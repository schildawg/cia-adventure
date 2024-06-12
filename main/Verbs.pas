// "INVENTORY" Verb.
//
procedure ShowInventory();
var
   HasInventory : Boolean;

begin
    HasInventory := False;
   
    WriteLn('WE ARE PRESENTLY CARRYING:');
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
        Item := I.Next() as Item;

        if Item.Location = Inventory then
        begin
            HasInventory := True;
            Write (Item.Description);
            if Item.Id = Gloves and Items[Gloves].State = Wearing then Write ('. WHICH I''M WEARING.');
            WriteLn ('');
        end    
    end
    if Not HasInventory then WriteLn ('NOTHING');
end

// "ORDERS PLEASE" Verb.
//
procedure DisplayOrders();
begin
    WriteLn('YOUR MISSION, ' + Name + ', IS TO RECOVER A RUBY THAT IS BEING');
    WriteLn('USED IN TOP SECRET GOVERNMENT PROJECTS AS A PART IN A');
    WriteLn('LASER PROJECTOR.');
    WriteLn('  YOU WILL HAVE A PARTNER WHO IS NOT TOO BRIGHT AND NEEDS');
    WriteLn('YOU TO TELL HIM WHAT TO DO. USE TWO WORD COMMANDS LIKE:');
    WriteLn('');
    WriteLn('              GET NOTEBOOK   GO WEST  LOOK DOOR');
    WriteLn('');
    WriteLn('SOME COMMANDS USE ONLY ONE WORD. EXAMPLE: INVENTORY');
    WriteLn('  IF YOU WANT TO SEE CHANGES IN YOUR SURROUNDINGS TYPE: LOOK');
    WriteLn('THE RUBY HAS BEEN CAPTURED BY A SECRET SPY RING KNOWN AS');
    WriteLn('CHAOS. WE SUSPECT THEY ARE UNDER COVER SOMEWHERE IN THIS');
    WriteLn('NEIGHBORHOOD. GOOD LUCK!');
end


/// Go verb.
///
procedure Go (Direction : String);
var
    Room   : Room;
    Item   : Item;

begin    
    Room := Rooms[Location] as Room;

    if Direction = 'NOR' or Direction = 'SOU' or Direction = 'EAS' or Direction = 'WES' then
    begin
        if Direction = 'NOR' and Room.Exits[North] then 
            MoveTo (Room.Exits[North]);
        
        else if Direction = 'SOU' and Room.Exits[South] then 
            MoveTo (Room.Exits[South]);

        else if Direction = 'EAS' and Room.Exits[East] then 
            MoveTo (Room.Exits[East]);
        
        else if Direction = 'WES' and Room.Exits[West] then 
            MoveTo(Room.Exits[West]);      
        
        else 
            raise 'I CAN''T GO THAT WAY AT THE MOMENT.';
    
        DisplayRoom();
        Exit;
    end 

    Item :=  FindItem (Direction);
    if Item.GetClass().HasProperty('Go') and Item.Go() = Handled then
    begin
        DisplayRoom ();
        Exit;
    end
    raise 'I CAN''T GO THAT WAY AT THE MOMENT.';
end

/// Get verb.
///
procedure Get (DirectObject : String);
var 
    Item           : Item;
    InventoryCount : Integer;
begin
    Item := FindItem (DirectObject);

    //Item <> 2 and Item <> 3 and Item <> 4 and Item <> 6 and Item <> 15 and Item <> 16 and Item <> 21 and Item <> 22 and Item <> 23 and Item <> 25 and Item <> 26 and Item <> 27 and Item <> 28 and Item <> 30 and Item <> 31 and Item <> 37 and Item <> 39 and Item <> 40 and Item <> 42 and Item <> 44 and Item <> 45 and Item <> 46 then 
    if Item.HasProperty('Fixed') and Item.Fixed then 
    begin
        raise 'I CAN''T CARRY THAT!';    
    end

    if Item.Location = Inventory then raise 'I ALREADY HAVE IT.';

    InventoryCount := 0;
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if Item.Location = Inventory then InventoryCount := InventoryCount + 1;
    end
    if InventoryCount >= 5 then raise 'I CAN''T CARRY ANYMORE.';
    
    WriteLn ('O.K.');
    Item.MoveTo(Inventory);

    if Item.GetClass().HasProperty ('Event') then
    begin
        Item.Event ('GET');
    end
end

/// Drop verb.
///
procedure Drop(DirectObject : String);
var 
   Matched : Item;

begin
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if Item.Keyword = DirectObject and Item.Location = Inventory then
        begin
            Matched := Item as Item;
            break;
        end
    end
   
    if Matched = Nil then
    begin
       WriteLn('I DON''T SEEM TO BE CARRYING IT.');  
       Exit;     
    end
    if Matched.GetClass().HasProperty ('Drop') and Matched.Drop () = Handled then Exit;
    
    Matched.Location := Location;
    WriteLn('O.K. I DROPPED IT.');
end

/// Push verb
//
procedure Push(DirectObject : String);
var 
   Item : Item;

begin
    var Matched := False;
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if Item.Keyword = DirectObject and (Item.Location = Location or Item.Location = Global) then
        begin
           Matched := True;
           if Item.GetClass().HasProperty('Push') and Item.Push() = Handled then Exit;
        end 
    end
    if not Matched then raise 'I DONT SEE THAT HERE.';
    
    // TODO: Handle Keyword Collision better :)
    // Item :=  FindItem (DirectObject);
    // if Item.GetClass().HasProperty('Push') and Item.Push() = Handled then Exit;

    WriteLn('NOTHING HAPPENS.');
end

/// Pull Verb
///
procedure Pull(DirectObject : String);
var  
    Item  : Item;

begin    
    Item := FindItem (DirectObject);
    if Item.GetClass().HasProperty ('Pull') and Item.Pull () = Handled then Exit;

    WriteLn ('NOTHING HAPPENS.');
end

/// Look Verb
////
procedure Look(DirectObject : String);
var 
   Item : Item;

begin
    Item :=  FindItem (DirectObject); 
    
    if Item.GetClass().HasProperty ('Look') and Item.Look() = Handled then Exit;
    
    WriteLn('I SEE NOTHING OF INTEREST.');
end

/// Insert Verb.
///
procedure Insert (DirectObject : String);
begin
    var Item :=  FindItem (DirectObject);
    if Item.GetClass().HasProperty ('Insert') and Item.Insert() = Handled then Exit;

    raise 'I CAN''T INSERT THAT!';
end

/// Open Verb
///
procedure Open(DirectObject : String);
var
   Item     : Item;
   Openable : Boolean;

begin  
    Item :=  FindItem (DirectObject);
    if Item.GetClass().HasProperty('Open') and Item.Open() = Handled then Exit;

    Openable := Item.HasProperty('Openable') and Item.Openable;

    // Item <> LOCKED_WOODEN_DOOR and Item <> SOLID_DOOR and Item <> LOCKED_CLOSET and Item <> 15 and Item <> 23 and Item <> 32 and Item <> 5 then
    if Not Openable then
    begin
        raise 'I CAN''T OPEN THAT.';
    end
    WriteLn ('I CAN''T DO THAT......YET!');
end

/// Wear Verb
///
procedure Wear (DirectObject : String);
begin
    var Item :=  FindItem (DirectObject);
    if Item.GetClass().HasProperty('Wear') and Item.Wear() = Handled then Exit;

    WriteLn ('I CAN''T WEAR THAT!');
end

/// Read Verb
///
procedure ReadVerb(DirectObject : String);
begin
    var Item := FindItem  (DirectObject);
    if Item.GetClass().HasProperty ('Read') and Item.Read() = Handled then Exit;

    WriteLn ('I CAN''T READ THAT.');
end

/// Start Verb
///
procedure Start(DirectObject : String);
begin
    var Item :=  FindItem (DirectObject);
    if Item.GetClass().HasProperty ('Start') and Item.Start() = Handled then Exit;

    WriteLn ('I CAN''T START THAT.');
end

/// Break Verb
///
procedure BreakVerb(DirectObject : String);
begin
    var Item :=  FindItem (DirectObject);
    if Item.GetClass().HasProperty ('DoBreak') and Item.DoBreak() = Handled then Exit;

    WriteLn ('I''M TRYING TO BREAK IT, BUT I CAN''T.');
end

/// Cut Verb.
///
procedure Cut (DirectObject : String);
begin
    var Item :=  FindItem(DirectObject);

    if Item.GetClass().HasProperty('Cut') and Item.Cut() = Handled then Exit;

    raise 'I''M TRYING. IT DOESN''T WORK.';
end

/// Throw Verb.
///
procedure Throw(DirectObject : String);
begin
    var Item := FindItem (DirectObject);
    if Item.GetClass().HasProperty ('Throw') and Item.Throw () = Handled then Exit;

    WriteLn ('I CAN''T THROW THAT.');
end

/// Connect Verb
///
procedure Connect (DirectObject : String);
begin
    var Item := FindItem (DirectObject);
    if Item.GetClass().HasProperty('Connect') and Item.Connect() = Handled then Exit;
    
    raise 'I CAN''T CONNECT THAT.';
end

/// Quit Verb
///
procedure Quit();
begin
    WriteLn('WHAT? YOU WOULD LEAVE ME HERE TO DIE ALONE?');
    WriteLn('JUST FOR THAT, I''M GOING TO DESTROY THE GAME.');
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
    if Location = Cafeteria then
    begin
       WriteLn ('WHOOPS! A TRAP DOOR OPENED UNDERNEATH ME AND');
       WriteLn ('I FIND MYSELF FALLING.');
       Pause (800);
       MoveTo(SubBasement);
       DisplayRoom();
       Exit;
    end
    WriteLn ('NOTHING HAPPENED.');
end
