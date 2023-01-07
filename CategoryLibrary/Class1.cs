using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using NXTConnection;
namespace CategoryLibrary
{
    public class CategoryClass
    {
        ConnectionClass ccon = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _cid;
        public int cid
        {
            get { return _cid; }
            set { _cid = value; }
        }

        public int _aid;
        public int aid
        {
            get { return _aid; }
            set { _aid = value; }
        }

        public string _category;
        public string category
        {
            get { return _category; }
            set { _category = value; }
        }
        public string _foodimage;
        public string foodimage
        {
            get { return _foodimage; }
            set { _foodimage = value; }
        }
        public string _remarks;
        public string remarks
        {
            get { return _remarks; }
            set { _remarks = value; }
        }
        public int _status;
        public int status
        {
            get { return _status; }
            set { _status = value; }
        }
        public int _restid;
        public int restid
        {
            get { return _restid; }
            set { _restid = value; }
        }
        public int _type;
        public int type
        {
            get { return _type; }
            set { _type = value; }
        }

        public string AddCategory()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("dbo.spfoodcategory", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@cid", cid);
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@fcategory", category);
            cmd.Parameters.AddWithValue("@remarks", remarks);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            string msg = cmd.ExecuteScalar().ToString();
            con.Close();
            return msg;
        }
        public DataTable getCategoryData()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("select * from VwfoodCategory where restid=@restid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public string AddFoodType()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("dbo.spfoodtype", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ftid", cid);
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@restid", restid);
            cmd.Parameters.AddWithValue("@ftype", category);
            cmd.Parameters.AddWithValue("@foodimg", foodimage);
            cmd.Parameters.AddWithValue("@remarks", remarks);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            string msg = cmd.ExecuteScalar().ToString();
            con.Close();
            return msg;
        }
        public DataTable getFoodType()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("select * from Vwfoodtype where restid=@restid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@restid", restid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        public Random random = new Random();

        public string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}
