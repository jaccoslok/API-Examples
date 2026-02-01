tableextension 58701 "Sales Order Entity Buffer PTE" extends "Sales Order Entity Buffer"
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