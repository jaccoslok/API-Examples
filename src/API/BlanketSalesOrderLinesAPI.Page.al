namespace bcportal.api;

using Microsoft.Sales.Document;

page 58709 "Blanket SO Lines API PTE"
{
    PageType = API;
    APIPublisher = 'slokSoftware';
    APIGroup = 'bcPortal';
    APIVersion = 'v2.0';
    EntityName = 'blanketSalesOrderLine';
    EntitySetName = 'blanketSalesOrderLines';
    ODataKeyFields = SystemId; //Mandatory!
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = const("Blanket Order"));
    Extensible = false;
    Editable = true;
    DelayedInsert = true;
    ModifyAllowed = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId) { Editable = false; } //Mandatory!
                field(documentId; DocumentId) { Editable = false; }
                field(documentNumber; Rec."Document No.") { Editable = false; }
                field(sequence; Rec."Line No.") { Editable = false; }
                field(lineType; Rec.Type) { Editable = false; }
                field(lineObjectNumber; Rec."No.") { Editable = false; }
                field(variantCode; Rec."Variant Code") { Editable = false; }
                field(description; Rec.Description) { Editable = false; }
                field(description2; Rec."Description 2") { Editable = false; }
                field(unitOfMeasureCode; Rec."Unit of Measure Code") { Editable = false; }
                field(quantityPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Editable = false;
                }
                field(quantity; Rec.Quantity) { Editable = false; }
                field(quantityBase; Rec."Quantity (Base)") { Editable = false; }
                field(remainingQuantity; RemainingQuantity)
                {
                    Editable = false;
                }
                field(remainingQuantityBase; RemainingQuantityBase)
                {
                    Editable = false;
                }
                field(outstandingQuantity; Rec."Outstanding Quantity") { Editable = false; }
                field(outstandingQuantityBase; Rec."Outstanding Qty. (Base)") { Editable = false; }
                field(shippedQuantity; Rec."Quantity Shipped") { Editable = false; }
                field(shippedQuantityBase; Rec."Qty. Shipped (Base)") { Editable = false; }
                field(invoicedQuantity; Rec."Quantity Invoiced") { Editable = false; }
                field(invoicedQuantityBase; Rec."Qty. Invoiced (Base)") { Editable = false; }
                field(invoiceQuantity; Rec."Qty. to Invoice") { Editable = false; }
                field(invoiceQuantityBase; Rec."Qty. to Invoice (Base)") { Editable = false; }
                field(shipQuantity; Rec."Qty. to Ship") { Editable = true; } //Mandatory to enable inline editing of the qty to ship
                field(shipQuantityBase; Rec."Qty. to Ship (Base)") { Editable = true; } //Mandatory to enable inline editing of the qty to ship
                field(unitPrice; Rec."Unit Price") { Editable = false; }
                field(lineDiscountPercent; Rec."Line Discount %") { Editable = false; }
                field(lineDiscountAmount; Rec."Line Discount Amount") { Editable = false; }
                field(amount; Rec.Amount) { Editable = false; }
                field(amountIncludingVat; Rec."Amount Including VAT") { Editable = false; }
                field(myCustomField; Rec."My Custom Field PTE") { Editable = false; }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        SalesOrderLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
            DocumentId := SalesHeader.SystemId
        else
            Clear(DocumentId);

        SalesOrderLine.SetRange("Document Type", SalesOrderLine."Document Type"::Order);
        SalesOrderLine.SetRange("Blanket Order No.", Rec."Document No.");
        SalesOrderLine.SetRange("Blanket Order Line No.", Rec."Line No.");
        SalesOrderLine.CalcSums(Quantity, "Quantity (Base)");

        RemainingQuantity := Rec.Quantity - SalesOrderLine.Quantity;
        RemainingQuantityBase := Rec."Quantity (Base)" - SalesOrderLine."Quantity (Base)";
    end;

    var
        DocumentId: Guid;
        RemainingQuantity: Decimal;
        RemainingQuantityBase: Decimal;
}