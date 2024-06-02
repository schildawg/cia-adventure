var NORTH : Integer := 0;
var SOUTH : Integer := 1;
var EAST  : Integer := 2;
var WEST  : Integer := 3;

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

var Rooms : Array := Array(31) as Array;

/// Add Room prototypes.
//
procedure AddRooms();
begin
    Rooms.Set (BUSY_STREET, BusyStreet());
    Rooms.Set (LOBBY, Lobby());
    Rooms.Set (VISITORS_ROOM, VisitorsRoom());
    Rooms.Set (ANTE_ROOM, AnteRoom());
    Rooms.Set (PRESIDENTS_OFFICE, PresidentsOffice());
    Rooms.Set (SMALL_ROOM, SmallRoom());
    Rooms.Set (SOUND_PROOFED_CUBICLE, SoundProofedCubicle());
    Rooms.Set (SECURITY_OFFICE, SecurityOffice());
    Rooms.Set (SMALL_HALLWAY, SmallHallway());
    Rooms.Set (SHORT_CORRIDOR, ShortCorridor());
    Rooms.Set (METAL_HALLWAY, MetalHallway());
    Rooms.Set (PLAIN_ROOM, PlainRoom());
    Rooms.Set (MAINTENANCE_CLOSET, MaintenanceCloset());
    Rooms.Set (CAFETERIA, Cafeteria());
    Rooms.Set (SIDE_CORRIDOR, SideCorridor());
    Rooms.Set (POWER_GENERATOR_ROOM, PowerGeneratorRoom());
    Rooms.Set (SUB_BASEMENT, SubBasement());
    Rooms.Set (SECRET_COMPLEX, SecretComplex());
    Rooms.Set (MONITORING_ROOM, MonitoringRoom());
    Rooms.Set (LEDGE, Ledge());
    Rooms.Set (OTHER_SIDE, OtherSide());
    Rooms.Set (LONG_CORRIDOR, LongCorridor());
    Rooms.Set (LARGE_ROOM, LargeRoom());
    Rooms.Set (LABORATORY, Laboratory());
    Rooms.Set (CROSS_CORRIDOR, CrossCorridor());
    Rooms.Set (CROSS_EXAMINATION_ROOM, CrossExaminationRoom());
    Rooms.Set (BATHROOM, Bathroom());
    Rooms.Set (CHIEFS_OFFICE, ChiefsOffice());
    Rooms.Set (CHAOS_CONTROL_ROOM, ChaosControlRoom());
    Rooms.Set (END_OF_COMPLEX, EndOfComplex());
end

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

/// IN A SMALL BATHROOM
///
class Bathroom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SMALL BATHROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  CHIEFS_OFFICE);
        this.Exits.Set(WEST,  0);
    end
end

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

/// IN A CAFETERIA
///
class Cafeteria (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A CAFETERIA';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, SMALL_HALLWAY);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  0);
    end
end

/// IN THE CHAOS CONTROL ROOM
///
class ChaosControlRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN THE CHAOS CONTROL ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  END_OF_COMPLEX);
        this.Exits.Set(WEST,  0);
    end
end

/// IN THE OFFICE OF THE CHIEF OF CHAOS
///
class ChiefsOffice (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN THE OFFICE OF THE CHIEF OF CHAOS';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, CROSS_EXAMINATION_ROOM);
        this.Exits.Set(SOUTH, END_OF_COMPLEX);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  BATHROOM);
    end
end

/// IN A NARROW CROSS CORRIDOR
///
class CrossCorridor (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A NARROW CROSS CORRIDOR';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, LONG_CORRIDOR);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  CHIEFS_OFFICE);
        this.Exits.Set(WEST,  LABORATORY);
    end
end

/// IN A CROSS EXAMINATION ROOM
///
class CrossExaminationRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A CROSS EXAMINATION ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, LARGE_ROOM);
        this.Exits.Set(SOUTH, CHIEFS_OFFICE);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  0);
    end
end

/// NEAR THE END OF THE COMPLEX
///
class EndOfComplex (Room);
begin
    constructor Init ();
    begin
        this.Description := 'NEAR THE END OF THE COMPLEX';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, CHIEFS_OFFICE);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  CHAOS_CONTROL_ROOM);
    end
end

/// IN A SECRET LABORATORY
///
class Laboratory (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SECRET LABORATORY';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  CROSS_CORRIDOR);
        this.Exits.Set(WEST,  0);
    end
end

/// IN A LARGE ROOM
///
class LargeRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A LARGE ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, CROSS_EXAMINATION_ROOM);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  LONG_CORRIDOR);
    end
end

/// ON A LEDGE IN FRONT OF A METAL PIT 1000'S OF FEET DEEP
///
class Ledge (Room);
begin
    constructor Init ();
    begin
        this.Description := 'ON A LEDGE IN FRONT OF A METAL PIT 1000''S OF FEET DEEP';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, SECRET_COMPLEX);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  0);
    end
end

/// IN THE LOBBY OF THE BUILDING
///
class Lobby (Room);
begin
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

/// IN A LONG CORRIDOR
///
class LongCorridor (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A LONG CORRIDOR';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, CROSS_CORRIDOR);
        this.Exits.Set(EAST,  LARGE_ROOM);
        this.Exits.Set(WEST,  OTHER_SIDE);
    end
end

/// IN A MAINTENANCE CLOSET
///
class MaintenanceCloset (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A MAINTENANCE CLOSET';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  CAFETERIA);
        this.Exits.Set(WEST,  0);
    end
end

/// IN A HALLWAY MADE OF METAL
///
class MetalHallway (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A HALLWAY MADE OF METAL';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  PLAIN_ROOM);
        this.Exits.Set(WEST,  SHORT_CORRIDOR);
    end
end

/// IN A SECRET MONITORING ROOM
///
class MonitoringRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SECRET MONITORING ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  SECRET_COMPLEX);
    end
end

/// ON THE OTHER SIDE OF THE PIT
///
class OtherSide (Room);
begin
    constructor Init ();
    begin
        this.Description := 'ON THE OTHER SIDE OF THE PIT';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  LONG_CORRIDOR);
        this.Exits.Set(WEST,  0);
    end
end

/// IN A SMALL PLAIN ROOM
///
class PlainRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SMALL PLAIN ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, SOUND_PROOFED_CUBICLE);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  METAL_HALLWAY);
    end
end

/// IN A POWER GENERATOR ROOM
///
class PowerGeneratorRoom (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A POWER GENERATOR ROOM';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  SIDE_CORRIDOR);
    end
end

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

/// IN THE ENTRANCE TO THE SECRET COMPLEX
///
class SecretComplex (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN THE ENTRANCE TO THE SECRET COMPLEX';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, LEDGE);
        this.Exits.Set(EAST,  MONITORING_ROOM);
        this.Exits.Set(WEST,  SUB_BASEMENT);
    end
end

/// IN A SECURITY OFFICE
///
class SecurityOffice (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SECURITY OFFICE';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  SMALL_HALLWAY);
        this.Exits.Set(WEST,  0);
    end
end

/// IN A SHORT CORRIDOR
///
class ShortCorridor (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SHORT CORRIDOR';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, SIDE_CORRIDOR);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  SMALL_ROOM);
    end
end

/// IN A SIDE CORRIDOR
///
class SideCorridor (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SIDE CORRIDOR';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, SHORT_CORRIDOR);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  POWER_GENERATOR_ROOM);
        this.Exits.Set(WEST,  0);
    end
end

 /// IN A SMALL HALLWAY
///
class SmallHallway (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SMALL HALLWAY';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, CAFETERIA);
        this.Exits.Set(EAST,  SMALL_ROOM);
        this.Exits.Set(WEST,  SECURITY_OFFICE);
    end
end

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

/// IN A SMALL SOUND PROOFED CUBICLE
///
class SoundProofedCubicle (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SMALL SOUND PROOFED CUBICLE';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, PLAIN_ROOM);
        this.Exits.Set(EAST,  0);
        this.Exits.Set(WEST,  0);
    end
end

/// IN A SUB-BASEMENT BELOW THE CHUTE
///
class SubBasement (Room);
begin
    constructor Init ();
    begin
        this.Description := 'IN A SUB-BASEMENT BELOW THE CHUTE';
       
        this.Exits := Array(4) as Array;
        this.Exits.Set(NORTH, 0);
        this.Exits.Set(SOUTH, 0);
        this.Exits.Set(EAST,  SECRET_COMPLEX);
        this.Exits.Set(WEST,  0);
    end
end

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