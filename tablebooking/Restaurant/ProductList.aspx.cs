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
    public partial class ProductList : System.Web.UI.Page
    {
        HttpCookie KUserInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        DataTable dt;
        kDishes kdish = new kDishes();
        ManageRestaurant.Restaurant kreg = new ManageRestaurant.Restaurant();
        CategoryClass cclass = new CategoryClass();
        private static string operate;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bindgrid();
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
        protected void btnsearch_Click(object sender, EventArgs e)
        {
            bindgrid();
        }
        public void bindgrid()
        {
            dt = new DataTable();
            if (txtproduct.Text != "")
            {
                kdish.title = txtproduct.Text;
            }
            else
            {
                kdish.title = "";
            }
            kdish.foodcategory = 0;
            kdish.foodtype = 0;
            kdish.kitmid = 0;
            kdish.kid = Convert.ToInt32(KUserInfo["restid"]);
            dt = kdish.KitchemItemsData();
            grddata.DataSource = dt;
            grddata.DataBind();
        }
        protected void grddata_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            operate = e.CommandArgument.ToString();
        }

        protected void grddata_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            HiddenField hfkitmid = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfkitmid");
            HiddenField hftitle = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hftitle");
            HiddenField hfcat = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfcat");
            HiddenField hftype = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hftype");
            HiddenField hfimg = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfimg");
            HiddenField hfprice = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfprice");
            HiddenField hfdisprice = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfdisprice");
            HiddenField hfdetails = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfdetails");
            HiddenField hfstatus = (HiddenField)grddata.Rows[e.RowIndex].FindControl("hfstatus");
            if (operate == "edititem")
            {
                hfekitmid.Value = hfkitmid.Value;
                txtitem.Text = hftitle.Value;
                drpcategory.SelectedValue = hfcat.Value;
                drpfoodtype.SelectedValue = hftype.Value;
                hfeimg.Value = hfimg.Value;
                txtdetails.Text = hfdetails.Value.Replace("& lt;", "<").Replace("& gt;", ">");
                txtprice.Text = Convert.ToString(decimal.ToInt32(Convert.ToDecimal(hfprice.Value)));
                txtdisprice.Text = Convert.ToString(decimal.ToInt32(Convert.ToDecimal(hfdisprice.Value)));
                if (Convert.ToInt32(hfstatus.Value) == 0)
                {
                    drpstatus.SelectedIndex = 0;
                }
                else
                {
                    drpstatus.SelectedIndex = 1;
                }
                lblmsg2.Text = "";
                mperoll.Show();
            }
            else if (operate == "deleteitem")
            {
                kdish.kitmid = Convert.ToInt32(hfekitmid.Value);
                kdish.kid = Convert.ToInt32(KUserInfo["restid"]);
                kdish.foodcategory = 0;
                kdish.foodtype = 0;
                kdish.title = "";
                kdish.itemimg = "";
                kdish.description = "";
                kdish.price = 0;
                kdish.disprice = 0;
                kdish.status = 2;
                kdish.type = 3;
                List<string> udata = kdish.ManageKitchenItems();
                lblmsg.Text = udata[1];
                bindgrid();
            }
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                string ext = "", dishimg = "";
                if (fldimage.HasFile)
                {
                    ext = Path.GetExtension(fldimage.PostedFile.FileName);
                    dishimg = kreg.RandomString(10) + ext;
                    fldimage.SaveAs(Server.MapPath("images/" + dishimg));
                }
                else
                {
                    dishimg = hfeimg.Value;
                }
                kdish.kitmid = Convert.ToInt32(hfekitmid.Value);
                kdish.kid = Convert.ToInt32(KUserInfo["restid"]);
                kdish.foodcategory = Convert.ToInt32(drpcategory.SelectedValue);
                kdish.foodtype = Convert.ToInt32(drpfoodtype.SelectedValue);
                kdish.title = txtitem.Text;
                kdish.itemimg = dishimg;
                kdish.description = txtdetails.Text;
                kdish.price = Convert.ToDecimal(txtprice.Text);
                kdish.disprice = Convert.ToDecimal(txtdisprice.Text);
                kdish.status = Convert.ToInt32(drpstatus.SelectedValue);
                kdish.type = 2;
                List<string> udata = kdish.ManageKitchenItems();
                lblmsg2.Text = udata[1];
            }
            catch (Exception ex)
            {
                lblmsg2.Text = "<span style='color:red'>Something Went Wrong..</span>";
            }
            mperoll.Show();
            bindgrid();
        }
    }
}