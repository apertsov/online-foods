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

/// <summary>
/// Summary description for TreeViewControl
/// </summary>
namespace TreeViewBinding
{
    public partial class DishGroupsTreeView : UserControl
    {
        private string mySQLConnectionString = @"Server=195.182.193.226;port=3306;Database=online_foods;uid=UserKon;pwd=qwerty;";
        private string sqlConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        //
        private DataSet GetDataSet()
        {
            string sql = "SELECT * FROM dish_groups";
            using (SqlConnection mySQLConnection = new SqlConnection())
            {
                mySQLConnection.ConnectionString = sqlConnectionString;
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
        //
        private void SetRecNavigationUrl(TreeNodeCollection childNodes)
        {
            foreach (TreeNode node in childNodes)
            {
                node.NavigateUrl = @"javascript:getInfo(" + node.Value + ")";
                SetRecNavigationUrl(node.ChildNodes);
            }
        }
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            TreeView TreeViewLists = new TreeView();
            TreeNodeBinding nodeBinding = new TreeNodeBinding();
            nodeBinding.DataMember = "System.Data.DataRowView";
            nodeBinding.TextField = "name";
            nodeBinding.ValueField = "id_dish_group";
            TreeViewLists.ID = "DishGroupTreeView";
            //onselectednodechanged="DishTreeView_SelectedNodeChanged"
            string clickHandler = "DishGroupClick();";
            TreeViewLists.Attributes.Add("onselectednodechanged",
                                                      clickHandler);

            clickHandler = "TVNodeExpand();";
            TreeViewLists.Attributes.Add("onexpand",
                                           clickHandler);

            TreeViewLists.DataBindings.Add(nodeBinding);
            TreeViewLists.DataSource = new HierarchicalDataSet(GetDataSet(), "id_dish_group", "id_owner_group");
            TreeViewLists.DataBind();
            SetRecNavigationUrl(TreeViewLists.Nodes);
            this.Controls.Add(TreeViewLists);
        }
        private void OverRideServerEvents()
        {
            // Create and wire up the javascript event handlers.
            //
           
        }
    }
}