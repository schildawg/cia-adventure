// "INVENTORY" Verb.
//
procedure Inventory();
var
   HasInventory : Boolean;

begin
    HasInventory := False;
   
    WriteLn('WE ARE PRESENTLY CARRYING:');
    for var R := 1; R  <= 46; R := R + 1 do
    begin
        var Item := Items[R];

        if Item.Location = INVENTORY then
        begin
            HasInventory := True;
            Write (Item.Description);
            if R = GLOVES and GlovesFlag = On then Write ('. WHICH I''M WEARING.');
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
        if Direction = 'NOR' and Room.Exits[NORTH] > 0 then 
            Location := Room.Exits[NORTH] as Integer;
        
        else if Direction = 'SOU' and Room.Exits[SOUTH] > 0 then 
            Location := Room.Exits[SOUTH] as Integer;
        
        else if Direction = 'EAS' and Room.Exits[EAST] > 0 then 
            Location := Room.Exits[EAST] as Integer;
        
        else if Direction = 'WES' and Room.Exits[WEST] > 0 then 
            Location := Room.Exits[WEST] as Integer;      
        
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
    Item  : Item;

begin
    Item := FindItem (DirectObject);

    //Item <> 2 and Item <> 3 and Item <> 4 and Item <> 6 and Item <> 15 and Item <> 16 and Item <> 21 and Item <> 22 and Item <> 23 and Item <> 25 and Item <> 26 and Item <> 27 and Item <> 28 and Item <> 30 and Item <> 31 and Item <> 37 and Item <> 39 and Item <> 40 and Item <> 42 and Item <> 44 and Item <> 45 and Item <> 46 then 
    if Item.HasProperty('Fixed') and Item.Fixed then 
    begin
        raise 'I CAN''T CARRY THAT!';    
    end

    if Item.Location = INVENTORY then raise 'I ALREADY HAVE IT.';
    if InventoryCount >= 5 then raise 'I CAN''T CARRY ANYMORE.';
    
    WriteLn ('O.K.');
    Item.Location := INVENTORY;

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
    for var I := Iterator(Items); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if Item.Keyword = DirectObject and Item.Location = INVENTORY then
        begin
            Matched := Item as Item;
            break;
        end
    end
   
    if Matched = Nil then
    begin
       WriteLn('I DONT SEEM TO BE CARRYING IT.');  
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
    for var I := Iterator(Items); I.HasNext(); Nop() do
    begin
        var Item := I.Next();
        if Item.Keyword = DirectObject and (Item.Location = Location or Item.Location = GLOBAL) then
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
