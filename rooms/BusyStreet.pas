/// ON A BUSY STREET
///
class BusyStreet (Room);
begin
    /// Creates instance.
    //
    constructor Init ();
    begin
        this.Description := 'ON A BUSY STREET';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  0);
    end

    /// Wins game if RUBY is in inventory!
    ///
    procedure Event ();
    begin
        if Items[RUBY].Location = INVENTORY then
        begin
           WriteLn ('HURRAY! YOUVE RECOVERED THE RUBY!');
           WriteLn ('YOU WIN!');
           IsDone := True;
           Exit;   
        end
    end
end

// LOOK should display the ON A BUSY STREET "room".
//
test 'ON A BUSY STREET';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('LOOK');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-4), 'WE ARE ON A BUSY STREET.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A TALL OFFICE BUILDING.');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// Should win if ON BUSY STREET and has RUBY!
//
test 'BUSY STREET - WIN';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;
    Items[RUBY].Location := -1;
    
    // Act
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'HURRAY! YOUVE RECOVERED THE RUBY!');      
    AssertEqual (Display.Buffer(-1), 'YOU WIN!');
    AssertTrue (IsDone);
end