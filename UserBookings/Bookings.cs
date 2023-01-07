using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NXTConnection;
using System.Data;
using System.Data.SqlClient;
namespace UserBookings
{
    public class Bookings
    {
        ConnectionClass conn = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _ubookid;
        public int ubookid { get { return _ubookid; } set { _ubookid = value; } }
        public int _restid;
        public int restid { get { return _restid; } set { _restid = value; } }
        public int _tblid;
        public int tblid { get { return _tblid; } set { _tblid = value; } }
        public int _npersons;
        public int npersons { get { return _npersons; } set { _npersons = value; } }
        public string _bookdt;
        public string bookdt { get { return _bookdt; } set { _bookdt = value; } }
        public string _booktime;
        public string booktime { get { return _booktime; } set { _booktime = value; } }
        public string _ufname;
        public string ufname { get { return _ufname; } set { _ufname = value; } }
        public string _ulname;
        public string ulname { get { return _ulname; } set { _ulname = value; } }
        public string _ucpno;
        public string ucpno { get { return _ucpno; } set { _ucpno = value; } }
        public string _umailid;
        public string umailid { get { return _umailid; } set { _umailid = value; } }
        public string _company;
        public string company { get { return _company; } set { _company = value; } }
        public string _notes;
        public string notes { get { return _notes; } set { _notes = value; } }
        public string _specarrange;
        public string specarrange { get { return _specarrange; } set { _specarrange = value; } }
        public int _isterms;
        public int isterms { get { return _isterms; } set { _isterms = value; } }
        public int _isactive;
        public int isactive { get { return _isactive; } set { _isactive = value; } }
        public int _type;
        public int type { get { return _type; } set { _type = value; } }
        public string _view;
        public string view { get { return _view; } set { _view = value; } }
        public string _fromdate;
        public string fromdate { get { return _fromdate; } set { _fromdate = value; } }
        public string _todate;
        public string todate { get { return _todate; } set { _todate = value; } }
        public int _dtype;
        public int dtype { get { return _dtype; } set { _dtype = value; } }
        public string _keitmid;
        public string keitmid { get { return _keitmid; } set { _keitmid = value; } }
        public string _keqty;
        public string eqty { get { return _keqty; } set { _keqty = value; } }
        public string _keprice;
        public string eprice { get { return _keprice; } set { _keprice = value; } }
        public int _reqtype;
        public int reqtype { get { return _reqtype; } set { _reqtype = value; } }
        public bool manageBookings()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spmanage_userbooking", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ubookid", ubookid);
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@tblid", tblid);
            cmd.Parameters.AddWithValue("@npersons", npersons);
            cmd.Parameters.AddWithValue("@bookdt", bookdt);
            cmd.Parameters.AddWithValue("@booktime", booktime);
            cmd.Parameters.AddWithValue("@ufname", ufname);
            cmd.Parameters.AddWithValue("@ulname", ulname);
            cmd.Parameters.AddWithValue("@ucpno", ucpno);
            cmd.Parameters.AddWithValue("@umailid", umailid);
            cmd.Parameters.AddWithValue("@company", company);
            cmd.Parameters.AddWithValue("@notes", notes);
            cmd.Parameters.AddWithValue("@specarrange", specarrange);
            cmd.Parameters.AddWithValue("@isterms", isterms);
            cmd.Parameters.AddWithValue("@dtype", dtype);
            cmd.Parameters.AddWithValue("@keitmid", keitmid);
            cmd.Parameters.AddWithValue("@eqty", eqty);
            cmd.Parameters.AddWithValue("@eprice", eprice);
            cmd.Parameters.AddWithValue("@isactive", isactive);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            bool val = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return val;
        }
        public DataTable fetchBookings()
        {
            con = conn.NXTConn();
            string query = "select * from dbo.Vwfetch_userbookings where restid=@restid and dtype=@dtype ";
            if (fromdate != "" & todate != "")
            {
                query += " and convert(datetime,convert(varchar,convert(datetime,bookdt,103),103),103) between convert(datetime,@fdate,103) and convert(datetime,@tdate,103) ";
            }
            if (reqtype > 0)
            {
                query += " and reqtype=@reqtype ";
            }
            query += " order by bookdt ";
            cmd = new SqlCommand(query, con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@reqtype", reqtype);
            cmd.Parameters.AddWithValue("@fdate", fromdate);
            cmd.Parameters.AddWithValue("@tdate", todate);
            cmd.Parameters.AddWithValue("@dtype", dtype);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable fetchBookingTables()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.fnfetchbooktables(@restid,@seats,@dt,@time,@type)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@seats", npersons);
            cmd.Parameters.AddWithValue("@dt", bookdt);
            cmd.Parameters.AddWithValue("@time", booktime);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable fetchBookingSlots()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.fnfetch_restslots(@restid,@sstype,@datetime,@type)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@sstype", ubookid);
            cmd.Parameters.AddWithValue("@datetime", bookdt);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public DataTable fetchBookingTimings()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("select * from dbo.spfetch_foodtime(@time,@restid,@type)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@time", bookdt);
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public bool updateBookingStatus()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spupdate_bookingstat", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ubookid", ubookid);
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@status", isactive);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            bool chk = Convert.ToBoolean(cmd.ExecuteScalar());
            con.Close();
            return chk;
        }
    }
}
