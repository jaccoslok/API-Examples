namespace bcportal.api;

using Microsoft.Sales.Document;

tableextension 58706 "Sales Line API PTE" extends "Sales Line"
{
    fields
    {
        field(58750; "My Custom Field PTE"; Text[50])
        {
            Caption = 'My Custom Field';
            DataClassification = CustomerContent;
        }
    }
}
