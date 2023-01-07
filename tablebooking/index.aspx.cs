using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserBookings;
using System.Data;
using System.Web.Services;
using ManageRestaurant;
using RestaurantSlots;
using CategoryLibrary;
using KitchenDishes;
namespace tablebooking
{
    public partial class index : System.Web.UI.Page
    {
        Bookings usrbook = new Bookings();
        Slots bslots = new Slots();
        DataTable dt;
        ManageRestaurant.Restaurant mrest = new ManageRestaurant.Restaurant();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                binddata();
                binddeltypes();
                bindDrps();
                bindProducts();
                Session.Remove("CartCookies");
                // gettimings();
            }
        }
        public void binddata()
        {
            string decrypt = mrest.DecryptString(Request.QueryString["id"]);
            mrest.restid = Convert.ToInt32(decrypt);
            dt = new DataTable();
            dt = mrest.fetchRestaurantsdetails();
            lblrestname.Text = dt.Rows[0].ItemArray[3].ToString();
            ViewState["rmail"] = dt.Rows[0].ItemArray[7].ToString();
            imglogo.ImageUrl = "http://tablebooking.nextdoorkitchen.in/Restaurant/logo/" + dt.Rows[0].ItemArray[8].ToString();
            Session["restid"] = decrypt;
        }
        public void binddeltypes()
        {
            bslots.restid = Convert.ToInt32(Session["restid"]);
            bslots.sclose = DateTime.Now.ToString("HH:mm tt");
            dt = new DataTable();
            dt = bslots.fetchDeviveryOptions();
            rdbdeltypes.DataSource = dt;
            rdbdeltypes.DataValueField = "dtype";
            rdbdeltypes.DataTextField = "doption";
            rdbdeltypes.DataBind();
        }
        public void bindDrps()
        {
            DataTable dt;
            CategoryClass ccat = new CategoryClass();
            ccat.restid = Convert.ToInt32(Session["restid"]);
            dt = new DataTable();
            dt = ccat.getCategoryData();
            drpfoodcategory.DataSource = dt;
            drpfoodcategory.DataTextField = "fcategory";
            drpfoodcategory.DataValueField = "cid";
            drpfoodcategory.DataBind();
            drpfoodcategory.Items.Insert(0, new ListItem("-Category-", "0"));

            ccat.restid = Convert.ToInt32(Session["restid"]);
            dt = new DataTable();
            dt = ccat.getFoodType();
            drpfoodtype.DataSource = dt;
            drpfoodtype.DataTextField = "ftype";
            drpfoodtype.DataValueField = "ftid";
            drpfoodtype.DataBind();
            drpfoodtype.Items.Insert(0, new ListItem("-Type-", "0"));

        }
        public void gettimings()
        {
            usrbook.bookdt = DateTime.Now.ToString("h:mm:ss tt");
            usrbook.restid = Convert.ToInt32(Session["restid"]);
            usrbook.type = 1;
            dt = new DataTable();
            dt = usrbook.fetchBookingTimings();
            //rdbslots.DataTextField = "sslot";
            //rdbslots.DataValueField = "stype";
            //rdbslots.DataSource = dt;
            //rdbslots.DataBind();

        }
        [WebMethod]
        public static string gettime(string time, int type)
        {
            Bookings usrbook = new Bookings();
            usrbook.bookdt = time;
            usrbook.restid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
            usrbook.type = type;
            DataTable dt = new DataTable();
            dt = usrbook.fetchBookingTimings();
            string data = "";
            data += "Which Service are you looking for?<br /><br />";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    data += "<input type='radio' name='slots' value='" + dr["stype"] + "' onclick='fntimeslots(" + dr["stype"] + ")' /> <label for='sslot' style='margin-right:4px'>" + dr["sslot"] + "</label>";
                }
            }
            else
            {
                data += "<p style='color:red'>No Slots Available..</p>";
            }
            return data;
        }
        [WebMethod]
        public static string gettimings(int slots, string time, int type)
        {
            Bookings usrbook = new Bookings();
            usrbook.restid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
            usrbook.ubookid = slots;
            usrbook.bookdt = time;
            usrbook.type = type;
            DataTable dt = new DataTable();
            dt = usrbook.fetchBookingSlots();
            string[] split = dt.Rows[0].ItemArray[2].ToString().Split('#');
            string data = "<div><br/> <span style='margin-right: 152px;'>Select Time</span><br/><br/><table style='margin-left:20px'><tr>";
            for (int i = 0; i < split.Count(); i++)
            {
                if (i % 3 == 0)
                {
                    data += "</tr><tr>";
                }
                data += "<td><div style='margin:0px 0px 4px 4px;border:1px solid black;padding:2px 2px 2px 2px;'><input type='radio' id='rdbtiming" + i.ToString() + "' name='timings' value='" + split[i] + "' onclick='fngetdata(" + i.ToString() + ")' /> <label for='sslot'>" + split[i] + "</label></div></td>";
            }
            data += "</tr></table></div>";
            return data;
        }
        [WebMethod]
        public static string getbookingdetails(int slots, string time, int persons, string bookdt, int type)
        {
            Bookings usrbook = new Bookings();
            usrbook.restid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
            usrbook.npersons = persons;
            usrbook.bookdt = bookdt;
            usrbook.booktime = time;
            usrbook.type = 1;
            DataTable dt = new DataTable();
            dt = usrbook.fetchBookingTables();
            string data = "";
            data += "<table id='customers' style='width:100%;margin-left:20px' border='1'><tr><th>#</th><th>Seats</th><th>Capping</th><th>Views</th></tr>";
            foreach (DataRow dr in dt.Rows)
            {
                if (persons < Convert.ToInt32(dr["capping"]))
                {
                    data += "<tr><td><input type='radio' id='rdbbooks' style='pointer-events:none;opacity:0.5;' name='booktime' value='" + dr["tblid"] + "' onclick='fnbookings(" + dr["tblid"] + ")' /></td><td>" + dr["seats"] + "</td><td>" + dr["capping"] + "</td><td>" + dr["vws"] + "</td></tr>";
                }
                else
                {
                    data += "<tr><td><input type='radio' id='rdbbooks' name='booktime' value='" + dr["tblid"] + "' onclick='fnbookings(" + dr["tblid"] + ")' /></td><td>" + dr["seats"] + "</td><td>" + dr["capping"] + "</td><td>" + dr["vws"] + "</td></tr>";
                }
            }
            data += "</table>";
            return data;
        }
        [WebMethod]
        public static string updateCartdetails(int itmid)
        {
            kDishes kdish = new kDishes();
            DataTable dt = new DataTable();
            if (HttpContext.Current.Session["CartCookies"] == null)
            {
                dt.Columns.Add("kitmid", typeof(int));
                dt.Columns.Add("kid", typeof(int));
                dt.Columns.Add("qty", typeof(int));
                dt.Columns.Add("itmname", typeof(string));
                dt.Columns.Add("price", typeof(int));
                dt.Columns.Add("ttlprice", typeof(int), "qty * price");
                DataRow dr1 = dt.NewRow();
                kdish.kid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                kdish.kitmid = itmid;
                kdish.title = "";
                kdish.foodtype = 0;
                kdish.foodcategory = 0;
                DataTable dt2 = new DataTable();
                dt2 = kdish.KitchemItemsData();
                dr1["kitmid"] = Convert.ToInt32(dt2.Rows[0].ItemArray[0].ToString());
                dr1["kid"] = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                dr1["qty"] = 1;
                dr1["itmname"] = dt2.Rows[0].ItemArray[2].ToString();
                dr1["price"] = Convert.ToInt32(dt2.Rows[0].ItemArray[8]);
                dt.Rows.Add(dr1);
            }
            else
            {
                dt = HttpContext.Current.Session["CartCookies"] as DataTable;
                bool contains = dt.AsEnumerable().Any(row => itmid == row.Field<int>("kitmid"));
                if (contains == true)
                {
                    dt.AsEnumerable().Where(row => row.Field<int>("kitmid") == itmid)
                    .Select(b => b["qty"] = Convert.ToInt32(b["qty"]) + 1)
                    .ToList();
                }
                else
                {
                    kdish.kid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                    kdish.title = "";
                    kdish.kitmid = itmid;
                    kdish.foodtype = 0;
                    kdish.foodcategory = 0;
                    DataTable dt2 = new DataTable();
                    dt2 = kdish.KitchemItemsData();
                    DataRow dr1 = dt.NewRow();
                    dr1["kitmid"] = Convert.ToInt32(dt2.Rows[0].ItemArray[0].ToString());
                    dr1["kid"] = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                    dr1["qty"] = 1;
                    dr1["itmname"] = dt2.Rows[0].ItemArray[2].ToString();
                    dr1["price"] = Convert.ToInt32(dt2.Rows[0].ItemArray[8]);
                    dt.Rows.Add(dr1);
                }
            }
            HttpContext.Current.Session["CartCookies"] = dt;
            int sno = 1;
            int sum = 0;
            string data = dt.Rows.Count + "@@<table id='customers' style='text-align:right' ><tr><th>#.</th><th>Dish</th><th>Qty</th><th>Price</th><th>Total</th></tr>";
            foreach (DataRow dr in dt.Rows)
            {
                data += "<tr><td>" + sno + "</td><td>" + dr["itmname"].ToString() + "</td><td>" + dr["qty"] + "</td><td>$" + dr["price"] + "</td><td>$" + dr["ttlprice"] + "</td><td><a href='javascript:void(0)' onclick='fndelete(" + dr["kitmid"] + ")' ><img width='20' src='img/delete.png' alt='delete' /></i></a></div></td></tr>";
                sno += 1;
                sum += Convert.ToInt32(dr["ttlprice"]);
            }
            data += "<tr><td colspan='4'>Grand Total:</td><td>$" + sum + "</td><td>&nbsp;</td></tr>";
            return data;
        }
        [WebMethod]
        public static string RemoveCartdetails(int itmid)
        {
            DataTable dt = new DataTable();
            dt = HttpContext.Current.Session["CartCookies"] as DataTable;

            var query = dt.AsEnumerable().Where(r => r.Field<int>("kitmid") == itmid);
            foreach (var row in query.ToList())
                row.Delete();
            HttpContext.Current.Session["CartCookies"] = dt;
            string data = "";
            if (dt.Rows.Count > 0)
            {
                int sno = 1;
                int sum = 0;
                data = dt.Rows.Count + "@@<table id='customers' style='text-align:right' ><tr><th>#.</th><th>Dish</th><th>Qty</th><th>Price</th><th>Total</th></tr>";
                foreach (DataRow dr in dt.Rows)
                {
                    data += "<tr><td>" + sno + "</td><td>" + dr["itmname"].ToString() + "</td><td>" + dr["qty"] + "</td><td>$" + dr["price"] + "</td><td>$" + dr["ttlprice"] + "</td><td><a href='javascript:void(0)' onclick='fndelete(" + dr["kitmid"] + ")' ><img width='20' src='img/delete.png' alt='delete' /></i></a></div></td></tr>";
                    sno += 1;
                    sum += Convert.ToInt32(dr["ttlprice"]);
                }
                data += "<tr><td colspan='4'>Grand Total:</td><td>$" + sum + "</td><td>&nbsp;</td></tr>";
            }
            else
            {
                data += "0@@No Data Found..";
            }
            return data;
        }
        [WebMethod]
        public static string getDeliverySlots(int rdbdel, string longi, string lati, string time)
        {
            string data = "";
            DataTable dt;
            if (rdbdel == 2)
            {
                ManageRestaurant.Restaurant mrest = new ManageRestaurant.Restaurant();
                mrest.restid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                mrest.longitude = longi;
                mrest.latitude = lati;
                dt = new DataTable();
                dt = mrest.getRestaurantsMiles();
                if (Convert.ToInt32(dt.Rows[0].ItemArray[0]) > 0)
                {
                    Bookings usrbook = new Bookings();
                    usrbook.restid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                    usrbook.ubookid = rdbdel;
                    usrbook.bookdt = time;
                    usrbook.type = 3;
                    dt = new DataTable();
                    dt = usrbook.fetchBookingSlots();
                    string[] split = dt.Rows[0].ItemArray[2].ToString().Split('#');
                    data = "<div><br/> <span style='margin-right: 152px;'>Select Time</span><br/><br/><table style='margin-left:20px'><tr>";
                    for (int i = 0; i < split.Count(); i++)
                    {
                        if (i % 3 == 0)
                        {
                            data += "</tr><tr>";
                        }
                        data += "<td><div style='margin:0px 0px 4px 4px;border:1px solid black;padding:2px 2px 2px 2px;'><input type='radio' id='rdbdtiming" + i.ToString() + "' name='etimings' value='" + split[i] + "' onclick='fngetdeldata(" + i.ToString() + ")' /> <label for='sslot'>" + split[i] + "</label></div></td>";
                    }
                    data += "</tr></table></div>";
                    return 1 + "@@" + data;
                }
                else
                {
                    data = "0@@0";
                }
            }
            else if (rdbdel == 3)
            {
                Bookings usrbook = new Bookings();
                usrbook.restid = Convert.ToInt32(HttpContext.Current.Session["restid"]);
                usrbook.ubookid = rdbdel;
                usrbook.bookdt = time;
                usrbook.type = 3;
                dt = new DataTable();
                dt = usrbook.fetchBookingSlots();
                string[] split = dt.Rows[0].ItemArray[2].ToString().Split('#');
                data = "<div><br/> <span style='margin-right: 152px;'>Select Time</span><br/><br/><table style='margin-left:20px'><tr>";
                for (int i = 0; i < split.Count(); i++)
                {
                    if (i % 3 == 0)
                    {
                        data += "</tr><tr>";
                    }
                    data += "<td><div style='margin:0px 0px 4px 4px;border:1px solid black;padding:2px 2px 2px 2px;'><input type='radio' id='rdbdtiming" + i.ToString() + "' name='etimings' value='" + split[i] + "' onclick='fngetdeldata(" + i.ToString() + ")' /> <label for='sslot'>" + split[i] + "</label></div></td>";
                }
                data += "</tr></table></div>";
                return 1 + "@@" + data;
            }
            return data;
        }
        protected void imgminus_Click(object sender, ImageClickEventArgs e)
        {
            if (Convert.ToInt32(qty1.Text) > 1)
            {
                qty1.Text = Convert.ToString(Convert.ToInt32(qty1.Text) - 1);
            }
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "", "fnslots();", true);
        }

        protected void imgplus_Click(object sender, ImageClickEventArgs e)
        {
            qty1.Text = Convert.ToString(Convert.ToInt32(qty1.Text) + 1);
            ScriptManager.RegisterClientScriptBlock(this, GetType(), "", "fnslots();", true);
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = HttpContext.Current.Session["CartCookies"] as DataTable;
            string keitmid = "", eqty = "", eprice = "";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (keitmid == "")
                    {
                        keitmid = dr["kitmid"].ToString();
                        eqty = dr["qty"].ToString();
                        eprice = dr["price"].ToString();
                    }
                    else
                    {
                        keitmid += "#" + dr["kitmid"].ToString();
                        eqty += "#" + dr["qty"].ToString();
                        eprice += "#" + dr["price"].ToString();
                    }
                }
                usrbook.ubookid = 0;
                usrbook.restid = Convert.ToInt32(Session["restid"]);
                if (hfbookings.Value != "")
                {
                    usrbook.tblid = Convert.ToInt32(hfbookings.Value);
                }
                else
                {
                    usrbook.tblid = 0;
                }
                usrbook.npersons = Convert.ToInt32(qty1.Text);
                usrbook.bookdt = hfdate.Value;
                usrbook.booktime = hfbtime.Value;
                usrbook.ufname = txtfname.Text;
                usrbook.ulname = txtlname.Text;
                usrbook.ucpno = txtcpno.Text;
                usrbook.umailid = txtmailid.Text;
                usrbook.company = txtcompany.Text;
                usrbook.notes = txtremarks.Text;
                string sparrange = hfsparrange.Value;
                usrbook.specarrange = sparrange;
                usrbook.isterms = 1;
                usrbook.dtype = Convert.ToInt32(hfrdbval.Value);
                usrbook.keitmid = keitmid;
                usrbook.eqty = eqty;
                usrbook.eprice = eprice;
                usrbook.isactive = 1;
                usrbook.type = 1;
                bool val = usrbook.manageBookings();
                if (val)
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "", "alert('Your Order Has been Sent to us..We will get back to you soon..');window.location='index.aspx?id=" + Request.QueryString["id"] + "'", true);
                    string data = "";
                    if (Convert.ToInt32(hfrdbval.Value) == 1)
                    {
                        data = "you have received a new order for table booking from " + txtfname.Text + " " + txtlname.Text + "..please check your account to approve order.";
                    }
                    else if (Convert.ToInt32(hfrdbval.Value) == 2)
                    {
                        data = "you have received a new order for delivery from " + txtfname.Text + " " + txtlname.Text + "..please check your account to approve order.";
                    }
                    else if (Convert.ToInt32(hfrdbval.Value) == 3)
                    {
                        data = "you have received a new order for takeaway from " + txtfname.Text + " " + txtlname.Text + "..please check your account to approve order.";
                    }
                    try
                    {
                        mrest.remarks = data;
                        mrest.rmail = ViewState["rmail"].ToString();
                        mrest.sendOrdermail();
                    }
                    catch (Exception ex)
                    {

                    }
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, GetType(), "", "alert('Something Went Wrong..');window.location='index.aspx?id=" + Request.QueryString["id"] + "'", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "", "alert('Cart Empty..');window.location='index.aspx?id=" + Request.QueryString["id"] + "'", true);
            }
        }

        public void bindProducts()
        {
            kDishes kdish = new kDishes();
            DataTable dt = new DataTable();
            kdish.kid = Convert.ToInt32(Session["restid"]);
            kdish.title = txtsearch.Text;
            kdish.foodcategory = Convert.ToInt32(drpfoodcategory.SelectedValue);
            kdish.foodtype = Convert.ToInt32(drpfoodtype.SelectedValue);
            dt = kdish.KitchemItemsData();
            string data = "";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    data += "<div class='card'>";
                    data += "<img src='../Restaurant/images/" + dr["fimg"].ToString() + "' alt='" + dr["itemname"].ToString() + "' height='100' />";
                    data += "<h1><p class='price'>" + dr["itemname"].ToString() + "</p></h1>";
                    data += "<h3><p class='price'>$" + dr["disprice"].ToString() + "</p></h3>";
                    data += "<p>" + dr["descp"].ToString() + "</p>";
                    data += "<p><a href='javascript:void(0)' class='abtn' onclick='fncart(" + dr["kitmid"] + ")'>Add to Cart</a></p>";
                    data += "</div>";
                }
            }
            else
            {
                data = "No Data Found..";
            }
            lblproducts.Text = data;
        }
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            bindProducts();
        }

    }
}