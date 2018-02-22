XVEMSFD ;DJB/VSHL**%RCR,DIAXU,DDIOL [07/16/94];2017-08-15  4:48 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
%RCR ;;;
 ;;; % R C R     Array Moving
 ;;;
 ;;; 1. ENTRY POINT: %XY^%RCR
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    %X.....The global or array root of an existing array.
 ;;;    %Y.....The global or array root of the target array.
 ;;;           Example: To move array X to ^TMP($J you would write:
 ;;;                       S %X="X("
 ;;;                       S %Y="^TMP($J,"
 ;;;                       D %XY^%RCR
 ;;;***
DDIOL ;;;
 ;;; D D I O L     Writer
 ;;;
 ;;;    Programmers will have to remove embedded WRITE statements from data
 ;;;    dictionaries as alternate user interfaces are developed for FM. Direct
 ;;;    writes might cause the text to display improperly in the new interface.
 ;;;
 ;;; 1. ENTRY POINT: EN^DDIOL
 ;;;    This is designed to replace WRITE statements in data dictionaries, such
 ;;;    as executable help. Each string literal passed is written on a new line.
 ;;;    Strings passed should not be longer than 70 characters.
 ;;;    
 ;;; FORMATS:  a. DO EN^DDIOL(Value)
 ;;;           b. DO EN^DDIOL(.Array)
 ;;;           c. DO EN^DDIOL("","^Global Name")
 ;;;
 ;;;     Value = Any MUMPS expression passed by value, such as a string literal
 ;;;             or a variable.
 ;;;     Array = The name of a local array passed by reference.
 ;;;                A(1) = String 1
 ;;;                A(2) = String 2
 ;;;     Global Name = Name of a global containing string literals.
 ;;;                @GlobalName@(1,0) = String 1
 ;;;                @GlobalName@(2,0) = String 2
 ;;;***
DIAXU ;;;
 ;;; D I A X U     Extract Data
 ;;;
 ;;; 1. ENTRY POINT: EN^DIAXU
 ;;;    Extracts data specified in template for a single entry, and moves
 ;;;    that data to a destination file. Source entry may be deleted.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIAXF......Global root or number of file containing source entry.
 ;;;    DIAXT......Extract template (in brackets)  in source file that
 ;;;               contains specifications of data to be extracted.
 ;;;    DIAXFE.....Internal entry number of source entry.
 ;;;    DIAXDEL....Optional. If defined, tells pgm to delete source entry.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    DIAXDA......Internal entry number of entry created in destination file.
 ;;;    DIAXNTC.....Internal entry number of validated extract template.
 ;;;
 ;;;    DIAXFE killed upon exit. DIAXF,DIAXT,DIAXDEL not killed.
 ;;;
 ;;;    DIAXNTC is flag used to determine if extract template has been validated.
 ;;;    Validation is necessary to ensure mapping information is valid. If this
 ;;;    entry point is used within a FOR loop to move several entries, kill this
 ;;;    variable outside the loop since re-validation occurs for each call within
 ;;;    the loop.
 ;;;
 ;;;    If an error occurred during extract process, the following array is
 ;;;    returned instead:
 ;;;    ^TMP("DIERR",$J,n,"TEXT",0) = ^^m^m
 ;;;    ^TMP("DIERR",$J,n,"TEXT",1:m,0) = error msg
 ;;;         n = error sequence number. DIERR can be used as a terminating
 ;;;             value when looping through this array.
 ;;;         m = Total number of nodes of msg text for error n.
 ;;;
 ;;;    DIAXDA is not defined. All input variables are left defined.
 ;;;***
