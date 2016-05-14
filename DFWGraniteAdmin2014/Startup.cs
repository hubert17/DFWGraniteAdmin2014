using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DFWGraniteAdmin2014.Startup))]
namespace DFWGraniteAdmin2014
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
