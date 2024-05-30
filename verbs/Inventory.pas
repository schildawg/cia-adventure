// "INVENTORY" Verb.
//
procedure Inventory();
var
   HasInventory : Boolean;

begin
    HasInventory := False;
   
    WriteLn('WE ARE PRESENTLY CARRYING:');
    for var R := 1; R  <= 46; R := R + 1 do
    begin
        var Item := Items[R];

        if Item.Location = INVENTORY then
        begin
            HasInventory := True;
            Write (Item.Description);
            if R = GLOVES and GlovesFlag = On then Write ('. WHICH IM WEARING.');
            WriteLn ('');
        end    
    end
    if Not HasInventory then WriteLn ('NOTHING');
end

/// Tests INVENTORY
//
test 'INVENTORY';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('INVENTORY');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'WE ARE PRESENTLY CARRYING:');
    AssertEqual (Display.Buffer(-1), 'A C.I.A. IDENTIFICATION BADGE');
end