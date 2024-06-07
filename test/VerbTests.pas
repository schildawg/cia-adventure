
/// Tests ORDERS PLEASE
//
test 'ORDERS PLEASE';
begin
    // Arrange
    Setup ();
    Name := 'JOEL';
    Location := BUSY_STREET;

    // Act
    ParseCommand ('ORDERS PLEASE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-13), 'YOUR MISSION, JOEL, IS TO RECOVER A RUBY THAT IS BEING');
    AssertEqual (Display.Buffer(-12), 'USED IN TOP SECRET GOVERNMENT PROJECTS AS A PART IN A');
    AssertEqual (Display.Buffer(-11), 'LASER PROJECTOR.');
    AssertEqual (Display.Buffer(-10), '  YOU WILL HAVE A PARTNER WHO IS NOT TOO BRIGHT AND NEEDS');
    AssertEqual (Display.Buffer(-9),  'YOU TO TELL HIM WHAT TO DO. USE TWO WORD COMMANDS LIKE:');
    AssertEqual (Display.Buffer(-8),  '');
    AssertEqual (Display.Buffer(-7), '              GET NOTEBOOK   GO WEST  LOOK DOOR');
    AssertEqual (Display.Buffer(-6),  '');
    AssertEqual (Display.Buffer(-5), 'SOME COMMANDS USE ONLY ONE WORD. EXAMPLE: INVENTORY');
    AssertEqual (Display.Buffer(-4), '  IF YOU WANT TO SEE CHANGES IN YOUR SURROUNDINGS TYPE: LOOK');
    AssertEqual (Display.Buffer(-3), 'THE RUBY HAS BEEN CAPTURED BY A SECRET SPY RING KNOWN AS');
    AssertEqual (Display.Buffer(-2), 'CHAOS. WE SUSPECT THEY ARE UNDER COVER SOMEWHERE IN THIS');
    AssertEqual (Display.Buffer(-1), 'NEIGHBORHOOD. GOOD LUCK!');
end

/// Tests INVENTORY
//
test 'INVENTORY';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('INVENTORY');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'WE ARE PRESENTLY CARRYING:');
    AssertEqual (Display.Buffer(-1), 'A C.I.A. IDENTIFICATION BADGE');
end

/// Tests GO NORTH
//
test 'GO NORTH';
begin
    // Arrange
    Setup ();
    Location := LEDGE;

    // Act
    ParseCommand ('GO NORTH');
    Events ();

    // Assert
    AssertEqual (SECRET_COMPLEX, Location);
end

/// Tests GO SOUTH
//
test 'GO SOUTH';
begin
    // Arrange
    Setup ();
    Location := SMALL_HALLWAY;

    // Act
    ParseCommand ('GO SOUTH');
    Events ();

    // Assert
    AssertEqual (CAFETERIA, Location);
end

/// Tests GO EAST
//
test 'GO EAST';
begin
    // Arrange
    Setup ();
    Location := SMALL_HALLWAY;

    // Act
    ParseCommand ('GO EAST');
    Events ();

    // Assert
    AssertEqual (SMALL_ROOM, Location);
end

/// Tests GO WEST
//
test 'GO WEST';
begin
    // Arrange
    Setup ();
    Location := SMALL_HALLWAY;

    // Act
    ParseCommand ('GO WEST');
    Events ();

    // Assert
    AssertEqual (SECURITY_OFFICE, Location);
end

/// Tests can't GO to non-mapped direction.
//
test 'GO - CAN''T GO';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('GO NORTH');
    Events ();

    // Assert
    AssertEqual (BUSY_STREET, Location);
    AssertEqual (Display.Buffer(-1), 'I CAN''T GO THAT WAY AT THE MOMENT.');
end

/// Tests WALK 
//
test 'GO - WALK SYNONYM';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;
    Items[BADGE].Location := 0;

    // Act
    ParseCommand ('WALK BUILDING');
    Events ();

    // Assert
    AssertEqual (LOBBY, Location);
end


/// Tests RUN 
//
test 'GO - RUN SYNONYM';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;
    Items[BADGE].Location := 0;

    // Act
    ParseCommand ('RUN BUILDING');
    Events ();

    // Assert
    AssertEqual (LOBBY, Location);
end


/// Tests GET 
//
test 'GET';
begin
    // Arrange
    Setup ();
    Location := PRESIDENTS_OFFICE;
    InventoryCount := 0;
    Items[PAPER_WEIGHT].Location := PRESIDENTS_OFFICE;

    // Act
    ParseCommand ('GET WEIGHT');
    Events ();

    // Assert
    AssertEqual (INVENTORY, Items[PAPER_WEIGHT].Location);
end

/// Tests Can't GET fixed items. 
//
test 'GET - FIXED';
begin
    // Arrange
    Setup ();
    InventoryCount := 0;
    Location := BUSY_STREET;

    // Act
    ParseCommand ('GET BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (BUSY_STREET, Items[BUILDING].Location);
end

/// Tests Can't GET an item already in INVENTORY. 
//
test 'GET - ALREADY HAVE';
begin
    // Arrange
    Setup ();
    InventoryCount := 0;
    Location := BUSY_STREET;

    // Act
    ParseCommand ('GET BADGE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I ALREADY HAVE IT.');
end


/// Tests Can't GET when holding too many items.
//
test 'GET - TOO MANY';
begin
    // Arrange
    Setup ();
    Location := MAINTENANCE_CLOSET;
    InventoryCount := 5;

    // Act
    ParseCommand ('GET GLOVES');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY ANYMORE.');
end

/// Tests TAKE 
//
test 'GET - TAKE SYNONYM';
begin
    // Arrange
    Setup ();
    Location := MAINTENANCE_CLOSET;
    InventoryCount := 0;

    // Act
    ParseCommand ('TAKE BAG');
    Events ();

    // Assert
    AssertEqual (INVENTORY, Items[PLASTIC_BAG].Location);
end

/// Tests CARRY 
//
test 'GET - CARRY SYNONYM';
begin
    // Arrange
    Setup ();
    Location := MAINTENANCE_CLOSET;
    InventoryCount := 0;

    // Act
    ParseCommand ('CARRY BROOM');
    Events ();

    // Assert
    AssertEqual (INVENTORY, Items[BROOM].Location);
end

/// Tests DROP 
//
test 'DROP';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;
    Items[BADGE].Location := INVENTORY;

    // Act
    ParseCommand ('DROP BADGE');
    Events ();

    // Assert
    AssertEqual (BUSY_STREET, Items[BADGE].Location);
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
end

/// Tests LEAVE 
//
test 'DROP - LEAVE SYNONYM';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;
    Items[BADGE].Location := INVENTORY;

    // Act
    ParseCommand ('LEAVE BADGE');
    Events ();

    // Assert
    AssertEqual (BUSY_STREET, Items[BADGE].Location);
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
end

/// Tests PUSH 
//
test 'PUSH - NOTHING HAPPENS';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('PUSH BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// Tests PRESS
//
test 'PUSH - PRESS SYNONYM';
begin
    // Arrange
    Setup ();

    Location := LOBBY;
    Items[BADGE].Location := BUSY_STREET;

    // Act
    ParseCommand ('PRESS BUTTON');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE DOORS OPEN WITH A WHOOSH!');
end

// Tests PULL
//
test 'PULL';
begin
    // Arrange
    Setup ();

    Location := BUSY_STREET;

    // Act
    ParseCommand ('PULL BUILDING');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// Tests LOOK
//
test 'LOOK';
begin
    // Arrange
    Setup ();

    Location := BUSY_STREET;

    // Act
    ParseCommand ('LOOK BUILDING');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I SEE NOTHING OF INTEREST.');
end

// EXAMINE
//
test 'LOOK - EXAMINE SYNONYM';
begin
    // Arrange
    Setup ();

    Location := LARGE_ROOM;

    // Act
    ParseCommand ('EXAMINE PAINTING');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I SEE A PICTURE OF A GRINNING JACKAL.');
end

// INSERT
//
test 'INSERT';
begin
    // Arrange
    Setup ();

    Location := LARGE_ROOM;

    // Act
    ParseCommand ('INSERT PAINTING');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I CAN''T INSERT THAT!');
end

// PUT!
//
test 'INSERT - PUT SYNONYM';
begin
    Setup ();
    Location := SMALL_HALLWAY;
    
    Items[QUARTER].Location := INVENTORY;
    Items[QUARTER].Mock := COFFEE_MACHINE;

    ParseCommand ('PUT QUARTER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
end

// OPEN
//
test 'OPEN';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('OPEN BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T OPEN THAT.');
end

// UNLOCK.
//
test 'OPEN - UNLOCK SYNONYM';
begin
    Setup ();
    Location := CAFETERIA;
    
    Items[ANTIQUE_KEY].Location := INVENTORY;

    ParseCommand ('UNLOCK CLOSET');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. THE CLOSET IS OPENED.');
end

// WEAR
//
test 'WEAR';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('WEAR BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T WEAR THAT!');
end

// READ
//
test 'READ';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('READ BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T READ THAT.');
end

// START
//
test 'START';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('START BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T START THAT.');
end

// BREAK
//
test 'BREAK';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('BREAK BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I''M TRYING TO BREAK IT, BUT I CAN''T.');
end

// CUT
//
test 'CUT';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('CUT BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I''M TRYING. IT DOESN''T WORK.');
end

// THROW
//
test 'THROW';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('THROW BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T THROW THAT.');
end

// CONNECT
//
test 'CONNECT';
begin
    Setup ();
    Location := BUSY_STREET;

    ParseCommand ('CONNECT BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CONNECT THAT.');
end

// ATTACH
//
test 'CONNECT - ATTACH SYNONYM';
begin
    Setup ();
    TelevisionFlag := Off;
    Location := VISITORS_ROOM;
    Items[TELEVISION].Location := VISITORS_ROOM;

    ParseCommand ('ATTACH TELEVISION');

    AssertEqual (Display.Buffer(-1), 'O.K. THE T.V. IS CONNECTED.');
    AssertEqual (On, TelevisionFlag);
end


// QUIT
//
test 'QUIT';
begin
    Setup ();

    ParseCommand ('QUIT');

    AssertEqual (Display.Buffer(-6), 'WHAT? YOU WOULD LEAVE ME HERE TO DIE ALONE?');
    AssertEqual (Display.Buffer(-5), 'JUST FOR THAT, I''M GOING TO DESTROY THE GAME.');

    AssertEqual (Display.Buffer(-1), 'BOOOOOOOOOOOOM!');
    AssertTrue (IsDone);
end

// BOND-007
//
test 'BOND-007';
begin
    Display.Output := DEBUG;
    Setup ();
    Location := CAFETERIA;

    ParseCommand ('BOND-007');

    AssertEqual (Display.Buffer(-6), 'WHOOPS! A TRAP DOOR OPENED UNDERNEATH ME AND');
    AssertEqual (Display.Buffer(-5), 'I FIND MYSELF FALLING.');
    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SUB-BASEMENT BELOW THE CHUTE.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A STRONG NYLON ROPE.');
    //AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST  ');   <-- WHY???
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (SUB_BASEMENT, Location);
end