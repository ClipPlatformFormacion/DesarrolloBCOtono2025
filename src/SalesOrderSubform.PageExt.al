pageextension 50100 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        modify(Type)
        {
            Visible = true;
        }
        modify(FilteredTypeField)
        {
            Visible = true;
        }
    }
}