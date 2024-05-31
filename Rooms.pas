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
    Rooms.Set (VISITORS_ROOM, VisitorsRoom());
    Rooms.Set (ANTE_ROOM, AnteRoom());
    Rooms.Set (PRESIDENTS_OFFICE, PresidentsOffice());

    Items.Set (BADGE, Badge());
    Items.Set (BUILDING, Building());
    Items.Set (SCULPTURE, Sculpture());
    Items.Set (SLIDING_DOORS, SlidingDoors());
    Items.Set (RECORDER, Recorder());
    Items.Set (LOCKED_WOODEN_DOOR, LockedWoodenDoor());
    Items.Set (OPEN_WOODEN_DOOR, OpenWoodenDoor());
end

var Rooms : Array := Array(31) as Array;

procedure AddRooms();
begin
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
