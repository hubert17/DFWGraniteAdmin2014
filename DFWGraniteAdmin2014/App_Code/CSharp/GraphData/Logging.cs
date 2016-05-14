using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using log4net;
using log4net.Config;

namespace BusinessManagementPortal
{
    //[assembly: XmlConfigurator(Watch = true)]
    public class Logging
    {
        internal static readonly ILog log = LogManager.GetLogger
           (System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        /// <summary>
        /// Log the Exceptions
        /// </summary>
        /// <param name="ex">Exception</param>
        public static void LogError(Exception ex)
        {
            log4net.Config.XmlConfigurator.Configure();
            try
            {
                log.Info("<br/><hr/>Log Entry<hr/> ");
                log.Error(string.Format("<br/><b>Error Message : </b>{0}", ex.Message));
                log.Error(string.Format("<br/><b>Error StackTrace : </b>{0}", ex.StackTrace));

                //Log inner exceptions.
                while (ex.InnerException != null)
                {
                    ex = ex.InnerException;
                    log.Error("<hr/><b>Inner Exception : </b>");
                    log.Error(string.Format("<br/>Error Message : {0}", ex.Message));
                    log.Error(string.Format("<br/>Error StackTrace : {0}", ex.StackTrace));
                    log.Error("<hr/>");
                }

                log.Info("<br/><hr/>");

            }
            catch (Exception logex)
            {
                log.Error(logex);
            }
        }
    }
}