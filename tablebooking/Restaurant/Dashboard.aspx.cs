using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dashboard;
using ManageRestaurant;
using System.Web.Services;
namespace tablebooking.Restaurant
{
    public partial class Dashboard : System.Web.UI.Page
    {
        HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        DashboardLinks dlinks = new DashboardLinks();
        ManageRestaurant.Restaurant mrest = new ManageRestaurant.Restaurant();
        const int type = 1;
        string dash = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblexpdate.Text = RestInfo["expdate"].ToString();
                try
                {
                    binddash();
                    fetchlinks();
                }
                catch (Exception ex)
                {
                    Response.Redirect("logout.aspx");
                }
            }
        }
        public void binddash()
        {
            dlinks.aid = Convert.ToInt32(RestInfo["restid"]);
            dlinks.type = type;
            ArrayList alist = dlinks.KitchenDashboard();
            dash += "<div class='template-demo'>";
            for (int i = 0; i < alist.Count; i++)
            {
                string[] getheader = headers(i);
                if (Convert.ToInt32(RestInfo["restid"]) == 1)
                {
                    dash += "<a type='button' href='" + getheader[1] + ".aspx" + getheader[3] + "' class='" + getheader[2] + "'>" + getheader[0] + " <br/>(<span id='newval" + i + "'>" + (int)alist[i] + "</span>)</a>";
                }
                else
                {
                    if (Convert.ToInt32(alist[i]) > 0)
                    {
                        dash += "<a type='button' href='" + getheader[1] + ".aspx" + getheader[3] + "' class='" + getheader[2] + "'>" + getheader[0] + " <br/>(<span id='newval" + i + "'>" + (int)alist[i] + "</span>)</a>";
                    }
                }
            }
            dash += "</div>";
            lbldash.Text = dash;
        }
        public string[] headers(int index)
        {
            string[,] headers = new string[6, 4]
            {
                     { "Tables","tablemaster","btn btn-warning btn-rounded btn-fw",""},
                     { "Table Timings","Slottimings","btn btn-info btn-rounded btn-fw",""},
                     { "Devivery & Takeaway Timings","deliveryandtakewayslots","btn btn-warning btn-rounded btn-fw",""},
                     { "Table Bookings","Bookings","btn btn-dark btn-rounded btn-fw","?stat=1"},
                     { "Delivery","DeliveryReport","btn btn-warning btn-rounded btn-fw","?stat=1"},
                     { "Takeaway","TakeawayReport","btn btn-info btn-rounded btn-fw","?stat=1"},
            };
            string[] dashs = new string[] { headers[index, 0], headers[index, 1], headers[index, 2], headers[index, 3] };
            return dashs;
        }
        [WebMethod]
        public static string fetchNewSlotCount(int type)
        {
            string data = "";
            if (type == 1)
            {
                HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
                DashboardLinks dlinks = new DashboardLinks();
                dlinks.aid = Convert.ToInt32(RestInfo["restid"]);
                dlinks.type = type;
                ArrayList alist = dlinks.KitchenDashboard();
                data = alist[3].ToString() + "#" + alist[4].ToString() + "#" + alist[5].ToString();
            }
            else
            {
                data = "Invalid!!";
            }
            return data;
        }

        public void fetchlinks()
        {
            string Encrypt = mrest.EnryptString(RestInfo["restid"].ToString());
            txtlink.Text = "<div id='container' style='padding-bottom:56.25%; position:relative; display:block; width: 100%;height:100%'>";
            txtlink.Text += "<iframe id='bookingframe' width='100%' height='100%' src='http://tablebooking.nextdoorkitchen.in/index.aspx?id=" + Encrypt + "'";
            txtlink.Text += "frameborder='0' allowfullscreen='' style='position:absolute; top:0; left: 0'>";
            txtlink.Text += "</iframe></div>";

            lbllink.Text = "http://tablebooking.nextdoorkitchen.in/index.aspx?id=" + Encrypt + "";
        }


    }
}