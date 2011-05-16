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

public partial class sklad : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ListBox1.Visible = false;
        string connectionString = "server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
        string localBaseConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection sqlConnection = new SqlConnection();
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
        DataSet dataSet = new DataSet();

        sqlConnection.ConnectionString = localBaseConnectionString;
        mySqlDataAdapter.SelectCommand = new SqlCommand("SELECT * FROM Goods");
        mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(connectionString);
        mySqlDataAdapter.Fill(dataSet);

        GridView1.DataSource = dataSet;
        GridView1.DataBind();
        Button1.Text += "!";
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        ListBox1.Visible = false;
        string connectionString = "server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
        string localBaseConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection mySqlConnection = new SqlConnection();
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
        DataSet dataSet = new DataSet();

        mySqlConnection.ConnectionString = localBaseConnectionString;
        mySqlDataAdapter.SelectCommand = new SqlCommand("SELECT * FROM SalesOperations");
        mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(connectionString);
        mySqlDataAdapter.Fill(dataSet);

        GridView1.DataSource = dataSet;
        GridView1.DataBind();
        Button2.Text += "!";
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Button1.Text = "work";
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        ListBox1.Visible = true;
        string connectionString = "server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
        string localBaseConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection mySqlConnection = new SqlConnection();
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
        DataSet dataSet = new DataSet();
        DataSet dataSet2 = new DataSet();

        mySqlConnection.ConnectionString = localBaseConnectionString;
        mySqlDataAdapter.SelectCommand = new SqlCommand("SELECT so_id FROM SalesOperations");
        mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(connectionString);
        mySqlDataAdapter.Fill(dataSet);

        ListBox1.DataSource = dataSet;
        ListBox1.DataTextField = "so_id";
        ListBox1.DataBind();
        ListBox1.SelectedIndex = 0;

        mySqlDataAdapter.SelectCommand = new SqlCommand("SELECT * FROM GoodsSales WHERE gs_so_id=" + ListBox1.SelectedItem.Value);
        mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(localBaseConnectionString);
        mySqlDataAdapter.Fill(dataSet2);
        GridView1.DataSource = dataSet2;
        GridView1.DataBind();

        Button3.Text += "!";
    }
    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string connectionString = "server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
        string localBaseConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection mySqlConnection = new SqlConnection();
        SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter();
        DataSet dataSet2 = new DataSet();

        mySqlDataAdapter.SelectCommand = new SqlCommand("SELECT * FROM GoodsSales WHERE gs_so_id=" + ListBox1.SelectedItem.Value);
        mySqlDataAdapter.SelectCommand.Connection = new SqlConnection(localBaseConnectionString);
        mySqlDataAdapter.Fill(dataSet2);
        GridView1.DataSource = dataSet2;
        GridView1.DataBind();

        Button3.Text += "+";
    }
}