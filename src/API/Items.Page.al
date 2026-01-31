namespace bcportal.api;
using Microsoft.Inventory.Item;

page 50000 "Items PTE"
{
    PageType = API;
    APIPublisher = 'slokSoftware';
    APIGroup = 'BcPortal';
    APIVersion = 'v2.0';
    EntityName = 'item';
    EntitySetName = 'items';
    SourceTable = Item;
    DelayedInsert = true;
    Editable = false;
    ODataKeyFields = SystemId; // Mandatory!
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