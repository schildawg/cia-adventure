/// A PAIR OF SLIDING DOORS
///
class SlidingDoors (Item);
begin
    /// Creates instance.
    // 
    constructor Init ();
    begin
        this.Description := 'A PAIR OF SLIDING DOORS';
        this.Keyword     := 'DOO';
        this.Location    := LOBBY;

        this.Fixed := True;
    end
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