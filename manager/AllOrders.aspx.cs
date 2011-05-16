using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class AllOrdersaspx : System.Web.UI.Page
{

    private DataTable ShowData(String beginDate, String endDate)
    {

        CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
        CommunicationService.Order[] or = client.GetOrdersByDate(endDate, beginDate);
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
                //dr = dt.NewRow();

                Int32 k = dt.Rows.Count;
                //Store the DataTable in ViewState
                //ViewState["CurrentTable"] = dt;
                return dt;
            }
            return dt;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewState["calendar"] = 1;
            
            String period = DropDownList1.SelectedItem.Text;
            String beginDate = "", endDate = "";
            switch (period)
            {
                case "Daily": beginDate=DateTime.Now.Date.ToString("yyyy-MM-dd");
                    endDate=DateTime.Now.Date.ToString("yyyy-MM-dd");
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
            DataTable dt=ShowData(beginDate,endDate);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Cells[10].Text == "Awaiting")
                    row.BackColor = Color.Yellow;
                if (row.Cells[10].Text == "Accepted")
                    if (!String.IsNullOrEmpty(row.Cells[6].Text))
                        row.BackColor = Color.IndianRed;
                    else
                        row.BackColor = Color.Orange;
                if (row.Cells[10].Text == "Getting Ready")
                    row.BackColor = Color.PaleGreen;
                if (row.Cells[10].Text == "Sent")
                    row.BackColor = Color.Green;
                if (row.Cells[10].Text == "Refused")
                    row.BackColor = Color.Red;
            }
            CheckBox1.Checked = true;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(TextBox1.Text) && String.IsNullOrEmpty(TextBox2.Text))
        {
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
            DataTable dt=ShowData(beginDate, endDate);
            if (CheckBox1.Checked)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                foreach (GridViewRow row in GridView1.Rows)
                {
                    if (row.Cells[10].Text == "Awaiting")
                        row.BackColor = Color.Yellow;
                    if (row.Cells[10].Text == "Accepted")
                        if (!String.IsNullOrEmpty(row.Cells[6].Text))
                            row.BackColor = Color.IndianRed;
                        else
                            row.BackColor = Color.Orange;
                    if (row.Cells[10].Text == "Getting Ready")
                        row.BackColor = Color.PaleGreen;
                    if (row.Cells[10].Text == "Sent")
                        row.BackColor = Color.Green;
                    if (row.Cells[10].Text == "Refused")
                        row.BackColor = Color.Red;
                }
                UpdatePanel1.Update();
                return;
            }
            DataTable dt1 = new DataTable();
            dt1.Columns.Add(new DataColumn("Id Order", typeof(string)));
            dt1.Columns.Add(new DataColumn("Address", typeof(string)));
            dt1.Columns.Add(new DataColumn("Phone", typeof(string)));
            dt1.Columns.Add(new DataColumn("Order Date", typeof(string)));
            dt1.Columns.Add(new DataColumn("Execution Date", typeof(string)));
            dt1.Columns.Add(new DataColumn("Execution Time", typeof(string)));
            dt1.Columns.Add(new DataColumn("Order Discount", typeof(string)));
            dt1.Columns.Add(new DataColumn("Order Sum", typeof(string)));
            dt1.Columns.Add(new DataColumn("Info", typeof(string)));
            dt1.Columns.Add(new DataColumn("State", typeof(string)));
            dt1.Columns.Add(new DataColumn("Prep Time", typeof(string)));

            if (CheckBox2.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Awaiting")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox3.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Accepted")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox4.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Getting Ready")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox5.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Sent")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox6.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Refused")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            GridView1.DataSource = dt1;
            GridView1.DataBind();
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Cells[10].Text == "Awaiting")
                    row.BackColor = Color.Yellow;
                if (row.Cells[10].Text == "Accepted")
                    if (!String.IsNullOrEmpty(row.Cells[6].Text))
                        row.BackColor = Color.IndianRed;
                    else
                        row.BackColor = Color.Orange;
                if (row.Cells[10].Text == "Getting Ready")
                    row.BackColor = Color.PaleGreen;
                if (row.Cells[10].Text == "Sent")
                    row.BackColor = Color.Green;
                if (row.Cells[10].Text == "Refused")
                    row.BackColor = Color.Red;
            }
            UpdatePanel1.Update();
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
                    dt=ShowData(endDate, beginDate);
                }
                catch { }
            }else
            if (String.IsNullOrEmpty(TextBox1.Text) && !String.IsNullOrEmpty(TextBox2.Text))
            {
                try
                {
                    String beginDate = "2011-04-19";
                    String endDate = TextBox2.Text;
                    dt = ShowData(endDate, beginDate);
                }
                catch { }
            }else
            if (!String.IsNullOrEmpty(TextBox1.Text) && !String.IsNullOrEmpty(TextBox2.Text))
            {
                try
                {
                    String beginDate = TextBox1.Text;
                    String endDate = TextBox2.Text;
                    dt = ShowData(endDate, beginDate);
                }
                catch { }
            }
            if (CheckBox1.Checked)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                foreach (GridViewRow row in GridView1.Rows)
                {
                    if (row.Cells[10].Text == "Awaiting")
                        row.BackColor = Color.Yellow;
                    if (row.Cells[10].Text == "Accepted")
                        if (!String.IsNullOrEmpty(row.Cells[6].Text))
                            row.BackColor = Color.IndianRed;
                        else
                            row.BackColor = Color.Orange;
                    if (row.Cells[10].Text == "Getting Ready")
                        row.BackColor = Color.PaleGreen;
                    if (row.Cells[10].Text == "Sent")
                        row.BackColor = Color.Green;
                    if (row.Cells[10].Text == "Refused")
                        row.BackColor = Color.Red;
                }
                UpdatePanel1.Update();
                return;
            }
            DataTable dt1 = new DataTable();
            dt1.Columns.Add(new DataColumn("Id Order", typeof(string)));
            dt1.Columns.Add(new DataColumn("Address", typeof(string)));
            dt1.Columns.Add(new DataColumn("Phone", typeof(string)));
            dt1.Columns.Add(new DataColumn("Order Date", typeof(string)));
            dt1.Columns.Add(new DataColumn("Execution Date", typeof(string)));
            dt1.Columns.Add(new DataColumn("Execution Time", typeof(string)));
            dt1.Columns.Add(new DataColumn("Order Discount", typeof(string)));
            dt1.Columns.Add(new DataColumn("Order Sum", typeof(string)));
            dt1.Columns.Add(new DataColumn("Info", typeof(string)));
            dt1.Columns.Add(new DataColumn("State", typeof(string)));
            dt1.Columns.Add(new DataColumn("Prep Time", typeof(string)));

            if (CheckBox2.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Awaiting")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox3.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Accepted")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox4.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Getting Ready")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox5.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Sent")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            if (CheckBox6.Checked)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[9].ToString() == "Refused")
                    {
                        DataRow rw = dt1.NewRow();
                        rw[0] = row[0].ToString();
                        rw[1] = row[1].ToString();
                        rw[2] = row[2].ToString();
                        rw[3] = row[3].ToString();
                        rw[4] = row[4].ToString();
                        rw[5] = row[5].ToString();
                        rw[6] = row[6].ToString();
                        rw[7] = row[7].ToString();
                        rw[8] = row[8].ToString();
                        rw[9] = row[9].ToString();
                        rw[10] = row[10].ToString();
                        dt1.Rows.Add(rw);
                    }
                }
            }
            GridView1.DataSource = dt1;
            GridView1.DataBind();
        }
        Label4.Visible = false;
        GridView2.Visible = false ;
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.Cells[10].Text == "Awaiting")
                row.BackColor = Color.Yellow;
            if (row.Cells[10].Text == "Accepted")
                if (!String.IsNullOrEmpty(row.Cells[6].Text))
                    row.BackColor = Color.IndianRed;
                else
                    row.BackColor = Color.Orange;
            if (row.Cells[10].Text == "Getting Ready")
                row.BackColor = Color.PaleGreen;
            if (row.Cells[10].Text == "Sent")
                row.BackColor = Color.Green;
            if (row.Cells[10].Text == "Refused")
                row.BackColor = Color.Red;
        }
        UpdatePanel3.Update();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        TextBox1.Text = "";
        TextBox2.Text = "";
        UpdatePanel2.Update();
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = sender as LinkButton;
        DataControlFieldCell cell = (DataControlFieldCell)lbtn.Parent;
        GridViewRow row = (GridViewRow)cell.Parent;
        Label4.Text = "Dishes in order Id: " + row.Cells[1].Text;
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
                dr["Sum"] = (Double.Parse(dishes[i].Price)*Double.Parse(dishes[i].Count)).ToString();
                dt.Rows.Add(dr);

            }
            //dr = dt.NewRow();

            Int32 k = dt.Rows.Count;
            //Store the DataTable in ViewState
            //ViewState["CurrentTable"] = dt;

            GridView2.DataSource = dt;
            GridView2.DataBind();
        }

        Label4.Visible = true;
        GridView2.Visible = true;
        UpdatePanel3.Update();
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {

        if (ViewState["calendar"].ToString()=="1" || String.IsNullOrEmpty(TextBox1.Text))
        {
            ViewState["calendar"] = 2;
            Calendar c = sender as Calendar;
            TextBox1.Text = c.SelectedDate.ToString("yyyy-MM-dd");
            UpdatePanel2.Update();
        }else
            if (ViewState["calendar"].ToString() == "2" || String.IsNullOrEmpty(TextBox2.Text))
        {
            ViewState["calendar"] = 1;
            Calendar c = sender as Calendar;
            TextBox2.Text = c.SelectedDate.ToString("yyyy-MM-dd");
            UpdatePanel2.Update();
        }
    }
}