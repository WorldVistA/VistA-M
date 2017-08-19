HMPMONEH ;ASMR/BL,JCH monitor error help ;Sep 13, 2016 20:03:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6644 - routine refactored, 7 September 2016
 ;
ERRHELP ; ^DIR ? help for error-action prompt
 W !,"The available actions at the eHMP Monitor's error screen include:",!
 W !,"BM = Back to Monitor, to return to Monitor's main screen."
 W !,"UE = Update Error Screen, to refresh the error screen. This is the"
 W !,"     default action in this screen, which automatically updates."
 W !,"E3 = To display "_$NA(^TMP("HMPERR","JOB#"))_" errors"
 W !,"E4 = To display "_$NA(^TMP("HMPFERR","JOB#"))_" errors"
 W !,"E5 = To display "_$NA(^TMP("JOB#","HMP ERROR"))_" errors"
 W !,"EX = To display "_$NA(^XTMP("HMP*"))_" errors"
 W !,"BM = Back to Monitor, to return to Monitor's main screen."
 W !,"Q  = Quit, to exit the monitor"
 Q
 ;
