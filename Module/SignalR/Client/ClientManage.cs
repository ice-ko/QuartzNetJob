using Five.QuartzNetJob.DataService.DataHelper;
using Five.QuartzNetJob.DataService.Models;
using Microsoft.AspNetCore.SignalR.Client;
using System;
using System.Collections.Generic;
using System.Text;

namespace SignalR.Client
{
    public class ClientManage
    {
        public void ClientSend(int id)
        {
            HubConnection connection = new HubConnectionBuilder()
                            .WithUrl("http://localhost:5000/chatHub")
                            .Build();
            //连接hub
            connection.StartAsync();
            Console.WriteLine("已连接");

            //定义一个客户端方法ReceiveMessage
            //connection.On<string, string>("ReceiveMessage", (UriParser, message) =>
            //{
            //    Console.WriteLine($"接收消息：{message}");
            //});
          
            var db = DataHelper.GetInstance();
            //根据任务编号获取任务详情
            var schedule = db.Queryable<Schedule>().InSingle(id);
            var result = db.Updateable<Schedule>().UpdateColumns(it => new Schedule() { JobStatus = 0, UpdateTime = DateTime.Now })
                  .Where(it => it.JobId == id).ExecuteCommand();
            //发送消息
            connection.InvokeAsync("SendMessage", "", "ok");
        }
    }
}
