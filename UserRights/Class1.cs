using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NXTConnection;
using System.Data.SqlClient;
using System.Data;
namespace UserRights
{
    public class Urights
    {
        ConnectionClass ccon = new ConnectionClass();
        SqlConnection con;
        DataTable dt;
        SqlCommand cmd;
        public int _hid;
        public int hid
        {
            get { return _hid; }
            set { _hid = value; }
        }

        public int _hsid;
        public int hsid
        {
            get { return _hsid; }
            set { _hsid = value; }
        }

        public int _aid;
        public int aid
        {
            get { return _aid; }
            set { _aid = value; }
        }
        public int _said;
        public int said
        {
            get { return _said; }
            set { _said = value; }
        }

        public int _type;
        public int type
        {
            get { return _type; }
            set { _type = value; }
        }
        public string _page;
        public string page
        {
            get { return _page; }
            set { _page = value; }
        }
        public DataTable dtheaders()
        {
            dt = new DataTable();
            con = ccon.NXTConn();
            cmd = new SqlCommand("select * from Vwheaders", con);
            con.Open();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable dtSubHeaders()
        {
            dt = new DataTable();
            con = ccon.NXTConn();
            cmd = new SqlCommand("select * from VwSubHeaders", con);
            con.Open();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable dtallottedHeaders()
        {
            dt = new DataTable();
            con = ccon.NXTConn();
            cmd = new SqlCommand("select * from VwAllotedRoles", con);
            con.Open();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public string AllotRights()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("spallotrights", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@hid", hid);
            cmd.Parameters.AddWithValue("@hsid", hsid);
            cmd.Parameters.AddWithValue("@aaid", said);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            string msg = cmd.ExecuteScalar().ToString();
            con.Close();
            return msg;
        }
        public DataTable menulist()
        {
            con = ccon.NXTConn();
            dt = new DataTable();
            cmd = new SqlCommand("select * from VwAllotedRoles where aid=@aid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            con.Open();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public bool checkuserformenu()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("select count(*) from VwAllotedRoles where lower((page)+'.aspx')=lower(@page) and aid=@aid and isactive=1", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@page", page);
            cmd.Parameters.AddWithValue("@aid", aid);
            con.Open();
            bool chkpage = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return chkpage;
        }
    }
}