using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Hosting.WindowsServices;
using Microsoft.AspNetCore.Server.Kestrel.Core;

namespace DockerRestAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args)
        {

            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .UseKestrel(o =>
                {
                    o.Listen(IPAddress.Any, 443,
                        listenOptions =>
                        {
                            listenOptions.UseHttps(new X509Certificate2(@"DockerRestAPI.pfx", "crypticpassword"));
                        });
                } )
             //   .UseUrls("https://*:443")
                .UseContentRoot(Directory.GetCurrentDirectory());
            // .UseKestrel(options =>
            // {
            //     options.Listen(IPAddress.Any, 443,
            //         listenOptions => { listenOptions.UseHttps("DockerRestAPI.pfx", "crypticpassword"); });
            //     //  options.ListenLocalhost();.UseHttps("../../localhost.pfx", Environment.GetEnvironmentVariable("LOCALHOST_CERTIFICATE_PWD"));
            //     // Set properties and call methods on options
            // }).UseContentRoot(Directory.GetCurrentDirectory())
            //;
        }
    }
}
