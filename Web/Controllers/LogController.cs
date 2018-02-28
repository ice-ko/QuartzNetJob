using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Five.QuartzNetJob.DataService.DataHelper;
using Five.QuartzNetJob.DataService.Models;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;

namespace Five.QuartzNetJob.Web.Controllers
{
    public class LogController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult GetLog(int start, int length)
        {
            var db = DataHelper.GetInstance();
            var schedule = db.Queryable<OperateLog>().OrderBy(o => o.CreateTime,OrderByType.Desc).Skip(start).Take(length).ToList();
            var count = db.Queryable<OperateLog>().Count();
            Dictionary<string, object> dic = new Dictionary<string, object>
            {
                { "recordsTotal",count},
                { "recordsFiltered", count},
                { "list", schedule }
            };
            return Json(dic);
        }
    }
}