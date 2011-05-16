using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mega_shop_mysql3;
using System.Web.Services;

public partial class MainPage : System.Web.UI.Page
{
    [WebMethod(true)]
    public static void SetDishsByIDs(String IDs)
    {
        MainPage page = (MainPage)HttpContext.Current.Handler;
        String[] values = IDs.Split(',');
        foreach (String ID in values)
        {
            WebUserControl OrderStateControl = (WebUserControl)page.LoadControl("~/Controls/WebUserConrol.ascx");
            OrderStateControl.ID = "Dish" + ID;
            OrderStateControl.dish_id = Convert.ToInt32(ID);
            page.DishsPlaceHolder.Controls.Add(OrderStateControl);
        }
    }
    //

    protected void Page_Load(object sender, EventArgs e)
    {
    }
}