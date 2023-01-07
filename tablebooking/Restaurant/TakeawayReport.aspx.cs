using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserBookings;
using System.Data;
namespace tablebooking.Restaurant
{
    public partial class TakeawayReport : System.Web.UI.Page
    {
        UserBookings.Bookings ubook = new UserBookings.Bookings();
        DataTable dt;
        HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        private static string operate;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bindbookings();
            }
        }
        public void bindbookings()
        {
            ubook.restid = Convert.ToInt32(RestInfo["restid"]);
            ubook.dtype = 3;
            if (txtfdate.Text != "" && txttodate.Text != "")
            {
                ubook.fromdate = txtfdate.Text;
                ubook.todate = txttodate.Text;
            }
            else
            {
                ubook.fromdate = "";
                ubook.todate = "";
            }
            dt = new DataTable();
            dt = ubook.fetchBookings();
            grddata.DataSource = dt;
            grddata.DataBind();
            foreach (GridViewRow gr in grddata.Rows)
            {
                HiddenField hfstatus = (HiddenField)gr.FindControl("hfstatus");
                DropDownList drpestatus = (DropDownList)gr.FindControl("drpstatus");
                Button btnupdatestatus = (Button)gr.FindControl("btnupdatestatus");
                drpestatus.SelectedValue = hfstatus.Value;
                if (Convert.ToInt32(hfstatus.Value) == 2)
                {
                    btnupdatestatus.Visible = false;
                    drpestatus.Enabled = false;
                }
            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            bindbookings();
        }
        protected void grddata_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            operate = e.CommandArgument.ToString();
        }

        protected void grddata_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (operate == "upstatus")
            {
                HiddenField tblid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("tblid");
                HiddenField hfstatus = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstatus");
                DropDownList drpstatus = (DropDownList)grddata.Rows[e.RowIndex].FindControl("drpstatus");
                Label lblbookdt = (Label)grddata.Rows[e.RowIndex].FindControl("lblbookdt");
                Button btnupdatestatus = (Button)grddata.Rows[e.RowIndex].FindControl("btnupdatestatus");

                ubook.ubookid = Convert.ToInt32(tblid.Value);
                ubook.restid = Convert.ToInt32(RestInfo["restid"]);
                ubook.isactive = Convert.ToInt32(drpstatus.SelectedValue);
                ubook.type = 1;
                bool chk = ubook.updateBookingStatus();
                if (!chk)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "", "alert('Something Went Wrong!!');", true);
                }
                else
                {
                    try
                    {
                        ManageRestaurant.Restaurant mrest = new ManageRestaurant.Restaurant();
                        mrest.remarks = "Your Table Booking on " + lblbookdt + " has been approved.";
                        mrest.rmail = RestInfo["rmail"];
                        mrest.sendOrdermail();
                    }
                    catch (Exception ex)
                    { 
                    
                    }
                }
                bindbookings();
            }
        }
    }
}