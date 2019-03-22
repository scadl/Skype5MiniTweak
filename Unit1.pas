unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    TrackBar1: TTrackBar;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);

  private
      procedure TransWindNT(target:hwnd; value:byte);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sk5mf, sk5chf1, sk5chf2, sk5cl: hwnd;

implementation

{$R *.dfm}

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
sk5mf:=FindWindow('tSkMainForm',0);
sk5chf1:=FindWindowEx(sk5mf,0,'TMyselfControl',0);
if CheckBox1.Checked
then
    ShowWindow(sk5chf1,SW_HIDE)
else
    ShowWindow(sk5chf1,SW_SHOW);

end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
sk5mf:=FindWindow('tSkMainForm',0);
sk5chf1:=FindWindowEx(sk5mf,0,'TChromeMenu',0);
if CheckBox2.Checked
then
    begin
    ShowWindow(sk5chf1,SW_HIDE);
    //sk5cl:=FindWindowEx(sk5mf,0,'TConversationsControl',0);
    //SetWindowPos(sk5cl,0,4,30,0,0,SWP_NOOWNERZORDER+SWP_NOSIZE);
    //SetWindowPos(sk5mf,0,0,0,50,100,SWP_NOOWNERZORDER+SWP_NOMOVE);
    end
else
    ShowWindow(sk5chf1,SW_SHOW);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
sk5mf:=FindWindow('tSkMainForm',0);
if CheckBox3.Checked
then begin
TransWindNT(sk5mf,TrackBar1.Position);
TrackBar1.Enabled:=true
end else begin
TrackBar1.Enabled:=false;
TransWindNT(sk5mf,255);
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
sk5mf:=FindWindow('tSkMainForm',0);
if (0=FindWindow('tSkMainForm',0)) then
begin
if mrYes=MessageDlg('Skype main window aren''t found!'+#13+'Should I start searching it every 3 minutes?',mtWarning,mbYesNo,0) then
timer1.enabled:=true;
end else begin
  CheckBox1.Enabled:=true;
  CheckBox2.Enabled:=true;
  CheckBox3.Enabled:=true;
  //TrackBar1.Enabled:=true;
  sk5chf1:=FindWindowEx(sk5mf,0,'TMyselfControl',0);
    if IsWindowVisible(sk5chf1)=false
      then CheckBox1.Checked:=true;
  sk5chf1:=FindWindowEx(sk5mf,0,'TChromeMenu',0);
    if IsWindowVisible(sk5chf1)=false
      then CheckBox2.Checked:=true;
end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if 0<>FindWindow('tSkMainForm',0) then
begin
  CheckBox1.Enabled:=true;
  CheckBox2.Enabled:=true;
  CheckBox3.Enabled:=true;
  //TrackBar1.Enabled:=true;
end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
sk5mf:=FindWindow('tSkMainForm',0);
TransWindNT(sk5mf,TrackBar1.Position);
end;

procedure TForm1.TransWindNT(target:hwnd; value:byte);
begin
SetWindowLong(target, GWL_EXSTYLE, GetWindowLong(target, GWL_EXSTYLE) or WS_EX_LAYERED);
SetLayeredWindowAttributes(target, 0, value, LWA_ALPHA); //100-уровень прозрачности (максимум 256)
end;
end.
