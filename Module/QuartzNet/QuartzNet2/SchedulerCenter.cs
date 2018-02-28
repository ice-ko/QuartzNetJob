using Quartz;
using Quartz.Impl;
using QuartzNet2.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuartzNet2.Core
{

    /// <summary>
    /// 任务调度中心
    /// </summary>
    public class SchedulerCenter
    {

        /// <summary>
        /// 任务调度对象
        /// </summary>
        public static readonly SchedulerCenter Instance;

        static SchedulerCenter()
        {
            Instance = new SchedulerCenter();
        }

        private IScheduler _scheduler;

        /// <summary>
        /// 返回任务计划（调度机）
        /// </summary>
        /// <returns></returns>
        private IScheduler Scheduler
        {
            get
            {
                if (_scheduler != null)
                    return _scheduler;
                else
                {
                    ISchedulerFactory schedf = new StdSchedulerFactory();
                    _scheduler = schedf.GetScheduler();
                    return _scheduler;
                }
            }
        }

        /// <summary>
        /// 添加一个工作调度
        /// </summary>
        /// <param name="m"></param>
        /// <returns></returns>
        private bool AddScheduleJob<T>(ScheduleEntity m) where T : IJob
        {
            try
            {
                if (m != null)
                {
                    if (m.StarRunTime == null)
                    {
                        m.StarRunTime = DateTime.Now;
                    }

                    var starRunTime = DateBuilder.NextGivenSecondDate(m.StarRunTime, 1);

                    if (m.EndRunTime == null)
                    {
                        m.EndRunTime = DateTime.Now;
                    }
                    var endRunTime = DateBuilder.NextGivenSecondDate(m.EndRunTime, 1);
                    IJobDetail job = job = JobBuilder.Create<T>()
                        .WithIdentity(m.JobName, m.JobGroup).Build();
                    ITrigger trigger = null;
                    if (!string.IsNullOrEmpty(m.CronStr))
                    {
                        trigger = (ICronTrigger)TriggerBuilder.Create()
                            .StartAt(starRunTime)
                            .EndAt(endRunTime)
                            .WithIdentity(m.JobName, m.JobGroup)
                            .WithCronSchedule(m.CronStr)
                            .Build();
                    }
                    else
                    {
                        trigger = (ISimpleTrigger)TriggerBuilder.Create().StartAt(starRunTime).WithSimpleSchedule(x => x.WithIntervalInSeconds(1).WithRepeatCount(0)).Build();
                    }
                    Scheduler.ScheduleJob(job, trigger);
                    Scheduler.Start();
                    StopScheduleJob<ScheduleManage>(m.JobGroup, m.JobName);
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        /// <summary>
        /// 暂停指定的计划
        /// </summary>
        /// <param name="jobGroup"></param>
        /// <param name="jobName"></param>
        /// <returns></returns>
        public StatusResult StopScheduleJob<T>(string jobGroup, string jobName) where T : ScheduleManage, new()
        {
            try
            {
                Scheduler.PauseJob(new JobKey(jobName, jobGroup));
                new T().GetScheduleModel(new ScheduleEntity
                {
                    JobName = jobName,
                    JobGroup = jobGroup,
                    Status = EnumType.JobStatus.已停止
                });
                return new StatusResult() { Status = 0, Msg = "停止任务计划成功！" };
            }
            catch (Exception ex)
            {
                return new StatusResult() { Status = -1, Msg = "停止任务计划失败" };
            }
        }

        /// <summary>
        /// 运行指定的计划
        /// </summary>
        /// <param name="jobGroup"></param>
        /// <param name="jobName"></param>
        /// <returns></returns>
        public StatusResult RunScheduleJob<T, V>(string jobGroup, string jobName)
            where T : ScheduleManage, new()
            where V : IJob
        {
            try
            {
                var instance = new T();
                var sm = instance.GetScheduleModel(new ScheduleEntity()
                {
                    JobName = jobName,
                    JobGroup = jobGroup
                });
                var result = AddScheduleJob<V>(sm);
                if (result)
                {
                    sm.Status = EnumType.JobStatus.已启用;
                    instance.UpdateScheduleStatus(sm);
                    Scheduler.ResumeJob(new JobKey(jobName, jobGroup));
                    return new StatusResult { Status = 0, Msg = "启动成功" };
                }
                else
                {
                    return new StatusResult { Status = -1, Msg = "启动失败" };
                }
            }
            catch (Exception ex)
            {
                return new StatusResult { Status = -1, Msg = "启动失败" };
            }
        }
    }
}
