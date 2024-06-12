/// Room
///
class Room;
var
    Description : String;
    Exits       : Map;

begin
    /// Displays a Room.
    ///
    procedure Display(); 
    begin
        WriteLn('WE ARE ' + Description + '.');
        
        for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
        begin
            var Item := I.Next();

            var Hidden := Item.HasProperty ('Hidden') and Item.Hidden;
            if Item.Location = Location and not Hidden then WriteLn ('I CAN SEE ' + Item.Description + '.');
        end
        
        if Exits[North] or Exits[South] or Exits[East] or Exits[West] then
        begin
            Write('WE COULD EASILY GO: ');
            if Exits[North] then Write ('NORTH  ');
            if Exits[South] then Write ('SOUTH  ');
            if Exits[East] then Write ('EAST  ');
            if Exits[West] then Write ('WEST  ');
        end
        WriteLn (' ');
        WriteLn ('>--------------------------------------------------------------<');
    end

    procedure Event () ;
    begin
    end
end

procedure DisplayRoom();
begin
    Rooms[Location].Display();
end

object None (Room)
end

object Inventory (Room)
end

object Global (Room)
end

// IN A DINGY ANTE ROOM
///
object AnteRoom (Room)
    Description := 'IN A DINGY ANTE ROOM';
    Exits := [West: Lobby] as Map;
end

/// IN A SMALL BATHROOM
///
object Bathroom (Room)
    Description := 'IN A SMALL BATHROOM';
    Exits := [East: ChiefsOffice] as Map;
end

/// ON A BUSY STREET
///
object BusyStreet (Room)
    Description := 'ON A BUSY STREET';
    Exits := Map();

    /// Wins game if RUBY is in inventory!
    ///
    procedure Event ();
    begin
        if Items[Ruby].Location = Inventory then
        begin
           WriteLn ('HURRAY! YOU''VE RECOVERED THE RUBY!');
           WriteLn ('YOU WIN!');
           IsDone := True;
           Exit;   
        end
    end
end

/// IN A CAFETERIA
///
object Cafeteria (Room)
    Description := 'IN A CAFETERIA';
    Exits := [North: SmallHallway] as Map;
end

/// IN THE CHAOS CONTROL ROOM
///
object ChaosControlRoom (Room)
    Description := 'IN THE CHAOS CONTROL ROOM';      
    Exits := [East:  EndOfComplex] as Map;
end

/// IN THE OFFICE OF THE CHIEF OF CHAOS
///
object ChiefsOffice (Room)
    Description := 'IN THE OFFICE OF THE CHIEF OF CHAOS';
    Exits := [North: CrossExaminationRoom, South: EndOfComplex, West:Bathroom] as Map;
end

/// IN A NARROW CROSS CORRIDOR
///
object CrossCorridor (Room)
    Description := 'IN A NARROW CROSS CORRIDOR';
    Exits := [North: LongCorridor,East:ChiefsOffice,West:Laboratory] as Map;
end

/// IN A CROSS EXAMINATION ROOM
///
object CrossExaminationRoom (Room)
    Description := 'IN A CROSS EXAMINATION ROOM';      
    Exits := [North: LargeRoom, South: ChiefsOffice] as Map;
end

/// NEAR THE END OF THE COMPLEX
///
object EndOfComplex (Room)
    Description := 'NEAR THE END OF THE COMPLEX';
    Exits := [North: ChiefsOffice, West:  ChaosControlRoom] as Map;
end

/// IN A SECRET LABORATORY
///
object Laboratory (Room)
    Description := 'IN A SECRET LABORATORY';
    Exits := [East:  CrossCorridor] as Map;
end

/// IN A LARGE ROOM
///
object LargeRoom (Room)
    Description := 'IN A LARGE ROOM';
    Exits := [South: CrossExaminationRoom, West:  LongCorridor] as Map;
end

/// ON A LEDGE IN FRONT OF A METAL PIT 1000'S OF FEET DEEP
///
object Ledge (Room)
    Description := 'ON A LEDGE IN FRONT OF A METAL PIT 1000''S OF FEET DEEP';
    Exits := [North: SecretComplex] as Map;
end

/// IN THE LOBBY OF THE BUILDING
///
object Lobby (Room)
    Description := 'IN THE LOBBY OF THE BUILDING';
    Exits := [North: BusyStreet, East:  AnteRoom, West:  VisitorsRoom] as Map;

    // Door man kicks you out if you have BADGE.
    //
    procedure Event ();
    begin
        if Items[Badge].Location = Inventory then 
        begin
            WriteLn ('THE DOOR MAN LOOKS AT MY BADGE AND THEN THROWS ME OUT.');
            Pause (1000);
            MoveTo (BusyStreet);
            DisplayRoom();
        end
    end
end

/// IN A LONG CORRIDOR
///
object LongCorridor (Room)
    Description := 'IN A LONG CORRIDOR';
    Exits := [South: CrossCorridor, East: LargeRoom, West:  OtherSide] as Map;
end

/// IN A MAINTENANCE CLOSET
///
object MaintenanceCloset (Room)
    Description := 'IN A MAINTENANCE CLOSET';      
    Exits := [East:Cafeteria] as Map;
end

/// IN A HALLWAY MADE OF METAL
///
object MetalHallway (Room)
    Description := 'IN A HALLWAY MADE OF METAL';       
    Exits := [East: PlainRoom, West: ShortCorridor] as Map;
    
    procedure Event ();
    begin
        if ElectricyFlag = On then
        begin
            WriteLn ('THE FLOOR IS WIRED WITH ELECTRICITY!');
            WriteLn ('IM BEING ELECTROCUTED!');
            Die();
        end
    end
end

/// IN A SECRET MONITORING ROOM
///
object MonitoringRoom (Room)
    Description := 'IN A SECRET MONITORING ROOM';
    Exits := [West:  SecretComplex] as Map;
end

/// ON THE OTHER SIDE OF THE PIT
///
object OtherSide (Room)
    Description := 'ON THE OTHER SIDE OF THE PIT';
    Exits := [East:  LongCorridor] as Map;
end

/// IN A SMALL PLAIN ROOM
///
object PlainRoom (Room)
    Description := 'IN A SMALL PLAIN ROOM';    
    Exits := [North: SoundProofedCubicle, West:  MetalHallway] as Map;
end

/// IN A POWER GENERATOR ROOM
///
object PowerGeneratorRoom (Room)
    Description := 'IN A POWER GENERATOR ROOM';
    Exits := [West:  SideCorridor] as Map;
end

/// IN THE COMPANY PRESIDENTS OFFICE
///
object PresidentsOffice (Room)
    Description := 'IN THE COMPANY PRESIDENT''S OFFICE';
    Exits := [West: AnteRoom] as Map;
end

/// IN THE ENTRANCE TO THE SECRET COMPLEX
///
object SecretComplex (Room)
    Description := 'IN THE ENTRANCE TO THE SECRET COMPLEX';
    Exits := [East: MonitoringRoom, South: Ledge, West: SubBasement] as Map;
end

/// IN A SECURITY OFFICE
///
object SecurityOffice (Room)
    Description := 'IN A SECURITY OFFICE';
    Exits := [East: SmallHallway] as Map;
end

/// IN A SHORT CORRIDOR
///
object ShortCorridor (Room)
    Description := 'IN A SHORT CORRIDOR';
    Exits := [South: SideCorridor, West:  SmallRoom] as Map; 

    /// GUARD shoots you if Guns is True.
    ///
    procedure Event ();
    begin
        if Items[IdCard].Location <> Inventory then
        begin
            WriteLn('THE GUARD LOOKS AT ME SUSPICIOUSLY, THEN THROWS ME BACK.');
            Pause (750);
            Location := SmallRoom as Identifier;
            DisplayRoom();
            Exit;
        end

        if Guns then
        begin
            WriteLn ('THE GUARD DRAWS HIS GUN AND SHOOTS ME!');
            Die();
            Exit;
        end

        if Location = ShortCorridor and Items[CupOfCoffee].Location = Inventory and Items[CupOfCoffee].IsDrugged then
        begin
            WriteLn ('THE GUARD TAKES MY COFFEE');
            WriteLn ('AND FALLS TO SLEEP RIGHT AWAY.');
            DrugCounter := 5 + Random(0, 10);

            Items[AlertGuard].Swap (SleepingGuard);
            
            Items[CupOfCoffee].IsDrugged := False;
            Items[CupOfCoffee].Location := None as Identifier;
        end
    end
end

/// IN A SIDE CORRIDOR
///
object SideCorridor (Room)
    Description := 'IN A SIDE CORRIDOR';
    Exits := [North: ShortCorridor, East: PowerGeneratorRoom] as Map;
end

 /// IN A SMALL HALLWAY
///
object SmallHallway (Room)
    Description := 'IN A SMALL HALLWAY';    
    Exits := [South: Cafeteria, East: SmallRoom, West: SecurityOffice] as Map;
end

/// IN A SMALL ROOM
///
object SmallRoom (Room)
    Description := 'IN A SMALL ROOM';
    Exits := [North: Lobby] as Map;
end

/// IN A SMALL SOUND PROOFED CUBICLE
///
object SoundProofedCubicle (Room)
    Description := 'IN A SMALL SOUND PROOFED CUBICLE';
    Exits := [South: PlainRoom] as Map;

    // Door slams shut behind you.
    //
    procedure Event ();
    begin
        if Rooms[SoundProofedCubicle].Exits[South] then
        begin
            WriteLn ('A SECRET DOOR SLAMS DOWN BEHIND ME!');
            Rooms[SoundProofedCubicle].Exits.Remove(South);
        end
    end
end

/// IN A SUB-BASEMENT BELOW THE CHUTE
///
object SubBasement (Room)
    Description := 'IN A SUB-BASEMENT BELOW THE CHUTE';
    Exits := [East: SecretComplex] as Map;
end

/// IN A VISITORS ROOM
///
object VisitorsRoom (Room)
    Description := 'IN A VISITORS ROOM';
    Exits := [East: Lobby] as Map;
end