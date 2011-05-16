using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class CashRagistry : System.Web.UI.Page
{

    private DataTable ShowSpent(String beginDate, String endDate)
    {

        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Good[] good = client.GetSpentMoney(endDate, beginDate);
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Id Good", typeof(string)));
        dt.Columns.Add(new DataColumn("Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Count", typeof(string)));
        dt.Columns.Add(new DataColumn("Price", typeof(string)));
        dt.Columns.Add(new DataColumn("Date", typeof(string)));
        if (good != null)
        {
            for (Int32 i = 0; i < good.Length; i++)
            {
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Id Good"] = good[i].Id;
                dr["Name"] = good[i].Name;
                dr["Count"] = good[i].Count;
                dr["Price"] = good[i].Price;
                dr["Date"] = good[i].Date;
                dt.Rows.Add(dr);

            }
            return dt;
        }
        return dt;
    }

    private DataTable ShowRecieved(String beginDate, String endDate)
    {

        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Order[] or = client.GetRecievedMoney(endDate, beginDate);
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Id Order", typeof(string)));
        dt.Columns.Add(new DataColumn("Address", typeof(string)));
        dt.Columns.Add(new DataColumn("Phone", typeof(string)));
        dt.Columns.Add(new DataColumn("Order Date", typeof(string)));
        dt.Columns.Add(new DataColumn("Execution Date", typeof(string)));
        dt.Columns.Add(new DataColumn("Execution Time", typeof(string)));
        dt.Columns.Add(new DataColumn("Order Discount", typeof(string)));
        dt.Columns.Add(new DataColumn("Order Sum", typeof(string)));
        dt.Columns.Add(new DataColumn("Info", typeof(string)));
        dt.Columns.Add(new DataColumn("State", typeof(string)));
        dt.Columns.Add(new DataColumn("Prep Time", typeof(string)));
        if (or != null)
        {
            for (Int32 i = 0; i < or.Length; i++)
            {
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Id Order"] = or[i].IdOrder;
                dr["Address"] = or[i].Addres;
                dr["Phone"] = or[i].Phone;
                dr["Order Date"] = or[i].OrderDate;
                dr["Execution Date"] = or[i].ExecutionDate;
                dr["Execution Time"] = or[i].ExecutionTime;
                dr["Order Discount"] = or[i].OrderDiscount;
                dr["Order Sum"] = or[i].OrderSum;
                dr["Info"] = or[i].Info;
                String st = "";
                switch (or[i].State)
                {
                    case "0": st = "Awaiting"; break;
                    case "1": st = "Accepted"; break;
                    case "2": st = "Getting Ready"; break;
                    case "3": st = "Sent"; break;
                    case "-1": st = "Refused"; break;
                }
                dr["State"] = st;
                dr["Prep Time"] = or[i].PreparationTime;
                dt.Rows.Add(dr);

            }
            return dt;
        }
        return dt;
    }

    private DataTable ShowLost(String beginDate, String endDate)
    {

        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Order[] or = client.GetLostMoney(endDate, beginDate);
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Id Order", typeof(string)));
        dt.Columns.Add(new DataColumn("Address", typeof(string)));
        dt.Columns.Add(new DataColumn("Phone", typeof(string)));
        dt.Columns.Add(new DataColumn("Order Date", typeof(string)));
        dt.Columns.Add(new DataColumn("Execution Date", typeof(string)));
        dt.Columns.Add(new DataColumn("Execution Time", typeof(string)));
        dt.Columns.Add(new DataColumn("Order Discount", typeof(string)));
        dt.Columns.Add(new DataColumn("Order Sum", typeof(string)));
        dt.Columns.Add(new DataColumn("Info", typeof(string)));
        dt.Columns.Add(new DataColumn("State", typeof(string)));
        dt.Columns.Add(new DataColumn("Prep Time", typeof(string)));
        if (or != null)
        {
            for (Int32 i = 0; i < or.Length; i++)
            {
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Id Order"] = or[i].IdOrder;
                dr["Address"] = or[i].Addres;
                dr["Phone"] = or[i].Phone;
                dr["Order Date"] = or[i].OrderDate;
                dr["Execution Date"] = or[i].ExecutionDate;
                dr["Execution Time"] = or[i].ExecutionTime;
                dr["Order Discount"] = or[i].OrderDiscount;
                dr["Order Sum"] = or[i].OrderSum;
                dr["Info"] = or[i].Info;
                String st = "";
                switch (or[i].State)
                {
                    case "0": st = "Awaiting"; break;
                    case "1": st = "Accepted"; break;
                    case "2": st = "Getting Ready"; break;
                    case "3": st = "Sent"; break;
                    case "-1": st = "Refused"; break;
                }
                dr["State"] = st;
                dr["Prep Time"] = or[i].PreparationTime;
                dt.Rows.Add(dr);

            }
            return dt;
        }
        return dt;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Label1.Text = "Current date: " + DateTime.Now.Date.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToShortTimeString();

            

            String period = DropDownList1.SelectedItem.Text;
            String beginDate = "", endDate = "";
            switch (period)
            {
                case "Daily": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    break;
                case "Weekly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(7, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Monthly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(30, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Yearly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(356, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
            }

            DataTable dt = ShowSpent(beginDate, endDate);
            ViewState["spent"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();

            dt = ShowRecieved(beginDate, endDate);
            ViewState["recieved"] = dt;
            GridView2.DataSource = dt;
            GridView2.DataBind();

            dt = ShowLost(beginDate, endDate);
            ViewState["lost"] = dt;
            GridView3.DataSource = dt;
            GridView3.DataBind();

            Label7.Visible = false; 
            Label8.Visible = false;
            Label9.Visible = false;

            GridView4.Visible = false;
            GridView5.Visible = false;
            GridView6.Visible = false;

            Label10.Visible = false;

        }
        
        Timer1.Enabled = true;
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        Label1.Text = "Current date: " + DateTime.Now.Date.ToString("yyyy-MM-dd") + " " + DateTime.Now.ToShortTimeString();
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        String beginDate = "", endDate = "";
        beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
        endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");

        CommunicationService.Good[] goods = client.GetSpentMoney(endDate, beginDate);
        CommunicationService.Order[] orR = client.GetRecievedMoney(endDate, beginDate);
        CommunicationService.Order[] orL = client.GetLostMoney(endDate, beginDate);

        if (goods != null) 
        if(goods.Length!=((DataTable)ViewState["spent"]).Rows.Count)
            if (Label10.Visible == false)
            {
                Label10.Text = "New Spent money!";
                Label10.Visible = true;
                UpdatePanel7.Update();
            }
            else
            {
                Label10.Text += "  New Spent money!";
                UpdatePanel7.Update();
            }
        if(orR!=null)
        if (orR.Length != ((DataTable)ViewState["recieved"]).Rows.Count)
            if (Label10.Visible == false)
            {
                Label10.Text = "New Recieved money!";
                Label10.Visible = true;
                UpdatePanel7.Update();
            }
            else
            {
                Label10.Text += "  New Recieved money!";
                UpdatePanel7.Update();
            }
        if (orL != null) 
        if (orL.Length != ((DataTable)ViewState["lost"]).Rows.Count)
            if (Label10.Visible == false)
            {
                Label10.Text = "New Lost money!";
                Label10.Visible = true;
                UpdatePanel7.Update();
            }
            else
            {
                Label10.Text += "  New Lost money!";
                UpdatePanel7.Update();
            }


        UpdatePanel7.Update();
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        TextBox1.Text = "";
        TextBox2.Text = "";
        UpdatePanel1.Update();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        TextBox3.Text = "";
        TextBox4.Text = "";
        UpdatePanel2.Update();
    }
    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        TextBox5.Text = "";
        TextBox6.Text = "";
        UpdatePanel3.Update();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = sender as LinkButton;
        DataControlFieldCell cell = (DataControlFieldCell)lbtn.Parent;
        GridViewRow row = (GridViewRow)cell.Parent;
        Label7.Text = "About good Id: " + row.Cells[1].Text;
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Good good = client.GetGoodById(row.Cells[1].Text);
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Id Good", typeof(string)));
        dt.Columns.Add(new DataColumn("Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Count", typeof(string)));
        dt.Columns.Add(new DataColumn("Price", typeof(string)));
        if (good != null)
        {
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Id Good"] = good.Id;
                dr["Name"] = good.Name;
                dr["Count"] = good.Count;
                dr["Price"] = good.Price;

                dt.Rows.Add(dr);
            GridView4.DataSource = dt;
            GridView4.DataBind();
        }

        Label7.Visible = true;
        GridView4.Visible = true;
        UpdatePanel8.Update();

    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = sender as LinkButton;
        DataControlFieldCell cell = (DataControlFieldCell)lbtn.Parent;
        GridViewRow row = (GridViewRow)cell.Parent;
        Label8.Text = "Dishes in order Id: " + row.Cells[1].Text;
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Dish[] dishes = client.GetOrderComponents(row.Cells[1].Text);
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Id Dish", typeof(string)));
        dt.Columns.Add(new DataColumn("Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Time", typeof(string)));
        dt.Columns.Add(new DataColumn("Info", typeof(string)));
        dt.Columns.Add(new DataColumn("Tags", typeof(string)));
        dt.Columns.Add(new DataColumn("Recipe", typeof(string)));
        dt.Columns.Add(new DataColumn("Price", typeof(string)));
        dt.Columns.Add(new DataColumn("Count", typeof(string)));
        dt.Columns.Add(new DataColumn("Sum", typeof(string)));
        if (dishes != null)
        {
            for (Int32 i = 0; i < dishes.Length; i++)
            {
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Id Dish"] = dishes[i].IdDish;
                dr["Name"] = dishes[i].Name;
                dr["Time"] = dishes[i].Time;
                dr["Info"] = dishes[i].Info;
                dr["Tags"] = dishes[i].Tags;
                dr["Recipe"] = dishes[i].Recipe;
                dr["Count"] = dishes[i].Count;
                dr["Sum"] = (Double.Parse(dishes[i].Price) * Double.Parse(dishes[i].Count)).ToString();
                dt.Rows.Add(dr);

            }

            GridView5.DataSource = dt;
            GridView5.DataBind();
        }

        Label8.Visible = true;
        GridView5.Visible = true;
        UpdatePanel9.Update();
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = sender as LinkButton;
        DataControlFieldCell cell = (DataControlFieldCell)lbtn.Parent;
        GridViewRow row = (GridViewRow)cell.Parent;
        Label9.Text = "Dishes in order Id: " + row.Cells[1].Text;
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Dish[] dishes = client.GetOrderComponents(row.Cells[1].Text);
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("Id Dish", typeof(string)));
        dt.Columns.Add(new DataColumn("Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Time", typeof(string)));
        dt.Columns.Add(new DataColumn("Info", typeof(string)));
        dt.Columns.Add(new DataColumn("Tags", typeof(string)));
        dt.Columns.Add(new DataColumn("Recipe", typeof(string)));
        dt.Columns.Add(new DataColumn("Price", typeof(string)));
        dt.Columns.Add(new DataColumn("Count", typeof(string)));
        dt.Columns.Add(new DataColumn("Sum", typeof(string)));
        if (dishes != null)
        {
            for (Int32 i = 0; i < dishes.Length; i++)
            {
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Id Dish"] = dishes[i].IdDish;
                dr["Name"] = dishes[i].Name;
                dr["Time"] = dishes[i].Time;
                dr["Info"] = dishes[i].Info;
                dr["Tags"] = dishes[i].Tags;
                dr["Recipe"] = dishes[i].Recipe;
                dr["Count"] = dishes[i].Count;
                dr["Sum"] = (Double.Parse(dishes[i].Price) * Double.Parse(dishes[i].Count)).ToString();
                dt.Rows.Add(dr);

            }

            GridView6.DataSource = dt;
            GridView6.DataBind();
        }

        Label9.Visible = true;
        GridView6.Visible = true;
        UpdatePanel10.Update();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Boolean f = false;
        if (String.IsNullOrEmpty(TextBox1.Text) && String.IsNullOrEmpty(TextBox2.Text))
        {
            String period = DropDownList2.SelectedItem.Text;
            String beginDate = "", endDate = "";
            switch (period)
            {
                case "Daily": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    f = true;
                    break;
                case "Weekly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(7, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Monthly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(30, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Yearly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(356, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
            }
            DataTable dt = ShowSpent(beginDate, endDate);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (f) ViewState["spent"] = dt;
            UpdatePanel4.Update();

            Label10.Visible = false;
            UpdatePanel7.Update();
            return;
        }
        else
        {
            DataTable dt = null;
            if (!String.IsNullOrEmpty(TextBox1.Text) && String.IsNullOrEmpty(TextBox2.Text))
            {
                try
                {
                    String beginDate = TextBox1.Text;
                    String endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    dt = ShowSpent(endDate, beginDate);
                }
                catch { }
            }
            else
                if (String.IsNullOrEmpty(TextBox1.Text) && !String.IsNullOrEmpty(TextBox2.Text))
                {
                    try
                    {
                        String beginDate = "2011-04-19";
                        String endDate = TextBox2.Text;
                        dt = ShowSpent(endDate, beginDate);
                    }
                    catch { }
                }
                else
                    if (!String.IsNullOrEmpty(TextBox1.Text) && !String.IsNullOrEmpty(TextBox2.Text))
                    {
                        try
                        {
                            String beginDate = TextBox1.Text;
                            String endDate = TextBox2.Text;
                            dt = ShowSpent(endDate, beginDate);
                        }
                        catch { }
                    }
            GridView1.DataSource = dt;
            GridView1.DataBind();
            UpdatePanel4.Update();
            return;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Boolean f = false;
        if (String.IsNullOrEmpty(TextBox3.Text) && String.IsNullOrEmpty(TextBox4.Text))
        {
            String period = DropDownList1.SelectedItem.Text;
            String beginDate = "", endDate = "";
            switch (period)
            {
                case "Daily": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    f = true;
                    break;
                case "Weekly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(7, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Monthly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(30, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Yearly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(356, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
            }
            DataTable dt = ShowRecieved(beginDate, endDate);
            GridView2.DataSource = dt;
            GridView2.DataBind();
            if (f) ViewState["recieved"] = dt;
            UpdatePanel5.Update();
            Label10.Visible = false;
            UpdatePanel7.Update();
            return;
        }
        else
        {
            DataTable dt = null;
            if (!String.IsNullOrEmpty(TextBox3.Text) && String.IsNullOrEmpty(TextBox4.Text))
            {
                try
                {
                    String beginDate = TextBox3.Text;
                    String endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    dt = ShowRecieved(endDate, beginDate);
                }
                catch { }
            }
            else
                if (String.IsNullOrEmpty(TextBox3.Text) && !String.IsNullOrEmpty(TextBox4.Text))
                {
                    try
                    {
                        String beginDate = "2011-04-19";
                        String endDate = TextBox4.Text;
                        dt = ShowRecieved(endDate, beginDate);
                    }
                    catch { }
                }
                else
                    if (!String.IsNullOrEmpty(TextBox3.Text) && !String.IsNullOrEmpty(TextBox4.Text))
                    {
                        try
                        {
                            String beginDate = TextBox3.Text;
                            String endDate = TextBox4.Text;
                            dt = ShowRecieved(endDate, beginDate);
                        }
                        catch { }
                    }
            GridView2.DataSource = dt;
            GridView2.DataBind();
            UpdatePanel5.Update();
            
            return;
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Boolean f = false;
        if (String.IsNullOrEmpty(TextBox5.Text) && String.IsNullOrEmpty(TextBox6.Text))
        {
            String period = DropDownList3.SelectedItem.Text;
            String beginDate = "", endDate = "";
            switch (period)
            {
                case "Daily": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    f = true;
                    break;
                case "Weekly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(7, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Monthly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(30, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
                case "Yearly": beginDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate = (DateTime.Now.Date - new TimeSpan(356, 0, 0, 0)).ToString("yyyy-MM-dd");
                    break;
            }
            DataTable dt = ShowLost(beginDate, endDate);
            GridView3.DataSource = dt;
            GridView3.DataBind();
            UpdatePanel6.Update();
            if (f) ViewState["lost"] = dt;
            Label10.Visible = false;
            UpdatePanel7.Update();
            return;
        }
        else
        {
            DataTable dt = null;
            if (!String.IsNullOrEmpty(TextBox5.Text) && String.IsNullOrEmpty(TextBox6.Text))
            {
                try
                {
                    String beginDate = TextBox5.Text;
                    String endDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
                    dt = ShowLost(endDate, beginDate);
                }
                catch { }
            }
            else
                if (String.IsNullOrEmpty(TextBox5.Text) && !String.IsNullOrEmpty(TextBox6.Text))
                {
                    try
                    {
                        String beginDate = "2011-04-19";
                        String endDate = TextBox6.Text;
                        dt = ShowLost(endDate, beginDate);
                    }
                    catch { }
                }
                else
                    if (!String.IsNullOrEmpty(TextBox5.Text) && !String.IsNullOrEmpty(TextBox6.Text))
                   {
                        try
                        {
                            String beginDate = TextBox5.Text;
                            String endDate = TextBox6.Text;
                            dt = ShowLost(endDate, beginDate);
                        }
                        catch { }
                    }
            GridView3.DataSource = dt;
            GridView3.DataBind();
            UpdatePanel6.Update();
            return;
        }
    }
}