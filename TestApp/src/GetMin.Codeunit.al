codeunit 50151 GetMin
{
    procedure GetMin(p1: Integer; p2: Integer): Integer
    begin
        if p1 <= p2 then
            exit(p1)
        else
            exit(p2);
    end;
}