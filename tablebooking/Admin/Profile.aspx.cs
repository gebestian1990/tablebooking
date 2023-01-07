using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AdminLogin;
namespace nextdoormarket.Admin
{
    public partial class Profile : System.Web.UI.Page
    {
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        ManageAdmin madmin = new ManageAdmin();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    LoadDetails();
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "<span style='color:red'>Something Went Wrong..</span>";
                }
            }
        }
        public void LoadDetails()
        {
            madmin.aid = Convert.ToInt32(AddInfo["aid"]);
            madmin.AdminDetails();
            txtname.Text = madmin.aname;
            txtemail.Text = madmin.amail;
            txtmno.Text = madmin.amno;
            txtoldpassword.Text = "";
            txtnewpswd.Text = "";
            txtconfirmpswd.Text = "";
            lblmsg.Text = "";
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
                madmin.aid = Convert.ToInt32(AddInfo["aid"]);
                madmin.apswd = txtoldpassword.Text;
                if (madmin.ChkPswd())
                {
                    lblmsg.Text = "";
                    madmin.aid = Convert.ToInt32(AddInfo["aid"]);
                    madmin.aname = txtname.Text;
                    madmin.amail = txtemail.Text;
                    madmin.amno = txtmno.Text;
                    madmin.npswd = txtnewpswd.Text;
                    madmin.isadmin = Convert.ToInt32(AddInfo["role"]);
                    madmin.status = 1;
                    madmin.type = 2;
                    madmin.maid = 0;
                    madmin.remarks = "";
                    string msg = madmin.UpdateProfile();
                    LoadDetails();
                    lblmsg.Text = msg;
                }
                else
                {
                    lblmsg.Text = "<span style='color:red'>InCorrect Old Password Entered..</span>";
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            try
            {
                LoadDetails();
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }
    }
}