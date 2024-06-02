
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