XVEMSF1 ;DJB/VSHL**DDS,DIAC,DIB,DIM,DIO2 [04/17/94];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DDS ;;;
 ;;; D D S     ScreenMan
 ;;;
 ;;; 1. ENTRY POINT: ^DDS
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DDSFILE.....File number or global root.
 ;;;    DA..........Internal entry number.
 ;;;    DR..........Name of form enclosed in brackets (FORM file).
 ;;;
 ;;;    Editing a subfile directly. Kill DDSFILE(1) when complete.
 ;;;    DDSFILE(1).....Subfile number or global root.
 ;;;    DA(1)...DA(n)..The DA array. DA is subrecord number and DA(n) is record
 ;;;    number at top level.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    DTOUT..........User timed out.
 ;;;
 ;;; 4. EXAMPLE
 ;;;    S DDSFILE=16500,DA=15,DR="[EE FORM1]" D ^DDS
 ;;;***
DIAC ;;;
 ;;; D I A C     File Access Determination
 ;;;
 ;;; 1. ENTRY POINT: ^DIAC
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIFILE.....File number.
 ;;;    DIAC......."RD"    Verify Read access
 ;;;               "WR"    Verify Write access
 ;;;               "AUDIT" Verify Audit access
 ;;;               "DD"    Verify Data Dictionary access
 ;;;               "DEL"   Verify Delete access
 ;;;               "LAYGO" Verify LAYGO access
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    DIAC.....Either 1 (has access) or 0 (doesn't have access).
 ;;;    %........Same as DIAC.
 ;;;***
DIB ;;;
 ;;; D I B     User Controlled Editing
 ;;;
 ;;; 1. ENTRY POINT: EN^DIB
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIE..........File number or global root.
 ;;;    DIE("NO^")..."OUTOK"         Prevents jumping. Allows exiting.
 ;;;                 "BACK"          Allows jumping back. No exiting.
 ;;;                 "BACKOUTOK"     Allows jumping back. Allows exiting.
 ;;;                 "Other value"   Prevents all jumping. No exiting.
 ;;;    DIDEL........Override Delete Access (Set DIDEL=File number).
 ;;;***
DIM ;;;
 ;;; D I M     M Code Validation.
 ;;;
 ;;; 1. ENTRY POINT: ^DIM
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X......Code to be evaluated.
 ;;;
 ;;; 3. OUTPUT VARIABLES
 ;;;    X......If $D(X) is zero the line of code was invalid.
 ;;;***
DIO2 ;;;
 ;;; D I O 2     Internal to External Date
 ;;;
 ;;; 1. ENTRY POINT: DT^DIO2
 ;;;    Takes an internal date and writes out its external form.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    Y......Internal date.
 ;;;***
