var BADGE : Integer := 39;

/// A C.I.A. IDENTIFICATION BADGE
///
class Badge (Item);
begin
    /// Creates instance.
    // 
    constructor Init ();
    begin
        this.Description := 'A C.I.A. IDENTIFICATION BADGE';
        this.Keyword     := 'BAD';
        this.Location    := INVENTORY;
    end
end
Items.Set (BADGE, Badge());

// Tests dropping BADGE.
//
test 'DROP BADGE';
begin
    // Arrange
    Setup ();
    Location := BUSY_STREET;

    // Act
    ParseCommand ('DROP BADGE');
    Events ();

    // Assert
    AssertEqual (Display.Buffer(-1), 'O.K. I DROPPED IT.');
    AssertEqual (BUSY_STREET, Items[BADGE].Location);
end
