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
uses 'main/Utils';

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

// Maps Verbs to handlers.
//
var Dispatch := ['GO ': Go, 'GET': Get, 'DRO': Drop, 'OPE': Open, 'PUS': Push, 'PUL': Pull, 'LOO': Look,
    'INS': Insert, 'OPE': Open, 'WEA': Wear, 'REA': ReadVerb, 'STA': Start, 'BRE': BreakVerb, 'CUT': Cut, 
    'THR': Throw, 'CON': Connect, 'QUI': Quit, 'BON': Bond007, 'INV': Inventory];
    
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
    raise 'I DON''T SEE THAT HERE.';
end

/// Finds an Item
///
/// # Errors
///
/// Raises error if item not found.
///
function  FindItem (ToMatch : String) : Item;
var
   Item : Item;

begin
    for var I := Iterator(Items); I.HasNext(); Nop() do
    begin
        Item := I.Next() as Item;
        if Item.Keyword = ToMatch and (Item.Location = Location or Item.Location = INVENTORY or Location = GLOBAL) then
        begin
           Exit Item;
        end 
    end
    raise 'I DON''T SEE THAT HERE.';
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
function MatchDirectObject (DirectObject : String);
begin
    for var I := Iterator(Items); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if DirectObject = Item.Keyword then Exit True;
    end
    Exit DirectObject = 'NOR' or DirectObject = 'SOU' or DirectObject = 'EAS' or DirectObject = 'WES';
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
        WriteLn ('THE FLOOR IS WIRED WITH ELECTRICITY!');
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
    WriteLn ('I''M DEAD!');
    WriteLn ('YOU DIDN''T WIN.');

    //var Input := ReadLn ('WOULD YOU LIKE TO TRY AGAIN (Y/N) ');
    //if Input = 'Y' then Reset(); else IsDone := True;
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
            WriteLn('I DON''T KNOW HOW TO DO THAT.');
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
            WriteLn('I DON''T KNOW WHAT IT IS YOU ARE TALKING ABOUT.');
            UpdateTime := False; 
            Exit;
        end

        if (Dispatch.Contains(Verb)) then
            begin
                Dispatch.Get (Verb) (DirectObject);
            end
        else WriteLn (Verb + ' NOT SUPPORTED... YET!');
    except
        on Err : String do Error(Err);
    end
end

/// Reads a command and executes it.
///
procedure ReadCommand ();
var 
    Command : String;

begin
    InventoryCount := 0;
    for var I := Iterator(Items); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if Item.Location = -1 then InventoryCount := InventoryCount + 1;
    end

    UpdateTime := True;
    
    WriteLn('');
    Command := ReadLn ('WHAT DO YOU THINK WE SHOULD DO? ') as String;
    ParseCommand (Command);
end

procedure Error(Err : String);
begin
    UpdateTime := False;
    WriteLn (Err);
end

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
            on Err : String do Error(Err);
        end
    end 
end

Main();