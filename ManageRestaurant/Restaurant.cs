using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NXTConnection;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Web;
using System.Net.Mime;
namespace ManageRestaurant
{
    public class Restaurant
    {
        ConnectionClass conn = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _restid;
        public int restid { get { return _restid; } set { _restid = value; } }
        public int _aid { get; set; }
        public int aid { get { return _aid; } set { _aid = value; } }
        public string _restname;
        public string restname { get { return _restname; } set { _restname = value; } }
        public string _tagline;
        public string tagline { get { return _tagline; } set { _tagline = value; } }
        public string _cpname;
        public string cpname { get { return _cpname; } set { _cpname = value; } }
        public string _cpno;
        public string cpno { get { return _cpno; } set { _cpno = value; } }
        public string _rmail;
        public string rmail { get { return _rmail; } set { _rmail = value; } }
        public string _rpswd;
        public string rpswd { get { return _rpswd; } set { _rpswd = value; } }
        public string _rlogo;
        public string rlogo { get { return _rlogo; } set { _rlogo = value; } }
        public int _expdays;
        public int expdays { get { return _expdays; } set { _expdays = value; } }
        public int _isactive;
        public int isactive { get { return _isactive; } set { _isactive = value; } }
        public int _type;
        public int type { get { return _type; } set { _type = value; } }
        public string _expdate;
        public string expdate { get { return _expdate; } set { _expdate = value; } }
        public string _remarks;
        public string remarks { get { return _remarks; } set { _remarks = value; } }
        public string _longitude;
        public string longitude { get { return _longitude; } set { _longitude = value; } }
        public string _latitude;
        public string latitude { get { return _latitude; } set { _latitude = value; } }
        public int _dtime;
        public int dtime { get { return _dtime; } set { _dtime = value; } }
        public int _dradius;
        public int dradius { get { return _dradius; } set { _dradius = value; } }
        public bool updateRestaurant()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spupdaterestdetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@restname", restname);
            cmd.Parameters.AddWithValue("@tagline", tagline);
            cmd.Parameters.AddWithValue("@cpname", cpname);
            cmd.Parameters.AddWithValue("@cpno", cpno);
            cmd.Parameters.AddWithValue("@rmail", rmail);
            cmd.Parameters.AddWithValue("@rpswd", rpswd);
            cmd.Parameters.AddWithValue("@rlogo", rlogo);
            cmd.Parameters.AddWithValue("@expdays", expdays);
            cmd.Parameters.AddWithValue("@long", longitude);
            cmd.Parameters.AddWithValue("@lati", latitude);
            cmd.Parameters.AddWithValue("@dtime", dtime);
            cmd.Parameters.AddWithValue("@delradius", dradius);
            cmd.Parameters.AddWithValue("@isactive", isactive);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            bool val = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return val;
        }
        public DataTable fetchRestaurants()
        {
            con = conn.NXTConn();
            if (type == 1)
            {
                if (restname != "")
                {
                    cmd = new SqlCommand("select * from dbo.VwRestaurant_Details where restname like '%'+@rname+'%'", con);
                }
                else
                {
                    cmd = new SqlCommand("select * from dbo.VwRestaurant_Details", con);
                }
            }
            else
            {
                if (restname != "")
                {
                    cmd = new SqlCommand("select * from dbo.VwRestaurant_Details where aid=@aid and restname like '%'+@rname+'%'", con);
                }
                else
                {
                    cmd = new SqlCommand("select * from dbo.VwRestaurant_Details where aid=@aid", con);
                }
            }
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@rname", restname);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable fetchRestaurantsdetails()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.VwRestaurant_Details where restid=@restid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable getRestaurantsMiles()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.fnCalcDistanceMiles(@lati,@longi,@restid)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@lati", latitude);
            cmd.Parameters.AddWithValue("@longi", longitude);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public bool CheckRestLogin()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.fncheckrest_logindetails(@rmail,@pswd,@type)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@rmail", rmail);
            cmd.Parameters.AddWithValue("@pswd", rpswd);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            if (dt.Rows.Count > 0)
            {
                restid = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
                restname = dt.Rows[0].ItemArray[1].ToString();
                rmail = dt.Rows[0].ItemArray[2].ToString();
                cpno = dt.Rows[0].ItemArray[3].ToString();
                remarks = dt.Rows[0].ItemArray[4].ToString();
                return true;
            }
            else
            {
                return false;
            }
        }
        public void ForgotRestPassword()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.sprestaurant_forgotpswd", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@rmail", rmail);
            cmd.Parameters.AddWithValue("@type", 1);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            isactive = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
            rmail = dt.Rows[0].ItemArray[1].ToString();
            rpswd = dt.Rows[0].ItemArray[2].ToString();
            remarks = dt.Rows[0].ItemArray[3].ToString();
        }
        public bool ChkRestPswd()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select count(*) from VwRestaurant_Details where restid=@restid and rpswd=hashbytes('SHA1',(@pswd+ cast(upid as nvarchar(36))))", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@pswd", rpswd);
            con.Open();
            int chkdata = (int)cmd.ExecuteScalar();
            con.Close();
            if (chkdata == 1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool sendRestRegistermail()
        {
            try
            {
                using (MailMessage mailMessage = new MailMessage())
                {
                    MailMessage Msg = new MailMessage();
                    Msg.From = new MailAddress("info@nextdoorkitchen.in", "Restaurant Table Booking");
                    // Recipient e-mail address.
                    Msg.To.Add(rmail);
                    Msg.Subject = "Restaurant Table Booking Login Details";
                    Msg.AlternateViews.Add(Mail_Body());
                    Msg.IsBodyHtml = true;
                    // your remote SMTP server IP.
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "localhost";
                    smtp.Port = 25;
                    smtp.Credentials = new System.Net.NetworkCredential("info@nextdoorkitchen.in", "zs8p*6V6");
                    smtp.EnableSsl = false;
                    smtp.Send(Msg);
                }

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        private AlternateView Mail_Body()
        {
            string path = HttpContext.Current.Server.MapPath("assets/images/logo.png");
            LinkedResource Img = new LinkedResource(path, MediaTypeNames.Image.Jpeg);
            Img.ContentId = "MyImage";

            string body = "";

            body += "<html>";
            body += "<title>";
            body += "Welcome to Table Booking..";
            body += "</title>";
            body += "<body>";
            body += "<center><a href=\"http://tablebooking.nextdoorkitchen.in/\"><img src=cid:MyImage  id='img' alt=''/> </a><br/>";
            body += "<p style=\"font-weight:bold;color:#30c4ca;font-size:30px\">Next Door Kitchen.</p>";
            body += "<p style=\"font-weight:bold;font-size:25px\">";

            body += "New Login Details For Table Booking Restaurant Panel<br/><br/>Your Login Details Are <br/> Email-ID : " + rmail + "<br/>New Password: " + rpswd + "";
            body += "<br/><br/><h6 style='color:red'>Note: Please Update Password After You Login With The Above Login Details.</h6>";
            body += "</p>";

            body += "</center>";
            body += "</body>";
            body += "</title>";

            AlternateView AV =
            AlternateView.CreateAlternateViewFromString(body, null, MediaTypeNames.Text.Html);
            AV.LinkedResources.Add(Img);
            return AV;
        }
        public Random random = new Random();

        public string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public string DecryptString(string encrString)
        {
            byte[] b;
            string decrypted;
            try
            {
                b = Convert.FromBase64String(encrString);
                decrypted = System.Text.ASCIIEncoding.ASCII.GetString(b);
            }
            catch (FormatException fe)
            {
                decrypted = "";
            }
            return decrypted;
        }

        public string EnryptString(string strEncrypted)
        {
            byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(strEncrypted);
            string encrypted = Convert.ToBase64String(b);
            return encrypted;
        }
        public DataTable Notifications()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from Vwnotifications", con);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public int kitchenNotifications()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select isactive from Vwkitchen_notifications where restid=@restid and notid=@notid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@notid", aid);
            con.Open();
            int isactive = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
            return isactive;
        }
        public bool updateKitchenNotifications()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spupdate_restnotifications", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@notid", aid);
            cmd.Parameters.AddWithValue("@isactive", isactive);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            bool chk = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return chk;
        }
        public bool sendOrdermail()
        {
            try
            {
                using (MailMessage mailMessage = new MailMessage())
                {
                    MailMessage Msg = new MailMessage();
                    Msg.From = new MailAddress("info@nextdoorkitchen.in", "Restaurant Table Booking");
                    // Recipient e-mail address.
                    Msg.To.Add(rmail);
                    Msg.Subject = "Restaurant Order Details";
                    Msg.Body = remarks;
                    Msg.IsBodyHtml = true;
                    // your remote SMTP server IP.
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "localhost";
                    smtp.Port = 25;
                    smtp.Credentials = new System.Net.NetworkCredential("info@nextdoorkitchen.in", "zs8p*6V6");
                    smtp.EnableSsl = false;
                    smtp.Send(Msg);
                }

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
