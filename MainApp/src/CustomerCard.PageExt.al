pageextension 50101 "Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(Level; Rec.Level)
            {
                ApplicationArea = All;
            }
            field(Discount; Rec.Discount)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}