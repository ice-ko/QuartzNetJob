using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Five.QuartzNetJob.Web.Models
{
    /// <summary>
    /// 通用数据返回格式
    /// </summary>
    public class BaseResult
    {
       /// <summary>
       /// 状态码
       /// </summary>
        public MsgCode Code { get; set; }
        /// <summary>
        /// 消息
        /// </summary>
        public string Msg { get; set; }
        /// <summary>
        /// 数据
        /// </summary>
        public object Data { get; set; }
    }



}
