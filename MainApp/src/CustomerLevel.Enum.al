enum 50101 "Customer Level" implements "ICustomer Level"
{
    Extensible = true;

    value(0; " ")
    {
        Implementation = "ICustomer Level" = "Blank Customer Level";
    }
    value(1; "Bronze")
    {
        Implementation = "ICustomer Level" = "Bronze Customer Level";
    }
    value(2; "Silver")
    {
        Implementation = "ICustomer Level" = "Silver Customer Level";
    }
}