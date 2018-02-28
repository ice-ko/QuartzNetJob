using Five.QuartzNetJob.DataService.DataHelper;
using Five.QuartzNetJob.DataService.Models;
using Five.QuartzNetJob.Utils.Tool;
using Quartz;
using QuartzNet.Entity;
using QuartzNet3.Core;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Five.QuartzNetJob.ExecuteJobTask.Service
{
    public class HttpJobTask : IJob
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

            var item = new HttpItem
            {
                URL = model.Url,
                Method = "post"
            };
            var result = new HttpHelper().GetHtml(item).Html;

            await Console.Out.WriteLineAsync(string.Format("请求返回信息：", result));
            await Task.CompletedTask;
        }
    }
}
