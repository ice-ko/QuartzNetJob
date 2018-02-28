using Five.QuartzNetJob.Utils.Tool;
using SqlSugar;
using System.Collections.Generic;
using System.Linq;

namespace Five.QuartzNetJob.DataService.DataHelper
{
    /// <summary>
    /// 数据库操作类
    /// </summary>
    public class DataHelper
    {
        /// <summary>
        /// 初始化数据库连接
        /// </summary>
        /// <returns></returns>
        public static SqlSugarClient GetInstance()
        {
            SqlSugarClient db = new SqlSugarClient(
                new ConnectionConfig()
                {
                    ConnectionString = AppSettingHelper.MysqlConnection,
                    DbType = DbType.MySql,
                    IsAutoCloseConnection = true,
                    InitKeyType = InitKeyType.Attribute
                });
            //db.Ado.IsEnableLogEvent = true;
            //db.Ado.LogEventStarting = (sql, pars) =>
            //{

            //};
            db.Aop.OnLogExecuted = (sql, pars) => //SQL执行完事件
            {
                Log4netHelper.Info("SQL执行完事件：" + sql + "\r\n" +
                    db.Utilities.SerializeObject(pars.ToDictionary(s => s.ParameterName, s => s.Value))
                    );
            };
            db.Aop.OnLogExecuting = (sql, pars) => //SQL执行前事件
            {

            };
            db.Aop.OnError = (exp) =>//执行SQL 错误事件
            {

            };
            db.Aop.OnExecutingChangeSql = (sql, pars) => //SQL执行前 可以修改SQL
            {
                return new KeyValuePair<string, SugarParameter[]>(sql, pars);
            };
            return db;
        }
    }
}
