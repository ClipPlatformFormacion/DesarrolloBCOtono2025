table 50104 "Course Ledger Entry"
{
    Caption = 'Course Ledger Entry';
    // DrillDownPageID = "Course Ledger Entries";
    // LookupPageID = "Course Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        // field(2; "Entry Type"; Enum "Res. Journal Line Entry Type")
        // {
        //     Caption = 'Entry Type';
        // }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Course No."; Code[20])
        {
            Caption = 'Course No.';
            TableRelation = Course;
        }
        field(6; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition';
            TableRelation = "Course Edition".Edition where("Course No." = field("Course No."));
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(16; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        // field(17; "Global Dimension 1 Code"; Code[20])
        // {
        //     CaptionClass = '1,1,1';
        //     Caption = 'Global Dimension 1 Code';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        // }
        // field(18; "Global Dimension 2 Code"; Code[20])
        // {
        //     CaptionClass = '1,1,2';
        //     Caption = 'Global Dimension 2 Code';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        // }
        field(21; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(27; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(28; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(29; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        // field(34; "Course Register No."; Integer)
        // {
        //     Caption = 'Course Register No.';
        //     Editable = false;
        //     TableRelation = "Course Register";
        // }
        // field(480; "Dimension Set ID"; Integer)
        // {
        //     Caption = 'Dimension Set ID';
        //     Editable = false;
        //     TableRelation = "Dimension Set Entry";

        //     trigger OnLookup()
        //     begin
        //         Rec.ShowDimensions();
        //     end;
        // }
        // field(481; "Shortcut Dimension 3 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,3';
        //     Caption = 'Shortcut Dimension 3 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(3)));
        // }
        // field(482; "Shortcut Dimension 4 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,4';
        //     Caption = 'Shortcut Dimension 4 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(4)));
        // }
        // field(483; "Shortcut Dimension 5 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,5';
        //     Caption = 'Shortcut Dimension 5 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(5)));
        // }
        // field(484; "Shortcut Dimension 6 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,6';
        //     Caption = 'Shortcut Dimension 6 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(6)));
        // }
        // field(485; "Shortcut Dimension 7 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,7';
        //     Caption = 'Shortcut Dimension 7 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(7)));
        // }
        // field(486; "Shortcut Dimension 8 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,8';
        //     Caption = 'Shortcut Dimension 8 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(8)));
        // }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Document No.", "Posting Date")
        {
        }
    }

    // var
    //     DimMgt: Codeunit DimensionManagement;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Course Ledger Entry", 'r')]
    procedure GetNextEntryNo(): Integer
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        exit(SequenceNoMgt.GetNextSeqNo(DATABASE::"Course Ledger Entry"));
    end;

    [InherentPermissions(PermissionObjectType::TableData, Database::"Course Ledger Entry", 'r')]
    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

    procedure CopyFromResJnlLine(CourseJnlLine: Record "Course Journal Line")
    begin
        "Document No." := CourseJnlLine."Document No.";
        "External Document No." := CourseJnlLine."External Document No.";
        "Posting Date" := CourseJnlLine."Posting Date";
        "Document Date" := CourseJnlLine."Document Date";
        "Course No." := CourseJnlLine."Course No.";
        "Course Edition" := CourseJnlLine."Course Edition";
        Description := CourseJnlLine.Description;
        Quantity := CourseJnlLine.Quantity;
        "Unit Price" := CourseJnlLine."Unit Price";
        "Total Price" := CourseJnlLine."Total Price";
        // "Global Dimension 1 Code" := ResJnlLine."Shortcut Dimension 1 Code";
        // "Global Dimension 2 Code" := ResJnlLine."Shortcut Dimension 2 Code";
        // "Dimension Set ID" := ResJnlLine."Dimension Set ID";
        "Source Code" := CourseJnlLine."Source Code";
        "Journal Batch Name" := CourseJnlLine."Journal Batch Name";
        "Reason Code" := CourseJnlLine."Reason Code";
        "No. Series" := CourseJnlLine."Posting No. Series";

        OnAfterCopyFromResJnlLine(Rec, CourseJnlLine);
    end;

    // procedure ShowDimensions()
    // begin
    //     DimMgt.ShowDimensionSet("Dimension Set ID", CopyStr(StrSubstNo('%1 %2', TableCaption(), "Entry No."), 1, 250));
    // end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCopyFromResJnlLine(var ResLedgerEntry: Record "Course Ledger Entry"; ResJournalLine: Record "Course Journal Line")
    begin
    end;
}