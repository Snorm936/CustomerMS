using Customer.Data.Model;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Windows.Forms;

namespace Customer.Data
{
    public class Customers
    {

        public static DataTable GetAll()
        {
            OracleCommand cmd = new OracleCommand("CustomerGet", Connection.GetConnection());
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            OracleDataAdapter adapter = new OracleDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public static Model.Customer Get(int customerId)
        {
            Model.Customer customer = null;
            OracleCommand cmd = new OracleCommand("CustomerGet", Connection.GetConnection());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("P_CustomerId", customerId);
            OracleDataReader reader = cmd.ExecuteReader();
            if(reader.Read())
            {
                customer = new Model.Customer();
                customer.CustomerId = Convert.ToInt32(reader["CustomerId"].ToString());
                customer.Ishidden = Convert.ToInt32(reader["Ishidden"].ToString());
                customer.CustomerName = reader["CustomerName"].ToString();
                customer.Sex = Convert.ToChar(reader["Sex"].ToString()); 
                customer.DOB = Convert.ToDateTime(reader["DOB"].ToString());
                customer.POB = reader["POB"].ToString();
                customer.Phone = reader["Phone"].ToString();
                customer.Email = reader["Email"].ToString();
            }
            return customer; 
        }

        public static int Add(Model.Customer customer)
        {
            int id = 0;
            try
            {

                OracleCommand cmd = new OracleCommand("CustomerAdd", Connection.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("P_CustomerName", customer.CustomerName);
                cmd.Parameters.Add("P_Sex", customer.Sex);
                cmd.Parameters.Add("P_DOB", customer.DOB);
                cmd.Parameters.Add("P_POB", customer.POB);
                cmd.Parameters.Add("P_Phone", customer.Phone);
                cmd.Parameters.Add("P_Email", customer.Email);
                cmd.Parameters.Add("P_CustomerId", OracleDbType.Int32).Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                id = Convert.ToInt32(cmd.Parameters["P_CustomerId"].Value.ToString());

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            return id;

        }

        public static void Update(Model.Customer customer)
        {
            try
            {
                OracleCommand cmd = new OracleCommand("CustomerUpdate", Connection.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("P_CustomerId", customer.CustomerId);
                cmd.Parameters.Add("P_Ishidden", customer.Ishidden);
                cmd.Parameters.Add("P_CustomerName", customer.CustomerName);
                cmd.Parameters.Add("P_Sex", customer.Sex);
                cmd.Parameters.Add("P_DOB", customer.DOB);
                cmd.Parameters.Add("P_POB", customer.POB);
                cmd.Parameters.Add("P_Phone", customer.Phone);
                cmd.Parameters.Add("P_Email", customer.Email);
                cmd.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        public static void Delete(int CustomerId)
        {
            try
            {
                OracleCommand cmd = new OracleCommand("CustomerDelete", Connection.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("P_CustomerId", CustomerId);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

    }
}
