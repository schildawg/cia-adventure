/// IN A VISITORS ROOM
///
class VisitorsRoom (Room);
begin
    /// Creates instance.
    //
    constructor Init ();
    begin
        this.Description := 'IN A VISITORS ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  LOBBY);
        this.Exits.Set(WEST,  0);
    end
end
Rooms.Set (VISITORS_ROOM, VisitorsRoom());

// LOOK should display IN A VISITORS ROOM.
//
test 'IN A VISITORS ROOM';
begin
    Setup ();
    Location := VISITORS_ROOM;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A VISITORS ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A VIDEO CASSETTE RECORDER.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO EAST should lead to LOBBY
//
test 'VISITORS ROOM - GO EAST';
begin
    Setup ();
    Location := VISITORS_ROOM;
    Items[BADGE].Location := 0;

    ParseCommand ('GO EAST');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end