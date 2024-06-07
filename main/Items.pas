/// Item
///
class Item;
var
    Description : String;
    Keyword     : String;
    Location    : Integer;

begin
    constructor Init (Description : String, Keyword : String, Location : Integer);
    begin
        this.Description := Description;
        this.Keyword := Keyword;
        this.Location := Location; 
    end
end

var Items : Array := Array(53) as Array;

// Add Item prototypes.
//
procedure AddItems();
begin
    Items.Set (BADGE, Badge());
    Items.Set (BUILDING, Building());
    Items.Set (SCULPTURE, Sculpture());
    Items.Set (SLIDING_DOORS, SlidingDoors());
    Items.Set (RECORDER, Recorder());
    Items.Set (LOCKED_WOODEN_DOOR, LockedWoodenDoor());
    Items.Set (OPEN_WOODEN_DOOR, OpenWoodenDoor());
    Items.Set(PAPER_WEIGHT, PaperWeight());
    Items.Set(MAHOGANY_DESK, MohoganyDesk());
    Items.Set(MAHOGANY_DRAWER, MohoganyDrawer());
    Items.Set(SPIRAL_NOTEBOOK, SpiralNotebook());
    Items.Set(BATTERY, BatteryItem());
    Items.Set(CREDIT_CARD, CreditCard());
    Items.Set(QUARTER, Quarter());

    Items.Set(PANEL, PanelOfButtons());
    Items.Set(ONE, ButtonOne());
    Items.Set(TWO, ButtonTwo());
    Items.Set(THREE, ButtonThree());

    Items.Set(TAPE, Tape());
    Items.Set(LOCK, Lock());
    Items.Set(SOLID_DOOR, SolidDoor());
    Items.Set(OPEN_DOOR, OpenDoor());
    Items.Set(ALERT_GUARD, AlertGuard());
    Items.Set(SLEEPING_GUARD, SleepingGuard());
    Items.Set(LOCKED_CLOSET, LockedCloset());
    Items.Set(CLOSET,  MaintenanceClosetItem());
    Items.Set(PLASTIC_BAG, PlasticBag());
    Items.Set(ANTIQUE_KEY, AntiqueKey());
    Items.Set(METAL_SQUARE, MetalSquare());
    Items.Set(LEVER, Lever());
    Items.Set(BROOM, Broom());
    Items.Set(DUSTPAN, Dustpan());
    Items.Set(GLASS_CASE, GlassCase());
    Items.Set(RAZOR_BLADE, RazorBlade());
    Items.Set(RUBY, Ruby());
    Items.Set(SIGN, Sign());
    Items.Set(COFFEE_MACHINE, CoffeeMachine());
    Items.Set(CUP_OF_COFFEE, CupOfCoffee());
    Items.Set(CAPSULE, Capsule());
    Items.Set(BUTTON, Button());
    Items.Set(ROPE, Rope());
    Items.Set(HOOK, Hook());
    Items.Set(TELEVISION, Television());
    Items.Set(PEDISTAL_MONITOR, PedistalMonitor());
    Items.Set(ID_CARD, IdCard());
    Items.Set(MONITORS, Monitors());
    Items.Set(PAINTING, Painting());
    Items.Set(GLOVES, Gloves());
    Items.Set(BOX, Box());
    Items.Set(SLIT, Slit());

    Items.Set(SLIDING_DOORS_BUTTON, SlidingDoorsButton());
    Items.Set(BOX_BUTTON,           BoxButton());
end

/// A C.I.A. IDENTIFICATION BADGE
///
class Badge (Item);
begin
    /// Creates instance.
    // 
    constructor Init ();
    begin       
        this.Description := 'A C.I.A. IDENTIFICATION BADGE';
        this.Keyword     := 'BAD';
        this.Location    := INVENTORY;
    end
end

/// A LARGE BATTERY
///
class BatteryItem (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A LARGE BATTERY';
        this.Keyword     := 'BAT';
        this.Location    := 0;

        this.Mock := Nil;
    end

    // INSERT BATTERY into RECORDER.
    //
    function Insert() : ResultType;
    var 
        Item : Integer;

    begin
        Item := GetIndirectObject(Mock);
            
        if Item = RECORDER then 
        begin
            WriteLn('O.K.');
            Items[RECORDER].BatteryFlag := On;
            Items[BATTERY].Location := 0;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

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

function GetIndirectObject(Mock : Integer) : Integer;
begin
    if Mock <> Nil then Exit Mock as Integer;
    
    var IndirectObject := ReadLn ('TELL ME, IN ONE WORD, INTO WHAT? ') as String;
    Exit FindItemID (Copy(IndirectObject, 0, 3));
end

function GetIndirectObjectAt(Mock : String) : String;
begin
    if Mock <> Nil then Exit Mock as String;
    
    var IndirectObject := ReadLn ('TELL ME, IN ONE WORD, AT WHAT? ') as String;
    Exit Copy(IndirectObject, 0, 3);
end

/// A BLANK CREDIT CARD
///
class CreditCard (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A BLANK CREDIT CARD';
        this.Keyword     := 'CAR';
        this.Location    := 0;
        
        this.Mock := Nil;
    end

    // INSERT CREDIT CARD into SLIT.
    //
    function Insert() : ResultType;
    var 
        Item : Integer;

    begin
        Item := GetIndirectObject(Mock);
            
        if Item = SLIT and DrugCounter <= 0 then
        begin
            WriteLn ('THE GUARD WON''T LET ME!');
            Exit Handled;
        end

        if Item = SLIT then 
        begin 
            WriteLn('POP! A SECTION OF THE WALL OPENS.....');
            WriteLn('REVEALING SOMETHING VERY INTERESTING.');
            Items[CREDIT_CARD].Location := 0;
            Items[LOCK].Location := Location;
            Exit Handled;
        end

        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// AN OLD MAHOGANY DESK
///
class MohoganyDesk (Item);
begin
    constructor Init ();
    begin
        this.Description := 'AN OLD MAHOGANY DESK';
        this.Keyword     := 'DES';
        this.Location    := PRESIDENTS_OFFICE;

        this.Fixed := True;
    end

    /// LOOK at DESK
    ///
    function Look() : ResultType;
    begin
       WriteLn('I CAN SEE A LOCKED DRAWER IN IT.');
       Exit Handled;
    end
end

/// A MAHOGANY DRAWER
///
class MohoganyDrawer (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A MAHOGANY DRAWER';
        this.Keyword     := 'DRA';
        this.Location    := PRESIDENTS_OFFICE;

        this.Fixed := True;
        this.Hidden := True;
    end

    /// LOOK at DRAWER
    ///
    function Look() : ResultType;
    begin
        WriteLn ('IT LOOKS FRAGILE.');
        Exit Handled;
    end

    /// OPEN the DRAWER
    ///
    function Open() : ResultType;
    begin
       WriteLn('IT''S STUCK.');
       Exit Handled;
    end

    /// BREAK the DRAWER
    ///
    function DoBreak() : ResultType;
    begin
        if Items[PAPER_WEIGHT].Location <> INVENTORY then
        begin
           WriteLn('I CAN''T DO THAT YET.');
           Exit Handled;
        end

        if Location = PRESIDENTS_OFFICE then
        begin
            WriteLn ('IT''S HARD....BUT I GOT IT. TWO THINGS FELL OUT.');
            Items[BATTERY].Location := Location;
            Items[SPIRAL_NOTEBOOK].Location := Location;
            
            Hidden := False;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENS.');
        Exit Passed;
    end
end

// Moves the elevator
//
procedure Elevator (TheFloor : Integer);
begin
    Floor := TheFloor as Integer;
    WriteLn('THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    WriteLn('SUDDENLY THE DOORS OPEN AGAIN.');
    Pause (1000);
end

/// A PANEL OF BUTTONS NUMBERED ONE THRU THREE
///
class PanelOfButtons (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A PANEL OF BUTTONS NUMBERED ONE THRU THREE';
        this.Keyword     := 'PAN';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
    end
end

/// Button One on Panel
///
class ButtonOne (Item);
begin
    constructor Init ();
    begin
        this.Description := 'ONE';
        this.Keyword     := 'ONE';
        this.Location    := SMALL_ROOM;

        this.Fixed  := True;
        this.Hidden := True;
    end

    function Push() : ResultType;
    begin
        if Floor <> 1 then 
        begin
            Rooms[SMALL_ROOM].Exits.Set(0, LOBBY);
            Elevator (1);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// Button Two on Panel
///
class ButtonTwo (Item);
begin
    constructor Init ();
    begin
        this.Description := 'TWO';
        this.Keyword     := 'TWO';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
        this.Hidden := True;
    end

    function Push() : ResultType;
    begin
        if Floor <> 2 then 
        begin
            Rooms[SMALL_ROOM].Exits.Set(0, SMALL_HALLWAY);
            Elevator (2);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// Button Three on Panel
///
class ButtonThree (Item);
begin
    constructor Init ();
    begin
        this.Description := 'THR';
        this.Keyword     := 'THR';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
        this.Hidden := True;
    end

    function Push() : ResultType;
    begin
        if Floor <> 3 then 
        begin
            Rooms[SMALL_ROOM].Exits.Set(0, SHORT_CORRIDOR);
            Elevator (3);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// AN ELABORATE PAPER WEIGHT
///
class PaperWeight (Item);
begin
    constructor Init ();
    begin
        this.Description := 'AN ELABORATE PAPER WEIGHT';
        this.Keyword     := 'WEI';
        this.Location    := PRESIDENTS_OFFICE;
    end

    /// LOOK at WEIGHT
    ///
    function Look() : ResultType;
    begin
        WriteLn('IT LOOKS HEAVY.');
        Exit Handled;     
    end
end

/// A QUARTER
///
class Quarter (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A QUARTER';
        this.Keyword     := 'QUA';
        this.Location    := 0;

        this.Mock := Nil;
    end

    // INSERT QUARTER into COFFEE MACHINE.
    //
    function Insert() : ResultType;
    var 
        Item : Integer;

    begin
        Item := GetIndirectObject(Mock);

        if Item = COFFEE_MACHINE then 
        begin
            WriteLn ('POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
            Items[QUARTER].Location := 0;
            Items[CUP_OF_COFFEE].Location := Location;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// A VIDEO CASSETTE RECORDER
///
class Recorder (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A VIDEO CASSETTE RECORDER';
        this.Keyword     := 'REC';
        this.Location    := VISITORS_ROOM;

        this.Fixed := True;
        
        this.TelevisionFlag := Off;
        this.BatteryFlag    := Off;
        this.TapeFlag       := Off;

    end

    /// LOOK at RECORDER
    ///
    function Look() : ResultType;
    begin
        if BatteryFlag = Off then
        begin
            WriteLn ('THERE''S NO POWER FOR IT.');
            Exit Handled;     
        end

        if TelevisionFlag <> On then
        begin
            WriteLn ('THERE''S NO T.V. TO WATCH ON.');
            Exit Handled;
        end      
    end

    // START the RECORDER.
    //
    function Start() : ResultType;
    begin
        if BatteryFlag = On and TelevisionFlag = On and TapeFlag = On then
        begin
            WriteLn ('THE RECORDER STARTS UP AND PRESENTS A SHORT MESSAGE:');
            WriteLn (Name);
            WriteLn ('WE HAVE UNCOVERED A NUMBER THAT MAY HELP YOU.');
            WriteLn ('THAT NUMBER IS:' + Code + '. PLEASE WATCH OUT FOR HIDDEN TRAPS.');
            WriteLn ('ALSO, THERE IS SOMETHING IN THE SCULPTURE.');
            Items[SCULPTURE].Flag := On;
            Exit Handled;
        end   
        WriteLn('NOTHING HAPPENED.');
        Exit Passed;
    end
end

/// A LARGE SCULPTURE
///
class Sculpture (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A LARGE SCULPTURE';
        this.Keyword     := 'SCU';
        this.Location    := LOBBY;

        this.Fixed    := True;
        this.Openable := True;
        this.Flag     := Off;
    end

    // Opening this SCULPTURE spawns a QUARTER and a CREDIT CARD.
    //
    function Open() : ResultType;
    begin
        if Items[QUARTER].Location = 0 and Items[CREDIT_CARD].Location = 0 and Flag = On then
        begin
            WriteLn('I OPEN THE SCULPTURE.');
            WriteLn('SOMETHING FALLS OUT.');
            
            Items[QUARTER].Location := Location;
            Items[CREDIT_CARD].Location := Location;
            Exit Handled;
        end 
        Exit Passed;
    end   
end

/// A PAIR OF SLIDING DOORS
///
class SlidingDoors (Item);
begin
    /// Creates instance.
    // 
    constructor Init ();
    begin
        this.Description := 'A PAIR OF SLIDING DOORS';
        this.Keyword     := 'DOO';
        this.Location    := LOBBY;

        this.Fixed := True;
        this.State := Closed;
    end
        
    // GO to SLIDING DOOR leads to SMALL ROOM, if door is open.
    //
    function Go () : ResultType;
    begin
        if State = Opened then 
        begin
            Location := SMALL_ROOM;
            Exit Handled;
        end
        Exit Passed;
    end  

    function Look () : ResultType;
    begin
        if State = Opened then
        begin 
            WriteLn('THE DOORS ARE OPEN.');
            Exit Handled;
        end

        if State = Closed then
        begin 
            WriteLn('THERE''S A BUTTON NEAR THE DOORS.');
            Exit Handled;
        end
        Exit Passed;   
    end 
end

/// BUTTON near SLIDING DOORS
///
class SlidingDoorsButton (Item);
begin
    constructor Init ();
    begin
        this.Description := 'NOTHING TO SEE HERE!';
        this.Keyword     := 'BUT';
        this.Location    := LOBBY;

        this.Fixed := True;
        this.Hidden := True;
        this.Flag   := Off;
    end
        
    // PUSH BUTTON, yeah!!!
    //
    function Push () : ResultType;
    begin
        if Items[SLIDING_DOORS].State = Closed then
        begin
            WriteLn('THE DOORS OPEN WITH A WHOOSH!');
            Items[SLIDING_DOORS].State := Opened;
            Flag := On;
            Exit Handled;
        end
        Exit Passed;
    end    
end

/// A SPIRAL NOTEBOOK
///
class SpiralNotebook (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A SPIRAL NOTEBOOK';
        this.Keyword     := 'NOT';
        this.Location    := 0;
    end

    /// LOOK at NOTEBOOK
    ///
    function Look() : ResultType;
    begin
        WriteLn ('THERE''S WRITING ON IT.');
        Exit Handled;    
    end

    /// READ the NOTEBOOK
    ///
    function Read() : ResultType;
    begin
        WriteLn ('IT SAYS:');
        WriteLn (Name + ',');
        WriteLn ('  WE HAVE DISCOVERED ONE OF CHAOSES SECRET WORDS.');
        WriteLn ('IT IS: BOND-007- .TO BE USED IN A -TASTEFUL- SITUATION.');
        Exit Handled;
    end
end

/// A LOCKED WOODEN DOOR
///
class LockedWoodenDoor (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A LOCKED WOODEN DOOR';
        this.Keyword     := 'DOO';
        this.Location    := ANTE_ROOM;

        this.Fixed := True;
        this.Openable := True;
    end

    // LOOK at DOOR shows it's locked.
    //
    function Look() : ResultType;
    begin
        WriteLn ('IT''S LOCKED.');
        Exit Handled;
    end 

    // OPEN then DOOR if ANTIQUE KEY in INVENTORY.
    //
    function Open() : ResultType;
    begin
        if Items[ANTIQUE_KEY].Location = INVENTORY then
        begin
            WriteLn ('O.K. I OPENED THE DOOR.');
            Items[LOCKED_WOODEN_DOOR].Location := 0;
            Items[OPEN_WOODEN_DOOR].Location := ANTE_ROOM;
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// A OPEN WOODEN DOOR
///
class OpenWoodenDoor (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A OPEN WOODEN DOOR';
        this.Keyword     := 'DOO';
        this.Location    := 0;

        this.Fixed := True;
    end

    // GO to DOOR should lead to PRESIDENTS_OFFICE.
    //
    function Go() : ResultType;
    begin
        Location := PRESIDENTS_OFFICE;
        Exit Handled;
    end   
end


/// A VIDEO TAPE
///
class Tape (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A VIDEO TAPE';
        this.Keyword     := 'TAP';
        this.Location    := 0;

        this.Mock := Nil;
    end

    // INSERT TAPE into RECORDER.
    //
    function Insert() : ResultType;
    var 
        Item : Integer;

    begin
        Item := GetIndirectObject(Mock);
            
        if Item = RECORDER then 
        begin
            WriteLn ('O.K. THE TAPE IS IN THE RECORDER.');
            Items[TAPE].Location := 0;
            Items[RECORDER].TapeFlag := On;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// AN ELECTRONIC LOCK
///
class Lock (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'AN ELECTRONIC LOCK';
        this.Keyword     := 'LOC';
        this.Location    := 0;

        this.Fixed := True;
    end

    function Open () : ResultType;
    begin
        var Input := ReadLn ('WHATS THE COMBINATION? ');
        if Input = Code then
        begin
            WriteLn ('THE DOOR IS SLOWLY OPENING.');
            Items[LOCK].Location := 0;
            Items[SOLID_DOOR].Location := 0;
            Items[OPEN_DOOR].Location := 10;
            Exit Handled;
        end
        WriteLn ('YOU MUST HAVE THE WRONG COMBINATION OR YOU ARE NOT');
        WriteLn ('SAYING IT RIGHT.');
        Exit Handled;
    end
end

/// A SOLID LOOKING DOOR
///
class SolidDoor (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A SOLID LOOKING DOOR';
        this.Keyword     := 'DOO';
        this.Location    := SHORT_CORRIDOR;

        this.Fixed := True;
    end

    function Look () : ResultType;
    begin
        WriteLn('THERE IS A SMALL SLIT NEAR THE DOOR.');
        Exit Handled;        
    end

    function Open () : ResultType;
    begin
        WriteLn ('I CAN''T. IT DOESNT WORK.');
        Exit Handled; 
    end
end

/// AN OPEN DOOR
///
class OpenDoor (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'AN OPEN DOOR';
        this.Keyword     := 'DOO';
        this.Location    := 0;

        this.Fixed := True;
    end

    // GO to DOOR leads to METAL HALLWAY
    //
    function Go () : ResultType;
    begin
        Location := METAL_HALLWAY;
        Exit Handled;
    end
end


/// AN ALERT SECURITY GUARD
///
class AlertGuard (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'AN ALERT SECURITY GUARD';
        this.Keyword     := 'GUA';
        this.Location    := SHORT_CORRIDOR;

        this.Fixed := True;
    end
end

/// A SLEEPING SECURITY GUARD
///
class SleepingGuard (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A SLEEPING SECURITY GUARD';
        this.Keyword     := 'GUA';
        this.Location    := 0;

        this.Fixed := True;
    end
end

/// A LOCKED MAINTENANCE CLOSET
///
class LockedCloset (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A LOCKED MAINTENANCE CLOSET';
        this.Keyword     := 'CLO';
        this.Location    := CAFETERIA;

        this.Fixed := True;
    end

    function Open () : ResultType;
    begin
        if Items[ANTIQUE_KEY].Location = INVENTORY then 
        begin
            WriteLn ('O.K. THE CLOSET IS OPENED.');
            Items[LOCKED_CLOSET].Location := 0;
            Items[CLOSET].Location := 14;
            Exit Handled;
        end 
        Exit Passed;       
    end
end

/// A MAINTENANCE CLOSET
///
class MaintenanceClosetItem (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A MAINTENANCE CLOSET';
        this.Keyword     := 'CLO';
        this.Location    := 0;

        this.Fixed := True;
    end

    function Go () : ResultType;
    begin
        Location := MAINTENANCE_CLOSET;
        Exit Handled;
    end
end

/// A PLASTIC BAG
///
class PlasticBag (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A PLASTIC BAG';
        this.Keyword     := 'BAG';
        this.Location    := MAINTENANCE_CLOSET;
    end

    function Look () : ResultType;
    begin
        WriteLn ('IT''S A VERY STRONG BAG.');
        Exit Handled;
    end

    // OPEN the PLASTIC BAG.
    //
    function Open () : ResultType;
    begin
        WriteLn ('I CAN''T. IT''S TOO STRONG.');
        Exit Handled;
    end

    // CUT the PLASTIC BAG
    //
    function Cut () : ResultType;
    begin
        if Items[RAZOR_BLADE].Location <> INVENTORY then
        begin
            WriteLn ('I CAN''T DO THAT YET.');
            Exit Handled;
        end

        WriteLn('RIP! THE BAG GOES TO PIECES, AND SOMETHING FALLS OUT!');
        Items[PLASTIC_BAG].Location := 0;
        Items[TAPE].Location := Location;
        Exit Handled;       
    end
end

/// AN OLDE FASHIONED KEY
///
class AntiqueKey (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'AN OLDE FASHIONED KEY';
        this.Keyword     := 'KEY';
        this.Location    := SMALL_ROOM;
    end
end

/// A SMALL METAL SQUARE ON THE WALL
///
class MetalSquare (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A SMALL METAL SQUARE ON THE WALL';
        this.Keyword     := 'SQU';
        this.Location    := POWER_GENERATOR_ROOM;

        this.Fixed := True;
    end

    // PUSH METAL SQUARE without GLOVES leads to death!
    //
    function Push () : ResultType;
    begin
        if Items[GLOVES].State <> Wearing then
        begin
            WriteLn('THERE''S ELECTRICITY COURSING THRU THE SQUARE!');
            WriteLn('I''M BEING ELECTROCUTED!');
            Die ();
            Exit Handled;
        end
        Exit Passed;
    end
end

/// A LEVER ON THE SQUARE
///
class Lever (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A LEVER ON THE SQUARE';
        this.Keyword     := 'LEV';
        this.Location    := POWER_GENERATOR_ROOM;

        this.Fixed := True;
    end

    function Pull () : ResultType;
    begin
        if Items[GLOVES].State <> Wearing then
        begin
            WriteLn('THE LEVER HAS ELECTRICITY COURSING THRU IT!');
            WriteLn('I''M BEING ELECTROCUTED!');
            Die ();
            Exit Handled;
        end

        if ElectricyFlag = On then
        begin
            WriteLn ('THE LEVER GOES ALL THE WAY UP AND CLICKS.');
            WriteLn ('SOMETHING SEEMS DIFFERENT NOW.');
            ElectricyFlag := Off;
            Exit Handled;
        end
        Exit Passed;
    end
end

/// A BROOM
///
class Broom (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A BROOM';
        this.Keyword     := 'BRO';
        this.Location    := MAINTENANCE_CLOSET;
    end
end

/// A DUSTPAN
///
class Dustpan (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A DUSTPAN';
        this.Keyword     := 'DUS';
        this.Location    := MAINTENANCE_CLOSET;
    end
end

/// A GLASS CASE ON A PEDESTAL
///
class GlassCase (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A GLASS CASE ON A PEDESTAL';
        this.Keyword     := 'CAS';
        this.Location    := SOUND_PROOFED_CUBICLE;

        this.Fixed := True;
    end

    // LOOK at CASE.
    //
    function Look () : ResultType;
    begin
        WriteLn ('I CAN SEE A GLEAMING STONE IN IT.');
        Exit Handled;        
    end

    // CUT the GLASS CASE
    //
    function Cut () : ResultType;
    begin
        if Items[RAZOR_BLADE].Location <> INVENTORY then
        begin
            WriteLn ('I CAN''T DO THAT YET.');
            Exit Handled;
        end

        WriteLn ('I CUT THE CASE AND REACH IN TO PULL SOMETHING OUT.');
        Items[RUBY].Location := INVENTORY;
        Exit Handled;
    end
end

/// A RAZOR BLADE
///
class RazorBlade (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A RAZOR BLADE';
        this.Keyword     := 'BLA';
        this.Location    := BATHROOM;
    end
end

/// A VERY LARGE RUBY
///
class Ruby (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A VERY LARGE RUBY';
        this.Keyword     := 'RUB';
        this.Location    := 0;
    end
end

/// A SIGN ON THE SQUARE
///
class Sign (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A SIGN ON THE SQUARE';
        this.Keyword     := 'SIG';
        this.Location    := POWER_GENERATOR_ROOM;
    end

    // LOOK at SIGN.
    //
    function Look () : ResultType;
    begin
        WriteLn ('THERE''S WRITING ON IT.');
        Exit Handled;   
    end
    
    // READ the SIGN
    //
    function Read () : ResultType;
    begin
        WriteLn ('IT SAYS: WATCH OUT! DANGEROUS!');
        Exit Handled;
    end
end

/// A COFFEE MACHINE
///
class CoffeeMachine (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A COFFEE MACHINE';
        this.Keyword     := 'MAC';
        this.Location    := SMALL_HALLWAY;

        this.Fixed := True;
    end
end

/// A CUP OF STEAMING HOT COFFEE
///
class CupOfCoffee (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A CUP OF STEAMING HOT COFFEE';
        this.Keyword     := 'CUP';
        this.Location    := 0;

        this.IsDrugged := False;
    end

    function Drop () : ResultType;
    begin
        WriteLn ('I DROPPED THE CUP BUT IT BROKE INTO SMALL PEICES.');
        WriteLn ('THE COFFEE SOAKED INTO THE GROUND.');
        
        var CupOfCoffee := Items[CUP_OF_COFFEE];
        CupOfCoffee.Location := 0;
        CupOfCoffee.IsDrugged := False;

        Exit Handled;
    end
end

/// A SMALL CAPSULE
///
class Capsule (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A SMALL CAPSULE';
        this.Keyword     := 'CAP';
        this.Location    := 0;
    end

    function Drop () : ResultType;
    begin
        if Items[CUP_OF_COFFEE].Location = INVENTORY then
        begin
            WriteLn ('O.K. I DROPPED IT.');
            WriteLn ('BUT IT FELL IN THE COFFEE!');
            Items[CAPSULE].Location := 0; 
            Items[CUP_OF_COFFEE].IsDrugged := True;
            
            Exit Handled;
        end
        Exit Passed;
    end
end

/// A LARGE BUTTON ON THE WALL
///
class Button (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A LARGE BUTTON ON THE WALL';
        this.Keyword     := 'BUT';
        this.Location    := CHAOS_CONTROL_ROOM;

        this.Flag := Off;
    end

    /// PUSH BUTTON turns on BUTTON??
    //
    function Push () : ResultType;
    begin
        if this.Flag = Off then
        begin
            WriteLn('THE BUTTON ON THE WALL GOES IN .....');
            WriteLn('CLICK! SOMETHING SEEMS DIFFFERENT NOW.');
            this.Flag := On;
            Exit Handled;
        end
        Exit Passed;
    end
end

/// A STRONG NYLON ROPE
///
class Rope (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A STRONG NYLON ROPE';
        this.Keyword     := 'ROP';
        this.Location    := SUB_BASEMENT;

        this.State := Default;
        this.Mock  := Nil;
    end

    // GO to the ROPE
    //
    function Go () : ResultType;
    begin
        if State = Connected and Location = LEDGE then 
        begin
            Location := OTHER_SIDE;
            Exit Handled;
        end
        Exit Passed;
    end

    // THROW the ROPE.
    //
    function Throw () : ResultType;
    begin
        if this.Location <> INVENTORY then
        begin
           WriteLn ('I CAN''T DO THAT YET.');
           Exit Handled;
        end
    
        var IndirectObject := GetIndirectObjectAt(Mock);
        if IndirectObject <> 'HOO' then
        begin
            WriteLn ('O.K. I THREW IT.');
            Items[ROPE].Location := Location;
            Exit Handled;
        end

        if Location <> LEDGE then
        begin
            WriteLn ('I CAN''T DO THAT YET.');
            Exit Handled;
        end

        WriteLn ('I THREW THE ROPE AND IT SNAGGED ON THE HOOK.');
        State := Connected;
        this.Location := Location;

        Exit Handled;
    end
end

/// A LARGE HOOK WITH A ROPE HANGING FROM IT
///
class Hook (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A LARGE HOOK WITH A ROPE HANGING FROM IT';
        this.Keyword     := 'HOO';
        this.Location    := OTHER_SIDE;
        
        this.Fixed := True;
    end
end

/// A PORTABLE TELEVISION
///
class Television (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A PORTABLE TELEVISION';
        this.Keyword     := 'TEL';
        this.Location    := SECURITY_OFFICE;
    end

    function Connect () : ResultType;
    begin
        if this.Location <> Location then 
        begin
            WriteLn ('I DON''T SEE THE TELEVISION HERE.');
            Exit Handled;
        end

        if Items[RECORDER].TelevisionFlag = On then
        begin
            WriteLn ('I DID THAT ALREADY.');
            Exit Handled;
        end
        
        if Location <> VISITORS_ROOM then 
        begin
            WriteLn ('I CAN''T DO THAT....YET!');
            Exit Handled;
        end

        WriteLn ('O.K. THE T.V. IS CONNECTED.');
        Items[RECORDER].TelevisionFlag := On;
        Exit Handled;
    end

    /// GET the TELEVISION disconnects it.
    procedure Event (Source : String);
    begin
       if Source = 'GET' then Items[RECORDER].TelevisionFlag := Off;
    end
end

/// A BANK OF MONITORS
///
class PedistalMonitor (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A BANK OF MONITORS';
        this.Keyword     := 'MON';
        this.Location    := SECURITY_OFFICE;
    end

    function Look () : ResultType;
    begin
        if Items[BUTTON].Flag = Off then
        begin
            WriteLn ('THE SCREEN IS DARK.');
            Exit Handled;
        end

        WriteLn ('I SEE A ROOM WITH A CASE ON A PEDESTAL IN IT.');
        Exit Handled;  
    end
end

/// A CHAOS I.D. CARD
///
class IdCard (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A CHAOS I.D. CARD';
        this.Keyword     := 'CAR';
        this.Location    := END_OF_COMPLEX;
    end
end

/// A BANK OF MONITORS
///
class Monitors (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A BANK OF MONITORS';
        this.Keyword     := 'MON';
        this.Location    := MONITORING_ROOM;
    end

    function Look () : ResultType;
    begin
        WriteLn('I SEE A METAL PIT 1000''S OF FEET DEEP ON ONE MONITOR.');
        WriteLn('ON THE OTHER SIDE OF THE PIT,I SEE A LARGE HOOK.');        
        Exit Handled;
    end
end

/// A SMALL PAINTING
///
class Painting (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A SMALL PAINTING';
        this.Keyword     := 'PAI';
        this.Location    := LARGE_ROOM;

        this.State := Default;
    end

    function Look () : ResultType;
    begin
       WriteLn ('I SEE A PICTURE OF A GRINNING JACKAL.');
       Exit Handled;
    end

    /// GET spawns a CAPSULE at the current location.
    ///
    procedure Event (Source : String);
    begin
        if Source = 'GET' and State <> Moved then 
        begin
            WriteLn ('SOMETHING FELL FROM THE FRAME!');
            Items[CAPSULE].Location := Location;
            State := Moved;
        end
    end
end

/// A PAIR OF RUBBER GLOVES
///
class Gloves (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A PAIR OF RUBBER GLOVES';
        this.Keyword     := 'GLO';
        this.Location    := MAINTENANCE_CLOSET;
    end
   
    // Stop wearing GLOVES if DROP.
    //
    function Drop () : ResultType;
    begin
        Items[GLOVES].State := Default;
        Exit Passed;
    end

    // WEAR the GLOVES.
    //
    function Wear () : ResultType;
    begin
        if this.Location = INVENTORY then
        begin
            WriteLn ('O.K. IM NOW WEARING THE GLOVES.');
            Items[GLOVES].State := Wearing;
            Exit Handled;
        end
    end
end

/// A BOX WITH A BUTTON ON IT
///
class Box (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A BOX WITH A BUTTON ON IT';
        this.Keyword     := 'BOX';
        this.Location    := LABORATORY;
    end
end

/// BUTTON on the BOX!
///
class BoxButton (Item);
begin
    constructor Init ();
    begin
        this.Description := 'NOTHING TO SEE HERE';
        this.Keyword     := 'BUT';
        this.Location    := GLOBAL;
    end

    function Push () : ResultType;
    begin
        if Items[BOX].Location = INVENTORY then
        begin
            WriteLn ('I PUSH THE BUTTON ON THE BOX AND');

            if Location=SOUND_PROOFED_CUBICLE OR Location=CHAOS_CONTROL_ROOM then
            begin
                WriteLn('THERE IS A BLINDING FLASH....');
                Pause (750);
                Location := BUSY_STREET;

                Floor := 1;
                Rooms[SMALL_ROOM].Exits.Set(0, LOBBY);
                DisplayRoom();
                Exit Handled;
            end
            WriteLn('NOTHING HAPPENS!');
            Exit Handled;
        end
        Exit Passed;
    end
end

/// SLIT
///
class Slit (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'NOTHING TO SEE HERE!';
        this.Keyword     := 'SLI';
        this.Location    := SHORT_CORRIDOR;

        this.Fixed := True;
        this.Hidden := True;
    end
end

