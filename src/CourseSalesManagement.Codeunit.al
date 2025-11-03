codeunit 50100 "Course Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignFieldsForNo, '', false, false)]
    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Res: Record Course;
    begin
        Res.Get(SalesLine."No.");
        // Res.TestField("Gen. Prod. Posting Group");
        SalesLine.Description := Res.Name;
        // SalesLine."Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
        // SalesLine."VAT Prod. Posting Group" := Res."VAT Prod. Posting Group";        
        SalesLine."Unit Price" := Res.Price;
        SalesLine."Allow Item Charge Assignment" := false;
        OnAfterAssignCourseValues(SalesLine, Res, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record Course; SalesHeader: Record "Sales Header")
    begin
    end;
}