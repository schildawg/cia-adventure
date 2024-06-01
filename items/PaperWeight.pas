/// AN ELABORATE PAPER WEIGHT
///
class PaperWeight (Item);
begin
    constructor Init ();
    begin
        this.Description := 'AN ELABORATE PAPER WEIGHT';
        this.Keyword     := 'WEI';
        this.Location    := PRESIDENTS_OFFICE;
    end

    /// LOOK at WEIGHT
    ///
    function Look() : ResultType;
    begin
        WriteLn('IT LOOKS HEAVY.');
        Exit Handled;     
    end

end

// GET the WEIGHT
//
test 'WEIGHT - GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET WEIGHT');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(INVENTORY, Items[PAPER_WEIGHT].Location);
end

// LOOK at WEIGHT.
//
test 'WEIGHT - LOOK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK WEIGHT');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT LOOKS HEAVY.');
end