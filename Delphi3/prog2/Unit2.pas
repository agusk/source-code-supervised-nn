unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, StdCtrls, ExtCtrls, TeeProcs, Chart, Buttons;

type
  TGrafikForm = class(TForm)
    Chart1: TChart;
    Button1: TButton;
    Series1: TFastLineSeries;
    Button2: TButton;
    Panel1: TPanel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SettingReset(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ScrollAxis(Axis:TChartAxis; Const Percent:Double);
    Procedure HorizScroll(Const Percent:Double);
    Procedure VertScroll(Const Percent:Double);
  end;

var
  GrafikForm: TGrafikForm;

implementation
Uses Unit1;
{$R *.DFM}

Procedure TGrafikForm.ScrollAxis(Axis:TChartAxis; Const Percent:Double);
var Amount:Double;
    dMin,dMax:Double;
begin
  With Axis do
  begin
    Amount:=-((Maximum-Minimum)/(100.0/Percent));
    dMin:=Minimum-Amount;
    dMax:=Maximum-Amount;
    SetMinMax(dMin,dMax);
  end;
end;

Procedure TGrafikForm.HorizScroll(Const Percent:Double);
begin
  ScrollAxis(Chart1.TopAxis,Percent);
  ScrollAxis(Chart1.BottomAxis,Percent);
  Button3.Enabled:=True;
end;

Procedure TGrafikForm.VertScroll(Const Percent:Double);
begin
  ScrollAxis(Chart1.LeftAxis,Percent);
  ScrollAxis(Chart1.RightAxis,Percent);
  Button3.Enabled:=True;
end;

procedure TGrafikForm.Button1Click(Sender: TObject);
begin
    GrafikForm.Visible:=False;
    Form1.Show;
end;

procedure TGrafikForm.Button2Click(Sender: TObject);
begin
If Series1.Marks.Visible=False Then
   begin
        Series1.Marks.Visible:=True;
        Button2.Caption:='Menghilangkan Label';
   end
   Else
   begin
        Series1.Marks.Visible:=False;
        Button2.Caption:='Menampilkan Label';
   end;
end;

procedure TGrafikForm.Button3Click(Sender: TObject);
begin
    Chart1.UndoZoom;
    Button3.Enabled:=False;
end;

procedure TGrafikForm.Button5Click(Sender: TObject);
begin
   Chart1.ZoomPercent(120);
   Button3.Enabled:=True;
end;

procedure TGrafikForm.Button4Click(Sender: TObject);
begin
    Chart1.ZoomPercent(70);
    Button3.Enabled:=True;
end;


procedure TGrafikForm.SpeedButton1Click(Sender: TObject);
begin
    HorizScroll(-10);
end;

procedure TGrafikForm.SpeedButton2Click(Sender: TObject);
begin
    HorizScroll(10);
end;

procedure TGrafikForm.SpeedButton3Click(Sender: TObject);
begin
    VertScroll(10);
end;

procedure TGrafikForm.SpeedButton4Click(Sender: TObject);
begin
    VertScroll(-10);
end;

procedure TGrafikForm.SettingReset(Sender: TObject);
begin
   Button3.Enabled:=True;
end;

end.




