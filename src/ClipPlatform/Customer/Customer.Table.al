namespace ClipPlatform.Customer;
using Microsoft.Inventory.Item;

table 50103 Customer
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; MyField; Integer)
        {
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }
        field(2; OtroCampo; Integer)
        {
            TableRelation = Item;
        }
    }

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }
}