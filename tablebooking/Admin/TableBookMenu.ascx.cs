using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using UserRights;
using System.Reflection;
namespace tablebooking.Admin
{
    public partial class TableBookMenu : System.Web.UI.UserControl
    {
        DataTable dt;
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        Urights uright = new Urights();
        string menu = "";
        int index = 0;
        string[] icons;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    int aid = Convert.ToInt32(AddInfo["aid"]);
                    if (Session["menu"] == null)
                    {
                        if (aid == 1)
                        {
                            MasterAdmin();
                        }
                        else
                        {
                            Users(aid);
                        }
                    }
                    else
                    {
                        lblmenu.Text = Session["menu"].ToString();
                    }
                }
                catch (AmbiguousMatchException)
                {
                    lblmenu.Text = "Something Went Wrong";
                }
            }
        }
        public void MasterAdmin()
        {

            dt = new DataTable();
            dt = uright.dtSubHeaders();
            var header = dt.AsEnumerable()
                        .Select(row => new
                        {
                            hid = row.Field<int>("hid"),
                            head = row.Field<string>("header")
                        }).Distinct();
            foreach (var getheader in header)
            {
                icons = menuicons(index);
                menu += "<li class='nav-item'>";
                menu += "<a class='nav-link' data-toggle='collapse' href='#" + icons[0] + "' aria-expanded='false' aria-controls='" + icons[0] + "'>";
                menu += "<span class='menu-title'>" + getheader.head + "</span>";
                menu += "<i class='menu-arrow'></i>";
                menu += "<i class='menu-icon mdi mdi-" + icons[1] + "'></i>";
                menu += "</a>";
                menu += "<div class='collapse' id='" + icons[0] + "'>";
                menu += "<ul class='nav flex-column sub-menu'>";
                var subheader = from row in dt.AsEnumerable()
                                where row.Field<int>("hid") == Convert.ToInt32(getheader.hid)
                                orderby row.Field<int>("hsid")
                                let sheadarray = new object[]
                                {
                                    row.Field<string>("hname"),
                                    row.Field<string>("page")
                                }
                                select row;
                foreach (var shead in subheader)
                {
                    menu += "<li class='nav-item'><a class='nav-link' href='" + shead["page"].ToString() + ".aspx'>" + shead["hname"].ToString() + "</a></li>";
                }
                menu += "</ul>";
                menu += "</div>";
                menu += "</li>";
                index += 1;
            }
            menu += "<li class='nav-item sidebar-actions'>";
            menu += "<span class='nav-link'>";
            menu += " <div class='mt-4'>";
            menu += "<div class='border-bottom'>";
            menu += "<p class='text-secondary'>Settings</p>";
            menu += "</div>";
            menu += "<ul class='gradient-bullet-list mt-4'>";
            menu += "<li><a href='Profile.aspx'>My Profile</a></li>";
            menu += "<li><a href='Logout.aspx'>Logout</a></li></li>";
            menu += "</ul>";
            menu += "</div>";
            menu += "</span>";
            menu += "</li>";
            lblmenu.Text = menu;
            Session["menu"] = menu;
        }
        public void Users(int aid)
        {
            dt = new DataTable();
            uright.aid = aid;
            dt = uright.menulist();
            var header = dt.AsEnumerable()
                        .Select(row => new
                        {
                            hid = row.Field<int>("hid"),
                            head = row.Field<string>("head")
                        }).Distinct();
            foreach (var getheader in header)
            {
                icons = menuicons(index);
                menu += "<li class='nav-item'>";
                menu += "<a class='nav-link' data-toggle='collapse' href='#" + icons[0] + "' aria-expanded='false' aria-controls='" + icons[0] + "'>";
                menu += "<span class='menu-title'>" + getheader.head + "</span>";
                menu += "<i class='menu-arrow'></i>";
                menu += "<i class='menu-icon mdi mdi-" + icons[1] + "'></i>";
                menu += "</a>";
                menu += "<div class='collapse' id='" + icons[0] + "'>";
                menu += "<ul class='nav flex-column sub-menu'>";
                var subheader = from row in dt.AsEnumerable()
                                where row.Field<int>("hid") == Convert.ToInt32(getheader.hid)
                                orderby row.Field<int>("hsid")
                                let sheadarray = new object[]
                                {
                                    row.Field<string>("subhead"),
                                    row.Field<string>("page")
                                }
                                select row;
                foreach (var shead in subheader)
                {
                    menu += "<li class='nav-item'><a class='nav-link' href='" + shead["page"].ToString() + ".aspx'>" + shead["subhead"].ToString() + "</a></li>";
                }
                menu += "</ul>";
                menu += "</div>";
                menu += "</li>";
                index += 1;
            }
            lblmenu.Text = menu;
            Session["menu"] = menu;
        }
        public string[] menuicons(int index)
        {
            string[,] icons = new string[6, 2] {
            {"ui-basic","floor-plan" },
            {"form-elements","card-text-outline"},
            {"charts","chart-line"},
            {"tables","table"},
            {"icons","layers-outline"},
            {"auth","account-circle-outline"}
            };

            string[] rval = new string[] { icons[index, 0], icons[index, 1] };
            return rval;
        }
    }
}