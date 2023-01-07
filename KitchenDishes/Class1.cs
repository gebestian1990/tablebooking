using NXTConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace KitchenDishes
{
    public class kDishes
    {

        ConnectionClass conn = new ConnectionClass();
        SqlConnection con;
        SqlCommand cmd;
        DataTable dt;
        public int _kitmid;
        public int kitmid
        {
            get { return _kitmid; }
            set { _kitmid = value; }
        }
        public int _kid;
        public int kid
        {
            get { return _kid; }
            set { _kid = value; }
        }
        public int _foodcategory;
        public int foodcategory
        {
            get { return _foodcategory; }
            set { _foodcategory = value; }
        }
        public int _foodtype;
        public int foodtype
        {
            get { return _foodtype; }
            set { _foodtype = value; }
        }
        public string _title;
        public string title
        {
            get { return _title; }
            set { _title = value; }
        }
        public string _itemimg;
        public string itemimg
        {
            get { return _itemimg; }
            set { _itemimg = value; }
        }
        public string _description;
        public string description
        {
            get { return _description; }
            set { _description = value; }
        }
        public decimal _price;
        public decimal price
        {
            get { return _price; }
            set { _price = value; }
        }
        public decimal _disptice;
        public decimal disprice
        {
            get { return _disptice; }
            set { _disptice = value; }
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
        public List<string> ManageKitchenItems()
        {
            con = conn.NXTConn();
            cmd = new SqlCommand("dbo.spmanage_kitchenitems", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@kitmid", kitmid);
            cmd.Parameters.AddWithValue("@kid", kid);
            cmd.Parameters.AddWithValue("@catid", foodcategory);
            cmd.Parameters.AddWithValue("@ftype", foodtype);
            cmd.Parameters.AddWithValue("@itemname", title);
            cmd.Parameters.AddWithValue("@fimg", itemimg);
            cmd.Parameters.AddWithValue("@descp", description);
            cmd.Parameters.AddWithValue("@price", price);
            cmd.Parameters.AddWithValue("@disprice", disprice);
            cmd.Parameters.AddWithValue("@stat", status);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            List<string> rdata = new List<string>();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                rdata.Add(dt.Rows[0].ItemArray[i].ToString());
            }
            return rdata;
        }
        public DataTable KitchemItemsData()
        {
            con = conn.NXTConn();
            string query = "select * from Vwkitchenitems where kid=@kid and isactive<2 ";
            if (title != "")
            {
                query += " and itemname like '%'+@title+'%' ";
            }
            if (foodcategory > 0)
            {
                query += "and catid=@catid ";
            }
            if (foodtype > 0)
            {
                query += " and ftype=@ftype ";
            }
            if (kitmid > 0)
            {
                query += " and kitmid=@kitmid ";
            }
            query += " order by itemname ";
            cmd = new SqlCommand(query, con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@title", title);
            cmd.Parameters.AddWithValue("@catid", foodcategory);
            cmd.Parameters.AddWithValue("@ftype", foodtype);
            cmd.Parameters.AddWithValue("@kid", kid);
            cmd.Parameters.AddWithValue("@kitmid", kitmid);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
    }
}
