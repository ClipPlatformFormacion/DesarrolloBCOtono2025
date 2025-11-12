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

    [Test]
    procedure CourseSalesPosting()
    var
        Course: Record Course;
        CourseEdition: Record "Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        DocumentNo: Code[20];
    begin
        // [SCENARIO] Al generar un documento registrado de venta con un curso,
        //   la información de la edición se traslada a los documentos registrados

        // [GIVEN] Un curso
        //         Una edición del curso
        //         Un documento de venta (cliente) para el curso y edición
        CreateCourse(Course);
        CourseEdition := CreateCourseEdition(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, Enum::"Sales Line Type"::Course);
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        // [WHEN] Registramos el documento de venta
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, false);

        // [THEN] La edición del curso se traslada al documento registrado
        SalesShipmentLine.SetRange("Document No.", DocumentNo);
        LibraryAssert.AreEqual(1, SalesShipmentLine.Count(), 'Número de líneas de albarán incorrecto');
        SalesShipmentLine.FindFirst();
        LibraryAssert.AreEqual(SalesLine.Type, SalesShipmentLine.Type, 'El tipo de línea en el albarán no es correcto');
        LibraryAssert.AreEqual(SalesLine."No.", SalesShipmentLine."No.", 'El curso en el albarán no es correcto');
        LibraryAssert.AreEqual(SalesLine."Course Edition", SalesShipmentLine."Course Edition", 'La edición del curso en el albarán no es correcta');
    end;

    [Test]
    procedure CourseLedgerEntries()
    var
        Course: Record Course;
        CourseEdition: Record "Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CourseLedgerEntry: Record "Course Ledger Entry";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        DocumentNo: Code[20];
    begin
        // [SCENARIO] Al generar un documento registrado de venta con un curso,
        //   se genera un movimiento de curso

        // [GIVEN] Un curso
        //         Una edición del curso
        //         Un documento de venta (cliente) para el curso y edición
        CreateCourse(Course);
        CourseEdition := CreateCourseEdition(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        SalesHeader.Validate("Posting Date", Today() + 1);
        SalesHeader.Modify(true);
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, Enum::"Sales Line Type"::Course);
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate(Description, 'Venta de curso de prueba');
        SalesLine.Validate("Unit Price", 500);
        SalesLine.Modify(true);

        // [WHEN] Registramos el albarán
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, false);

        // [THEN] No se ha generado movimiento de curso
        CourseLedgerEntry.SetRange("Document No.", DocumentNo);
        LibraryAssert.AreEqual(0, CourseLedgerEntry.Count(), 'Se ha generado movimiento de curso');

        // [WHEN] Registramos la factura
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, false, true);

        // [THEN] Se ha generado movimiento de curso
        CourseLedgerEntry.SetRange("Document No.", DocumentNo);
        LibraryAssert.AreEqual(1, CourseLedgerEntry.Count(), 'Número de movimientos incorrecto');
        CourseLedgerEntry.FindFirst();
        LibraryAssert.AreEqual(Today() + 1, CourseLedgerEntry."Posting Date", 'La fecha del movimiento no es correcta');
        LibraryAssert.AreEqual(Course."No.", CourseLedgerEntry."Course No.", 'El curso en el movimiento no es correcto');
        LibraryAssert.AreEqual(CourseEdition.Edition, CourseLedgerEntry."Course Edition", 'La edición del curso en el movimiento no es correcta');
        LibraryAssert.AreEqual(SalesLine.Description, CourseLedgerEntry.Description, 'La descripción del movimiento no es correcta');
        LibraryAssert.AreEqual(SalesLine.Quantity, CourseLedgerEntry.Quantity, 'La cantidad del movimiento no es correcta');
        LibraryAssert.AreEqual(SalesLine."Unit Price", CourseLedgerEntry."Unit Price", 'El precio unitario del movimiento no es correcto');
        LibraryAssert.AreEqual(SalesLine."Line Amount", CourseLedgerEntry."Total Price", 'El precio total del movimiento no es correcto');
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

    local procedure CreateCourseEdition(Course: Record Course) CourseEdition: Record "Course Edition"
    begin
        CourseEdition.Init();
        CourseEdition.Validate("Course No.", Course."No.");
        CourseEdition.Validate(Edition, 'Edición 1');
        CourseEdition.Validate("Start Date", Today() + 10);
        CourseEdition.Validate("Max. Students", 20);
        CourseEdition.Insert(true);
    end;
}