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
            begin
                case Level of
                    Level::" ":
                        Rec.Validate(Discount, 0);
                    Level::Bronze:
                        Rec.Validate(Discount, 5);
                    Level::Silver:
                        Rec.Validate(Discount, 10);
                    else
                        Error('Nivel %1 desconocido', Level);
                end;
            end;
        }
    }
}