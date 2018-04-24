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

        /// <summary>返回任务计划（调度机）</summary>
        /// <returns></returns>
        private IScheduler Scheduler
        {
            get
            {
                if (this._scheduler != null)
                    return this._scheduler;
                this._scheduler = new StdSchedulerFactory().GetScheduler();
                return this._scheduler;
            }
        }

        /// <summary>添加一个工作调度</summary>
        /// <param name="m"></param>
        /// <returns></returns>
        private bool AddScheduleJob<T>(ScheduleEntity m) where T : IJob
        {
            try
            {
                if (m == null)
                    return false;
                //开始时间
                DateTimeOffset startTimeUtc = DateBuilder.NextGivenSecondDate(new DateTimeOffset?((DateTimeOffset)m.StarRunTime), 1);
                //结束时间
                DateTimeOffset dateTimeOffset = DateBuilder.NextGivenSecondDate(new DateTimeOffset?((DateTimeOffset)m.EndRunTime), 1);
                //创建任务
                var job = JobBuilder.Create<T>().WithIdentity(m.JobName, m.JobGroup).Build();
                ITrigger trigger = null;
                //判断触发器类型
                if (string.IsNullOrEmpty(m.CronStr))
                {
                    trigger = TriggerBuilder.Create().StartAt(startTimeUtc).WithSimpleSchedule(x => x.WithIntervalInSeconds(1).WithRepeatCount(0)).Build();
                }
                else
                {
                    trigger = TriggerBuilder.Create().StartAt(startTimeUtc).EndAt(new DateTimeOffset?(dateTimeOffset))
                        .WithIdentity(m.JobName, m.JobGroup)
                        .WithCronSchedule(m.CronStr).Build();
                }
                this.Scheduler.ScheduleJob(job, trigger);
                this.Scheduler.Start();
                this.StopScheduleJob<ScheduleManage>(m.JobGroup, m.JobName, false);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        /// <summary>暂停指定的计划</summary>
        /// <param name="jobGroup"></param>
        /// <param name="jobName"></param>
        /// <param name="isDelete">停止并删除任务</param>
        /// <returns></returns>
        public StatusResult StopScheduleJob<T>(string jobGroup, string jobName, bool isDelete = false) where T : ScheduleManage, new()
        {
            try
            {
                this.Scheduler.PauseJob(new JobKey(jobName, jobGroup));
                if (isDelete)
                    Activator.CreateInstance<T>().RemoveScheduleModel(jobGroup, jobName);
                return new StatusResult()
                {
                    Status = 0,
                    Msg = "停止任务计划成功！"
                };
            }
            catch (Exception ex)
            {
                return new StatusResult()
                {
                    Status = -1,
                    Msg = "停止任务计划失败"
                };
            }
        }

        /// <summary>运行指定的计划</summary>
        /// <param name="jobGroup"></param>
        /// <param name="jobName"></param>
        /// <returns></returns>
        public StatusResult RunScheduleJob<T, V>(string jobGroup, string jobName) where T : ScheduleManage, new() where V : IJob
        {
            try
            {
                T instance = Activator.CreateInstance<T>();
                ScheduleEntity scheduleModel = instance.GetScheduleModel(jobGroup, jobName);
                if (this.AddScheduleJob<V>(scheduleModel))
                {
                    scheduleModel.Status = EnumType.JobStatus.已启用;
                    instance.UpdateScheduleStatus(scheduleModel);
                    this.Scheduler.ResumeJob(new JobKey(jobName, jobGroup));
                    return new StatusResult()
                    {
                        Status = 0,
                        Msg = "启动成功"
                    };
                }
                return new StatusResult()
                {
                    Status = -1,
                    Msg = "启动失败"
                };
            }
            catch (Exception ex)
            {
                return new StatusResult()
                {
                    Status = -1,
                    Msg = "启动失败"
                };
            }
        }
    }
}
