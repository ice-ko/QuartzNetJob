using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Five.QuartzNetJobWeb.Models;
using QuartzNet3.Core;
using QuartzNet.Entity;
using Five.QuartzNetJob.DataService.DataHelper;
using Five.QuartzNetJob.DataService.Models;
using Five.QuartzNetJob.Web.Models;
using SqlSugar;
using Five.QuartzNetJob.Utils.Tool;
using System.Reflection;
using Five.QuartzNetJob.ExecuteJobTask.Service;

namespace Five.QuartzNetJob.Web.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            //生成表
            //var db = DataHelper.GetInstance();
            //db.CodeFirst.InitTables(typeof(OperateLog), typeof(OperateLog));
            return View();
        }
        public IActionResult About()
        {
            return View();
        }
        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="start">当前页</param>
        /// <param name="length">分页大小</param>
        /// <returns></returns>
        public ActionResult GetSchedule(int start, int length)
        {
            var db = DataHelper.GetInstance();
            var schedule = db.Queryable<Schedule>().Where(w => w.Valid == 1).OrderBy(o => o.JobId).Skip(start).Take(length).ToList();
            var count = db.Queryable<Schedule>().Count();
            Dictionary<string, object> dic = new Dictionary<string, object>
            {
                { "recordsTotal",count},
                { "recordsFiltered", count},
                { "list", schedule }
            };
            return Json(dic);
        }
        /// <summary>
        /// 查询详情
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult GetDetails(int id)
        {
            var db = DataHelper.GetInstance();
            var schedule = db.Queryable<Schedule>().InSingle(id);
            return Json(new QuartzNetJob.Web.Models.BaseResult { Code = MsgCode.Success, Data = schedule });
        }
        /// <summary>
        /// 添加任务
        /// </summary>
        /// <param name="schedule"></param>
        /// <returns></returns>
        public IActionResult AddJobTask(Schedule schedule)
        {
            try
            {
                var db = DataHelper.GetInstance();
                if (schedule.JobId > 0)
                {
                    db.Updateable(schedule).ExecuteCommand();
                    OperatelogService.AddLog(new OperateLog
                    {
                        TableName = "Schedule",
                        Describe = "修改任务编号" + schedule.JobId + "成功",
                        CreateTime = DateTime.Now,
                        UpdateTime = DateTime.Now
                    });
                }
                else
                {
                    db.Insertable(schedule).ExecuteCommand();
                    OperatelogService.AddLog(new OperateLog
                    {
                        TableName = "Schedule",
                        Describe = "添加任务" + schedule.JobName + "成功",
                        CreateTime = DateTime.Now,
                        UpdateTime = DateTime.Now
                    });
                }

            }
            catch (Exception ex)
            {
                return base.Json(new QuartzNetJob.Web.Models.BaseResult { Code = MsgCode.IsFail, Msg = ex.Message });
            }
            return base.Json(new QuartzNetJob.Web.Models.BaseResult { Code = MsgCode.Success, Msg = "ok" });
        }

        /// <summary>
        /// 执行任务
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public IActionResult ExecuteJob(int id)
        {
            var db = DataHelper.GetInstance();
            var schedule = db.Queryable<Schedule>().InSingle(id);

            var scheduleEntity = DataMapper.MapperToModel(new ScheduleEntity(), schedule);
            //给IJob设置参数
            scheduleEntity.Agrs = new Dictionary<string, object> { { "orderId", id } };
            ScheduleManage.Instance.AddScheduleList(scheduleEntity);
            // 运行任务调度
            BaseQuartzNetResult result;
            if (schedule.TriggerType == 0)
            {
                result = SchedulerCenter.Instance.RunScheduleJob<ScheduleManage, SubmitJobTask>(schedule.JobGroup, schedule.JobName).Result;
            }
            else
            {
                result = SchedulerCenter.Instance.RunScheduleJob<ScheduleManage>(schedule.JobGroup, schedule.JobName).Result;
            }
            Console.Out.WriteLineAsync("任务执行状态：" + result.Msg);
            if (result.Code == 1000)
            {
                var t10 = db.Updateable<Schedule>().UpdateColumns(it => new Schedule()
                {
                    JobStatus = 1,
                    UpdateTime = DateTime.Now
                })
                .Where(it => it.JobId == scheduleEntity.JobId).ExecuteCommand();
                OperatelogService.AddLog(new OperateLog
                {
                    TableName = "Schedule",
                    Describe = "执行任务" + schedule.JobName + "成功",
                    CreateTime = DateTime.Now,
                    UpdateTime = DateTime.Now
                });
            }
            return base.Json(new BaseResult { Code = result.Code == 1000 ? MsgCode.Success : MsgCode.IsFail, Msg = result.Msg });
        }
        /// <summary>
        /// 停止任务
        /// </summary>
        /// <param name="id">任务编号</param>
        /// <returns></returns>
        public IActionResult StopScheduleJob(int id)
        {
            var db = DataHelper.GetInstance();
            //根据任务编号获取任务详情
            var schedule = db.Queryable<Schedule>().InSingle(id);
            //停止指定任务
            var result = SchedulerCenter.Instance.StopScheduleJob<ScheduleManage>(schedule.JobGroup, schedule.JobName);
            if (result.Result.Code == 1000)
            {
                db.Updateable<Schedule>()
                  .UpdateColumns(it => new Schedule() { JobStatus = 0, UpdateTime = DateTime.Now })
                  .Where(it => it.JobId == id).ExecuteCommand();
                OperatelogService.AddLog(new OperateLog
                {
                    TableName = "Schedule",
                    Describe = "停止任务" + schedule.JobName + "成功",
                    CreateTime = DateTime.Now,
                    UpdateTime = DateTime.Now
                });
            }
            return base.Json(new BaseResult { Code = result.Result.Code == 1000 ? MsgCode.Success : MsgCode.IsFail, Msg = result.Result.Msg });
        }
        /// <summary>
        /// 恢复暂停任务
        /// </summary>
        /// <param name="id">任务编号</param>
        /// <returns></returns>
        public IActionResult ResumeJob(int id)
        {
            var db = DataHelper.GetInstance();
            //根据任务编号获取任务详情
            var schedule = db.Queryable<Schedule>().InSingle(id);
            //恢复运行指定暂停任务
            var result = SchedulerCenter.Instance.ResumeJob(schedule.JobGroup, schedule.JobName);
            if (result.Result.Code == 1000)
            {
                db.Updateable<Schedule>()
                  .UpdateColumns(it => new Schedule() { JobStatus = 1, UpdateTime = DateTime.Now })
                  .Where(it => it.JobId == id).ExecuteCommand();
                OperatelogService.AddLog(new OperateLog
                {
                    TableName = "Schedule",
                    Describe = "恢复暂停任务" + schedule.JobName + "成功",
                    CreateTime = DateTime.Now,
                    UpdateTime = DateTime.Now
                });
            }
            return base.Json(new BaseResult { Code = result.Result.Code == 1000 ? MsgCode.Success : MsgCode.IsFail, Msg = result.Result.Msg });
        }
        /// <summary>
        /// 删除任务
        /// </summary>
        /// <returns></returns>
        public IActionResult DeleteSchedule(int id)
        {
            var db = DataHelper.GetInstance();
            //根据任务编号获取任务详情
            var schedule = db.Queryable<Schedule>().InSingle(id);
            //停止指定任务
            var resultJob = SchedulerCenter.Instance.StopScheduleJob<ScheduleManage>(schedule.JobGroup, schedule.JobName, true);
            //更改数据状态
            var result = db.Updateable<Schedule>().UpdateColumns(it => new Schedule() { Valid = 0, UpdateTime = DateTime.Now })
                  .Where(it => it.JobId == id).ExecuteCommand();
            if (result <= 0)
            {
                return Json(new BaseResult { Code = MsgCode.IsFail });
            }
            OperatelogService.AddLog(new OperateLog
            {
                TableName = "Schedule",
                Describe = "编号为：" + id + "任务删除成功",
                CreateTime = DateTime.Now,
                UpdateTime = DateTime.Now
            });
            return Json(new BaseResult { Code = MsgCode.Success });
        }
    }
}
