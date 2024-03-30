using Oracle.ManagedDataAccess.Client;

namespace Customer.Data
{
    public class Connection
    {
        static OracleConnection con;
        public static OracleConnection GetConnection()
        {
            if (con == null)
            {
                con = new OracleConnection("Data Source = localhost:1521/XEPDB1; User id = CusUser; Password = Cus1234");
                con.Open();
            }
            return con;
        }
    }
}
