var NORTH : Integer := 0;
var SOUTH : Integer := 1;
var EAST  : Integer := 2;
var WEST  : Integer := 3;

type ScreenType = (DEBUG, BUFFER, CONSOLE);
var Display := Screen();

/// Room
///
class Room;
var
    Description : String;
    Exits       : Array;

begin
    constructor Init (Description : String, North, South, East, West : Integer);
    begin
        this.Description := Description;
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(0, North);
        this.Exits.Set(1, South);
        this.Exits.Set(2, East);
        this.Exits.Set(3, West);
    end

    /// By default, no event!
    ///
    procedure Event () ;
    begin
    end
end

procedure Setup ();
begin
    Init ();
    Rooms.Set (BUSY_STREET, BusyStreet());
    Rooms.Set (LOBBY, Lobby());

    Items.Set (BADGE, Badge());
    Items.Set (BUILDING, Building());
    Items.Set (SCULPTURE, Sculpture());
    Items.Set (SLIDING_DOORS, SlidingDoors());
end

var INVENTORY              : Integer := -1;

var BUSY_STREET            : Integer := 1;
var VISITORS_ROOM          : Integer := 2;
var LOBBY                  : Integer := 3;
var ANTE_ROOM              : Integer := 4;
var PRESIDENTS_ROOM        : Integer := 5;
var SOUND_PROOFED_CUBICLE  : Integer := 6;
var SECURITY_OFFICE        : Integer := 7;
var SMALL_HALLWAY          : Integer := 8;
var SMALL_ROOM             : Integer := 9;
var SHORT_CORRIDOR         : Integer := 10;
var METAL_HALLWAY          : Integer := 11;
var PLAIN_ROOM             : Integer := 12;
var MAINTENANCE_CLOSET     : Integer := 13;
var CAFETERIA              : Integer := 14;
var SIDE_CORRIDOR          : Integer := 15;
var POWER_GENERATOR_ROOM   : Integer := 16;
var SUB_BASEMENT           : Integer := 17;
var SECRET_COMPLEX         : Integer := 18;
var MONITORING_ROOM        : Integer := 19;
var LEDGE                  : Integer := 20;
var OTHER_SIDE             : Integer := 21;
var LONG_CORRIDOR          : Integer := 22;
var LARGE_ROOM             : Integer := 23;
var LABORATORY             : Integer := 24;
var CROSS_CORRIDOR         : Integer := 25;
var CROSS_EXAMINATION_ROOM : Integer := 26;
var BATHROOM               : Integer := 27;
var CHIEFS_OFFICE          : Integer := 28;
var CHAOS_CONTROL_ROOM     : Integer := 29;
var END_OF_COMPLEX         : Integer := 30;

var Rooms : Array := Array(31) as Array;

procedure AddRooms();
begin
    Rooms.Set (VISITORS_ROOM, Room ('IN A VISITORS ROOM', 0, 0, LOBBY, 0));
    Rooms.Set (ANTE_ROOM, Room ('IN A DINGY ANTE ROOM', 0, 0, 0, LOBBY));
    Rooms.Set (PRESIDENTS_ROOM, Room ('IN THE COMPANY PRESIDENTS OFFICE', 0, 0, 0, ANTE_ROOM));
    Rooms.Set (SOUND_PROOFED_CUBICLE, Room ('IN A SMALL SOUND PROOFED CUBICLE', 0, PLAIN_ROOM, 0, 0));
    Rooms.Set (SECURITY_OFFICE, Room ('IN A SECURITY OFFICE', 0, 0, SMALL_HALLWAY, 0));
    Rooms.Set (SMALL_HALLWAY, Room ('IN A SMALL HALLWAY', 0, CAFETERIA, SMALL_ROOM, SECURITY_OFFICE));
    Rooms.Set (SMALL_ROOM, Room ('IN A SMALL ROOM', LOBBY, 0, 0, 0));
    Rooms.Set (SHORT_CORRIDOR, Room ('IN A SHORT CORRIDOR', 0, SIDE_CORRIDOR, 0, SMALL_ROOM));
    Rooms.Set (METAL_HALLWAY, Room ('IN A HALLWAY MADE OF METAL', 0, 0, PLAIN_ROOM, SHORT_CORRIDOR));
    Rooms.Set (PLAIN_ROOM, Room ('IN A SMALL PLAIN ROOM', SOUND_PROOFED_CUBICLE, 0, 0, METAL_HALLWAY));
    Rooms.Set (MAINTENANCE_CLOSET, Room ('IN A MAINTENANCE CLOSET', 0, 0, CAFETERIA, 0));
    Rooms.Set (CAFETERIA, Room ('IN A CAFETERIA', SMALL_HALLWAY, 0, 0, 0));
    Rooms.Set (SIDE_CORRIDOR, Room ('IN A SIDE CORRIDOR', SHORT_CORRIDOR, 0, POWER_GENERATOR_ROOM, 0));
    Rooms.Set (POWER_GENERATOR_ROOM, Room ('IN A POWER GENERATOR ROOM', 0, 0, 0, SIDE_CORRIDOR));
    Rooms.Set (SUB_BASEMENT, Room ('IN A SUB-BASEMENT BELOW THE CHUTE', 0, 0, SECRET_COMPLEX, 0));
    Rooms.Set (SECRET_COMPLEX, Room ('IN THE ENTRANCE TO THE SECRET COMPLEX', 0, LEDGE, MONITORING_ROOM, SUB_BASEMENT));
    Rooms.Set (MONITORING_ROOM, Room ('IN A SECRET MONITORING ROOM', 0, 0, 0, SECRET_COMPLEX));
    Rooms.Set (LEDGE, Room ('ON A LEDGE IN FRONT OF A METAL PIT 1000S OF FEET DEEP', SECRET_COMPLEX, 0, 0, 0));
    Rooms.Set (OTHER_SIDE, Room ('ON THE OTHER SIDE OF THE PIT', 0, 0, LONG_CORRIDOR, 0));
    Rooms.Set (LONG_CORRIDOR, Room ('IN A LONG CORRIDOR', 0, CROSS_CORRIDOR, LARGE_ROOM, OTHER_SIDE));
    Rooms.Set (LARGE_ROOM, Room ('IN A LARGE ROOM', 0, CROSS_EXAMINATION_ROOM, 0, LONG_CORRIDOR));
    Rooms.Set (LABORATORY, Room ('IN A SECRET LABORATORY', 0, 0, CROSS_CORRIDOR, 0));
    Rooms.Set (CROSS_CORRIDOR, Room ('IN A NARROW CROSS CORRIDOR', LONG_CORRIDOR, 0, 0, LABORATORY));
    Rooms.Set (CROSS_EXAMINATION_ROOM, Room ('IN A CROSS EXAMINATION ROOM', LARGE_ROOM, CHIEFS_OFFICE, 0, 0));
    Rooms.Set (BATHROOM, Room ('IN A SMALL BATHROOM', 0, 0, CHIEFS_OFFICE, 0));
    Rooms.Set (CHIEFS_OFFICE, Room ('IN THE OFFICE OF THE CHIEF OF CHAOS', CROSS_EXAMINATION_ROOM, END_OF_COMPLEX, 0, BATHROOM));
    Rooms.Set (CHAOS_CONTROL_ROOM, Room ('IN THE CHAOS CONTROL ROOM', 0, 0, END_OF_COMPLEX, 0));
    Rooms.Set (END_OF_COMPLEX, Room ('NEAR THE END OF THE COMPLEX', CHIEFS_OFFICE, 0, 0, CHAOS_CONTROL_ROOM));
end

// test 'IN A VISITORS ROOM';
// begin
//     Init ();

//     Location := 2;

//     DisplayRoom ();
// end
