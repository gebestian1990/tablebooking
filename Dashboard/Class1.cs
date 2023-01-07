using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using NXTConnection;
using System.Collections;
namespace Dashboard
{
    public class DashboardLinks
    {
        ConnectionClass ccon = new ConnectionClass();
        SqlConnection con;
        DataTable dt;
        SqlCommand cmd;
        ArrayList dashvalues;
        public int _aid;
        public int aid
        {
            get { return _aid; }
            set { _aid = value; }
        }
        public int _type;
        public int type
        {
            get { return _type; }
            set { _type = value; }
        }
        public ArrayList GetDashboard()
        {
            con = ccon.NXTConn();
            dashvalues = new ArrayList();
            cmd = new SqlCommand("select * from dbo.fndashboard(@aid,@type)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                dashvalues.Add(dt.Rows[0].ItemArray[i]);
            }
            return dashvalues;
        }
        public ArrayList KitchenDashboard()
        {
            con = ccon.NXTConn();
            string date = DateTime.Now.ToString("dd/MM/yyyy");
            dashvalues = new ArrayList();
            cmd = new SqlCommand("select * from dbo.fnkitchendashboard(@kit,@type,@date)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@kit", aid);
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Parameters.AddWithValue("@date", date);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                dashvalues.Add(dt.Rows[0].ItemArray[i]);
            }
            return dashvalues;
        }
    }
}