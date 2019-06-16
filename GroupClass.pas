unit GroupClass;


interface


type
   TSemestrMissing = array[0..29] of array[0..5] of array[0..4] of Byte;

   TMissingLink = ^TSemestrMissing;

   TNameField = String[12];

   TStudentLink = ^TStudent;
   TStudentInfo = record
    Name: TNameField;
      Surname: TNameField;
      MiddleName: TNameField;
      Leader: Boolean;
   end;

   TStudent = record
      StudentInfo: TStudentInfo;
      NextStudent: TStudentLink;
      PrevStudent: TStudentLink;
      MissingList: TMissingLink;
   end;

   CGroup = class
      private
         StudentNumber: Integer;
         FirstStudent: TStudentLink;
         LastStudent: TStudentLink;
         Leader: Boolean;
      public
         Constructor Create;
         procedure AddStudent(StudentInfo: TStudentInfo);
         procedure DeleteStudent(Student: TStudentLink);
         procedure RemoveLeader();
         procedure SetLeader();
         procedure SortStudents(Group: CGroup);
         function GetNumbOfStudents(): Integer;
         function GetStudent(Position: Integer): TStudentLink;
         function GetLeaderStatus(): Boolean;
         destructor Destroy();
   end;

implementation

uses Week;

constructor CGroup.Create();
begin
   FirstStudent := nil;
   LastStudent := nil;
   StudentNumber := 0;
   LEader := False;
end;

procedure CGroup.RemoveLeader();
var
   Iterator: TStudentLink;
begin
   Iterator := FirstStudent;
   while (Iterator <> nil) do
   begin
      if (Iterator^.StudentInfo.Leader) then
      begin
         Iterator^.StudentInfo.Leader := False;
         Break;
      end;
      Iterator := Iterator^.NextStudent;
   end;
end;

procedure CGroup.AddStudent(StudentInfo: TStudentInfo);
var
   PlaceForStudent: TStudentLink;
   PlaceForMissingList: TMissingLink;
begin
   New(PlaceForStudent);
   New(PlaceForMissingList);
   PlaceForStudent^.StudentInfo.Surname := StudentInfo.Surname;
   PlaceForStudent^.StudentInfo.Name := StudentInfo.Name;
   PlaceForStudent^.StudentInfo.MiddleName := StudentInfo.MiddleName;
   PlaceForStudent^.StudentInfo.Leader := StudentInfo.Leader;
   PlaceForStudent^.MissingList := PlaceForMissingList;
   if (LastStudent = nil) then
   begin
      FirstStudent := PlaceForStudent;
      FirstStudent^.PrevStudent := nil;
      LastStudent := PlaceForStudent;
   end
   else
   begin
      LastStudent^.NextStudent := PlaceForStudent;
      PlaceForStudent^.PrevStudent := LastStudent;
      LastStudent := PlaceForStudent;
   end;

   if (StudentInfo.Leader) then
   begin
      Self.Leader := True;
   end;
   LastStudent^.NextStudent := nil;
   Inc(StudentNumber);
end;

procedure CGroup.DeleteStudent(Student: TStudentLink);
begin
   if (Student = FirstStudent) then
   begin
      FirstStudent := Student^.NextStudent;
   end
   else
   begin
      Student.PrevStudent^.NextStudent := Student^.NextStudent;
   end;

   if (Student = LastStudent) then
   begin
      LastStudent := Student^.PrevStudent;
   end
   else
   begin
      Student.NextStudent^.PrevStudent := Student^.PrevStudent;
   end;

   if (Student^.StudentInfo.Leader) then
   begin
      Self.Leader := False;
   end;
   Dispose(Student.MissingList);
   Dispose(Student);
   Dec(StudentNumber);
end;

function CGroup.GetNumbOfStudents(): Integer;
begin
   Result := StudentNumber;
end;

function CGroup.GetStudent(Position: Integer): TStudentLink;
var
   Iterator: TStudentLink;
   I: Integer;
begin
   Iterator := FirstStudent;
   for I := 0 to Position - 1 do
   begin
      Iterator := Iterator^.NextStudent;
   end;
   Result := Iterator;
end;

function CGroup.GetLeaderStatus(): Boolean;
begin
   Result := Self.Leader;
end;

procedure CGroup.SetLeader;
begin
   Self.Leader := True;
end;

function StudnetComparator(Student1, Student2: TStudentLink): Boolean;
begin
   if (Student1^.StudentInfo.Surname <> Student2^.StudentInfo.Surname) then
   begin
      Result := (Student1^.StudentInfo.Surname > Student2^.StudentInfo.Surname);
   end
   else
   begin
      Result := ((Student1^.StudentInfo.Name > Student2^.StudentInfo.Name))
   end;
end;

procedure StudentSwap(var Student1, Student2: TStudentLink);
var
   Temp: String[12];
   TempMissingsList: TMissingLink;
   TempLeader: Boolean;
begin
   Temp := Student1^.StudentInfo.Name;
   Student1^.StudentInfo.Name := Student2^.StudentInfo.Name;
   Student2^.StudentInfo.Name := Temp;

   Temp := Student1.StudentInfo.Surname;
   Student1^.StudentInfo.Surname := Student2^.StudentInfo.Surname;
   Student2^.StudentInfo.Surname := Temp;

   Temp := Student1^.StudentInfo.MiddleName;
   Student1^.StudentInfo.MiddleName := Student2^.StudentInfo.MiddleName;
   Student2^.StudentInfo.MiddleName := Temp;

   TempLeader := Student1^.StudentInfo.Leader;
   Student1^.StudentInfo.Leader := Student2^.StudentInfo.Leader;
   Student2^.StudentInfo.Leader := TempLeader;

   TempMissingsList := Student1^.MissingList;
   Student1^.MissingList := Student2^.MissingList;
   Student2^.MissingList := TempMissingsList;

end;

procedure CGroup.SortStudents(Group: CGroup);
var
   I, J: Integer;
   Student1, Student2: TStudentLink;
begin
   for I := 0 to Group.GetNumbOfStudents - 2 do
   begin
      for J := 0 to Group.GetNumbOfStudents - 2 - I do
      begin
         Student1 := Group.GetStudent(J);
         Student2 := Group.GetStudent(J + 1);
         if (StudnetComparator(Student1, Student2)) then
         begin
            StudentSwap(Student1, Student2);
         end;
      end;
   end;
end;

destructor CGroup.Destroy();
var
   Iterator1, Iterator2: TStudentLink;
begin
   Iterator1 := FirstStudent;
   if (Iterator1 <> nil) then
   begin
      while (Iterator1^.NextStudent <> nil) do
      begin
         Iterator2 := Iterator1^.NextStudent;
         Dispose(Iterator1^.MissingList);
         Dispose(Iterator1);
         Iterator1 := Iterator2;
      end;
   end;
end;


end.


