using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Configuration;
namespace NXTConnection
{
    public class ConnectionClass
    {
        public SqlConnection NXTConn()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["tblbookingConn"].ConnectionString);
            return con;
        }
    }
}
