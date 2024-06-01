
// IN A DINGY ANTE ROOM
///
class AnteRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A DINGY ANTE ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  LOBBY);
    end
end

// LOOK should display IN A DINGY ANTE ROOM.
//
test 'IN A DINGY ANTE ROOM';
begin
    Setup ();
    Location := ANTE_ROOM;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A DINGY ANTE ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LOCKED WOODEN DOOR.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO WEST should lead to LOBBY
//
test 'ANTE ROOM - GO WEST';
begin
    Setup ();
    Location := ANTE_ROOM;
    Items[BADGE].Location := 0;

    ParseCommand ('GO WEST');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end