using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FestivalMVC.Startup))]
namespace FestivalMVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
