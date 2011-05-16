using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Xml.Linq;
using System.Data.SqlClient;
using MySql.Data;
using MySql.Data.MySqlClient;
using TreeViewBinding;

namespace Mega_shop_mysql3
{
    public partial class _Default : System.Web.UI.Page
    {
        private DataSet GetDataSet()
        {
            string mySQLConnectionString = @"Server=localhost;Database=online_foods;Uid=root;Pwd=;";
            string localBaseConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
            string sql = "SELECT * FROM dish_groups";
            using (SqlConnection mySQLConnection = new SqlConnection())
            {
                mySQLConnection.ConnectionString = mySQLConnectionString;
                using (SqlCommand Command = new SqlCommand(sql, mySQLConnection))
                {
                    mySQLConnection.Open();
                    using (SqlDataReader myReader = Command.ExecuteReader())
                    {
                        DataTable table = new DataTable();
                        DataSet dataSet = new DataSet();
                        table.Load(myReader);
                        dataSet.Tables.Add(table);
                        mySQLConnection.Close();
                        return dataSet;
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        //

        //
    }
}