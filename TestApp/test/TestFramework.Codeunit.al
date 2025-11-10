codeunit 50150 "Test Framework"
{
    Subtype = Test;

    [Test]
    procedure Succesfull()
    begin
        // Cuando no se haya producido ningún error        
    end;

    [Test]
    procedure Fail()
    begin
        // cuando se produce un error
        Error('Un error en el test');
    end;

    [Test]
    procedure Test001()
    var
        GetMin: Codeunit GetMin;
        Valor1, Valor2 : Integer;
        Resultado: Integer;
    begin
        // [SCENARIO] Cuando se pasan dos valores numéricos a la función GetMin, siendo
        //              el primero el más pequeño, el resultado es correcto

        // [GIVEN] Dos valores numéricos
        Valor1 := 1;
        Valor2 := 2;
        // [WHEN] Se realiza una llamada a la función GetMin
        Resultado := GetMin.GetMin(Valor1, Valor2);
        // [THEN] El resultado es el valor del primer número
        if Resultado <> Valor1 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure Test002()
    var
        GetMin: Codeunit GetMin;
        Valor1, Valor2 : Integer;
        Resultado: Integer;
    begin
        // [SCENARIO] Cuando se pasan dos valores numéricos a la función GetMin, siendo
        //              el segundo el más pequeño, el resultado es correcto

        // [GIVEN] Dos valores numéricos
        Valor1 := 10;
        Valor2 := 2;
        // [WHEN] Se realiza una llamada a la función GetMin
        Resultado := GetMin.GetMin(Valor1, Valor2);
        // [THEN] El resultado es el valor del segundo número
        if Resultado <> Valor2 then
            Error('El resultado no es correcto');
    end;
}