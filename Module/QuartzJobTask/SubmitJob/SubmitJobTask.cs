using Quartz;
using QuartzNet.Entity;
using QuartzNet3.Core;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Five.QuartzNetJob.ExecuteJobTask.Service
{
    public class SubmitJobTask:IJob
    {
        public async Task Execute(IJobExecutionContext context)
        {
            var manage = new ScheduleManage();
            var schedule = new ScheduleEntity
            {
                JobGroup = context.JobDetail.Key.Group,
                JobName = context.JobDetail.Key.Name,
                RunStatus = EnumType.JobRunStatus.执行中
            };
            manage.UpdateScheduleRunStatus(schedule);
            var model = manage.GetScheduleModel(context.JobDetail.Key.Group, context.JobDetail.Key.Name);
            await Console.Out.WriteLineAsync(string.Format("试一试:{0}{1}{2}", schedule.JobGroup,schedule.JobName,schedule.RunStatus));
        }
    }
}
