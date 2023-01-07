using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CategoryLibrary;
using System.Configuration;
using System.Data.OleDb;
using KitchenDishes;
using ManageRestaurant;
using System.IO;
using System.Text.RegularExpressions;
namespace tablebooking.Restaurant
{
    public partial class UploadMultipleProducts : System.Web.UI.Page
    {
        HttpCookie KUserInfo = HttpContext.Current.Request.Cookies["RestInfo"];
        DataTable dt;
        kDishes kdish = new kDishes();
        ManageRestaurant.Restaurant kreg = new ManageRestaurant.Restaurant();
        CategoryClass cclass = new CategoryClass();
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
                string ext = "", recipefile = "";
                ext = Path.GetExtension(fldupload.PostedFile.FileName);
                recipefile = kreg.RandomString(10) + ext;
                fldupload.SaveAs(Server.MapPath("images/" + recipefile));
                if (ext.ToLower() == ".xlsx" || ext.ToLower() == ".xls")
                {
                    try
                    {
                        Import_To_Grid(Server.MapPath("images/" + recipefile), ext, "yes");
                    }
                    catch(Exception ex)
                    {
                        lblmsg.Text = "<span style='color:red'>Something Went Wrong..</span>";
                    }
                }
                else
                {
                    lblmsg.Text = "<span style='color:red'>Upload document with .xls or .xlsx extension.</span>";
                }

            }
            catch (Exception ex)
            {
                //lblmsg.Text = "<span style='color:red'>Something Went Wrong.</span>";
                lblmsg.Text = ex.ToString();
            }
        }


        private void Import_To_Grid(string FilePath, string Extension, string isHDR)
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                    break;
            }
            conStr = String.Format(conStr, FilePath, isHDR);
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            DataTable dt = new DataTable();
            cmdExcel.Connection = connExcel;
            //Get the name of First Sheet
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
            connExcel.Close();
            //Read Data from First Sheet
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

            DataTable dt2 = new DataTable();
            dt2.Columns.Add("Title", typeof(string));
            dt2.Columns.Add("category", typeof(string));
            dt2.Columns.Add("catid", typeof(int));
            dt2.Columns.Add("type", typeof(string));
            dt2.Columns.Add("typeid", typeof(int));
            dt2.Columns.Add("Details", typeof(string));
            dt2.Columns.Add("Price", typeof(decimal));
            dt2.Columns.Add("disprice", typeof(decimal));
            DataRow dr2 = null;
            Regex r = new Regex(@"^\d+$");
            foreach (DataRow dr in dt.Rows)
            {
                if (Regex.Match(dr["price"].ToString(), @"^\d+$").Success && Regex.Match(dr["Discounted Price"].ToString(), @"^\d+$").Success)
                {
                    dr2 = dt2.NewRow();
                    dr2["Title"] = dr["Title"];
                    dr2["category"] = drpcategory.SelectedItem.Text;
                    dr2["catid"] = Convert.ToInt32(drpcategory.SelectedValue);
                    dr2["type"] = drpfoodtype.SelectedItem.Text;
                    dr2["typeid"] = Convert.ToInt32(drpfoodtype.SelectedValue);
                    dr2["Details"] = dr["Details"];
                    dr2["Price"] = dr["Price"];
                    dr2["disprice"] = dr["Discounted Price"];
                    dt2.Rows.Add(dr2);
                }
            }

            grddata.DataSource = dt2;
            grddata.DataBind();
            if (dt2.Rows.Count > 0)
            {
                btnuploadall.Visible = true;
            }
        }

        protected void btnuploadall_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (GridViewRow gr in grddata.Rows)
                {
                    Label lbltitle = (Label)gr.Cells[1].FindControl("lbltitle");
                    HiddenField hfcat = (HiddenField)gr.Cells[2].FindControl("hfcat");
                    HiddenField hftype = (HiddenField)gr.Cells[3].FindControl("hftype");
                    Label lbldetails = (Label)gr.Cells[4].FindControl("lbldetails");
                    FileUpload fldimage = (FileUpload)gr.Cells[7].FindControl("fldimage");
                    Label lblprice = (Label)gr.Cells[5].FindControl("lblprice");
                    Label lbldiscountedprice = (Label)gr.Cells[6].FindControl("lbldiscountedprice");

                    string ext = "", dishimg = "";
                    ext = Path.GetExtension(fldimage.PostedFile.FileName);
                    dishimg = kreg.RandomString(10) + ext;
                    fldimage.SaveAs(Server.MapPath("images/" + dishimg));

                    kdish.kitmid = 0;
                    kdish.kid = Convert.ToInt32(KUserInfo["restid"]);
                    kdish.foodcategory = Convert.ToInt32(hfcat.Value);
                    kdish.foodtype = Convert.ToInt32(hftype.Value);
                    kdish.title = lbltitle.Text;
                    kdish.itemimg = dishimg;
                    kdish.description = lbldetails.Text;
                    kdish.price = Convert.ToDecimal(lblprice.Text);
                    kdish.disprice = Convert.ToDecimal(lbldiscountedprice.Text);
                    kdish.status = 1;
                    kdish.type = 1;
                    List<string> udata = kdish.ManageKitchenItems();
                    lblmsg.Text = udata[1];
                    grddata.DataSource = null;
                    grddata.DataBind();
                    btnuploadall.Visible = false;

                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "<span style='color:red'>Something Went Wrong.</span>";
            }
        }
    }
}