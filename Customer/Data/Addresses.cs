using Customer.Data.Model;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Windows.Forms;

namespace Customer.Data
{
    public class Addresses
    {
        public static DataTable Get(int customerId)
        {
            OracleCommand cmd = new OracleCommand("AddressGet", Connection.GetConnection());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("P_CustomerId", customerId);
            DataTable dt = new DataTable();
            OracleDataAdapter adapter = new OracleDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }
        public static void Add(Address address)
        {
            try
            {

                OracleCommand cmd = new OracleCommand("AddressAdd", Connection.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("P_CustomerId", address.CustomerId);
                cmd.Parameters.Add("P_AddressName", address.AddressName);
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }
        public static void Delete(int id)
        {
            try
            {

                OracleCommand cmd = new OracleCommand("AddressDelete", Connection.GetConnection());
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("P_CustomerId", id);
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }
    }
}
