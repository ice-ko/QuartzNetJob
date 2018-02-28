using log4net;
using log4net.Repository;
using System.Diagnostics;
using System.Reflection;

namespace Five.QuartzNetJob.Utils.Tool
{
    /// <summary>
    /// 日志等级
    /// </summary>
    public enum LogLevel
    {
        Error,
        Debug,
        Warning,
        Info
    }
    /// <summary>
    /// 单例模式初始化
    /// </summary>
    public class Singleton
    {
        private ILog Log;
        private static Singleton instance;
        private Singleton() { }
        public static Singleton getInstance()
        {
            if (instance == null)
            {
                instance = new Singleton();
            }
            return instance;
        }
        /// <summary>
        /// 获取日志初始化器
        /// </summary>
        /// <param name="type">类名 方法名</param>
        /// <returns></returns>
        public ILog Init(string type)
        {
            Log = LogManager.GetLogger(Log4netHelper.Repository.Name, type);
            return Log;
        }
    }
    /// <summary>
    /// 日志操作类
    /// </summary>
    public class Log4netHelper
    {
        /// <summary>
        /// log4net 仓储
        /// </summary>
        public static ILoggerRepository Repository { get; set; }
        /// <summary>
        /// 输出Erro日志
        /// </summary>
        /// <param name="message">日志内容</param>
        public static void Error(string message)
        {
            StackTrace trace = new StackTrace();
            //获取是哪个类来调用的  
            var className = trace.GetFrame(1).GetMethod().DeclaringType;
            //获取方法名称
            MethodBase method = trace.GetFrame(1).GetMethod();
            var type = "类名：" + className.Namespace + "\r\n\r\t\r\r方法名：" + method.Name;
            WriteLog(LogLevel.Error, message, type);
        }
        /// <summary>
        /// 输出Warning日志
        /// </summary>
        /// <param name="message">日志内容</param>
        public static void Warning(string message)
        {
            StackTrace trace = new StackTrace();
            //获取是哪个类来调用的  
            var className = trace.GetFrame(1).GetMethod().DeclaringType;
            //获取方法名称
            MethodBase method = trace.GetFrame(1).GetMethod();
            var type = "类名：" + className.Namespace + "\r\n\r\t\r\r方法名：" + method.Name;
            //记录日志
            WriteLog(LogLevel.Warning, message, type);
        }
        /// <summary>
        /// 输出Info日志
        /// </summary>
        /// <param name="message">日志内容</param>
        public static void Info(string message)
        {
            StackTrace trace = new StackTrace();
            //获取是哪个类来调用的  
            var className = trace.GetFrame(1).GetMethod().DeclaringType;
            //获取方法名称
            MethodBase method = trace.GetFrame(1).GetMethod();
            var type = "类名：" + className.Namespace + "\r\n\r\t\r\r方法名：" + method.Name;
            //记录日志
            WriteLog(LogLevel.Info, message, type);
        }
        /// <summary>
        /// 输出Debug日志
        /// </summary>
        /// <param name="message">日志内容</param>
        public static void Debug(string message)
        {
            StackTrace trace = new StackTrace();
            //获取是哪个类来调用的  
            var className = trace.GetFrame(1).GetMethod().DeclaringType;
            //获取方法名称
            MethodBase method = trace.GetFrame(1).GetMethod();
            var type = "类名：" + className.Namespace + "\r\n\r\t\r\r方法名：" + method.Name;
            //记录日志
            WriteLog(LogLevel.Debug, message, type);
        }
        /// <summary>
        /// 写日志
        /// </summary>
        /// <param name="logLevel">日志等级</param>
        /// <param name="message">日志信息</param>
        /// <param name="type">类名 方法名</param>
        private static void WriteLog(LogLevel logLevel, string message, string type)
        {
            ILog Log = Singleton.getInstance().Init(type);
            switch (logLevel)
            {
                case LogLevel.Debug:
                    Log.Debug(message);
                    break;
                case LogLevel.Error:
                    Log.Error(message);
                    break;
                case LogLevel.Info:
                    Log.Info(message);
                    break;
                case LogLevel.Warning:
                    Log.Warn(message);
                    break;
            }

        }
    }
}
