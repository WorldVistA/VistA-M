HMPMONS ;ASMR/BL, synch process support;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;
US ; update synch-process screen
 N EXIT S EXIT=0  ; exit will stop the display
 F  Q:EXIT  D
 . S HMPMNTR("default")="BM"  ; default for this screen
 . D FORMFEED^HMPMONL
 . W !,$$HDR^HMPMONL("eHMP Synch Processes"),!  ; header line
 . W !!,"You have selected the Update Synch Process Screen."
 . D PROMPT^HMPMONA(.HMPACT,"SYNC")
 . I HMPACT="US" Q  ; update synch screen, nothing to do
 . I (HMPACT="BM")!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) S EXIT=1 Q
 . S LNTAG=$P(HMPCALLS(HMPACT),";",3)
 . D @LNTAG S EXIT=HMPMNTR("exit") Q:HMPMNTR("exit")  ; perform user-selected action, exit if flag set
 . D RTRN2CON^HMPMONL ; return to continue
 Q
 ;
ES ; examine synch process
 D FORMFEED^HMPMONL
 W !,$$HDR^HMPMONL("Examine Synch Process"),!  ; header line
 W !!,"You have selected the synch-process-action Examine Synch Process."
 D NOTYET^HMPMONL Q
 ;
PS ; park synch process
 D FORMFEED^HMPMONL
 W !,$$HDR^HMPMONL("Park Synch Process"),!  ; header line
 W !!,"You have selected Park Synch Process action."
 D NOTYET^HMPMONL Q
 ;
RS ; restart synch process
 D FORMFEED^HMPMONL
 W !,$$HDR^HMPMONL("Restart Synch Process"),!  ; header line
 W !!,"You have selected the synch-process-action Restart Synch Process."
 D NOTYET^HMPMONL Q
 ;
