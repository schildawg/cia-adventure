/// A LARGE SCULPTURE
///
class Sculpture (Item);
begin
    /// Creates instance.
    // 
    constructor Init ();
    begin
        this.Description := 'A LARGE SCULPTURE';
        this.Keyword     := 'SCU';
        this.Location    := LOBBY;

        this.Openable := True;
        this.Flag := Off;
    end

    // Opening this SCULPTURE spawns a QUARTER and a CREDIT CARD.
    //
    function Open() : ResultType;
    begin
        if Items[QUARTER].Location = 0 and Items[CREDIT_CARD].Location = 0 and Flag = On then
        begin
            WriteLn('I OPEN THE SCULPTURE.');
            WriteLn('SOMETHING FALLS OUT.');
            
            Items[QUARTER].Location := Location;
            Items[CREDIT_CARD].Location := Location;
            Exit Handled;
        end 
        Exit Passed;
    end   
end
Items.Set (SCULPTURE, Sculpture());

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