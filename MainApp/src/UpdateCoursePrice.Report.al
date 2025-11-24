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

            column(ReportCaption; ReportCaption) { }
            column(OldPriceCaption; OldPriceCaption) { }
            column(No; "No.") { IncludeCaption = true; }
            column(Name; Name) { IncludeCaption = true; }
            column(OldPrice; OldPrice) { }
            column(Price; Price) { IncludeCaption = true; }

            trigger OnPreDataItem()
            begin
                // Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            var
                NewPrice: Decimal;
            begin
                // Message('OnAfterGetRecord: %1', Course."No.");
                OldPrice := Course.Price;
                NewPrice := Course.Price + (Course.Price * Percentaje / 100);
                NewPrice := Round(NewPrice, 0.01);
                Course.Validate(Price, NewPrice);
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
        // OldPriceCaption: TextConst ENU = 'Old Price', ESP = 'Precio Anterior';
        OldPriceCaption: Label 'Old Price', comment = 'ESP="Precio Anterior"';
        ReportCaption: Label 'Update Course Prices', comment = 'ESP="Actualizar precio cursos"';
}