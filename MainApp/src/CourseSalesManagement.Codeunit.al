codeunit 50100 "Course Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", OnBeforeIncludeOption, '', false, false)]
    local procedure "Option Lookup Buffer_OnBeforeIncludeOption"(OptionLookupBuffer: Record "Option Lookup Buffer" temporary; LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean; RecRef: RecordRef)
    begin
        if LookupType <> Enum::"Option Lookup Type"::Sales.AsInteger() then
            exit;

        if Option <> Enum::"Sales Line Type"::Course.AsInteger() then
            exit;

        Result := true;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignFieldsForNo, '', false, false)]
    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record Course;
    begin
        if SalesLine.Type <> SalesLine.Type::Course then
            exit;

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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostSalesLineOnBeforePostSalesLine, '', false, false)]
    local procedure "Sales-Post_OnPostSalesLineOnBeforePostSalesLine"(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line")
    begin
        if SalesLine.Type <> SalesLine.Type::Course then
            exit;

        PostCourseJnlLine(SalesHeader, SalesLine, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
    end;

    local procedure PostCourseJnlLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10])
    var
        CourseJnlLine: Record "Course Journal Line";
        CourseJnlPostLine: Codeunit "Course Jnl.-Post Line";
        // IsHandled: Boolean;
        ShouldExit: Boolean;
    begin
        // IsHandled := false;
        // OnBeforePostResJnlLine(SalesHeader, SalesLine, JobTaskSalesLine, IsHandled, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, SalesShptHeader, ReturnRcptHeader, ResJnlPostLine);
        // if IsHandled then
        //     exit;

        ShouldExit := SalesLine."Qty. to Invoice" = 0;
        // OnPostResJnlLineOnShouldExit(SalesLine, ShouldExit);
        if ShouldExit then
            exit;

        CourseJnlLine.Init();
        CourseJnlLine.CopyFromSalesHeader(SalesHeader);
        CourseJnlLine.CopyDocumentFields(GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, SalesHeader."Posting No. Series");
        CourseJnlLine.CopyFromSalesLine(SalesLine);
        // OnPostResJnlLineOnAfterInit(ResJnlLine, SalesLine);

        CourseJnlPostLine.RunWithCheck(CourseJnlLine);

        // OnAfterPostResJnlLine(SalesHeader, SalesLine, JobTaskSalesLine, ResJnlLine);
    end;
}