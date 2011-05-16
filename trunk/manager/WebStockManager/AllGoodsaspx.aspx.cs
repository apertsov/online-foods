using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AllGoodsaspx : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
            CommunicationService.Good[] goods = client.GetGoods();
            DataTable dt = new DataTable();
            if (goods != null)
            {
                
                dt.Columns.Add(new DataColumn("Good id", typeof(string)));
                dt.Columns.Add(new DataColumn("Name", typeof(string)));
                dt.Columns.Add(new DataColumn("Count", typeof(string)));
                dt.Columns.Add(new DataColumn("Price", typeof(string)));
                for(Int32 i=0;i<goods.Length;i++)
                {
                    DataRow row = null;
                    row = dt.NewRow();
                    row["Good id"] = goods[i].Id;
                    row["Name"] = goods[i].Name;
                    row["Count"] = goods[i].Count;
                    row["Price"] = goods[i].Price;
                    dt.Rows.Add(row);
                }
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();

            Label1.Text = "Current date: " + DateTime.Now.Date.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToShortTimeString();
            LinkButton2_Click(this, new EventArgs());
            LinkButton4_Click(this, new EventArgs());
        }
        Timer1.Enabled = true;
    }



    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chb = row.FindControl("CheckBox1") as CheckBox;
            chb.Checked = !chb.Checked;
            UpdatePanel1.Update();
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = sender as LinkButton;
        DataControlFieldCell cell = (DataControlFieldCell)lbtn.Parent;
        GridViewRow row = (GridViewRow)cell.Parent;

        Label6.Text = row.Cells[2].Text;
        TextBox1.Text = row.Cells[3].Text;
        Label7.Text = row.Cells[4].Text;
        TextBox2.Text = row.Cells[5].Text;

        Label2.Visible = true;
        Label3.Visible = true;
        Label4.Visible = true;
        Label5.Visible = true;
        Label6.Visible = true;
        Label7.Visible = true;
        TextBox1.Visible = true;
        TextBox2.Visible = true;
        Confirm.Visible = true;
        Label8.Visible = true;
        LinkButton2.Visible = true;
        UpdatePanel2.Update();
      
    }
    protected void Confirm_Click(object sender, EventArgs e)
    {
        CommunicationService.Good good = new CommunicationService.Good();
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();

        good.Id = Label6.Text;
        good.Name = TextBox1.Text;
        good.Count = Label7.Text;
        good.Price = TextBox2.Text;

        client.ChangeGood(good);

        LinkButton2_Click(this, new EventArgs());

        Timer1_Tick(this, new EventArgs());

    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Label2.Visible = false;
        Label3.Visible = false;
        Label4.Visible = false;
        Label5.Visible = false;
        Label6.Visible = false;
        Label7.Visible = false;
        Label8.Visible = false;
        TextBox1.Visible = false;
        TextBox2.Visible = false;
        Confirm.Visible = false;
        LinkButton2.Visible = false;
        UpdatePanel2.Update();
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Good[] goods = client.GetGoods();
        DataTable dt = new DataTable();
        if (goods != null)
        {

            dt.Columns.Add(new DataColumn("Good id", typeof(string)));
            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Count", typeof(string)));
            dt.Columns.Add(new DataColumn("Price", typeof(string)));
            for (Int32 i = 0; i < goods.Length; i++)
            {
                DataRow row = null;
                row = dt.NewRow();
                row["Good id"] = goods[i].Id;
                row["Name"] = goods[i].Name;
                row["Count"] = goods[i].Count;
                row["Price"] = goods[i].Price;
                dt.Rows.Add(row);
            }
        }

        GridView1.DataSource = dt;
        GridView1.DataBind();

        Label1.Text = "Current date: " + DateTime.Now.Date.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToShortTimeString();
        LinkButton2_Click(this, new EventArgs());
        LinkButton4_Click(this, new EventArgs());
        UpdatePanel1.Update();
    }

    protected void LinkButton3_Click(object sender, EventArgs e)
    {
       
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Good id", typeof(string)));
        dt.Columns.Add(new DataColumn("Name", typeof(string)));
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chb = row.FindControl("CheckBox1") as CheckBox;
            if (chb.Checked)
            {
                DataRow row1 = null;
                row1 = dt.NewRow();
                row1["Good id"] = row.Cells[2].Text;
                row1["Name"] = row.Cells[3].Text;
                dt.Rows.Add(row1);
            }
        }
        GridView2.DataSource = dt;
        GridView2.DataBind();

        Label9.Visible = true;
        Purchase.Visible = true;
        GridView2.Visible = true;
        LinkButton4.Visible = true;
        UpdatePanel3.Update();
    }
    protected void Purchase_Click(object sender, EventArgs e)
    {
       CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
       foreach (GridViewRow row in GridView2.Rows)
       {
           client.BuyGoods(row.Cells[1].Text, ((TextBox)row.Cells[0].FindControl("TextBox3")).Text);
       }
        
       Timer1_Tick(this, new EventArgs());

        
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        Label9.Visible = false;
        Purchase.Visible = false;
        GridView2.Visible = false;
        LinkButton4.Visible = false;
    }
}