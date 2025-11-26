codeunit 50104 "Silver Customer Level" implements "ICustomer Level"
{
    procedure GetDiscount(): Decimal
    begin
        exit(10);
    end;
}