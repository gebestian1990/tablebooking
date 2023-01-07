using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RestaurantTables;
using System.Data;
namespace tablebooking.Restaurant
{
    public partial class tablemaster : System.Web.UI.Page
    {
        Tables tbls = new Tables();
        DataTable dt;
        HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        private static string operate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindid();
                bindViews();
                bindGrid();
            }
        }
        public void bindid()
        {
            tbls.restid = Convert.ToInt32(RestInfo["restid"]);
            txttblname.Text = "T-" + tbls.getTblid().ToString();
        }
        public void bindViews()
        {
            tbls.restid = Convert.ToInt32(RestInfo["restid"]);
            dt = new DataTable();
            dt = tbls.fetchViews();

            drpviews.DataValueField = "vwid";
            drpviews.DataTextField = "vwname";
            drpviews.DataSource = dt;
            drpviews.DataBind();
            drpviews.Items.Insert(0, new ListItem("-Select View-", "0"));

            drpeviews.DataValueField = "vwid";
            drpeviews.DataTextField = "vwname";
            drpeviews.DataSource = dt;
            drpeviews.DataBind();
            drpeviews.Items.Insert(0, new ListItem("-Select View-", "0"));
        }
        public void bindGrid()
        {
            dt = new DataTable();
            tbls.restid = Convert.ToInt32(RestInfo["restid"]);
            dt = tbls.fetchTables();
            grddata.DataSource = dt;
            grddata.DataBind();
        }
        protected void btnviews_Click(object sender, EventArgs e)
        {
            lblvwmsg.Text = "";
            mpeviewspopup.Show();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            int capping = 0;
            if (txtseatscapping.Text != "")
            {
                capping = Convert.ToInt32(txtseatscapping.Text);
            }
            tbls.tblid = 0;
            tbls.restid = Convert.ToInt32(RestInfo["restid"]);
            tbls.tblname = txttblname.Text;
            tbls.tblalias = txttblalias.Text;
            tbls.viewid = Convert.ToInt32(drpviews.SelectedValue);
            tbls.seats = Convert.ToInt32(txtseats.Text);
            tbls.capping = capping;
            tbls.remarks = txtremarks.Text;
            tbls.isactive = 1;
            tbls.type = 1;
            bool val = tbls.manageRestTables();
            if (val)
            {
                lblmsg.Text = "Table Added";
            }
            else
            {
                lblmsg.Text = "Something Went Wrong.";
            }
            reset();
            bindGrid();
            bindid();
        }
        public void reset()
        {
            txttblname.Text = "";
            txttblalias.Text = "";
            drpviews.SelectedIndex = 0;
            txtseats.Text = "";
            txtseatscapping.Text = "";
            txtremarks.Text = "";
            txttblname.Focus();
        }
        protected void btncancel_Click(object sender, EventArgs e)
        {
            reset();
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            tbls.tblid = Convert.ToInt32(hfetblid.Value);
            tbls.restid = Convert.ToInt32(RestInfo["restid"]);
            tbls.tblname = "";
            tbls.tblalias = txttblealias.Text;
            tbls.viewid = Convert.ToInt32(drpeviews.SelectedValue);
            tbls.seats = Convert.ToInt32(txteseats.Text);
            tbls.capping = Convert.ToInt32(txteseatscapping.Text);
            tbls.remarks = txteremarks.Text;
            tbls.isactive = Convert.ToInt32(drpstatus.SelectedValue);
            tbls.type = 2;
            bool val = tbls.manageRestTables();
            if (val)
            {
                lblmsg2.Text = "Table Updated";
            }
            else
            {
                lblmsg2.Text = "Something Went Wrong.";
            }
            mpeuser.Show();
            bindGrid();
        }

        protected void btnaddviews_Click(object sender, EventArgs e)
        {
            tbls.restid = Convert.ToInt32(RestInfo["restid"]);
            tbls.tblalias = txtvwname.Text;
            tbls.type = 1;
            lblvwmsg.Text = tbls.manageViews();
            bindViews();
            mpeviewspopup.Show();
        }

        protected void grddata_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            operate = e.CommandArgument.ToString();
        }

        protected void grddata_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (operate == "edititem")
            {
                HiddenField hftblid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("tblid");
                HiddenField hfremarks = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfremarks");
                Label lblalias = (Label)grddata.Rows[e.RowIndex].FindControl("lblalias");
                HiddenField hfviews = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfviews");
                Label lblseats = (Label)grddata.Rows[e.RowIndex].FindControl("lblseats");
                Label lblcapping = (Label)grddata.Rows[e.RowIndex].FindControl("lblcapping");
                HiddenField hfstat = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstat");

                hfetblid.Value = hftblid.Value;
                txttblealias.Text = lblalias.Text;
                drpeviews.SelectedIndex = drpeviews.Items.IndexOf(drpeviews.Items.FindByValue(hfviews.Value));
                txteseats.Text = lblseats.Text;
                txteseatscapping.Text = lblcapping.Text;
                txteremarks.Text = hfremarks.Value;
                drpstatus.SelectedIndex = Convert.ToInt32(hfstat.Value);
                mpeuser.Show();
            }
        }
    }
}