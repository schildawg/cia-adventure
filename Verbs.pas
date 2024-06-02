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
            if R = GLOVES and GlovesFlag = On then Write ('. WHICH IM WEARING.');
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

