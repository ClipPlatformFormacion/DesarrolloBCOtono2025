page 50100 "Course List"
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
    Editable = false;
    CardPageId = "Course Card";
    // PromotedActionCategoriesML = ENU = 'New,Process,Report,MyCategory', ESP = 'Nuevo,Proceso,Informe,MiCategoria';

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
            part(CourseEditionPart; "Course Edition Factbox")
            {
                SubPageLink = "Course No." = field("No.");
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(CourseEditionsPromoted; CourseEditions) { }
        }
        area(Navigation)
        {
            action(CourseEditions)
            {
                CaptionML = ENU = 'Editions', ESP = 'Ediciones';
                RunObject = page "Course Edition List";
                RunPageLink = "Course No." = field("No.");
                // Promoted = true;
                // PromotedCategory = category4;
                // PromotedOnly = true;
            }
        }
    }
}