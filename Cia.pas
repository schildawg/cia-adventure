/// �����  �����   ���
/// �        �    �   �
/// �        �    ����� 
/// �        �    �   � 
/// �����  �����  �   �
///
///  Translated from TRS-80 version on CPMNET BBS by Pete Wohlmut 10-3-82
///  Translated to ALGOL-24 by Joel Schilling 05-20-24
type ScreenType = (DEBUG, BUFFER, CONSOLE);
var Display := Screen();

type Flag = (On, Off);
type ResultType = (Handled, Failed, Passed);
type DoorState = (Opened, Closed); 

uses 'main/Constants';
uses 'main/Rooms';
uses 'main/Items';
uses 'main/Verbs';

uses 'test/RoomTests';
uses 'test/ItemTests';
uses 'test/VerbTests';

var Name : String;
var Code : String;

var UpdateTime : Boolean := True;
var IsDone : Boolean := False;

var Location    : Integer := 1;
var Time        : Integer := 0;

var SleepTimer  : Integer := 0;
var DrugCounter : Integer := -1;

var InventoryCount : Integer := 0;

var Door              : DoorState := Closed;
var Floor             : Integer := 1;

var TelevisionFlag    : Flag := Off;
var ButtonFlag        : Flag := Off;
var ElectricyFlag     : Flag := On;
var BatteryFlag       : Flag := Off;
var TapeFlag          : Flag := Off;
var RopeFlag          : Flag := Off;
var PaintingFlag      : Flag := Off;
var GlovesFlag        : Flag := Off;
var DruggedFlag       : Flag := Off;
var Guns              : Integer := 0;

procedure Setup ();
begin
    Init ();
    
    AddRooms();
    AddItems();
end

/// Finds an item number.
///
/// # Errors
///
/// Raises error if item not found.
///
function  FindItemID (ToMatch : String) : Integer;
begin
    for var I := 1; I < Items.Length; I := I + 1 do
    begin
        var Item := Items[I];
        if Item.Keyword = ToMatch and (Item.Location = Location or Item.Location = INVENTORY) then
        begin
           Exit I as Integer;
        end 
    end
    raise 'I DONT SEE THAT HERE.';
end

/// Finds an Item
///
/// # Errors
///
/// Raises error if item not found.
///
function  FindItem (ToMatch : String) : Item;
begin
    for var I := 1; I < Items.Length; I := I + 1 do
    begin
        var Item := Items[I];
        if Item.Keyword = ToMatch and (Item.Location = Location or Item.Location = INVENTORY) then
        begin
           Exit Item as Item;
        end 
    end
    raise 'I DONT SEE THAT HERE.';
end

/// Displays a Room.
///
procedure DisplayRoom();
var
   HasExit : Boolean := False;
   TheRoom : Room;

begin
    TheRoom := Rooms[Location] as Room;
    WriteLn('WE ARE ' + TheRoom.Description + '.');

    for var I := 1; I <= 46; I := I + 1 do
    begin
       var Item := Items[I];

       var Hidden := False;
       try Hidden := Item.Hidden;
       except end

       if Item.Location = Location and not Hidden then WriteLn ('I CAN SEE ' + Item.Description + '.');
    end
    
    for var R := 0; R < 4; R := R + 1 do
    begin
       if TheRoom.Exits[R] > 0 then HasExit := True;
    end
    
    if HasExit then
    begin
        Write('WE COULD EASILY GO: ');
        if TheRoom.Exits[NORTH] > 0 then Write ('NORTH  ');
        if TheRoom.Exits[SOUTH] > 0 then Write ('SOUTH  ');
        if TheRoom.Exits[EAST]  > 0 then Write ('EAST  ');
        if TheRoom.Exits[WEST]  > 0 then Write ('WEST  ');
    end
    WriteLn (' ');
    WriteLn ('>--------------------------------------------------------------<');
end

/// Updates the Time and runs Events.
//
procedure UpdateTimer();
begin
    Time := Time + 1;
    if SleepTimer > 0 then SleepTimer := SleepTimer - 1;
    if Time = 1 then
    begin
        Name := ReadLn('ENTER YOUR NAME PARTNER? ') as String;
    end
    Events();
end

/// Checks if is a valid object.
///
function MatchDirectObject (Item : String);
begin
    for var I := 1; I < Items.Length; I := I + 1 do
    begin
        if Item = Items[I].Keyword then Exit True;
    end
    Exit Item = 'NOR' or Item = 'SOU' or Item = 'EAS' or Item = 'WES';
end


/// Drop verb.
///
procedure Drop(DirectObject : String);
var 
   Match : Item;
   TheItem : Integer;

begin
    Match := Nil as Item;
    for var R := 1; R <= 46; R := R + 1 do
    begin
        if Items[R].Keyword = DirectObject and Items[R].Location = INVENTORY then
        begin
            Match := Items[R] as Item;
            TheItem := R as Integer;
            break;
        end
    end
   
    if Match = Nil then
    begin
       WriteLn('I DONT SEEM TO BE CARRYING IT.');  
       Exit;     
    end

    if TheItem = CUP_OF_COFFEE then 
    begin
        WriteLn ('I DROPPED THE CUP BUT IT BROKE INTO SMALL PEICES.');
        WriteLn ('THE COFFEE SOAKED INTO THE GROUND.');
        Items[CUP_OF_COFFEE].Location := 0;
        DruggedFlag := Off;
        Exit;
    end

    if TheItem = GLOVES then
    begin
        GlovesFlag := Off;
    end

    if TheItem = CAPSULE and Items[CUP_OF_COFFEE].Location = INVENTORY then
    begin
        WriteLn ('O.K. I DROPPED IT.');
        WriteLn ('BUT IT FELL IN THE COFFEE!');
        Items[CAPSULE].Location := 0; 
        DruggedFlag := On;
        Exit;
    end
    
    Match.Location := Location;
    WriteLn('O.K. I DROPPED IT.');
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

/// Push verb
//
procedure Push(DirectObject : String);
var 
   TheItem : Integer;

begin
    if DirectObject = 'BUT' and Location = LOBBY and Door = Closed then
    begin
       WriteLn('THE DOORS OPEN WITH A WHOOSH!');
       Door := Opened;
       Exit;
    end

    if Items[BOX].Location = INVENTORY and DirectObject = 'BUT' then
    begin
        WriteLn ('I PUSH THE BUTTON ON THE BOX AND');

        if Items[BOX].Location = INVENTORY and (Location=SOUND_PROOFED_CUBICLE OR Location=CHAOS_CONTROL_ROOM) then
        begin
           WriteLn('THERE IS A BLINDING FLASH....');
           Pause (750);
           Location := BUSY_STREET;

           Floor := 1;
           Rooms[SMALL_ROOM].Exits.Set(0, LOBBY);
           DisplayRoom();
           Exit;
        end

        WriteLn('NOTHING HAPPENS.');
        Exit;
    end

   try 
        TheItem :=  FindItemID (DirectObject);

        try if Items[TheItem].Push() = Handled then Exit;
        except end

        if TheItem = METAL_SQUARE and GlovesFlag = Off then
        begin
            WriteLn('THERES ELECTRICITY COURSING THRU THE SQUARE!');
            WriteLn('IM BEING ELECTROCUTED!');
            Die ();
        end
        
        if TheItem = BUTTON and ButtonFlag = Off then
        begin
            WriteLn('THE BUTTON ON THE WALL GOES IN .....');
            WriteLn('CLICK! SOMETHING SEEMS DIFFFERENT NOW.');
            ButtonFlag := On;
            Exit;
        end
        WriteLn('NOTHING HAPPENS.');

    except
        on Err : String do
            begin
               WriteLn (Err);
            end 
    end
end

/// Pull Verb
///
procedure Pull(DirectObject : String);
var 
    Item : Integer;

begin
    Item :=  FindItemID (DirectObject);
    if Item = LEVER and GlovesFlag = Off then
    begin
        WriteLn('THE LEVER HAS ELECTRICITY COURSING THRU IT!');
        WriteLn('IM BEING ELECTROCUTED!');
        Die ();
        Exit;  // <-  Yeah, still need to exit after dying :)
    end
    
    if Item = LEVER and ElectricyFlag = On then
    begin
        WriteLn ('THE LEVER GOES ALL THE WAY UP AND CLICKS.');
        WriteLn ('SOMETHING SEEMS DIFFERENT NOW.');
        ElectricyFlag := Off;
        Exit;
    end
    WriteLn ('NOTHING HAPPENS.');
end

/// Look Verb
procedure Look(DirectObject : String);
var 
   Item : Integer;

begin
    Item :=  FindItemID (DirectObject); 
    
    try if Items[Item].Look() = Handled then Exit;
    except 
    end

    if Item = PLASTIC_BAG then
    begin
        WriteLn ('IT''S A VERY STRONG BAG.');
        Exit;
    end

    if Item = SIGN then
    begin
       WriteLn ('THERES WRITING ON IT.');
       Exit;
    end

    if Item = SLIDING_DOORS and Door = Open then
    begin 
        WriteLn('THE DOORS ARE OPEN.');
        Exit;
    end

    if Item = GLASS_CASE then
    begin
        WriteLn ('I CAN SEE A GLEAMING STONE IN IT.');
        Exit;
    end
    
    if Item = SOLID_DOOR then
    begin
        WriteLn('THERE IS A SMALL SLIT NEAR THE DOOR.');
        Exit;
    end

    if Item = SLIDING_DOORS and Door = Closed then
    begin 
        WriteLn('THERES A BUTTON NEAR THE DOORS.');
        Exit;
    end

    if Item = MONITORS then
    begin
        WriteLn ('I SEE A METAL PIT 1000S OF FEET DEEP ON ONE MONITOR.');
        WriteLn ('ON THE OTHER SIDE OF THE PIT,I SEE A LARGE HOOK.');
        Exit;
    end

    if Item = PEDISTAL_MONITOR and ButtonFlag = Off then
    begin
        WriteLn ('THE SCREEN IS DARK.');
        Exit;
    end

    if Item = PEDISTAL_MONITOR then
    begin
        WriteLn ('I SEE A ROOM WITH A CASE ON A PEDESTAL IN IT.');
        Exit;
    end

    if Item = PAINTING then
    begin
       WriteLn ('I SEE A PICTURE OF A GRINNING JACKAL.');
       Exit;
    end
    
    WriteLn('I SEE NOTHING OF INTEREST.');
end

/// Insert Verb.
///
procedure Insert (DirectObject : String);
var
    Item   : Integer;
    Item2  : Integer;
    IndirectObject : String;

begin
    Item :=  FindItemID (DirectObject);
    try if Items[Item].Insert() = Handled then Exit;
    except end

    if Item <> TAPE and Item <> BATTERY and Item <> CREDIT_CARD and Item <>  QUARTER then
    begin
       WriteLn('I CAN''T INSERT THAT!');
       Exit;
    end
    
    IndirectObject := ReadLn ('TELL ME, IN ONE WORD, INTO WHAT? ') as String;
    Item2 :=  FindItemID (Copy(IndirectObject, 0, 3));

    if Item = CREDIT_CARD and Item2 = SLIT and DrugCounter <= 0 then
    begin
        WriteLn ('THE GUARD WON''T LET ME!');
        Exit;
    end

    if Item = TAPE and Item2 = RECORDER then
    begin
        WriteLn ('O.K. THE TAPE IS IN THE RECORDER.');
        Items[TAPE].Location := 0;
        TapeFlag := On;
        Exit;
    end

    if Item = CREDIT_CARD and Item2 = SLIT then 
    begin 
        WriteLn('POP! A SECTION OF THE WALL OPENS.....');
        WriteLn('REVEALING SOMETHING VERY INTERESTING.');
        Items[CREDIT_CARD].Location := 0;
        Items[LOCK].Location := Location;
        Exit;
    end

    if Item = QUARTER and Item2 = COFFEE_MACHINE then 
    begin
        WriteLn ('POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
        Items[QUARTER].Location := 0;
        Items[CUP_OF_COFFEE].Location := Location;
        Exit;
    end

    WriteLn ('NOTHING HAPPENED.');
end

/// Open Verb
///
procedure Open(DirectObject : String);
var
   Item     : Integer;
   Openable : Boolean;

begin  
    try
        Item :=  FindItemID (DirectObject);
        try 
            if Items[Item].Open() = Handled then Exit;
        except 
            on Err2 : String do 
            begin end
        end

        Openable := False;
        try 
           Openable := Items[Item].Openable;
        except
        end

        //if Not Openable then
        if Item <> LOCKED_WOODEN_DOOR and Item <> SOLID_DOOR and Item <> LOCKED_CLOSET and Item <> 15 and Item <> 23 and Item <> 32 and Item <> 5 then
        begin
            raise 'I CAN''T OPEN THAT.';
        end
    
        if Item = SOLID_DOOR then
        begin
            WriteLn ('I CAN''T. IT DOESNT WORK.');
            Exit;
        end

        if Item = LOCKED_CLOSET and Items[ANTIQUE_KEY].Location = INVENTORY then 
        begin
            WriteLn ('O.K. THE CLOSET IS OPENED.');
            Items[LOCKED_CLOSET].Location := 0;
            Items[CLOSET].Location := 14;
            Exit;
        end

        if Item = PLASTIC_BAG then
        begin
            WriteLn ('I CAN''T. IT''S TOO STRONG.');
            Exit;
        end

        if Item = LOCK then
        begin
            var Input := ReadLn ('WHATS THE COMBINATION? ');
            if Input = Code then
            begin
                WriteLn ('THE DOOR IS SLOWLY OPENING.');
                Items[LOCK].Location := 0;
                Items[SOLID_DOOR].Location := 0;
                Items[OPEN_DOOR].Location := 10;
                Exit;
            end
            WriteLn ('YOU MUST HAVE THE WRONG COMBINATION OR YOU ARE NOT');
            WriteLn ('SAYING IT RIGHT.');
            Exit;
        end
        WriteLn ('I CAN''T DO THAT......YET!');

    except
        on Err : String do
            begin
               WriteLn (Err);
            end 
    end
end

/// Wear Verb
///
procedure Wear (DirectObject : String);
begin
    if DirectObject = 'GLO' and Items[GLOVES].Location = INVENTORY then
    begin
       WriteLn ('O.K. IM NOW WEARING THE GLOVES.');
       GlovesFlag := On;
       Exit;
    end
    WriteLn ('I CAN''T WEAR THAT!');
end

/// Read Verb
///
procedure ReadVerb(DirectObject : String);
var
   Item : Integer;
begin
    if DirectObject <> 'SIG' and DirectObject <> 'NOT' then
    begin
        WriteLn ('I CAN''T READ THAT.');
        Exit;   
    end 
   
    Item := FindItemID  (DirectObject);
    
    try if Items[Item].Read() = Handled then Exit;
    except end

    if Item = SIGN then 
    begin
        WriteLn ('IT SAYS: WATCH OUT! DANGEROUS!');
    end
end

/// Start Verb
///
procedure Start(DirectObject : String);
var
   Item : Integer;

begin
    if  DirectObject <> 'REC' then
    begin
        WriteLn ('I CAN''T START THAT.');
        Exit;
    end
    
    Item :=  FindItemID (DirectObject);
    try if Items[Item].Start() = Handled then Exit;
    except
    end
    WriteLn('NOTHING HAPPENED.');
end

/// Break Verb
///
procedure BreakVerb(DirectObject : String);
var
   Item : Integer;

begin
    Item :=  FindItemID (DirectObject);
    try if Items[Item].DoBreak() = Handled then Exit;
    except end

    WriteLn ('IM TRYING TO BREAK IT, BUT I CAN''T.');
end

/// Cut Verb.
///
procedure Cut (DirectObject : String);
var
   Item : Integer;

begin
    Item :=  FindItemID (DirectObject);
    
    if Item <> PLASTIC_BAG and Item <> GLASS_CASE then
    begin
       WriteLn ('IM TRYING. IT DOESNT WORK.');
       Exit;
    end

    if Items[RAZOR_BLADE].Location <> INVENTORY then
    begin
        WriteLn ('I CAN''T DO THAT YET.');
        Exit;
    end

    if Item = PLASTIC_BAG then
    begin
        WriteLn('RIP! THE BAG GOES TO PIECES, AND SOMETHING FALLS OUT!');
        Items[PLASTIC_BAG].Location := 0;
        Items[TAPE].Location := Location;
        Exit;
    end

    if Item = GLASS_CASE then
    begin
        WriteLn ('I CUT THE CASE AND REACH IN TO PULL SOMETHING OUT.');
        Items[RUBY].Location := INVENTORY;
        Exit;
    end
end

/// Throw Verb.
///
procedure Throw(DirectObject : String);
var
    IndirectObject : String;

begin
    if DirectObject <> 'ROP' then
    begin
       WriteLn ('I CAN''T THROW THAT.');
       Exit;
    end
    
    if Items[ROPE].Location <> INVENTORY then
    begin
        WriteLn ('I CAN''T DO THAT YET.');
        Exit;
    end
    
    var Input := ReadLn ('TELL ME,IN ONE WORD,AT WHAT? ');
    IndirectObject = Copy(Input, 0, 3);

    if IndirectObject = 'HOO' then
    begin
        WriteLn ('O.K. I THREW IT.');
        Items[ROPE].Location := Location;
        Exit;
    end

    if Location <> LEDGE then
    begin
        WriteLn ('I CAN''T DO THAT YET.');
        Exit;
    end
    WriteLn ('I THREW THE ROPE AND IT SNAGGED ON THE HOOK.');
    RopeFlag := On;
    Items[ROPE].Location := Location;
end

/// Connect Verb
///
procedure Connect (DirectObject : String);
begin
    if DirectObject <> 'TEL' then
    begin
        WriteLn ('I CAN''T CONNECT THAT.');
        Exit;
    end

    if Items[TELEVISION].Location <> Location then
    begin
        WriteLn ('I DONT SEE THE TELEVISION HERE.');
        Exit;
    end

    if TelevisionFlag = On then
    begin
        WriteLn ('I DID THAT ALREADY.');
        Exit;
    end
    
    if Location <> VISITORS_ROOM then 
    begin
       WriteLn ('I CAN''T DO THAT....YET!');
       Exit;
    end

    WriteLn ('O.K. THE T.V. IS CONNECTED.');
    TelevisionFlag := On;
end

/// Quit Verb
///
procedure Quit();
begin
    WriteLn('WHAT? YOU WOULD LEAVE ME HERE TO DIE ALONE?');
    WriteLn('JUST FOR THAT, IM GOING TO DESTROY THE GAME.');
    WriteLn(' '); 
    WriteLn(' '); 
    WriteLn(' '); 
    WriteLn('BOOOOOOOOOOOOM!'); 
    Pause (1000);
    IsDone := True;
end

/// Opens trap door to basement.
///
procedure Bond007();
begin
    if Location = CAFETERIA then
    begin
       WriteLn ('WHOOPS! A TRAP DOOR OPENED UNDERNEATH ME AND');
       WriteLn ('I FIND MYSELF FALLING.');
       Pause (800);
       Location := SUB_BASEMENT;
       DisplayRoom();
       Exit;
    end
    WriteLn ('NOTHING HAPPENED.');
end

/// Processes events.
///
procedure Events();
begin
    if Location = SHORT_CORRIDOR and Guns = -2 then
    begin
        WriteLn ('THE GUARD DRAWS HIS GUN AND SHOOTS ME!');
        Die();
    end

    if Location = SHORT_CORRIDOR and Items[ID_CARD].Location <> INVENTORY then
    begin
        WriteLn('THE GUARD LOOKS AT ME SUSPICIOUSLY, THEN THROWS ME BACK.');
        Pause (750);
        Location := SMALL_ROOM;
        DisplayRoom();
        Exit;
    end

    if Location = SOUND_PROOFED_CUBICLE and ButtonFlag = Off then
    begin
        WriteLn ('SIRENS GO OFF ALL AROUND ME!');
        WriteLn ('GUARDS RUN IN AND SHOOT ME TO DEATH!');
        Die();
    end

    if Location = METAL_HALLWAY and ElectricyFlag = On then
    begin
        WriteLn ('THE FLOOR IS WIRED WITH ELECDRICITY!');
        WriteLn ('IM BEING ELECTROCUTED!');
        Die();
    end
    
    if Location = SHORT_CORRIDOR and Items[CUP_OF_COFFEE].Location = INVENTORY and DruggedFlag = On then
    begin
       WriteLn ('THE GUARD TAKES MY COFFEE');
       WriteLn ('AND FALLS TO SLEEP RIGHT AWAY.');
       DrugCounter := 5 + 10; //Random(0, 10);
       Items[ALERT_GUARD].Location := 0;
       Items[SLEEPING_GUARD].Location := SHORT_CORRIDOR;
       DruggedFlag := Off;
       Items[CUP_OF_COFFEE].Location := 0;
    end
    
    if DrugCounter = 0 then
    begin
        WriteLn ('I HEAR A NOISE LIKE SOMEONE IS YAWNING.');
        Items[11].Location = SHORT_CORRIDOR;
        Items[12].Location = 0;
        Guns := -2;
        DrugCounter := -1;
        Exit;
    end

    if Time > 375 then
    begin
        WriteLn ('I THINK THEY ARE ON TO ME....I HEAR NOISES.');
    end

    if Time = 400 then 
    begin
       WriteLn ('OH NO! THEY CAUGHT UP TO ME! HELP! THEYRE PULLING OUT GUNS!');
       Die();
    end

    if Time = 1 then 
    begin
        WriteLn('WRITING ON THE WALL SAYS:');
        WriteLn('IF YOU WANT INSTRUCTIONS TYPE:ORDERS PLEASE');
    end

    if Location = SOUND_PROOFED_CUBICLE and Rooms[SOUND_PROOFED_CUBICLE].Exits.Get (1) <> 0 then
    begin
        WriteLn ('A SECRET DOOR SLAMS DOWN BEHIND ME!');
        Rooms[SOUND_PROOFED_CUBICLE].Exits.Set (1 , 0);
    end

    var CurrentRoom := Rooms[Location];
    CurrentRoom.Event();
end

// Parses abreviations, and returns expanded commands.
//
function ParseAbreviation(Command : String) : String;
begin
    if Command = Str('N') then Exit 'GO NORTH';
    if Command = Str('S') then Exit 'GO SOUTH';
    if Command = Str('E') then Exit 'GO EAST';
    if Command = Str('W') then Exit 'GO WEST';
    if Command = Str('I') then Exit 'INV';

    Exit Command as String;
end

// Converts synonyms to verb.
//
function FindSynonyms(Verb : String) : String;
begin
   if Verb = 'WAL' or Verb = 'RUN' then Exit 'GO ';
   if Verb = 'TAK' or Verb = 'CAR' then Exit 'GET';
   if Verb = 'LEA' then Exit 'DRO';
   if Verb = 'PRE' then Exit 'PUS';
   if Verb = 'EXA' then Exit 'LOO';
   if Verb = 'PUT' then Exit 'INS';
   if Verb = 'UNL' then Exit 'OPE';
   if Verb = 'PLA' then Exit 'STA';
   if Verb = 'SMA' then Exit 'BRE';
   if Verb = 'ATT' then Exit 'CON';
   if Verb = 'LIS' then Exit 'INV';

   Exit Verb as String;
end

/// Ends the game by dying.
///
procedure Die();
begin
    Pause (1000); 
    WriteLn ('IM DEAD!');
    WriteLn ('YOU DIDN''T WIN.');

    var Input := ReadLn ('WOULD YOU LIKE TO TRY AGAIN (Y/N) ');
    if Input = 'Y' then Reset(); else IsDone := True;
end

procedure Intro ();
begin
    ClearScreen ();
    WriteLn('        C.I.A  ADVENTURE');
    Setup ();

    DisplayRoom();  
end

/// Sets up the game.
///
procedure Init ();
begin
    Randomize ();
    Door := Closed;

    Code := Str(Random(1, 9));  
    for var R := 1; R < 5; R := R + 1 do
    begin
       Code := Code + Str(Random(1, 9));  
    end

    Time := 0;
    UpdateTime := True;
end

procedure ParseCommand (Command : String);
var 
    Verb, DirectObject : String;
    
begin
    try   
        Command := ParseAbreviation (Command);

        Verb := Copy(Command, 0, 3);
        Verb := FindSynonyms (Verb);

        if Verb = 'ORD' then 
        begin
            DisplayOrders();
            Exit;
        end

        if Not Dispatch.Contains (Verb) then 
        begin
            WriteLn('I DONT KNOW HOW TO DO THAT.');
            UpdateTime := False;
            Exit;
        end

        if Verb = 'QUI' then 
        begin 
            Quit();
            Exit;
        end

        if Pos (Command, Str(' ')) = -1 then
        begin
            if Verb = 'LOO' then DisplayRoom();
            else if Verb = 'BON' then Bond007();
            else if Verb = 'INV' then Inventory();
            else WriteLn('PLEASE USE 2 WORD COMMANDS SO I CAN UNDERSTAND YOU.');

            UpdateTime := False;
            Exit;
        end

        DirectObject := Copy(Command, Pos(Command, Str(' ')) + 1, 3);

        if Not MatchDirectObject (DirectObject) then
        begin
            WriteLn('I DONT KNOW WHAT IT IS YOU ARE TALKING ABOUT.');
            UpdateTime := False; 
            Exit;
        end

        if (Dispatch.Contains(Verb)) then
            begin
                Dispatch.Get (Verb) (DirectObject);
            end
        else WriteLn (Verb + ' NOT SUPPORTED... YET!');
    except
        on Err : String do
            begin
                UpdateTime := False;
                WriteLn (Err);
            end
    end
end

/// Reads a command and executes it.
///
procedure ReadCommand ();
var 
    Command : String;

begin
    InventoryCount := 0;
    for var I := 1; I < Items.Length; I := I + 1 do
    begin
        if Items[I].Location = -1 then InventoryCount := InventoryCount + 1;
    end

    UpdateTime := True;
    
    WriteLn('');
    Command := ReadLn ('WHAT DO YOU THINK WE SHOULD DO? ') as String;
    ParseCommand (Command);
end

// Maps Verbs to handlers.
//
var Dispatch := ['GO ': Go, 'GET': Get, 'DRO': Drop, 'OPE': Open, 'PUS': Push, 'PUL': Pull, 'LOO': Look,
    'INS': Insert, 'OPE': Open, 'WEA': Wear, 'REA': ReadVerb, 'STA': Start, 'BRE': BreakVerb, 'CUT': Cut, 
    'THR': Throw, 'CON': Connect, 'QUI': Quit, 'BON': Bond007, 'INV': Inventory];

/// Main.
//
procedure Main();
begin
    Intro();
    while Not IsDone do 
    begin
        if UpdateTime then UpdateTimer();
        try  
            ReadCommand ();

        except
            on Err : String do
                begin
                    UpdateTime := False;
                    WriteLn (Err);
                end
        end
    end 
end

Main();