codeunit 50152 "Test Cursos"
{
    Subtype = Test;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record Course;
    begin
        // [SCENARIO] Al seleccionar un curso en un documento de venta,
        //      la línea de venta tiene la información del producto (nombre, precio y grupos contables)

        // [GIVEN] Un curso
        //         Un documento de venta (cliente)

        // [WHEN] Seleccionamos el curso en el documento de venta

        // [THEN] La descripción de la línea de venta es el nombre del curso
        //          El precio de la venta es el precio del curso
        //          Los grupos contables en la línea de venta son los del curso
    end;
}