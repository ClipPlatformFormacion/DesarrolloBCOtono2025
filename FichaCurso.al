page 50101 "Course Card"
{
    CaptionML = ENU = 'Course', ESP = 'Curso';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Course;

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ESP = 'General';
                field("No."; Rec."No.") { }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
            }
            group(Training)
            {
                CaptionML = ENU = 'Training', ESP = 'Detalles formativos';
                field("Type (Enum)"; Rec."Type (Enum)")
                {
                    Importance = Additional;
                }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field("Language Code"; Rec."Language Code") { }
                field("Content Description"; Rec."Content Description") { }
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
                field(Price; Rec.Price) { }
            }
        }
    }
}