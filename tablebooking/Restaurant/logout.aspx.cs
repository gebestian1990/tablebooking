using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tablebooking.Restaurant
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Current.Response.Cache.SetNoServerCaching();
                HttpContext.Current.Response.Cache.SetNoStore();
                Session.Abandon();
                HttpCookie AddInfo = Request.Cookies["RestInfo"];
                AddInfo.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(AddInfo);
                Session.RemoveAll();
                Response.Redirect("index.aspx", false);
            }
            catch (Exception ex)
            {
                Response.Redirect("index.aspx");
            }
        }
    }
}