
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

    AssertEqual (Display.Buffer(-1), 'THERE''S WRITING ON IT.');
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

// GO to ROPE leads to OTHER SIDE.
test 'ROPE - GO';
begin
    // Arrange
    Setup ();
    Location := LEDGE;
    Items[ROPE].Location := LEDGE;

    RopeFlag := On;

    // Act
    ParseCommand ('GO ROPE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-4), 'WE ARE ON THE OTHER SIDE OF THE PIT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LARGE HOOK WITH A ROPE HANGING FROM IT.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (OTHER_SIDE, Location);
end

// GO to DOOR leads to METAL HALLWAY.
//
test 'OPEN DOOR - GO';
begin
    // Arrange
    Setup ();
    Location := SHORT_CORRIDOR;
    Items[OPEN_DOOR].Location := SHORT_CORRIDOR;
    Items[SOLID_DOOR].Location := 0;
    ElectricyFlag := Off;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-3), 'WE ARE IN A HALLWAY MADE OF METAL.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST  WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (METAL_HALLWAY, Location);
end

// GO to CLOSET leads to MAINTENANCE CLOSET.
//
test 'CLOSET - GO';
begin
    // Arrange
    Setup ();
    Location := CAFETERIA;
    Items[LOCKED_CLOSET].Location := 0;
    Items[CLOSET].Location := CAFETERIA;

    // Act
    ParseCommand ('GO CLOSET');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-7), 'WE ARE IN A MAINTENANCE CLOSET.');
    AssertEqual (Display.Buffer(-6), 'I CAN SEE A PLASTIC BAG.');
    AssertEqual (Display.Buffer(-5), 'I CAN SEE A BROOM.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A DUSTPAN.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF RUBBER GLOVES.');  
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (MAINTENANCE_CLOSET, Location);
end

// GO to SLIDING DOOR leads to SMALL ROOM.
//
test 'SLIDING DOOR - GO';
begin
    // Arrange
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := BUSY_STREET;
    Door := Opened;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SMALL ROOM.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN OLDE FASHIONED KEY.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PANEL OF BUTTONS NUMBERED ONE THRU THREE.');  
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (SMALL_ROOM, Location);
end

// GET PAINTING should drop a CAPSULE.
//
test 'PAINTING - GET';
begin
    // Arrange
    Setup ();
    Location := LARGE_ROOM;

    // Act
    ParseCommand ('GET PAINTING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'O.K.');      
    AssertEqual (Display.Buffer(-1), 'SOMETHING FELL FROM THE FRAME!');
    AssertEqual (LARGE_ROOM, Items[CAPSULE].Location);
end

// GET TELEVISION should disconnect it.
//
test 'TELEVISION - GET';
begin
    // Arrange
    Setup ();
    Location := SECURITY_OFFICE;
    TelevisionFlag := On;

    // Act
    ParseCommand ('GET TELEVISION');
    Events ();

    // Assert
    AssertEqual (TelevisionFlag, Off);
end


// DROP the CUP OF COFFEE results in cup shattering to bits.
//
test 'CUP OF COFFEE - DROP';
begin
    // Arrange
    Setup ();

    Location := CAFETERIA;
    Items[CUP_OF_COFFEE].Location := INVENTORY;

    // Act
    ParseCommand ('DROP CUP');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'I DROPPED THE CUP BUT IT BROKE INTO SMALL PEICES.');      
    AssertEqual (Display.Buffer(-1), 'THE COFFEE SOAKED INTO THE GROUND.');
    AssertEqual(0, Items[CUP_OF_COFFEE].Location);
end

// DROP GLOVES should remove wearing them!
//
test 'GLOVES - DROP';
begin
    // Arrange
    Setup ();
    Items[GLOVES].Location := INVENTORY;
    GlovesFlag := On;

    // Act
    ParseCommand ('DROP GLOVES');
    Events ();

    // Assert
    AssertEqual(Off, GlovesFlag);
end

// DROP the CAPSULE should drop into CUP OF COFFEE if it is in INVENTORY.
//
test 'CAPSULE - DROP INTO COFFEE';
begin
    // Arrange
    Setup ();
    Items[CAPSULE].Location := INVENTORY;
    Items[CUP_OF_COFFEE].Location := INVENTORY;
    Location := BUSY_STREET;

    // Act
    ParseCommand ('DROP CAPSULE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'O.K. I DROPPED IT.');      
    AssertEqual (Display.Buffer(-1), 'BUT IT FELL IN THE COFFEE!');
    AssertEqual(0, Items[CAPSULE].Location);
end

// Should electrocute you if PUSH METAL SQUARE without GLOVES.
//
test 'METAL SQARE - PUSH without GLOVES';
begin
    // Arrange
    Setup ();

    Location := POWER_GENERATOR_ROOM;
    GlovesFlag := Off;

    // Act
    ParseCommand ('PUSH SQUARE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-3), 'I''M BEING ELECTROCUTED!');
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');      
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// PUSH BUTTON turns on ButtonFlag. (???)
//
test 'BUTTON (LARGE) - PUSH';
begin
    // Arrange
    Setup ();

    Location := CHAOS_CONTROL_ROOM;
    Items[BOX].Location := 0;
    ButtonFlag := Off;

    // Act
    ParseCommand ('PUSH BUTTON');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'THE BUTTON ON THE WALL GOES IN .....');      
    AssertEqual (Display.Buffer(-1), 'CLICK! SOMETHING SEEMS DIFFFERENT NOW.');
    AssertEqual(On, ButtonFlag);
end

// PUSH BUTTON opens SLIDING DOORS if they are Closed on ButtonFlag.
//
test 'BUTTON (SLIDING DOORS) - PUSH';
begin
    // Arrange
    Setup ();

    Location := LOBBY;
    Items[BADGE].Location := BUSY_STREET;

    // Act
    ParseCommand ('PUSH BUTTON');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE DOORS OPEN WITH A WHOOSH!');
    AssertEqual(On, ButtonFlag);
end

// PUSH BUTTON on BOX
//
test 'BUTTON (BOX) - PUSH';
begin
    // Arrange
    Setup ();

    Location := CHAOS_CONTROL_ROOM;
    Items[BOX].Location := INVENTORY;

    // Act
    ParseCommand ('PUSH BUTTON');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-6), 'I PUSH THE BUTTON ON THE BOX AND');
    AssertEqual (Display.Buffer(-5), 'THERE IS A BLINDING FLASH....');
    AssertEqual (Display.Buffer(-4), 'WE ARE ON A BUSY STREET.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A TALL OFFICE BUILDING.');

    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual(BUSY_STREET, Location);
end


// PULL LEVER without GLOVES electrocutes you.
//
test 'LEVER - PULL without GLOVES';
begin
    // Arrange
    Setup ();

    Location := POWER_GENERATOR_ROOM;
    GlovesFlag := Off;

    // Act
    ParseCommand ('PULL LEVER');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-4), 'THE LEVER HAS ELECTRICITY COURSING THRU IT!');
    AssertEqual (Display.Buffer(-3), 'I''M BEING ELECTROCUTED!');
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// PULL LEVER should turn off electricity.
//
test 'LEVER - PULL with GLOVES';
begin
    // Arrange
    Setup ();

    Location := POWER_GENERATOR_ROOM;
    GlovesFlag := On;
    ElectricyFlag := On;

    // Act
    ParseCommand ('PULL LEVER');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-2), 'THE LEVER GOES ALL THE WAY UP AND CLICKS.');
    AssertEqual (Display.Buffer(-1), 'SOMETHING SEEMS DIFFERENT NOW.');
    AssertEqual (Off, ElectricyFlag);
end

// LOOK at PLASTIC BAG
//
test 'PLASTIC BAG - LOOK';
begin
    // Arrange
    Setup ();

    Location := MAINTENANCE_CLOSET;

    // Act
    ParseCommand ('LOOK BAG');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'IT''S A VERY STRONG BAG.');
end

// LOOK at SIGN
//
test 'SIGN - LOOK';
begin
    // Arrange
    Setup ();

    Location := POWER_GENERATOR_ROOM;

    // Act
    ParseCommand ('LOOK SIGN');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THERE''S WRITING ON IT.');
end

// LOOK at SLIDING DOORS
//
test 'SLIDING DOORS (OPEN) - LOOK';
begin
    // Arrange
    Setup ();

    Items[BADGE].Location := BUSY_STREET;
    Location := LOBBY;
    Door := Opened;

    // Act
    ParseCommand ('LOOK DOORS');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE DOORS ARE OPEN.');
end

// LOOK at SLIDING DOORS should show button.
//
test 'SLIDING DOOR (CLOSED) - LOOK';
begin
    Setup ();
    Location := LOBBY;
    Items[BADGE].Location := 0;
  
    ParseCommand ('LOOK DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S A BUTTON NEAR THE DOORS.');
end

// LOOK at GLASS CASE
//
test 'GLASS CASE - LOOK';
begin
    // Arrange
    Setup ();

    Location := SOUND_PROOFED_CUBICLE; 

    // Act
    ParseCommand ('LOOK CASE');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I CAN SEE A GLEAMING STONE IN IT.');
end

// LOOK at SOLID DOOR
//
test 'SOLID DOOR - LOOK';
begin
    // Arrange
    Setup ();

    Location := SHORT_CORRIDOR;

    // Act
    ParseCommand ('LOOK DOOR');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THERE IS A SMALL SLIT NEAR THE DOOR.');
end

// LOOK at MONITORS
//
test 'MONITORS (LEDGE) - LOOK';
begin
    // Arrange
    Setup ();

    Location := MONITORING_ROOM;

    // Act
    ParseCommand ('LOOK MONITORS');

    // Assert    
    AssertEqual (Display.Buffer(-2), 'I SEE A METAL PIT 1000''S OF FEET DEEP ON ONE MONITOR.');
    AssertEqual (Display.Buffer(-1), 'ON THE OTHER SIDE OF THE PIT,I SEE A LARGE HOOK.');
end

// LOOK at PEDISTAL MONITORS
//
test 'MONITORS (PEDISTAL) - LOOK';
begin
    // Arrange
    Setup ();

    Location := SECURITY_OFFICE;
    ButtonFlag := Off;

    // Act
    ParseCommand ('LOOK MONITORS');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE SCREEN IS DARK.');
end


// LOOK at PEDISTAL MONITORS with BUTTON 
//
test 'MONITORS (PEDISTAL) - LOOK WITH BUTTON ON';
begin
    // Arrange
    Setup ();

    Location := SECURITY_OFFICE;
    ButtonFlag := On;

    // Act
    ParseCommand ('LOOK MONITORS');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I SEE A ROOM WITH A CASE ON A PEDESTAL IN IT.');
end


// LOOK at PAINTING.
//
test 'PAINTING - LOOK';
begin
    // Arrange
    Setup ();

    Location := LARGE_ROOM;

    // Act
    ParseCommand ('LOOK PAINTING');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I SEE A PICTURE OF A GRINNING JACKAL.');
end

// INSERT the CREDIT CARD with the ALERT GUARD.
//
test 'CREDIT CARD - INSERT with ALERT GUARD';
begin
    Setup ();
    Location := SHORT_CORRIDOR;
    
    Items[ID_CARD].Location := INVENTORY;
    Items[CREDIT_CARD].Location := INVENTORY;
    Items[CREDIT_CARD].Mock := SLIT;

    ParseCommand ('INSERT CARD');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THE GUARD WON''T LET ME!');
end

// INSERT the CREDIT CARD with the SLEEPING GUARD.
//
test 'CREDIT CARD - INSERT with SLEEPING GUARD';
begin
    Setup ();
    Location := SHORT_CORRIDOR;
    
    Items[ID_CARD].Location := INVENTORY;
    Items[CREDIT_CARD].Location := INVENTORY;
    Items[CREDIT_CARD].Mock := SLIT;
    DrugCounter := 10;

    ParseCommand ('INSERT CARD');
    Events ();

    AssertEqual (Display.Buffer(-2), 'POP! A SECTION OF THE WALL OPENS.....');
    AssertEqual (Display.Buffer(-1), 'REVEALING SOMETHING VERY INTERESTING.');

    AssertEqual(0, Items[CREDIT_CARD].Location);
    AssertEqual(SHORT_CORRIDOR, Items[LOCK].Location);
end

// INSERT the TAPE into the RECORDER
//
test 'TAPE - INSERT';
begin
    Setup ();
    Location := VISITORS_ROOM;
    
    Items[TAPE].Location := INVENTORY;
    Items[TAPE].Mock := RECORDER;

    ParseCommand ('INSERT TAPE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. THE TAPE IS IN THE RECORDER.');
    AssertEqual (On, TapeFlag);
end

// INSERT the QUARTER into the COFFEE MACHINE
//
test 'QUARTER - INSERT';
begin
    Setup ();
    Location := SMALL_HALLWAY;
    
    Items[QUARTER].Location := INVENTORY;
    Items[QUARTER].Mock := COFFEE_MACHINE;

    ParseCommand ('INSERT QUARTER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
    AssertEqual (SMALL_HALLWAY, Items[CUP_OF_COFFEE].Location);
end

// OPEN SOLID DOOR shouldn't work.
//
test 'SOLID DOOR - OPEN';
begin
    Setup ();
    Location := SHORT_CORRIDOR;
    
    Items[ID_CARD].Location := INVENTORY;

    ParseCommand ('OPEN DOOR');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T. IT DOESNT WORK.');
end


// OPEN LOCKED CLOSET.
//
test 'LOCKED CLOSET - OPEN';
begin
    Setup ();
    Location := CAFETERIA;
    
    Items[ANTIQUE_KEY].Location := INVENTORY;

    ParseCommand ('OPEN CLOSET');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. THE CLOSET IS OPENED.');
end

// OPEN PLASTIC BAG
//
test 'PLASTIC BAG - OPEN';
begin
    Setup ();
    Location := MAINTENANCE_CLOSET;

    ParseCommand ('OPEN BAG');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T. IT''S TOO STRONG.');
end

// OPEN LOCK
//
test 'LOCK - OPEN';
begin
    Setup ();
    Location := SHORT_CORRIDOR;
    Items[ID_CARD].Location := INVENTORY;
    Items[LOCK].Location := SHORT_CORRIDOR;

    // TODO: Mock ReadLn();
    // ParseCommand ('OPEN LOCK');
    Events ();
end

// WEAR GLOVES
//
test 'GLOVES - WEAR';
begin
    Setup ();
    Items[GLOVES].Location := INVENTORY;
    Location := BUSY_STREET;

    ParseCommand ('WEAR GLOVES');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. IM NOW WEARING THE GLOVES.');
    AssertEqual (On, GlovesFlag);
end

// READ the SIGN.
//
test 'SIGN - READ';
begin
    Setup ();
    Location := POWER_GENERATOR_ROOM;

    ParseCommand ('READ SIGN');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT SAYS: WATCH OUT! DANGEROUS!');
end

// CUT PLASTIC BAG with no RAZOR BLADE.
//
test 'PLASTIC BAG - CUT no RAZOR BLADE';
begin
    Setup ();
    Location := MAINTENANCE_CLOSET;

    ParseCommand ('CUT BAG');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// CUT PLASTIC BAG
//
test 'PLASTIC BAG - CUT';
begin
    Setup ();
    Location := MAINTENANCE_CLOSET;
    Items[RAZOR_BLADE].Location := INVENTORY;

    ParseCommand ('CUT BAG');
    Events ();

    AssertEqual (Display.Buffer(-1), 'RIP! THE BAG GOES TO PIECES, AND SOMETHING FALLS OUT!');
    AssertEqual (MAINTENANCE_CLOSET, Items[TAPE].Location);
end

// CUT GLASS CASE <-- the start of this whole obsession :D
//
test 'GLASS CASE - CUT';
begin
    Setup ();
    Location := SOUND_PROOFED_CUBICLE;
    Items[RAZOR_BLADE].Location := INVENTORY;

    ParseCommand ('CUT CASE');

    AssertEqual (Display.Buffer(-1), 'I CUT THE CASE AND REACH IN TO PULL SOMETHING OUT.');
    AssertEqual (INVENTORY, Items[RUBY].Location);
end

// THROW the ROPE with no ROPE.
//
test 'ROPE - THROW no ROPE';
begin
    Setup ();
    Location := LEDGE;
    Items[ROPE].Location := LEDGE;

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// THROW the ROPE drops the ROPE if not at HOOK.
//
test 'ROPE - THROW not at HOOK';
begin
    Setup ();
    Location := LEDGE;
    Items[ROPE].Location := INVENTORY;
    Items[ROPE].Mock := 'FLOOR';

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'O.K. I THREW IT.');
    AssertEqual (LEDGE, Items[ROPE].Location);
end

// THROW the ROPE not on LEDGE.
//
test 'ROPE - THROW not on LEDGE';
begin
    Setup ();
    Location := BUSY_STREET;
    Items[ROPE].Location := INVENTORY;
    Items[ROPE].Mock := 'HOO';

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// THROW the ROPE.
//
test 'ROPE - THROW';
begin
    Setup ();
    Location := LEDGE;
    Items[ROPE].Location := INVENTORY;
    Items[ROPE].Mock := 'HOO';

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'I THREW THE ROPE AND IT SNAGGED ON THE HOOK.');
    AssertEqual (On, RopeFlag);
    AssertEqual (Location, Items[ROPE].Location);
end

// CONNECT the TELEVISION.
//
test 'TELEVISION - CONNECT';
begin
    Setup ();
    TelevisionFlag := Off;
    Location := VISITORS_ROOM;
    Items[TELEVISION].Location := VISITORS_ROOM;

    ParseCommand ('CONNECT TELEVISION');

    AssertEqual (Display.Buffer(-1), 'O.K. THE T.V. IS CONNECTED.');
    AssertEqual (On, TelevisionFlag);
end

// CONNECT the TELEVISION already done.
//
test 'TELEVISION - CONNECT already done';
begin
    Setup ();
    TelevisionFlag := On;
    Location := VISITORS_ROOM;
    Items[TELEVISION].Location := VISITORS_ROOM;

    ParseCommand ('CONNECT TELEVISION');

    AssertEqual (Display.Buffer(-1), 'I DID THAT ALREADY.');
    AssertEqual (On, TelevisionFlag);
end

// CONNECT the TELEVISION can't do yet.
//
test 'TELEVISION - CAN''T CONNECT';
begin
    Setup ();
    TelevisionFlag := Off;
    Location := CAFETERIA;
    Items[TELEVISION].Location := CAFETERIA;

    ParseCommand ('CONNECT TELEVISION');

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT....YET!');
end
