using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using MySql.Data.MySqlClient;

    public partial class WebUserControl : System.Web.UI.UserControl
    {
        public int dish_id = 1;
        public void InitIt(int d_id)
        {
            dish_id = d_id;
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            //string id="1";
            SqlDataReader dr;
            SqlConnection SqlCon = null;
            string str = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
            string conString = @"server=195.182.193.226;port=3306;User Id=UserKon;password=qwerty;database=online_foods;Persist Security Info=True";
            SqlCon = new SqlConnection();
            SqlCon.ConnectionString = str;
            SqlCon.Open();
            string sqll = string.Format("SELECT * FROM dish WHERE id_dish='{0}'", dish_id);
            using (SqlCommand sqlc = new SqlCommand(sqll, SqlCon))
            {
                dr = sqlc.ExecuteReader();
                while (dr.Read())
                {

                    this.Label1.Text = (string)dr["name"];
                    Label3.Text = Convert.ToString(dr["price"]);
                }
            }
            dr.Close();
            sqll = string.Format("SELECT * FROM dish_picture WHERE dish_id='{0}'", dish_id);
            using (SqlCommand sqlc = new SqlCommand(sqll, SqlCon))
            {
                dr = sqlc.ExecuteReader();
                //  Image1.ImageUrl = "pictures/1.jpg";
                while (dr.Read())
                {

                    Image1.ImageUrl = "/WebProject/pictures/" + (string)dr["picture"];
                }
            }
            dr.Close();

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string cookies = "";
            if(Request.Cookies["basket"] != null)
                cookies = Server.HtmlEncode(Request.Cookies["basket"].Value); ;
            if (Request.Cookies["basket"] == null)
                cookies = "";

            Response.Cookies["basket"].Value = cookies + this.dish_id + ":" + this.TextBox1.Text + ":" + this.Label3.Text+":" + this.Label1.Text + ",";
            Response.Cookies["basket"].Expires = DateTime.Now.AddDays(1);
        }
}