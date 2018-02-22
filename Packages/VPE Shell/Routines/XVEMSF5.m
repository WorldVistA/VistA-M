XVEMSF5 ;DJB/VSHL**DIE [12/4/95 7:12pm];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIE ;;;
 ;;; D I E     Edit Data
 ;;;
 ;;; 1. ENTRY POINT: ^DIE
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIE........Global root or file number.
 ;;;    DA.........Internal entry number.
 ;;;    DR.........Fields to be edited. Examples:
 ;;;          S DR="27"  Field number.
 ;;;          S DR="27//TODAY"  Offer default prompt. Value on file overrides
 ;;;                            default.
 ;;;          S DR="27///TODAY"  "Stuffs" a value. Value is in external form
 ;;;                             and passes thru input transform.
 ;;;          S DR="27///^S X=VAR"  "Stuffs" a value stored in a variable.
 ;;;          S DR="27////2570120"  "Stuffs" a value. Value is in internal
 ;;;                             form, and doesn't pass thru input transform.
 ;;;                             Can't be used for .01 field.
 ;;;          S DR="27:60"  A range of field numbers.
 ;;;          A place holder like @1.
 ;;;          A line of M code.
 ;;;          A sequence of any of the above types separated by ";".
 ;;;          An input template enclosed in brackets.
 ;;;    DIE("NO^")..."OUTOK"         No jump. Exit ok.
 ;;;                 "BACK"          Jump back ok. No exit.
 ;;;                 "BACKOUTOK"     Jump back ok. Exit ok.
 ;;;                 "Other value"   No jump. No exit.
 ;;;    DIDEL........Override Delete Access (Set DIDEL=File number).
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    DTOUT........Time out
 ;;;
 ;;;  LOCKING: So 2 users can't edit entry at same time.
 ;;;      S DIE="^FILE(,",DA=777,DR="[EDIT]"
 ;;;      L ^FILE(777):0 I $T D ^DIE L  Q
 ;;;      W !?5,"Another user is editing this entry." Q
 ;;;
 ;;;  SPECIFIERS: When responding to EDIT WHICH FIELD prompt:
 ;;;      T.........Use Title instead of Label.
 ;;;      "xxx".....Use literal as prompt.
 ;;;      DUP.......Duplicate response to this field from entry to entry.
 ;;;      REQ.......Require an answer.
 ;;;      3T........Title.
 ;;;      3xxx......Use literal as prompt. No quotes.
 ;;;      3d........Duplicate response. Lowercase D.
 ;;;      3R........Require an answer.
 ;;;      Use "~" to combine specifiers. Ex: 3R~T
 ;;;
 ;;;  BRANCHING: Insert executable M statement in the DR string. If the code
 ;;;             sets Y, DIE will jump to that field (field must be in DR string).
 ;;;             Y may be set to place holder, e.g. @1. If Y is set to 0 or "",
 ;;;             DIE will exit. If Y is killed or never set, no branching will
 ;;;             occur. Y can be calculated using X which equals internal value
 ;;;             of field previously asked for.
 ;;;             Ex: S DR="4;I X=""YES"" S Y=10;.01;10;15"
 ;;;
 ;;;  SPECIFIC FIELDS IN MULTIPLES:
 ;;;        Multiple field 15, subfields .01 and 7:
 ;;;        S DR=".01;15;6"
 ;;;        S DR(2,16001.02)=".01;7"
 ;;;
 ;;;  CONTINUED DR STRING: If more than 245 characters.
 ;;;        S DR(2,16001.02,1)
 ;;;        S DR(2,16001.02,2)
 ;;;
 ;;;  UP-ARROW EXIT: If user up-arrowed out of ^DIE variable Y will be defined.
 ;;;
 ;;;  EDITING SUBFILE DIRECTLY: Data in subfile 16000.02 is stored on node
 ;;;        20 and you want to edit number 777, subentry 1:
 ;;;        S DIE="^FILE(777,20,"
 ;;;        S DA(1)=777
 ;;;        S DA=1
 ;;;        S DR=".01;7"
 ;;;        D ^DIE
 ;;;        Subfile zero node must be defined.
 ;;;
 ;;;  SCREENING VARIABLE POINTER: Set DIC("V"). Refer to the VA Fileman
 ;;;                              Programmer's Manual.
 ;;;
 ;;;***
