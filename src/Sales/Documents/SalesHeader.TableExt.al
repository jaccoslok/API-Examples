tableextension 58702 "Sales Header PTE" extends "Sales Header"
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