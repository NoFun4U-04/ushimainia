using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class menuQuanLy : Form
    {
        public menuQuanLy()
        {
            InitializeComponent();
        }
        //ham hien thi ngay
        public void time()
        {
            CultureInfo viVN = new CultureInfo("vi-VN");
            DateTime now = DateTime.Now;
            // Định dạng giống như trong ảnh bạn gửi
            string formattedTime = now.ToString("dddd, dd MMMM yyyy, h:mm tt", viVN);
            // Viết hoa chữ cái đầu của thứ (ví dụ: "Thứ sáu" → "Thứ Sáu")
            formattedTime = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(formattedTime);
            // Gán vào Label
            timeNow.Text = formattedTime;

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void menuQuanLy_Load(object sender, EventArgs e)
        {
            time();


        }
    }
}
