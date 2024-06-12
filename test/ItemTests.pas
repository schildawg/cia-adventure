
// Tests dropping BADGE.
//
test 'DROP BADGE';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('DROP BADGE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
    AssertEqual (BusyStreet, Items[Badge].Location);
end

// GET the BATTERY
//
test 'BATTERY - GET';
begin
    Setup ();
    MoveTo(PresidentsOffice);
    Items[BatteryItem].MoveTo(PresidentsOffice);

    ParseCommand ('GET BATTERY');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(Inventory, Items[BatteryItem].Location);
end

// INSERT the BATTERY
//
test 'BATTERY - INSERT';
begin
    Setup ();
    MoveTo(PresidentsOffice);
    Items[BatteryItem].MoveTo(Inventory);
    Items[BatteryItem].Mock := Recorder;

    ParseCommand ('INSERT BATTERY');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(None, Items[BatteryItem].Location);
end

// Can't get A TALL OFFICE BUILDING 
// 
test 'BUILDING - CAN''T GET';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('GET BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (BusyStreet, Items[Building].Location);
end

// DROP BADGE and GO BUILDING should go to LOBBY.
// 
test 'BUILDING - GO';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('DROP BADGE');
    ParseCommand ('GO BUILDING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');     
    AssertEqual (Lobby, Location);
end

// Can't get DESK
//
test 'DESK - CAN''T GET';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('GET DESK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// LOOK at DESK
//
test 'DESK - LOOK';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('LOOK DESK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN SEE A LOCKED DRAWER IN IT.');
end


// Can't get DESK
//
test 'DRAWER - CAN''T GET';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('GET DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// LOOK at DRAWER
//
test 'DRAWER - LOOK';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('LOOK DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT LOOKS FRAGILE.');
end

// OPEN the DRAWER
//
test 'DRAWER - OPEN';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('OPEN DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT''S STUCK.');
end

// BREAK the DRAWER
//
test 'DRAWER - BREAK';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('BREAK DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// BREAK the DRAWER with WEIGHT
//
test 'DRAWER - BREAK with WEIGHT';
begin
    Setup ();
    MoveTo(PresidentsOffice);
    Items[PaperWeight].MoveTo(Inventory);

    ParseCommand ('BREAK DRAWER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT''S HARD....BUT I GOT IT. TWO THINGS FELL OUT.');
    AssertEqual (PresidentsOffice, Items[SpiralNotebook].Location);
    AssertEqual (PresidentsOffice, Items[BatteryItem].Location);
end



// Can't GET the PANEL.
//
test 'PANEL - CAN''T GET';
begin
    Setup ();
    MoveTo(SmallRoom);
    Items[ButtonOne].MoveTo(SmallRoom);

    ParseCommand ('GET PANEL');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SmallRoom, Items[PanelOfButtons].Location);
end

// Can't GET button ONE.
//
test 'ONE - CAN''T GET';
begin
    Setup ();
    MoveTo(SmallRoom);
    Items[ButtonOne].MoveTo(SmallRoom);

    ParseCommand ('GET ONE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SmallRoom, Items[ButtonOne].Location);
end

// PUSH ONE on floor one.
//
test 'ONE - PUSH FLOOR ONE';
begin
    Setup ();
    MoveTo(SmallRoom);
    Floor := 1;

    ParseCommand ('PUSH ONE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// PUSH ONE.
//
test 'ONE - PUSH';
begin
    Setup ();
    MoveTo(SmallRoom);
    Floor := 2;

    ParseCommand ('PUSH ONE');
    Events ();

    AssertEqual (Display.Buffer(-2), 'THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    AssertEqual (Display.Buffer(-1), 'SUDDENLY THE DOORS OPEN AGAIN.');
    AssertEqual (1, Floor);
end

// Can't GET button TWO.
//
test 'TWO - CAN''T GET';
begin
    Setup ();
    MoveTo(SmallRoom);

    ParseCommand ('GET TWO');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SmallRoom, Items[ButtonTwo].Location);
end

// PUSH TWO on floor two.
//
test 'TWO - PUSH FLOOR TWO';
begin
    Setup ();
    MoveTo(SmallRoom);
    Floor := 2;

    ParseCommand ('PUSH TWO');
    Events ();

    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// PUSH TWO.
//
test 'TWO - PUSH';
begin
    Setup ();
    MoveTo(SmallRoom);
    Floor := 1;

    ParseCommand ('PUSH TWO');
    Events ();

    AssertEqual (Display.Buffer(-2), 'THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    AssertEqual (Display.Buffer(-1), 'SUDDENLY THE DOORS OPEN AGAIN.');
    AssertEqual (2, Floor);
end

// Can't GET button THREE.
//
test 'THREE - CAN''T GET';
begin
    Setup ();
    MoveTo(SmallRoom);

    ParseCommand ('GET THREE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (SmallRoom, Items[ButtonThree].Location);
end

// PUSH THREE on floor three.
//
test 'THREE - PUSH FLOOR THREE';
begin
    Setup ();
    MoveTo(SmallRoom);
    Floor := 3;

    ParseCommand ('PUSH THREE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'NOTHING HAPPENS.');
end

// PUSH THREE.
//
test 'THREE - PUSH';
begin
    Setup ();
    MoveTo(SmallRoom);
    Floor := 1;

    ParseCommand ('PUSH THREE');
    Events ();

    AssertEqual (Display.Buffer(-2), 'THE DOORS CLOSE AND I FEEL AS IF THE ROOM IS MOVING.');
    AssertEqual (Display.Buffer(-1), 'SUDDENLY THE DOORS OPEN AGAIN.');
    AssertEqual (3, Floor);
end

procedure DropAll();
begin
    for var I := Iterator(Items.Values()); I.HasNext(); Nop() do
    begin
       var Item := I.Next();
       if Item.Location = Inventory then Item.MoveTo(None);
    end
end

// GET the WEIGHT
//
test 'WEIGHT - GET';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    Items[PaperWeight].MoveTo(PresidentsOffice); 

    // TODO: Reset state!!!
    DropAll();

    ParseCommand ('GET WEIGHT');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(Inventory, Items[PaperWeight].Location);
end

// LOOK at WEIGHT.
//
test 'WEIGHT - LOOK';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('LOOK WEIGHT');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT LOOKS HEAVY.');
end



// Can't get RECORDER
//
test 'RECORDER - CAN''T GET';
begin
    Setup ();
    MoveTo(VisitorsRoom);

    ParseCommand ('GET RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// LOOK at RECORDER should say there's no power if no battery.
//
test 'RECORDER - LOOK NO POWER';
begin
    Setup ();
    MoveTo(VisitorsRoom);
    Items[Recorder].BatteryFlag := Off;
    Items[Recorder].TelevisionFlag := Off;
    Items[Recorder].TapeFlag := Off;

    ParseCommand ('LOOK RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S NO POWER FOR IT.');
end

// LOOK at RECORDER should say there's no T.V. if not connected.
//
test 'RECORDER - LOOK NO T.V.';
begin
    Setup ();
    MoveTo(VisitorsRoom);
    Items[Recorder].BatteryFlag := On;
    Items[Recorder].TelevisionFlag := Off;
    Items[Recorder].TapeFlag := Off;

    ParseCommand ('LOOK RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S NO T.V. TO WATCH ON.');
end

// PLAY RECORDER should work, if tape inserted!
//
test 'RECORDER - PLAY';
begin
    Setup ();
    MoveTo(VisitorsRoom);
    
    Name := 'JOEL';
    Items[Recorder].BatteryFlag := On;
    Items[Recorder].TelevisionFlag := On;
    Items[Recorder].TapeFlag := On;
    Code := '12345';

    ParseCommand ('PLAY RECORDER');
    Events ();

    AssertEqual (Display.Buffer(-5), 'THE RECORDER STARTS UP AND PRESENTS A SHORT MESSAGE:');
    AssertEqual (Display.Buffer(-4), 'JOEL');
    AssertEqual (Display.Buffer(-3), 'WE HAVE UNCOVERED A NUMBER THAT MAY HELP YOU.');
    AssertEqual (Display.Buffer(-2), 'THAT NUMBER IS:12345. PLEASE WATCH OUT FOR HIDDEN TRAPS.');
    AssertEqual (Display.Buffer(-1), 'ALSO, THERE IS SOMETHING IN THE SCULPTURE.');
end

// Can't get SCULPTURE
//
test 'SCULPTURE - CAN''T GET';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);

    ParseCommand ('GET SCULPTURE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// Can't OPEN SCULPTURE... yet
//
test 'SCULPTURE - CAN''T OPEN';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);
    Items[Sculpture].Flag := Off;

    ParseCommand ('OPEN SCULPTURE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT......YET!');
end

// Opening SCULPTURE should spawn QUARTER and CREDIT CARD.
//
test 'SCULPTURE - OPEN';
begin    
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);
    Items[Sculpture].Flag := On;

    ParseCommand ('OPEN SCULPTURE');
    Events ();

    AssertEqual (Display.Buffer(-2), 'I OPEN THE SCULPTURE.');
    AssertEqual (Display.Buffer(-1), 'SOMETHING FALLS OUT.');
    AssertEqual (Lobby, Items[Quarter].Location);
    AssertEqual (Lobby, Items[CreditCard].Location);
end


// Can't get SLIDING DOORS
//
test 'SLIDING DOORS - CAN''T GET';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);

    ParseCommand ('GET DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
end

// Can't OPEN SLIDING DOORS
//
test 'SLIDING DOORS - CAN''T OPEN';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);

    ParseCommand ('OPEN DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T OPEN THAT.');
end

// GET the NOTEBOOK
//
test 'NOTEBOOK - GET';
begin
    Setup ();
    MoveTo(PresidentsOffice);
    Items[SpiralNotebook].MoveTo(PresidentsOffice);

    ParseCommand ('GET NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K.');
    AssertEqual(Inventory, Items[SpiralNotebook].Location);
end

// LOOK at NOTEBOOK.
//
test 'NOTEBOOK - LOOK';
begin
    Setup ();
    MoveTo(PresidentsOffice);
    Items[SpiralNotebook].MoveTo(PresidentsOffice);

    ParseCommand ('LOOK NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S WRITING ON IT.');
end

// READ the NOTEBOOK.
//
test 'NOTEBOOK - READ';
begin
    Setup ();
    MoveTo(PresidentsOffice);
    Items[SpiralNotebook].MoveTo(PresidentsOffice);
    Name := 'JOEL';

    ParseCommand ('READ NOTEBOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'IT SAYS:');
    AssertEqual (Display.Buffer(-3), 'JOEL,');
    AssertEqual (Display.Buffer(-2), '  WE HAVE DISCOVERED ONE OF CHAOSES SECRET WORDS.');
    AssertEqual (Display.Buffer(-1), 'IT IS: BOND-007- .TO BE USED IN A -TASTEFUL- SITUATION.');
end


// Can't get A LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - CAN''T GET';
begin    
    // Arrange
    Setup ();
    MoveTo(AnteRoom);

    // Act
    ParseCommand ('GET DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (AnteRoom, Items[LockedWoodenDoor].Location);
end

// LOOK at LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - LOOK';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);

    // Act
    ParseCommand ('LOOK DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'IT''S LOCKED.');
end

// Can't go in LOCKED WOODEN DOOR
// 
test 'LOCKED WOODEN DOOR - CAN''T GO';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T GO THAT WAY AT THE MOMENT.');
end


// Can't OPEN the LOCKED WOODEN DOOR without KEY
// 
test 'LOCKED WOODEN DOOR - CAN''T OPEN';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);

    // Act
    ParseCommand ('OPEN DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT......YET!');
end

// OPEN the LOCKED WOODEN DOOR with KEY
// 
test 'LOCKED WOODEN DOOR - OPEN';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);
    Items[AntiqueKey].MoveTo(Inventory);

    // Act
    ParseCommand ('OPEN DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'O.K. I OPENED THE DOOR.');
    AssertEqual (None, Items[LockedWoodenDoor].Location);
    AssertEqual (AnteRoom, Items[OpenWoodenDoor].Location);
end

// Can't get AN OPEN WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - CAN''T GET';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);
    Items[LockedWoodenDoor].MoveTo(None);
    Items[OpenWoodenDoor].Location := Location;

    // Act
    ParseCommand ('GET DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I CAN''T CARRY THAT!');
    AssertEqual (AnteRoom, Items[OpenWoodenDoor].Location);
end

// LOOK at OPEN WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - LOOK';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);
    Items[LockedWoodenDoor].MoveTo(None);
    Items[OpenWoodenDoor].Location := Location;

    // Act
    ParseCommand ('LOOK DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'I SEE NOTHING OF INTEREST.');
end

// Can't go in LOCKED WOODEN DOOR
// 
test 'OPEN WOODEN DOOR - GO';
begin
    // Arrange
    Setup ();
    MoveTo(AnteRoom);
    Items[LockedWoodenDoor].MoveTo(None);
    Items[OpenWoodenDoor].Location := Location;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE COMPANY PRESIDENT''S OFFICE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN ELABORATE PAPER WEIGHT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE AN OLD MAHOGANY DESK.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO to ROPE leads to OTHER SIDE.
test 'ROPE - GO';
begin
    // Arrange
    Setup ();
    MoveTo(Ledge);
    
    Items[Rope].MoveTo(Ledge);
    Items[Rope].State    := Connected;

    // Act
    ParseCommand ('GO ROPE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-4), 'WE ARE ON THE OTHER SIDE OF THE PIT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LARGE HOOK WITH A ROPE HANGING FROM IT.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (OtherSide, Location);
end

// GO to DOOR leads to METAL HALLWAY.
//
test 'OPEN DOOR - GO';
begin
    // Arrange
    Setup ();
    MoveTo(ShortCorridor);
    Items[OpenDoor].MoveTo(ShortCorridor);
    Items[SolidDoor].MoveTo(None);
    ElectricyFlag := Off;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-3), 'WE ARE IN A HALLWAY MADE OF METAL.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST  WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (MetalHallway, Location);
end

// GO to CLOSET leads to MAINTENANCE CLOSET.
//
test 'CLOSET - GO';
begin
    // Arrange
    Setup ();
    MoveTo(Cafeteria);
    Items[LockedCloset].MoveTo(None);
    Items[MaintenanceClosetItem].MoveTo(Cafeteria);

    // Act
    ParseCommand ('GO CLOSET');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-7), 'WE ARE IN A MAINTENANCE CLOSET.');
    AssertEqual (Display.Buffer(-6), 'I CAN SEE A PLASTIC BAG.');
    AssertEqual (Display.Buffer(-5), 'I CAN SEE A BROOM.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A DUSTPAN.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF RUBBER GLOVES.');  
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (MaintenanceCloset, Location);
end

// GO to SLIDING DOOR leads to SMALL ROOM.
//
test 'SLIDING DOOR - GO';
begin
    // Arrange
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(BusyStreet);
    Items[SlidingDoors].State := Opened;

    // Act
    ParseCommand ('GO DOOR');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SMALL ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PANEL OF BUTTONS NUMBERED ONE THRU THREE.'); 
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN OLDE FASHIONED KEY.'); 
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual (SmallRoom, Location);
end

// GET PAINTING should drop a CAPSULE.
//
test 'PAINTING - GET';
begin
    // Arrange
    Setup ();
    MoveTo(LargeRoom);

    // Act
    ParseCommand ('GET PAINTING');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'O.K.');      
    AssertEqual (Display.Buffer(-1), 'SOMETHING FELL FROM THE FRAME!');
    AssertEqual (LargeRoom, Items[Capsule].Location);
end

// GET TELEVISION should disconnect it.
//
test 'TELEVISION - GET';
begin
    // Arrange
    Setup ();
    DropAll();

    MoveTo(SecurityOffice);
    Items[Television].Location := Location;

    Items[Recorder].TelevisionFlag := On;

    // Act
    ParseCommand ('GET TELEVISION');
    Events ();

    // Assert
    AssertEqual (Items[Recorder].TelevisionFlag, Off);
end


// DROP the CUP OF COFFEE results in cup shattering to bits.
//
test 'CUP OF COFFEE - DROP';
begin
    // Arrange
    Setup ();

    MoveTo(Cafeteria);
    Items[CupOfCoffee].MoveTo(Inventory);

    // Act
    ParseCommand ('DROP CUP');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'I DROPPED THE CUP BUT IT BROKE INTO SMALL PEICES.');      
    AssertEqual (Display.Buffer(-1), 'THE COFFEE SOAKED INTO THE GROUND.');
    AssertEqual(None, Items[CupOfCoffee].Location);
end

// DROP GLOVES should remove wearing them!
//
test 'GLOVES - DROP';
begin
    // Arrange
    Setup ();
    Items[Gloves].MoveTo(Inventory);
    Items[Gloves].State    := Wearing;

    // Act
    ParseCommand ('DROP GLOVES');
    Events ();

    // Assert
    AssertEqual(Default, Items[Gloves].State);
end

// DROP the CAPSULE should drop into CUP OF COFFEE if it is in Inventory.
//
test 'CAPSULE - DROP INTO COFFEE';
begin
    // Arrange
    Setup ();
    Items[Capsule].MoveTo(Inventory);
    Items[CupOfCoffee].MoveTo(Inventory);
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('DROP CAPSULE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'O.K. I DROPPED IT.');      
    AssertEqual (Display.Buffer(-1), 'BUT IT FELL IN THE COFFEE!');
    AssertEqual(None, Items[Capsule].Location);
end

// Should electrocute you if PUSH METAL SQUARE without GLOVES.
//
test 'METAL SQARE - PUSH without GLOVES';
begin
    // Arrange
    Setup ();

    MoveTo(PowerGeneratorRoom);
    Items[Gloves].State := Default;

    // Act
    ParseCommand ('PUSH SQUARE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-3), 'I''M BEING ELECTROCUTED!');
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');      
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// PUSH BUTTON turns on Flag
//
test 'BUTTON (LARGE) - PUSH';
begin
    // Arrange
    Setup ();

    MoveTo(ChaosControlRoom);
    Items[Box].MoveTo(None);
    Items[Button].Flag := Off;

    // Act
    ParseCommand ('PUSH BUTTON');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'THE BUTTON ON THE WALL GOES IN .....');      
    AssertEqual (Display.Buffer(-1), 'CLICK! SOMETHING SEEMS DIFFFERENT NOW.');
    AssertEqual(On, Items[Button].Flag);
end

// PUSH BUTTON opens SLIDING DOORS if they are Closed on Flag.
//
test 'BUTTON (SLIDING DOORS) - PUSH';
begin
    // Arrange
    Setup ();

    MoveTo(Lobby);
    Items[Badge].MoveTo(BusyStreet);

    // Act
    ParseCommand ('PUSH BUTTON');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE DOORS OPEN WITH A WHOOSH!');
    AssertEqual(On, Items[SlidingDoorsButton].Flag);
end

// PUSH BUTTON on BOX
//
test 'BUTTON (BOX) - PUSH';
begin
    // Arrange
    Setup ();

    MoveTo(ChaosControlRoom);
    Items[Box].MoveTo(Inventory);

    // Act
    ParseCommand ('PUSH BUTTON');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-6), 'I PUSH THE BUTTON ON THE BOX AND');
    AssertEqual (Display.Buffer(-5), 'THERE IS A BLINDING FLASH....');
    AssertEqual (Display.Buffer(-4), 'WE ARE ON A BUSY STREET.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A TALL OFFICE BUILDING.');

    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
    AssertEqual(BusyStreet, Location);
end


// PULL LEVER without GLOVES electrocutes you.
//
test 'LEVER - PULL without GLOVES';
begin
    // Arrange
    Setup ();

    MoveTo(PowerGeneratorRoom);
    Items[Gloves].State := Default;

    // Act
    ParseCommand ('PULL LEVER');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-4), 'THE LEVER HAS ELECTRICITY COURSING THRU IT!');
    AssertEqual (Display.Buffer(-3), 'I''M BEING ELECTROCUTED!');
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// PULL LEVER should turn off electricity.
//
test 'LEVER - PULL with GLOVES';
begin
    // Arrange
    Setup ();

    MoveTo(PowerGeneratorRoom);
    Items[Gloves].State := Wearing;
    ElectricyFlag := On;

    // Act
    ParseCommand ('PULL LEVER');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-2), 'THE LEVER GOES ALL THE WAY UP AND CLICKS.');
    AssertEqual (Display.Buffer(-1), 'SOMETHING SEEMS DIFFERENT NOW.');
    AssertEqual (Off, ElectricyFlag);
end

// LOOK at PLASTIC BAG
//
test 'PLASTIC BAG - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(MaintenanceCloset);

    // Act
    ParseCommand ('LOOK BAG');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'IT''S A VERY STRONG BAG.');
end

// LOOK at SIGN
//
test 'SIGN - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(PowerGeneratorRoom);

    // Act
    ParseCommand ('LOOK SIGN');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THERE''S WRITING ON IT.');
end

// LOOK at SLIDING DOORS
//
test 'SLIDING DOORS (OPEN) - LOOK';
begin
    // Arrange
    Setup ();

    Items[Badge].MoveTo(BusyStreet);
    Items[SlidingDoors].State := Opened;
    MoveTo(Lobby);

    // Act
    ParseCommand ('LOOK DOORS');
    Events ();

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE DOORS ARE OPEN.');
end

// LOOK at SLIDING DOORS should show button.
//
test 'SLIDING DOOR (CLOSED) - LOOK';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);
  
    ParseCommand ('LOOK DOORS');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THERE''S A BUTTON NEAR THE DOORS.');
end

// LOOK at GLASS CASE
//
test 'GLASS CASE - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(SoundProofedCubicle); 

    // Act
    ParseCommand ('LOOK CASE');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I CAN SEE A GLEAMING STONE IN IT.');
end

// LOOK at SOLID DOOR
//
test 'SOLID DOOR - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(ShortCorridor);

    // Act
    ParseCommand ('LOOK DOOR');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THERE IS A SMALL SLIT NEAR THE DOOR.');
end

// LOOK at MONITORS
//
test 'MONITORS (LEDGE) - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(MonitoringRoom);

    // Act
    ParseCommand ('LOOK MONITORS');

    // Assert    
    AssertEqual (Display.Buffer(-2), 'I SEE A METAL PIT 1000''S OF FEET DEEP ON ONE MONITOR.');
    AssertEqual (Display.Buffer(-1), 'ON THE OTHER SIDE OF THE PIT,I SEE A LARGE HOOK.');
end

// LOOK at PEDISTAL MONITORS
//
test 'MONITORS (PEDISTAL) - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(SecurityOffice);
    Items[Button].Flag := Off;

    // Act
    ParseCommand ('LOOK MONITORS');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'THE SCREEN IS DARK.');
end


// LOOK at PEDISTAL MONITORS with BUTTON 
//
test 'MONITORS (PEDISTAL) - LOOK WITH BUTTON ON';
begin
    // Arrange
    Setup ();

    MoveTo(SecurityOffice);
    Items[Button].Flag := On;

    // Act
    ParseCommand ('LOOK MONITORS');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I SEE A ROOM WITH A CASE ON A PEDESTAL IN IT.');
end


// LOOK at PAINTING.
//
test 'PAINTING - LOOK';
begin
    // Arrange
    Setup ();

    MoveTo(LargeRoom);

    // Act
    ParseCommand ('LOOK PAINTING');

    // Assert    
    AssertEqual (Display.Buffer(-1), 'I SEE A PICTURE OF A GRINNING JACKAL.');
end

// INSERT the CREDIT CARD with the ALERT GUARD.
//
test 'CREDIT CARD - INSERT with ALERT GUARD';
begin
    Setup ();
    MoveTo(ShortCorridor);
    
    Guns := False;
    Items[IdCard].MoveTo(Inventory);
    Items[CreditCard].MoveTo(Inventory);
    Items[CreditCard].Mock := Slit;

    ParseCommand ('INSERT CARD');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THE GUARD WON''T LET ME!');
end

// INSERT the CREDIT CARD with the SLEEPING GUARD.
//
test 'CREDIT CARD - INSERT with SLEEPING GUARD';
begin
    Setup ();
    MoveTo(ShortCorridor);
    
    Items[IdCard].MoveTo(Inventory);
    Items[CreditCard].MoveTo(Inventory);
    Items[CreditCard].Mock := Slit;
    DrugCounter := 10;

    ParseCommand ('INSERT CARD');
    Events ();

    AssertEqual (Display.Buffer(-2), 'POP! A SECTION OF THE WALL OPENS.....');
    AssertEqual (Display.Buffer(-1), 'REVEALING SOMETHING VERY INTERESTING.');

    AssertEqual(None, Items[CreditCard].Location);
    AssertEqual(ShortCorridor, Items[Lock].Location);
end

// INSERT the TAPE into the RECORDER
//
test 'TAPE - INSERT';
begin
    Setup ();
    MoveTo(VisitorsRoom);
    
    Items[Tape].MoveTo(Inventory);
    Items[Tape].Mock := Recorder;

    ParseCommand ('INSERT TAPE');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. THE TAPE IS IN THE RECORDER.');
    AssertEqual (On, Items[Recorder].TapeFlag);
end

// INSERT the QUARTER into the COFFEE MACHINE
//
test 'QUARTER - INSERT';
begin
    Setup ();
    MoveTo(SmallHallway);
    
    Items[Quarter].MoveTo(Inventory);
    Items[Quarter].Mock := CoffeeMachine;

    ParseCommand ('INSERT QUARTER');
    Events ();

    AssertEqual (Display.Buffer(-1), 'POP! A CUP OF COFFEE COMES OUT OF THE MACHINE.');
    AssertEqual (SmallHallway, Items[CupOfCoffee].Location);
end

// OPEN SOLID DOOR shouldn't work.
//
test 'SOLID DOOR - OPEN';
begin    
    Setup ();
    Guns := False;
    MoveTo(ShortCorridor);
    
    Items[IdCard].MoveTo(Inventory);

    ParseCommand ('OPEN DOOR');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T. IT DOESNT WORK.');
end


// OPEN LOCKED CLOSET.
//
test 'LOCKED CLOSET - OPEN';
begin
    Setup ();
    MoveTo(Cafeteria);
    
    Items[AntiqueKey].MoveTo(Inventory);

    ParseCommand ('OPEN CLOSET');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. THE CLOSET IS OPENED.');
end

// OPEN PLASTIC BAG
//
test 'PLASTIC BAG - OPEN';
begin
    Setup ();
    MoveTo(MaintenanceCloset);

    ParseCommand ('OPEN BAG');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T. IT''S TOO STRONG.');
end

// OPEN LOCK
//
test 'LOCK - OPEN';
begin
    Setup ();
    MoveTo(ShortCorridor);
    Items[IdCard].MoveTo(Inventory);
    Items[Lock].MoveTo(ShortCorridor);

    // TODO: Mock ReadLn();
    // ParseCommand ('OPEN LOCK');
    Events ();
end

// WEAR GLOVES
//
test 'GLOVES - WEAR';
begin
    Setup ();
    Items[Gloves].MoveTo(Inventory);
    MoveTo(BusyStreet);

    ParseCommand ('WEAR GLOVES');
    Events ();

    AssertEqual (Display.Buffer(-1), 'O.K. IM NOW WEARING THE GLOVES.');
    AssertEqual (Wearing, Items[Gloves].State);
end

// READ the SIGN.
//
test 'SIGN - READ';
begin
    Setup ();
    MoveTo(PowerGeneratorRoom);

    ParseCommand ('READ SIGN');
    Events ();

    AssertEqual (Display.Buffer(-1), 'IT SAYS: WATCH OUT! DANGEROUS!');
end

// CUT PLASTIC BAG with no RAZOR BLADE.
//
test 'PLASTIC BAG - CUT no RAZOR BLADE';
begin
    Setup ();
    MoveTo(MaintenanceCloset);

    ParseCommand ('CUT BAG');
    Events ();

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// CUT PLASTIC BAG
//
test 'PLASTIC BAG - CUT';
begin
    Setup ();
    MoveTo(MaintenanceCloset);
    Items[RazorBlade].MoveTo(Inventory);

    ParseCommand ('CUT BAG');
    Events ();

    AssertEqual (Display.Buffer(-1), 'RIP! THE BAG GOES TO PIECES, AND SOMETHING FALLS OUT!');
    AssertEqual (MaintenanceCloset, Items[Tape].Location);
end

// CUT GLASS CASE <-- the start of this whole obsession :D
//
test 'GLASS CASE - CUT';
begin
    Setup ();
    MoveTo(SoundProofedCubicle);
    Items[RazorBlade].MoveTo(Inventory);

    ParseCommand ('CUT CASE');

    AssertEqual (Display.Buffer(-1), 'I CUT THE CASE AND REACH IN TO PULL SOMETHING OUT.');
    AssertEqual (Inventory, Items[Ruby].Location);
end

// THROW the ROPE with no ROPE.
//
test 'ROPE - THROW no ROPE';
begin
    Setup ();
    MoveTo(Ledge);
    Items[Rope].MoveTo(Ledge);

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// THROW the ROPE drops the ROPE if not at HOOK.
//
test 'ROPE - THROW not at HOOK';
begin
    Setup ();
    MoveTo(Ledge);
    Items[Rope].MoveTo(Inventory);
    Items[Rope].Mock := 'FLOOR';

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'O.K. I THREW IT.');
    AssertEqual (Ledge, Items[Rope].Location);
end

// THROW the ROPE not on LEDGE.
//
test 'ROPE - THROW not on LEDGE';
begin
    Setup ();
    MoveTo(BusyStreet);
    Items[Rope].MoveTo(Inventory);
    Items[Rope].Mock := 'HOO';

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT YET.');
end

// THROW the ROPE.
//
test 'ROPE - THROW';
begin
    Setup ();
    MoveTo(Ledge);
    Items[Rope].MoveTo(Inventory);
    Items[Rope].Mock := 'HOO';

    ParseCommand ('THROW ROPE');

    AssertEqual (Display.Buffer(-1), 'I THREW THE ROPE AND IT SNAGGED ON THE HOOK.');
    AssertEqual (Connected, Items[Rope].State);
    AssertEqual (Location, Items[Rope].Location);
end

// CONNECT the TELEVISION.
//
test 'TELEVISION - CONNECT';
begin
    Setup ();
    Items[Recorder].TelevisionFlag := Off;
    MoveTo(VisitorsRoom);
    Items[Television].MoveTo(VisitorsRoom);

    ParseCommand ('CONNECT TELEVISION');

    AssertEqual (Display.Buffer(-1), 'O.K. THE T.V. IS CONNECTED.');
    AssertEqual (On, Items[Recorder].TelevisionFlag);
end

// CONNECT the TELEVISION already done.
//
test 'TELEVISION - CONNECT already done';
begin
    Setup ();
    Items[Recorder].TelevisionFlag := On;
    MoveTo(VisitorsRoom);
    Items[Television].MoveTo(VisitorsRoom);

    ParseCommand ('CONNECT TELEVISION');

    AssertEqual (Display.Buffer(-1), 'I DID THAT ALREADY.');
    AssertEqual (On, Items[Recorder].TelevisionFlag);
end

// CONNECT the TELEVISION can't do yet.
//
test 'TELEVISION - CAN''T CONNECT';
begin
    Setup ();
    Items[Recorder].TelevisionFlag := Off;
    MoveTo(Cafeteria);
    Items[Television].MoveTo(Cafeteria);

    ParseCommand ('CONNECT TELEVISION');

    AssertEqual (Display.Buffer(-1), 'I CAN''T DO THAT....YET!');
end
