using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ManageRestaurant;
using System.Data;
namespace tablebooking.Restaurant
{
    public partial class index : System.Web.UI.Page
    {
        ManageRestaurant.Restaurant manageRest = new ManageRestaurant.Restaurant();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtemail.Focus();
                forgot.Visible = false;
            }
        }
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            try
            {
                manageRest.rmail = txtemail.Text.Trim();
                manageRest.rpswd = txtpswd.Text.Trim();
                manageRest.type = 1;
                bool chklogin = manageRest.CheckRestLogin();
                if (chklogin)
                {
                    HttpCookie RestInfo = new HttpCookie("RestInfo");
                    RestInfo["restid"] = manageRest.restid.ToString();
                    RestInfo["restname"] = manageRest.restname;
                    RestInfo["rmail"] = manageRest.rmail;
                    RestInfo["cpno"] = manageRest.cpno;
                    RestInfo["expdate"] = manageRest.remarks.ToString();
                    RestInfo.Expires.Add(new TimeSpan(1, 1, 1, 1, 1));
                    Response.Cookies.Add(RestInfo);
                    Response.Redirect("Dashboard.aspx", false);
                }
                else
                {
                    lblmsg.Text = "<span style='color:red'>Invalid Login Details..<span>";
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong..<span>";
            }
        }
        protected void btnforgot_Click(object sender, EventArgs e)
        {
            try
            {
                manageRest.rmail = txtfemail.Text;
                manageRest.type = 1;
                manageRest.ForgotRestPassword();
                if (manageRest.type == 1)
                {
                    if (manageRest.sendRestRegistermail())
                    {
                        lblfmsg.Text = manageRest.remarks;
                    }
                    else
                    {
                        lblfmsg.Text = "<span style='color:red'>Something Went Wrong.</span>";
                    }
                }
                else
                {
                    lblfmsg.Text = manageRest.rmail;
                }
                forgot.Visible = true;
                login.Visible = false;
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color: red'>Something Went Wrong</span>";
            }
        }
        protected void lnklogin_Click(object sender, EventArgs e)
        {
            forgot.Visible = false;
            login.Visible = true;
        }

        protected void lnkforgotpswd_Click(object sender, EventArgs e)
        {
            forgot.Visible = true;
            login.Visible = false;
        }
    }
}
