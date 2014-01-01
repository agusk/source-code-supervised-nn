unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Gauges, Grids;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Xinput: TStringGrid;
    GroupBox2: TGroupBox;
    VijHidden: TStringGrid;
    Label1: TLabel;
    WjkHidden: TStringGrid;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    YOutput: TStringGrid;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    sMomentum: TEdit;
    sLearningRate: TEdit;
    sLooping: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    sUnitInput: TEdit;
    sUnitHidden: TEdit;
    sUnitOutput: TEdit;
    sErrorMax: TEdit;
    Label9: TLabel;
    Button2: TButton;
    GroupBox5: TGroupBox;
    Gauge1: TGauge;
    Button1: TButton;
    Button3: TButton;
    Label10: TLabel;
    Label11: TLabel;
    rErrorSystem: TLabel;
    rLooping: TLabel;
    Button4: TButton;
    stf: TComboBox;
    Label12: TLabel;
    GroupBox6: TGroupBox;
    Target: TStringGrid;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    function RandomWeight(low,high:Extended):Extended;
    function tf(no:integer;value:Extended):Extended;
    function dtf(no:integer;value:Extended):Extended;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation
Uses Unit2;
{$R *.DFM}

var isFinish:Boolean;

function TForm1.RandomWeight(low,high:Extended):Extended;
begin
   RandomWeight:=Random(100)*(high-low)*0.01+low;
end;

function TForm1.tf(no:integer;value:Extended):Extended;
var eResult:Extended;
begin
  eResult:=0.0;
  case no of
  0:begin
      if value>=10000 then eResult:=0.9999;
      if value<=-10000 then eResult:=0.000000001;
      if (value>-10000) and (value<10000) then eResult:=1/(1+exp(-value));
    end;
  1:begin
      if value>=10000 then eResult:=0.9998;
      if value<=-10000 then eResult:=-0.999998;
      if (value>-10000) and (value<10000) then  eResult:=(2/(1+exp(-value)))-1;
    end;
  end;

  tf:=eResult;
end;

function TForm1.dtf(no:integer;value:Extended):Extended;
var dummy,eResult:Extended;
begin
  eResult:=0.0;
  case no of
  0:begin
      dummy:=tf(no,value);
      eResult:=(1-dummy)*dummy;
    end;
  1:begin
      dummy:=tf(no,value);
      eResult:=0.5*(1+dummy)*(1-dummy);
    end;
  end;

  dtf:=eResult;
end;

procedure TForm1.Button1Click(Sender: TObject);
var    eMomentum,eLearningRate,eErrorMax :Extended;
       iUnitInput,iUnitHidden,iUnitOutput,iLooping,tf_choice:Integer;
       counter,i,j,k:Integer;
       Finish:Boolean;
       Dummy,dInput,dHidden,dOutput:Extended;
       Xi:array[1..100] of real;
       Vij,update_Vij:array[0..100,1..100] of Extended;
       Wjk,update_Wjk:array[0..100,1..30] of Extended;
       Zin_j,Zj:array[1..100] of Extended;
       Yink,Yk:array[1..30] of Extended;
       O_target:array[1..30] of real;
       delta_in_j,delta_j:array[1..100] of Extended;
       delta_k:array[1..30] of Extended;
       Error,Error_system:Extended;
       PeakValue:real;


begin
 isFinish:=false;
 Button1.Enabled:=false;
 Button2.Enabled:=false;
 Button5.Enabled:=false;
 {--- mengkonversi bilangan----}
 eMomentum:=StrToFloat(sMomentum.Text);
 eLearningRate:=StrToFloat(sLearningRate.Text);
 eErrorMax:=StrToFloat(sErrorMax.Text);
 iLooping:=StrToInt(sLooping.Text);
 iUnitInput:=StrToInt(sUnitInput.Text);
 iUnitHidden:=StrToInt(sUnitHidden.Text);
 iUnitOutput:=StrToInt(sUnitOutput.Text);
 tf_choice:=stf.ItemIndex;
 Finish:=false;

 {-----settting stringGrid/tabel-------}
 VijHidden.ColCount:=iUnitHidden+1;
 VijHidden.RowCount:=iUnitInput+2;
 VijHidden.Cells[0,0]:='    i\j';
 for i:=1 to iUnitInput+1 do VijHidden.Cells[0,i]:=IntToStr(i-1);
 for j:=1 to iUnitHidden do VijHidden.Cells[j,0]:=IntToStr(j);

 WjkHidden.ColCount:=iUnitOutput+1;
 WjkHidden.RowCount:=iUnitHidden+2;
 WjkHidden.Cells[0,0]:='    j\k';
 for j:=1 to iUnitHidden do WjkHidden.Cells[0,j]:=IntToStr(j-1);
 for k:=1 to iUnitOutput+1 do WjkHidden.Cells[k,0]:=IntToStr(k);

 YOutput.ColCount:=iUnitOutput+2;
 YOutput.RowCount:=2;
 YOutput.Cells[0,0]:='No';
 YOutput.Cells[1,0]:='Error';
 for i:=1 to iUnitOutput do
   YOutput.Cells[1+i,0]:='Output '+IntToStr(i);

 {-----initial data bobot pada hidden layer--------}

 for i:=1 to iUnitInput do Xi[i]:=StrToFloat(Xinput.Cells[1,i]);
  // normalisasi
  PeakValue:=0.0;
  for i:=1 to iUnitInput do
   If Xi[i]>PeakValue Then PeakValue:=Xi[i];

 for i:=1 to iUnitInput do Xi[i]:=Xi[i]/PeakValue;
 for i:=1 to iUnitOutput do O_target[i]:=strToFloat(Target.Cells[1,i]);

 RandSeed:=1000;
 for i:=1 to iUnitInput+1 do
   for j:=1 to iUnitHidden do
     Vij[i-1,j]:=RandomWeight(-0.5,0.5);


 for j:=1 to iUnitHidden+1 do
   for k:=1 to iUnitOutput do
     Wjk[j-1,k]:=RandomWeight(-0.5,0.5);

{-------------prosese training---------------}
counter:=0;
Gauge1.MaxValue:=iLooping;
Gauge1.Progress:=0;
Gauge1.Update;
GrafikForm.Series1.Clear;
Repeat
 counter:=counter+1;
 for j:=1 to iUnitHidden do
 begin
    Zin_j[j]:=0;
    for i:=1 to iUnitInput do
      Zin_j[j]:=Zin_j[j]+Xi[i]*Vij[i,j];
    Zin_j[j]:=Zin_j[j]+Vij[0,j];
    Zj[j]:=tf(tf_choice,Zin_j[j]);
 end;

 for k:=1 to iUnitOutput do
 begin
   Yink[k]:=0;
   for j:=1 to iUnitHidden do
     Yink[k]:=Yink[k]+Zj[j]*Wjk[j,k];
   Yink[k]:=Yink[k]+Wjk[0,k];
   Yk[k]:=tf(tf_choice,Yink[k]);
 end;

 Error:=0;
 for k:=1 to iUnitOutput do
    Error:=Error+(O_target[k]-Yk[k])*(O_target[k]-Yk[k]);
 Error:=0.5*Error;


 if Error> eErrorMax then
 begin
   for k:=1 to iUnitOutput do
   begin
    delta_k[k]:=(O_target[k]-Yk[k])*dtf(tf_choice,YinK[k]);
    for j:=1 to iUnitHidden do
     update_Wjk[j,k]:=eLearningRate*delta_k[k]*Zj[j]+(update_Wjk[j,k]*eMomentum);
    update_Wjk[0,k]:=eLearningRate*delta_k[k];
   end;

   for j:=1 to iUnitHidden do
   begin
     delta_in_j[j]:=0;
     for k:=1 to iUnitOutput do
       delta_in_j[j]:=delta_in_j[j]+delta_k[k]*Wjk[j,k];
     delta_j[j]:=delta_in_j[j]*dtf(tf_choice,Zin_j[j]);
   end;

   for j:=1 to iUnitHidden do
   begin
     for i:=1 to iUnitInput do
       update_Vij[i,j]:=eLearningRate*delta_j[j]*Xi[i]+(Vij[i,j]*eMomentum);
     update_Vij[0,j]:=eLearningRate*delta_j[j];
   end;

   for j:=0 to iUnitHidden do
     for k:=1 to iUnitOutput do
       Wjk[j,k]:=Wjk[j,k]+update_Wjk[j,k];

   for i:=0 to iUnitInput do
    for j:=1 to iUnitHidden do
      Vij[i,j]:=Vij[i,j]+update_Vij[i,j];
 end else
 begin
  finish:=true;
 end;

if finish=false then
begin
  YOutput.Cells[1,counter]:=FloatToStrF(Error,ffGeneral,6,10);
  GrafikForm.Series1.AddXY(counter,Error,'');
  for i:=1 to iUnitOutput do
   YOutput.Cells[1+i,counter]:=FloatToStrF(Yk[i],ffGeneral,6,10);
  YOutput.Cells[0,counter]:=IntToStr(counter);
end;

 if counter>=iLooping then finish:=true;
 if finish=false then YOutput.RowCount:=YOutput.RowCount+1;

Gauge1.Progress:=counter;
Gauge1.Update;
until finish=true or isFinish=true;
Gauge1.Progress:=0;
Gauge1.Update;
{---------- menampilkan hasil traning------------}

for i:=1 to iUnitInput+1 do
 for j:=1 to iUnitHidden do
    VijHidden.Cells[j,i]:=FloatToStrF(Vij[i-1,j],ffGeneral,6,10);

for j:=1 to iUnitHidden+1 do
 for k:=1 to iUnitOutput do
    WjkHidden.Cells[k,j]:=FloatToStrF(Wjk[j-1,k],ffGeneral,6,10);

  YOutput.Cells[1,counter]:=FloatToStrF(Error,ffGeneral,6,10);
  for i:=1 to iUnitOutput do
   YOutput.Cells[1+i,counter]:=FloatToStrF(Yk[i],ffGeneral,6,10);
  YOutput.Cells[0,counter]:=IntToStr(counter);

 rErrorSystem.Caption:=FloatToStrF(Error,ffGeneral,6,10);
 rLooping.Caption:=IntToStr(Counter);

 rErrorSystem.Visible:=true;
 rLooping.Visible:=true;
 VijHidden.Visible:=true;
 WjkHidden.Visible:=true;
 YOutput.Visible:=true;
 Label1.Visible:=true;
 Label2.Visible:=true;
 Button1.Enabled:=true;
 Button2.Enabled:=true;
 Button5.Enabled:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.Button2Click(Sender: TObject);
var nUnitInput,nUnitTarget,i:Integer;
begin
  if(sMomentum.Text<>'') and(sLearningRate.Text<>'') and
    (sLooping.Text<>'') and (stf.Text<>'') and (sErrorMax.Text<>'') and
    (sUnitInput.Text<>'') and (sUnitHidden.Text<>'') and (sUnitOutput.Text<>'')
  then
  begin
        {-----koversi data dalam numerik dan setting gridlines-----}
        XInput.ColCount:=2;
        nUnitInput:=StrToInt(sUnitInput.Text);
        XInput.RowCount:=nUnitInput+1;
        XInput.Cells[0,0]:=' No';
        Xinput.Cells[1,0]:=' Nilai';
        nUnitTarget:=StrToInt(sUnitOutput.Text);
        Target.RowCount:=nUnitTarget+1;
        Target.Cells[0,0]:=' No';
        Target.Cells[1,0]:=' Nilai';
        for i:=1 to nUnitInput do Xinput.Cells[0,i]:=IntToStr(i);
        for i:=1 to nUnitTarget do Target.Cells[0,i]:=IntToStr(i);
        {-----show gridlines dan enabled setting-----}
        XInput.Visible:=true;
        Target.Visible:=true;
        Button1.Enabled:=true;
        Button3.Enabled:=true;
  end else
  Application.MessageBox('Isi semua parameter','Error Pengisiam',MB_OK);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  sMomentum.Text:='';
  sLearningRate.Text:='';
  sLooping.Text:='';
  sErrorMax.Text:='';
  sUnitInput.Text:='';
  sUnitHidden.Text:='';
  sUnitOutput.Text:='';
  Gauge1.Progress:=0;
  Gauge1.Update;
  Button1.Enabled:=false;
  Button3.Enabled:=false;
  Button5.Enabled:=false;
  XInput.Visible:=false;
  Label1.Visible:=false;
  Label2.Visible:=false;
  rErrorSystem.Visible:=false;
  rLooping.Visible:=false;
  VijHIdden.Visible:=false;
  WjkHIdden.Visible:=false;
  YOutput.Visible:=false;
end;


procedure TForm1.Button5Click(Sender: TObject);
begin
  Form1.Visible:=False;
  GrafikForm.Show;
end;

end.
