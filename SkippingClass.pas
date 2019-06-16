unit SkippingClass;

interface

type
   TWeekClasses = array[0..5] of array [0..4] of Byte;

   SkippingLink = ^TSkippingList;
   TSkippingList = record
      NextWeek: SkippingLink;
      MissedClasses: TWeekClasses;
   end;

   ÑListControler = class
      private
         SkippingList: SkippingLink;
         procedure AddWeek();
      public
         constructor Create();
         procedure SetWeek(Position: Integer; Week: TWeekClasses);
         function GetWeek(Position: Integer): TWeekClasses;
   end;

implementation

constructor ÑListControler.Create();
var
   I: Integer;
begin
   for I := 0 to 15 do
   begin
      AddWeek();
   end;
end;

procedure ÑListControler.AddWeek();
var
   PlaceForWeek: SkippingLink;
begin
   New(PlaceForWeek);
   if (SkippingList <> nil) then
   begin
      PlaceForWeek^.NextWeek := SkippingList;
   end;
   SkippingList := PlaceForWeek;
end;

function ÑListControler.GetWeek(Position: Integer): TWeekClasses;
var
   I: Integer;
   Iterator: SkippingLink;
begin
   Iterator := SkippingList;
   for I := 0 to Position - 1 do
   begin
      Iterator := Iterator^.NextWeek;
   end;
   Result := Iterator^.MissedClasses;
end;

procedure CListControler.SetWeek(Position: Integer; Week: TWeekClasses);
begin

end;
end.
