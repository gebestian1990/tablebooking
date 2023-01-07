using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CategoryLibrary;
namespace tablebooking.Restaurant
{
    public partial class FoodCategory : System.Web.UI.Page
    {
        public static string operate;
        HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
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
                CategoryClass ccat = new CategoryClass();
                ccat.cid = 0;
                ccat.aid = 0;
                ccat.restid = Convert.ToInt32(RestInfo["restid"]);
                ccat.category = txtcategory.Text;
                ccat.remarks = txtremarks.Text;
                ccat.status = 1;
                ccat.type = 1;
                string msg = ccat.AddCategory();
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
            txtcategory.Text = "";
            txtremarks.Text = "";
            lblmsg.Text = "";
            bindGrid();
        }
        public void bindGrid()
        {
            CategoryClass ccat = new CategoryClass();
            ccat.restid = Convert.ToInt32(RestInfo["restid"]);
            DataTable dt = ccat.getCategoryData();
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
                    HiddenField hfcid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfcid");
                    Label lblcategory = (Label)grddata.Rows[e.RowIndex].FindControl("lblecategory");
                    HiddenField hfremarks = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfremarks");
                    HiddenField hfstat = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstat");

                    hfecid.Value = hfcid.Value;
                    txteditcategory.Text = lblcategory.Text;
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
                CategoryClass ccat = new CategoryClass();
                ccat.cid = Convert.ToInt32(hfecid.Value);
                ccat.aid = 0;
                ccat.restid = Convert.ToInt32(RestInfo["restid"]);
                ccat.category = txteditcategory.Text;
                ccat.remarks = txteditreamrks.Text;
                ccat.status = Convert.ToInt32(drpstatus.SelectedItem.Value);
                ccat.type = 2;
                string msg = ccat.AddCategory();
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