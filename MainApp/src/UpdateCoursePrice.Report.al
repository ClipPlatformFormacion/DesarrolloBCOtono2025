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
            RequestFilterFields = "No.", Price, "Gen. Prod. Posting Group";
            trigger OnPreDataItem()
            begin
                // Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            begin
                // Message('OnAfterGetRecord: %1', Course."No.");
                Course.Validate(Price, Course.Price + (Course.Price * Percentaje / 100));
                Course.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                // Message('OnPostDataItem');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(PercentajeControl; Percentaje)
                    {
                        Caption = 'Percentaje', comment = 'ESP="Porcentaje"';
                        ToolTip = 'Establish the percentage you want to use to update the course prices', comment = 'ESP="Establece el porcentaje que quieres utilizar para actualizar el precio de los cursos"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if Percentaje = 0 then
            Error('Se debe introducir un porcentaje');
    end;

    trigger OnPostReport()
    begin
        Message('Proceso finalizado');
    end;

    var
        Percentaje: Decimal;
}