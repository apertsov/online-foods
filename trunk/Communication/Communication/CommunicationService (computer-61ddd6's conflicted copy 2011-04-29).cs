using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.Threading;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using MySql.Data.Types;

//using System.Net;
//using System.Net.Sockets;

namespace Communication
{
    [ServiceBehavior(
        InstanceContextMode = InstanceContextMode.Single,
        ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class CommunicationService: CommunicationLibrary.ICommunication
    {
        string connectionString = "Server=195.182.193.226;Port=3306;Database=online_foods;Uid=UserKon;Pwd=qwerty;allow user variables=true";
        MySqlConnection connection = new MySqlConnection();
        MySqlDataAdapter adapter = new MySqlDataAdapter();
        DataSet data = new DataSet();

        List<CommunicationLibrary.Order> orderList = new List<CommunicationLibrary.Order>();

        Boolean newOrder=false;

        public List<CommunicationLibrary.Order> GetNewOrders(String date)
        {
            if (newOrder == true)
            {
                List<CommunicationLibrary.Order> buf = new List<CommunicationLibrary.Order>();
                foreach (CommunicationLibrary.Order or in orderList)
                {
                    if (or.ExecutionDate == date.Replace(".", "-"))
                    buf.Add(or);
                }
                orderList.Clear();
                newOrder = false;
                return buf;
            }
            else return null;
        }

        public string SubmitOrder(CommunicationLibrary.Order order)
        {
            connection.ConnectionString = connectionString;
            adapter.SelectCommand = new MySqlCommand("Select * from `online_foods`.`order`");
            adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
            adapter.Fill(data);

            adapter.InsertCommand = new MySqlCommand(@"INSERT INTO `online_foods`.`order`(`id_order`,`date_order`,`id_agent`,`info`,`execution_time`,`execution_date`,`sum_order`,`sum_discount`,`state`,`phone`,`adress`)
                                                        VALUES (@id_order,@date_order,@id_agent,@info, @execution_time,@execution_date,@sum_order,@sum_discount,@state,@phone,@adress);");
            adapter.InsertCommand.Parameters.Add("@id_order", MySqlDbType.Int32, 11, "`id_order`").Value = DBNull.Value;
            try
            {
                adapter.InsertCommand.Parameters.Add("@date_order", MySqlDbType.Date, 12, "`date_order`").Value = order.OrderDate.Replace('.', '-');
            }
            catch
            {
                adapter.InsertCommand.Parameters["@date_order"].Value = DBNull.Value;
            }
            adapter.InsertCommand.Parameters.Add("@id_agent", MySqlDbType.Int32, 11, "`id_agent`").Value = order.IdUser;
            adapter.InsertCommand.Parameters.Add("@info", MySqlDbType.VarChar, 1000, "`info`").Value =  order.Info;
            if (String.IsNullOrEmpty(order.ExecutionTime))
                adapter.InsertCommand.Parameters.Add("@execution_time", MySqlDbType.DateTime, 10, "`execution_time`").Value = DBNull.Value;
            else
                adapter.InsertCommand.Parameters.Add("@execution_time", MySqlDbType.DateTime, 10, "`execution_time`").Value = order.ExecutionTime;
            try
            {
                adapter.InsertCommand.Parameters.Add("@execution_date", MySqlDbType.Date, 12, "`execution_date`").Value = order.ExecutionDate.Replace('.', '-');
            }
            catch
            {
                adapter.InsertCommand.Parameters["@execution_date"].Value = DBNull.Value;
            }
            adapter.InsertCommand.Parameters.Add("@sum_order", MySqlDbType.Decimal, 10, "`sum_order`").Value = order.OrderSum;
            adapter.InsertCommand.Parameters.Add("@sum_discount", MySqlDbType.Decimal, 10, "`sum_discount`").Value = order.OrderDiscount;
            adapter.InsertCommand.Parameters.Add("@state", MySqlDbType.Int16, 4, "`state`").Value = 0;
            adapter.InsertCommand.Parameters.Add("@phone", MySqlDbType.VarChar, 45, "`phone`").Value = order.Phone;
            adapter.InsertCommand.Parameters.Add("@adress", MySqlDbType.VarChar, 45, "`adress`").Value = order.Addres;
            adapter.InsertCommand.Connection = new MySqlConnection(connectionString);
            adapter.InsertCommand.Connection.Open();
            adapter.InsertCommand.ExecuteNonQuery();
            adapter.InsertCommand.Connection.Clone();
            
            data = new DataSet();
            adapter.Fill(data);
            Double time = 0;
            order.IdOrder = data.Tables[0].Rows[data.Tables[0].Rows.Count - 1][0].ToString();
            foreach (KeyValuePair<String, String> row in order.DishCount)
            {
                adapter.InsertCommand = new MySqlCommand(@"INSERT INTO `online_foods`.`order_rows`(`id_order_rows`,`id_order`,`id_dish`,`count`) 
                                                        VALUES (@id_order_rows,@id_order,@id_dish,@count);");
                adapter.InsertCommand.Parameters.Add("@id_order_rows", MySqlDbType.Int32, 11, "`id_order_rows`").Value = DBNull.Value;
                adapter.InsertCommand.Parameters.Add("@id_order", MySqlDbType.Int32, 11, "`id_order`").Value = order.IdOrder;
                adapter.InsertCommand.Parameters.Add("@id_dish", MySqlDbType.Int32, 11, "`id_dish`").Value = row.Key;
                adapter.InsertCommand.Parameters.Add("@count", MySqlDbType.Decimal, 15, "`count`").Value = row.Value;
                adapter.InsertCommand.Connection = new MySqlConnection(connectionString);
                adapter.InsertCommand.Connection.Open();
                adapter.InsertCommand.ExecuteNonQuery();
                adapter.InsertCommand.Connection.Close();

                
                try
                {
                    adapter.SelectCommand = new MySqlCommand(@"Select `dish`.`time` from `online_foods`.`dish` where `id_dish`=@id_dish");
                    adapter.SelectCommand.Parameters.Add("@id_dish", MySqlDbType.Int32, 11, "`id_dish`").Value = row.Key;
                    adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    DateTime d = DateTime.Parse(dt.Rows[0][0].ToString());
                    Double buf = d.Hour + d.Minute;
                    if (time <= buf) time = buf;
                    
                }
                catch { }
            }
            adapter.SelectCommand = new MySqlCommand("Select * from `online_foods`.`order`");
            adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
            order.PreparationTime = time.ToString();
            //orderList.Add(order);
            //newOrder=true;

            return order.IdOrder ;
        }

        public String GetState(String idOrder)
        {
            adapter.SelectCommand = new MySqlCommand("Select `order`.`state` from `online_foods`.`order` where `order`.`id_order`=@id_order");
            adapter.SelectCommand.Parameters.Add("@id_order", MySqlDbType.Int32, 11, "`id_order`").Value = Int32.Parse(idOrder);
            adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            adapter.SelectCommand = new MySqlCommand("Select * from `online_foods`.`order`");
            adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
            adapter.Fill(data);

            return dt.Rows[0][0].ToString();
            
        }

        public void SetState(String idOrder, String state)
        {
            adapter.UpdateCommand = new MySqlCommand(@"UPDATE `online_foods`.`order` SET `state`=@state  WHERE `id_order`=@id_order;");
            adapter.UpdateCommand.Connection = new MySqlConnection(connectionString);
            try
            {

                adapter.UpdateCommand.Parameters.Add("@id_order", MySqlDbType.Int32, 11, "`id_order`").Value = Int32.Parse(idOrder);
                adapter.UpdateCommand.Parameters.Add("@state", MySqlDbType.Int16,4, "`state`").Value = Int32.Parse(state);
                adapter.UpdateCommand.Connection.Open();
                adapter.UpdateCommand.ExecuteNonQuery();

                data = new DataSet();
                adapter.Fill(data);
            }
            catch
            {
                return;
            }


        }

        public List<CommunicationLibrary.Order> GetUnservedOrders(String date)
        {
            List<CommunicationLibrary.Order> orders = new List<CommunicationLibrary.Order>();
            adapter.SelectCommand = new MySqlCommand(@"Select * from `online_foods`.`order` where (`order`.`execution_date`=@date) AND (`order`.`state`<>3 AND `order`.`state`<>-1)");
            try
            {
                adapter.SelectCommand.Parameters.Add("@date", MySqlDbType.Date, 9, "`execution_date`").Value = date.Replace('.', '-');
                adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                    or.IdOrder = row["id_order"].ToString();
                    or.Addres = row["adress"].ToString();
                    or.Phone = row["phone"].ToString();
                    DateTime d = DateTime.Parse(row["date_order"].ToString());
                    or.OrderDate = d.ToString("yyyy-MM-dd");
                    d = DateTime.Parse(row["execution_date"].ToString());
                    or.ExecutionDate = d.ToString("yyyy-MM-dd");
                    or.ExecutionTime = row["execution_time"].ToString();
                    or.Info = row["info"].ToString();
                    or.OrderDiscount = row["sum_discount"].ToString();
                    or.OrderSum = row["sum_order"].ToString();
                    or.State = row["state"].ToString();

                    adapter.SelectCommand = new MySqlCommand(@"Select `id_dish`,`count` from `online_foods`.`order_rows` where `id_order`=@id_order");
                    adapter.SelectCommand.Parameters.Add("@id_order", MySqlDbType.Int32, 11, "`id_order`").Value = or.IdOrder;
                    adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);

                    Double time = 0;
                    foreach (DataRow row1 in dt1.Rows)
                    {
                        adapter.SelectCommand = new MySqlCommand(@"Select `time` from `online_foods`.`dish` where `dish`.`id_dish`=@id_dish");
                        adapter.SelectCommand.Parameters.Clear();
                        adapter.SelectCommand.Parameters.Add("@id_dish", MySqlDbType.Int32, 11, "`id_dish`").Value = row1["id_dish"].ToString();
                        adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        Double buf = 0;
                        try
                        {
                            DateTime da = DateTime.Parse(table.Rows[0][0].ToString());
                            buf = da.Hour + da.Minute;
                        }
                        catch
                        {
                            buf = 0;
                        }

                        if (time <= buf) time = buf;

                    }
                    or.PreparationTime = time.ToString();
                    orders.Add(or);
                }

                return orders;
            }
            catch
            {
                return null;
            }
        }

        public List<CommunicationLibrary.Dish> GetOrderComponents(String idOrder)
        {
            List<CommunicationLibrary.Dish> dishList = new List<CommunicationLibrary.Dish>();
            try
            {
                adapter.SelectCommand = new MySqlCommand(@"Select `id_dish`,`count` from `online_foods`.`order_rows` where `order_rows`.`id_order`=@idOrder");
                adapter.SelectCommand.Parameters.Add("@idOrder", MySqlDbType.Int32, 11, "`id_order`").Value = idOrder;
                adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.SelectCommand.Connection.Open();
                adapter.Fill(dt);
                adapter.SelectCommand.Connection.Close();

                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Dish dish = new CommunicationLibrary.Dish();
                    dish.Count = row["count"].ToString();

                    adapter.SelectCommand = new MySqlCommand(@"Select * from `online_foods`.`dish` where `dish`.`id_dish`=@idDish");
                    adapter.SelectCommand.Parameters.Add("@idDish", MySqlDbType.Int32, 11, "`id_dish`").Value = row["id_dish"].ToString();
                    adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.SelectCommand.Connection.Open();
                    adapter.Fill(dt1);
                    adapter.SelectCommand.Connection.Close();

                    dish.IdDish = dt1.Rows[0]["id_dish"].ToString();
                    dish.Name = dt1.Rows[0]["name"].ToString();
                    dish.Time = dt1.Rows[0]["time"].ToString();
                    dish.Info = dt1.Rows[0]["info"].ToString();
                    dish.Tags = dt1.Rows[0]["tags"].ToString();
                    dish.Recipe = dt1.Rows[0]["receipt"].ToString();
                    dish.Price = dt1.Rows[0]["price"].ToString();
                    dishList.Add(dish);
                }
                return dishList;
            }
            catch
            {
                return null;
            }
        }

        public List<CommunicationLibrary.Order> GetOrdersByDate(String beginDate, String endDate)
        {
            List<CommunicationLibrary.Order> orList = new List<CommunicationLibrary.Order>();
            try
            {
                adapter.SelectCommand = new MySqlCommand(@"Select * from `online_foods`.`order` where `order`.`date_order`>=@beginDate AND `order`.`date_order`<=@endDate");
                adapter.SelectCommand.Parameters.Add("@beginDate", MySqlDbType.DateTime, 11, "`date_order`").Value = beginDate;
                adapter.SelectCommand.Parameters.Add("@endDate", MySqlDbType.DateTime, 11, "`date_order`").Value = endDate;
                adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.SelectCommand.Connection.Open();
                adapter.Fill(dt);
                adapter.SelectCommand.Connection.Close();
                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                    or.IdOrder = row["id_order"].ToString();
                    or.Addres = row["adress"].ToString();
                    or.Phone = row["phone"].ToString();
                    DateTime d = DateTime.Parse(row["date_order"].ToString());
                    or.OrderDate = d.ToString("yyyy-MM-dd");
                    d = DateTime.Parse(row["execution_date"].ToString());
                    or.ExecutionDate = d.ToString("yyyy-MM-dd");
                    or.ExecutionTime = row["execution_time"].ToString();
                    or.Info = row["info"].ToString();
                    or.OrderDiscount = row["sum_discount"].ToString();
                    or.OrderSum = row["sum_order"].ToString();
                    or.State = row["state"].ToString();

                    adapter.SelectCommand = new MySqlCommand(@"Select `id_dish`,`count` from `online_foods`.`order_rows` where `id_order`=@id_order");
                    adapter.SelectCommand.Parameters.Add("@id_order", MySqlDbType.Int32, 11, "`id_order`").Value = or.IdOrder;
                    adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);

                    Double time = 0;
                    foreach (DataRow row1 in dt1.Rows)
                    {
                        adapter.SelectCommand = new MySqlCommand(@"Select `time` from `online_foods`.`dish` where `dish`.`id_dish`=@id_dish");
                        adapter.SelectCommand.Parameters.Clear();
                        adapter.SelectCommand.Parameters.Add("@id_dish", MySqlDbType.Int32, 11, "`id_dish`").Value = row1["id_dish"].ToString();
                        adapter.SelectCommand.Connection = new MySqlConnection(connectionString);
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        Double buf = 0;
                        try
                        {
                            DateTime da = DateTime.Parse(table.Rows[0][0].ToString());
                            buf = da.Hour + da.Minute;
                        }
                        catch
                        {
                            buf = 0;
                        }

                        if (time <= buf) time = buf;

                    }
                    or.PreparationTime = time.ToString();
                    orList.Add(or);
                }
                return orList;
            }
            catch
            {
                return null;
            }
        }
    }
}
