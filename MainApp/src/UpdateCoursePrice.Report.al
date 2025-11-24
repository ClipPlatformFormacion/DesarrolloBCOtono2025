report 50100 "Update Course Price"
{
    Caption = 'Update Course Prices', comment = 'ESP="Actualizar precio cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultRenderingLayout = RDLCLayout;

    dataset
    {
        dataitem(Course; Course)
        {
            RequestFilterFields = "No.", Price, "Gen. Prod. Posting Group";

            column(No; "No.") { }
            column(Name; Name) { }
            column(OldPrice; OldPrice) { }
            column(Price; Price) { }

            trigger OnPreDataItem()
            begin
                // Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            begin
                // Message('OnAfterGetRecord: %1', Course."No.");
                OldPrice := Course.Price;
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

    rendering
    {
        layout(RDLCLayout)
        {
            Type = RDLC;
            LayoutFile = './src/Layouts/UpdateCoursePrice.rdl';
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
        OldPrice: Decimal;
}