XVEMSF4 ;DJB/VSHL**DICQ,DICRW,DID,DIEZ,DIFG,DICD,DIKZ [12/4/95 7:08pm];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DICQ ;;;
 ;;; D I C Q     Entry Display for Loop-ups
 ;;;
 ;;; 1. ENTRY POINT: DQ^DICQ
 ;;;    Use this subroutine to process a question mark response directly.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC........Global root
 ;;;    DIC(0).....Same as ^DIC
 ;;;    DIC("S")...Optional. Same as ^DIC
 ;;;    D..........Set to "B".
 ;;;    DZ.........Set to "??" to prevent "DO YOU WANT TO SEE ALL nn ENTRIES?"
 ;;;               prompt.
 ;;;***
DICRW ;;;
 ;;; D I C R W     Required Variables
 ;;;
 ;;; 1. ENTRY POINT: DT^DICRW
 ;;;
 ;;; 2. OUTPUT VARIABLES
 ;;;    DUZ......Set to zero if not already defined.
 ;;;    DUZ(0)...Set to null if not already defined. If DUZ(0)=@ enables
 ;;;             terminal break if operating system supports it.
 ;;;    IO(0)....Set to $I if IO(0) is not defined. Therefore this program should
 ;;;             not be used if user is on a device different from the home
 ;;;             terminal and IO(0) is undefined.
 ;;;    DT.......Set to the current date.
 ;;;    U........Up-arrow (^).
 ;;;***
DID ;;;
 ;;; D I D     Data Dictionary Listing
 ;;;
 ;;; 1. ENTRY POINT: EN^DID
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC........Data dictionary number
 ;;;    DIFORMAT...Equal to desired data dictionary format:
 ;;;               STANDARD, BRIEF, MODIFIED STANDARD, TEMPLATES ONLY
 ;;;               GLOBAL MAP, CONDENSED
 ;;;***
DIEZ ;;;
 ;;; D I E Z     Input Template Compilation
 ;;;
 ;;; 1. ENTRY POINT: ^DIEZ
 ;;;
 ;;; 1. ENTRY POINT: EN^DIEZ
 ;;;    Recompile an input template without user intervention.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X.......Routine name.
 ;;;    Y.......The internal entry number of template.
 ;;;    DMAX....Maximum size of compiled routines.
 ;;;***
DIFG ;;;
 ;;; D I F G     Filegrams
 ;;;
 ;;;  Refer to the VA Fileman Programmer's Manual.
 ;;;***
DICD ;;;
 ;;; D I C D     Wait Messages
 ;;;
 ;;; 1. ENTRY POINT: WAIT^DICD
 ;;;    Generates wait messages.
 ;;;***
DIKZ ;;;
 ;;; D I K Z     Cross Reference Compilation
 ;;;
 ;;; 1. ENTRY POINT: ^DIKZ
 ;;;    Compiled routines are then used when any calls to ^DIK are made.
 ;;;
 ;;; 1. ENTRY POINT: EN^DIKZ
 ;;;    Recompile a file's cross references without user intervention.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X.......Routine name.
 ;;;    Y.......The file number.
 ;;;    DMAX....Maximum size of compiled routines.
 ;;;***
