/// IN THE LOBBY OF THE BUILDING
///
class Lobby (Room);
begin
    /// Creates instance.
    //
    constructor Init ();
    begin
        this.Description := 'IN THE LOBBY OF THE BUILDING';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, BUSY_STREET);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  ANTE_ROOM);
        this.Exits.Set(WEST,  VISITORS_ROOM);
    end

    // Door man kicks you out if you have BADGE.
    //
    procedure Event ();
    begin
        if Items[BADGE].Location = INVENTORY then 
        begin
            WriteLn ('THE DOOR MAN LOOKS AT MY BADGE AND THEN THROWS ME OUT.');
            Pause (1000);
            Location := BUSY_STREET;
            DisplayRoom();
        end
    end
end

// LOOK should display IN THE LOBBY OF THE BUILDING.
//
test 'IN THE LOBBY OF THE BUILDING';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// Door man should throw you out if you have BADGE
//
test 'LOBBY - DOOR MAN CHECKS BADGE';
begin
    // Arrange
    Setup ();
    Location := LOBBY;

    // Act
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'THE DOOR MAN LOOKS AT MY BADGE AND THEN THROWS ME OUT.');  
    AssertEqual (BUSY_STREET, Location);
end

// PUSH BUTTON should open the DOORS.
// TODO: Hidden Items??
test 'LOBBY - PUSH BUTTON';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;
  
    ParseCommand ('PUSH BUTTON');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THE DOORS OPEN WITH A WHOOSH!');
end
