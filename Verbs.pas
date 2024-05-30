
var Verbs : Array := Array(18) as Array;

procedure AddVerbs();
begin
    Verbs.Set(0, 'GO ');
    Dispatch.Put ('GO ', Go);

    Verbs.Set(1, 'GET');
    Dispatch.Put ('GET', Get);

    Verbs.Set(2, 'DRO');
    Dispatch.Put ('DRO', Drop);

    Verbs.Set(3, 'PUS');
    Dispatch.Put ('PUS', Push);

    Verbs.Set(4, 'PUL');
    
    Verbs.Set(5, 'LOO');
    Dispatch.Put ('LOO', Look);

    Verbs.Set(6, 'INS');

    Verbs.Set(7, 'OPE');
    Dispatch.Put ('OPE', Open);

    Verbs.Set(8, 'WEA');
    Verbs.Set(9, 'REA');
    Verbs.Set(10, 'STA');
    Verbs.Set(11, 'BRE');
    Verbs.Set(12, 'CUT');
    Verbs.Set(13, 'THR');
    Verbs.Set(14, 'CON');
    Verbs.Set(15, 'QUI');
    Verbs.Set(16, 'BON');
    Verbs.Set(17, 'INV');
end