/// Iterator!
///
class Iterator;
begin
    constructor Init (TheArray : Array);
    begin
       this.TheArray := TheArray;
       this.Current := 0;
    end

    /// Does Iterator have more items?
    //
    function HasNext () : Boolean;
    begin
       Exit Current < TheArray.Length - 1;
    end

    /// Returns next item.
    //
    function Next () : Any;
    begin
        Current := Current + 1;

        Exit TheArray.Get(Current);
    end
end

/// Hack to work around language not supporting blank lines.  TODO :)
///
procedure Nop();
begin
end
