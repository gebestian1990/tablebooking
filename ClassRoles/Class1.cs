using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NXTConnection;
using System.Data.SqlClient;
using System.Data;

namespace ClassRoles
{
    public class ARoles
    {
        ConnectionClass ccon = new ConnectionClass();
        SqlCommand cmd;
        SqlConnection con;
        DataTable dt;
        public int _rid;
        public int rid
        {
            get { return _rid; }
            set { _rid = value; }
        }

        public int _aid;
        public int aid
        {
            get { return _aid; }
            set { _aid = value; }
        }

        public string _roll;
        public string roll
        {
            get { return _roll; }
            set { _roll = value; }
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
        public int _type;
        public int type
        {
            get { return _type; }
            set { _type = value; }
        }

        public string AddRoll()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("dbo.spadminroles", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@rid", rid);
            cmd.Parameters.AddWithValue("@aid", aid);
            cmd.Parameters.AddWithValue("@roll", roll);
            cmd.Parameters.AddWithValue("@remarks", remarks);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@type", type);
            con.Open();
            string msg = cmd.ExecuteScalar().ToString();
            con.Close();
            return msg;
        }
        public DataTable getRollData()
        {
            con = ccon.NXTConn();
            cmd = new SqlCommand("select * from VwRoles", con);
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
    }
}
