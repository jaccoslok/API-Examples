namespace bcportal.api;
using Microsoft.Sales.Document;

pageextension 58700 "Sales Order PTE" extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("My Custom Field PTE";Rec."My Custom Field PTE")
            {
                ApplicationArea = All;
            }
        }
    }
}