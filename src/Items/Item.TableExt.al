namespace bcportal.api;
using Microsoft.Inventory.Item;

tableextension 58703 "Item PTE" extends Item
{
    fields
    {
        field(58700; "Description 3 PTE"; Text[75])
        {
            Caption = 'Description 3';
            DataClassification = CustomerContent;
        }
        field(58701; "Description 4 PTE"; Text[100])
        {
            Caption = 'Description 4';
            DataClassification = CustomerContent;
        }
    }
}
