<%@ WebHandler Language="C#" Class="LoadDishsByGroup" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Xml.Linq;
using System.Data.SqlClient;
using MySql.Data;
using MySql.Data.MySqlClient;

public class LoadDishsByGroup : IHttpHandler {
    private string mySQLConnectionString = @"server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
    private string localBaseConnectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
    public void ProcessRequest(HttpContext context)
    {
        
        string group_id = context.Request.QueryString["id_group"];
        string sqlQuery =
        " SELECT        dish.id_dish, dish.name, dish.price, dish.info " +
        " FROM            link_dish_group INNER JOIN " +
        "                dish ON link_dish_group.id_dish = dish.id_dish INNER JOIN " +
        "                dish_groups ON link_dish_group.id_group = dish_groups.id_dish_group " +
        " WHERE        (dish_groups.id_dish_group = "+group_id+")";
        string mysqlQuery =
        "SELECT  " +
        "    d.name, d.id_dish, d.price, d.info,  " +
        "    ldg.id_group " +
        " FROM " +
        " link_dish_group ldg " +
        " LEFT OUTER JOIN dish d ON (d.id_dish = ldg.id_dish) " +
        " WHERE " +
        " ldg.id_group = " + group_id +
        " GROUP BY d.id_dish ";
        string responseStr = "<table>";
        responseStr ="";
        using (SqlConnection mySQLConnection = new SqlConnection())
        {
            mySQLConnection.ConnectionString = localBaseConnectionString;
            using (SqlCommand Command = new SqlCommand(sqlQuery, mySQLConnection))
            {
                mySQLConnection.Open();
                using (SqlDataReader myReader = Command.ExecuteReader())
                {
                    System.Data.DataTable table = new DataTable();
                    System.Data.DataSet dataSet = new DataSet();
                    table.Load(myReader);
                    foreach(DataRow row in table.Rows)
                    {  
                        String id_dish = row["id_dish"].ToString();
                        String name = row["name"].ToString();
                        String price = Convert.ToDouble(row["price"].ToString()).ToString();
                        String info = row["info"].ToString();
                        responseStr += id_dish + ",";
                        //responseStr += "<tr> <td>" + "<dish:dishPanel ID='Dish" + id_dish + "' runat='server' dish_id=" + id_dish + " /></td></tr> ";
                        //responseStr += "<tr> <td>" + name + " Info: " + info + " Price: " + price + "<a id='good-" + id_dish + "-" + price + "' href='#' class='addCart'>Add to order</a></td></tr> "; 
                    }   
                    //responseStr += "</table>";
                }
            }
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(responseStr);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}