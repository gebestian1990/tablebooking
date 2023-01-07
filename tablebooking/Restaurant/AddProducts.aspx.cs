using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ManageRestaurant;
using System.Data;
using CategoryLibrary;
using KitchenDishes;
namespace tablebooking.Restaurant
{
    public partial class AddProducts : System.Web.UI.Page
    {

        HttpCookie KUserInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        DataTable dt;
        kDishes kdish = new kDishes();
        ManageRestaurant.Restaurant kreg = new ManageRestaurant.Restaurant();
        CategoryClass cclass = new CategoryClass();
        const int status = 1, type = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindata();
            }
        }
        public void bindata()
        {
            cclass.restid = Convert.ToInt32(KUserInfo["restid"]);
            dt = new DataTable();
            dt = cclass.getCategoryData();
            drpcategory.DataTextField = "fcategory";
            drpcategory.DataValueField = "cid";
            drpcategory.DataSource = dt;
            drpcategory.DataBind();
            drpcategory.Items.Insert(0, new ListItem("-Select Category-", "0"));

            cclass.restid = Convert.ToInt32(KUserInfo["restid"]);
            dt = new DataTable();
            dt = cclass.getFoodType();
            drpfoodtype.DataTextField = "ftype";
            drpfoodtype.DataValueField = "ftid";
            drpfoodtype.DataSource = dt;
            drpfoodtype.DataBind();
            drpfoodtype.Items.Insert(0, new ListItem("-Select Type-", "0"));
        }
        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string ext = "", dishimg = "";
                ext = Path.GetExtension(fldimage.PostedFile.FileName);
                dishimg = kreg.RandomString(10) + ext;
                fldimage.SaveAs(Server.MapPath("images/" + dishimg));

                kdish.kitmid = 0;
                kdish.kid = Convert.ToInt32(KUserInfo["restid"]);
                kdish.foodcategory = Convert.ToInt32(drpcategory.SelectedValue);
                kdish.foodtype = Convert.ToInt32(drpfoodtype.SelectedValue);
                kdish.title = txtitem.Text;
                kdish.itemimg = dishimg;
                kdish.description = txtdetails.Text;
                kdish.price = Convert.ToDecimal(txtprice.Text);
                kdish.disprice = Convert.ToDecimal(txtdisprice.Text);
                kdish.status = status;
                kdish.type = type;
                List<string> udata = kdish.ManageKitchenItems();
                lblmsg.Text = udata[1];
                txtitem.Text = "";
                txtdetails.Text = "";
                txtdisprice.Text = "";
                txtprice.Text = "";
                drpcategory.SelectedIndex = 0;
                drpfoodtype.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong.</span>";
            }
        }
    }
}