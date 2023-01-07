using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using UserRights;
namespace nextdoormarket.Admin
{
    public partial class Rights : System.Web.UI.Page
    {
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        Urights rights = new Urights();
        DataTable dthead;
        DataTable dtsubhead;
        IEnumerable<DataRow> subheads;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    hfaid.Value = Session["said"].ToString();
                    BindList();
                    chkrights();
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "<span style='color:red'>Something Went Wrong.</span>";
                }
            }
        }
        public void BindList()
        {
            dthead = new DataTable();
            dthead = rights.dtheaders();
            dtlistheaders.DataSource = dthead;
            dtlistheaders.DataBind();

            dtsubhead = new DataTable();
            dtsubhead = rights.dtSubHeaders();
            if (dthead.Rows.Count > 0)
            {
                foreach (DataListItem lst in dtlistheaders.Items)
                {
                    CheckBoxList chksheader = (CheckBoxList)lst.FindControl("chksubheaders");
                    HiddenField hfhid = (HiddenField)lst.FindControl("hfheader");
                    subheads = null;
                    subheads = from t in dtsubhead.AsEnumerable()
                               where t.Field<int>("hid") == Convert.ToInt32(hfhid.Value)
                               orderby t.Field<int>("aorder") ascending
                               select t;
                    if (subheads.Any())
                    {
                        chksheader.DataSource = subheads.CopyToDataTable();
                        chksheader.DataTextField = "hname";
                        chksheader.DataValueField = "hsid";
                        chksheader.DataBind();
                    }
                }
            }
        }
        public void chkrights()
        {
            foreach (DataListItem dsubhead in dtlistheaders.Items)
            {
                CheckBoxList chksheader = (CheckBoxList)dsubhead.FindControl("chksubheaders");
                HiddenField hfhid = (HiddenField)dsubhead.FindControl("hfheader");
                dtsubhead = new DataTable();
                dtsubhead = rights.dtallottedHeaders();
                if (dtsubhead.Rows.Count > 0)
                {
                    subheads = null;
                    subheads = from t in dtsubhead.AsEnumerable()
                               where t.Field<int>("hid") == Convert.ToInt32(hfhid.Value)
                               && t.Field<int>("aid") == Convert.ToInt32(hfaid.Value)
                               select t;
                    if (subheads.Any())
                    {
                        for (int i = 0; i < chksheader.Items.Count; i++)
                        {
                            bool contains = subheads.CopyToDataTable().AsEnumerable().Any(row => Convert.ToInt32(chksheader.Items[i].Value) == row.Field<int>("hsid"));
                            if (contains == true)
                            {
                                chksheader.Items[i].Selected = true;
                            }
                        }
                    }
                }
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string msg = "";
            try
            {

                foreach (DataListItem lstitem in dtlistheaders.Items)
                {

                    HiddenField hfheader = (HiddenField)lstitem.FindControl("hfheader");
                    CheckBoxList chksubheaders = (CheckBoxList)lstitem.FindControl("chksubheaders");
                    for (int i = 0; i < chksubheaders.Items.Count; i++)
                    {
                        rights.aid = Convert.ToInt32(hfaid.Value);
                        rights.hid = Convert.ToInt32(hfheader.Value);
                        rights.hsid = Convert.ToInt32(chksubheaders.Items[i].Value);
                        rights.said = Convert.ToInt32(AddInfo["aid"]);
                        if (chksubheaders.Items[i].Selected == true)
                        {
                            rights.type = 1;
                        }
                        else
                        {
                            rights.type = 2;
                        }
                        msg = rights.AllotRights();
                    }
                }
                BindList();
                chkrights();
            }
            catch (Exception ex)
            {
                lblmsg.Text = msg;
            }
            lblmsg.Text = msg;

        }
    }
}