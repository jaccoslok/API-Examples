namespace bcportal.api;
using Microsoft.Inventory.Item;

pageextension 58701 "Item Card PTE" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("Description 3 PTE"; Rec."Description 3 PTE")
            {
                ApplicationArea = All;
            }
            field("Description 4 PTE"; Rec."Description 4 PTE")
            {
                ApplicationArea = All;
            }
        }
    }
}
