using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NXTConnection;
using System.Data.SqlClient;
using System.Data;
namespace RestaurantSlots
{
    public class Slots
    {
        ConnectionClass conn = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _restid;
        public int restid { get { return _restid; } set { _restid = value; } }
        public int _stype;
        public int stype { get { return _stype; } set { _stype = value; } }
        public string _soopentime;
        public string soopentime { get { return _soopentime; } set { _soopentime = value; } }
        public string _sclose;
        public string sclose { get { return _sclose; } set { _sclose = value; } }
        public string _sdiff;
        public string sdiff { get { return _sdiff; } set { _sdiff = value; } }
        public int _isactive;
        public int isactive { get { return _isactive; } set { _isactive = value; } }
        public int _type;
        public int type { get { return _type; } set { _type = value; } }
        public int _dtype;
        public int dtype { get { return _dtype; } set { _dtype = value; } }

        public bool manageRestSlots()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spmanage_restslots", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@stype", stype);
            cmd.Parameters.AddWithValue("@soopentime", soopentime);
            cmd.Parameters.AddWithValue("@sclose", sclose);
            cmd.Parameters.AddWithValue("@sdiff", sdiff);
            cmd.Parameters.AddWithValue("@isactive", isactive);
            cmd.Parameters.AddWithValue("@dtype", dtype);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            bool val = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return val;
        }
        public DataTable fetchslotDetails()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.Vwrestslotdetails where restid=@restid and dtype=@dtype", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@dtype", dtype);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable fetchDeviveryOptions()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.fngetdeloptions(@restid,@time)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@time", sclose);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
    }
}
