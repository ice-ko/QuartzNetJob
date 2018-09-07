using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using QuartzNet3.Core;

namespace Five.QuartzNetJobWeb
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>();
    }
}
