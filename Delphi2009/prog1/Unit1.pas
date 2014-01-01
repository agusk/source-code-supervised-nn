unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Baris_A: TEdit;
    Label3: TLabel;
    Kolom_A: TEdit;
    MatrikA: TStringGrid;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Baris_B: TEdit;
    Kolom_B: TEdit;
    MatrikB: TStringGrid;
    Operasi: TRadioGroup;
    GroupBox3: TGroupBox;
    MatrikC: TStringGrid;
    Label6: TLabel;
    Label7: TLabel;
    Baris_C: TLabel;
    Kolom_C: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.Button1Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  MatrikA.Visible:=true;
  MatrikA.RowCount:=StrToInt(Baris_A.Text);
  MatrikA.ColCount:=StrToInt(Kolom_A.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  MatrikB.Visible:=true;
  MatrikB.RowCount:=StrToInt(Baris_B.Text);
  MatrikB.ColCount:=StrToInt(Kolom_B.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
var pilihan:Integer;
    Bar_A,Bar_B,Kol_A,Kol_B :Integer;
    i,j,k:Integer;
    NilaiA,NilaiB,Dummy:Extended;
begin
  pilihan:=operasi.ItemIndex;
  Bar_A:=StrToInt(Baris_A.Text);
  Bar_B:=StrToInt(Baris_B.Text);
  Kol_A:=StrToInt(Kolom_A.Text);
  Kol_B:=StrToInt(Kolom_B.Text);
  
  case pilihan of
  0:begin
     if((Bar_A=Bar_B) and (Kol_A=Kol_B)) then
     begin
      MatrikC.RowCount:=Bar_A;
      MatrikC.ColCount:=Kol_A;
      for i:=0 to Bar_A-1 do
        for j:=0 to Kol_A-1 do
        begin
           NilaiA:=StrToFloat(MatrikA.Cells[j,i]);
           NilaiB:=StrToFloat(MatrikB.Cells[j,i]);
           MatrikC.Cells[j,i]:=FloatToStrF(NilaiA+NilaiB,ffGeneral,5,8);
        end;
     end else
     begin
      Application.MessageBox('Orde Matrik A dan B tidak sama','Error',MB_OK);
      MatrikA.Visible:=false;
      MatrikB.Visible:=false;
     end;
    end;
  1:begin
     if((Bar_A=Bar_B) and (Kol_A=Kol_B)) then
     begin
      MatrikC.RowCount:=Bar_A;
      MatrikC.ColCount:=Kol_A;
      for i:=0 to Bar_A-1 do
        for j:=0 to Kol_A-1 do
        begin
           NilaiA:=StrToFloat(MatrikA.Cells[j,i]);
           NilaiB:=StrToFloat(MatrikB.Cells[j,i]);
           MatrikC.Cells[j,i]:=FloatToStrF(NilaiA-NilaiB,ffGeneral,5,8);
        end;
     end else
     begin
      Application.MessageBox('Orde Matrik A dan B tidak sama','Error',MB_OK);
      MatrikA.Visible:=false;
      MatrikB.Visible:=false;
     end;
    end;
  2:begin
     if Kol_A=Bar_B then
     begin
        MatrikC.RowCount:=Bar_A;
        MatrikC.ColCount:=Kol_B;
       for i:=0 to Bar_A-1 do
        for j:=0 to Kol_B-1 do
        begin
         Dummy:=0;
         for k:=0 to Kol_A-1 do
         begin
           NilaiA:=StrToFloat(MatrikA.Cells[k,i]);
           NilaiB:=StrToFloat(MatrikB.Cells[j,k]);
           Dummy:=Dummy+(NilaiA*NilaiB);
         end;
         MatrikC.Cells[j,i]:=FloatToStrF(Dummy,ffGeneral,5,8);
        end;
     end else
     begin
      Application.MessageBox('Baris Matrik A dan kolom Matrik B tidak sama','Error',MB_OK);
      MatrikA.Visible:=false;
      MatrikB.Visible:=false;
     end;
    end;
  end;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
      MatrikA.Visible:=false;
      MatrikB.Visible:=false;
      MatrikC.Visible:=false;
      Baris_A.Text:='';
      Baris_B.Text:='';
      Kolom_A.Text:='';
      Kolom_B.Text:='';
end;

end.
