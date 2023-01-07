using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NXTConnection;
using System.Data.SqlClient;
using System.Data;
namespace RestaurantTables
{
    public class Tables
    {
        ConnectionClass conn = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _tblid;
        public int tblid { get { return _tblid; } set { _tblid = value; } }
        public int _restid;
        public int restid { get { return _restid; } set { _restid = value; } }
        public string _tblname;
        public string tblname { get { return _tblname; } set { _tblname = value; } }
        public string _tblalias;
        public string tblalias { get { return _tblalias; } set { _tblalias = value; } }
        public int _viewid;
        public int viewid { get { return _viewid; } set { _viewid = value; } }
        public int _seats;
        public int seats { get { return _seats; } set { _seats = value; } }
        public int _capping;
        public int capping { get { return _capping; } set { _capping = value; } }
        public string _remarks;
        public string remarks { get { return _remarks; } set { _remarks = value; } }
        public int _isactive;
        public int isactive { get { return _isactive; } set { _isactive = value; } }
        public int _type;
        public int type { get { return _type; } set { _type = value; } }

        public bool manageRestTables()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spmanage_resttables", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@tblid", tblid);
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@tblname", tblname);
            cmd.Parameters.AddWithValue("@tblalias", tblalias);
            cmd.Parameters.AddWithValue("@viewid", viewid);
            cmd.Parameters.AddWithValue("@seats", seats);
            cmd.Parameters.AddWithValue("@capping", capping);
            cmd.Parameters.AddWithValue("@remarks", remarks);
            cmd.Parameters.AddWithValue("@isactive", isactive);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            bool msg = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return msg;
        }
        public DataTable fetchTables()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.Vwrest_tables where restid=@restid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public int getTblid()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select dbo.fntblid(@restid)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            con.Open();
            int id = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
            return id;
        }
        public string manageViews()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spinsert_restviews", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@vwname", tblalias);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            string msg = cmd.ExecuteScalar().ToString();
            con.Close();
            return msg;
        }
        public DataTable fetchViews()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from Vwrest_Views where restid=@restid order by vwname", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
    }
}
