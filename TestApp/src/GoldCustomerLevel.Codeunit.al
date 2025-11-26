codeunit 50153 "Gold Customer Level" implements "ICustomer Level"
{
    procedure GetDiscount(): Decimal
    begin
        exit(15);
    end;

    procedure SetDiscount(NewDiscount: Decimal)
    begin

    end;
}