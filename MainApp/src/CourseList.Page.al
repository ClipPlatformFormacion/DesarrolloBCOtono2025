page 50100 "Course List"
{
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;
    Editable = false;
    CardPageId = "Course Card";
    // PromotedActionCategories = 'New,Process,Report,MyCategory', Comment = 'ESP="Nuevo,Proceso,Informe,MiCategoria"';

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
                    Visible = true;
                }
                field("Language Name"; Rec."Language Name")
                { }
                field(LanguageNameProcedure; GetLanguageName(Rec."Language Code")) { }
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
            actionref(LedgerEntriesPromoted; "Ledger E&ntries") { }
        }
        area(Navigation)
        {
            action(CourseEditions)
            {
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                RunObject = page "Course Edition List";
                RunPageLink = "Course No." = field("No.");
                Image = ListPage;
                // Promoted = true;
                // PromotedCategory = category4;
                // PromotedOnly = true;
            }
            action("Ledger E&ntries")
            {
                ApplicationArea = All;
                Caption = 'Ledger E&ntries';
                Image = ResourceLedger;
                RunObject = Page "Course Ledger Entries";
                RunPageLink = "Course No." = field("No.");
                RunPageView = sorting("Course No.")
                                  order(descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
        }
    }

    procedure GetLanguageName(LanguageCode: Code[10]): Text[50]
    var
        Language: Record Language;
    begin
        Language.SetLoadFields("Name");
        if Language.Get(LanguageCode) then
            exit(Language.Name);

        // SELECT * FROM Language WHERE Code = LanguageCode;
        //  SELECT Name FROM Language WHERE Code = LanguageCode;
    end;
}