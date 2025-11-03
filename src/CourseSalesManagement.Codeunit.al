codeunit 50100 "Course Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignFieldsForNo, '', false, false)]
    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record Course;
    begin
        Course.Get(SalesLine."No.");
        Course.TestField("Gen. Prod. Posting Group");
        SalesLine.Description := Course.Name;
        SalesLine."Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";
        SalesLine."VAT Prod. Posting Group" := Course."VAT Prod. Posting Group";
        SalesLine."Unit Price" := Course.Price;
        SalesLine."Allow Item Charge Assignment" := false;
        OnAfterAssignCourseValues(SalesLine, Course, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record Course; SalesHeader: Record "Sales Header")
    begin
    end;
}