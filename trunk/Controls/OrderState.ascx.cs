using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Drawing;

public partial class Controls_OrderState : System.Web.UI.UserControl
{

    private CommunicationService.CommunicationClient client = new CommunicationService.CommunicationClient();
    //private string mySQLConnectionString = @"Server=195.182.193.226;port=3306;Database=online_foods;uid=UserKon;pwd=qwerty;";
    private int _OrderID;
    //
    public int OrderID
    {
        get { return _OrderID; }
        set { _OrderID = value; }
    }
    //
    protected void StateTimerTick(object sender, EventArgs e)
    {
        int state = Convert.ToInt16(client.GetState(Convert.ToString(_OrderID)));
        String strState = "";
        Color stateColor = new Color();
        switch (state)
        {
            case 0: strState = "В черзі..."; stateColor = Color.Green; break;
            case 1: strState = "Прийнято"; stateColor = Color.DeepSkyBlue; break;
            case 2: strState = "Відправка"; stateColor = Color.Honeydew; break;
            case -1: strState = "Доставлено"; stateColor = Color.BlueViolet; break;
        }
        StateLabel.Text = strState;
        StateLabel.BackColor = stateColor;
    }
    //
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}