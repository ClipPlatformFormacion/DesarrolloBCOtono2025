codeunit 50152 "Test Cursos"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record Course;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
    begin
        // [SCENARIO] Al seleccionar un curso en un documento de venta,
        //      la línea de venta tiene la información del curso (nombre, precio y grupos contables)

        // [GIVEN] Un curso
        //         Un documento de venta (cliente)
        CreateCourse(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [WHEN] Seleccionamos el curso en el documento de venta
        SalesLine.Validate(Type, Enum::"Sales Line Type"::Course);
        SalesLine.Validate("No.", Course."No.");

        // [THEN] La descripción de la línea de venta es el nombre del curso
        //          El precio de la venta es el precio del curso
        //          Los grupos contables en la línea de venta son los del curso     
        LibraryAssert.AreEqual(Enum::"Sales Line Type"::Course, SalesLine.Type, 'El tipo de venta no es correcto');
        LibraryAssert.AreEqual(Course."No.", SalesLine."No.", 'El curso no es correcto');
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'Grupo contable incorrecto');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'Grupo contable incorrecto');
    end;

    local procedure CreateCourse(var Course: Record Course)
    var
        GeneralPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        LibraryERM: Codeunit "Library - ERM";
        LibraryRandom: Codeunit "Library - Random";
    begin
        CourseNoSeriesSetup();
        LibraryERM.FindGeneralPostingSetupInvtFull(GeneralPostingSetup);
        LibraryERM.FindVATPostingSetupInvt(VATPostingSetup);

        Clear(Course);
        Course.Insert(true);
        Course.Validate(Name, Course."No.");  // Validate Name as No. because value is not important.                
        Course.Validate(Price, LibraryRandom.RandInt(100));  // Required field - value is not important.
        Course.Validate("Gen. Prod. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");
        Course.Validate("VAT Prod. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
        Course.Modify(true);
    end;

    local procedure CourseNoSeriesSetup()
    var
        CoursesSetup: Record "Courses Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        CoursesSetup.Get();
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> CoursesSetup."Course Nos." then begin
            CoursesSetup.Validate("Course Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            CoursesSetup.Modify(true);
        end;
    end;
}