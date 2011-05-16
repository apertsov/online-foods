using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.Threading;
using System.Data;
//using Sql.Data;
//using Sql.Data.SqlClient;
//using Sql.Data.Types;
using System.Data.SqlClient;

//using System.Net;
//using System.Net.Sockets;

namespace Communication
{
    [ServiceBehavior(
        InstanceContextMode = InstanceContextMode.Single,
        ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class CommunicationService: CommunicationLibrary.ICommunication
    {
        string connectionString = @"Data Source=.\SQLEXPRESS;AttachDbFilename=C:\Data\online_foods.mdf;Integrated Security=True;Connect Timeout=30;User Instance=True";
        SqlConnection connection = new SqlConnection();
        SqlDataAdapter adapter = new SqlDataAdapter();
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
            Boolean isPre = false;
            connection.ConnectionString = connectionString;
            adapter.SelectCommand = new SqlCommand("Select * from [order]");
            adapter.SelectCommand.Connection = new SqlConnection(connectionString);
            adapter.Fill(data);

            adapter.InsertCommand = new SqlCommand(@"INSERT INTO [order]([date_order],[id_agent],[info],[execution_time],[execution_date],[sum_order],[sum_discount],[state],[phone],[adress])
                                                        VALUES (@date_order,@id_agent,@info, @execution_time,@execution_date,@sum_order,@sum_discount,@state,@phone,@adress);");
            try
            {
                adapter.InsertCommand.Parameters.Add("@date_order", SqlDbType.Date, 12, "[date_order]").Value = order.OrderDate.Replace('.', '-');
            }
            catch
            {
                adapter.InsertCommand.Parameters["@date_order"].Value = DBNull.Value;
            }
            if (!string.IsNullOrEmpty(order.IdUser))
                adapter.InsertCommand.Parameters.Add("@id_agent", SqlDbType.Int, 11, "[id_agent]").Value = order.IdUser;
            else
                adapter.InsertCommand.Parameters.Add("@id_agent", SqlDbType.Int, 11, "[id_agent]").Value = DBNull.Value;
            if (!string.IsNullOrEmpty(order.Info))
                adapter.InsertCommand.Parameters.Add("@info", SqlDbType.VarChar, 1000, "[info]").Value =  order.Info;
            else
                adapter.InsertCommand.Parameters.Add("@info", SqlDbType.VarChar, 1000, "[info]").Value = DBNull.Value;
            if (String.IsNullOrEmpty(order.ExecutionTime))
                adapter.InsertCommand.Parameters.Add("@execution_time", SqlDbType.DateTime, 10, "[execution_time]").Value = DBNull.Value;
            else
            {
                adapter.InsertCommand.Parameters.Add("@execution_time", SqlDbType.DateTime, 10, "[execution_time]").Value = order.ExecutionTime;
                isPre = true;
            }
            try
            {
                adapter.InsertCommand.Parameters.Add("@execution_date", SqlDbType.Date, 12, "[execution_date]").Value = order.ExecutionDate.Replace('.', '-');
            }
            catch
            {
                adapter.InsertCommand.Parameters["@execution_date"].Value = DBNull.Value;
            }
            if (!String.IsNullOrEmpty(order.OrderSum))
                adapter.InsertCommand.Parameters.Add("@sum_order", SqlDbType.Decimal, 10, "[sum_order]").Value = order.OrderSum;
            else
                adapter.InsertCommand.Parameters.Add("@sum_order", SqlDbType.Decimal, 10, "[sum_order]").Value = DBNull.Value;
            if (!String.IsNullOrEmpty(order.OrderDiscount))
                adapter.InsertCommand.Parameters.Add("@sum_discount", SqlDbType.Decimal, 10, "[sum_discount]").Value = order.OrderDiscount;
            else
                adapter.InsertCommand.Parameters.Add("@sum_discount", SqlDbType.Decimal, 10, "[sum_discount]").Value = DBNull.Value;
            if(isPre)
                adapter.InsertCommand.Parameters.Add("@state", SqlDbType.Int, 4, "[state]").Value = 1;
            else
            adapter.InsertCommand.Parameters.Add("@state", SqlDbType.Int, 4, "[state]").Value = 0;
            if (!String.IsNullOrEmpty(order.Phone))
                adapter.InsertCommand.Parameters.Add("@phone", SqlDbType.VarChar, 45, "[phone]").Value = order.Phone;
            else
                adapter.InsertCommand.Parameters.Add("@phone", SqlDbType.VarChar, 45, "[phone]").Value = DBNull.Value;
            if (!String.IsNullOrEmpty(order.Addres))
                adapter.InsertCommand.Parameters.Add("@adress", SqlDbType.VarChar, 45, "[adress]").Value = order.Addres;
            else
                adapter.InsertCommand.Parameters.Add("@adress", SqlDbType.VarChar, 45, "[adress]").Value = DBNull.Value;
            adapter.InsertCommand.Connection = new SqlConnection(connectionString);
            adapter.InsertCommand.Connection.Open();
            adapter.InsertCommand.ExecuteNonQuery();
            adapter.InsertCommand.Connection.Close();
            
            data = new DataSet();
            adapter.Fill(data);
            Double time = 0;
            order.IdOrder = data.Tables[0].Rows[data.Tables[0].Rows.Count - 1][0].ToString();
            foreach (KeyValuePair<String, String> row in order.DishCount)
            {
                adapter.InsertCommand = new SqlCommand(@" INSERT INTO [order_rows]([id_order],[id_dish],[count]) 
                                                        VALUES (@id_order,@id_dish,@count);");
                adapter.InsertCommand.Parameters.Add("@id_order", SqlDbType.Int, 11, "[id_order]").Value = order.IdOrder;
                adapter.InsertCommand.Parameters.Add("@id_dish", SqlDbType.Int, 11, "[id_dish]").Value = row.Key;
                adapter.InsertCommand.Parameters.Add("@count", SqlDbType.Decimal, 15, "[count]").Value = row.Value;
                adapter.InsertCommand.Connection = new SqlConnection(connectionString);
                adapter.InsertCommand.Connection.Open();
                adapter.InsertCommand.ExecuteNonQuery();
                adapter.InsertCommand.Connection.Close();

                
                try
                {
                    adapter.SelectCommand = new SqlCommand(@"Select [dish].[time]from [dish]where [id_dish]=@id_dish");
                    adapter.SelectCommand.Parameters.Add("@id_dish", SqlDbType.Int, 11, "[id_dish]").Value = row.Key;
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    DateTime d = DateTime.Parse(dt.Rows[0][0].ToString());
                    Double buf = d.Hour*60 + d.Minute;
                    if (time <= buf) time = buf;
                    
                }
                catch { }
            }
            adapter.SelectCommand = new SqlCommand("Select * from [order]");
            adapter.SelectCommand.Connection = new SqlConnection(connectionString);
            order.PreparationTime = time.ToString();;

            return order.IdOrder ;
        }

        public String GetState(String idOrder)
        {
            adapter.SelectCommand = new SqlCommand("Select [order].[state]from [order]where [order].[id_order]=@id_order");
            adapter.SelectCommand.Parameters.Add("@id_order", SqlDbType.Int, 11, "[id_order]").Value = Int32.Parse(idOrder);
            adapter.SelectCommand.Connection = new SqlConnection(connectionString);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            adapter.SelectCommand = new SqlCommand("Select * from [order]");
            adapter.SelectCommand.Connection = new SqlConnection(connectionString);
            adapter.Fill(data);

            return dt.Rows[0][0].ToString();
            
        }

        public void SetState(String idOrder, String state)
        {
            adapter.UpdateCommand = new SqlCommand(@"UPDATE [order] SET [state]=@state  WHERE [id_order]=@id_order;");
            adapter.UpdateCommand.Connection = new SqlConnection(connectionString);
            try
            {

                adapter.UpdateCommand.Parameters.Add("@id_order", SqlDbType.Int, 11, "[id_order]").Value = Int32.Parse(idOrder);
                adapter.UpdateCommand.Parameters.Add("@state", SqlDbType.Int,4, "[state]").Value = Int32.Parse(state);
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
            adapter.SelectCommand = new SqlCommand(@"Select * from [order] where ([order].[execution_date]=@date) AND ([order].[state]<>3 AND [order].[state]<>-1)");
            try
            {
                adapter.SelectCommand.Parameters.Add("@date", SqlDbType.Date, 9, "[execution_date]").Value = date.Replace('.', '-') + " 00:00:00";
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                    or.IdOrder = row["id_order"].ToString();
                    or.Addres = row["adress"].ToString();
                    or.Phone = row["phone"].ToString();
                    DateTime d = DateTime.Parse(row["date_order"].ToString());
                    or.OrderDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    d = DateTime.Parse(row["execution_date"].ToString());
                    or.ExecutionDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    or.ExecutionTime = row["execution_time"].ToString().Substring(row["execution_time"].ToString().IndexOf(" ") + 1, row["execution_time"].ToString().Length - row["execution_time"].ToString().IndexOf(" ") -1);
                    if (or.ExecutionTime == "00:00:00") or.ExecutionTime = "";
                    or.Info = row["info"].ToString();
                    or.OrderDiscount = row["sum_discount"].ToString();
                    or.OrderSum = row["sum_order"].ToString();
                    or.State = row["state"].ToString();

                    adapter.SelectCommand = new SqlCommand(@"Select [id_dish],[count] from [order_rows]where [id_order]=@id_order");
                    adapter.SelectCommand.Parameters.Add("@id_order", SqlDbType.Int, 11, "[id_order]").Value = or.IdOrder;
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);

                    Double time = 0;
                    foreach (DataRow row1 in dt1.Rows)
                    {
                        adapter.SelectCommand = new SqlCommand(@"Select [time] from [dish]where [dish].[id_dish]=@id_dish");
                        adapter.SelectCommand.Parameters.Clear();
                        adapter.SelectCommand.Parameters.Add("@id_dish", SqlDbType.Int, 11, "[id_dish]").Value = row1["id_dish"].ToString();
                        adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        Double buf = 0;
                        try
                        {
                            DateTime da = DateTime.Parse(table.Rows[0][0].ToString());
                            buf = da.Hour*60 + da.Minute;
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
                adapter.SelectCommand = new SqlCommand(@"Select [id_dish],[count]from [order_rows]where [order_rows].[id_order]=@idOrder");
                adapter.SelectCommand.Parameters.Add("@idOrder", SqlDbType.Int, 11, "[id_order]").Value = idOrder;
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);


                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Dish dish = new CommunicationLibrary.Dish();
                    dish.Count = row["count"].ToString();

                    adapter.SelectCommand = new SqlCommand(@"Select * from [dish]where [dish].[id_dish]=@idDish");
                    adapter.SelectCommand.Parameters.Add("@idDish", SqlDbType.Int, 11, "[id_dish]").Value = row["id_dish"].ToString();
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);
                    if (dt1 != null && dt1.Rows.Count!=0)
                    {
                        dish.IdDish = dt1.Rows[0]["id_dish"].ToString();
                        dish.Name = dt1.Rows[0]["name"].ToString();
                        dish.Time = dt1.Rows[0]["time"].ToString();
                        dish.Info = dt1.Rows[0]["info"].ToString();
                        dish.Tags = dt1.Rows[0]["tags"].ToString();
                        dish.Recipe = dt1.Rows[0]["receipt"].ToString();
                        dish.Price = dt1.Rows[0]["price"].ToString();
                        dishList.Add(dish);
                    }
                }
                return dishList;
            }
            catch
            {
                return null;
            }
        }

        public List<CommunicationLibrary.Order> GetPreOrders(String currentDate, String currentTime)
        {
            List<CommunicationLibrary.Order> orList = new List<CommunicationLibrary.Order>();
            try
            {
                adapter.SelectCommand = new SqlCommand(@"Select * from [order]where [order].[state]=1");
                adapter.SelectCommand.Parameters.Add("@date", SqlDbType.DateTime, 11, "[execution_date]").Value = currentDate;
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                adapter.SelectCommand.Connection.Close();

                DateTime time = DateTime.Parse(currentDate+" "+currentTime);
                foreach (DataRow row in dt.Rows)
                {
                    DateTime time1 = DateTime.Parse("01/01/0001 00:00:00");
                    try
                    {
                        time1 = DateTime.Parse(row[4].ToString());
                    }
                    catch
                    {
                        continue;
                    }

                    adapter.SelectCommand = new SqlCommand(@"Select [id_dish],[count] from [order_rows]where [id_order]=@id_order");
                    adapter.SelectCommand.Parameters.Add("@id_order", SqlDbType.Int, 11, "[id_order]").Value = row["id_order"].ToString();
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);

                    Double time2 = 0;
                    DateTime time3 = DateTime.Parse("01/01/0001 00:00:00");
                    foreach (DataRow row1 in dt1.Rows)
                    {
                        adapter.SelectCommand = new SqlCommand(@"Select [time] from [dish]where [dish].[id_dish]=@id_dish");
                        adapter.SelectCommand.Parameters.Clear();
                        adapter.SelectCommand.Parameters.Add("@id_dish", SqlDbType.Int, 11, "[id_dish]").Value = row1["id_dish"].ToString();
                        adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        if (table.Rows.Count != 0)
                        {
                            DateTime da = new DateTime(0);
                            Double buf = 0;
                            try
                            {
                                da = DateTime.Parse("01/01/0001 "+table.Rows[0][0].ToString().Substring(table.Rows[0][0].ToString().IndexOf(" ")+1,table.Rows[0][0].ToString().Length-table.Rows[0][0].ToString().IndexOf(" ")-1));
                                buf = da.Hour * 60 + da.Minute;
                            }
                            catch
                            {
                                buf = 0;
                            }

                            if (time2 <= buf)
                            {
                                time2 = buf;
                                time3 = da;
                            }

                        }
                    }

                   time3+= new TimeSpan(1, 0, 0);
                   DateTime time4 = new DateTime(0);

                   time4 = time1.Subtract(new TimeSpan(time3.Ticks));


                   if ( ( time4<= time) && (time3.ToString()!="1/1/0001 01:00:00") && (time4.ToShortDateString()==currentDate))
                   {
                       CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                       or.IdOrder = row["id_order"].ToString();
                       or.Addres = row["adress"].ToString();
                       or.Phone = row["phone"].ToString();
                       DateTime d = DateTime.Parse(row["date_order"].ToString());
                       or.OrderDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                       d = DateTime.Parse(row["execution_date"].ToString());
                       or.ExecutionDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                       or.ExecutionTime = row["execution_time"].ToString().Substring(row["execution_time"].ToString().IndexOf(" ") + 1, row["execution_time"].ToString().Length - row["execution_time"].ToString().IndexOf(" ") - 1);
                       if (or.ExecutionTime == "00:00:00") or.ExecutionTime = "";
                       or.Info = row["info"].ToString();
                       or.OrderDiscount = row["sum_discount"].ToString();
                       or.OrderSum = row["sum_order"].ToString();
                       or.State = row["state"].ToString();
                       or.PreparationTime = time2.ToString();
                       orList.Add(or);
                   }
                }
                return orList;
            }
            catch
            {
                return null;

            }
        }

        public void ChangeGood(CommunicationLibrary.Good good)
        {
            try
            {
                adapter.UpdateCommand = new SqlCommand(@"Update [Goods] Set [Goods].[good_name]=@good_name,[Goods].[good_curprice]=@good_curprice where [Goods].[good_id]=@good_id;");
                adapter.UpdateCommand.Parameters.Add("@good_name", SqlDbType.VarChar, 50, "[good_name]").Value = good.Name;
                adapter.UpdateCommand.Parameters.Add("@good_curprice", SqlDbType.Int, 11, "[good_curprice]").Value = good.Price;
                adapter.UpdateCommand.Parameters.Add("@good_id", SqlDbType.Int, 11, "[good_id]").Value = good.Id;
                adapter.UpdateCommand.Connection = new SqlConnection(connectionString);

                adapter.UpdateCommand.Connection.Open();
                adapter.UpdateCommand.ExecuteNonQuery();
                adapter.UpdateCommand.Connection.Close();

                
            }
            catch
            {
            }
        }

        public void BuyGoods(String id, String count)
        {
            try
            {
                adapter.SelectCommand = new SqlCommand(@"Select [Goods].[good_count],[Goods].[good_curprice] From [Goods]Where [Goods].[good_id]=@good_id;");
                adapter.SelectCommand.Parameters.Add("@good_id", SqlDbType.Int, 11, "[good_id]").Value = id;
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                Int32 price = Int32.Parse(dt.Rows[0]["good_curprice"].ToString());
                Int32 c = Int32.Parse(dt.Rows[0]["good_count"].ToString()) + Int32.Parse(count);
                adapter.UpdateCommand = new SqlCommand(@"Update [Goods] Set [Goods].[good_count]=@good_count where [Goods].[good_id]=@good_id;");
                adapter.UpdateCommand.Parameters.Add("@good_count", SqlDbType.Int, 11, "[good_count]").Value = c;
                adapter.UpdateCommand.Parameters.Add("@good_id", SqlDbType.Int, 11, "[good_id]").Value =id;
                adapter.UpdateCommand.Connection = new SqlConnection(connectionString);

                adapter.UpdateCommand.Connection.Open();
                adapter.UpdateCommand.ExecuteNonQuery();
                adapter.UpdateCommand.Connection.Close();

                adapter.InsertCommand = new SqlCommand(@"Insert Into [SalesOperations]([so_time]) Values(@so_time);");
                adapter.InsertCommand.Parameters.Add("@so_time", SqlDbType.DateTime, 20, "[so_time]").Value = DateTime.Now.ToString();
                adapter.InsertCommand.Connection = new SqlConnection(connectionString);
                adapter.InsertCommand.Connection.Open();
                adapter.InsertCommand.ExecuteNonQuery();
                adapter.InsertCommand.Connection.Close();

                adapter.SelectCommand = new SqlCommand(@"Select * from [SalesOperations]");
                dt = new DataTable();
                adapter.SelectCommand.Connection= new SqlConnection(connectionString);
                adapter.Fill(dt);

                String id1 = dt.Rows[dt.Rows.Count - 1]["so_id"].ToString();

                adapter.InsertCommand = new SqlCommand(@"Insert into [GoodsSales]([gs_so_id],[gs_good_id],[gs_count],[gs_price]) Values(@gs_so_id,@gs_good_id,@gs_count,@gs_price) ");
                adapter.InsertCommand.Parameters.Add("@gs_so_id", SqlDbType.Int, 11, "[gs_so_id]").Value = id1;
                adapter.InsertCommand.Parameters.Add("@gs_good_id", SqlDbType.Int, 11, "[gs_good_id]").Value = id;
                adapter.InsertCommand.Parameters.Add("@gs_count", SqlDbType.Int, 11, "[gs_count]").Value = count;
                adapter.InsertCommand.Parameters.Add("@gs_price", SqlDbType.Int, 11, "[gs_price]").Value = Int32.Parse(count) * price;

                adapter.InsertCommand.Connection = new SqlConnection(connectionString);
                adapter.InsertCommand.Connection.Open();
                adapter.InsertCommand.ExecuteNonQuery();
                adapter.InsertCommand.Connection.Close();

            }
            catch
            {
            }
        }

        public List<CommunicationLibrary.Good> GetGoods()
        {
            List<CommunicationLibrary.Good> goodList = new List<CommunicationLibrary.Good>();
            try
            {
                adapter.SelectCommand = new SqlCommand(@"Select * from [Goods]");
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                if(dt!=null)
                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Good good = new CommunicationLibrary.Good();
                    good.Id = row["good_id"].ToString();
                    good.Name = row["good_name"].ToString();
                    good.Count = row["good_count"].ToString();
                    good.Price = row["good_curprice"].ToString();
                    goodList.Add(good);
                }

                return goodList;
            }
            catch
            {
                return null;
            }
        }

        public List<CommunicationLibrary.Order> GetLostMoney(String beginDate, String endDate)
        {
            List<CommunicationLibrary.Order> salesList = new List<CommunicationLibrary.Order>();
            try
            {
                
                adapter.SelectCommand = new SqlCommand(@"Select * from [order] where [order].[execution_date]>=@beginDate AND [order].[execution_date]<=@endDate AND [order].[state]=-1;");
                adapter.SelectCommand.Parameters.Add("@beginDate", SqlDbType.DateTime, 11, "[execution_date]").Value = beginDate + " 00:00:00";
                adapter.SelectCommand.Parameters.Add("@endDate", SqlDbType.DateTime, 11, "[execution_date]").Value = endDate + " 00:00:00";
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                if(dt!=null)
                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                    or.IdOrder = row["id_order"].ToString();
                    or.Addres = row["adress"].ToString();
                    or.Phone = row["phone"].ToString();
                    DateTime d = DateTime.Parse(row["date_order"].ToString());
                    or.OrderDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    d = DateTime.Parse(row["execution_date"].ToString());
                    or.ExecutionDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    or.ExecutionTime = row["execution_time"].ToString().Substring(row["execution_time"].ToString().IndexOf(" ") + 1, row["execution_time"].ToString().Length - row["execution_time"].ToString().IndexOf(" ") - 1);
                    if (or.ExecutionTime == "00:00:00") or.ExecutionTime = "";
                    or.Info = row["info"].ToString();
                    or.OrderDiscount = row["sum_discount"].ToString();
                    or.OrderSum = row["sum_order"].ToString();
                    or.State = row["state"].ToString();

                    salesList.Add(or);
                }

                return salesList;
            }
            catch
            {
                return null;
            }
        }

        public CommunicationLibrary.Good GetGoodById(String id)
        {
            try
            {
                CommunicationLibrary.Good good = new CommunicationLibrary.Good();

                adapter.SelectCommand = new SqlCommand(@"Select * from [Goods] where [good_id]=@good_id;");
                adapter.SelectCommand.Parameters.Add("@good_id", SqlDbType.Int, 11, "[good_id]").Value = id;
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);

                DataTable dt = new DataTable();
                adapter.Fill(dt);

                good.Id = dt.Rows[0]["good_id"].ToString();
                good.Name = dt.Rows[0]["good_name"].ToString();
                good.Count = dt.Rows[0]["good_count"].ToString();
                good.Price = dt.Rows[0]["good_curprice"].ToString();

                return good;
            }
            catch
            {
                return null;
            }
        }

        public List<CommunicationLibrary.Good> GetSpentMoney(String beginDate, String endDate)
        {
            List<CommunicationLibrary.Good> goodList = new List<CommunicationLibrary.Good>();
            try
            {
                adapter.SelectCommand = new SqlCommand(@"Select * from [SalesOperations] where [so_time]>=@beginDate AND [so_time]<=@endDAte");
                adapter.SelectCommand.Parameters.Add("@beginDate", SqlDbType.DateTime, 11, "[so_time]").Value = beginDate+" "+"00:00:00";
                adapter.SelectCommand.Parameters.Add("@endDate", SqlDbType.DateTime, 11, "[so_time]").Value = endDate + " " + "23:59:59";
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                if(dt!=null)
                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Good good = new CommunicationLibrary.Good();
                    good.Date = row["so_time"].ToString();
                    adapter.SelectCommand = new SqlCommand(@"Select * from [GoodsSales]where [gs_so_id]=@gs_so_id");
                    adapter.SelectCommand.Parameters.Add("@gs_so_id", SqlDbType.Int, 11, "[gs_so_id]").Value = row["so_id"].ToString();
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);

                    if (dt1.Rows.Count == 0) continue;
                    good.Id = dt1.Rows[0]["gs_good_id"].ToString();
                    good.Price = dt1.Rows[0]["gs_price"].ToString();
                    good.Count = dt1.Rows[0]["gs_count"].ToString();

                    adapter.SelectCommand = new SqlCommand(@"Select * from [Goods]where [good_id]=@good_id");
                    adapter.SelectCommand.Parameters.Add("@good_id", SqlDbType.Int, 11, "[good_id]").Value = dt1.Rows[0]["gs_good_id"].ToString();
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    dt1 = new DataTable();
                    adapter.Fill(dt1);

                    good.Name = dt1.Rows[0]["good_name"].ToString();

                    goodList.Add(good);
                }
                return goodList;
            }
            catch
            {
                return null;
            }
        }

        public List<CommunicationLibrary.Order> GetRecievedMoney(String beginDate, String endDate)
        {
            List<CommunicationLibrary.Order> salesList = new List<CommunicationLibrary.Order>();
            try
            {
                adapter.SelectCommand = new SqlCommand(@"Select * from [order]where [order].[execution_date]>=@beginDate AND [order].[execution_date]<=@endDate AND [order].[state]=3;");
                adapter.SelectCommand.Parameters.Add("@beginDate", SqlDbType.DateTime, 11, "[execution_date]").Value = beginDate;
                adapter.SelectCommand.Parameters.Add("@endDate", SqlDbType.DateTime, 11, "[execution_date]").Value = endDate;
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                if(dt!=null)
                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                    or.IdOrder = row["id_order"].ToString();
                    or.Addres = row["adress"].ToString();
                    or.Phone = row["phone"].ToString();
                    DateTime d = DateTime.Parse(row["date_order"].ToString());
                    or.OrderDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    d = DateTime.Parse(row["execution_date"].ToString());
                    or.ExecutionDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    or.ExecutionTime = row["execution_time"].ToString().Substring(row["execution_time"].ToString().IndexOf(" ") + 1, row["execution_time"].ToString().Length - row["execution_time"].ToString().IndexOf(" ") - 1);
                    if (or.ExecutionTime == "00:00:00") or.ExecutionTime = "";
                    or.Info = row["info"].ToString();
                    or.OrderDiscount = row["sum_discount"].ToString();
                    or.OrderSum = row["sum_order"].ToString();
                    or.State = row["state"].ToString();

                    salesList.Add(or);
                }

                return salesList;
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
                adapter.SelectCommand = new SqlCommand(@"Select * from [order]where [order].[date_order]>=@beginDate AND [order].[date_order]<=@endDate");
                adapter.SelectCommand.Parameters.Add("@beginDate", SqlDbType.DateTime, 11, "[date_order]").Value = beginDate;
                adapter.SelectCommand.Parameters.Add("@endDate", SqlDbType.DateTime, 11, "[date_order]").Value = endDate;
                adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                foreach (DataRow row in dt.Rows)
                {
                    CommunicationLibrary.Order or = new CommunicationLibrary.Order();
                    or.IdOrder = row["id_order"].ToString();
                    or.Addres = row["adress"].ToString();
                    or.Phone = row["phone"].ToString();
                    DateTime d = DateTime.Parse(row["date_order"].ToString());
                    or.OrderDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    d = DateTime.Parse(row["execution_date"].ToString());
                    or.ExecutionDate = d.ToString().Substring(0, d.ToString().IndexOf(" "));
                    or.ExecutionTime = row["execution_time"].ToString().Substring(row["execution_time"].ToString().IndexOf(" ") + 1, row["execution_time"].ToString().Length - row["execution_time"].ToString().IndexOf(" ") - 1);
                    if (or.ExecutionTime == "00:00:00") or.ExecutionTime = "";
                    or.Info = row["info"].ToString();
                    or.OrderDiscount = row["sum_discount"].ToString();
                    or.OrderSum = row["sum_order"].ToString();
                    or.State = row["state"].ToString();

                    adapter.SelectCommand = new SqlCommand(@"Select [id_dish],[count]from [order_rows]where [id_order]=@id_order");
                    adapter.SelectCommand.Parameters.Add("@id_order", SqlDbType.Int, 11, "[id_order]").Value = or.IdOrder;
                    adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                    DataTable dt1 = new DataTable();
                    adapter.Fill(dt1);

                    Double time = 0;
                    foreach (DataRow row1 in dt1.Rows)
                    {
                        adapter.SelectCommand = new SqlCommand(@"Select [time]from [dish]where [dish].[id_dish]=@id_dish");
                        adapter.SelectCommand.Parameters.Clear();
                        adapter.SelectCommand.Parameters.Add("@id_dish", SqlDbType.Int, 11, "[id_dish]").Value = row1["id_dish"].ToString();
                        adapter.SelectCommand.Connection = new SqlConnection(connectionString);
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        Double buf = 0;
                        try
                        {
                            DateTime da = DateTime.Parse(table.Rows[0][0].ToString());
                            buf = da.Hour*60 + da.Minute;
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
