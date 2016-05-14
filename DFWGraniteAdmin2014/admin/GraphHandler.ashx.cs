using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using BusinessManagementPortal.Data;

namespace DFWGraniteAdmin2014.admin
{
    /// <summary>
    /// Summary description for GraphHandler
    /// </summary>
    public class GraphHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            System.Collections.Specialized.NameValueCollection forms = context.Request.Form;

            string strOperation = forms.Get("oper");
            string gridName = context.Request.Params["gridName"];
            string chartName = context.Request["GraphName"];
            string dateidFrom = context.Request["dateidFrom"];
            string dateidTo = context.Request["dateidTo"];

            DataAccessLayer Dal = new DataAccessLayer();

            # region Graph

            if (!string.IsNullOrEmpty(chartName))
            {
                GraphDataList graphList = new GraphDataList();
                graphList = Dal.GetGraphData(chartName, dateidFrom, dateidTo);

                //oper = null which means its first load.
                var jsonSerializer = new JavaScriptSerializer();
                string data = jsonSerializer.Serialize(graphList.ListOfGraphData);
                context.Response.Write(data);
            }

            #endregion
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