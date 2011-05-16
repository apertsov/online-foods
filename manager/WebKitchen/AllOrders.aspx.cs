using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class ShowOrders : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Label2.Text = DateTime.Now.Date.ToString("yyyy-MM-dd") + "   " + DateTime.Now.ToShortTimeString();
            CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
            CommunicationService.Order[] or = client.GetUnservedOrders(DateTime.Now.Date.ToString("yyyy-MM-dd"));
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
                    if (or[i].State == "1")
                        if (!String.IsNullOrEmpty(or[i].ExecutionTime)) continue;
                    if (or[i].State != "1" && or[i].State !="2") continue;
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
                        case "1": st = "Accepted"; break;
                        case "2": st = "Getting Ready"; break;
                    }
                    dr["State"] = st;
                    dr["Prep Time"] = or[i].PreparationTime;
                    if (String.IsNullOrEmpty(or[i].ExecutionTime) || or[i].State != "1")
                        dt.Rows.Add(dr);

                }

                Int32 k = dt.Rows.Count;
                
            }
            or = null;
            or = client.GetPreOrders(DateTime.Now.Date.ToString("yyyy-MM-dd"), DateTime.Now.ToShortTimeString());
            if (or != null)
                for (Int32 i = 0; i < or.Length; i++)
                {
                    if (or[i].ExecutionDate != DateTime.Now.Date.ToString("yyyy-MM-dd")) continue;
                    if (String.IsNullOrEmpty(or[i].ExecutionTime)) continue;
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
            ViewState["CurrentTable"] = dt;

            GridView2.DataSource = dt;
            GridView2.DataBind();
            foreach (GridViewRow row in GridView2.Rows)
            {
                DateTime res = new DateTime();
                if (row.Cells[11].Text == "Accepted")
                    if (DateTime.TryParse(row.Cells[7].Text, out  res))
                        row.BackColor = Color.IndianRed;
                    else
                        row.BackColor = Color.Orange;
                if (row.Cells[11].Text == "Getting Ready")
                    row.BackColor = Color.PaleGreen;
            }
        }
        Timer1.Enabled = true;

    }

    public void ChangeState(Object sender, EventArgs e)
    {

    }
    protected void GettingReady_Click(object sender, EventArgs e)
    {
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        foreach (GridViewRow row in GridView2.Rows)
        {
            CheckBox chb = row.FindControl("CheckBox1") as CheckBox;
            if (chb.Checked)
            {
                client.SetState(row.Cells[2].Text, "2");
            }
        }
        Timer1_Tick(this, e);
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Order[] or = client.GetUnservedOrders(DateTime.Now.Date.ToString("yyyy-MM-dd"));
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

                if (or[i].State == "1")
                    if (!String.IsNullOrEmpty(or[i].ExecutionTime)) continue;
                if (or[i].State != "1" && or[i].State != "2") continue;
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
                    case "1": st = "Accepted"; break;
                    case "2": st = "Getting Ready"; break;
                }
                dr["State"] = st;
                dr["Prep Time"] = or[i].PreparationTime;
                if (String.IsNullOrEmpty(or[i].ExecutionTime) || or[i].State != "1")
                    dt.Rows.Add(dr);

            }
            
        }
        or = null;
        or = client.GetPreOrders(DateTime.Now.Date.ToString("yyyy-MM-dd"), DateTime.Now.ToShortTimeString());
        if (or != null)
            for (Int32 i = 0; i < or.Length; i++)
            {
                if (or[i].ExecutionDate != DateTime.Now.Date.ToString("yyyy-MM-dd")) continue;
                if (String.IsNullOrEmpty(or[i].ExecutionTime)) continue;
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
                    case "1": st = "Accepted"; break;
                    case "2": st = "Getting Ready"; break;
                }
                dr["State"] = st;
                dr["Prep Time"] = or[i].PreparationTime;
                dt.Rows.Add(dr);

            }

        GridView2.DataSource = dt;
        GridView2.DataBind();
        foreach (GridViewRow row in GridView2.Rows)
        {
            DateTime res = new DateTime();
            if (row.Cells[11].Text == "Accepted")
                if (DateTime.TryParse(row.Cells[7].Text, out  res))
                    row.BackColor = Color.IndianRed;
                else
                    row.BackColor = Color.Orange;
            if (row.Cells[11].Text == "Getting Ready")
                row.BackColor = Color.PaleGreen;
        }
        Label2.Text = DateTime.Now.Date.ToString("yyyy-MM-dd") + "   " + DateTime.Now.ToShortTimeString();
        UpdatePanel1.Update();
    }
    protected void Sent_Click(object sender, EventArgs e)
    {
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        foreach (GridViewRow row in GridView2.Rows)
        {
            CheckBox chb = row.FindControl("CheckBox1") as CheckBox;
            if (chb.Checked)
            {
                client.SetState(row.Cells[2].Text, "3");
            }
        }
        Label4.Visible = false;
        GridView2.Visible = false;
        UpdatePanel2.Update();
        Timer1_Tick(this, e);
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = sender as LinkButton;
        DataControlFieldCell cell = (DataControlFieldCell)lbtn.Parent;
        GridViewRow row = (GridViewRow)cell.Parent;
        Label4.Text = "Dishes in order Id: " + row.Cells[2].Text;
        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Dish[] dishes = client.GetOrderComponents(row.Cells[2].Text);
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
            //dr = dt.NewRow();

            Int32 k = dt.Rows.Count;
            //Store the DataTable in ViewState
            //ViewState["CurrentTable"] = dt;

            GridView3.DataSource = dt;
            GridView3.DataBind();
        }

        Label4.Visible = true;
        GridView2.Visible = true;
        UpdatePanel2.Update();
    }
    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView2.Rows)
        {
            CheckBox chb = row.FindControl("CheckBox1") as CheckBox;
            chb.Checked = !chb.Checked;
            UpdatePanel1.Update();
        }
    }

}