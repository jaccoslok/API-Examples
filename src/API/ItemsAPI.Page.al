namespace bcportal.api;
using Microsoft.Inventory.Item;

page 58700 "Items API PTE"
{
    PageType = API;
    APIPublisher = 'slokSoftware';
    APIGroup = 'bcPortal';
    APIVersion = 'v2.0';
    EntityName = 'item';
    EntitySetName = 'items';
    SourceTable = Item;
    ODataKeyFields = SystemId; // Mandatory!
    DelayedInsert = true;
    Editable = false;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { } // Mandatory! This must be the System ID of an order-able item.
                field(number; Rec."No.") { }
                field(description; Rec.Description) { } // The ordering screen expects description, displayName or itemDescription
                field(countryRegionOfOriginCode; Rec."Country/Region of Origin Code") { }
                field(unitPrice; Rec."Unit Price") { }
                field(inventory; Rec.Inventory) { }
                field(salesUnitOfMeasure; Rec."Sales Unit of Measure") { }
                field(description3; Rec."Description 3 PTE") { }
                field(description4; Rec."Description 4 PTE") { }
            }
        }
    }
}