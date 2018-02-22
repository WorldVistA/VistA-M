XVEMSF2 ;DJB/VSHL**DIC [8/3/97 1:29pm];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIC ;;;
 ;;; D I C     Look-up/Add New Entries
 ;;;
 ;;; 1. ENTRY POINT: ^DIC
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC.....File number or global root ("^GLOBAL(" or "^GLOBAL(X,Y,").
 ;;;    DIC(0)....A  Ask entry
 ;;;              C  Cross reference suppression is turned off
 ;;;              E  Echo back information
 ;;;              F  Forget look-up value
 ;;;              I  Ignore special look-up program
 ;;;              L  LAYGO allowed
 ;;;              M  Multiple-index look-up allowed
 ;;;              N  Internal Number look-up allowed
 ;;;              O  Only find one entry if it matches exactly
 ;;;              Q  Question erroneous input
 ;;;              S  Suppress display of .01
 ;;;              X  EXact match required
 ;;;              Z  Zero node returned in Y(0) and external form in Y(0,0)
 ;;;    X........If DIC(0) doesn't contain A, set X=Value you want to look up.
 ;;;    DIC("A")...Prompt.
 ;;;    DIC("B")...Default answer.
 ;;;    DIC("S")...Screen. When screen is executed Y=Internal number, and naked.
 ;;;                indicator is at zero node.
 ;;;    DIC("W")...Command string executed when DIC displays each of the entries
 ;;;                that match user's input. Y and naked ref is same as DIC("S").
 ;;;                Overrides identifiers. DIC("W")="" will suppress identifiers.
 ;;;    DIC("DR")..Fields that will be asked if LAYGO and you add new entry.
 ;;;    DIC("P")...Needed to successfully add FIRST subentry to a multiple field.
 ;;;                Set it to 2nd piece of zero node of multiple field's
 ;;;                definition in ^DD. Ex: S DIC("P")=$P(^DD(2,9,0),"^",2)
 ;;;    DTIME......Number of seconds for time-out.
 ;;;    DLAYGO.....If set equal to file number, user may add a new entry.
 ;;;    DINUM......Identifies subscript at which data is to be stored.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........Y=-1   Look-up unsuccessful.
 ;;;             Y=N^S  N is the internal number, S is the .01 field.
 ;;;             Y=N^S^1  1 indicates entry has just been added.
 ;;;    Y(0).....Set to zero node if DIC(0) contains Z.
 ;;;    Y(0,0)...External form of .01 field if DIC(0) contains Z.
 ;;;    X........If DIC(0) contains A, X will store users look-up value.
 ;;;    DTOUT....Time-out occurred.
 ;;;    DUOUT....User entered "^".
 ;;;
 ;;;    Sample code where file ^DIZ(16 has multiple field 9 at node 4.
 ;;;    S DIC="^DIZ(16,",DIC(0)="QEAL" D ^DIC ;Get entry
 ;;;    S DA(1)=+Y,DIC=DIC_DA(1)_",4," ;Root of subfile
 ;;;    S DIC(0)="QEAL",DIC("P")=$P(^DD(16,9,0),"^",2)
 ;;;    D ^DIC ;Get subentry
 ;;;    S DIE=DIC KILL DIC S DA=+Y,DR="1;2" D ^DIE ;Edit multiples directly
 ;;;
 ;;; 1. ENTRY POINT: IX^DIC
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC......Global root
 ;;;    DIC(0)...Same as ^DIC
 ;;;    D........The cross reference in which to start looking. If DIC(0) contains
 ;;;             M, then DIC will continue with further cross references. If it
 ;;;             does not, then the look-up is only on the single cross reference.
 ;;;    X........If DIC(0) does not contain an A, then X must equal look-up value.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........Y=-1   Look-up unsuccessful.
 ;;;             Y=N^S  N is the internal number, S is the .01 field.
 ;;;             Y=N^S^1  1 indicates entry has just been added.
 ;;;    Y(0).....Set to zero node if DIC(0) contains Z.
 ;;;    Y(0,0)...External form of .01 field if DIC(0) contains Z.
 ;;;    X........If DIC(0) contains A, X will store users look-up value.
 ;;;    DTOUT....Time-out occurred.
 ;;;    DUOUT....User entered "^".
 ;;;
 ;;; 1. ENTRY POINT: MIX^DIC1
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    Same as IX^DIC except variable D can contain a list of xrefs
 ;;;    separated by up-arrow. If DIC(0) does not contain M, only the
 ;;;    first xref in D will be used for the look-up.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Same as IX^DIC.
 ;;;***
