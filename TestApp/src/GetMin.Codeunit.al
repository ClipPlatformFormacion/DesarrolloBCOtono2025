codeunit 50151 GetMin
{
    procedure GetMin(p1: Integer; p2: Integer): Integer
    begin
        if SeCumplenLasCondiciones(p1, p2) then
            exit(p2);
        exit(p1);
    end;

    local procedure SeCumplenLasCondiciones(var p1: Integer; var p2: Integer) returnValue: Boolean
    begin
        returnValue := p1 > p2;
    end;
}