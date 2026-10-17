namespace bcportal.api;
using Microsoft.Integration.Entity;

tableextension 58701 "Sales Order Entity Buffer PTE" extends "Sales Order Entity Buffer"
{
    fields
    {
        field(58750; "My Custom Field PTE"; Text[50])
        {
            Caption = 'My Custom Field';
            DataClassification = CustomerContent;
        }
        field(58751; "Blanket Order No. PTE"; Code[20])
        {
            Caption = 'Blanket Order No.';
            DataClassification = CustomerContent;
        }
    }
}