using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ManageRestaurant;
using System.Data;
using UserBookings;
namespace tablebooking.Admin
{
    public partial class ViewRestaurant : System.Web.UI.Page
    {
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        UserBookings.Bookings ubook = new UserBookings.Bookings();
        ManageRestaurant.Restaurant manageRest = new ManageRestaurant.Restaurant();
        DataTable dt;
        public static string operate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindGrid();
            }
        }
        public void bindGrid()
        {
            dt = new DataTable();
            if (Convert.ToInt32(AddInfo["role"]) == 1)
            {
                manageRest.type = 1;
            }
            else
            {
                manageRest.type = 0;
                manageRest.aid = Convert.ToInt32(AddInfo["aid"]);
            }
            manageRest.restname = txtsearchrestraurant.Text;
            dt = manageRest.fetchRestaurants();
            grddata.DataSource = dt;
            grddata.DataBind();
        }
        public void reset()
        {
            txtrname.Text = "";
            txtcpname.Text = "";
            txteemail.Text = "";
            txtemno.Text = "";
            txtepswd.Text = "";
            txtexpdays.Text = "";
            drpstatus.SelectedIndex = 0;
        }
        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                int expdays;
                if (txtexpdays.Text != "")
                {
                    expdays = Convert.ToInt32(txtexpdays.Text);
                }
                else
                {
                    expdays = 0;
                }
                manageRest.restid = Convert.ToInt32(hferestid.Value);
                manageRest.aid = Convert.ToInt32(AddInfo["aid"]);
                manageRest.restname = txtrname.Text;
                manageRest.tagline = "";
                manageRest.cpname = txtcpname.Text;
                manageRest.cpno = txtemno.Text;
                manageRest.rmail = txteemail.Text;
                manageRest.rpswd = txtepswd.Text;
                manageRest.rlogo = "";
                manageRest.expdays = expdays;
                manageRest.longitude = "";
                manageRest.latitude = "";
                manageRest.dtime = 0;
                manageRest.dradius = 0;
                manageRest.isactive = Convert.ToInt32(drpstatus.SelectedValue);
                manageRest.type = 2;
                bool val = manageRest.updateRestaurant();
                if (val)
                {
                    lblmsg2.Text = "Restaurant Updated Successfully!";
                }
                else
                {
                    lblmsg2.Text = "Something Went Wrong";
                }
                mpeuser.Show();
                bindGrid();
            }
            catch (Exception ex)
            {
                lblmsg2.Text = "Something Went Wrong";
            }
        }

        protected void grddata_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            operate = e.CommandArgument.ToString();
        }

        protected void grddata_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                if (operate == "edititem")
                {
                    reset();
                    HiddenField hfrestid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfrestid");
                    Label lblname = (Label)grddata.Rows[e.RowIndex].FindControl("lblname");
                    HiddenField hfcpname = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfcpname");
                    HiddenField hfmail = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfmail");
                    HiddenField hfmno = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfmno");
                    HiddenField hfstat = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstat");
                    HiddenField hfexpdate = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfexpdate");

                    hferestid.Value = hfrestid.Value;
                    txtrname.Text = lblname.Text;
                    txtcpname.Text = hfcpname.Value;
                    txteemail.Text = hfmail.Value;
                    txtemno.Text = hfmno.Value;
                    lblexpdate.Text = "Expiry Date: " + hfexpdate.Value; ;
                    drpstatus.SelectedIndex = Convert.ToInt32(hfstat.Value);
                    lblmsg2.Text = "";
                    mpeuser.Show();
                }
                else if (operate == "viewbookings")
                {
                    HiddenField hfrestid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfrestid");
                    hfpoprestid.Value = hfrestid.Value;
                    bindbookings();
                    mpesrch.Show();
                }
            }
            catch (Exception ex)
            {
                lblmsg2.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }
        public void bindbookings()
        {
            ubook.restid = Convert.ToInt32(hfpoprestid.Value);
            if (txtfdate.Text != "" && txttodate.Text != "")
            {
                ubook.fromdate = txtfdate.Text;
                ubook.todate = txttodate.Text;
            }
            else
            {
                string date = DateTime.Now.ToString("dd/MM/yyyy");
                ubook.fromdate = date;
                ubook.todate = date;
            }
            dt = new DataTable();
            dt = ubook.fetchBookings();
            grdsrchbookings.DataSource = dt;
            grdsrchbookings.DataBind();
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            bindGrid();
        }

        protected void btnsrchdate_Click(object sender, EventArgs e)
        {
            bindbookings();
            mpesrch.Show();
        }

        protected void btnsrchdate_Click1(object sender, EventArgs e)
        {
            bindbookings();
            mpesrch.Show();
        }
    }
}