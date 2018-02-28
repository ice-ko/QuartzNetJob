using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuartzNet2.Core.Entity {

    /// <summary>
    /// 枚举类型
    /// </summary>
    public class EnumType {
        public enum JobStatus {
            已启用 = 1,
            已停止 = 0
        }

        public enum JobStep {
            执行完成 = 1,
            执行任务计划中 = 2,

        }

        public enum JobRunStatus {
            执行中 = 1,
            待运行 = 0
        }
    }
}
