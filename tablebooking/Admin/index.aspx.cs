using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AdminLogin;
namespace nextdoormarket.Admin
{
    public partial class index : System.Web.UI.Page
    {
        ManageAdmin madmin = new ManageAdmin();
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
                madmin.amail = txtemail.Text.Trim();
                madmin.apswd = txtpswd.Text.Trim();
                madmin.type = 1;
                bool chklogin = madmin.CheckLogin();
                if (chklogin)
                {
                    HttpCookie AddInfo = new HttpCookie("AddInfo");
                    AddInfo["aid"] = madmin.aid.ToString();
                    AddInfo["aname"] = madmin.aname;
                    AddInfo["amail"] = madmin.amail;
                    AddInfo["amno"] = madmin.amno;
                    AddInfo["role"] = madmin.isadmin.ToString();
                    AddInfo.Expires.Add(new TimeSpan(1, 1, 1, 1, 1));
                    Response.Cookies.Add(AddInfo);
                    Response.Redirect("Dashboard.aspx",false);
                }
                else
                {
                    lblmsg.Text = "<span style='color:red'>Invalid Login Details..<span>";
                }
            }
            catch(Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong..<span>";
            }
        }
        protected void btnforgot_Click(object sender, EventArgs e)
        {
            try
            {
                madmin.amail = txtfemail.Text;
                madmin.type = 1;
                madmin.ForgotPassword();
                if (madmin.status == 1)
                {
                    if (madmin.sendRegistermail())
                    {
                        lblfmsg.Text = madmin.remarks;
                    }
                    else
                    {
                        lblfmsg.Text = "<span style='color:red'>Something Went Wrong.</span>";
                    }
                }
                else
                {
                    lblfmsg.Text = madmin.amail;
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