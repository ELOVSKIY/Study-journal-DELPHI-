program Course;

uses
  Vcl.Forms,
  Week in 'Week.pas' {WorkWeek},
  GroupClass in 'GroupClass.pas',
  Group in 'Group.pas' {GroupForm},
  StudentFormUnit in 'StudentFormUnit.pas' {StudentForm},
  SchedulerFormUnit in 'SchedulerFormUnit.pas' {ScheduleForm},
  ShedulerClassUnit in 'ShedulerClassUnit.pas',
  NewGroupFormUnit in 'NewGroupFormUnit.pas' {SchedulerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWorkWeek, WorkWeek);
  Application.CreateForm(TGroupForm, GroupForm);
  Application.CreateForm(TStudentForm, StudentForm);
  Application.CreateForm(TScheduleForm, ScheduleForm);
  Application.CreateForm(TSchedulerForm, SchedulerForm);
  Application.Run;
end.
