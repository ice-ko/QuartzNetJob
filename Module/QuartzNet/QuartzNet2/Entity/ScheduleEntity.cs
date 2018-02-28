using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuartzNet2.Core.Entity {

    /// <summary>
    /// 任务调度实体
    /// </summary>
    public class ScheduleEntity {
        /// <summary>
        /// 任务分组
        /// </summary>
        public string JobGroup { get; set; }

        /// <summary>
        /// 任务名称
        /// </summary>
        public string JobName { get; set; }

        /// <summary>
        /// 执行表达式
        /// </summary>
        public string CronStr { get; set; }

        /// <summary>
        /// 任务状态
        /// </summary>
        public EnumType.JobStatus Status { get; set; }

        /// <summary>
        /// 任务运行状态
        /// </summary>
        public EnumType.JobRunStatus RunStatus { get; set; }

        /// <summary>
        /// 下次执行时间
        /// </summary>
        public DateTime NextTime { get; set; }

        /// <summary>
        /// 运行时间
        /// </summary>
        public DateTime StarRunTime { get; set; }

        /// <summary>
        /// 停止时间
        /// </summary>
        public DateTime EndRunTime { get; set; }
    }
}
