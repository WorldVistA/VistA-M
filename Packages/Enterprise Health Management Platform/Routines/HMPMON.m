HMPMON ;ASMR/BL, eHMP monitor main routine ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526, DE6644 - routine refactored, 25 August 2016
 ;
 ; main routine for the eHMP monitor
 ; all other HMPMON* routines are invoked from this routine (see below)
 ; PROMPT^HMPMONA issues the ^DIR action prompts in the monitor
 ;
OPTION ; entry point from OPTION file (#19) entry HMPMON DASHBOARD 
 ;
 D HOME^%ZIS  ; set IO* variables
 ; HMPACT - user selected action
 ; HMPCALLS - values used for ^DIR calls
 ; HMPMNTR array used throughout HMPMON* routines, subscripts indicate intent
 ; HMPRATE - "refresh" rate for displaying screen, used as ^DIR timeout
 ; HMPROMPT - prompt group for ^DIR calls (see HMPMONR routine)
 N D,HMPACT,HMPCALLS,HMPMNTR,HMPRATE,HMPROMPT,LNTAG
 D CALLIST^HMPMONR(.HMPCALLS)
 ; line tag/routine to call
 ; HMPACT - user-selected action
 S HMPROMPT="MNTR" ; Monitor Action Prompt group
 S HMPRATE=$$RATE^HMPMONC ; auto-update rate
 S HMPMNTR("server")=$$GETSRVR^HMPMONM ; subscription server
 ; if there are NO subscriptions, display help and quit
 I 'HMPMNTR("server") D NOSRVR^HMPMONM Q
 S HMPMNTR("exit")=0  ; flag to exit monitor
 S HMPMNTR("site hash")=$$SYS^HMPUTILS,HMPMNTR("site name")=$$KSP^XUPARAM("WHERE")
 ;
 F  D  Q:HMPROMPT=U!HMPMNTR("exit")  ; monitor option's main loop
 . S HMPMNTR("default")="U"  ; default to update
 . S HMPMNTR("zero node")=$G(^HMP(800000,HMPMNTR("server"),0))  ; used for display
 . ; 1. display text in monitor
 . S HMPACT=HMPMNTR("default")  ; initial action is default
 . D FORMFEED^HMPMONL,U^HMPMOND ; clear screen, then update monitor display
 . ; 2. prompt user to select action
 . S HMPACT="" D PROMPT^HMPMONA(.HMPACT,HMPROMPT) ; prompt user for action
 . Q:HMPMNTR("exit")  ; exit the monitor
 . Q:HMPACT=""  ; no action selected
 . Q:$E(HMPACT)="U"  ; update = initial action, nothing to do
 . ; 3. perform user-selected action
 . S LNTAG=$P(HMPCALLS(HMPACT),";",3)  ; action's subroutine call
 . D @LNTAG ; perform user-selected action
 ;
 Q
 ;
EXIT ; exit monitor action
 S HMPMNTR("exit")=1 D FORMFEED^HMPMONL Q
 ;
 ;eHMP monitor routines as of 13 September 2016
 ; HMPMON - main routine, entry point for MenuMan option
 ; HMPMONA - action prompts for ^DIR calls
 ; HMPMONC - change auto-refresh rates, which is the timeout when calling ^DIR
 ; HMPMOND - display routine for monitor screen
 ; HMPMONDH - display help for monitor screen
 ; HMPMONE - error and event log display actions
 ; HMPMONEH - error display help, called by ^DIR ? logic
 ; HMPMONH - history of monitor (not implemented)
 ; HMPMONHH - history of monitor help text (not implemented)
 ; HMPMONJ - job processes (poller) display
 ; HMPMONL - library of monitor support support code
 ; HMPMONM - monitor a different server, interactive ^DIC call
 ; HMPMONR - reader array set up (^DIR)
 ; HMPMONS - synch process actions (not implemented)
 ; HMPMONSH - synch process help (not implemented)
 ; HMPMONV - view eHMP global nodes
 ; HMPMONX - XTMP global monitor support logic
 ;
