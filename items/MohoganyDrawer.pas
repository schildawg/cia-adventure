/// A MAHOGANY DRAWER
///
class MohoganyDrawer (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A MAHOGANY DRAWER';
        this.Keyword     := 'DRA';
        this.Location    := PRESIDENTS_OFFICE;

        this.Fixed := True;
        this.Hidden := True;
    end

    /// LOOK at DRAWER
    ///
    function Look() : ResultType;
    begin
        WriteLn ('IT LOOKS FRAGILE.');
        Exit Handled;
    end

    /// OPEN the DRAWER
    ///
    function Open() : ResultType;
    begin
       WriteLn('IT''S STUCK.');
       Exit Handled;
    end

    /// BREAK the DRAWER
    ///
    function DoBreak() : ResultType;
    begin
        if Items[PAPER_WEIGHT].Location <> INVENTORY then
        begin
           WriteLn('I CAN''T DO THAT YET.');
           Exit Handled;
        end

        if Location = PRESIDENTS_OFFICE then
        begin
            WriteLn ('IT''S HARD....BUT I GOT IT. TWO THINGS FELL OUT.');
            Items[BATTERY].Location := Location;
            Items[SPIRAL_NOTEBOOK].Location := Location;
            
            Hidden := False;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENS.');
        Exit Passed;
    end
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
