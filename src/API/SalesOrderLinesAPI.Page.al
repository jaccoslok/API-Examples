namespace bcportal.api;

using Microsoft.API.V2;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Integration.Entity;
using Microsoft.Integration.Graph;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using System.Reflection;

page 58708 "Sales Order Lines API PTE"
{
    DelayedInsert = true;
    APIPublisher = 'slokSoftware';
    APIGroup = 'bcPortal';
    APIVersion = 'v2.0';
    PageType = API;
    ODataKeyFields = SystemId; // Mandatory!
    EntityName = 'mySalesOrderLine';
    EntitySetName = 'mySalesOrderLines';
    SourceTable = "Sales Invoice Line Aggregate";
    SourceTableTemporary = true;
    Extensible = false;
    AboutText = 'Sales order lines with the custom field from the Sales Line table.';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId) // Mandatory
                {
                    Editable = false;
                }
                field(documentId; Rec."Document Id") // Mandatory!
                {

                    trigger OnValidate()
                    begin
                        if (not IsNullGuid(xRec."Document Id")) and (xRec."Document Id" <> Rec."Document Id") then
                            Error(CannotChangeDocumentIdNoErr);
                    end;
                }
                field(sequence; Rec."Line No.")
                {

                    trigger OnValidate()
                    begin
                        if (xRec."Line No." <> Rec."Line No.") and (xRec."Line No." <> 0) then
                            Error(CannotChangeLineNoErr);

                        RegisterFieldSet(Rec.FieldNo("Line No."));
                    end;
                }
                field(itemId; Rec."Item Id")
                {

                    trigger OnValidate()
                    begin
                        if not Item.GetBySystemId(Rec."Item Id") then
                            Error(ItemDoesNotExistErr);

                        RegisterFieldSet(Rec.FieldNo(Type));
                        RegisterFieldSet(Rec.FieldNo("No."));
                        RegisterFieldSet(Rec.FieldNo("Item Id"));
                        Rec."No." := Item."No.";
                    end;
                }
                field(accountId; Rec."Account Id")
                {

                    trigger OnValidate()
                    var
                        GLAccount: Record "G/L Account";
                        EmptyGuid: Guid;
                    begin
                        if Rec."Account Id" <> EmptyGuid then
                            if Item."No." <> '' then
                                Error(BothItemIdAndAccountIdAreSpecifiedErr);

                        if not GLAccount.GetBySystemId(Rec."Account Id") then
                            Error(AccountDoesNotExistErr);

                        RegisterFieldSet(Rec.FieldNo(Type));
                        RegisterFieldSet(Rec.FieldNo("Account Id"));
                        RegisterFieldSet(Rec.FieldNo("No."));
                    end;
                }
                field(lineType; Rec."API Type")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Type));
                    end;
                }
                field(lineObjectNumber; Rec."No.")
                {

                    trigger OnValidate()
                    var
                        GLAccount: Record "G/L Account";
                    begin
                        if (xRec."No." <> Rec."No.") and (xRec."No." <> '') then
                            Error(CannotChangeLineObjectNoErr);

                        case Rec."API Type" of
                            Rec."API Type"::Item:
                                begin
                                    if not Item.Get(Rec."No.") then
                                        Error(ItemDoesNotExistErr);

                                    RegisterFieldSet(Rec.FieldNo("Item Id"));
                                    Rec."Item Id" := Item.SystemId;
                                end;
                            Rec."API Type"::Account:
                                begin
                                    if not GLAccount.Get(Rec."No.") then
                                        Error(AccountDoesNotExistErr);

                                    RegisterFieldSet(Rec.FieldNo("Account Id"));
                                    Rec."Account Id" := GLAccount.SystemId;
                                end;
                        end;
                        RegisterFieldSet(Rec.FieldNo("No."));
                    end;
                }
                field(description; Rec.Description)
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Description));
                    end;
                }
                field(description2; Rec."Description 2")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Description 2"));
                    end;
                }
                field(myCustomField; Rec."My Custom Field PTE")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("My Custom Field PTE"));
                    end;
                }
                field(unitOfMeasureId; Rec."Unit of Measure Id")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Unit of Measure Code"));
                    end;
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Unit of Measure Code"));
                    end;
                }
                field(quantity; Rec.Quantity)
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Quantity));
                    end;
                }
                field(unitPrice; Rec."Unit Price")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Unit Price"));
                    end;
                }
                field(discountAmount; Rec."Line Discount Amount")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Line Discount Amount"));
                    end;
                }
                field(discountPercent; Rec."Line Discount %")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Line Discount %"));
                    end;
                }
                field(discountAppliedBeforeTax; Rec."Discount Applied Before Tax")
                {
                    Editable = false;
                }
                field(amountExcludingTax; Rec."Line Amount Excluding Tax")
                {
                    Editable = false;
                }
                field(taxCode; Rec."Tax Code")
                {

                    trigger OnValidate()
                    var
                        GeneralLedgerSetup: Record "General Ledger Setup";
                    begin
                        if GeneralLedgerSetup.UseVat() then begin
                            Rec.Validate("VAT Prod. Posting Group", COPYSTR(Rec."Tax Code", 1, 20));
                            RegisterFieldSet(Rec.FieldNo("VAT Prod. Posting Group"));
                        end else begin
                            Rec.Validate("Tax Group Code", COPYSTR(Rec."Tax Code", 1, 20));
                            RegisterFieldSet(Rec.FieldNo("Tax Group Code"));
                        end;
                    end;
                }
                field(taxPercent; Rec."VAT %")
                {
                    Editable = false;
                }
                field(totalTaxAmount; Rec."Line Tax Amount")
                {
                    Editable = false;
                }
                field(amountIncludingTax; Rec."Line Amount Including Tax")
                {
                    Editable = false;
                }
                field(invoiceDiscountAllocation; Rec."Inv. Discount Amount Excl. VAT")
                {
                    Editable = false;
                }
                field(netAmount; Rec.Amount)
                {
                    Editable = false;
                }
                field(netTaxAmount; Rec."Tax Amount")
                {
                    Editable = false;
                }
                field(netAmountIncludingTax; Rec."Amount Including VAT")
                {
                    Editable = false;
                }
                field(shipmentDate; Rec."Shipment Date")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Shipment Date"));
                    end;
                }
                field(shippedQuantity; Rec."Quantity Shipped")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Quantity Shipped"));
                    end;
                }
                field(invoicedQuantity; Rec."Quantity Invoiced")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Quantity Invoiced"));
                    end;
                }
                field(invoiceQuantity; Rec."Qty. to Invoice")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Qty. to Invoice"));
                    end;
                }
                field(shipQuantity; Rec."Qty. to Ship")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Qty. to Ship"));
                    end;
                }
                field(itemVariantId; Rec."Variant Id")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Variant Code"));
                    end;
                }
                field(variantCode; Rec."Variant Code")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Variant Code"));
                    end;
                }
                field(locationId; Rec."Location Id")
                {

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Location Code"));
                    end;
                }
                part(dimensionSetLines; "APIV2 - Dimension Set Lines")
                {
                    EntityName = 'dimensionSetLine';
                    EntitySetName = 'dimensionSetLines';
                    SubPageLink = "Parent Id" = field(SystemId), "Parent Type" = const("Sales Order Line");
                }
                part(location; "APIV2 - Locations")
                {
                    EntityName = 'location';
                    EntitySetName = 'locations';
                    Multiplicity = ZeroOrOne;
                    SubPageLink = SystemId = field("Location Id");
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    var
        GraphMgtSalesOrderBuffer: Codeunit "Graph Mgt - Sales Order Buffer";
    begin
        GraphMgtSalesOrderBuffer.PropagateDeleteLine(Rec);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        GraphMgtSalesOrderBuffer: Codeunit "Graph Mgt - Sales Order Buffer";
        GraphMgtSalesInvLines: Codeunit "Graph Mgt - Sales Inv. Lines";
        SysId: Guid;
        DocumentIdFilter: Text;
        IdFilter: Text;
        FilterView: Text;
    begin
        if not LinesLoaded then begin
            FilterView := Rec.GetView();
            IdFilter := Rec.GetFilter(SystemId);
            DocumentIdFilter := Rec.GetFilter("Document Id");
            if (IdFilter = '') and (DocumentIdFilter = '') then
                Error(IDOrDocumentIdShouldBeSpecifiedForLinesErr);
            if IdFilter <> '' then begin
                Evaluate(SysId, IdFilter);
                DocumentIdFilter := GraphMgtSalesInvLines.GetSalesOrderDocumentIdFilterFromSystemId(SysId);
            end else
                DocumentIdFilter := Rec.GetFilter("Document Id");
            GraphMgtSalesOrderBuffer.LoadLines(Rec, DocumentIdFilter);
            Rec.SetView(FilterView);
            if not Rec.FindFirst() then
                exit(false);
            LinesLoaded := true;
        end;

        exit(true);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        GraphMgtSalesOrderBuffer: Codeunit "Graph Mgt - Sales Order Buffer";
    begin
        GraphMgtSalesOrderBuffer.PropagateInsertLine(Rec, TempFieldBuffer);
    end;

    trigger OnModifyRecord(): Boolean
    var
        GraphMgtSalesOrderBuffer: Codeunit "Graph Mgt - Sales Order Buffer";
    begin
        GraphMgtSalesOrderBuffer.PropagateModifyLine(Rec, TempFieldBuffer);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearCalculatedFields();
        RegisterFieldSet(Rec.FieldNo(Type));
    end;

    var
        TempFieldBuffer: Record "Field Buffer" temporary;
        TempItemFieldSet: Record 2000000041 temporary;
        Item: Record "Item";
        LinesLoaded: Boolean;
        IDOrDocumentIdShouldBeSpecifiedForLinesErr: Label 'You must specify an Id or a Document Id to get the lines.';
        CannotChangeDocumentIdNoErr: Label 'The value for "documentId" cannot be modified.';
        CannotChangeLineNoErr: Label 'The value for sequence cannot be modified. Delete and insert the line again.';
        BothItemIdAndAccountIdAreSpecifiedErr: Label 'Both "itemId" and "accountId" are specified. Specify only one of them.';
        ItemDoesNotExistErr: Label 'Item does not exist.';
        AccountDoesNotExistErr: Label 'Account does not exist.';
        CannotChangeLineObjectNoErr: Label 'The value for "lineObjectNumber" cannot be modified.';

    local procedure RegisterFieldSet(FieldNo: Integer)
    var
        LastOrderNo: Integer;
    begin
        LastOrderNo := 1;
        if TempFieldBuffer.FindLast() then
            LastOrderNo := TempFieldBuffer.Order + 1;

        Clear(TempFieldBuffer);
        TempFieldBuffer.Order := LastOrderNo;
        TempFieldBuffer."Table ID" := Database::"Sales Invoice Line Aggregate";
        TempFieldBuffer."Field ID" := FieldNo;
        TempFieldBuffer.Insert();
    end;

    local procedure ClearCalculatedFields()
    begin
        TempFieldBuffer.Reset();
        TempFieldBuffer.DeleteAll();
        TempItemFieldSet.Reset();
        TempItemFieldSet.DeleteAll();
        Clear(Item);
    end;
}
