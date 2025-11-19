report 50100 "Update Course Price"
{
    Caption = 'Update Course Prices', comment = 'ESP="Actualizar precio cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Course; Course)
        {
            trigger OnPreDataItem()
            begin
                Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            begin
                Message('OnAfterGetRecord: %1', Course."No.");
            end;

            trigger OnPostDataItem()
            begin
                Message('OnPostDataItem');
            end;
        }
    }
}