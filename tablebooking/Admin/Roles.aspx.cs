using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassRoles;
using System.Data;
namespace nextdoormarket.Admin
{
    public partial class Roles : System.Web.UI.Page
    {
        public static string operate;
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        ARoles adroll = new ARoles();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    bindGrid();
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
                }
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {

                adroll.rid = 0;
                adroll.aid = Convert.ToInt32(AddInfo["aid"]);
                adroll.roll = txtroll.Text;
                adroll.remarks = txtremarks.Text;
                adroll.status = 1;
                adroll.type = 1;
                string msg = adroll.AddRoll();
                reset();
                lblmsg.Text = msg;
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }
        public void reset()
        {
            txtroll.Text = "";
            txtremarks.Text = "";
            lblmsg.Text = "";
            bindGrid();
        }
        public void bindGrid()
        {
            DataTable dt = adroll.getRollData();
            grddata.DataSource = dt;
            grddata.DataBind();
        }
        protected void btncancel_Click(object sender, EventArgs e)
        {
            try
            {
                reset();
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
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
                    HiddenField hfrid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfrid");
                    Label lblroll = (Label)grddata.Rows[e.RowIndex].FindControl("lblroll");
                    HiddenField hfremarks = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfremarks");
                    HiddenField hfstat = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstat");

                    hferid.Value = hfrid.Value;
                    txteditroll.Text = lblroll.Text;
                    txteditreamrks.Text = hfremarks.Value;
                    drpstatus.SelectedIndex = Convert.ToInt32(hfstat.Value);
                    lblmsg2.Text = "";
                    mperoll.Show();
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                adroll.rid = Convert.ToInt32(hferid.Value);
                adroll.aid = Convert.ToInt32(AddInfo["aid"]);
                adroll.roll = txteditroll.Text;
                adroll.remarks = txteditreamrks.Text;
                adroll.status = Convert.ToInt32(drpstatus.SelectedItem.Value);
                adroll.type = 2;
                string msg = adroll.AddRoll();
                lblmsg2.Text = msg;
                mperoll.Show();
                bindGrid();
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }
    }
}