using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UserRights;
namespace nextdoormarket.Admin
{
    public partial class NXDAdminMaster : System.Web.UI.MasterPage
    {
        HttpCookie AddInfo = HttpContext.Current.Request.Cookies["AddInfo"];
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.ClearHeaders();
                Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
                Response.AddHeader("Pragma", "no-cache");
                ChkCookies();
            }
        }
        public void ChkCookies()
        {
            try
            {
                if (Request.Cookies["AddInfo"] == null)
                {
                    Response.Redirect("logout.aspx",false);
                }
                else
                {
                    HttpCookie AddInfo = Request.Cookies["AddInfo"];
                    string page = Path.GetFileName(Request.Path);
                    lblname.Text = AddInfo["aname"].ToString();
                   // lblrole.Text = AddInfo["role"].ToString();
                    Urights usrright = new Urights();
                    List<string> excludepages = new List<string>();
                    excludepages.Add("dashboard.aspx");
                    excludepages.Add("profile.aspx");

                    if (!excludepages.Contains(page.ToLower()))
                    {
                        if (Convert.ToInt32(AddInfo["aid"]) > 1)
                        {
                            usrright.aid = Convert.ToInt32(AddInfo["aid"]);
                            usrright.page = page;
                            bool chkpage = usrright.checkuserformenu();
                            if (chkpage == false)
                            {
                                Response.Redirect("logout.aspx");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("logout.aspx");
            }
        }
    }
}