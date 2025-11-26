query 50100 "Simple Item Query"
{
    QueryType = Normal;

    elements
    {
        dataitem(Item; Item)   // SELECT [No_], [Description], [Base Unit of Measure], [Unit Cost] FROM [dbo].[Item]
        {
            DataItemTableFilter = "Vendor No." = filter(<> ''); // WHERE [Vendor No.] != ''
            column(No; "No.") { }
            column(Description; Description) { }
            column(BaseUnitOfMeasure; "Base Unit of Measure") { }
            column(Unit_Cost; "Unit Cost") { }
            column(Vendor_No_; "Vendor No.") { }
            column(Replenishment_System; "Replenishment System")
            {
                ColumnFilter = Replenishment_System = const(Purchase);  // WHERE [Replenishment System] = 'Purchase'
            }
            filter(InventoryPostingGroup; "Inventory Posting Group")
            {

            }

            dataitem(Vendor; Vendor)
            {
                SqlJoinType = LeftOuterJoin;
                // SELECT [columna1],[columna2],etc. FROM Tabla1 JOIN Tabla2 ON Tabla2.Campo = Tabla1.Campo 
                DataItemLink = "No." = Item."Vendor No.";
                column(Name; Name) { }
                column(City; City) { }
            }
        }
    }
}