using Five.QuartzNetJob.DataService.DataHelper;
using Five.QuartzNetJob.DataService.Models;
using Five.QuartzNetJob.Utils.Tool;
using QuartzNet.Entity;
using QuartzNet3.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Five.QuartzNetJob.Web.Utils
{
    public class StartTask
    {
        /// <summary>
        /// 开启任务
        /// </summary>
        public void Start()
        {
            var db = DataHelper.GetInstance();
            var schedule = db.Queryable<Schedule>().Where(w => w.JobStatus == 1).ToList();
            foreach (var item in schedule)
            {
                if (!string.IsNullOrEmpty(item.Url))
                {
                    item.AssemblyName = "Five.QuartzNetJob.ExecuteJobTask.Service";
                    item.ClassName = "HttpJobTask";
                }
                if (!string.IsNullOrEmpty(item.Url) || !string.IsNullOrEmpty(item.AssemblyName))
                {
                    var scheduleEntity = DataMapper.MapperToModel(new ScheduleEntity(), item);
                    ScheduleManage.Instance.AddScheduleList(scheduleEntity);
                    var result = SchedulerCenter.Instance.RunScheduleJob<ScheduleManage>(item.JobGroup, item.JobName).Result;
                }
            }
        }
    }
}
