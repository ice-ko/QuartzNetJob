using QuartzNet2.Core.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuartzNet2.Core
{

    /// <summary>
    /// 任务管理
    /// </summary>
    public class ScheduleManage
    {
        /// <summary>
        /// 任务计划列表
        /// </summary>
        public static List<ScheduleEntity> ScheduleList = new List<ScheduleEntity>();

        public static IList<ScheduleDetailsEntity> ScheduleDetailList = new List<ScheduleDetailsEntity>();

        public virtual ScheduleEntity GetScheduleModel(ScheduleEntity entity)
        {
            return ScheduleList.Where(a => a.JobName == entity.JobName && a.JobGroup == entity.JobGroup).FirstOrDefault();
        }

        public virtual void UpdateScheduleRunStatus(ScheduleEntity entity)
        {
            var schedule = ScheduleList.Where(a => a.JobName == entity.JobName && a.JobGroup == entity.JobGroup).FirstOrDefault();
            schedule.RunStatus = entity.RunStatus;
        }

        public virtual void AddScheduleDetails(ScheduleDetailsEntity detail)
        {
            ScheduleDetailList.Add(detail);
        }

        public virtual void UpdateScheduleNextTime(ScheduleEntity entity)
        {
            var schedule = ScheduleList.Where(a => a.JobName == entity.JobName && a.JobGroup == entity.JobGroup).FirstOrDefault();
            schedule.NextTime = entity.NextTime;
        }

        public virtual void UpdateScheduleStatus(ScheduleEntity entity)
        {
            var schedule = ScheduleList.Where(a => a.JobName == entity.JobName && a.JobGroup == entity.JobGroup).FirstOrDefault();
            schedule.Status = entity.Status;
        }
    }
}
