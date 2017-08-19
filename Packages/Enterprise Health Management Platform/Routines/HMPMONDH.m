HMPMONDH ;ASMR/BL, monitor prompt help ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;
MONHELP ; reader ? help for main monitor screen
 ; called by ^DIR calls invoked by PROMPT^HMPMON
 ;
 W !!,"The available actions at the eHMP monitors's main screen include:",!
 W !,"U = Update Monitor, to refresh the main screen. This is the"
 W !,"    default action at this prompt.  It updates the screen based on the"
 W !,"    auto-update rate (see below)."
 W !,"V = View HMP Nodes, to inspect eHMP data nodes"
 W !,"    stored in the ^XTMP or ^TMP globals."
 W !,"J = Job Listing, to inspect the polling jobs and extract batches."
 W !,"S = Synch Processes, to switch to the Synch Process Screen."
 W !,"E = Errors, to switch to the Errors Screen."
 W !,"H = History, to switch to the History Screen (not yet implemented)."
 W !,"C = Change Auto-update Rate, to change the frequency with which"
 W !,"    the monitor screens refresh."
 W !,"L = Log, look up an HMP EVENT log entry."
 W !,"M = Monitor a Different SERVER, to change which server in the"
 W !,"    HMP Subscription file (800000) is displayed in the monitor."
 W !,"Q = Quit, in any screen, will exit the monitor.",!
 D RTRN2CON^HMPMONL
 Q
 ;
