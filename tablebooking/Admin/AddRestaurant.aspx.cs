using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ManageRestaurant;
namespace tablebooking.Admin
{
    public partial class AddRestaurant : System.Web.UI.Page
    {
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        ManageRestaurant.Restaurant manageRest = new ManageRestaurant.Restaurant();
        const int status = 1, type = 1;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
                manageRest.restid = 0;
                manageRest.aid = Convert.ToInt32(AddInfo["aid"]);
                manageRest.restname = txtrname.Text;
                manageRest.tagline = "";
                manageRest.cpname = txtcpname.Text;
                manageRest.cpno = txtmno.Text;
                manageRest.rmail = txtmailid.Text;
                manageRest.rpswd = txtpswd.Text;
                manageRest.rlogo = "";
                manageRest.expdays = Convert.ToInt32(txtexpdays.Text);
                manageRest.longitude = "";
                manageRest.latitude = "";
                manageRest.dtime = 0;
                manageRest.dradius = 0;
                manageRest.isactive = status;
                manageRest.type = type;
                bool val = manageRest.updateRestaurant();
                if (val)
                {
                    lblmsg.Text = "Restaurant Added Successfully!";
                    reset();
                }
                else
                {
                    lblmsg.Text = "Something Went Wrong";
                    reset();
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "Something Went Wrong";
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            reset();
        }
        public void reset()
        {
            txtrname.Text = "";
            txtcpname.Text = "";
            txtexpdays.Text = "";
            txtmailid.Text = "";
            txtmno.Text = "";
            txtpswd.Text = "";
        }
    }
}