/// Copyright 2009. Agus Kurniawan
/// Contact: agusk2007@gmail.com
/// http://www.aguskurniawan.net
/// http://blog.aguskurniawan.net
/// http://geeks.netindonesia.net/blogs/agus 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;


namespace BackNNSimulation
{
    public class BackPro
    { 
        private int _totalInput;
        private int _totalHidden;
        private int _totalTarget;
        private double _momentum;
        private double _learningRate;
        private double _errorMax;
        private int _maxLoop;
        private int _tfModel = 1;
        private List<double> Xi = new List<double>();
        private List<double> _listTarget = new List<double>();
        private double[,] Vij;
        private double[,] updatedVij;
        private double[,] Wjk;
        private double[,] updatedWjk;
        private List<double[]> yOutput;
        private double[] Zin_j, Zj,Yink,Yk;
        private double[] delta_in_j, delta_j,delta_k;
        private bool _trainingFinish;
        private double _error;
        private Random _rand = new Random(1000);
        private int _totalEpoch;

        public int TotalEpoch
        {
            get
            {
                return _totalEpoch;
            }
            set
            {
                if (_totalEpoch == value)
                    return;
                _totalEpoch = value;
            }
        }

        public List<double[]> YOutput
        {
            get
            {
                return yOutput;
            }            
        }

        public double Error
        {
            get
            {
                return _error;
            }            
        }
        public List<double> ListTarget
        {
            get
            {
                return _listTarget;
            }
            set
            {
                if (_listTarget == value)
                    return;
                _listTarget = value;
            }
        }
        public List<double> ListInput
        {
            get
            {
                return Xi;
            }
            set
            {
                if (Xi == value)
                    return;
                Xi = value;
            }
        }
        
        
        public double[,] VijHidden
        {
            get
            {
                return Vij;
            }          
        }
        public double[,] WjkHidden
        {
            get
            {
                return Wjk;
            }           
        }

        public int TotalInput
        {
            get
            {
                return _totalInput;
            }
            set
            {
                if (_totalInput == value)
                    return;
                _totalInput = value;
            }
        }
        public int TotalHidden
        {
            get
            {
                return _totalHidden;
            }
            set
            {
                if (_totalHidden == value)
                    return;
                _totalHidden = value;
            }
        }
        public int TotalTarget
        {
            get
            {
                return _totalTarget;
            }
            set
            {
                if (_totalTarget == value)
                    return;
                _totalTarget = value;
            }
        }
        public double Momentum
        {
            get
            {
                return _momentum;
            }
            set
            {
                if (_momentum == value)
                    return;
                _momentum = value;
            }
        }
        public double LearningRate
        {
            get
            {
                return _learningRate;
            }
            set
            {
                if (_learningRate == value)
                    return;
                _learningRate = value;
            }
        }
        public double ErrorMax
        {
            get
            {
                return _errorMax;
            }
            set
            {
                if (_errorMax == value)
                    return;
                _errorMax = value;
            }
        }
        public int MaxLoop
        {
            get
            {
                return _maxLoop;
            }
            set
            {
                if (_maxLoop == value)
                    return;
                _maxLoop = value;
            }
        }
        public int TFModel
        {
            get
            {
                return _tfModel;
            }
            set
            {
                if (_tfModel == value)
                    return;
                _tfModel = value;
            }
        }


        public BackPro() { }

        private double RandomWeight(double low, double high)
        {
            // random without zero value
            double tmp=0.0;
            while (tmp == 0.0)
            {
                tmp = _rand.NextDouble();
            }
            return Convert.ToDouble(tmp * (high - low) + low); 
        }
        private double TF(double val)
        {
            double newVal = 0;

            switch (_tfModel)
            {
                case 1: //Binary sigmoid
                    if(val>=10000) 
                        newVal = 0.9999;
                    if (val<=-10000) 
                        newVal = 0.000000001;
                    if (val>-10000 && val<10000) 
                        newVal =Convert.ToDouble(1/(double)(1+Math.Exp(-val)));  
                    break;
                case 2: //Bipolar sigmoid 
                    if (val >= 10000)
                        newVal = 0.9998;
                    if (val <= -10000)
                        newVal = -0.999998;
                    if (val > -10000 && val < 10000)
                        newVal = (2 / Convert.ToDouble(1 + Math.Exp(-val)))-1;      
                    break;
            }

            return newVal;
        }
        private double DTF(double val)
        {
            double newVal = 0;
            double tmp = 0;
  
            switch (_tfModel)
            {
                case 1:
                    tmp = TF(val);
                    newVal = (1 - tmp) * tmp;
                    break;
                case 2:
                    tmp = TF(val);
                    newVal = Convert.ToDouble(0.5*(1 + tmp) * (1 - tmp));
                    break;
            }

            return newVal;
        }

        public void InitialData()
        {
            Vij = new double[_totalInput + 1, _totalHidden + 1];
            Wjk = new double[_totalHidden+1,_totalTarget+1];
            updatedVij = new double[_totalInput+1, _totalHidden+1];
            updatedWjk = new double[_totalHidden+1, _totalTarget+1];
            Zin_j = new double[_totalHidden+1];
            Zj = new double[_totalHidden+1];
            Yink = new double[_totalTarget+1];
            Yk = new double[_totalTarget+1];
            delta_k = new double[_totalTarget+1];
            delta_in_j = new double[_totalHidden+1];
            delta_j = new double[_totalHidden+1];
            yOutput = new List<double[]>();

            //normalisasi input
            double max = Xi.Max();
            for (int i = 1; i <= Xi.Count; i++)
                Xi[i-1] = Xi[i-1] / max;            

            for (int i = 0; i <= Xi.Count; i++)
                for (int j = 1; j <= _totalHidden; j++)
                    Vij[i, j] = RandomWeight(-0.5, 0.5);

            for (int j = 0; j <= _totalHidden; j++)
                for (int k = 1; k <= _totalTarget; k++)
                    Wjk[j, k] = RandomWeight(-0.5, 0.5);

            _trainingFinish = false;
 
        }


        public bool Run(int iLoop)
        {
            if (!_trainingFinish && iLoop > _maxLoop)
                _trainingFinish = true;

            if (!_trainingFinish)
            {
                System.Diagnostics.Debug.WriteLine("Training " + (iLoop));
                _totalEpoch = iLoop;
                int i,j,k;
                
                for (j = 1; j <= _totalHidden; j++)
                {
                    Zin_j[j] = 0;
                    for (i = 1; i <= _totalInput; i++)
                        Zin_j[j] = Zin_j[j] + Xi[i-1] * Vij[i, j];

                    Zin_j[j] = Zin_j[j] + Vij[0, j];
                    Zj[j] = TF(Zin_j[j]);
                }

                for (k = 1; k <= _totalTarget; k++)
                {
                    Yink[k] = 0;
                    for (j = 1; j <= _totalHidden; j++)
                        Yink[k] = Yink[k] + Zj[k] * Wjk[j, k];
                    Yink[k] = Yink[k] + Wjk[0, k];
                    Yk[k] = TF(Yink[k]);
                }

                double error = 0;
                for (k = 1; k <= _totalTarget; k++)
                    error = error + (_listTarget[k - 1] - Yk[k]) * (_listTarget[k - 1] - Yk[k]);

                error = 0.5 * error;

                if (error > _errorMax)
                {
                    // upgrade weight when requested error isn't archived
                    for (k = 1; k <= _totalTarget; k++)
                    {
                        delta_k[k] = (_listTarget[k - 1] - Yk[k]) * DTF(Yink[k]);
                        for (j = 1; j <= _totalHidden; j++)
                            updatedWjk[j, k] = _learningRate * delta_k[k] * Zj[j] + (updatedWjk[j, k] * _momentum);
                        updatedWjk[0, k] = _learningRate * delta_k[k];
                    }

                    for (j = 1; j <= _totalHidden; j++)
                    {
                        delta_in_j[j] = 0;
                        for (k = 1; k <= _totalTarget; k++)
                            delta_in_j[j] = delta_in_j[j] + delta_k[k] * Wjk[j, k];

                        delta_j[j] = delta_in_j[j] * DTF(Zin_j[j]);
                    }
                    for (j = 1; j <= _totalHidden; j++)
                    {
                        for (i = 1; i <= _totalInput; i++)
                            updatedVij[i, j] = _learningRate * delta_j[j] * Xi[i-1] + Vij[i, j] * _momentum;

                        updatedVij[0, j] = _learningRate * delta_j[j];
                    }
                    for (j = 0; j <= _totalHidden; j++)
                        for (k = 1; k <= _totalTarget; k++)
                            Wjk[j, k] = Wjk[j, k] + updatedWjk[j, k];

                    for (i = 0; i <= _totalInput; i++)
                        for (j = 1; j <= _totalHidden; j++)
                            Vij[i, j] = Vij[i, j] + updatedVij[i, j];

                }
                else
                {
                    _trainingFinish = true;                    
                }
                _error = error;

                double[] yOut = new double[_totalTarget + 1];
                yOut[0] = error;
                for (k = 1; k <= _totalTarget; k++)
                    yOut[k] = Yk[k];

                yOutput.Add(yOut);
 
            }

            return _trainingFinish;
        }
    }
}
