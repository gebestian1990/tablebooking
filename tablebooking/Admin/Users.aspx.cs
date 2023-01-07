using ClassRoles;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserRights;
using AdminLogin;
namespace nextdoormarket.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        ManageAdmin adetail = new ManageAdmin();
        Urights urights = new Urights();
        DataTable dt;
        IEnumerable<DataRow> filteredrows = null;
        public static string operate;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    bindGrid();
                    binddrp();
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
                }
            }
        }
        public void binddrp()
        {

            ARoles aroll = new ARoles();
            dt = new DataTable();
            dt = aroll.getRollData();
            filteredrows = null;
            if (dt.Rows.Count > 0)
            {
                if (Convert.ToInt32(AddInfo["aid"]) == 1)
                {
                    filteredrows = from r in dt.AsEnumerable()
                                   where r.Field<decimal>("isactive") == 1
                                   orderby r.Field<int>("rid")
                                   select r;
                    grddata.Columns[3].Visible = true;
                }
                else
                {
                    filteredrows = from r in dt.AsEnumerable()
                                   where r.Field<decimal>("isactive") == 1 && r.Field<int>("rid") > Convert.ToInt32(AddInfo["IsAdmin"])
                                   orderby r.Field<int>("rid")
                                   select r;
                }
            }
            if (filteredrows.Any())
            {
                drproll.DataTextField = "roll";
                drproll.DataValueField = "rid";
                drproll.DataSource = filteredrows.CopyToDataTable();
                drproll.DataBind();
                drproll.Items.Insert(0, new ListItem("-Select Roll-", "0"));

                drperoll.DataTextField = "roll";
                drperoll.DataValueField = "rid";
                drperoll.DataSource = filteredrows.CopyToDataTable();
                drperoll.DataBind();
                drperoll.Items.Insert(0, new ListItem("-Select Roll-", "0"));
            }
            else
            {
                drproll.DataSource = null;
                drproll.DataBind();
                drproll.Items.Insert(0, new ListItem("-Select Roll-", "0"));

                drperoll.DataSource = null;
                drperoll.DataBind();
                drperoll.Items.Insert(0, new ListItem("-Select Roll-", "0"));
            }
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
                adetail.aid = 0;
                adetail.aname = txtusername.Text;
                adetail.amail = txtmailid.Text;
                adetail.amno = txtmno.Text;
                adetail.npswd = txtpswd.Text;
                adetail.isadmin = Convert.ToInt32(drproll.SelectedValue);
                adetail.status = 1;
                adetail.type = 1;
                adetail.maid = Convert.ToInt32(AddInfo["aid"]);
                adetail.remarks = txtremarks.Text;
                lblmsg.Text = adetail.UpdateProfile();
                reset();
                bindGrid();
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }
        public void bindGrid()
        {
            dt = new DataTable();
            dt = adetail.AdminData();
            filteredrows = null;
            if (dt.Rows.Count > 0)
            {
                filteredrows = from t in dt.AsEnumerable()
                               where t.Field<int>("maid") == Convert.ToInt32(AddInfo["aid"])
                               select t;
            }
            if (filteredrows.Any())
            {
                grddata.DataSource = filteredrows.CopyToDataTable();
                grddata.DataBind();
            }
            else
            {
                grddata.DataSource = null;
                grddata.DataBind();
            }
        }
        public void reset()
        {
            txtusername.Text = "";
            txtmailid.Text = "";
            txtmno.Text = "";
            txtpswd.Text = "";
            drproll.SelectedIndex = 0;
            txtremarks.Text = "";
        }
        protected void btncancel_Click(object sender, EventArgs e)
        {
            try
            {
                bindGrid();
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
                    HiddenField hfaid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfaid");
                    Label lblname = (Label)grddata.Rows[e.RowIndex].FindControl("lblname");
                    HiddenField hfremarks = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfremarks");
                    HiddenField hfmail = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfmail");
                    HiddenField hfmno = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfmno");
                    HiddenField hfroll = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfroll");
                    HiddenField hfstat = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstat");

                    hfeaid.Value = hfaid.Value;
                    txtename.Text = lblname.Text;
                    txteemail.Text = hfmail.Value;
                    txtemno.Text = hfmno.Value;
                    txteremarks.Text = hfremarks.Value;
                    drperoll.SelectedIndex = drperoll.Items.IndexOf(drperoll.Items.FindByValue(hfroll.Value));
                    drpstatus.SelectedIndex = Convert.ToInt32(hfstat.Value);
                    lblmsg2.Text = "";
                    mpeuser.Show();
                }
                else if (operate == "editrights")
                {
                    HiddenField hfaid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfaid");
                    Label lblname = (Label)grddata.Rows[e.RowIndex].FindControl("lblname");
                    Session["said"] = hfaid.Value;
                    Session["sname"] = lblname.Text;
                    Response.Redirect("Rights.aspx");
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
                adetail.aid = Convert.ToInt32(hfeaid.Value);
                adetail.aname = txtename.Text;
                adetail.amail = txteemail.Text;
                adetail.amno = txtemno.Text;
                adetail.npswd = txtepswd.Text;
                adetail.isadmin = Convert.ToInt32(drperoll.SelectedValue);
                adetail.status = Convert.ToInt32(drpstatus.SelectedValue);
                adetail.type = 2;
                adetail.maid = 0;
                adetail.remarks = txteremarks.Text;
                lblmsg2.Text = adetail.UpdateProfile();
                mpeuser.Show();
                bindGrid();
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong</span>";
            }
        }
    }
}