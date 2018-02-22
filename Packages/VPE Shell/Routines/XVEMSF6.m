XVEMSF6 ;DJB/VSHL**DIK,DIPZ,DIR,DIS [12/4/95 7:07pm];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIK ;;;
 ;;; D I K     Entry Deletion and File Reindexing
 ;;;
 ;;; 1. ENTRY POINT: ^DIK
 ;;;    Delete an entry. Doesn't update pointers to deleted entries.
 ;;;    It does execute all cross references and triggers.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIK......Global root.
 ;;;    DA.......Entry number you wish to delete.
 ;;;    DA(1)....Needed when deleting at a lower level.
 ;;;
 ;;;    Examples:  S DIK="^EMP(",DA=7 D ^DIK
 ;;;               S DA(1)=1,DA=2,DIK="^EMP("_DA(1)_",""SX""," D ^DIK
 ;;;               S DIK="^EMP(" F DA=2,9,11 D ^DIK
 ;;;
 ;;; 1. ENTRY POINT: ENALL^DIK
 ;;;    Reindexes all entries in a file or subfile.
 ;;;    Executes only the SET logic.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIK......Global root.
 ;;;    DIK(1)...Field number or Field number and specific cross reference
 ;;;             separated by up-arrow.
 ;;;             S DIK(1)=.01   -or-   S DIK(1)=".01^B^C"
 ;;;    DA(1)....Needed when reindexing at a lower level.
 ;;;
 ;;; 1. ENTRY POINT: EN^DIK
 ;;;    Reindexes a single field in a file or subfile, for one entry.
 ;;;    Executes KILL and SET logic.
 ;;;    Needs DIK,DA,DA(1),DIK(1).
 ;;;
 ;;; 1. ENTRY POINT: EN1^DIK
 ;;;    Reindexes a single field in a file or subfile, for one entry.
 ;;;    Executes only the SET logic.
 ;;;    Needs DIK,DA,DA(1),DIK(1).
 ;;;
 ;;; 1. ENTRY POINT: IXALL^DIK
 ;;;    Reindexes all cross references for all entries.
 ;;;    Executes only the SET logic.
 ;;;    Needs DIK.
 ;;;
 ;;; 1. ENTRY POINT: IX^DIK
 ;;;    Reindexes all cross references for only one entry.
 ;;;    Executes KILL and SET logic.
 ;;;    Needs DIK,DA,DA(1).
 ;;;
 ;;; 1. ENTRY POINT: IX1^DIK
 ;;;    Reindexes all cross references for only one entry.
 ;;;    Executes only the SET logic.
 ;;;    Needs DIK,DA,DA(1).
 ;;;***
DIPZ ;;;
 ;;; D I P Z     Print Template Compilation
 ;;;
 ;;; 1. ENTRY POINT: ^DIPZ
 ;;;    A DIPZ-compiled routine may be called by any program that passes to
 ;;;    it DT,DUZ,IOSL,U, and D0 (entry number). Variable DXS must be killed
 ;;;    before and after the call.
 ;;;
 ;;; 1. ENTRY POINT: EN^DIPZ
 ;;;    Recompile an input template without user intervention.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    X.......Routine name.
 ;;;    Y.......The internal entry number of template.
 ;;;    DMAX....Maximum size of compiled routines.
 ;;;***
DIR ;;;
 ;;; D I R     Reader
 ;;;
 ;;;  Refer to the VA Fileman Programmer's Manual.
 ;;;***
DIS ;;;
 ;;; D I S     Search File Entries
 ;;;
 ;;; 1. ENTRY POINT: EN^DIS
 ;;;    Calls the Search File Entries option of VA Fileman. Needs DT and DUZ.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    DIC.....Global root or file number.
 ;;;***
