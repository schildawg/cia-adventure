// LOOK should display IN A DINGY ANTE ROOM.
//
test 'IN A DINGY ANTE ROOM';
begin
    Setup ();
    MoveTo(AnteRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A DINGY ANTE ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LOCKED WOODEN DOOR.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO WEST should lead to LOBBY
//
test 'ANTE ROOM - GO WEST';
begin     
    Setup ();
    MoveTo(AnteRoom);

    Items[Badge].MoveTo(None);

    ParseCommand ('GO WEST');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SMALL BATHROOM.
//
test 'IN A SMALL BATHROOM';
begin
    Setup ();
    MoveTo(Bathroom);
    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SMALL BATHROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A RAZOR BLADE.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display the ON A BUSY STREET "room".
//
test 'ON A BUSY STREET';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);

    // Act
    ParseCommand ('LOOK');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-4), 'WE ARE ON A BUSY STREET.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A TALL OFFICE BUILDING.');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// Should win if ON BUSY STREET and has RUBY!
//
test 'BUSY STREET - WIN';
begin
    // Arrange
    Setup ();
    MoveTo(BusyStreet);
    Items[Ruby].MoveTo(Inventory);
    
    // Act
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-2), 'HURRAY! YOU''VE RECOVERED THE RUBY!');      
    AssertEqual (Display.Buffer(-1), 'YOU WIN!');
    AssertTrue (IsDone);
end

// LOOK should display IN A CAFETERIA.
//
test 'IN A CAFETERIA';
begin
    Setup ();
    MoveTo(Cafeteria);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A CAFETERIA.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LOCKED MAINTENANCE CLOSET.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN THE CHAOS CONTROL ROOM.
//
test 'IN THE CHAOS CONTROL ROOM';
begin
    Setup ();
    MoveTo(ChaosControlRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN THE CHAOS CONTROL ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LARGE BUTTON ON THE WALL.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN THE OFFICE OF THE CHIEF OF CHAOS
//
test 'IN THE OFFICE OF THE CHIEF OF CHAOS';
begin
    Setup ();
    MoveTo(ChiefsOffice);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN THE OFFICE OF THE CHIEF OF CHAOS.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  SOUTH  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A NARROW CROSS CORRIDOR.
//
test 'IN A NARROW CROSS CORRIDOR';
begin
    Setup ();
    MoveTo(CrossCorridor);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN A NARROW CROSS CORRIDOR.');  
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A CROSS EXAMINATION ROOM.
//
test 'IN A CROSS EXAMINATION ROOM';
begin
    Setup ();
    MoveTo(CrossExaminationRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN A CROSS EXAMINATION ROOM.'); 
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  SOUTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display NEAR THE END OF THE COMPLEX.
//
test 'NEAR THE END OF THE COMPLEX';
begin
    Setup ();
    MoveTo(EndOfComplex);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE NEAR THE END OF THE COMPLEX.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A CHAOS I.D. CARD.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SECRET LABORATORY.
//
test 'IN A SECRET LABORATORY';
begin
    Setup ();
    MoveTo(Laboratory);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SECRET LABORATORY.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A BOX WITH A BUTTON ON IT.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A LARGE ROOM.
//
test 'IN A LARGE ROOM';
begin
    Setup ();
    MoveTo(LargeRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A LARGE ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A SMALL PAINTING.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: SOUTH  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display ON A LEDGE IN FRONT OF A METAL PIT 1000'S OF FEET DEEP.
//
test 'ON A LEDGE IN FRONT OF A METAL PIT 1000''S OF FEET DEEP';
begin
    Setup ();
    MoveTo(Ledge);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE ON A LEDGE IN FRONT OF A METAL PIT 1000''S OF FEET DEEP.');   
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end



// LOOK should display IN THE LOBBY OF THE BUILDING.
//
test 'IN THE LOBBY OF THE BUILDING';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// Door man should throw you out if you have BADGE
//
test 'LOBBY - DOOR MAN CHECKS BADGE';
begin
    // Arrange
    Setup ();
    MoveTo(Lobby);

    // Act
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'THE DOOR MAN LOOKS AT MY BADGE AND THEN THROWS ME OUT.');  
    AssertEqual (BusyStreet, Location);
end

// PUSH BUTTON should open the DOORS.
// 
test 'LOBBY - PUSH BUTTON';
begin
    Setup ();
    MoveTo(Lobby);
    Items[Badge].MoveTo(None);
  
    ParseCommand ('PUSH BUTTON');
    Events ();

    AssertEqual (Display.Buffer(-1), 'THE DOORS OPEN WITH A WHOOSH!');
end

// LOOK should display IN A LONG CORRIDOR.
//
test 'IN A LONG CORRIDOR';
begin
    Setup ();
    MoveTo(LongCorridor);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN A LONG CORRIDOR.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: SOUTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A MAINTENANCE CLOSET.
//
test 'IN A MAINTENANCE CLOSET';
begin
    Setup ();
    MoveTo(MaintenanceCloset);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-7), 'WE ARE IN A MAINTENANCE CLOSET.');
    AssertEqual (Display.Buffer(-6), 'I CAN SEE A PLASTIC BAG.');
    AssertEqual (Display.Buffer(-5), 'I CAN SEE A BROOM.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A DUSTPAN.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF RUBBER GLOVES.');  
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A HALLWAY MADE OF METAL.
//
test 'IN A HALLWAY MADE OF METAL';
begin
    Setup ();
    MoveTo(MetalHallway);
    ElectricyFlag := Off;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN A HALLWAY MADE OF METAL.');    
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// METAL HALLWAY - Electricity not turned off :D
//
test 'METAL HALLWAY - ELECTRICITY';
begin
    Setup ();
    MoveTo(MetalHallway);
    ElectricyFlag := On;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'THE FLOOR IS WIRED WITH ELECTRICITY!');    
    AssertEqual (Display.Buffer(-3), 'IM BEING ELECTROCUTED!');     
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');      
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// LOOK should display IN A SECRET MONITORING ROOM.
//
test 'IN A SECRET MONITORING ROOM';
begin
    Setup ();
    MoveTo(MonitoringRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SECRET MONITORING ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A BANK OF MONITORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end


// LOOK should display IN THE ENTRANCE TO THE SECRET COMPLEX.
//
test 'IN THE ENTRANCE TO THE SECRET COMPLEX';
begin
    Setup ();
    MoveTo(SecretComplex);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN THE ENTRANCE TO THE SECRET COMPLEX.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: SOUTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SECURITY OFFICE.
//
test 'IN A SECURITY OFFICE';
begin
    Setup ();
    MoveTo(SecurityOffice);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SECURITY OFFICE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A PORTABLE TELEVISION.');     
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A BANK OF MONITORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display ON THE OTHER SIDE OF THE PIT.
//
test 'ON THE OTHER SIDE OF THE PIT';
begin
    Setup ();
    MoveTo(OtherSide);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE ON THE OTHER SIDE OF THE PIT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LARGE HOOK WITH A ROPE HANGING FROM IT.');     
     
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SMALL PLAIN ROOM.
//
test 'IN A SMALL PLAIN ROOM';
begin
    Setup ();
    MoveTo(PlainRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN A SMALL PLAIN ROOM.');    
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A POWER GENERATOR ROOM.
//
test 'IN A POWER GENERATOR ROOM';
begin
    Setup ();
    MoveTo(PowerGeneratorRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-6), 'WE ARE IN A POWER GENERATOR ROOM.');
    AssertEqual (Display.Buffer(-5), 'I CAN SEE A SMALL METAL SQUARE ON THE WALL.');  
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LEVER ON THE SQUARE.');  
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A SIGN ON THE SQUARE.');  
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN THE COMPANY PRESIDENTS OFFICE.
//
test 'IN THE COMPANY PRESIDENT''S OFFICE';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('LOOK');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE COMPANY PRESIDENT''S OFFICE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN ELABORATE PAPER WEIGHT.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE AN OLD MAHOGANY DESK.');
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO WEST should lead to ANTE ROOM
//
test 'PRESIDENT''S OFFICE - GO WEST';
begin
    Setup ();
    MoveTo(PresidentsOffice);

    ParseCommand ('GO WEST');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A DINGY ANTE ROOM.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A LOCKED WOODEN DOOR.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end


// LOOK should display IN A SHORT CORRIDOR.
//
test 'IN A SHORT CORRIDOR';
begin
    Setup ();
    MoveTo(ShortCorridor);
    Items[IdCard].MoveTo(Inventory);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SHORT CORRIDOR.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A SOLID LOOKING DOOR.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE AN ALERT SECURITY GUARD.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: SOUTH  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// If Guns is True, GUARD in SHORT CORRIDOR shoots you.
//
test 'SHORT CORRIDOR - GUNS';
begin
    Setup ();
    MoveTo(ShortCorridor);
    Items[IdCard].MoveTo(Inventory);

    Guns := True;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'THE GUARD DRAWS HIS GUN AND SHOOTS ME!');     
    AssertEqual (Display.Buffer(-2), 'I''M DEAD!');      
    AssertEqual (Display.Buffer(-1), 'YOU DIDN''T WIN.');
end

// GUARD kicks you out if you don't have ID CARD.
//
test 'SHORT CORRIDOR - GUARD KICKS YOU OUT';
begin
    Setup ();
    MoveTo(ShortCorridor);
    Guns := False;
    Items[IdCard].MoveTo(None);


    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-6), 'THE GUARD LOOKS AT ME SUSPICIOUSLY, THEN THROWS ME BACK.');     
    AssertEqual (SmallRoom, Location);
end

// GUARD takes CUP OF COFFEE and falls asleep.
//
test 'SHORT CORRIDOR - GUARD TAKES COFFEE';
begin
    Setup ();
    MoveTo(ShortCorridor);
    Guns := False;
    Items[IdCard].MoveTo(Inventory);
    Items[CupOfCoffee].MoveTo(Inventory);
    Items[CupOfCoffee].IsDrugged := True;

    Events ();

    AssertEqual (Display.Buffer(-2), 'THE GUARD TAKES MY COFFEE');  
    AssertEqual (Display.Buffer(-1), 'AND FALLS TO SLEEP RIGHT AWAY.'); 
    AssertEqual (ShortCorridor, Items[SleepingGuard].Location);  
end

// LOOK should display IN A SIDE CORRIDOR.
//
test 'IN A SIDE CORRIDOR';
begin
    Setup ();
    MoveTo(SideCorridor);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-3), 'WE ARE IN A SIDE CORRIDOR.'); 
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SMALL HALLWAY.
//
test 'IN A SMALL HALLWAY';
begin
    Setup ();
    MoveTo(SmallHallway);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SMALL HALLWAY.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A COFFEE MACHINE.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: SOUTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SMALL ROOM.
//
test 'IN A SMALL ROOM';
begin
    Setup ();
    MoveTo(SmallRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SMALL ROOM.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE AN OLDE FASHIONED KEY.');    
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PANEL OF BUTTONS NUMBERED ONE THRU THREE.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO NORTH should lead to LOBBY
//
test 'SMALL ROOM - GO NORTH';
begin
    Setup ();
    MoveTo(SmallRoom);
    Items[Badge].MoveTo(None);

    ParseCommand ('GO NORTH');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// LOOK should display IN A SMALL SOUND PROOFED CUBICLE.
//
test 'IN A SMALL SOUND PROOFED CUBICLE';
begin
    Setup ();
    MoveTo(SoundProofedCubicle);
    Items[Button].Flag := On;

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN A SMALL SOUND PROOFED CUBICLE.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A GLASS CASE ON A PEDESTAL.');     
    AssertEqual (Display.Buffer(-3), 'WE COULD EASILY GO: SOUTH   ');      
    AssertEqual (Display.Buffer(-2), '>--------------------------------------------------------------<');
    AssertEqual (Display.Buffer(-1), 'A SECRET DOOR SLAMS DOWN BEHIND ME!');
end

// LOOK should display IN A SUB-BASEMENT BELOW THE CHUTE.
//
test 'IN A SUB-BASEMENT BELOW THE CHUTE';
begin
    Setup ();
    MoveTo(SubBasement);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A SUB-BASEMENT BELOW THE CHUTE.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A STRONG NYLON ROPE.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end



// LOOK should display IN A VISITORS ROOM.
//
test 'IN A VISITORS ROOM';
begin
    Setup ();
    MoveTo(VisitorsRoom);

    ParseCommand ('LOOK');
    Events ();

    AssertEqual (Display.Buffer(-4), 'WE ARE IN A VISITORS ROOM.');
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A VIDEO CASSETTE RECORDER.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: EAST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end

// GO EAST should lead to LOBBY
//
test 'VISITORS ROOM - GO EAST';
begin
    Setup ();
    MoveTo(VisitorsRoom);
    Items[Badge].MoveTo(None);

    ParseCommand ('GO EAST');
    Events ();

    AssertEqual (Display.Buffer(-5), 'WE ARE IN THE LOBBY OF THE BUILDING.');
    AssertEqual (Display.Buffer(-4), 'I CAN SEE A LARGE SCULPTURE.'); 
    AssertEqual (Display.Buffer(-3), 'I CAN SEE A PAIR OF SLIDING DOORS.');     
    AssertEqual (Display.Buffer(-2), 'WE COULD EASILY GO: NORTH  EAST  WEST   ');      
    AssertEqual (Display.Buffer(-1), '>--------------------------------------------------------------<');
end