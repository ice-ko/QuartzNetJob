using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuartzNet2.Core.Entity {

    /// <summary>
    /// 任务调度详情
    /// </summary>
    public class ScheduleDetailsEntity {

        /// <summary>
        /// 任务分组
        /// </summary>
        public string JobGroup { get; set; }

        /// <summary>
        /// 任务名称
        /// </summary>
        public string JobName { get; set; }

        /// <summary>
        /// 方法描述
        /// </summary>
        public string ActionDescribe { get; set; }

        /// <summary>
        /// 任务执行状态
        /// </summary>
        public EnumType.JobStep ActionStep { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 是否成功执行
        /// </summary>
        public int IsSuccess { get; set; }
    }
}
