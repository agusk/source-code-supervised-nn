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

namespace BackNNSimulation
{
    public partial class MainForm : Form
    {
        private int _totalInput;
        private int _totalHidden;
        private int _totalTarget;
        private int _tf = 0;
        private int _nLoop;
        private BackPro _backPro;

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            
            
        }

        private void SetupInputGridView()
        {
            this.dgInput.ColumnCount = 2;            
            this.dgInput.RowHeadersVisible = false;
            this.dgInput.Columns[0].Name = "No";
            this.dgInput.Columns[1].Name = "Data";
            this.dgInput.Columns[0].ValueType = typeof(System.Int32);
            this.dgInput.Columns[0].ReadOnly = true;
            this.dgInput.Columns[0].DefaultCellStyle.BackColor = Color.Gainsboro;
            this.dgInput.Columns[0].Width = 50;

            this.dgInput.Columns[1].ValueType = typeof(System.Double);
            this.dgInput.Columns[1].Width = 70;
            this.dgInput.SelectionMode = DataGridViewSelectionMode.CellSelect;
            this.dgInput.MultiSelect = false;
            this.dgInput.AllowUserToAddRows = false;
            this.dgInput.AllowUserToDeleteRows = false;
            this.dgInput.ScrollBars = ScrollBars.Both;
                       
            this.dgInput.DataError += new DataGridViewDataErrorEventHandler(dataGridView1_DataError);

            for (int i = 0; i < this._totalInput; i++)
            {
                List<string> rows = new List<string>();
                rows.Add(Convert.ToString(i + 1));
                rows.Add("1");                

                this.dgInput.Rows.Add(rows.ToArray());
            }
            this.dgInput.Columns[0].DisplayIndex = 0;
            this.dgInput.Columns[1].DisplayIndex = 1;
        }

        private void SetupTargetGridView()
        {
            this.dgTarget.ColumnCount = 2;
            this.dgTarget.RowHeadersVisible = false;
            this.dgTarget.Columns[0].Name = "No";
            this.dgTarget.Columns[1].Name = "Data";
            this.dgTarget.Columns[0].ValueType = typeof(System.Int32);
            this.dgTarget.Columns[0].ReadOnly = true;
            this.dgTarget.Columns[0].DefaultCellStyle.BackColor = Color.Gainsboro;
            this.dgTarget.Columns[0].Width = 50;

            this.dgTarget.Columns[1].ValueType = typeof(System.Double);
            this.dgTarget.Columns[1].Width = 70;
            this.dgTarget.SelectionMode = DataGridViewSelectionMode.CellSelect;
            this.dgTarget.MultiSelect = false;
            this.dgTarget.AllowUserToAddRows = false;
            this.dgTarget.AllowUserToDeleteRows = false;
            this.dgTarget.ScrollBars = ScrollBars.Both;

            this.dgTarget.DataError += dgTarget_DataError;

            for (int i = 0; i < this._totalTarget; i++)
            {
                List<string> rows = new List<string>();
                rows.Add(Convert.ToString(i + 1));
                rows.Add("1");

                this.dgTarget.Rows.Add(rows.ToArray());
            }
            this.dgTarget.Columns[0].DisplayIndex = 0;
            this.dgTarget.Columns[1].DisplayIndex = 1;
        }

        private void dgTarget_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            MessageBox.Show("Input data must be numeric", "Information",
                MessageBoxButtons.OK, MessageBoxIcon.Warning);

            e.Cancel = true;
        }

        private void dataGridView1_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            MessageBox.Show("Input data must be numeric", "Information", 
                MessageBoxButtons.OK, MessageBoxIcon.Warning);

            e.Cancel = true;
        }        

        
        private bool CheckInput()
        {
            bool success = true;

            if (string.IsNullOrEmpty(txtInput.Text.Trim()))
            {
                MessageBox.Show("Please entry input data");
                success = false;
            }
            else
            if (string.IsNullOrEmpty(txtHidden.Text.Trim()))
            {
                MessageBox.Show("Please entry hidden data");
                success = false;
            }
            else
            if (string.IsNullOrEmpty(txtOutput.Text.Trim()))
            {
                MessageBox.Show("Please entry target data");
                success = false;
            }
            else
                if (cbTransferFunc.SelectedItem==null)
                {
                    MessageBox.Show("Please choice transfer function");
                    success = false;
                }

            return success;
        }

        private void PrepareData()
        {
            _backPro = new BackPro();
            _backPro.TotalInput = Convert.ToInt32(this.txtInput.Text);
            _backPro.TotalHidden = Convert.ToInt32(this.txtHidden.Text);
            _backPro.TotalTarget = Convert.ToInt32(this.txtOutput.Text);
            _backPro.ErrorMax = Convert.ToDouble(this.txtErrorRate.Text);
            _backPro.LearningRate = Convert.ToDouble(this.txtRate.Text);
            _backPro.MaxLoop = Convert.ToInt32(this.txtLooping.Text);
            _backPro.Momentum = Convert.ToDouble(this.txtMomentum.Text);            
                                   
            if (this.cbTransferFunc.SelectedItem.ToString() == "Binary Sigmoid")
                _backPro.TFModel = 1;
            if (this.cbTransferFunc.SelectedItem.ToString() == "Bipolar Sigmoid")
                _backPro.TFModel = 2;


            for (int i = 0; i < _totalInput; i++)
                _backPro.ListInput.Add(Convert.ToDouble(this.dgInput.Rows[i].Cells[1].Value));
            for (int i = 0; i < _totalTarget; i++)
                _backPro.ListTarget.Add(Convert.ToDouble(this.dgTarget.Rows[i].Cells[1].Value));

            _nLoop = Convert.ToInt32(this.txtLooping.Text);
            
        }
        private void RenderInputWeight()
        {
            this.dgInputWeight.ColumnCount = _totalHidden+1;
            this.dgInputWeight.RowHeadersVisible = false;
            this.dgInputWeight.Columns[0].Name = "i/j";            
            this.dgInputWeight.Columns[0].ValueType = typeof(System.Int32);
            this.dgInputWeight.Columns[0].ReadOnly = true;
            this.dgInputWeight.Columns[0].DefaultCellStyle.BackColor = Color.Gainsboro;
            this.dgInputWeight.Columns[0].Width = 50;

            for (int i = 1; i <= _totalHidden; i++)
            {
                this.dgInputWeight.Columns[i].Name = i.ToString();
                this.dgInputWeight.Columns[i].ValueType = typeof(System.Double);
                this.dgInputWeight.Columns[i].Width = 70;
                this.dgInputWeight.Columns[i].ReadOnly = true;        
            }
            this.dgInputWeight.SelectionMode = DataGridViewSelectionMode.CellSelect;  
            this.dgInputWeight.MultiSelect = false;
            this.dgInputWeight.AllowUserToAddRows = false;
            this.dgInputWeight.AllowUserToDeleteRows = false;
            this.dgInputWeight.ScrollBars = ScrollBars.Both;

            for(int i=0;i<=_totalInput;i++)
            {
                List<string> rows = new List<string>();
                rows.Add(Convert.ToString(i));
                
                for (int j = 1; j <= _totalHidden; j++)
                {
                    rows.Add(_backPro.VijHidden[i,j].ToString("0.####"));
                }
                this.dgInputWeight.Rows.Add(rows.ToArray());
            }

        }
        private void RenderOutputWeight()
        {
            this.dgOuputWeight.ColumnCount = _totalTarget + 1;
            this.dgOuputWeight.RowHeadersVisible = false;
            this.dgOuputWeight.Columns[0].Name = "j/k";
            this.dgOuputWeight.Columns[0].ValueType = typeof(System.Int32);
            this.dgOuputWeight.Columns[0].ReadOnly = true;
            this.dgOuputWeight.Columns[0].DefaultCellStyle.BackColor = Color.Gainsboro;
            this.dgOuputWeight.Columns[0].Width = 50;

            for (int i = 1; i <= _totalTarget; i++)
            {
                this.dgOuputWeight.Columns[i].Name = i.ToString();
                this.dgOuputWeight.Columns[i].ValueType = typeof(System.Double);
                this.dgOuputWeight.Columns[i].Width = 70;
                this.dgOuputWeight.Columns[i].ReadOnly = true;
            }
            this.dgOuputWeight.SelectionMode = DataGridViewSelectionMode.CellSelect;
            this.dgOuputWeight.MultiSelect = false;
            this.dgOuputWeight.AllowUserToAddRows = false;
            this.dgOuputWeight.AllowUserToDeleteRows = false;
            this.dgOuputWeight.ScrollBars = ScrollBars.Both;


            for (int j = 0; j <= _totalHidden; j++)
            {
                List<string> rows = new List<string>();
                rows.Add(Convert.ToString(j));

                for (int k = 1; k <= _totalTarget; k++)
                {
                    rows.Add(_backPro.WjkHidden[j,k].ToString("0.####"));
                }
                this.dgOuputWeight.Rows.Add(rows.ToArray());
            }
        }
        private void RenderTarget()
        {
            this.dgOutput.ColumnCount = _totalTarget + 2;
            this.dgOutput.RowHeadersVisible = false;
            this.dgOutput.Columns[0].Name = "Epoch";
            this.dgOutput.Columns[0].ValueType = typeof(System.Int32);
            this.dgOutput.Columns[0].ReadOnly = true;
            this.dgOutput.Columns[0].DefaultCellStyle.BackColor = Color.Gainsboro;
            this.dgOutput.Columns[0].Width = 50;
            this.dgOutput.Columns[1].Name = "Error";
            this.dgOutput.Columns[1].ValueType = typeof(System.Double);
            this.dgOutput.Columns[1].ReadOnly = true;
            this.dgOutput.Columns[1].Width = 50;


            for (int i = 1; i <= _totalTarget; i++)
            {
                this.dgOutput.Columns[i+1].Name = String.Format("Output {0}", i);
                this.dgOutput.Columns[i + 1].ValueType = typeof(System.Double);
                this.dgOutput.Columns[i + 1].Width = 80;
                this.dgOutput.Columns[i + 1].ReadOnly = true;
            }
            this.dgOutput.SelectionMode = DataGridViewSelectionMode.CellSelect;
            this.dgOutput.MultiSelect = false;
            this.dgOutput.AllowUserToAddRows = false;
            this.dgOutput.AllowUserToDeleteRows = false;
            this.dgOutput.ScrollBars = ScrollBars.Both;

            for (int i = 0; i < _backPro.YOutput.Count; i++)
            {
                List<string> rows = new List<string>();
                rows.Add(Convert.ToString(i+1));

                for (int k = 0; k <= _totalTarget; k++)
                {
                    rows.Add(_backPro.YOutput[i][k].ToString("0.####"));
                }
                this.dgOutput.Rows.Add(rows.ToArray());
            }
        }
        private void RenderData()
        {
            RenderInputWeight();
            RenderOutputWeight();
            RenderTarget();

            this.lbResult.Text = String.Format("Error system: {0:0.####} \r\nTotal Epoch: {1}", 
                _backPro.Error,_backPro.TotalEpoch.ToString());
            this.lbResult.Visible = true;
        }
        private void btnRun_Click(object sender, EventArgs e)
        {
            if (!CheckInput())
                return;

            PrepareData();            
            backgroundWorker1.RunWorkerAsync();

        }

        private void btnSet_Click(object sender, EventArgs e)
        {
            this._totalInput = Convert.ToInt32(this.txtInput.Text);
            this._totalHidden = Convert.ToInt32(this.txtHidden.Text);
            this._totalTarget = Convert.ToInt32(this.txtOutput.Text);

            SetupInputGridView();
            SetupTargetGridView();            
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            this.txtErrorRate.Text = "";
            this.txtHidden.Text = "";
            this.txtInput.Text = "";
            this.txtLooping.Text = "";
            this.txtMomentum.Text = "";
            this.txtOutput.Text = "";
            this.txtRate.Text = "";

            dgInput.ColumnCount = 0;
            dgTarget.ColumnCount = 0;
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            _backPro.InitialData();

            double delta = _nLoop / 100;
            for (int i = 0; i < _nLoop; i++)
            {
                backgroundWorker1.ReportProgress((int)((i + 1) * delta));
                if (_backPro.Run(i + 1))
                {
                    _backPro.TotalEpoch = i + 1;
                    break;
                }

                
            }
            backgroundWorker1.ReportProgress(100);
        }

        private void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            this.progressBar1.Increment(e.ProgressPercentage);
        }

        private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            MessageBox.Show("NN Training is done");
            RenderData();
        }

        private void btnView_Click(object sender, EventArgs e)
        {
            NNTrainingView frm = new NNTrainingView();
            frm.BackproData = _backPro;
            frm.Populate();

            frm.ShowDialog();
        }
    }
}
