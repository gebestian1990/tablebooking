using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tablebooking.Restaurant
{
    public partial class Notifications : System.Web.UI.Page
    {
        ManageRestaurant.Restaurant rest = new ManageRestaurant.Restaurant();
        HttpCookie KUserInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bindNotifications();
            }
        }
        public void bindNotifications()
        {
            dt = new DataTable();
            dt = rest.Notifications();
            chknotifications.DataTextField = "ntype";
            chknotifications.DataValueField = "notid";
            chknotifications.DataSource = dt;
            chknotifications.DataBind();

            foreach (ListItem ls in chknotifications.Items)
            {
                rest.restid = Convert.ToInt32(KUserInfo["restid"]);
                rest.aid = Convert.ToInt32(ls.Value);
                int status = rest.kitchenNotifications();
                if (status == 1)
                {
                    ls.Selected = true;
                }
                else
                {
                    ls.Selected = false;
                }
            }
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            foreach (ListItem ls in chknotifications.Items)
            {
                rest.restid = Convert.ToInt32(KUserInfo["restid"]);
                rest.aid = Convert.ToInt32(ls.Value);
                if (ls.Selected == true)
                {
                    rest.isactive = 1;
                }
                else
                {
                    rest.isactive = 0;
                }
                rest.type = 1;
                bool chk = rest.updateKitchenNotifications();
                if (chk)
                {
                    lblmsg.Text = "<span style='color:green'>Status Updated</span>";
                }
                else
                {
                    lblmsg.Text = "<span style='color:red'>Something Went Wrong!!</span>";
                }
            }
            bindNotifications();
        }
    }
}