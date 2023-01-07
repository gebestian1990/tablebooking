using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RestaurantSlots;
using System.Data;
namespace tablebooking.Restaurant
{
    public partial class deliveryandtakewayslots : System.Web.UI.Page
    {
        Slots rslots = new Slots();
        DataTable dt;
        HttpCookie RestInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindDrps();
                binddata();
            }
        }
        public void bindDrps()
        {
            DateTime start = DateTime.ParseExact("00:00", "HH:mm", null);
            DateTime end = DateTime.ParseExact("23:59", "HH:mm", null);

            int interval = 30;
            List<string> lstTimeIntervals = new List<string>();
            for (DateTime i = start; i <= end; i = i.AddMinutes(interval))
                lstTimeIntervals.Add(i.ToString("HH:mm tt"));

            drpdelopen.DataSource = lstTimeIntervals;
            drpdelopen.DataBind();
            drpdelopen.Items.Insert(0, new ListItem("-Select-", "0"));

            drpdelclose.DataSource = lstTimeIntervals;
            drpdelclose.DataBind();
            drpdelclose.Items.Insert(0, new ListItem("-Select-", "0"));

            drptwayopen.DataSource = lstTimeIntervals;
            drptwayopen.DataBind();
            drptwayopen.Items.Insert(0, new ListItem("-Select-", "0"));

            drptwayclose.DataSource = lstTimeIntervals;
            drptwayclose.DataBind();
            drptwayclose.Items.Insert(0, new ListItem("-Select-", "0"));

            List<string> lstSlotIntervals = new List<string>();
            int val = 0;
            for (int i = 1; i <= 4; i++)
            {
                val = i * 15;
                lstSlotIntervals.Add(val.ToString() + " Mins");
            }

            drpdeldiff.DataSource = lstSlotIntervals;
            drpdeldiff.DataBind();
            drpdeldiff.Items.Insert(0, new ListItem("-Select-", "0"));

            drptwaydiff.DataSource = lstSlotIntervals;
            drptwaydiff.DataBind();
            drptwaydiff.Items.Insert(0, new ListItem("-Select-", "0"));

        }

        public void binddata()
        {
            rslots.restid = Convert.ToInt32(RestInfo["restid"]);
            rslots.dtype = 2;
            dt = new DataTable();
            dt = rslots.fetchslotDetails();
            if (dt.Rows.Count > 0)
            {
                drpdelopen.SelectedIndex = drpdelopen.Items.IndexOf(drpdelopen.Items.FindByValue(dt.Rows[0].ItemArray[5].ToString()));
                drpdelclose.SelectedIndex = drpdelclose.Items.IndexOf(drpdelclose.Items.FindByValue(dt.Rows[0].ItemArray[6].ToString()));
                drpdeldiff.SelectedIndex = drpdeldiff.Items.IndexOf(drpdeldiff.Items.FindByValue(dt.Rows[0].ItemArray[7].ToString()));
                drpdelstatus.SelectedIndex = drpdelstatus.Items.IndexOf(drpdelstatus.Items.FindByValue(dt.Rows[0].ItemArray[8].ToString()));
            }
            rslots.restid = Convert.ToInt32(RestInfo["restid"]);
            rslots.dtype = 3;
            dt = new DataTable();
            dt = rslots.fetchslotDetails();
            if (dt.Rows.Count > 0)
            {
                    drptwayopen.SelectedIndex = drptwayopen.Items.IndexOf(drptwayopen.Items.FindByValue(dt.Rows[0].ItemArray[5].ToString()));
                    drptwayclose.SelectedIndex = drptwayclose.Items.IndexOf(drptwayclose.Items.FindByValue(dt.Rows[0].ItemArray[6].ToString()));
                    drptwaydiff.SelectedIndex = drptwaydiff.Items.IndexOf(drptwaydiff.Items.FindByValue(dt.Rows[0].ItemArray[7].ToString()));
                    drptwaystatus.SelectedIndex = drptwaystatus.Items.IndexOf(drptwaystatus.Items.FindByValue(dt.Rows[0].ItemArray[8].ToString()));
            }
        }

        public bool updateSlots(int stype, string open, string close, string diff, int stat, int dtype)
        {
            rslots.restid = Convert.ToInt32(RestInfo["restid"]);
            rslots.stype = stype;
            rslots.soopentime = open;
            rslots.sclose = close;
            rslots.sdiff = diff;
            rslots.isactive = stat;
            rslots.dtype = dtype;
            rslots.type = 1;
            bool val = rslots.manageRestSlots();
            return val;
        }

        protected void btndelsubmit_Click(object sender, EventArgs e)
        {
            bool val = updateSlots(4, drpdelopen.SelectedValue, drpdelclose.SelectedValue, drpdeldiff.SelectedValue, Convert.ToInt32(drpdelstatus.SelectedValue), 2);
            if (val)
            {
                lbldelmsg.Text = "Data Updated";
            }
            else
            {
                lbldelmsg.Text = "Something Went Wrong..";
            }
            binddata();
        }

        protected void btnywaysubmit_Click(object sender, EventArgs e)
        {
            bool val = updateSlots(5, drptwayopen.SelectedValue, drptwayclose.SelectedValue, drptwaydiff.SelectedValue, Convert.ToInt32(drptwaystatus.SelectedValue), 3);
            if (val)
            {
                lblmsgtway.Text = "Data Updated";
            }
            else
            {
                lblmsgtway.Text = "Something Went Wrong..";
            }
            binddata();
        }
    }
}