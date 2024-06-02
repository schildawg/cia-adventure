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

var Items : Array := Array(51) as Array;

procedure AddItems();
begin
    Items.Set(TAPE,          Item ('A VIDEO TAPE',                 'TAP', 0));
    Items.Set(LOCK,          Item ('AN ELECTRONIC LOCK',           'LOC', 0));
    Items.Set(SOLID_DOOR,    Item ('A SOLID LOOKING DOOR',         'DOO', SHORT_CORRIDOR));
    Items.Set(OPEN_DOOR,     Item ('AN OPEN DOOR',                 'DOO', 0));
    Items.Set(ALERT_GUARD,   Item ('AN ALERT SECURITY GUARD',      'GUA', SHORT_CORRIDOR));
    Items.Set(SLEEPING_GUARD,Item ('A SLEEPING SECURITY GUARD',    'GUA', 0));
    Items.Set(LOCKED_CLOSET, Item ('A LOCKED MAINTENANCE CLOSET',  'CLO', CAFETERIA));
    Items.Set(CLOSET,        Item ('A MAINTENANCE CLOSET',         'CLO', 0));
    Items.Set(PLASTIC_BAG,   Item ('A PLASTIC BAG',                'BAG', MAINTENANCE_CLOSET));
    Items.Set(ANTIQUE_KEY,   Item ('AN OLDE FASHIONED KEY',        'KEY', SMALL_ROOM));
    Items.Set(METAL_SQUARE,  Item ('A SMALL METAL SQUARE ON THE WALL', 'SQU', POWER_GENERATOR_ROOM));
    Items.Set(LEVER,         Item ('A LEVER ON THE SQUARE',        'LEV', POWER_GENERATOR_ROOM));
    Items.Set(BROOM,         Item ('A BROOM',                      'BRO', MAINTENANCE_CLOSET));
    Items.Set(DUSTPAN,       Item ('A DUSTPAN',                    'DUS' ,MAINTENANCE_CLOSET));
    Items.Set(GLASS_CASE,    Item ('A GLASS CASE ON A PEDESTAL',   'CAS', SOUND_PROOFED_CUBICLE));
    Items.Set(RAZOR_BLADE,   Item ('A RAZOR BLADE',                'BLA', BATHROOM));
    Items.Set(RUBY,          Item ('A VERY LARGE RUBY',            'RUB', 0));
    Items.Set(SIGN,          Item ('A SIGN ON THE SQUARE',         'SIG', POWER_GENERATOR_ROOM));
    Items.Set(COFFEE_MACHINE, Item ('A COFFEE MACHINE',            'MAC', SMALL_HALLWAY));
    Items.Set(CUP_OF_COFFEE, Item ('A CUP OF STEAMING HOT COFFEE', 'CUP', 0));
    Items.Set(CAPSULE,       Item ('A SMALL CAPSULE',              'CAP', 0));
    Items.Set(BUTTON,        Item ('A LARGE BUTTON ON THE WALL',   'BUT', CHAOS_CONTROL_ROOM));
    Items.Set(ROPE,          Item ('A STRONG NYLON ROPE',          'ROP', SUB_BASEMENT));
    Items.Set(HOOK,          Item ('A LARGE HOOK WITH A ROPE HANGING FROM IT', 'HOO', OTHER_SIDE));
    Items.Set(TELEVISION,    Item ('A PORTABLE TELEVISION',        'TEL', SECURITY_OFFICE));
    Items.Set(PEDISTAL_MONITOR, Item ('A BANK OF MONITORS',        'MON', SECURITY_OFFICE));
    Items.Set(ID_CARD,       Item ('A CHAOS I.D. CARD',            'CAR', END_OF_COMPLEX));
    Items.Set(MONITORS,      Item ('A BANK OF MONITORS',           'MON', MONITORING_ROOM));
    Items.Set(PAINTING,      Item ('A SMALL PAINTING',             'PAI', LARGE_ROOM));
    Items.Set(GLOVES,        Item ('A PAIR OF RUBBER GLOVES',      'GLO', MAINTENANCE_CLOSET));
    Items.Set(BOX,           Item ('A BOX WITH A BUTTON ON IT',    'BOX', LABORATORY));
    Items.Set(SLIT,          Item ('SLIT',                         'SLI', SHORT_CORRIDOR));
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
        IndirectObject : String;
        Item : Integer;

    begin
        if Mock = Nil then
            begin
                IndirectObject := ReadLn ('TELL ME, IN ONE WORD, INTO WHAT? ') as String;
                Item := FindItem (Copy(IndirectObject, 0, 3));
            end 
        else 
            Item := Mock as Integer;
            

        if Item = RECORDER then 
        begin
            WriteLn('O.K.');
            BatteryFlag := On;
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

/// A BLANK CREDIT CARD
///
class CreditCard (Item);
begin
    constructor Init ();
    begin       
        this.Description := 'A BLANK CREDIT CARD';
        this.Keyword     := 'CAR';
        this.Location    := 0;
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

        this.Fixed := True;
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
        WriteLn ('THERES WRITING ON IT.');
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



