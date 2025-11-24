reportextension 50100 "Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(Course_Edition; "Course Edition") { }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Layouts/StandardSalesInvoice.rdl';
        }
    }
}