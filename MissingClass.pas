unit MissingClass;

interface

type
   TWeekMissing = array[0..5] of array[0..4] of Byte;
   TMissingLink = ^TMissingList;

   TMissingList = record
      NextWeek: TMissingLink;
      Missings: TWeekMissing;
   end;

   CListControler = class
      private
         MissingList: TMissingLink;
         CurrentWeek: Integer;
         procedure AddWeek();
      public
         constructor Create();
         function GetWeek(Position: Integer): TMissingLink;
         procedure SetWeek(Position: Integer; Week: TWeekMissing);
         destructor Destroy();
   end;

implementation

constructor CListControler.Create();
const
   CountOfWeek = 16;
var
   I: Integer;
begin
   CurrentWeek := 0;
   MissingList := nil;
   for I := 0 to CountOfWeek - 1 do
   begin
      Self.AddWeek();
   end;
end;

procedure CListControler.AddWeek();
var
   PlaceForWeek: TMissingLink;
   I, J: Integer;
begin
   New(PlaceForWeek);
   PlaceForWeek^.NextWeek := MissingList;
   MissingList := PlaceForWeek;
   for I := 0 to 5 do
   begin
      for J := 0 to 4 do
      begin
         MissingList^.Missings[I][J] := 0;
      end;
   end;
end;

function CListControler.GetWeek(Position: Integer): TMissingLink;
var
   Iterator: TMissingLink;
   I: Integer;
begin
   Iterator := MissingList;
   for I := 0 to Position - 1 do
   begin
      Iterator := Iterator^.NextWeek;
   end;
   Result := Iterator;
end;

procedure CliStControler.SetWeek(Position: Integer; Week: TWeekMissing);
var
   TempWeekLink: TMissingLink;
begin
   TempWeekLink := GetWeek(Position);
   TempWeekLink^.Missings := Week;
end;

destructor CListControler.Destroy;
var
   Iterator1, Iterator2: TMissingLink;
begin
   Iterator1 := MissingList;
   while (Iterator1^.NextWeek <> nil) do
   begin
      Iterator2 := Iterator1^.NextWeek;
      Dispose(Iterator1);
      Iterator1 := Iterator2
   end;
end;
end.
