/// Copyright 2009. Agus Kurniawan
/// Contact: agusk2007@gmail.com
/// http://www.aguskurniawan.net
/// http://geeks.netindonesia.net/blogs/agus 


using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using ZedGraph;
namespace BackNNSimulation
{
    public partial class NNTrainingView : Form
    {
        private BackPro _backpro;

        public BackPro BackproData
        {           
            set
            {
                if (_backpro == value)
                    return;
                _backpro = value;
            }
        }

        public NNTrainingView()
        {
            InitializeComponent();
        }

        public void Populate()
        {
            if (_backpro != null)
            {
                GraphPane pane = this.zedGraphControl1.GraphPane;

                pane.Title.Text = "Backpro NN Training Result";
                pane.XAxis.Title.Text = "Epoch";                               
                pane.YAxis.Title.Text = "Error";
                pane.Chart.Fill = new Fill(Color.White, Color.FromArgb(255, 255, 166), 90F);
                pane.Fill = new Fill(Color.FromArgb(250, 250, 255));

                
                PointPairList list1 = new PointPairList();
                for (int i = 0; i < _backpro.YOutput.Count; i++)
                {
                    list1.Add((double)(i + 1), (double)_backpro.YOutput[i][0]);

                }                    
                LineItem line = pane.AddCurve("Training", list1, Color.Red, SymbolType.None);

                this.zedGraphControl1.IsShowPointValues = true;
                this.zedGraphControl1.AxisChange();
            }
        }

        private void NNTrainingView_Resize(object sender, EventArgs e)
        {
            this.zedGraphControl1.Location = new Point(10, 10);
            this.zedGraphControl1.Size = new Size(ClientRectangle.Width - 20, ClientRectangle.Height - 20);
        }
    }
}
