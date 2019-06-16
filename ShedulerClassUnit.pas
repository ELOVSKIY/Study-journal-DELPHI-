unit ShedulerClassUnit;

interface

type
   TMonthScheduler = array[0..3]of  array[0..5] of array[0..4] of String[15];
   CScheduler = class
   private
      MonthScheduler: TMonthScheduler;
   public
      procedure SetSheduler(Sheduler: TMonthScheduler);
      function GetScheduler(): TMonthScheduler;
      destructor Destroy();
   end;
implementation

destructor CScheduler.Destroy;
var
   I, J, K: Integer;
begin
   for I := 0 to 3 do
   begin
      for J := 0 to 5 do
      begin
         for K := 0 to 4 do
         begin
            MonthScheduler[I][J][K] := '';
         end;
      end;
   end;
end;

procedure CScheduler.SetSheduler(Sheduler: TMonthScheduler);
begin
   Self.MonthScheduler := Sheduler;
end;

function CScheduler.GetScheduler(): TMonthScheduler;
begin
   Result := Self.MonthScheduler;
end;

end.
