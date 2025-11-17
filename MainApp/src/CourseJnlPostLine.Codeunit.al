codeunit 50101 "Course Jnl.-Post Line"
{
    Permissions = TableData "Course Ledger Entry" = rimd;
    TableNo = "Course Journal Line";

    trigger OnRun()
    begin
        GetGLSetup();
        RunWithCheck(Rec);
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ResJournalLineGlobal: Record "Course Journal Line";
        ResLedgerEntry: Record "Course Ledger Entry";
        Course: Record Course;
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    procedure RunWithCheck(var CourseJournalLine: Record "Course Journal Line")
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        ResJournalLineGlobal.Copy(CourseJournalLine);
        SequenceNoMgt.ClearSequenceNoCheck();
        Code();
        CourseJournalLine := ResJournalLineGlobal;
    end;

    local procedure "Code"()
    var
        xNextEntryNo: Integer;
        IsHandled: Boolean;
    begin
        xNextEntryNo := NextEntryNo;
        IsHandled := false;
        OnBeforePostResJnlLine(ResJournalLineGlobal, IsHandled, NextEntryNo);
        if not IsHandled then begin
            ValidateSequenceNo(NextEntryNo, xNextEntryNo, Database::"Course Ledger Entry");
            if ResJournalLineGlobal.EmptyLine() then
                exit;


            if ResJournalLineGlobal."Document Date" = 0D then
                ResJournalLineGlobal."Document Date" := ResJournalLineGlobal."Posting Date";

            Course.Get(ResJournalLineGlobal."Course No.");

            NextEntryNo := ResLedgerEntry.GetNextEntryNo();

            ResLedgerEntry.Init();
            ResLedgerEntry.CopyFromResJnlLine(ResJournalLineGlobal);

            GetGLSetup();
            ResLedgerEntry."Total Price" := Round(ResLedgerEntry."Total Price");
            ResLedgerEntry.Quantity := -ResLedgerEntry.Quantity;
            ResLedgerEntry."Total Price" := -ResLedgerEntry."Total Price";
            ResLedgerEntry."Entry No." := NextEntryNo;

            OnBeforeResLedgEntryInsert(ResLedgerEntry, ResJournalLineGlobal);

            ResLedgerEntry.Insert(true);
            OnAfterResLedgEntryInsert(ResLedgerEntry, ResJournalLineGlobal);
        end;

        xNextEntryNo := NextEntryNo;
        OnAfterPostResJnlLine(ResJournalLineGlobal, ResLedgerEntry, NextEntryNo);
        ValidateSequenceNo(NextEntryNo, xNextEntryNo, Database::"Course Ledger Entry");
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Course Ledger Entry", 'r')]
    local procedure ValidateSequenceNo(LedgEntryNo: Integer; xLedgEntryNo: Integer; TableNo: Integer)
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        if LedgEntryNo = xLedgEntryNo then
            exit;
        SequenceNoMgt.ValidateSeqNo(TableNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostResJnlLine(var ResJournalLine: Record "Course Journal Line"; var ResLedgEntry: Record "Course Ledger Entry"; var NextEntryNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostResJnlLine(var ResJournalLine: Record "Course Journal Line"; var IsHandled: Boolean; var NextEntryNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Course Ledger Entry"; ResJournalLine: Record "Course Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterResLedgEntryInsert(var ResLedgerEntry: Record "Course Ledger Entry"; ResJournalLine: Record "Course Journal Line")
    begin
    end;
}

