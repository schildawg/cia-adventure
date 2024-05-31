/// A VIDEO CASSETTE RECORDER
///
class Recorder (Item);
begin
    /// Creates instance.
    // 
    constructor Init ();
    begin
        this.Description := 'A VIDEO CASSETTE RECORDER';
        this.Keyword     := 'REC';
        this.Location    := VISITORS_ROOM;

        this.Fixed := True;
    end

    /// LOOK at RECORDER
    ///
    function Look() : ResultType;
    begin
        if BatteryFlag = Off then
        begin
            WriteLn ('THERES NO POWER FOR IT.');
            Exit Handled;     
        end

        if TelevisionFlag <> On then
        begin
            WriteLn ('THERES NO T.V. TO WATCH ON.');
            Exit Handled;
        end      
    end

    // START the RECORDER.
    //
    function Start() : ResultType;
    begin
        if BatteryFlag = On and TelevisionFlag = On and TapeFlag = On then
        begin
            WriteLn ('THE RECORDER STARTS UP AND PRESENTS A SHORT MESSAGE:');
            WriteLn (Name);
            WriteLn ('WE HAVE UNCOVERED A NUMBER THAT MAY HELP YOU.');
            WriteLn ('THAT NUMBER IS:' + Code + '. PLEASE WATCH OUT FOR HIDDEN TRAPS.');
            WriteLn ('ALSO, THERE IS SOMETHING IN THE SCULPTURE.');
            Items[SCULPTURE].Flag := On;
            Exit Handled;
        end   
        Exit Passed;
    end
end
Items.Set (RECORDER, Recorder());

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

    AssertEqual (Display.Buffer(-1), 'THERES NO POWER FOR IT.');
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

    AssertEqual (Display.Buffer(-1), 'THERES NO T.V. TO WATCH ON.');
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