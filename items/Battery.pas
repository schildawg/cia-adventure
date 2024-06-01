/// A LARGE BATTERY
///
class BatteryItem (Item);
begin
    constructor Init ();
    begin
        this.Description := 'A LARGE BATTERY';
        this.Keyword     := 'BAT';
        this.Location    := 0;

        this.Mock := Nil;
    end

    // INSERT BATTERY into RECORDER.
    //
    function Insert() : ResultType;
    var 
        IndirectObject : String;
        Item : Integer;

    begin
        if Mock = Nil then
            begin
                IndirectObject := ReadLn ('TELL ME, IN ONE WORD, INTO WHAT? ') as String;
                Item := FindItem (Copy(IndirectObject, 0, 3));
            end 
        else 
            Item := Mock as Integer;
            

        if Item = RECORDER then 
        begin
            WriteLn('O.K.');
            BatteryFlag := On;
            Items[BATTERY].Location := 0;
            Exit Handled;
        end
        WriteLn ('NOTHING HAPPENED.');
        Exit Handled;
    end 
end

// GET the BATTERY
//
test 'BATTERY - GET';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[BATTERY].Location := PRESIDENTS_OFFICE;

    ParseCommand ('GET BATTERY');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(INVENTORY, Items[BATTERY].Location);
end

// INSERT the BATTERY
//
test 'BATTERY - INSERT';
begin
    Setup ();
    Location := PRESIDENTS_OFFICE;
    Items[BATTERY].Location := INVENTORY;
    Items[BATTERY].Mock := RECORDER;

    ParseCommand ('INSERT BATTERY');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(0, Items[BATTERY].Location);
end