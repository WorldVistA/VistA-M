XVEMSF3 ;DJB/VSHL**DIC1,DICN [04/17/94];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIC1 ;;;
 ;;; D I C 1     Custom Look-up & File Information Setup
 ;;;
 ;;; 1. ENTRY POINT: DO^DIC1
 ;;;    If $D(DO), DO^DIC1 will QUIT. If DIC("W") is defined it won't be changed.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC......Global root
 ;;;    DIC(0)...Same as ^DIC
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    DO.......File name^file number and specifiers. This is the file
 ;;;             descriptor node. (Use letter O, not zero.)
 ;;;    DO(2)....File number and specifiers. This is the 2nd piece of DO.
 ;;;             +DO(2) will always equal the file number.
 ;;;    DIC("W")..Contains write logic for identifiers. ^DD(+DO(2),0,"ID",value)
 ;;;              Specifier I, must be in DO(2) for Fileman to look at ID nodes.
 ;;;    DO("SCR")..Contains IF statement that screens out entries. Screen is
 ;;;              applied to inquiries and printouts as well as look-ups.
 ;;;
 ;;; 1. ENTRY POINT: MIX^DIC1
 ;;;    ^DIC does look-up starting with B cross ref. You can make it do a
 ;;;    look-up on a specific set of cross references by calling DIC1 at MIX.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC......Global root
 ;;;    DIC(0)...Same as ^DIC. If it doesn't contain M, only first cross ref
 ;;;             in D will be used for look-up.
 ;;;    D........The list of cross references, separated by up-arrow.
 ;;;    X........If DIC(0) doesn't contain A, variable X must be equal to the
 ;;;             value you want to look-up.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........Y=-1   Look-up unsuccessful.
 ;;;             Y=N^S  N is the internal number, S is the .01 field.
 ;;;             Y=N^S^1  1 indicates entry has just been added.
 ;;;    Y(0).....Set to zero node if DIC(0) contains Z.
 ;;;    Y(0,0)...External form of .01 field if DIC(0) contains Z.
 ;;;    DTOUT....Time-out occurred.
 ;;;    DUOUT....User entered "^".
 ;;;***
DICN ;;;
 ;;; D I C N     Adding New Entries. YES/NO Prompts.
 ;;;
 ;;; 1. ENTRY POINT: FILE^DICN
 ;;;    You must Kill DD. If DO does not contain the characteristics of the file
 ;;;    you are adding to, then DO should be killed.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC......Global root
 ;;;    DIC(0)...Same as ^DIC
 ;;;    X........The value of the .01 field. Programmer must insure value has
 ;;;             already met input transform criteria.
 ;;;    DINUM....Optional. Identifies subscript where data is to be stored.
 ;;;    DIC("DR")..Optional. Used to input other data elements when entry is made.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    Y........Y=-1   Look-up unsuccessful. No new entry.
 ;;;             Y=N^S^1  1 indicates entry has just been added.
 ;;;    Y(0).....Set to zero node if DIC(0) contains Z.
 ;;;    Y(0,0)...External form of .01 field if DIC(0) contains Z.
 ;;;    DTOUT....Time-out occurred.
 ;;;    DUOUT....User entered "^".
 ;;;
 ;;; 1. ENTRY POINT: YN^DICN
 ;;;    Process a YES/NO response.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %........Default response. 0=No default
 ;;;                               1=YES
 ;;;                               2=NO
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;     %.......-1   User entered ^
 ;;;              0   User entered ?
 ;;;              1   User entered YES
 ;;;              2   User entered NO
 ;;;     %Y.......Actual text that the user entered.
 ;;;***
