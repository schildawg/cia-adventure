/// A TALL OFFICE BUILDING
///
class Building (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A TALL OFFICE BUILDING';
        this.Keyword     := 'BUI';
        this.Location    := BUSY_STREET;

        this.Fixed := True;
    end

    // GO to BUILDING should lead to LOBBY.
    //
    function Go() : ResultType;
    begin
        Location := LOBBY;
        Exit Handled;
    end   
end

// Can't get A TALL OFFICE BUILDING 
// 
test 'BUILDING - CAN''T GET';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('GET BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (BUSY_STREET, Items[BUILDING].Location);
end

// DROP BADGE and GO BUILDING should go to LOBBY.
// 
test 'BUILDING - GO';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('DROP BADGE');
    ParseCommand ('GO BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');     
    AssertEqual (LOBBY, Location);
end