using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DFWGraniteAdmin2014.UserControl
{
    public partial class UserLogBS : System.Web.UI.UserControl
    {
        public string myProperty { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
                LoggedInUserName.Text = "Hello, " + Context.User.Identity.Name + "! ";
            else
            {
                LoggedInUserName.Visible = false;
                LogoutLinkButton.Visible = false;
            }
        }
        protected void LogoutLinkButton_Click(object sender, EventArgs e)
        {
            System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }
    }
}