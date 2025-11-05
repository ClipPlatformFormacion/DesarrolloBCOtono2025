pageextension 50100 "Sales Order Subform" extends "Sales Order Subform"
{
    //TODO: hacer la misma pageextension para todas las subpáginas de documentos vivos y todas las subpáginas de documentos registrados o archivados
    layout
    {
        addafter("No.")
        {
            field("Course Edition"; Rec."Course Edition")
            {
                ApplicationArea = All;
            }
        }
        movelast(Control1; "Item Reference No.")
    }
}