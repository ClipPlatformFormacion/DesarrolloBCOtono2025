page 50100 "Course List"
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
    Editable = false;
    CardPageId = "Course Card";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field("Content Description"; Rec."Content Description") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Price; Rec.Price) { }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                }
                field("Type (Enum)"; Rec."Type (Enum)")
                {
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(CourseEditionPart; "Course Edition List")
            {
                SubPageLink = "Course No." = field("No.");
            }
        }
    }
}