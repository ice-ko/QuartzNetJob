using System.Configuration;

namespace Five.QuartzNetJob.Utils.Tool
{
    /// <summary>
    ///读取配置信息类
    /// </summary>
    public class AppSettingHelper
    {
        /// <summary>
        /// 数据库连接字符串
        /// </summary>
        static public string MysqlConnection => ConfigurationManager.AppSettings["DefaultConnection"];
        /// <summary>
        /// ip地址
        /// </summary>
        static public string IpAddress => ConfigurationManager.AppSettings["ip"];
    }
}
