unit StudentFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, GroupClass;

type
  TStudentForm = class(TForm)
    btConfirm: TButton;
    edMiddleName: TEdit;
    edName: TEdit;
    edSurname: TEdit;
    lbMiddleName: TLabel;
    lbName: TLabel;
    lbSurname: TLabel;
    cbLeader: TCheckBox;
    procedure SetParametrs();
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbLeaderKeyPress(Sender: TObject; var Key: Char);
    procedure btConfirmClick(Sender: TObject);
    procedure SetStudent(StudentLink: TStudentLink);
    procedure FormCreate(Sender: TObject);
    procedure CorrectNames();
    procedure onEditKeyPress(Sender: TObject; var Key: Char);
    procedure onDownEscape(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    CurrentStudentLink: TStudentLink;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StudentForm: TStudentForm;

implementation

{$R *.dfm}

uses  Week, Group;

procedure TStudentForm.SetStudent(StudentLink: TStudentLink);
begin
   CurrentStudentLink := StudentLink;
   edSurname.Text := StudentLink^.StudentInfo.Surname;
   edName.Text := StudentLink^.StudentInfo.Name;
   edMiddleName.Text := StudentLink^.StudentInfo.MiddleName;
   cbLeader.Checked := StudentLink^.StudentInfo.Leader;
end;

procedure TStudentForm.CorrectNames;
var
   Surname, Name, MiddleName: String;
begin
   Surname := AnsiLowerCase(edSurname.Text);
   Name := AnsiLowerCase(edName.Text);
   MiddleName := AnsiLowerCase(edMiddleName.Text);

   if (Ord(Surname[1]) > 1071) then
   begin
      Surname[1] := WideChar(Ord(Surname[1]) - 32);
   end;
   if (Ord(Name[1]) > 1071) then
   begin
      Name[1] := WideChar(Ord(Name[1]) - 32);
   end;
   if (Ord(MiddleName[1]) > 1071) then
   begin
      MiddleName[1] := WideChar(Ord(MiddleName[1]) - 32);
   end;

   edSurname.Text := Surname;
   edName.Text := Name;
   edMiddleName.Text := MiddleName;
end;

procedure TStudentForm.btConfirmClick(Sender: TObject);
const
   EmptyFieldError = 'Поля должны быть заполнены!';
var
   StudentInfo: TStudentInfo;
begin
   if (Length(edName.Text) = 0) or (Length(edMiddleName.Text) = 0)
      or (Length(edSurname.Text) = 0) then
   begin
      MessageDlg(EmptyFieldError, mtError, [mbOk], 0)
   end
   else
   begin
      StudentForm.CorrectNames();
      if (CurrentStudyGroup.GetLeaderStatus and cbLeader.Checked) then
      begin
         CurrentStudyGroup.RemoveLeader();
      end;

      if (CurrentStudentLink = nil) then
      begin
         StudentInfo.Surname := edSurname.Text;
         StudentInfo.Name := edName.Text;
         StudentInfo.MiddleName := edMiddleName.Text;
         StudentInfo.Leader := cbLeader.Checked;
         CurrentStudyGroup.AddStudent(StudentInfo);
      end
      else
      begin
         CurrentStudentLink^.StudentInfo.Surname := edSurname.Text;
         CurrentStudentLink^.StudentInfo.Name := edName.Text;
         CurrentStudentLink^.StudentInfo.MiddleName := edMiddleName.Text;
         CurrentStudentLink^.StudentInfo.Leader := cbLeader.Checked;
      end;
      CurrentStudyGroup.SortStudents(CurrentStudyGroup);
      WorkWeek.UpdateStudentList();
      WorkWeek.UpdateMissingGrid();
      GroupForm.UpdateStudentList;
      Close;
   end;
end;

procedure TStudentForm.cbLeaderKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) then
      cbLeader.Checked := not cbLeader.Checked;
end;

procedure TStudentForm.onDownEscape(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      Close;
end;

procedure TStudentForm.onEditKeyPress(Sender: TObject; var Key: Char);
var
   KeyOrder: Integer;
begin
   KeyOrder := Ord(Key);
   with Sender as TEdit do
   begin
      if ((Length(Text) = 12) and (Key <> #8)) then
         Key := #0;
      if (KeyOrder <> 8) then
      begin
         if ((KeyOrder < 1072) or (KeyOrder > 1103)) then        // 'a' = 1072, 'я' = 1103
         begin
            if ((KeyOrder < 1040) or (KeyOrder > 1071)) then     // 'А' = 1040, 'Я' = 1071
               Key := #0;
         end;
      end
   end;
end;

procedure TStudentForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
   I: Integer;
begin
   for I := 0 to ControlCount - 1 do
   begin
      if Controls[I].ClassType = TEdit then
         TEdit(Controls[I]).Clear
   end;
   cbLeader.Checked := False;
   CurrentStudentLink := nil;
end;

procedure TStudentForm.FormCreate(Sender: TObject);
begin
   CurrentStudentLink := nil;
end;

procedure TStudentForm.FormShow(Sender: TObject);
begin
   StudentForm.SetParametrs;
end;

procedure TStudentForm.SetParametrs();
const
   TopMargin = 30;
begin
   ClientWidth := 320;
   ClientHeight := 360;
   with lbSurname do
   begin
      Left := 30;
      Top := 30;
   end;

   with edSurname do
   begin
      Left := 30;
      Top := lbSurname.Top + lbSurname.Height;
      Width := Self.ClientWidth - 60;
   end;

   with lbName do
   begin
      Left := 30;
      Top := edSurname.Top + edSurname.Height + TopMargin;
   end;

   with edName do
   begin
      Left := 30;
      Top := lbName.Top + lbName.Height;
      Width := Self.ClientWidth - 60;
   end;

   with lbMiddleName do
   begin
      Left := 30;
      Top := edName.Top + edName.Height + TopMargin;
   end;

   with edMiddleName do
   begin
      Left := 30;
      Top := lbMiddleName.Top + lbMiddleName.Height;
      Width := Self.ClientWidth - 60;

   end;

   with cbLeader do
   begin
      Left := 30;
      Top := edMiddleName.Top + edMiddleName.Height + TopMargin;
   end;

   with btConfirm do
   begin
      Width := 160;
      Left := Self.ClientWidth - Width - 30;
      Top := cbLeader.Top + cbLeader.Height + TopMargin;
   end;

end;

end.
