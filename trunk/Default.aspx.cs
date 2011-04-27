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
        protected System.Web.UI.WebControls.TreeView DishGroupstvControl;
        protected void GroupsTreeView_Load(object sender, EventArgs e)
        {

        }
        //
        private string mySQLConnectionString = @"Server=localhost;Database=online_foods;Uid=root;Pwd=;";
        private DataSet GetDataSet()
        {
            string sql = "SELECT * FROM dish_groups";
            using (MySqlConnection mySQLConnection = new MySqlConnection())
            {
                mySQLConnection.ConnectionString = mySQLConnectionString;
                using (MySqlCommand Command = new MySqlCommand(sql, mySQLConnection))
                {
                    mySQLConnection.Open();
                    using (MySqlDataReader myReader = Command.ExecuteReader())
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
            String[] request = Request.QueryString.AllKeys;
            DishGroupstvControl = new TreeView();
            TreeNodeBinding nodeBinding = new TreeNodeBinding();
            nodeBinding.DataMember = "System.Data.DataRowView";
            nodeBinding.TextField = "name";
            nodeBinding.ValueField = "id_dish_group";
            DishGroupstvControl.ID = "DishGroupTreeView";
            DishGroupstvControl.DataBindings.Add(nodeBinding);
            DishGroupstvControl.DataSource = new HierarchicalDataSet(GetDataSet(), "id_dish_group", "id_owner_group");
            DishGroupstvControl.DataBind();
            this.Controls.Add(DishGroupstvControl);
            Console.Write("!");
        }
    }
}
