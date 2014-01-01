/// Copyright 2009. Agus Kurniawan
/// Contact: agusk2007@gmail.com
/// http://www.aguskurniawan.net
/// http://geeks.netindonesia.net/blogs/agus 


using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace BackNNSimulation
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }
    }
}
