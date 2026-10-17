namespace bcportal.api;

using Microsoft.Sales.Document;
using Microsoft.Integration.Entity;

page 58702 "Blanket Sales Orders API PTE"
{
    PageType = API;
    APIPublisher = 'slokSoftware';
    APIGroup = 'bcPortal';
    APIVersion = 'v2.0';
    EntityName = 'blanketSalesOrder';
    EntitySetName = 'blanketSalesOrders';
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const("Blanket Order"));
    ODataKeyFields = SystemId; //Mandatory
    DelayedInsert = true;
    Editable = false;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId) { }
                field(number; Rec."No.") { }
                field(externalDocumentNumber; Rec."External Document No.") { }
                field(orderDate; Rec."Order Date") { }
                field(documentDate; Rec."Document Date") { }
                field(postingDate; Rec."Posting Date") { }
                field(sellToCustomerNumber; Rec."Sell-to Customer No.") { }
                field(sellToCustomerName; Rec."Sell-to Customer Name") { }
                field(sellToContact; Rec."Sell-to Contact") { }
                field(sellToAddressLine1; Rec."Sell-to Address") { }
                field(sellToAddressLine2; Rec."Sell-to Address 2") { }
                field(sellToCity; Rec."Sell-to City") { }
                field(sellToCountry; Rec."Sell-to Country/Region Code") { }
                field(sellToState; Rec."Sell-to County") { }
                field(sellToPostCode; Rec."Sell-to Post Code") { }
                field(billToCustomerNumber; Rec."Bill-to Customer No.") { }
                field(billToName; Rec."Bill-to Name") { }
                field(billToAddressLine1; Rec."Bill-to Address") { }
                field(billToAddressLine2; Rec."Bill-to Address 2") { }
                field(billToCity; Rec."Bill-to City") { }
                field(billToCountry; Rec."Bill-to Country/Region Code") { }
                field(billToState; Rec."Bill-to County") { }
                field(billToPostCode; Rec."Bill-to Post Code") { }
                field(shipToName; Rec."Ship-to Name") { }
                field(shipToContact; Rec."Ship-to Contact") { }
                field(shipToAddressLine1; Rec."Ship-to Address") { }
                field(shipToAddressLine2; Rec."Ship-to Address 2") { }
                field(shipToCity; Rec."Ship-to City") { }
                field(shipToCountry; Rec."Ship-to Country/Region Code") { }
                field(shipToState; Rec."Ship-to County") { }
                field(shipToPostCode; Rec."Ship-to Post Code") { }
                field(currencyCode; Rec."Currency Code") { }
                field(amount; Rec.Amount) { }
                field(amountIncludingVat; Rec."Amount Including VAT") { }
                field(status; Rec.Status) { }
                part(blanketSalesOrderLines; "Blanket SO Lines API PTE")
                {
                    EntityName = 'blanketSalesOrderLine';
                    EntitySetName = 'blanketSalesOrderLines';
                    SubPageLink = "Document Type" = const("Blanket Order"), "Document No." = field("No.");
                }
            }
        }
    }

    [ServiceEnabled]
    [Caption('Creates a Sales Order for lines with a Quantity to Ship')]
    [Scope('Cloud')]
    procedure CreateSalesOrder(var ActionContext: WebServiceActionContext)
    var
        BlanketSalesOrderToOrder: Codeunit "Blanket Sales Order to Order";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderEntityBuffer: Record "Sales Order Entity Buffer";
    begin
        BlanketSalesOrderToOrder.SetHideValidationDialog(true);
        if not BlanketSalesOrderToOrder.Run(Rec) then
            Error(BlanketSalesOrderConversionFailedErr);

        BlanketSalesOrderToOrder.GetSalesOrderHeader(SalesOrderHeader);

        ActionContext.SetObjectType(ObjectType::Page);
        ActionContext.SetObjectId(Page::"Sales Orders API PTE");
        ActionContext.AddEntityKey(SalesOrderEntityBuffer.FieldNo(Id), SalesOrderHeader.SystemId);
        ActionContext.SetResultCode(WebServiceActionResultCode::Created);
    end;

    var
        BlanketSalesOrderConversionFailedErr: Label 'The blanket sales order could not be converted to a sales order.';
}
