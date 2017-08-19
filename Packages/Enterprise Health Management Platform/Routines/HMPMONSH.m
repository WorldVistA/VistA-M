HMPMONSH ;ASMR/BL, synch process help ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;
SYNCHELP ; show extended ?? help for synch-process-action prompt
 W !!,"The available actions at eHMP Monitor Synch Process screen are:"
 W !,"BM = Back to Monitor, to return to Monitor's main screen."
 W !," "
 W !,"Placeholders for future development include:"
 W !," "
 W !,"US = Update Synch Process Screen, to refresh the screen. This is the"
 W !,"     default action at this prompt, which auto-updates frequently."
 W !,"ES = Examine Synch Process, to select an active or parked synch"
 W !,"     process and examine its status information."
 W !,"PS = Park Synch Process, to select and examine an active synch"
 W !,"     process, and confirm selection to place it in a parked state."
 W !,"RS = Restart Synch Process, to select and examine a parked or"
 W !,"    stalled synch process, confirm selection, and restart it."
 Q
 ;
