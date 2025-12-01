xmlport 50100 "Sales Order Export"
{
    Direction = Export;
    Format = VariableText;
    RecordSeparator = '<NewLine>';
    FieldSeparator = ';';
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                SourceTableView = where("Document Type" = const(Order));
                // fieldattribute(NodeName3; NodeName2.SourceFieldName)
                // {
                // }
                fieldelement(No; SalesHeader."No.") { }
                fieldelement(Customer; SalesHeader."Sell-to Customer No.") { }
                fieldelement(Date; SalesHeader."Document Date") { }

                tableelement(SalesLine; "Sales Line")
                {
                    LinkTable = SalesHeader;
                    LinkFields = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    fieldelement(Type; SalesLine.type)
                    {

                    }
                    fieldelement(No; SalesLine."No.") { }
                    fieldelement(Quantity; SalesLine.Quantity) { }
                    textelement(Quantity2)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            Quantity2 := (SalesLine.Quantity * 2).ToText();
                        end;

                        trigger OnAfterAssignVariable()
                        var
                            myInt: Integer;
                        begin

                        end;
                    }
                    fieldelement(edition; SalesLine."Course Edition") { }

                    trigger OnBeforeInsertRecord()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
            }
        }
    }
}