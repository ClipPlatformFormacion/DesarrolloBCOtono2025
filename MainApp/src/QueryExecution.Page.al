page 50106 "Query Execution"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    actions
    {
        area(Promoted)
        {
            actionref(ExecutePromoted; Execute)
            {
            }
            actionref(CodeExecutePromoted; CodeExecute)
            {
            }
        }
        area(Processing)
        {
            action(Execute)
            {
                ApplicationArea = All;
                RunObject = query "Simple Item Query";
            }
            action(CodeExecute)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SimpleItemQuery: Query "Simple Item Query";
                    Count: Integer;
                begin
                    SimpleItemQuery.SetFilter(InventoryPostingGroup, '*');
                    if SimpleItemQuery.Open() then
                        while SimpleItemQuery.Read() do
                            Count += 1;   // Count := Count + 1;

                    Message('Total records: %1', Count);
                    Message(SimpleItemQuery.Name);
                    SimpleItemQuery.Close();
                end;
            }
        }
    }
}