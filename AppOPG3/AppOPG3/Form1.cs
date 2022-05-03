using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace AppOPG3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int top = 100;
            int left = 10;
            int offset = 40;
            String[] tasks = { "Plan", "Products", "Process", "Delivery" };
            for (int i = 0; i < tasks.Length; i++)
            {
                Button button = new Button();
                button.Text = tasks[i];
                button.Left = left + offset * i;
                button.Top = top;
                this.Controls.Add(button);
                top += button.Height + 2;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            //ConnectToMySQL();
            
        }

        private void Connection()
        {
            SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\jekj.skp\\Desktop\\AppOPG3\\AppOPG3\\DB1.mdf;Integrated Security=True");
            con.Open();

        }
    }
}
