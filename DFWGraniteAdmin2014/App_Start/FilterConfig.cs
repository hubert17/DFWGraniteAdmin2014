using System.Web;
using System.Web.Mvc;

namespace DFWGraniteAdmin2014
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
