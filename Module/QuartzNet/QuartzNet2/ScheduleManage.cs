using QuartzNet2.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuartzNet2.Core
{
    /// <summary>任务管理</summary>
    public class ScheduleManage
    {
        /// <summary>任务计划列表</summary>
        public static List<ScheduleEntity> ScheduleList = new List<ScheduleEntity>();
        public static IList<ScheduleDetailsEntity> ScheduleDetailList = (IList<ScheduleDetailsEntity>)new List<ScheduleDetailsEntity>();

        /// <summary>获取任务实例</summary>
        /// <param name="jobGroup">任务分组</param>
        /// <param name="jobName">任务名称</param>
        /// <returns></returns>
        public virtual ScheduleEntity GetScheduleModel(string jobGroup, string jobName)
        {
            return ScheduleManage.ScheduleList.Where<ScheduleEntity>((Func<ScheduleEntity, bool>)(a =>
            {
                if (a.JobName == jobName)
                    return a.JobGroup == jobGroup;
                return false;
            })).FirstOrDefault<ScheduleEntity>();
        }

        public virtual ScheduleEntity RemoveScheduleModel(string jobGroup, string jobName)
        {
            ScheduleEntity scheduleModel = this.GetScheduleModel(jobGroup, jobName);
            if (scheduleModel != null)
                ScheduleManage.ScheduleList.Remove(scheduleModel);
            return scheduleModel;
        }

        public virtual void UpdateScheduleRunStatus(ScheduleEntity entity)
        {
            ScheduleManage.ScheduleList.Where<ScheduleEntity>((Func<ScheduleEntity, bool>)(a =>
            {
                if (a.JobName == entity.JobName)
                    return a.JobGroup == entity.JobGroup;
                return false;
            })).FirstOrDefault<ScheduleEntity>().RunStatus = entity.RunStatus;
        }

        public virtual void AddScheduleDetails(ScheduleDetailsEntity detail)
        {
            ScheduleManage.ScheduleDetailList.Add(detail);
        }

        public virtual void UpdateScheduleNextTime(ScheduleEntity entity)
        {
            ScheduleManage.ScheduleList.Where<ScheduleEntity>((Func<ScheduleEntity, bool>)(a =>
            {
                if (a.JobName == entity.JobName)
                    return a.JobGroup == entity.JobGroup;
                return false;
            })).FirstOrDefault<ScheduleEntity>().NextTime = entity.NextTime;
        }

        public virtual void UpdateScheduleStatus(ScheduleEntity entity)
        {
            ScheduleManage.ScheduleList.Where<ScheduleEntity>((Func<ScheduleEntity, bool>)(a =>
            {
                if (a.JobName == entity.JobName)
                    return a.JobGroup == entity.JobGroup;
                return false;
            })).FirstOrDefault<ScheduleEntity>().Status = entity.Status;
        }
    }
}