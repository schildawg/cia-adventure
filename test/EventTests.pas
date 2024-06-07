// Time is 1
//
test 'TURN 1';
begin
    Setup ();
    Time := 1;

    Events();

    AssertEqual (Display.Buffer(-2), 'WRITING ON THE WALL SAYS:');
    AssertEqual (Display.Buffer(-1), 'IF YOU WANT INSTRUCTIONS TYPE:ORDERS PLEASE');
end

// Time is > 375
//
test 'TURN 376';
begin
    Setup ();
    Time := 376;

    Events();

    AssertEqual (Display.Buffer(-1), 'I THINK THEY ARE ON TO ME....I HEAR NOISES.');
end

// Time is = 400
//
test 'TURN 400';
begin
    Setup ();
    Time := 400;

    Events();

    AssertEqual (Display.Buffer(-3), 'OH NO! THEY CAUGHT UP TO ME! HELP! THEY''RE PULLING OUT GUNS!');
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// GUARD wakes up when DrugCount is 0
//
test 'GUARD wakes up';
begin
    Setup ();
    DrugCounter := 0;

    Events();

    AssertEqual (Display.Buffer(-1), 'I HEAR A NOISE LIKE SOMEONE IS YAWNING.');
    AssertEqual (-1, DrugCounter);
    AssertTrue (Guns);
end