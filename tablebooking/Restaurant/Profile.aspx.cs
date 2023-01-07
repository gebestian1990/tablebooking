using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ManageRestaurant;
using System.Data;
using System.IO;
namespace tablebooking.Restaurant
{
    public partial class Profile : System.Web.UI.Page
    {
        ManageRestaurant.Restaurant manageRest = new ManageRestaurant.Restaurant();
        DataTable dt;
        HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindData();
            }
        }
        public void bindData()
        {
            dt = new DataTable();
            manageRest.restid = Convert.ToInt32(RestInfo["restid"]);
            dt = manageRest.fetchRestaurantsdetails();
            txtrname.Text = dt.Rows[0].ItemArray[3].ToString();
            txttagline.Text = dt.Rows[0].ItemArray[4].ToString();
            txtcpname.Text = dt.Rows[0].ItemArray[5].ToString();
            txtmailid.Text = dt.Rows[0].ItemArray[7].ToString();
            txtmno.Text = dt.Rows[0].ItemArray[6].ToString();
            hflogo.Value = dt.Rows[0].ItemArray[8].ToString();
            imglogo.ImageUrl = "logo/" + dt.Rows[0].ItemArray[8].ToString();
            txtlongitude.Text = dt.Rows[0].ItemArray[13].ToString();
            txtlatitude.Text = dt.Rows[0].ItemArray[14].ToString();
            txtdeltime.Text = dt.Rows[0].ItemArray[15].ToString();
            txtdelradius.Text = dt.Rows[0].ItemArray[16].ToString();
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {

                string ext = "", logoimg = "";
                if (fldlogo.HasFile)
                {
                    ext = Path.GetExtension(fldlogo.PostedFile.FileName);
                    logoimg = manageRest.RandomString(10) + ext;
                    fldlogo.SaveAs(Server.MapPath("logo/" + logoimg));
                }
                else
                {
                    logoimg = hflogo.Value;
                }

                manageRest.restid = Convert.ToInt32(RestInfo["restid"]);
                manageRest.aid = 0;
                manageRest.restname = txtrname.Text;
                manageRest.tagline = txttagline.Text;
                manageRest.cpname = txtcpname.Text;
                manageRest.cpno = txtmno.Text;
                manageRest.rmail = txtmailid.Text;
                manageRest.rpswd = txtpswd.Text;
                manageRest.rlogo = logoimg;
                manageRest.expdays = 0;
                manageRest.longitude = hflongitude.Value;
                manageRest.latitude = hflatitude.Value;
                manageRest.dtime = Convert.ToInt32(txtdeltime.Text);
                manageRest.dradius = Convert.ToInt32(txtdelradius.Text);
                manageRest.isactive = 1;
                manageRest.type = 3;
                bool val = manageRest.updateRestaurant();
                if (val)
                {
                    lblmsg.Text = "Data Updated!";
                }
                else
                {
                    lblmsg.Text = "Something Went Wrong";
                }
                bindData();
            }
            catch (Exception ex)
            {
                lblmsg.Text = "Something Went Wrong";
            }
        }
    }
}