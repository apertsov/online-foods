using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SendOrder : System.Web.UI.Page
{
    ComunicationService.CommunicationClient client = new ComunicationService.CommunicationClient();
    Dictionary<String, String> dishes = new Dictionary<string, string>();
    private static String order_id = "0";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        ComunicationService.Order order = new ComunicationService.Order();
        order.Addres = TextBox1.Text;
        order.Phone = TextBox2.Text;
        order.OrderDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
        if (TextBox3.Text == "")
            order.ExecutionDate = DateTime.Now.Date.ToString("yyyy-MM-dd");
        else
            order.ExecutionDate = TextBox3.Text;
        if (TextBox4.Text == "")
            order.ExecutionTime = null;
        else
            order.ExecutionTime = TextBox4.Text;
        if (TextBox5.Text == "")
            order.OrderDiscount = null;
        else
            order.OrderDiscount = TextBox5.Text;
        if (TextBox6.Text == "")
            order.OrderSum = null;
        else
            order.OrderSum = TextBox6.Text;
        if (TextBox7.Text == "")
            order.Info = null;
        else
            order.Info = TextBox7.Text;
        if (Request.Cookies["basket"] != null)
        {
            HttpCookie aCookie = Request.Cookies["basket"];
            String cookievalue = Server.UrlDecode(aCookie.Value); 
            String[] values = cookievalue.Split(',');
            foreach (String dishOrder in values)
            if (dishOrder.Length>0)
            {
                
                String[] param = dishOrder.Split(':');
                dishes.Add(param[0], param[1]);
            }
        }       
        //dishes.Add("2", "3");
        order.DishCount = dishes;
            order_id = client.SubmitOrder(order);
        
        HttpCookie aCookieDel;
        string cookieName;
        int limit = Request.Cookies.Count;
        for (int i=0; i<limit; i++)
        {
            cookieName = Request.Cookies[i].Name;
            aCookieDel = new HttpCookie(cookieName);
            aCookieDel.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(aCookieDel);
        }
        //
        TextBox1.Enabled = false;
        TextBox2.Enabled = false;
        TextBox3.Enabled = false;
        TextBox4.Enabled = false;
        TextBox5.Enabled = false;
        TextBox6.Enabled = false;
        TextBox7.Enabled = false;
        Button1.Visible  = false;
        CheckStateTimer.Enabled = true;
        //
    }
    protected void btnCheck_Click(object sender, EventArgs e)
    {
        int state = Convert.ToInt16(client.GetState(order_id));
        String strState = "";
        switch (state)
        {
            case 0: strState = "В черзі..."; break;
            case 1: strState = "Прийнято"; break;
            case 2: strState = "Відправка"; break;
            case -1: strState = "Доставлено"; break;
        }
        lbStatus.Text = strState;
    }
    protected void CheckStateTimer_Tick(object sender, EventArgs e)
    {
        int state = Convert.ToInt16(client.GetState(order_id));
        String strState = "";
        switch (state)
        {
            case 0: strState = "В черзі..."; break;
            case 1: strState = "Прийнято"; break;
            case 2: strState = "Відправка"; break;
            case -1: strState = "Доставлено"; break;
        }
        lbStatus.Text = strState;
    }
}