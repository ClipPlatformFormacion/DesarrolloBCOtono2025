tableextension 50107 Customer extends Customer
{
    fields
    {
        field(50100; Discount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50101; Level; Enum "Customer Level")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ICustomerLevel: Interface "ICustomer Level";
            begin
                ICustomerLevel := Rec.Level;
                Rec.Validate(Discount, ICustomerLevel.GetDiscount());
            end;
        }
    }

    [IntegrationEvent(false, false)]
    procedure OnValidateCustomerLevelOnBeforeUnknownLevel(var Customer: Record Customer; var Handled: Boolean)
    begin

    end;
}