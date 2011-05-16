using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class manager_Default : System.Web.UI.Page
{
    
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlDataSource1.InsertParameters["name"].DefaultValue = TextBox1.Text;
        SqlDataSource1.InsertParameters["time"].DefaultValue = TextBox2.Text;
        SqlDataSource1.InsertParameters["info"].DefaultValue = TextBox3.Text;
        SqlDataSource1.InsertParameters["tags"].DefaultValue = TextBox4.Text;
        SqlDataSource1.InsertParameters["receipt"].DefaultValue = TextBox5.Text;
        SqlDataSource1.Insert();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Button4.Visible = true;
        Button2.Visible = false;
        ListBox1.Visible = false;
        GridView2.Visible = false;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        GridViewRow row = GridView1.SelectedRow;
        
        foreach (ListItem li in ListBox1.Items)
        {
            if (li.Selected == true)
            {
                SqlDataSource2.InsertParameters["id_dish"].DefaultValue = row.Cells[0].Text;
                SqlDataSource2.InsertParameters["id_ingredient"].DefaultValue = li.Value.ToString();
                SqlDataSource2.Insert();
            }
        }
        Label2.Text = "тадам!!!";
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
       // Response.Redirect("CorrectIngredients.aspx", false);
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        Label2.Text = "тадам!!!";
        Button2.Visible = true;
        ListBox1.Visible = true;
        GridView2.Visible = true;

        GridViewRow row = GridView1.SelectedRow;

        SqlDataSource3.SelectParameters["i"].DefaultValue = row.Cells[0].Text;
        SqlDataSource3.Select(DataSourceSelectArguments.Empty);
    }
}