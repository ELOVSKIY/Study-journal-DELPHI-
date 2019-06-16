unit NewGroupFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSchedulerForm = class(TForm)
    edGroupNumb: TEdit;
    btConfirm: TButton;
    edYear: TEdit;
    cbSemestr: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure SetParametrs();
    procedure edYearKeyPress(Sender: TObject; var Key: Char);
    procedure edGroupNumbKeyPress(Sender: TObject; var Key: Char);
    procedure btConfirmClick(Sender: TObject);
    procedure CreateNewGroup();
    procedure onEscapeExit(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SchedulerForm: TSchedulerForm;

implementation

{$R *.dfm}

uses Week, ShedulerClassUnit, GroupClass;

procedure TSchedulerForm.CreateNewGroup();
begin
   if (CurrentStudyGroup <> nil) then
   begin
      CurrentStudyGroup.Destroy();
      CurrentSheduler.Destroy();
      CurrentSheduler := CScheduler.Create;
      CurrentStudyGroup := CGroup.Create;
      WorkWeek.UpdateAllCompomemts();
   end
   else
   begin
      CurrentSheduler := CScheduler.Create;
      CurrentStudyGroup := CGroup.Create;
   end;
end;

procedure TSchedulerForm.SetParametrs();
const
   TopMargin = 30;
begin
   ClientWidth := 320;
   ClientHeight := 220;

   with edGroupNumb do
   begin
      Top := 30;
      Left := 30;
      Width := Self.ClientWidth - 60;
   end;

   with edYear do
   begin
      Top := edGroupNumb.Top + edGroupNumb.Height + TopMargin;
      Left := 30;
      Width := 80;
   end;

   with cbSemestr do
   begin
      Top := edGroupNumb.Top + edGroupNumb.Height + TopMargin;
      Left := edYear.Left + edYear.Width + 15;;
      Width := (Self.ClientWidth - 30 - Left);
   end;

   with btConfirm do
   begin
      Width := cbSemestr.Width;
      Top := cbSemestr.Top + cbSemestr.Height + TopMargin;
      Left := Self.Width - Width - 30;
   end;
end;

procedure TSchedulerForm.btConfirmClick(Sender: TObject);
const
   IncorrectInput = 'Вы не до конца заполнили все поля';
   Warning = 'Если вы не сохранили данные о прошлой группе, они будут утеряны!' +
      ' Желаете продолжить?';
var
   CanCreate: Boolean;
begin
   CanCreate := True;
   if (Length(edGroupNumb.Text) <> 6) or (Length(edYear.Text) <> 4)
      or (cbSemestr.ItemIndex = -1)  then
   begin
      MessageDlg(IncorrectInput, mtError, [mbOk], 0);
   end
   else
   begin
      if (not SavedInstance) then
      begin
         CanCreate :=  (MessageDlg(Warning, mtConfirmation, [mbYes, mbNo], 0)
         = mrYes);
      end;
      if (CanCreate) then
      begin
         CreateNewGroup();
         WorkWeek.Year := StrToint(edYear.Text);
         WorkWeek.GroupNumb := StrToInt(edGroupNumb.Text);
         WorkWeek.Semestr := (cbSemestr.ItemIndex + 1);
         WorkWeek.UpdateMainInfo();
         OpenedPath := '';
      end;
      Close;
   end;
end;

procedure TSchedulerForm.onEscapeExit(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
   begin
      Close;
   end;
end;

procedure TSchedulerForm.edGroupNumbKeyPress(Sender: TObject; var Key: Char);
begin
   if (Length(edGroupNumb.Text) = 6) and (Key <> #8) then
   begin
      Key := #0;
   end;
end;

procedure TSchedulerForm.edYearKeyPress(Sender: TObject; var Key: Char);
begin
   if (Length(edYear.Text) = 4) and (Key <> #8) then
   begin
      Key := #0;
   end;
end;

procedure TSchedulerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   edGroupNumb.Text := '';
   edYear.Text := '';
   cbSemestr.ItemIndex := -1;
   cbSemestr.Text := 'Семестра'
end;

procedure TSchedulerForm.FormCreate(Sender: TObject);
begin
   with cbSemestr do
   begin
      Items.Add('1 Семестр');
      Items.Add('2 Семестр');
      Items.Add('3 Семестр');
      Items.Add('4 Семестр');
      Items.Add('5 Семестр');
      Items.Add('6 Семестр');
      Items.Add('7 Семестр');
      Items.Add('8 Семестр');
   end;
end;

procedure TSchedulerForm.FormShow(Sender: TObject);
begin
   SetParametrs();
end;

end.
