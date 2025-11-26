codeunit 50103 "Bronze Customer Level" implements "ICustomer Level"
{
    procedure GetDiscount(): Decimal
    begin
        exit(5);
    end;
}