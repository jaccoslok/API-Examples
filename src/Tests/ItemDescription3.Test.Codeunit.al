namespace bcportal.api;
using Microsoft.Inventory.Item;

/// <summary>
/// Test codeunit for CM00001 (revised): Description 3 Text[75] and Description 4 Text[100] on Item.
/// Compilation requires both fields on Item table.
/// Runtime tests verify field lengths, assignments, and database round-trips (AC1, AC2, AC7).
/// </summary>
codeunit 58710 "Item Desc3 Test PTE"
{
    Subtype = Test;
    TestPermissions = Disabled;

    // TS1/AC1 – Description 3 declared as Text[75].
    // RED: runtime fails if field is not Text[75].
    [Test]
    procedure Description3FieldExistsWithLength75()
    var
        Item: Record Item;
        ExpectedLength: Integer;
        ActualLength: Integer;
    begin
        ExpectedLength := 75;
        ActualLength := MaxStrLen(Item."Description 3 PTE");
        if ActualLength <> ExpectedLength then
            Error('Description 3 PTE must be Text[75]. Expected %1, got %2.', ExpectedLength, ActualLength);
    end;

    // TS1/AC1 – In-memory value assignment for Description 3.
    [Test]
    procedure Description3ValueAssignment()
    var
        Item: Record Item;
        TestValue: Text[75];
    begin
        TestValue := 'Test Description 3';
        Item.Init();
        Item."No." := 'TEST-D3-001';
        Item."Description 3 PTE" := TestValue;
        if Item."Description 3 PTE" <> TestValue then
            Error('Description 3 PTE value mismatch. Expected ''%1'', got ''%2''.', TestValue, Item."Description 3 PTE");
    end;

    // TS1/AC1 – Boundary: exactly 75 characters accepted for Description 3.
    [Test]
    procedure Description3Accepts75CharValue()
    var
        Item: Record Item;
        MaxValue: Text[75];
    begin
        MaxValue := PadStr('', 75, 'X');
        Item."Description 3 PTE" := MaxValue;
        if StrLen(Item."Description 3 PTE") <> 75 then
            Error('Description 3 PTE should accept 75 characters. Got %1.', StrLen(Item."Description 3 PTE"));
    end;

    // TS1/AC1 – Database persistence round-trip for Description 3.
    [Test]
    procedure Description3DatabaseRoundTrip()
    var
        Item: Record Item;
        ReloadedItem: Record Item;
        TestValue: Text[75];
        TestNo: Code[20];
    begin
        TestNo := 'TST-D3-RT';
        TestValue := 'Round-trip persistence test D3';
        if Item.Get(TestNo) then
            Item.Delete(false);
        Item.Init();
        Item."No." := TestNo;
        Item.Description := 'D3 round-trip test item';
        Item."Description 3 PTE" := TestValue;
        Item.Insert(false);
        ReloadedItem.Get(TestNo);
        if ReloadedItem."Description 3 PTE" <> TestValue then
            Error('Description 3 DB round-trip failed. Expected ''%1'', got ''%2''.', TestValue, ReloadedItem."Description 3 PTE");
        ReloadedItem.Delete(false);
    end;

    // TS2/AC2 – Description 4 declared as Text[100].
    // RED: AL0132 compile error until Description 4 PTE field exists on Item.
    [Test]
    procedure Description4FieldExistsWithLength100()
    var
        Item: Record Item;
        ExpectedLength: Integer;
        ActualLength: Integer;
    begin
        ExpectedLength := 100;
        ActualLength := MaxStrLen(Item."Description 4 PTE");
        if ActualLength <> ExpectedLength then
            Error('Description 4 PTE must be Text[100]. Expected %1, got %2.', ExpectedLength, ActualLength);
    end;

    // TS2/AC2 – Boundary: exactly 100 characters accepted for Description 4.
    [Test]
    procedure Description4Accepts100CharValue()
    var
        Item: Record Item;
        MaxValue: Text[100];
    begin
        MaxValue := PadStr('', 100, 'Y');
        Item."Description 4 PTE" := MaxValue;
        if StrLen(Item."Description 4 PTE") <> 100 then
            Error('Description 4 PTE should accept 100 characters. Got %1.', StrLen(Item."Description 4 PTE"));
    end;

    // TS2/AC2 – Database persistence round-trip for Description 4.
    [Test]
    procedure Description4DatabaseRoundTrip()
    var
        Item: Record Item;
        ReloadedItem: Record Item;
        TestValue: Text[100];
        TestNo: Code[20];
    begin
        TestNo := 'TST-D4-RT';
        TestValue := 'Round-trip persistence test D4';
        if Item.Get(TestNo) then
            Item.Delete(false);
        Item.Init();
        Item."No." := TestNo;
        Item.Description := 'D4 round-trip test item';
        Item."Description 4 PTE" := TestValue;
        Item.Insert(false);
        ReloadedItem.Get(TestNo);
        if ReloadedItem."Description 4 PTE" <> TestValue then
            Error('Description 4 DB round-trip failed. Expected ''%1'', got ''%2''.', TestValue, ReloadedItem."Description 4 PTE");
        ReloadedItem.Delete(false);
    end;
}
