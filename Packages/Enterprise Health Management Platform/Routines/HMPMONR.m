HMPMONR ;ASMR/BL, Reader Support logic ;Sep 19, 2016 20:02:20
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ; this routine contains logic to suppport the FileMan Reader (calls to ^DIR)
 ;
CALLIST(CLLRSLT) ; CLLRSLT passed by reference, return list of calls
 ; this is called once on entry to the eHMP monitor, all the ^DIR prompts are listed below
 N P  ; P is used for Prompt below
 S CLLRSLT="BM^C^EX^E3^E4^E5^EH^ES^J^L^M^MH^PS^Q^RS^U^UE^UH^US^V"  ; complete list of prompts
 ; each subscript below is a prompt that can displayed in ^DIR as a set of codes
 ; the 2nd ';' $PIECE is the group (screen) in which it's used
 S CLLRSLT("BM")="Back to Monitor;ERR,SYNC;"  ; no M code, used throughout, handled by hard-coded logic
 S CLLRSLT("C")="Change Auto-refresh Rate;MNTR;C^HMPMONC"
 S CLLRSLT("E")="Errors;ERR;UE^HMPMONE"
 S CLLRSLT("EX")="Examine XTMP Error Log;ERR;EX^HMPMONE"
 S CLLRSLT("E3")="Examine HMPERR Error Log;ERR;E3^HMPMONE"
 S CLLRSLT("E4")="Examine HMPFERR Error Log;ERR;E4^HMPMONE"
 S CLLRSLT("E5")="Examine HMP ERROR Error Log;ERR;E5^HMPMONE"
 S CLLRSLT("EH")="Examine History;HIST;EH^HMPMONH"
 S CLLRSLT("ES")="Examine Synch Process;SYNC;ES^HMPMONS"
 S CLLRSLT("J")="Job Listing;MNTR;J^HMPMONJ"
 S CLLRSLT("L")="Event Log Inquiry;MNTR;LOG^HMPMONE"
 S CLLRSLT("M")="Monitor a Different Server;MNTR;M^HMPMONM"
 S CLLRSLT("MH")="Manage History;HIST;MH^HMPMONH"
 S CLLRSLT("PS")="Park Synch Process;SYNC;PS^HMPMONS"
 S CLLRSLT("Q")="Quit;MNTR,ERR,SYNC;EXIT^HMPMON"  ; displayed on multiple screens
 S CLLRSLT("S")="Update Synch Process;SYNC;US^HMPMONS"
 S CLLRSLT("RS")="Restart Synch Process;SYNC;RS^HMPMONS"
 S CLLRSLT("U")="Update Monitor;MNTR;U^HMPMOND"
 S CLLRSLT("UE")="Update Error Screen;ERR;UE^HMPMONE"
 S CLLRSLT("UH")="Update History Screen;HIST;UH^HMPMONH"
 S CLLRSLT("US")="Update Sync-process Screen;SYNC;US^HMPMONS"
 S CLLRSLT("V")="View HMP Nodes;MNTR;V^HMPMONV"
 ;
 ; now group by prompt for calls within a screen displayed to the user
 ;
 S P="MNTR" ; MNTR prompt group for ^DIR calls
 S CLLRSLT(U,"DIR",P,"C")=""
 S CLLRSLT(U,"DIR",P,"E")=""
 S CLLRSLT(U,"DIR",P,"H")=""
 S CLLRSLT(U,"DIR",P,"J")=""
 S CLLRSLT(U,"DIR",P,"L")=""
 S CLLRSLT(U,"DIR",P,"M")=""
 S CLLRSLT(U,"DIR",P,"Q")=""
 S CLLRSLT(U,"DIR",P,"S")=""
 S CLLRSLT(U,"DIR",P,"U","default")=1  ; default prompt for the main screen (the MNTR group)
 S CLLRSLT(U,"DIR",P,"V")=""
 S CLLRSLT(U,"DIR","text",P)="HMP MONITOR ACTION;Select Monitor Action"
 S CLLRSLT(U,"DIR","?",P)="^D MONHELP^HMPMONDH"  ; ^DIR help routine
 ;
 S P="ERR"  ; ERR prompt group for ^DIR calls
 S CLLRSLT(U,"DIR",P,"BM")=""
 S CLLRSLT(U,"DIR",P,"EX")=""
 S CLLRSLT(U,"DIR",P,"E3")=""
 S CLLRSLT(U,"DIR",P,"E4")=""
 S CLLRSLT(U,"DIR",P,"E5")=""
 S CLLRSLT(U,"DIR",P,"Q")=""
 S CLLRSLT(U,"DIR",P,"UE","default")=1  ; default prompt for the ERR screen
 ;  2nd ';' $PIECE below is the ^DIR prompt to the user
 S CLLRSLT(U,"DIR","text",P)="HMP MON ERR ACTION;Select Error Action"
 S CLLRSLT(U,"DIR","?",P)="^D ERRHELP^HMPMONEH"  ; ^DIR help routine
 ;
 S P="SYNC"  ; SYNC prompt group for ^DIR calls
 S CLLRSLT(U,"DIR",P,"BM","default")=1  ; default prompt for the SYNC screen
 S CLLRSLT(U,"DIR",P,"ES")=""
 S CLLRSLT(U,"DIR",P,"PS")=""
 S CLLRSLT(U,"DIR",P,"RS")=""
 S CLLRSLT(U,"DIR",P,"Q")=""
 S CLLRSLT(U,"DIR",P,"US")=""
 ;  2nd ';' $PIECE below is the ^DIR prompt to the user
 S CLLRSLT(U,"DIR","text",P)="HMP MON SYNC ACTION;Select Synch-process Action"
 S CLLRSLT(U,"DIR","?",P)="^D SYNCHELP^HMPMONSH"  ; ^DIR help routine
 ;
 Q
 ;
PROMPTS() Q "^MNTR^ERR^SYNC^" ; extrinisic variable, return valid ^DIR prompts group
 ; to add another display screen in the monitor, add the default prompt above
 ; to enable the HIST options, add it in $$PROMPTS and set up the CLLRSLT array as above
