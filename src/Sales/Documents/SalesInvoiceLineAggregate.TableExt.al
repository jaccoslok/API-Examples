namespace bcportal.api;

using Microsoft.Integration.Entity;

tableextension 58707 "Sales Inv. Line Agg. PTE" extends "Sales Invoice Line Aggregate"
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
