tableextension 50100 "Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const(Course)) Course;
        }
        field(50100; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "Course Edition".Edition where("Course No." = field("No."));
            //TODO: POner control para que no se seleccionen ediciones de cosas que no son cursos

            trigger OnValidate()
            begin
                Rec.CheckCourseEditionSales(Rec);
            end;
        }
    }

    procedure CheckCourseEditionSales(SalesLine: Record "Sales Line")
    var
        CourseEdition: Record "Course Edition";
    begin
        if salesLine.Type <> salesLine.Type::Course then
            exit;
        if salesLine.Quantity = 0 then
            exit;
        if salesLine."No." = '' then
            exit;
        if salesLine."Course Edition" = '' then
            exit;

        if CourseEdition.Get(salesLine."No.", salesLine."Course Edition") then;

        CourseEdition.CalcFields("Sales (Qty.)");
        if (CourseEdition."Sales (Qty.)" + salesLine.Quantity) > CourseEdition."Max. Students" then
            Message('Con esta venta se superá el número máximo de alumnos');
    end;
}