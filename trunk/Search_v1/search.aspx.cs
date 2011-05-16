using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data;
using MySql.Web;
using MySql.Data.MySqlClient;
using MySql.Data.Types;
using System.Data;
using System.Data.SqlClient;

public partial class search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string searchString = TextBox2.Text;
        searchString = "%" + searchString.Replace('\'', ' ') + "%";
        string connectionString = "server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
        string sqlConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection mySqlConnection = new SqlConnection();
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
        DataSet dataSet = new DataSet();

        mySqlConnection.ConnectionString = sqlConnectionString;
        mySqlDataAdapter.SelectCommand = new SqlCommand("SELECT * FROM dish WHERE name Like '" + searchString + "'");// OR tags Like '" + searchString + "' OR info Like '" + searchString + "'");
        mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(sqlConnectionString);
        mySqlDataAdapter.Fill(dataSet);

        GridView1.DataSource = dataSet;
        GridView1.DataBind();
    }
protected void  GridView1_SelectedIndexChanged(object sender, EventArgs e)
{

}
protected void Button2_Click(object sender, EventArgs e)
{
    
}
    /*
    string connectionString = "Server=127.0.0.1;Database=online_foods;Uid=root";
    MySqlConnection mySqlConnection = new MySqlConnection(connectionString);
    mySqlConnection.Open();
    MySqlCommand mySqlCommand = new MySqlCommand("SELECT 'qwerty' AS 'dec'", mySqlConnection);
    MySqlDataReader mySqlDataReader = mySqlCommand.ExecuteReader();
    DataTable dataTable = new DataTable();
    dataTable.Columns.Add("dec", typeof(string));
    while (mySqlDataReader.Read())
    {
        dataTable.Rows.Add((string)mySqlDataReader["dec"]);
        //Label1.Text = (string)mySqlDataReader["dec"];
    }
    GridView2.DataSource = dataTable;
    GridView2.DataBind();
    */
protected void Button3_Click(object sender, EventArgs e)
{
    Panel1.Visible = false;
    Panel2.Visible = true;
}
protected void Button5_Click(object sender, EventArgs e)
{
    string searchStringA = TextBox13.Text;
    string searchStringB = TextBox14.Text;
    string searchStringC = TextBox15.Text;
    searchStringA = "%" + searchStringA.Replace('\'', ' ') + "%";
    searchStringB = "%" + searchStringB.Replace('\'', ' ') + "%";
    searchStringC = "%" + searchStringC.Replace('\'', ' ') + "%";
    string connectionString = "server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
    string sqlConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
    SqlConnection mySqlConnection = new SqlConnection();
    SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
    DataSet dataSet = new DataSet();

    mySqlConnection.ConnectionString = sqlConnectionString;
    mySqlDataAdapter.SelectCommand = new SqlCommand(@"
        SELECT * 
        FROM dish
        WHERE name Like '" + searchStringA + "'" + "AND " +
        "info Like '" + searchStringB + "'" + "AND " +
        "tags Like '" + searchStringC + "'");
    mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(connectionString);
    mySqlDataAdapter.Fill(dataSet);

    GridView1.DataSource = dataSet;
    GridView1.DataBind();
}
}