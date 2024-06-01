/// AN OLD MAHOGANY DESK
///
class MohoganyDesk (Item);
begin
    constructor Init ();
    begin
        this.Description := 'AN OLD MAHOGANY DESK';
        this.Keyword     := 'DES';
        this.Location    := PRESIDENTS_OFFICE;

        this.Fixed := True;
    end

    /// LOOK at DESK
    ///
    function Look() : ResultType;
    begin
       WriteLn('I CAN SEE A LOCKED DRAWER IN IT.');
       Exit Handled;
    end
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