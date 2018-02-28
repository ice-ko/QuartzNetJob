using Five.QuartzNetJob.DataService.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Five.QuartzNetJob.DataService.DataHelper
{
    public class OperatelogService
    {
        public static void AddLog(OperateLog log)
        {
            try
            {
                var db = DataHelper.GetInstance();
                db.Insertable(log).ExecuteCommand();
            }
            catch (Exception ex)
            {
                Console.Out.WriteLineAsync(string.Format("插入日志出错：{0}", ex));
            }

        }
    }
}
