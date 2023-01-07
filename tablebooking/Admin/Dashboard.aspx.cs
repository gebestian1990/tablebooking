using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dashboard;
using System.Collections;
namespace nextdoormarket.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DashboardLinks dlinks = new DashboardLinks();
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        const int type = 1;
        string dash = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    binddash();
                }
                catch (Exception ex)
                {
                    Response.Redirect("logout.aspx");
                }
            }
        }
        public void binddash()
        {
            dlinks.aid = Convert.ToInt32(AddInfo["aid"]);
            dlinks.type = type;
            ArrayList alist = dlinks.GetDashboard();
            dash += "<div class='template-demo'>";
            for (int i = 0; i < alist.Count; i++)
            {
                string[] getheader = headers(i);
                if (Convert.ToInt32(AddInfo["aid"]) == 1)
                {
                    dash += "<a type='button' href='" + getheader[1] + ".aspx' class='" + getheader[2] + "'>" + getheader[0] + " <br/> (" + (int)alist[i] + ")</a>";
                }
                else
                {
                    if (Convert.ToInt32(alist[i]) > 0)
                    {
                        dash += "<a type='button' href='" + getheader[1] + ".aspx' class='" + getheader[2] + "'>" + getheader[0] + " <br/> (" + (int)alist[i] + ")</a>";
                    }
                }
            }
            dash += "</div>";
            lbldash.Text = dash;
        }
        public string[] headers(int index)
        {
            string[,] headers = new string[5, 3]
            {
                     { "Users","Users","btn btn-warning btn-rounded btn-fw"},
                     { "Roles","Roles","btn btn-info btn-rounded btn-fw"},
                     { "Restaurants","ViewRestaurant","btn btn-danger btn-rounded btn-fw"},
                     { "Food Categories","FoodCategory","btn btn-warning btn-rounded btn-fw"},
                     { "Food Types","FoodType","btn btn-success btn-rounded btn-fw"}
            };
            string[] dashs = new string[] { headers[index, 0], headers[index, 1], headers[index, 2] };
            return dashs;
        }
    }
}