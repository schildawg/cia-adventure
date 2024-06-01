/// IN A SMALL ROOM
///
class SmallRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SMALL ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, LOBBY);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  0);
    end
end

// LOOK should display IN A SMALL ROOM.
//
test 'IN A SMALL ROOM';
begin
    Setup ();
    Location := SMALL_ROOM;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SMALL ROOM.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN OLDE FASHIONED KEY.');    
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PANEL OF BUTTONS NUMBERED ONE THRU THREE.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO NORTH should lead to LOBBY
//
test 'SMALL ROOM - GO NORTH';
begin
    Setup ();
    Location := SMALL_ROOM;
    Items[BADGE].Location := 0;

    ParseCommand ('GO NORTH');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end