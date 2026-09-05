using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebBanLaptop
{
    public class Ketnoi
    {
        public SqlConnection con = new SqlConnection("Data Source=.\\sqlexpress;Initial Catalog=web_laptop_db;Interated Security=True");

    }
}