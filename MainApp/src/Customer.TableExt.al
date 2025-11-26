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
                Handled: Boolean;
            begin
                case Level of
                    Level::" ":
                        Rec.Validate(Discount, 0);
                    Level::Bronze:
                        Rec.Validate(Discount, 5);
                    Level::Silver:
                        Rec.Validate(Discount, 10);
                    else begin
                        OnValidateCustomerLevelOnBeforeUnknownLevel(Rec, Handled);
                        if not Handled then
                            Error('Nivel %1 desconocido', Level);
                    end;
                end;
            end;
        }
    }

    [IntegrationEvent(false, false)]
    procedure OnValidateCustomerLevelOnBeforeUnknownLevel(var Customer: Record Customer; var Handled: Boolean)
    begin

    end;
}