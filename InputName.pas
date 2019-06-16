unit InputName;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAutorization = class(TForm)
    edGroupNumb: TEdit;
    btAccess: TButton;
    procedure FormShow(Sender: TObject);
    procedure btAccessClick(Sender: TObject);
    procedure edGroupNumbKeyPress(Sender: TObject; var Key: Char);
    procedure edGroupNumbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Autorization: TAutorization;

implementation

{$R *.dfm}

uses Week;

function ValidNumb(Numb: String): Boolean;
begin
   if (Length(Numb) = 6)  then
      Result := True
   else
      Result := False;
end;

procedure TAutorization.btAccessClick(Sender: TObject);
const
   GroupNumbError = 'Некорректный номер группы, номер группы ' +
      'долджен состоятть из 6 символов!';
var
   GroupNumb: String;
begin
   GroupNumb := edGroupNumb.Text;
   if ValidNumb(GroupNumb) then
   begin
      WorkWeek.ShowModal;
   end
   else
   begin
      MessageDlg(GroupNumbError, mtError, [mbRetry], 0)
   end;
end;

procedure TAutorization.edGroupNumbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      Close;
end;

procedure TAutorization.edGroupNumbKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) then
      btAccessClick(Sender);
end;

procedure TAutorization.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
   AreSure = 'Вы уверены что хотите выйти?';
begin
   if (MessageDlg(AreSure, mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      CanClose := False;
end;

procedure TAutorization.FormShow(Sender: TObject);
const
   TopMargin = 20;
begin
   Width := 240;
   Height := 320;
   edGroupNumb.Top := 30;
   edGroupNumb.Left := 30;
   edGroupNumb.Width := 180;

   btAccess.Top := edGroupNumb.Top + edGroupNumb.Height +  TopMargin;
   btAccess.Left := edGroupNumb.Left + edGroupNumb.Width - btAccess.Width;

end;

end.
