unit Week;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Group, GroupClass, ShedulerClassUnit,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TWorkWeek = class(TForm)
    miMainMenuWeek: TMainMenu;
    miMenuSheduler: TMenuItem;
    miSaveAs: TMenuItem;
    miOpenFile: TMenuItem;
    miMenuChange: TMenuItem;
    miChangeSheduler: TMenuItem;
    miChangeGroup: TMenuItem;
    sgSheduler: TStringGrid;
    sgTitle: TStringGrid;
    Create: TMenuItem;
    sgClasses: TStringGrid;
    btNextPage: TSpeedButton;
    btPrevPage: TSpeedButton;
    pnlGroupNumb: TFlowPanel;
    pnlWeekNumber: TFlowPanel;
    pnlYear: TFlowPanel;
    pnlSemestrWeek: TFlowPanel;
    pnlSemestr: TFlowPanel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    miSave: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure SetFormParametrs();
    procedure ChangeFormParametrs();
    procedure FormResize(Sender: TObject);
    procedure miChangeGroupClick(Sender: TObject);
    procedure CreateClick(Sender: TObject);
    procedure UpdateStudentList();
    procedure UpdateSubjectList();
    procedure UpdateMainInfo();
    procedure UpdateMissingGrid;
    procedure miChangeShedulerClick(Sender: TObject);
    procedure sgClassesDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btNextPageClick(Sender: TObject);
    procedure btPrevPageClick(Sender: TObject);
    procedure EscapeExit(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgShedulerDblClick(Sender: TObject);
    procedure SetWeeks();
    procedure miSaveAsClick(Sender: TObject);
    procedure SaveMainInfo(Path: String);
    procedure SaveScheduler(Path: String);
    procedure SaveGroup(Path: String);
    procedure SaveMissingList(Path: String);
    procedure SaveFileGroup(Path: String);
    procedure miOpenFileClick(Sender: TObject);
    function OpenMainInfo(Path: String): Boolean;
    function OpenScheduler(Path: String): Boolean;
    function OpenGroup(Path: String): Boolean;
    function OpenMissingList(Path: String): Boolean;
    procedure UpdateAllCompomemts();
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miSaveClick(Sender: TObject);
  private
    CurrentStudyWeek: Integer;
    CurrentWeek: Integer;
  public
    GroupNumb, GroupNumbBuffer: Integer;
    Semestr, SemestrBuffer: Integer;
    Year, YearBuffer: Integer;
  end;

var
  WorkWeek: TWorkWeek;
  CurrentStudyGroup, StudyGroupBuffer: CGroup;
  CurrentSheduler, SchedulerBuffer: CScheduler;
  SavedInstance: Boolean = True;
  OpenedPath: String = '';
implementation

{$R *.dfm}

uses StudentFormUnit, SchedulerFormUnit, NewGroupFormUnit;

function GetCellFromInt(Numb: Integer): String;
begin
   if (Numb = 0) then
   begin
      Result := '';
   end
   else
   begin
      Result := IntToStr(Numb);
   end;
end;

procedure TWorkWeek.UpdateAllCompomemts;
begin
   UpdateStudentList();
   UpdateSubjectList();
   UpdateMainInfo();
   UpdateMissingGrid();
end;

procedure TWorkWeek.UpdateMissingGrid;      //переименовать
var
   I, J: Integer;
   Missings: TMissingLink;
begin
   with sgSheduler do
   begin
      for I := 0 to CurrentStudyGroup.GetNumbOfStudents - 1 do
      begin
         Missings := CurrentStudyGroup.GetStudent(I).MissingList;
         for J := 2 to ColCount - 1 do
         begin
            Cells[J, I] := GetCellFromInt(Missings^[CurrentWeek][(J - 2) div 6][(J - 2) mod 6])
         end;
      end;
   end;
end;

procedure TWorkWeek.sgShedulerDblClick(Sender: TObject);
var
   Student: TStudentLink;
   Missings: TMissingLink;
begin
   SavedInstance := False;
   with sgSheduler do
   begin
      if (Length(sgClasses.Cells[Col, 0]) <> 0) then
      begin
         Student := CurrentStudyGroup.GetStudent(Row);
         Missings := Student^.MissingList;
         Missings^[CurrentWeek][(Col - 2)div 6][(Col - 2) mod 6]
            := (Missings^[CurrentWeek][(Col - 2) div 6][(Col - 2) mod 6] + 1) mod 3;
         Cells[Col, Row] := GetCellFromInt(Missings^[CurrentWeek][(Col - 2) div 6][(Col - 2) mod 6]);
      end;
   end;
end;

procedure TWorkWeek.UpdateSubjectList;
var
   MonthScheduler: TMonthScheduler;
   I, J: Integer;
begin
   if (CurrentStudyGroup <> nil) then
   begin
      MonthScheduler := CurrentSheduler.GetScheduler;
      for I := 0 to 5 do
      begin
         for J := 0 to 4 do
         begin
            sgClasses.Cells[I * 5 + J + 2, 0]
               := MonthScheduler[CurrentStudyWeek][I][J];
         end;
      end;
      pnlWeekNumber.Caption := IntToStr(CurrentStudyWeek + 1) +
         ' неделя';
      pnlSemestrWeek.Caption := IntToStr(CurrentWeek + 1) +
         ' неделя';
   end;
end;

procedure TWorkWeek.UpdateStudentList();
const
   ShedulerCellHeight = 30;
var
   I: Integer;
   StudentInfo: TStudentInfo;
   Names: String;
begin
   with sgSheduler do
   begin
      if (CurrentStudyGroup = nil) or (CurrentStudyGroup.GetNumbOfStudents = 0) then
      begin
         RowCount := 1;
         for I := 0 to ColCount - 1 do
         begin
            Cells[I, 0] := '';
         end;
         Enabled := False;
      end
      else
      begin
         Enabled := True;
         RowCount:= CurrentStudyGroup.GetNumbOfStudents;
         for I := 0 to CurrentStudyGroup.GetNumbOfStudents - 1 do     //Нумерация столбцов и установка значений
         begin
            Cells[0, I] := IntToStr(I + 1);
            StudentInfo := CurrentStudyGroup.GetStudent(I)^.StudentInfo;
            Names := StudentInfo.Surname + ' ' + StudentInfo.Name[1] +
                 '.' + StudentInfo.MiddleName[1] + '.';
            if (StudentInfo.Leader) then
               Names := Names + ' (*)';
            Cells[1, I] := Names;
            RowHeights[I] := ShedulerCellHeight;
         end;
      end;
   end;
end;

procedure TWorkWeek.btNextPageClick(Sender: TObject);
begin
   CurrentStudyWeek := (CurrentStudyWeek + 1) mod 4;
   CurrentWeek := CurrentWeek + 1;
   WorkWeek.UpdateSubjectList();
   WorkWeek.UpdateMissingGrid();
   btPrevPage.Enabled := True;
   if (CurrentWeek= 15) then
   begin
      btNextPage.Enabled := False;
   end;
end;

procedure TWorkWeek.btPrevPageClick(Sender: TObject);
begin
   CurrentStudyWeek := (CurrentStudyWeek + 3) mod 4;
   CurrentWeek := CurrentWeek - 1;
   WorkWeek.UpdateSubjectList();
   WorkWeek.UpdateMissingGrid();
   btNextPage.Enabled :=True;
   if (CurrentWeek = 0) then
   begin
      btPrevPage.Enabled := False;
   end;
end;

procedure  TWorkWeek.ChangeFormParametrs();
var
   I, TempWidth: Integer;
begin
   with sgTitle do
   begin
      for I := 2 to ColCount - 1 do
      begin
         ColWidths[I] := (Width - ColWidths[0] - ColWidths[1]) div 6;
      end;
   end;

   with sgClasses do
   begin
      for I := 2 to ColCount - 1 do
      begin
         if (I mod 5 = 2) then
            TempWidth := sgTitle.ColWidths[2];
         ColWidths[I] := TempWidth div (5 - (I - 2) mod 5) - 4;
         TempWidth := TempWidth - ColWidths[I];
      end;
   end;

   with sgSheduler do
   begin
      for I := 2 to ColCount - 1 do
      begin
         if (I mod 5 = 2) then
            TempWidth := sgTitle.ColWidths[2];
         ColWidths[I] := TempWidth div (5 - (I - 2) mod 5) - 4;
         TempWidth := TempWidth - ColWidths[I];
      end;
   end;

   with btNextPage do
   begin
      Left := sgSheduler.Left + sgSheduler.Width - Width;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

   with btPrevPage do
   begin
      Left := btNextPage.Left - Width - 20;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

   with pnlGroupNumb do
   begin
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

   with pnlWeekNumber do
   begin
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

   with pnlSemestr do
   begin
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

   with pnlYear do
   begin
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

   with pnlSemestrWeek do
   begin
      Top := sgSheduler.Top + sgSheduler.Height + 15;
   end;

end;

procedure TWorkWeek.SaveMissingList(Path: String);
var
   FileName: String;
   MissingFile: File of TSemestrMissing;
   MissingList: TSemestrMissing;
   I: Integer;
begin
   FileName := Path + '.msgl';
   AssignFile(MissingFile, FileName);
   Rewrite(MissingFile);
   for I := 0 to CurrentStudyGroup.GetNumbOfStudents - 1 do
   begin
      MissingList := CurrentStudyGroup.GetStudent(I).MissingList^;
      Write(MissingFile, MissingList);
   end;
   CloseFile(MissingFile);
end;

procedure TWorkWeek.SaveGroup(Path: String);
var
   FileName: String;
   GroupFile: File of TStudentInfo;
   I: Integer;
   TempStudentInfo: TStudentInfo;
begin
   FileName := Path + '.grp';
   AssignFile(GroupFile, FileName);
   Rewrite(GroupFile);
   for I := 0 to CurrentStudyGroup.GetNumbOfStudents - 1 do
   begin
      TempStudentInfo := CurrentStudyGroup.GetStudent(I).StudentInfo;
      Write(GroupFile, TempStudentInfo);
   end;
   CloseFile(GroupFile);
end;

procedure TWorkWeek.SaveScheduler(Path: String);
var
   FileName: String;
   SchedulerFile: File of TMonthScheduler;
   Scheduler: TMonthScheduler;
begin
   Scheduler := CurrentSheduler.GetScheduler;
   FileName := Path + '.schd';
   AssignFile(SchedulerFile, FileName);
   Rewrite(SchedulerFile);
   Write(SchedulerFile, Scheduler);
   CloseFile(SchedulerFile);
end;

procedure TWorkWeek.SaveMainInfo(Path: String);
var
   MainInfoFile: File of Integer;
   FileName: String;
begin
   FileName := Path + '.jrnl';
   AssignFile(MainInfoFile, FileName);
   Rewrite(MainInfoFile);
   Write(MainInfoFile, GroupNumb);
   Write(MainInfoFile, Year);
   Write(MainInfoFile, Semestr);
   CloseFile(MainInfoFile);
end;

procedure TWorkWeek.SaveFileGroup(Path: String);
begin
   SaveMainInfo(Path);
   SaveScheduler(Path);
   SaveGroup(Path);
   SaveMissingList(Path);
   SavedInstance := True;
   miSave.Enabled := True;
end;

procedure TWorkWeek.miSaveAsClick(Sender: TObject);
const
   NotEmptyFile = 'Данный файл не является пустым.' +
      #13#10 + 'Хотите его перезаписать?';
var
   FileName, Path: String;
begin
   if SaveDialog.Execute then
   begin
      Path := ExtractFilePath(SaveDialog.FileName) +pnlGroupNumb.Caption +
          '-' + pnlYear.Caption + '-' + pnlSemestr.Caption[1];
      FileName := Path + '.jrnl';
      if (FileExists(FileName)) then
      begin
         if (MessageDlg(NotEmptyFile, mtConfirmation,
            [mbYes, mbNo], 0) = mrYes) then
         begin
            SaveFileGroup(Path);
         end
         else
         begin
            WorkWeek.miSaveAsClick(Sender);
         end;
      end
      else
      begin
         SaveFileGroup(Path);
      end
   end;
end;

procedure TWorkWeek.miSaveClick(Sender: TObject);
begin
   SaveFileGroup(OpenedPath);
end;

function TWorkWeek.OpenMissingList(Path: String): Boolean;
var
   FileName: String;
   MissingFile: File of TSemestrMissing;
   MissingList: TSemestrMissing;
   MissingLink: TMissingLink;
   I: Integer;
begin
   Result := True;
   try
      FileName := Path + '.msgl';
      AssignFile(MissingFile, FileName);
      Reset(MissingFile);
      for I := 0 to StudyGroupBuffer.GetNumbOfStudents - 1 do
      begin
         Read(MissingFile, MissingList);
         StudyGroupBuffer.GetStudent(I).MissingList^ := MissingList;
      end;
      CloseFile(MissingFile);
   except
      Result := False;
   end;
end;

function TWorkWeek.OpenGroup(Path: String): Boolean;
var
   FileName: String;
   GroupFile: File of TStudentInfo;
   I: Integer;
   TempStudentInfo: TStudentInfo;
begin
   Result := True;
   try
      FileName := Path + '.grp';
      AssignFile(GroupFile, FileName);
      Reset(GroupFile);
      while (not EoF(GroupFile)) do
      begin
         Read(GroupFile, TempStudentInfo);
         StudyGroupBuffer.AddStudent(TempStudentInfo);
      end;
      CloseFile(GroupFile);
   except
      Result := False;
   end;
end;

function TWorkWeek.OpenScheduler(Path: String): Boolean;
var
   FileName: String;
   SchedulerFile: File of TMonthScheduler;
   Scheduler: TMonthScheduler;
begin
   Result := True;
   try
      FileName := Path + '.schd';
      AssignFile(SchedulerFile, FileName);
      Reset(SchedulerFile);
      Read(SchedulerFile, Scheduler);
      SchedulerBuffer.SetSheduler(Scheduler);
      CloseFile(SchedulerFile);
   except
      Result := False;
   end;
end;

function TWorkWeek.OpenMainInfo(Path: String): Boolean;
var
   FileName: String;
   MainInfoFile: File of Integer;
   Temp: Integer;
begin
   Result := True;
   try
      FileName := Path + '.jrnl';
      AssignFile(MainInfoFile, FileName);
      Reset(MainInfoFile);
      Read(MainInfoFile, GroupNumbBuffer);
      Read(MainInfoFile, YearBuffer);
      Read(MainInfoFile, SemestrBuffer);
      CloseFile(MainInfoFile);
   except
      Result := False;
   end;
end;

procedure TWorkWeek.miOpenFileClick(Sender: TObject);
const
   FileGroupOpenSuccess = 'Файл журнала был удачно открыт';
   FileGroupOpenDenied ='В ходе открытия произоошла ошибка,' +
      ' возможно один из файлов был повреждён';
   Warning = 'Вы не сохранили данные о прошлой группе, они будут утеряны!' +
      ' Желаете продолжить?';
var
   CorrectFileGroup: Boolean;
   Path: String;
   CanOpen: Boolean;
begin
   CanOpen := True;
   if (not SavedInstance) then
   begin
      CanOpen :=  (MessageDlg(Warning, mtConfirmation, [mbYes, mbNo], 0)
         = mrYes);
   end;
   if (CanOpen) then
   begin
      CorrectFileGroup := True;
      if OpenDialog.Execute then
      begin
         Path := OpenDialog.FileName;
         StudyGroupBuffer := CGroup.Create();
         SchedulerBuffer := CScheduler.Create();
         Delete(Path, Length(path) - 4, 5);
         CorrectFileGroup := OpenMainInfo(Path) and CorrectFileGroup;
         CorrectFileGroup := OpenScheduler(Path) and CorrectFileGroup;
         CorrectFileGroup := OpenGroup(Path) and CorrectFileGroup;
         CorrectFileGroup := OpenMissingList(Path) and CorrectFileGroup;
         if (CorrectFileGroup) then
         begin
            if (CurrentStudyGroup <> nil) then
            begin
               CurrentStudyGroup.Destroy();
               CurrentSheduler.Destroy();
            end;

            CurrentStudyGroup := StudyGroupBuffer;
            CurrentSheduler := SchedulerBuffer;
            Year := YearBuffer;
            Semestr := SemestrBuffer;
            GroupNumb := GroupNumbBuffer;

            UpdateAllCompomemts();
            MessageDlg(FileGroupOpenSuccess, mtInformation, [mbOk], 0);
            miSave.Enabled := True;
            SavedInstance := True;
            OpenedPath := Path;
         end
         else
         begin
            StudyGroupBuffer.Destroy();
            CurrentSheduler.Destroy();
            MessageDlg(FileGroupOpenDenied, mtInformation, [mbOk], 0);
         end;
      end;
   end
end;

procedure TWorkWeek.SetFormParametrs();
const
   TitleCellHeight = 50;
begin
   ClientWidth := 1800;
   ClientHeight := 720;

   with sgTitle do
   begin
      Top := 30;
      Left := 30;
      Height := TitleCellHeight;
      Width := Self.ClientWidth - 60;

      RowHeights[0] := TitleCellHeight;
      ColWidths[0] := 50;
      ColWidths[1] := 220;

      Cells[0, 0] := '№';
      Cells[1, 0] := 'Ф.И.О';
      Cells[2, 0] := 'Понедельник';
      Cells[3, 0] := 'Вторник';
      Cells[4, 0] := 'Среда';
      Cells[5, 0] := 'Четверг';
      Cells[6, 0] := 'Пятница';
      Cells[7, 0] := 'Суббота';
   end;

   with sgClasses do
   begin
      Top := sgTitle.Top + sgTitle.Height;
      Left := 30;
      Height := 120;
      Width := Self.ClientWidth - 60;

      RowHeights[0] := 120;
      ColWidths[0] := 50;
      ColWidths[1] := 220;
   end;

   with btNextPage do
   begin
      Width := 130;
      Height := 35;
   end;

   with btPrevPage do
   begin
      Width := 130;
      Height := 35;
   end;

   with sgSheduler do
   begin
      Top := sgClasses.Top + sgClasses.Height;
      Left := 30;

      Width := Self.ClientWidth - 38;
      Height := Self.ClientHeight - sgClasses.Height - sgClasses.Top - btNextPage.Height - 45;

      ColWidths[0] := 50;
      ColWidths[1] := 220;
   end;

   with pnlGroupNumb do
   begin
      Left := 30;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
      Width := 120;
   end;

   with pnlSemestr do
   begin
      Left := pnlGroupNumb.Left + pnlGroupNumb.Width;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
      Width := 120;
   end;

   with pnlWeekNumber do
   begin
      Left := pnlSemestr.Left + pnlSemestr.Width;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
      Width := 120;
   end;

   with pnlYear do
   begin
      Left := pnlWeekNumber.Left + pnlWeekNumber.Width;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
      Width := 120;
   end;

   with pnlSemestrWeek do
   begin
      Left := pnlYear.Left + pnlYear.Width;
      Top := sgSheduler.Top + sgSheduler.Height + 15;
      Width := 120;
   end;
end;

procedure StringGridRotateTextOut(Grid: TStringGrid; ARow, ACol: Integer; Rect: TRect;
   Schriftart: string; Size: Integer; Color: TColor; Alignment: TAlignment);
var
   lf: TLogFont;
   tf: TFont;
begin
   if (Size > Grid.ColWidths[ACol] div 2) then
      Size := Grid.ColWidths[ACol] div 2;
   with Grid.Canvas do
   begin
      Font.Name := Schriftart;
      Font.Size := Size;
      Font.Color := Color;
      tf := TFont.Create;
      try
         tf.Assign(Font);
         GetObject(tf.Handle, SizeOf(lf), @lf);
         lf.lfEscapement  := 900;
         lf.lfOrientation := 0;
         tf.Handle := CreateFontIndirect(lf);
         Font.Assign(tf);
      finally
         tf.Free;
      end;

      FillRect(Rect);
      TextRect(Rect, Rect.Right - Size - Size div 2  - 6,Rect.Bottom - 5,Grid.Cells[ACol, ARow]);
   end;
end;

procedure TWorkWeek.sgClassesDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
   CellTest: String;
begin
   sgClasses.Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Left + Rect.Width, Rect.Top + Rect.Height);
   StringGridRotateTextOut(sgClasses, ARow, ACol, Rect, 'ARIAL', 14 ,clBlack, taRightJustify);
end;

procedure TWorkWeek.miChangeGroupClick(Sender: TObject);
begin
   SavedInstance := False;
   GroupForm.ShowModal;
end;

procedure TWorkWeek.miChangeShedulerClick(Sender: TObject);
begin
   SavedInstance := False;
   SchedulerFormUnit.ScheduleForm.ShowModal;
end;

procedure TWorkWeek.CreateClick(Sender: TObject);
begin
   SavedInstance := True;
   SchedulerForm.ShowModal;
end;

procedure TWorkWeek.EscapeExit(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
   begin
      Close;
   end;
end;

procedure TWorkWeek.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
   Save = 'Вы не сохранили изменения, действительно хотите выйти?';
begin
   if (not SavedInstance) then
   begin
      CanClose := MessageDlg(Save, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
   end;
end;

procedure TWorkWeek.FormResize(Sender: TObject);
begin
   WorkWeek.ChangeFormParametrs()
end;

procedure TWorkWeek.FormShow(Sender: TObject);
begin
   WorkWeek.SetFormParametrs();
   WorkWeek.ChangeFormParametrs();
   WorkWeek.UpdateStudentList();
end;

procedure TWorkWeek.SetWeeks();
begin

   CurrentStudyWeek := 0;
   CurrentWeek := 0;
end;

procedure TWorkWeek.UpdateMainInfo();
begin
   pnlGroupNumb.Caption := IntToStr(GroupNumb);
   pnlYear.Caption := IntToStr(Year);
   pnlSemestr.Caption := IntToStr(Semestr) + ' Семестр';
   pnlSemestrWeek.Caption := '1 Неделя';
   pnlWeekNumber.Caption := '1 Неделя';
   miMenuChange.Enabled := True;
   btNextPage.Enabled := True;
   miSaveAs.Enabled := True;
   SetWeeks();
end;

end.
