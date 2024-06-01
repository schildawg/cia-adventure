/// A LOCKED WOODEN DOOR
///
class LockedWoodenDoor (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A LOCKED WOODEN DOOR';
        this.Keyword     := 'DOO';
        this.Location    := ANTE_ROOM;

        this.Fixed := True;
        this.Openable := True;
    end

    // LOOK at DOOR shows it's locked.
    //
    function Look() : ResultType;
    begin
        WriteLn ('IT''S LOCKED.');
        Exit Handled;
    end 

    // OPEN then DOOR if ANTIQUE KEY in INVENTORY.
    //
    function Open() : ResultType;
    begin
        if Items[ANTIQUE_KEY].Location = INVENTORY then
        begin
            WriteLn ('O.K. I OPENED THE DOOR.');
            Items[LOCKED_WOODEN_DOOR].Location := 0;
            Items[OPEN_WOODEN_DOOR].Location := ANTE_ROOM;
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// A OPEN WOODEN DOOR
///
class OpenWoodenDoor (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A OPEN WOODEN DOOR';
        this.Keyword     := 'DOO';
        this.Location    := 0;

        this.Fixed := True;
    end

    // GO to DOOR should lead to PRESIDENTS_OFFICE.
    //
    function Go() : ResultType;
    begin
        Location := PRESIDENTS_OFFICE;
        Exit Handled;
    end   
end

// Can't get A LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - CAN''T GET';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('GET DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (ANTE_ROOM, Items[LOCKED_WOODEN_DOOR].Location);
end

// LOOK at LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - LOOK';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('LOOK DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'IT''S LOCKED.');
end

// Can't go in LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - CAN''T GO';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T GO THAT WAY AT THE MOMENT.');
end


// Can't OPEN the LOCKED WOODEN DOOR without KEY
// 
test 'LOCKED WOODEN DOOR - CAN''T OPEN';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('OPEN DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT......YET!');
end

// OPEN the LOCKED WOODEN DOOR with KEY
// 
test 'LOCKED WOODEN DOOR - OPEN';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[ANTIQUE_KEY].Location := INVENTORY;

    // Act
    ParseCommand ('OPEN DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'O.K. I OPENED THE DOOR.');
    AssertEqual (0, Items[LOCKED_WOODEN_DOOR].Location);
    AssertEqual (ANTE_ROOM, Items[OPEN_WOODEN_DOOR].Location);
end

// Can't get AN OPEN WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - CAN''T GET';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[LOCKED_WOODEN_DOOR].Location := 0;
    Items[OPEN_WOODEN_DOOR].Location := Location;

    // Act
    ParseCommand ('GET DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (ANTE_ROOM, Items[OPEN_WOODEN_DOOR].Location);
end

// LOOK at OPEN WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - LOOK';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[LOCKED_WOODEN_DOOR].Location := 0;
    Items[OPEN_WOODEN_DOOR].Location := Location;

    // Act
    ParseCommand ('LOOK DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I SEE NOTHING OF INTEREST.');
end

// Can't go in LOCKED WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - GO';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[LOCKED_WOODEN_DOOR].Location := 0;
    Items[OPEN_WOODEN_DOOR].Location := Location;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE COMPANY PRESIDENT''S OFFICE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN ELABORATE PAPER WEIGHT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE AN OLD MAHOGANY DESK.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end