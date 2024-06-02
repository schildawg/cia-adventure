
// Tests dropping BADGE.
//
test 'DROP BADGE';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('DROP BADGE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
    AssertEqual (BUSY_STREET, Items[BADGE].Location);
end



// GET the BATTERY
//
test 'BATTERY - GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[BATTERY].Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET BATTERY');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(INVENTORY, Items[BATTERY].Location);
end

// INSERT the BATTERY
//
test 'BATTERY - INSERT';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[BATTERY].Location := INVENTORY;
    Items[BATTERY].Mock := RECORDER;

    ParseCommand ('INSERT BATTERY');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(0, Items[BATTERY].Location);
end

// Can't get A TALL OFFICE BUILDING 
// 
test 'BUILDING - CAN''T GET';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('GET BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (BUSY_STREET, Items[BUILDING].Location);
end

// DROP BADGE and GO BUILDING should go to LOBBY.
// 
test 'BUILDING - GO';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('DROP BADGE');
    ParseCommand ('GO BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');     
    AssertEqual (LOBBY, Location);
end

// Can't get DESK
//
test 'DESK - CAN''T GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET DESK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// LOOK at DESK
//
test 'DESK - LOOK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK DESK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN SEE A LOCKED DRAWER IN IT.');
end


// Can't get DESK
//
test 'DRAWER - CAN''T GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// LOOK at DRAWER
//
test 'DRAWER - LOOK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT LOOKS FRAGILE.');
end

// OPEN the DRAWER
//
test 'DRAWER - OPEN';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('OPEN DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT''S STUCK.');
end

// BREAK the DRAWER
//
test 'DRAWER - BREAK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('BREAK DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// BREAK the DRAWER with WEIGHT
//
test 'DRAWER - BREAK with WEIGHT';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[PAPER_WEIGHT].Location := INVENTORY;

    ParseCommand ('BREAK DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT''S HARD....BUT I GOT IT. TWO THINGS FELL OUT.');
    AssertEqual (PRESIDENTS_OFFICE, Items[SPIRAL_NOTEBOOK].Location);
    AssertEqual (PRESIDENTS_OFFICE, Items[BATTERY].Location);
end



// Can't GET the PANEL.
//
test 'PANEL - CAN''T GET';
begin
    Setup ();
    Location := SMALL_ROOM;
    Items[ONE].Location := SMALL_ROOM;

    ParseCommand ('GET PANEL');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SMALL_ROOM, Items[PANEL].Location);
end

// Can't GET button ONE.
//
test 'ONE - CAN''T GET';
begin
    Setup ();
    Location := SMALL_ROOM;
    Items[ONE].Location := SMALL_ROOM;

    ParseCommand ('GET ONE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SMALL_ROOM, Items[ONE].Location);
end


// PUSH ONE on floor one.
//
test 'ONE - PUSH FLOOR ONE';
begin
    Setup ();
    Location := SMALL_ROOM;
    Floor := 1;

    ParseCommand ('PUSH ONE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// PUSH ONE.
//
test 'ONE - PUSH';
begin
    Setup ();
    Location := SMALL_ROOM;
    Floor := 2;

    ParseCommand ('PUSH ONE');
    Events ();

    AssertEqual (Display.Buffer(-2), 'THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    AssertEqual (Display.Buffer(-1), 'SUDDENLY THE DOORS OPEN AGAIN.');
    AssertEqual (1, Floor);
end

// Can't GET button TWO.
//
test 'TWO - CAN''T GET';
begin
    Setup ();
    Location := SMALL_ROOM;

    ParseCommand ('GET TWO');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SMALL_ROOM, Items[TWO].Location);
end

// PUSH TWO on floor two.
//
test 'TWO - PUSH FLOOR TWO';
begin
    Setup ();
    Location := SMALL_ROOM;
    Floor := 2;

    ParseCommand ('PUSH TWO');
    Events ();

    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// PUSH TWO.
//
test 'TWO - PUSH';
begin
    Setup ();
    Location := SMALL_ROOM;
    Floor := 1;

    ParseCommand ('PUSH TWO');
    Events ();

    AssertEqual (Display.Buffer(-2), 'THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    AssertEqual (Display.Buffer(-1), 'SUDDENLY THE DOORS OPEN AGAIN.');
    AssertEqual (2, Floor);
end

// Can't GET button THREE.
//
test 'THREE - CAN''T GET';
begin
    Setup ();
    Location := SMALL_ROOM;

    ParseCommand ('GET THREE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SMALL_ROOM, Items[THREE].Location);
end

// PUSH THREE on floor three.
//
test 'THREE - PUSH FLOOR THREE';
begin
    Setup ();
    Location := SMALL_ROOM;
    Floor := 3;

    ParseCommand ('PUSH THREE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// PUSH THREE.
//
test 'THREE - PUSH';
begin
    Setup ();
    Location := SMALL_ROOM;
    Floor := 1;

    ParseCommand ('PUSH THREE');
    Events ();

    AssertEqual (Display.Buffer(-2), 'THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    AssertEqual (Display.Buffer(-1), 'SUDDENLY THE DOORS OPEN AGAIN.');
    AssertEqual (3, Floor);
end



// GET the WEIGHT
//
test 'WEIGHT - GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET WEIGHT');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(INVENTORY, Items[PAPER_WEIGHT].Location);
end

// LOOK at WEIGHT.
//
test 'WEIGHT - LOOK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK WEIGHT');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT LOOKS HEAVY.');
end



// Can't get RECORDER
//
test 'RECORDER - CAN''T GET';
begin
    Setup ();
    Location := VISITORS_ROOM;

    ParseCommand ('GET RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// LOOK at RECORDER should say there's no power if no battery.
//
test 'RECORDER - LOOK NO POWER';
begin
    Setup ();
    Location := VISITORS_ROOM;
    BatteryFlag := Off;
    TelevisionFlag := Off;
    TapeFlag := Off;

    ParseCommand ('LOOK RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S NO POWER FOR IT.');
end

// LOOK at RECORDER should say there's no T.V. if not connected.
//
test 'RECORDER - LOOK NO T.V.';
begin
    Setup ();
    Location := VISITORS_ROOM;
    BatteryFlag := On;
    TelevisionFlag := Off;
    TapeFlag := Off;

    ParseCommand ('LOOK RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S NO T.V. TO WATCH ON.');
end

// PLAY RECORDER should work, if tape inserted!
//
test 'RECORDER - PLAY';
begin
    Setup ();
    Location := VISITORS_ROOM;
    
    Name := 'JOEL';
    BatteryFlag := On;
    TelevisionFlag := On;
    TapeFlag := On;
    Code := '12345';

    ParseCommand ('PLAY RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-5), 'THE RECORDER STARTS UP AND PRESENTS A SHORT MESSAGE:');
    AssertEqual (Display.Buffer(-4), 'JOEL');
    AssertEqual (Display.Buffer(-3), 'WE HAVE UNCOVERED A NUMBER THAT MAY HELP YOU.');
    AssertEqual (Display.Buffer(-2), 'THAT NUMBER IS:12345. PLEASE WATCH OUT FOR HIDDEN TRAPS.');
    AssertEqual (Display.Buffer(-1), 'ALSO, THERE IS SOMETHING IN THE SCULPTURE.');
end



// Can't get SCULPTURE
//
test 'SCULPTURE - CAN''T GET';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;

    ParseCommand ('GET SCULPTURE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// Can't OPEN SCULPTURE... yet
//
test 'SCULPTURE - CAN''T OPEN';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;
    Items[SCULPTURE].Flag := Off;

    ParseCommand ('OPEN SCULPTURE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT......YET!');
end

// Opening SCULPTURE should spawn QUARTER and CREDIT CARD.
//
test 'SCULPTURE - OPEN';
begin    
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;
    Items[SCULPTURE].Flag := On;

    ParseCommand ('OPEN SCULPTURE');
    Events ();

    AssertEqual (Display.Buffer(-2), 'I OPEN THE SCULPTURE.');
    AssertEqual (Display.Buffer(-1), 'SOMETHING FALLS OUT.');
    AssertEqual (LOBBY, Items[QUARTER].Location);
    AssertEqual (LOBBY, Items[CREDIT_CARD].Location);
end


// Can't get SLIDING DOORS
//
test 'SLIDING DOORS - CAN''T GET';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;

    ParseCommand ('GET DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// Can't OPEN SLIDING DOORS
//
test 'SLIDING DOORS - CAN''T OPEN';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;

    ParseCommand ('OPEN DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T OPEN THAT.');
end

// LOOK at SLIDING DOORS should show button.
//
test 'SLIDING DOORS - LOOK';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;
  
    ParseCommand ('LOOK DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERES A BUTTON NEAR THE DOORS.');
end



// GET the NOTEBOOK
//
test 'NOTEBOOK - GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[SPIRAL_NOTEBOOK].Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(INVENTORY, Items[SPIRAL_NOTEBOOK].Location);
end

// LOOK at NOTEBOOK.
//
test 'NOTEBOOK - LOOK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[SPIRAL_NOTEBOOK].Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERES WRITING ON IT.');
end

// READ the NOTEBOOK.
//
test 'NOTEBOOK - READ';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[SPIRAL_NOTEBOOK].Location := PRESIDENTS_OFFICE;
    Name := 'JOEL';

    ParseCommand ('READ NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'IT SAYS:');
    AssertEqual (Display.Buffer(-3), 'JOEL,');
    AssertEqual (Display.Buffer(-2), '  WE HAVE DISCOVERED ONE OF CHAOSES SECRET WORDS.');
    AssertEqual (Display.Buffer(-1), 'IT IS: BOND-007- .TO BE USED IN A -TASTEFUL- SITUATION.');
end


// Can't get A LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - CAN''T GET';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('GET DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (ANTE_ROOM, Items[LOCKED_WOODEN_DOOR].Location);
end

// LOOK at LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - LOOK';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('LOOK DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'IT''S LOCKED.');
end

// Can't go in LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - CAN''T GO';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T GO THAT WAY AT THE MOMENT.');
end


// Can't OPEN the LOCKED WOODEN DOOR without KEY
// 
test 'LOCKED WOODEN DOOR - CAN''T OPEN';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;

    // Act
    ParseCommand ('OPEN DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT......YET!');
end

// OPEN the LOCKED WOODEN DOOR with KEY
// 
test 'LOCKED WOODEN DOOR - OPEN';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[ANTIQUE_KEY].Location := INVENTORY;

    // Act
    ParseCommand ('OPEN DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'O.K. I OPENED THE DOOR.');
    AssertEqual (0, Items[LOCKED_WOODEN_DOOR].Location);
    AssertEqual (ANTE_ROOM, Items[OPEN_WOODEN_DOOR].Location);
end

// Can't get AN OPEN WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - CAN''T GET';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[LOCKED_WOODEN_DOOR].Location := 0;
    Items[OPEN_WOODEN_DOOR].Location := Location;

    // Act
    ParseCommand ('GET DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (ANTE_ROOM, Items[OPEN_WOODEN_DOOR].Location);
end

// LOOK at OPEN WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - LOOK';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[LOCKED_WOODEN_DOOR].Location := 0;
    Items[OPEN_WOODEN_DOOR].Location := Location;

    // Act
    ParseCommand ('LOOK DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I SEE NOTHING OF INTEREST.');
end

// Can't go in LOCKED WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - GO';
begin
    // Arrange
    Setup ();
    Location := ANTE_ROOM;
    Items[LOCKED_WOODEN_DOOR].Location := 0;
    Items[OPEN_WOODEN_DOOR].Location := Location;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE COMPANY PRESIDENT''S OFFICE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN ELABORATE PAPER WEIGHT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE AN OLD MAHOGANY DESK.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end