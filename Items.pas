/// Item
///
class Item;
var
    Description : String;
    Keyword     : String;
    Location    : Integer;

begin
    constructor Init (Description : String, Keyword : String, Location : Integer);
    begin
        this.Description := Description;
        this.Keyword := Keyword;
        this.Location := Location; 
    end
end

var RECORDER            : Integer := 1;
var TAPE                : Integer := 2;
var BATTERY             : Integer := 3;
var CREDIT_CARD         : Integer := 4;
var LOCK                : Integer := 5;
var PAPER_WEIGHT        : Integer := 6;
var LOCKED_WOODEN_DOOR  : Integer := 7;
var OPEN_WOODEN_DOOR    : Integer := 8;
var SOLID_DOOR          : Integer := 9;
var OPEN_DOOR           : Integer := 10;
var ALERT_GUARD         : Integer := 11;
var SLEEPING_GUARD      : Integer := 12;
var LOCKED_CLOSET       : Integer := 13;
var CLOSET              : Integer := 14;
var PLASTIC_BAG         : Integer := 15;
var ANTIQUE_KEY         : Integer := 16;
var METAL_SQUARE        : Integer := 17;
var LEVER               : Integer := 18;
var MAHOGANY_DESK       : Integer := 19;
var BROOM               : Integer := 20;
var DUSTPAN             : Integer := 21;
var SPIRAL_NOTEPAD      : Integer := 22;
var MAHOGANY_DRAWER     : Integer := 23;
var GLASS_CASE          : Integer := 24;
var RAZOR_BLADE         : Integer := 25;
var RUBY                : Integer := 26;
var SIGN                : Integer := 27;
var QUARTER             : Integer := 28;
var COFFEE_MACHINE      : Integer := 29;
var CUP_OF_COFFEE       : Integer := 30;
var CAPSULE             : Integer := 31;
var SCULPTURE           : Integer := 32;
var BUILDING            : Integer := 33;
var SLIDING_DOORS       : Integer := 34;
var BUTTON              : Integer := 35;
var PANEL               : Integer := 36;
var ROPE                : Integer := 37;
var HOOK                : Integer := 38;
var TELEVISION          : Integer := 40;
var MONITORS            : Integer := 41;
var ID_CARD             : Integer := 42;
var PEDISTAL_MONITOR    : Integer := 43;
var PAINTING            : Integer := 44;
var GLOVES              : Integer := 45;
var BOX                 : Integer := 46;
var ONE                 : Integer := 47;
var TWO                 : Integer := 48;
var THREE               : Integer := 49;
var SLIT                : Integer := 50;

var Items : Array := Array(51) as Array;

procedure AddItems();
begin
    Items.Set(RECORDER,      Item ('A VIDEO CASSETTE RECORDER',    'REC', VISITORS_ROOM));
    Items.Set(TAPE,          Item ('A VIDEO TAPE',                 'TAP', 0));
    Items.Set(BATTERY,       Item ('A LARGE BATTERY',              'BAT', 0));
    Items.Set(CREDIT_CARD,   Item ('A BLANK CREDIT CARD',          'CAR', 0));
    Items.Set(LOCK,          Item ('AN ELECTRONIC LOCK',           'LOC', 0));
    Items.Set(PAPER_WEIGHT,  Item ('AN ELABORATE PAPER WEIGHT',    'WEI', PRESIDENTS_ROOM));
    Items.Set(LOCKED_WOODEN_DOOR, Item ('A LOCKED WOODEN DOOR',    'DOO', ANTE_ROOM));
    Items.Set(OPEN_WOODEN_DOOR,   Item ('AN OPEN WOODEN DOOR',     'DOO', 0));
    Items.Set(SOLID_DOOR,    Item ('A SOLID LOOKING DOOR',         'DOO', SHORT_CORRIDOR));
    Items.Set(OPEN_DOOR,     Item ('AN OPEN DOOR',                 'DOO', 0));
    Items.Set(ALERT_GUARD,   Item ('AN ALERT SECURITY GUARD',      'GUA', SHORT_CORRIDOR));
    Items.Set(SLEEPING_GUARD,Item ('A SLEEPING SECURITY GUARD',    'GUA', 0));
    Items.Set(LOCKED_CLOSET, Item ('A LOCKED MAINTENANCE CLOSET',  'CLO', CAFETERIA));
    Items.Set(CLOSET,        Item ('A MAINTENANCE CLOSET',         'CLO', 0));
    Items.Set(PLASTIC_BAG,   Item ('A PLASTIC BAG',                'BAG', MAINTENANCE_CLOSET));
    Items.Set(ANTIQUE_KEY,   Item ('AN OLDE FASHIONED KEY',        'KEY', SMALL_ROOM));
    Items.Set(METAL_SQUARE,  Item ('A SMALL METAL SQUARE ON THE WALL', 'SQU', POWER_GENERATOR_ROOM));
    Items.Set(LEVER,         Item ('A LEVER ON THE SQUARE',        'LEV', POWER_GENERATOR_ROOM));
    Items.Set(MAHOGANY_DESK, Item ('AN OLD MAHOGANY DESK',         'DES', PRESIDENTS_ROOM));
    Items.Set(BROOM,         Item ('A BROOM',                      'BRO', MAINTENANCE_CLOSET));
    Items.Set(DUSTPAN,       Item ('A DUSTPAN',                    'DUS' ,MAINTENANCE_CLOSET));
    Items.Set(SPIRAL_NOTEPAD,Item ('A SPIRAL NOTEBOOK',            'NOT', 0));
    Items.Set(MAHOGANY_DRAWER, Item ('A MAHOGANY DRAWER',          'DRA', 0)); 
    Items.Set(GLASS_CASE,    Item ('A GLASS CASE ON A PEDESTAL',   'CAS', SOUND_PROOFED_CUBICLE));
    Items.Set(RAZOR_BLADE,   Item ('A RAZOR BLADE',                'BLA', BATHROOM));
    Items.Set(RUBY,          Item ('A VERY LARGE RUBY',            'RUB', 0));
    Items.Set(SIGN,          Item ('A SIGN ON THE SQUARE',         'SIG', POWER_GENERATOR_ROOM));
    Items.Set(QUARTER,       Item ('A QUARTER',                    'QUA', 0));
    Items.Set(COFFEE_MACHINE, Item ('A COFFEE MACHINE',            'MAC', SMALL_HALLWAY));
    Items.Set(CUP_OF_COFFEE, Item ('A CUP OF STEAMING HOT COFFEE', 'CUP', 0));
    Items.Set(CAPSULE,       Item ('A SMALL CAPSULE',              'CAP', 0));
    Items.Set(BUTTON,        Item ('A LARGE BUTTON ON THE WALL',   'BUT', CHAOS_CONTROL_ROOM));
    Items.Set(PANEL,         Item ('A PANEL OF BUTTONS NUMBERED ONE THRU THREE', 'PAN', SMALL_ROOM));
    Items.Set(ROPE,          Item ('A STRONG NYLON ROPE',          'ROP', SUB_BASEMENT));
    Items.Set(HOOK,          Item ('A LARGE HOOK WITH A ROPE HANGING FROM IT', 'HOO', OTHER_SIDE));
    Items.Set(TELEVISION,    Item ('A PORTABLE TELEVISION',        'TEL', SECURITY_OFFICE));
    Items.Set(PEDISTAL_MONITOR, Item ('A BANK OF MONITORS',        'MON', SECURITY_OFFICE));
    Items.Set(ID_CARD,       Item ('A CHAOS I.D. CARD',            'CAR', END_OF_COMPLEX));
    Items.Set(MONITORS,      Item ('A BANK OF MONITORS',           'MON', MONITORING_ROOM));
    Items.Set(PAINTING,      Item ('A SMALL PAINTING',             'PAI', LARGE_ROOM));
    Items.Set(GLOVES,        Item ('A PAIR OF RUBBER GLOVES',      'GLO', MAINTENANCE_CLOSET));
    Items.Set(BOX,           Item ('A BOX WITH A BUTTON ON IT',    'BOX', LABORATORY));
    Items.Set(ONE,           Item ('ONE',                         'ONE', SMALL_ROOM));
    Items.Set(TWO,           Item ('TWO',                         'TWO', SMALL_ROOM));
    Items.Set(THREE,         Item ('THREE',                       'THR', SMALL_ROOM));
    Items.Set(SLIT,          Item ('SLIT',                        'SLI', SHORT_CORRIDOR));
end