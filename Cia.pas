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
type ItemState = (Default, Moved, Connected, Wearing); 

uses 'main/Constants';
uses 'main/Utils';

uses 'main/Rooms';
uses 'main/Items';
uses 'main/Verbs';

uses 'test/RoomTests';
uses 'test/ItemTests';
uses 'test/VerbTests';
uses 'test/EventTests';

var Name : String;
var Code : String;

var UpdateTime : Boolean := True;
var IsDone     : Boolean := False;

var Location    : Integer := 1;
var Floor       : Integer := 1;
var Time        : Integer := 0;

// Dumb ways to die :)
var ElectricyFlag : Flag    := On;
var Guns          : Boolean := False;

var SleepTimer  : Integer := 0;
var DrugCounter : Integer := -1;

// Maps Verbs to handlers.
//
var Dispatch := ['GO ': Go, 'GET': Get, 'DRO': Drop, 'OPE': Open, 'PUS': Push, 'PUL': Pull, 'LOO': Look,
    'INS': Insert, 'OPE': Open, 'WEA': Wear, 'REA': ReadVerb, 'STA': Start, 'BRE': BreakVerb, 'CUT': Cut, 
    'THR': Throw, 'CON': Connect, 'QUI': Quit, 'BON': Bond007, 'INV': Inventory];
    
procedure Setup ();
begin
    Randomize ();

    Code := Str(Random(1, 9));  
    for var R := 1; R < 5; R := R + 1 do
    begin
       Code := Code + Str(Random(1, 9));  
    end

    Items.Reset();
    
    Time := 0;
    UpdateTime := True; 
    
    AddRooms();
end

/// Finds an item number.
///
function  FindItemID (ToMatch : String) : Identifier;
begin
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
        Item := I.Next() as Item;
        if Item.Keyword = ToMatch and (Item.Location = Location or Item.Location = INVENTORY) then
        begin
           Exit Item.Id;
        end 
    end
    raise 'I DON''T SEE THAT HERE.';
end

/// Finds an Item
///
function  FindItem (ToMatch : String) : Item;
var
   Item : Item;

begin
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
        Item := I.Next() as Item;
        if Item.Keyword = ToMatch and (Item.Location = Location or Item.Location = INVENTORY or Location = GLOBAL) then
        begin
           Exit Item;
        end 
    end
    raise 'I DON''T SEE THAT HERE.';
end

/// Checks if is a valid object.
///
function MatchDirectObject (DirectObject : String);
begin
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
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
    if Time = 1 then 
    begin
        WriteLn('WRITING ON THE WALL SAYS:');
        WriteLn('IF YOU WANT INSTRUCTIONS TYPE:ORDERS PLEASE');
    end

    if Time > 375 then
    begin
        WriteLn ('I THINK THEY ARE ON TO ME....I HEAR NOISES.');
    end

    if Time = 400 then 
    begin
       WriteLn ('OH NO! THEY CAUGHT UP TO ME! HELP! THEY''RE PULLING OUT GUNS!');
       Die();
       Exit;
    end

    if DrugCounter = 0 then
    begin
        WriteLn ('I HEAR A NOISE LIKE SOMEONE IS YAWNING.');
        
        Items[AlertGuard].Location = SHORT_CORRIDOR;
        Items[SleepingGuard].Location = 0;

        Guns := True;
        DrugCounter := -1;
        Exit;
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
            raise 'I DON''T KNOW HOW TO DO THAT.';
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
            else raise 'PLEASE USE 2 WORD COMMANDS SO I CAN UNDERSTAND YOU.';

            Exit;
        end

        DirectObject := Copy(Command, Pos(Command, Str(' ')) + 1, 3);

        if Not MatchDirectObject (DirectObject) then
        begin
            raise 'I DON''T KNOW WHAT IT IS YOU ARE TALKING ABOUT.' + DirectObject;
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
    ClearScreen ();
    WriteLn('        C.I.A  ADVENTURE');
    Setup ();

    DisplayRoom();  
    Name := ReadLn('ENTER YOUR NAME PARTNER? ') as String;
    
    while Not IsDone do 
    begin
        if UpdateTime then
        begin
            Time := Time + 1;
            if SleepTimer > 0 then SleepTimer := SleepTimer - 1;

            Events();
        end

        if IsDone then Exit;

        try  
            ReadCommand ();
        except
            on Err : String do Error(Err);
        end
    end 
end

Main();