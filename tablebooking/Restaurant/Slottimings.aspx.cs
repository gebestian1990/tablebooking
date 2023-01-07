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
    public partial class Slottimings : System.Web.UI.Page
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

            drpbreakopen.DataSource = lstTimeIntervals;
            drpbreakopen.DataBind();
            drpbreakopen.Items.Insert(0, new ListItem("-Select-", "0"));

            drpbreakclose.DataSource = lstTimeIntervals;
            drpbreakclose.DataBind();
            drpbreakclose.Items.Insert(0, new ListItem("-Select-", "0"));

            drplunchopen.DataSource = lstTimeIntervals;
            drplunchopen.DataBind();
            drplunchopen.Items.Insert(0, new ListItem("-Select-", "0"));

            drplunchclose.DataSource = lstTimeIntervals;
            drplunchclose.DataBind();
            drplunchclose.Items.Insert(0, new ListItem("-Select-", "0"));

            drpdinneropen.DataSource = lstTimeIntervals;
            drpdinneropen.DataBind();
            drpdinneropen.Items.Insert(0, new ListItem("-Select-", "0"));

            drpdinnerclose.DataSource = lstTimeIntervals;
            drpdinnerclose.DataBind();
            drpdinnerclose.Items.Insert(0, new ListItem("-Select-", "0"));

            List<string> lstSlotIntervals = new List<string>();
            int val = 0;
            for (int i = 1; i <= 4; i++)
            {
                val = i * 15;
                lstSlotIntervals.Add(val.ToString() + " Mins");
            }

            drpbookdiff.DataSource = lstSlotIntervals;
            drpbookdiff.DataBind();
            drpbookdiff.Items.Insert(0, new ListItem("-Select-", "0"));

            drplunchbookdiff.DataSource = lstSlotIntervals;
            drplunchbookdiff.DataBind();
            drplunchbookdiff.Items.Insert(0, new ListItem("-Select-", "0"));

            drpdinnerbookdiff.DataSource = lstSlotIntervals;
            drpdinnerbookdiff.DataBind();
            drpdinnerbookdiff.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void binddata()
        {
            rslots.restid = Convert.ToInt32(RestInfo["restid"]);
            rslots.dtype = 1;
            dt = new DataTable();
            dt = rslots.fetchslotDetails();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (Convert.ToInt32(dt.Rows[i].ItemArray[3]) == 1 && Convert.ToInt32(dt.Rows[i].ItemArray[12]) == 1)
                    {
                        drpbreakopen.SelectedIndex = drpbreakopen.Items.IndexOf(drpbreakopen.Items.FindByValue(dt.Rows[i].ItemArray[5].ToString()));
                        drpbreakclose.SelectedIndex = drpbreakclose.Items.IndexOf(drpbreakclose.Items.FindByValue(dt.Rows[i].ItemArray[6].ToString()));
                        drpbookdiff.SelectedIndex = drpbookdiff.Items.IndexOf(drpbookdiff.Items.FindByValue(dt.Rows[i].ItemArray[7].ToString()));
                        drpbreakstatus.SelectedIndex = drpbreakstatus.Items.IndexOf(drpbreakstatus.Items.FindByValue(dt.Rows[i].ItemArray[8].ToString()));
                    }
                    else if (Convert.ToInt32(dt.Rows[i].ItemArray[3]) == 2 && Convert.ToInt32(dt.Rows[i].ItemArray[12]) == 1)
                    {
                        drplunchopen.SelectedIndex = drplunchopen.Items.IndexOf(drplunchopen.Items.FindByValue(dt.Rows[i].ItemArray[5].ToString()));
                        drplunchclose.SelectedIndex = drplunchclose.Items.IndexOf(drplunchclose.Items.FindByValue(dt.Rows[i].ItemArray[6].ToString()));
                        drplunchbookdiff.SelectedIndex = drplunchbookdiff.Items.IndexOf(drplunchbookdiff.Items.FindByValue(dt.Rows[i].ItemArray[7].ToString()));
                        drplunchstatus.SelectedIndex = drplunchstatus.Items.IndexOf(drplunchstatus.Items.FindByValue(dt.Rows[i].ItemArray[8].ToString()));
                    }
                    else if (Convert.ToInt32(dt.Rows[i].ItemArray[3]) == 3 && Convert.ToInt32(dt.Rows[i].ItemArray[12]) == 1)
                    {
                        drpdinneropen.SelectedIndex = drpdinneropen.Items.IndexOf(drpdinneropen.Items.FindByValue(dt.Rows[i].ItemArray[5].ToString()));
                        drpdinnerclose.SelectedIndex = drpdinnerclose.Items.IndexOf(drpdinnerclose.Items.FindByValue(dt.Rows[i].ItemArray[6].ToString()));
                        drpdinnerbookdiff.SelectedIndex = drpdinnerbookdiff.Items.IndexOf(drpdinnerbookdiff.Items.FindByValue(dt.Rows[i].ItemArray[7].ToString()));
                        drpdinnerstatus.SelectedIndex = drpdinnerstatus.Items.IndexOf(drpdinnerstatus.Items.FindByValue(dt.Rows[i].ItemArray[8].ToString()));
                    }
                }
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

        protected void btnbreaksubmit_Click(object sender, EventArgs e)
        {
            bool val = updateSlots(1, drpbreakopen.SelectedValue, drpbreakclose.SelectedValue, drpbookdiff.SelectedValue, Convert.ToInt32(drpbreakstatus.SelectedValue), 1);
            if (val)
            {
                lblbreakmsg.Text = "Data Updated";
            }
            else
            {
                lblbreakmsg.Text = "Something Went Wrong..";
            }
            binddata();
        }

        protected void btnlunchsubmit_Click(object sender, EventArgs e)
        {
            bool val = updateSlots(2, drplunchopen.SelectedValue, drplunchclose.SelectedValue, drplunchbookdiff.SelectedValue, Convert.ToInt32(drplunchstatus.SelectedValue), 1);
            if (val)
            {
                lblmsglunch.Text = "Data Updated";
            }
            else
            {
                lblmsglunch.Text = "Something Went Wrong..";
            }
            binddata();
        }

        protected void btndinnersubmit_Click(object sender, EventArgs e)
        {
            bool val = updateSlots(3, drpdinneropen.SelectedValue, drpdinnerclose.SelectedValue, drpdinnerbookdiff.SelectedValue, Convert.ToInt32(drpdinnerstatus.SelectedValue), 1);
            if (val)
            {
                lblmsgdinner.Text = "Data Updated";
            }
            else
            {
                lblmsgdinner.Text = "Something Went Wrong..";
            }
            binddata();
        }
    }
}