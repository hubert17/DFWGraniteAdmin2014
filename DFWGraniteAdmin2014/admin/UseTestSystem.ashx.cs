using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace DFWGraniteAdmin2014.admin
{
    /// <summary>
    /// Summary description for UseTestSystem
    /// </summary>
    public class UseTestSystem : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string id = context.Request.Params["id"];

            var filePath = context.Server.MapPath("/") + "Web.config";
            var map = new ExeConfigurationFileMap { ExeConfigFilename = filePath };
            var configFile = ConfigurationManager.OpenMappedExeConfiguration(map, ConfigurationUserLevel.None);
            var MirrorWeb = configFile.AppSettings.Settings["MirrorWeb"];

            context.Response.ContentType = "text/plain";

            if (String.IsNullOrEmpty(id))
                context.Response.Write(MirrorWeb.Value); //mirnot, mirsys, mirsysdb               
            else
            {
                MirrorWeb.Value = id;
                configFile.Save();
                context.Response.Write(MirrorWeb.Value);
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}