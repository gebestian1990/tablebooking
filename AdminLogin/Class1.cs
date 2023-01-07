using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NXTConnection;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
namespace AdminLogin
{
    public class ManageAdmin
    {
        ConnectionClass conn = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _aid;
        public int aid
        {
            get { return _aid; }
            set { _aid = value; }
        }
        public int _maid;
        public int maid
        {
            get { return _maid; }
            set { _maid = value; }
        }
        public string _aname;
        public string aname
        {
            get { return _aname; }
            set { _aname = value; }
        }
        public string _amail;
        public string amail
        {
            get { return _amail; }
            set { _amail = value; }
        }
        public string _npswd;
        public string npswd
        {
            get { return _npswd; }
            set { _npswd = value; }
        }
        public string _apswd;
        public string apswd
        {
            get { return _apswd; }
            set { _apswd = value; }
        }
        public string _amno;
        public string amno
        {
            get { return _amno; }
            set { _amno = value; }
        }
        public string _remarks;
        public string remarks
        {
            get { return _remarks; }
            set { _remarks = value; }
        }
        public int _isadmin;
        public int isadmin
        {
            get { return _isadmin; }
            set { _isadmin = value; }
        }
        public int _status;
        public int status
        {
            get { return _status; }
            set { _status = value; }
        }
        public int _type;
        public int type
        {
            get { return _type; }
            set { _type = value; }
        }
        public bool CheckLogin()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.fncheck_logindetails(@email,@pswd,@type)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@email", amail);
            cmd.Parameters.AddWithValue("@pswd", apswd);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            if (dt.Rows.Count > 0)
            {
                aid = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
                aname = dt.Rows[0].ItemArray[1].ToString();
                amail = dt.Rows[0].ItemArray[2].ToString();
                amno = dt.Rows[0].ItemArray[3].ToString();
                isadmin = Convert.ToInt32(dt.Rows[0].ItemArray[4]);
                return true;
            }
            else
            {
                return false;
            }
        }
        public void ForgotPassword()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spadmin_forgotpswd", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@amail", amail);
            cmd.Parameters.AddWithValue("@type", 1);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            status = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
            amail = dt.Rows[0].ItemArray[1].ToString();
            apswd = dt.Rows[0].ItemArray[2].ToString();
            remarks = dt.Rows[0].ItemArray[3].ToString();
        }
        public void AdminDetails()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select aname,amail,amno from VwAdminDetails where aid=@aid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            aname = dt.Rows[0].ItemArray[0].ToString();
            amail = dt.Rows[0].ItemArray[1].ToString();
            amno = dt.Rows[0].ItemArray[2].ToString();
        }
        public bool ChkPswd()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select count(*) from VwAdminDetails where aid=@aid and apswd=hashbytes('SHA1',(@pswd+ cast(upid as nvarchar(36))))", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@pswd", apswd);
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
        public string UpdateProfile()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spadmindetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@maid", maid);
            cmd.Parameters.AddWithValue("@aname", aname);
            cmd.Parameters.AddWithValue("@email", amail);
            cmd.Parameters.AddWithValue("@mno", amno);
            cmd.Parameters.AddWithValue("@pswd", npswd);
            cmd.Parameters.AddWithValue("@isadmin", isadmin);
            cmd.Parameters.AddWithValue("@isactive", status);
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Parameters.AddWithValue("@remarks", remarks);
            con.Open();
            string msg = cmd.ExecuteScalar().ToString();
            con.Close();
            return msg;
        }
        public DataTable AdminData()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from VwAdminDetails", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public bool sendRegistermail()
        {
            try
            {
                using (MailMessage mailMessage = new MailMessage())
                {
                    MailMessage Msg = new MailMessage();
                    Msg.From = new MailAddress("info@nextdoorkitchen.in", "Next Door Kitchen");
                    // Recipient e-mail address.
                    Msg.To.Add(amail);
                    Msg.Subject = "Next Door Kitchen Admin Panel Login Details";
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

        private string EncryptString(object key, string etxt)
        {
            throw new NotImplementedException();
        }

        private AlternateView Mail_Body()
        {
            string path =HttpContext.Current.Server.MapPath("assets/images/logo.png");
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

            body += "New Login Details For Table Booking Admin Panel<br/><br/>Your Login Details Are <br/> Email-ID : " + amail + "<br/>New Password: " + apswd + "";
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
    }
}
