unit SchedulerFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus;

type
  TScheduleForm = class(TForm)
    sgDaysOfWeek: TStringGrid;
    sgWeeksOfMonth: TStringGrid;
    sgSubjects: TStringGrid;
    MainMenuSheduler: TMainMenu;
    SaveSheduler: TMenuItem;
    ClearSheduler: TMenuItem;
    procedure SetParametrs();
    procedure ChangeParametrs();
    procedure FormShow(Sender: TObject);
    procedure SaveSchedulerGrid();
    procedure UpdateSchedulerGrid();
    procedure FormResize(Sender: TObject);
    procedure SaveShedulerClick(Sender: TObject);
    procedure sgSubjectsKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClearShedulerClick(Sender: TObject);
    procedure sgSubjectsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScheduleForm: TScheduleForm;
  StateSaved: Boolean;

implementation

{$R *.dfm}

uses ShedulerClassUnit, Week;


procedure TScheduleForm.SaveSchedulerGrid();
var
   Scheduler: TMonthScheduler;
   I, J, K: Integer;
begin
   for I := 0 to High(Scheduler) do
   begin
      for J := 0 to High(Scheduler[0]) do
      begin
         for K := 0 to High(Scheduler[0][0]) do
         begin
            Scheduler[I][J][K] := sgSubjects.Cells[J, I * 5 + K];
         end;
      end;
   end;
   CurrentSheduler.SetSheduler(Scheduler);
   StateSaved := True;
   WorkWeek.UpdateSubjectList();
end;

procedure TScheduleForm.ChangeParametrs();
var
   I, TempHeight: Integer;
begin
   with sgDaysOfWeek do
   begin
      for I := 1 to ColCount - 1 do
      begin
         ColWidths[I] := (Width - ColWidths[0]) div 6;
      end;
   end;

   with sgWeeksOfMonth do
   begin
      for I := 0 to RowCount - 1 do
      begin
         RowHeights[I] := Height div 4
      end;
   end;

   with sgSubjects do
   begin
      for I := 0 to ColCount - 1 do
      begin
         ColWidths[I] := sgDaysOfWeek.ColWidths[1] - 1;
      end;

      for I := 0 to RowCount - 1 do
      begin
         if (I mod 5 = 0) then
            TempHeight := sgWeeksOfMonth.RowHeights[0] - 1;
         RowHeights[I] := TempHeight div (5 - I mod 5) - 4 ;
         TempHeight := TempHeight - RowHeights[I];
      end;
      RowHeights[RowCount - 1] := RowHeights[RowCount - 1] - 3;
   end;
end;

procedure TScheduleForm.SaveShedulerClick(Sender: TObject);
begin
   ScheduleForm.SaveSchedulerGrid();
end;

procedure TScheduleForm.SetParametrs();
const
   FirstColumnWidth = 105;
var
   I: Integer;
begin
   ClientWidth := 1200;
   ClientHeight := 720;

   with sgDaysOfWeek do
   begin
      ColWidths[0] := FirstColumnWidth;
      Top := 30;
      Left := 30;
      Width := Self.ClientWidth - 60;
      Cells[1,0] := 'Понедельник';
      Cells[2,0] := 'Вторник';
      Cells[3,0] := 'Среда';
      Cells[4,0] := 'Четверг';
      Cells[5,0] := 'Пятница';
      Cells[6,0] := 'Суббота';
   end;

   with sgWeeksOfMonth do
   begin
      Width := FirstColumnWidth + 2;
      ColWidths[0] := FirstColumnWidth;
      Top :=sgDaysOfWeek.Top + sgDaysOfWeek.Height;
      Left := 30;

      Height := Self.ClientHeight - sgDaysOfWeek.Top - sgDaysOfWeek.Height - 30;
      Cells[0,0] := '1 Неделя';
      Cells[0,1] := '2 Неделя';
      Cells[0,2] := '3 неделя';
      Cells[0,3] := '4 Неделя';
   end;

   with sgSubjects do
   begin
      Top := sgWeeksOfMonth.Top;
      Left := sgWeeksOfMonth.Left + sgWeeksOfMonth.Width;
      Width := Self.ClientWidth - sgWeeksOfMonth.Left - sgWeeksOfMonth.Width - 28;
      Height := sgWeeksOfMonth.Height;
   end;
   ChangeParametrs();
end;

procedure TScheduleForm.sgSubjectsKeyPress(Sender: TObject; var Key: Char);
var
   KeyOrder: Integer;
   CellText: String;
begin
   with sgSubjects do
   begin
      CellText := Cells[sgSubjects.Col, sgSubjects.Row];
      if ((Length(CellText) = 25) and (Key <> #8)) then
         Key := #0;
      KeyOrder := Ord(Key);
      if (KeyOrder <> 8) and (Key <> ' ') then
      begin
         if ((KeyOrder < 1072) or (KeyOrder > 1103)) then        // 'a' = 1072, 'я' = 1103
         begin
            if ((KeyOrder < 1040) or (KeyOrder > 1071)) then     // 'А' = 1040, 'Я' = 1071
               Key := #0;
         end;
      end
      else
      begin
         if (Key = ' ') and((Length(CellText) <> 0) and (CellText[Length(CellText)] = ' ') // нельзя ввести два пробела подряд и первый пробел
            or (Length(CellText) = 0))then
            Key := #0;
      end;
      if ((Length(CellText) = 14) and (Key <> #8)) then
      begin
         Key := #0;
      end;
   end;
   StateSaved := False;
end;

procedure TScheduleForm.ClearShedulerClick(Sender: TObject);
var
   I, J: Integer;
begin
   with sgSubjects do
   begin
      for I := 0 to ColCount - 1 do
      begin
         for J := 0 to RowCount - 1 do
         begin
            Cells[I, J] := '';
         end;
      end;
   end;
   StateSaved := False;
end;

procedure TScheduleForm.UpdateSchedulerGrid;
var
   Scheduler: TMonthScheduler;
   I, J, K: Integer;
begin
   Scheduler := CurrentSheduler.GetScheduler();
   for I := 0 to High(Scheduler) do
   begin
      for J := 0 to High(Scheduler[0]) do
      begin
         for K := 0 to High(Scheduler[0][0]) do
         begin
            sgSubjects.Cells[J, I * 5 + K] := Scheduler[I][J][K];
         end;
      end;
   end;
   CurrentSheduler.SetSheduler(Scheduler);
   StateSaved := True;
end;

procedure TScheduleForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
   Save = 'Вы внесли изменения файл, но не сохранили их, хотите их сохранить?';
var
   Choice: Integer;
begin
   if (not StateSaved) then
   begin
      Choice := MessageDlg(Save, mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      case Choice of
         mrCancel: CanClose := False;
         mrYes: ScheduleForm.SaveSchedulerGrid();
      end;
   end;
end;

procedure TScheduleForm.FormResize(Sender: TObject);
begin
   ScheduleForm.ChangeParametrs
end;

procedure TScheduleForm.FormShow(Sender: TObject);
begin
   ScheduleForm.SetParametrs();
   ScheduleForm.UpdateSchedulerGrid();
end;

procedure TScheduleForm.sgSubjectsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      Close;
end;

end.
