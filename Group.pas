unit Group;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus;

type
  TGroupForm = class(TForm)
    sgGroup: TStringGrid;
    mnGroup: TMainMenu;
    AddStudent: TMenuItem;
    DeleteStudent: TMenuItem;
    ChangeStudent: TMenuItem;
    sgTitle: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure SetFormParametrs();
    procedure ChangingFormParametrs();
    procedure FormResize(Sender: TObject);
    procedure AddStudentClick(Sender: TObject);
    procedure ChangeStudentClick(Sender: TObject);
    procedure UpdateStudentList();
    procedure DeleteStudentClick(Sender: TObject);
    procedure onEscapeDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GroupForm: TGroupForm;

implementation

{$R *.dfm}

uses StudentFormUnit, GroupClass, Week;

procedure TGroupForm.UpdateStudentList;
const
   CellHeight = 30;
var
   I, Temp: Integer;
   StudentInfo: TStudentInfo;
   Names: String;
begin
    with sgGroup do
    begin
     if (CurrentStudyGroup = nil) or (CurrentStudyGroup.GetNumbOfStudents = 0) then
      begin
         RowCount := 0;
         Visible := False;
         Enabled := False;
      end
      else
      begin
         RowCount:= CurrentStudyGroup.GetNumbOfStudents;
         Visible := True;
         Enabled := True;
         for I := 0 to CurrentStudyGroup.GetNumbOfStudents - 1 do     //Нумерация столбцов и установка значений
         begin
            StudentInfo := CurrentStudyGroup.GetStudent(I)^.StudentInfo;
            Cells[0, I] := IntToStr(I + 1);
            Names := StudentInfo.Surname + ' ' + StudentInfo.Name + ' '
               + StudentInfo.MiddleName;
            Cells[1, I] := Names;
            RowHeights[I] := CellHeight;
         end;
      end;
   end;
end;

procedure TGroupForm.SetFormParametrs();
begin
   with sgTitle do
   begin
      Top := 30;
      Left := 30;
      Cells[0, 0] := '№';
      Cells[1, 0] := 'Фамилия Имя Отчество';
   end;

   with sgGroup do
   begin
      Top := sgTitle.Top + sgTitle.Height;
      Left := 30;

      Width := Self.ClientWidth - 60;
      Height := Self.ClientHeight - sgTitle.Height -  60;

      ColCount := 2;
      ColWidths[0] := 50;
   end;
   GroupForm.ChangingFormParametrs();
   GroupForm.UpdateStudentList;
end;

procedure TGroupForm.onEscapeDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      Close;
end;

procedure TGroupForm.AddStudentClick(Sender: TObject);
begin
   StudentForm.ShowModal;
end;

procedure TGroupForm.ChangeStudentClick(Sender: TObject);
const
   EmptyList = 'В данной группе пока что нет студентов!';
var
   LinkOnStudent: TStudentLink;
begin
   if (CurrentStudyGroup.GetNumbOfStudents <> 0) then
   begin
      LinkOnStudent := CurrentStudyGroup.GetStudent(sgGroup.Row);
      StudentForm.SetStudent(LinkOnStudent);
      StudentForm.ShowModal;
   end
   else
   begin
       MessageDlg(EmptyList, mtInformation, [mbOk], 0)
   end;
end;

procedure TGroupForm.ChangingFormParametrs();
var
   I: Integer;
begin
   with sgTitle do
   begin
      Width := Self.ClientWidth - 60;
      ColWidths[0] := 50;
      ColWidths[1] := Width - ColWidths[0] - 5;
   end;

   with sgGroup do
   begin
      Width := Self.ClientWidth - 60;
      Height := Self.ClientHeight - sgTitle.Height - sgTitle.Top - 30;

      ColWidths[1] := Width - ColWidths[0];
   end;
end;

procedure TGroupForm.DeleteStudentClick(Sender: TObject);
const
   AreSure = 'Вы уверены, что хотите удалить данного студента из списка?';
   EmptyList = 'В данной группе пока что нет студентов!';
var
   Student: TStudentLink;
begin
   if (CurrentStudyGroup.GetNumbOfStudents <> 0) then
   begin
      if (MessageDlg(AreSure, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
         Student := CurrentStudyGroup.GetStudent(sgGroup.Row);
         CurrentStudyGroup.DeleteStudent(Student);
         WorkWeek.UpdateStudentList;
         GroupForm.UpdateStudentList;
      end;
   end
   else
   begin
      MessageDlg(EmptyList, mtInformation, [mbOk], 0)
   end;
end;

procedure TGroupForm.FormResize(Sender: TObject);
begin
   GroupForm.ChangingFormParametrs();
end;

procedure TGroupForm.FormShow(Sender: TObject);
begin
   ClientWidth := 720;
   ClientHeight := 640;
   GroupForm.SetFormParametrs();
end;

end.
