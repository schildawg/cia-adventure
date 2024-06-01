/// A PANEL OF BUTTONS NUMBERED ONE THRU THREE
///
class PanelOfButtons (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A PANEL OF BUTTONS NUMBERED ONE THRU THREE';
        this.Keyword     := 'PAN';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
    end
end

/// Button One on Panel
///
class ButtonOne (Item);
begin
    constructor Init ();
    begin
        this.Description := 'ONE';
        this.Keyword     := 'ONE';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
    end

    function Push() : ResultType;
    begin
        if Floor <> 1 then 
        begin
            Rooms[SMALL_ROOM].Exits.Set(0, LOBBY);
            Elevator (1);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// Button Two on Panel
///
class ButtonTwo (Item);
begin
    constructor Init ();
    begin
        this.Description := 'TWO';
        this.Keyword     := 'TWO';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
    end

    function Push() : ResultType;
    begin
        if Floor <> 2 then 
        begin
            Rooms[SMALL_ROOM].Exits.Set(0, SMALL_HALLWAY);
            Elevator (2);
            Exit Handled;
        end
        Exit Passed;
    end 
end

/// Button Three on Panel
///
class ButtonThree (Item);
begin
    constructor Init ();
    begin
        this.Description := 'THR';
        this.Keyword     := 'THR';
        this.Location    := SMALL_ROOM;

        this.Fixed := True;
    end

    function Push() : ResultType;
    begin
        if Floor <> 3 then 
        begin
            Rooms[SMALL_ROOM].Exits.Set(0, SHORT_CORRIDOR);
            Elevator (3);
            Exit Handled;
        end
        Exit Passed;
    end 
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