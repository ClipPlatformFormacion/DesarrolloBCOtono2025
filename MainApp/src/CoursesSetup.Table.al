table 50101 "Courses Setup"
{
    Caption = 'Courses Setup', Comment = 'ESP="Conf. cursos"';
    DataClassification = CustomerContent;
    DrillDownPageID = "Courses Setup";
    LookupPageID = "Courses Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(2; "Course Nos."; Code[20])
        {
            Caption = 'Course Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}