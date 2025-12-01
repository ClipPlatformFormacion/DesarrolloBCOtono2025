codeunit 50105 "Mi WebService"
{
    procedure UnMetodoSinParametrosNiValorDeRetorno()
    begin

    end;

    procedure UnMetodoConParametroDeTexto(textoRecibido: Text): Text
    begin
        if GuiAllowed() then
            if not Confirm('¿Desea continuar con el texto recibido: %1?', false, textoRecibido) then
                error('Operación cancelada por el usuario.');

        exit(textoRecibido + ' desde Business Central');
    end;

    procedure CrearCliente(name: Text[100]; address: Text[100]; phoneNo: Text[30]): Code[20]
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        Customer.Validate(Name, name);
        Customer.Validate("Address", address);
        Customer.Validate("Phone No.", phoneNo);
        Customer.Insert(true);
        exit(Customer."No.");
    end;

    procedure CrearClienteComplejo(parametro: XmlPort "Sales Order Export")
    begin
        parametro.Import();
    end;
}