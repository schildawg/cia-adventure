/// A SPIRAL NOTEBOOK
///
class SpiralNotebook (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A SPIRAL NOTEBOOK';
        this.Keyword     := 'NOT';
        this.Location    := 0;
    end

    /// LOOK at NOTEBOOK
    ///
    function Look() : ResultType;
    begin
        WriteLn ('THERES WRITING ON IT.');
        Exit Handled;    
    end

    /// READ the NOTEBOOK
    ///
    function Read() : ResultType;
    begin
        WriteLn ('IT SAYS:');
        WriteLn (Name + ',');
        WriteLn ('  WE HAVE DISCOVERED ONE OF CHAOSES SECRET WORDS.');
        WriteLn ('IT IS: BOND-007- .TO BE USED IN A -TASTEFUL- SITUATION.');
        Exit Handled;
    end
end

// GET the NOTEBOOK
//
test 'NOTEBOOK - GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[SPIRAL_NOTEBOOK].Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(INVENTORY, Items[SPIRAL_NOTEBOOK].Location);
end

// LOOK at NOTEBOOK.
//
test 'NOTEBOOK - LOOK';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[SPIRAL_NOTEBOOK].Location := PRESIDENTS_OFFICE;

    ParseCommand ('LOOK NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERES WRITING ON IT.');
end

// READ the NOTEBOOK.
//
test 'NOTEBOOK - READ';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[SPIRAL_NOTEBOOK].Location := PRESIDENTS_OFFICE;
    Name := 'JOEL';

    ParseCommand ('READ NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'IT SAYS:');
    AssertEqual (Display.Buffer(-3), 'JOEL,');
    AssertEqual (Display.Buffer(-2), '  WE HAVE DISCOVERED ONE OF CHAOSES SECRET WORDS.');
    AssertEqual (Display.Buffer(-1), 'IT IS: BOND-007- .TO BE USED IN A -TASTEFUL- SITUATION.');
end