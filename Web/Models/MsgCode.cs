using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Five.QuartzNetJob.Web.Models
{
    public enum MsgCode
    {
        /// <summary>
        /// 请求超时
        /// </summary>
        ReuestTimeout = 996,
        /// <summary>
        /// 应用程序异常
        /// </summary>
        ServiceException = 997,
        /// <summary>
        /// 非法请求
        /// </summary>
        BadRequest = 998,
        /// <summary>
        /// 未知错误
        /// </summary>
        Unknow = 999,
        /// <summary>
        /// 请求成功
        /// </summary>
        Success = 1000,
        /// <summary>
        /// 验证码错误
        /// </summary>
        IsCode = 5004,
        /// <summary>
        /// 失败
        /// </summary>
        IsFail = 5005,
        /// <summary>
        /// 是否存在
        /// </summary>
        IsExist = 5006
    }
}
