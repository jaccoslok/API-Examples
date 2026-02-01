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
                field(id; Rec.SystemId) { } // Mandatory!
                field(number; Rec."No.") { }
                field(description; Rec.Description) { } // The ordering screen expects description, displayName or itemDescription
                field(countryRegionOfOriginCode; Rec."Country/Region of Origin Code") { }
                field(unitPrice; Rec."Unit Price") { }
                field(inventory; Rec.Inventory) { }
                field(salesUnitOfMeasure; Rec."Sales Unit of Measure") { }
            }
        }
    }
}