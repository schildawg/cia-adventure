/// IN THE COMPANY PRESIDENTS OFFICE
///
class PresidentsOffice (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN THE COMPANY PRESIDENT''S OFFICE';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  ANTE_ROOM);
    end
end

// LOOK should display IN THE COMPANY PRESIDENTS OFFICE.
//
test 'IN THE COMPANY PRESIDENT''S OFFICE';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE COMPANY PRESIDENT''S OFFICE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN ELABORATE PAPER WEIGHT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE AN OLD MAHOGANY DESK.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO WEST should lead to ANTE ROOM
//
test 'PRESIDENT''S OFFICE - GO WEST';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('GO WEST');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A DINGY ANTE ROOM.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LOCKED WOODEN DOOR.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end