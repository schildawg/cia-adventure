/// Item
///
class Item;
var
    Description : String;
    Keyword     : String;
    Location    : Identifier;

begin
    /// Moves item to specified place.
    ///
    procedure MoveTo (Place);
    begin
        this.Location := Place as Identifier;
    end 

    /// Removes this item, and replaces it with another.
    ///
    procedure Swap(I : Identifier);
    begin
        Items[I].MoveTo(this.Location);
        
        this.Location := None as Identifier;
    end
end


/// A C.I.A. IDENTIFICATION BADGE
///
object Badge (Item)     
    Description := 'A C.I.A. IDENTIFICATION BADGE';
    Keyword     := 'BAD';
    Location    := Inventory;

    Order := 390;
end

/// A LARGE BATTERY
///
object BatteryItem (Item)
    Description := 'A LARGE BATTERY';
    Keyword     := 'BAT';
    Location    := None;

    Mock :=  Nil;
    Order := 30;

    // INSERT BATTERY into RECORDER.
    //
    function Insert() : ResultType;
    begin
        var Item := GetIndirectObject(Mock);
            
        if Item = Recorder then 
        begin
            WriteLn('O.K.');
            Items[Recorder].BatteryFlag := On;
            Items[BatteryItem].Location := None;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// A TALL OFFICE BUILDING
///
object Building (Item)
    Description := 'A TALL OFFICE BUILDING';
    Keyword     := 'BUI';
    Location    := BusyStreet;

    Fixed := True;
    Order := 330;

    // GO to BUILDING should lead to Lobby.
    //
    function Go() : ResultType;
    begin
        Location := Lobby;
        Exit Handled;
    end   
end

function GetIndirectObject(Mock : Identifier) : Identifier;
begin
    if Mock <> Nil then 
    begin 
        Exit Mock as Identifier;
    end

    var IndirectObject := ReadLn ('TELL ME, IN ONE WORD, INTO WHAT? ') as String;
    Exit FindItemID (Copy(IndirectObject, 0, 3));
end

function GetIndirectObjectAt(Mock : String) : String;
begin
    if Mock <> Nil then Exit Mock as String;
    
    var IndirectObject := ReadLn ('TELL ME, IN ONE WORD, AT WHAT? ') as String;
    Exit Copy(IndirectObject, 0, 3);
end

/// AN OLD MAHOGANY DESK
///
object MohoganyDesk (Item)
    Description := 'AN OLD MAHOGANY DESK';
    Keyword     := 'DES';
    Location    := PresidentsOffice;

    Fixed := True;
    Order := 190;

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
object MohoganyDrawer (Item)
    Description := 'A MAHOGANY DRAWER';
    Keyword     := 'DRA';
    Location    := PresidentsOffice;

    Fixed := True;
    Hidden := True;
    
    Order := 230;

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
        if Items[PaperWeight].Location <> Inventory then
        begin
           WriteLn('I CAN''T DO THAT YET.');
           Exit Handled;
        end

        if Location = PresidentsOffice then
        begin
            WriteLn ('IT''S HARD....BUT I GOT IT. TWO THINGS FELL OUT.');
            Items[BatteryItem].Location := Location;
            Items[SpiralNotebook].Location := Location;
            
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
object PanelOfButtons (Item)
    Description := 'A PANEL OF BUTTONS NUMBERED ONE THRU THREE';
    Keyword     := 'PAN';
    Location    := SmallRoom;

    Fixed := True;
    Order := 360;
end

/// Button One on Panel
///
object ButtonOne (Item)
    Description := 'ONE';
    Keyword     := 'ONE';
    Location    := SmallRoom;

    Fixed  := True;
    Hidden := True;

    Order := 470;

    function Push() : ResultType;
    begin
        if Floor <> 1 then 
        begin
            Rooms[SmallRoom].Exits.Put(North, Lobby);
            Elevator (1);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// Button Two on Panel
///
object ButtonTwo (Item)
    Description := 'TWO';
    Keyword     := 'TWO';
    Location    := SmallRoom;

    Fixed := True;
    Hidden := True;

    Order := 480;

    function Push() : ResultType;
    begin
        if Floor <> 2 then 
        begin
            Rooms[SmallRoom].Exits.Put(North, SmallHallway);
            Elevator (2);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// Button Three on Panel
///
object ButtonThree (Item)
    Description := 'THR';
    Keyword     := 'THR';
    Location    := SmallRoom;

    Fixed := True;
    Hidden := True;

    Order := 490;

    function Push() : ResultType;
    begin
        if Floor <> 3 then 
        begin
            Rooms[SmallRoom].Exits.Put(North, ShortCorridor);
            Elevator (3);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// AN ELABORATE PAPER WEIGHT
///
object PaperWeight (Item)
    Description := 'AN ELABORATE PAPER WEIGHT';
    Keyword     := 'WEI';
    Location    := PresidentsOffice;
    
    Order := 60;

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
object Quarter (Item)   
    Description := 'A QUARTER';
    Keyword     := 'QUA';
    Location    := None;

    Mock  := Nil;
    Order := 280;

    // INSERT QUARTER into COFFEE MACHINE.
    //
    function Insert() : ResultType;
    begin
        // FIXME: var section
        var Item := GetIndirectObject(Mock);

        if Item = CoffeeMachine then 
        begin
            WriteLn ('POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
            Items[Quarter].Location := None;
            Items[CupOfCoffee].Location := Location;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// A VIDEO CASSETTE RECORDER
///
object Recorder (Item)
    Description := 'A VIDEO CASSETTE RECORDER';
    Keyword     := 'REC';
    Location    := VisitorsRoom;

    Fixed := True;
    
    TelevisionFlag := Off;
    BatteryFlag    := Off;
    TapeFlag       := Off;

    Order := 10;

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
            Items[Sculpture].Flag := On;
            Exit Handled;
        end   
        WriteLn('NOTHING HAPPENED.');
        Exit Passed;
    end
end

/// A LARGE SCULPTURE
///
object Sculpture (Item)
    Description := 'A LARGE SCULPTURE';
    Keyword     := 'SCU';
    Location    := Lobby;

    Fixed    := True;
    Openable := True;
    Flag     := Off;
    
    Order := 320;

    // Opening this SCULPTURE spawns a QUARTER and a CREDIT CARD.
    //
    function Open() : ResultType;
    begin
        if Items[Quarter].Location = None and Items[CreditCard].Location = None and Flag = On then
        begin
            WriteLn('I OPEN THE SCULPTURE.');
            WriteLn('SOMETHING FALLS OUT.');
            
            Items[Quarter].Location := Location;
            Items[CreditCard].Location := Location;
            Exit Handled;
        end 
        Exit Passed;
    end   
end

/// A PAIR OF SLIDING DOORS
///
object SlidingDoors (Item)
    Description := 'A PAIR OF SLIDING DOORS';
    Keyword     := 'DOO';
    Location    := Lobby;

    Fixed := True;
    State := Closed;
    Order := 340;

    // GO to SLIDING DOOR leads to SMALL ROOM, if door is open.
    //
    function Go () : ResultType;
    begin
        if State = Opened then 
        begin
            Location := SmallRoom;
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
object SlidingDoorsButton (Item)
    Description := 'BUTTON NEAR SLIDING DOORS';
    Keyword     := 'BUT';
    Location    := Lobby;

    Fixed := True;
    Hidden := True;
    Flag   := Off;

    Order := 530;

    // PUSH BUTTON, yeah!!!
    //
    function Push () : ResultType;
    begin
        if Items[SlidingDoors].State = Closed then
        begin
            WriteLn('THE DOORS OPEN WITH A WHOOSH!');
            Items[SlidingDoors].State := Opened;
            Flag := On;
            Exit Handled;
        end
        Exit Passed;
    end    
end

/// A SPIRAL NOTEBOOK
///
object SpiralNotebook (Item)
    Description := 'A SPIRAL NOTEBOOK';
    Keyword     := 'NOT';
    Location    := None;
    
    Order := 220;

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
object LockedWoodenDoor (Item)
    Description := 'A LOCKED WOODEN DOOR';
    Keyword     := 'DOO';
    Location    := AnteRoom;

    Fixed := True;
    Openable := True;
    Order := 70;

    // LOOK at DOOR shows it's locked.
    //
    function Look() : ResultType;
    begin
        WriteLn ('IT''S LOCKED.');
        Exit Handled;
    end 

    // OPEN then DOOR if ANTIQUE KEY in Inventory.
    //
    function Open() : ResultType;
    begin
        if Items[AntiqueKey].Location = Inventory then
        begin
            WriteLn ('O.K. I OPENED THE DOOR.');
            Items[LockedWoodenDoor].Swap (OpenWoodenDoor);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// A OPEN WOODEN DOOR
///
object OpenWoodenDoor (Item)
    Description := 'A OPEN WOODEN DOOR';
    Keyword     := 'DOO';
    Location    := None;

    Fixed := True;
    Order := 80;

    // GO to DOOR should lead to PRESIDENTS_OFFICE.
    //
    function Go() : ResultType;
    begin
        Location := PresidentsOffice;
        Exit Handled;
    end   
end

/// A VIDEO TAPE
///
object Tape (Item)     
    Description := 'A VIDEO TAPE';
    Keyword     := 'TAP';
    Location    := None;

    Mock := Nil;
    Order := 20;

    // INSERT TAPE into RECORDER.
    //
    function Insert() : ResultType;
    begin
        var Item := GetIndirectObject(Mock);  
        if Item = Recorder then 
        begin
            WriteLn ('O.K. THE TAPE IS IN THE RECORDER.');
            Items[Tape].Location := None;
            Items[Recorder].TapeFlag := On;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// AN ELECTRONIC LOCK
///
object Lock (Item)     
    Description := 'AN ELECTRONIC LOCK';
    Keyword     := 'LOC';
    Location    := None;

    Fixed := True;
    Order := 50;

    function Open () : ResultType;
    begin
        var Input := ReadLn ('WHATS THE COMBINATION? ');
        if Input = Code then
        begin
            WriteLn ('THE DOOR IS SLOWLY OPENING.');
            Items[Lock].Location := None;
            Items[SolidDoor].Swap(OpenDoor);
            Exit Handled;
        end
        WriteLn ('YOU MUST HAVE THE WRONG COMBINATION OR YOU ARE NOT');
        WriteLn ('SAYING IT RIGHT.');
        Exit Handled;
    end
end

/// A SOLID LOOKING DOOR
///
object SolidDoor (Item)   
    Description := 'A SOLID LOOKING DOOR';
    Keyword     := 'DOO';
    Location    := ShortCorridor;

    Fixed := True;
    Order := 90;

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
object OpenDoor (Item)    
    Description := 'AN OPEN DOOR';
    Keyword     := 'DOO';
    Location    := None;

    Fixed := True;
    Order := 100;

    // GO to DOOR leads to METAL HALLWAY
    //
    function Go () : ResultType;
    begin
        MoveTo(MetalHallway);
        Exit Handled;
    end
end


/// AN ALERT SECURITY GUARD
///
object AlertGuard (Item)  
    Description := 'AN ALERT SECURITY GUARD';
    Keyword     := 'GUA';
    Location    := ShortCorridor;

    Fixed := True;
    Order := 110;
end

/// A SLEEPING SECURITY GUARD
///
object SleepingGuard (Item)   
    Description := 'A SLEEPING SECURITY GUARD';
    Keyword     := 'GUA';
    Location    := None;

    Fixed := True;
    Order := 120;
end

/// A LOCKED MAINTENANCE CLOSET
///
object LockedCloset (Item)    
    Description := 'A LOCKED MAINTENANCE CLOSET';
    Keyword     := 'CLO';
    Location    := Cafeteria;

    Fixed := True;
    Order := 130;

    function Open () : ResultType;
    begin
        if Items[AntiqueKey].Location = Inventory then 
        begin
            WriteLn ('O.K. THE CLOSET IS OPENED.');
            Items[LockedCloset].Swap(MaintenanceClosetItem);
            Exit Handled;
        end 
        Exit Passed;       
    end
end

/// A MAINTENANCE CLOSET
///
object MaintenanceClosetItem (Item)       
    Description := 'A MAINTENANCE CLOSET';
    Keyword     := 'CLO';
    Location    := None;

    Fixed := True;
    Order := 140;

    function Go () : ResultType;
    begin
        MoveTo(MaintenanceCloset);
        Exit Handled;
    end
end

/// A PLASTIC BAG
///
object PlasticBag (Item)    
    Description := 'A PLASTIC BAG';
    Keyword     := 'BAG';
    Location    := MaintenanceCloset;
    
    Order := 150; 
    
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
        if Items[RazorBlade].Location <> Inventory then
        begin
            WriteLn ('I CAN''T DO THAT YET.');
            Exit Handled;
        end

        WriteLn('RIP! THE BAG GOES TO PIECES, AND SOMETHING FALLS OUT!');
        Items[PlasticBag].Location := None;
        Items[Tape].Location := Location;
        Exit Handled;       
    end
end

/// AN OLDE FASHIONED KEY
///
object AntiqueKey (Item)     
    Description := 'AN OLDE FASHIONED KEY';
    Keyword     := 'KEY';
    Location    := SmallRoom;

    Order := 160;
end

/// A SMALL METAL SQUARE ON THE WALL
///
object MetalSquare (Item) 
    Description := 'A SMALL METAL SQUARE ON THE WALL';
    Keyword     := 'SQU';
    Location    := PowerGeneratorRoom;

    Fixed := True;
    Order := 170;

    // PUSH METAL SQUARE without GLOVES leads to death!
    //
    function Push () : ResultType;
    begin
        if Items[Gloves].State <> Wearing then
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
object Lever (Item)    
    Description := 'A LEVER ON THE SQUARE';
    Keyword     := 'LEV';
    Location    := PowerGeneratorRoom;

    Fixed := True;
    Order := 180;

    function Pull () : ResultType;
    begin
        if Items[Gloves].State <> Wearing then
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
object Broom (Item)      
    Description := 'A BROOM';
    Keyword     := 'BRO';
    Location    := MaintenanceCloset;
    
    Order := 200;
end

/// A DUSTPAN
///
object Dustpan (Item)     
    Description := 'A DUSTPAN';
    Keyword     := 'DUS';
    Location    := MaintenanceCloset;

    Order := 210;
end

/// A GLASS CASE ON A PEDESTAL
///
object GlassCase (Item)     
    Description := 'A GLASS CASE ON A PEDESTAL';
    Keyword     := 'CAS';
    Location    := SoundProofedCubicle;

    Fixed := True;
    Order := 240;

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
        if Items[RazorBlade].Location <> Inventory then
        begin
            WriteLn ('I CAN''T DO THAT YET.');
            Exit Handled;
        end

        WriteLn ('I CUT THE CASE AND REACH IN TO PULL SOMETHING OUT.');
        Items[Ruby].Location := Inventory;
        Exit Handled;
    end
end

/// A RAZOR BLADE
///
object RazorBlade (Item)     
    Description := 'A RAZOR BLADE';
    Keyword     := 'BLA';
    Location    := Bathroom;

    Order := 250;
end

/// A VERY LARGE RUBY
///
object Ruby (Item)    
    Description := 'A VERY LARGE RUBY';
    Keyword     := 'RUB';
    Location    := None;

    Order := 260;
end

/// A SIGN ON THE SQUARE
///
object Sign (Item)   
    Description := 'A SIGN ON THE SQUARE';
    Keyword     := 'SIG';
    Location    := PowerGeneratorRoom;

    Order := 270;

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
object CoffeeMachine (Item) 
    Description := 'A COFFEE MACHINE';
    Keyword     := 'MAC';
    Location    := SmallHallway;

    Fixed := True;
    Order := 290;
end

/// A CUP OF STEAMING HOT COFFEE
///
object CupOfCoffee (Item)   
    Description := 'A CUP OF STEAMING HOT COFFEE';
    Keyword     := 'CUP';
    Location    := None;

    IsDrugged := False;
    Order := 300;

    function Drop () : ResultType;
    begin
        WriteLn ('I DROPPED THE CUP BUT IT BROKE INTO SMALL PEICES.');
        WriteLn ('THE COFFEE SOAKED INTO THE GROUND.');
        
        var CupOfCoffee := Items[CupOfCoffee];
        CupOfCoffee.Location := None;
        CupOfCoffee.IsDrugged := False;

        Exit Handled;
    end
end

/// A SMALL CAPSULE
///
object Capsule (Item)     
    Description := 'A SMALL CAPSULE';
    Keyword     := 'CAP';
    Location    := None;
    
    Order := 310;

    function Drop () : ResultType;
    begin
        if Items[CupOfCoffee].Location = Inventory then
        begin
            WriteLn ('O.K. I DROPPED IT.');
            WriteLn ('BUT IT FELL IN THE COFFEE!');
            Items[Capsule].Location := None; 
            Items[CupOfCoffee].IsDrugged := True;
            
            Exit Handled;
        end
        Exit Passed;
    end
end

/// A LARGE BUTTON ON THE WALL
///
object Button (Item)   
    Description := 'A LARGE BUTTON ON THE WALL';
    Keyword     := 'BUT';
    Location    := ChaosControlRoom;
    
    Flag := Off;
    Order := 520;

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
object Rope (Item)
    Description := 'A STRONG NYLON ROPE';
    Keyword     := 'ROP';
    Location    := SubBasement;

    State := Default;
    Mock  := Nil;
    Order := 370;

    // GO to the ROPE
    //
    function Go () : ResultType;
    begin
        if State = Connected and Location = Ledge then 
        begin
            Location := OtherSide;
            Exit Handled;
        end
        Exit Passed;
    end

    // THROW the ROPE.
    //
    function Throw () : ResultType;
    begin
        if this.Location <> Inventory then
        begin
           WriteLn ('I CAN''T DO THAT YET.');
           Exit Handled;
        end
    
        var IndirectObject := GetIndirectObjectAt(Mock);
        if IndirectObject <> 'HOO' then
        begin
            WriteLn ('O.K. I THREW IT.');
            Items[Rope].Location := Location;
            Exit Handled;
        end

        if Location <> Ledge then
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
object Hook (Item)     
    Description := 'A LARGE HOOK WITH A ROPE HANGING FROM IT';
    Keyword     := 'HOO';
    Location    := OtherSide;
    
    Fixed := True;
    Order := 380;
end

/// A PORTABLE TELEVISION
///
object Television (Item)   
    Description := 'A PORTABLE TELEVISION';
    Keyword     := 'TEL';
    Location    := SecurityOffice;
    
    Order := 400;

    function Connect () : ResultType;
    begin
        if this.Location <> Location then 
        begin
            WriteLn ('I DON''T SEE THE TELEVISION HERE.');
            Exit Handled;
        end

        if Items[Recorder].TelevisionFlag = On then
        begin
            WriteLn ('I DID THAT ALREADY.');
            Exit Handled;
        end
        
        if Location <> VisitorsRoom then 
        begin
            WriteLn ('I CAN''T DO THAT....YET!');
            Exit Handled;
        end

        WriteLn ('O.K. THE T.V. IS CONNECTED.');
        Items[Recorder].TelevisionFlag := On;
        Exit Handled;
    end

    /// GET the TELEVISION disconnects it.
    procedure Event (Source : String);
    begin
       if Source = 'GET' then Items[Recorder].TelevisionFlag := Off;
    end
end

/// A BANK OF MONITORS
///
object PedistalMonitor (Item)      
    Description := 'A BANK OF MONITORS';
    Keyword     := 'MON';
    Location    := SecurityOffice;

    Order := 430;

    function Look () : ResultType;
    begin
        if Items[Button].Flag = Off then
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
object IdCard (Item)    
    Description := 'A CHAOS I.D. CARD';
    Keyword     := 'CAR';
    Location    := EndOfComplex;

    Order := 420;
end

/// A BLANK CREDIT CARD
///
object CreditCard (Item)     
    Description := 'A BLANK CREDIT CARD';
    Keyword     := 'CAR';
    Location    := None;
    
    Mock  := Nil;
    Order := 40;

    // INSERT CREDIT CARD into SLIT.
    //
    function Insert() : ResultType;
    begin
        var Item := GetIndirectObject(Mock);
            
        if Item = Slit and DrugCounter <= 0 then
        begin
            WriteLn ('THE GUARD WON''T LET ME!');
            Exit Handled;
        end

        if Item = Slit then 
        begin 
            WriteLn('POP! A SECTION OF THE WALL OPENS.....');
            WriteLn('REVEALING SOMETHING VERY INTERESTING.');
            Items[CreditCard].Location := None;
            Items[Lock].Location := Location;
            Exit Handled;
        end

        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

/// A BANK OF MONITORS
///
object Monitors (Item)   
    Description := 'A BANK OF MONITORS';
    Keyword     := 'MON';
    Location    := MonitoringRoom;

    Order := 410;

    function Look () : ResultType;
    begin
        WriteLn('I SEE A METAL PIT 1000''S OF FEET DEEP ON ONE MONITOR.');
        WriteLn('ON THE OTHER SIDE OF THE PIT,I SEE A LARGE HOOK.');        
        Exit Handled;
    end
end

/// A SMALL PAINTING
///
object Painting (Item)     
    Description := 'A SMALL PAINTING';
    Keyword     := 'PAI';
    Location    := LargeRoom;

    State := Default;
    Order := 440;

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
            Items[Capsule].Location := Location;
            State := Moved;
        end
    end
end

/// A PAIR OF RUBBER GLOVES
///
object Gloves (Item)      
    Description := 'A PAIR OF RUBBER GLOVES';
    Keyword     := 'GLO';
    Location    := MaintenanceCloset;
    State       := Default;

    Order := 450;

    // Stop wearing GLOVES if DROP.
    //
    function Drop () : ResultType;
    begin
        Items[Gloves].State := Default;
        Exit Passed;
    end

    // WEAR the GLOVES.
    //
    function Wear () : ResultType;
    begin
        if this.Location = Inventory then
        begin
            WriteLn ('O.K. IM NOW WEARING THE GLOVES.');
            Items[Gloves].State := Wearing;
            Exit Handled;
        end
    end
end

/// A BOX WITH A BUTTON ON IT
///
object Box (Item)     
    Description := 'A BOX WITH A BUTTON ON IT';
    Keyword     := 'BOX';
    Location    := Laboratory;

    Order := 460;
end

/// BUTTON on the BOX!
///
object BoxButton (Item)
    Description := 'A BUTTON ON THE BOX';
    Keyword     := 'BUT';
    Location    := Global;

    Order := 350;

    function Push () : ResultType;
    begin
        if Items[Box].Location = Inventory then
        begin
            WriteLn ('I PUSH THE BUTTON ON THE BOX AND');

            if Location = SoundProofedCubicle OR Location = ChaosControlRoom then
            begin
                WriteLn('THERE IS A BLINDING FLASH....');
                Pause (750);
                Location := BusyStreet;

                Floor := 1;
                Rooms[SmallRoom].Exits.Put(North, Lobby);
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
object Slit (Item)    
    Description := 'SLIT NEAR DOOR';
    Keyword     := 'SLI';
    Location    := ShortCorridor;

    Fixed := True;
    Hidden := True;

    Order := 500;
end