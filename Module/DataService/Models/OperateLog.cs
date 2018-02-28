using SqlSugar;
using System;
using System.Collections.Generic;
using System.Text;

namespace Five.QuartzNetJob.DataService.Models
{
    /// <summary>
    /// 操作日志表
    /// </summary>
    [SugarTable("qrtz_operatelog")]
    public class OperateLog
    {
        /// <summary>
        /// 日志编号
        /// </summary>
        [SugarColumn(IsNullable = false, IsPrimaryKey = true, IsIdentity = true)]
        public int Id { get; set; }
        /// <summary>
        /// 操作表名称
        /// </summary>
        [SugarColumn(Length = 255)]
        public string TableName { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        [SugarColumn(Length = 255)]
        public string Describe { get; set; }
        /// <summary>
        /// 日志类型(0：正常，1：异常)
        /// </summary>
        public int Type { get; set; }
        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime CreateTime { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime UpdateTime { get; set; }
    }
}
