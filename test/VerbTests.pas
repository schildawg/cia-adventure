
/// Tests ORDERS PLEASE
//
test 'ORDERS PLEASE';
begin
    // Arrange
    Setup ();
    Name := 'JOEL';
    MoveTo(BusyStreet);

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

/// Tests Inventory
//
test 'INVENTORY';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

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
    MoveTo(Ledge);

    // Act
    ParseCommand ('GO NORTH');
    Events ();

    // Assert
    AssertEqual (SecretComplex, Location);
end

/// Tests GO SOUTH
//
test 'GO SOUTH';
begin
    // Arrange
    Setup ();
    MoveTo(SmallHallway);

    // Act
    ParseCommand ('GO SOUTH');
    Events ();

    // Assert
    AssertEqual (Cafeteria, Location);
end

/// Tests GO EAST
//
test 'GO EAST';
begin
    // Arrange
    Setup ();
    MoveTo(SmallHallway);

    // Act
    ParseCommand ('GO EAST');
    Events ();

    // Assert
    AssertEqual (SmallRoom, Location);
end

/// Tests GO WEST
//
test 'GO WEST';
begin
    // Arrange
    Setup ();
    MoveTo(SmallHallway);

    // Act
    ParseCommand ('GO WEST');
    Events ();

    // Assert
    AssertEqual (SecurityOffice, Location);
end

/// Tests can't GO to non-mapped direction.
//
test 'GO - CAN''T GO';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('GO NORTH');
    Events ();

    // Assert
    AssertEqual (BusyStreet, Location);
    AssertEqual (Display.Buffer(-1), 'I CAN''T GO THAT WAY AT THE MOMENT.');
end

/// Tests WALK 
//
test 'GO - WALK SYNONYM';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);
    Items[Badge].MoveTo(None);

    // Act
    ParseCommand ('WALK BUILDING');
    Events ();

    // Assert
    AssertEqual (Lobby, Location);
end


/// Tests RUN 
//
test 'GO - RUN SYNONYM';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);
    Items[Badge].MoveTo(None);

    // Act
    ParseCommand ('RUN BUILDING');
    Events ();

    // Assert
    AssertEqual (Lobby, Location);
end


/// Tests GET 
//
test 'GET';
begin
    // Arrange
    Setup ();
    MoveTo(PresidentsOffice);
    Items[PaperWeight].MoveTo(PresidentsOffice);

    // Act
    ParseCommand ('GET WEIGHT');
    Events ();

    // Assert
    AssertEqual (Inventory, Items[PaperWeight].Location);
end

/// Tests Can't GET fixed items. 
//
test 'GET - FIXED';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('GET BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (BusyStreet, Items[Building].Location);
end

/// Tests Can't GET an item already in Inventory. 
//
test 'GET - ALREADY HAVE';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

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
    MoveTo(MaintenanceCloset);

    Items[Badge].MoveTo(Inventory);
    Items[PaperWeight].MoveTo(Inventory);
    Items[Broom].MoveTo(Inventory);
    Items[Dustpan].MoveTo(Inventory);
    Items[AntiqueKey].MoveTo(Inventory);

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
    MoveTo(MaintenanceCloset);

    // Act
    ParseCommand ('TAKE BAG');
    Events ();

    // Assert
    AssertEqual (Inventory, Items[PlasticBag].Location);
end

/// Tests CARRY 
//
test 'GET - CARRY SYNONYM';
begin
    // Arrange
    Setup ();
    MoveTo(MaintenanceCloset);

    // Act
    ParseCommand ('CARRY BROOM');
    Events ();

    // Assert
    AssertEqual (Inventory, Items[Broom].Location);
end

/// Tests DROP 
//
test 'DROP';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);
    Items[Badge].MoveTo(Inventory);

    // Act
    ParseCommand ('DROP BADGE');
    Events ();

    // Assert
    AssertEqual (BusyStreet, Items[Badge].Location);
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
end

/// Tests LEAVE 
//
test 'DROP - LEAVE SYNONYM';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);
    Items[Badge].MoveTo(Inventory);

    // Act
    ParseCommand ('LEAVE BADGE');
    Events ();

    // Assert
    AssertEqual (BusyStreet, Items[Badge].Location);
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
end

/// Tests PUSH 
//
test 'PUSH - NOTHING HAPPENS';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

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

    MoveTo(Lobby);
    Items[Badge].MoveTo(BusyStreet);

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

    MoveTo(BusyStreet);

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

    MoveTo(BusyStreet);

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

    MoveTo(LargeRoom);

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

    MoveTo(LargeRoom);

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
    MoveTo(SmallHallway);
    
    Items[Quarter].MoveTo(Inventory);
    Items[Quarter].Mock := CoffeeMachine;

    ParseCommand ('PUT QUARTER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
end

// OPEN
//
test 'OPEN';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('OPEN BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T OPEN THAT.');
end

// UNLOCK.
//
test 'OPEN - UNLOCK SYNONYM';
begin
    Setup ();
    MoveTo(Cafeteria);
    
    Items[AntiqueKey].MoveTo(Inventory);

    ParseCommand ('UNLOCK CLOSET');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. THE CLOSET IS OPENED.');
end

// WEAR
//
test 'WEAR';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('WEAR BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T WEAR THAT!');
end

// READ
//
test 'READ';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('READ BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T READ THAT.');
end

// START
//
test 'START';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('START BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T START THAT.');
end

// BREAK
//
test 'BREAK';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('BREAK BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I''M TRYING TO BREAK IT, BUT I CAN''T.');
end

// CUT
//
test 'CUT';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('CUT BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I''M TRYING. IT DOESN''T WORK.');
end

// THROW
//
test 'THROW';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('THROW BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T THROW THAT.');
end

// CONNECT
//
test 'CONNECT';
begin
    Setup ();
    MoveTo(BusyStreet);

    ParseCommand ('CONNECT BUILDING');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CONNECT THAT.');
end

// ATTACH
//
test 'CONNECT - ATTACH SYNONYM';
begin
    Setup ();
    Items[Recorder].TelevisionFlag := Off;
    MoveTo(VisitorsRoom);
    Items[Television].MoveTo(VisitorsRoom);

    ParseCommand ('ATTACH TELEVISION');

    AssertEqual (Display.Buffer(-1), 'O.K. THE T.V. IS CONNECTED.');
    AssertEqual (On, Items[Recorder].TelevisionFlag);
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
    Setup ();
    MoveTo(Cafeteria);

    ParseCommand ('BOND-007');

    AssertEqual (Display.Buffer(-6), 'WHOOPS! A TRAP DOOR OPENED UNDERNEATH ME AND');
    AssertEqual (Display.Buffer(-5), 'I FIND MYSELF FALLING.');
    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SUB-BASEMENT BELOW THE CHUTE.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A STRONG NYLON ROPE.');
    //AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST  ');   <-- WHY???
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (SubBasement, Location);
end