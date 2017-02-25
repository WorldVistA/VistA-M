HMPMONDH ;asmr-ven/toad-dashboard: main prompt help ;2016-06-29 15:18Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMONDH
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2016-03-22/04-06 asmr-ven/toad: created routine HMPMONDH to
 ; provide extended ?? help to main dashboard action prompt, in
 ; dialog or silent mode; fix org.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; DASHHELP: show extended ?? help for main dashboard action prompt
 ; HELPTEXT: lines of extended help text
 ;
 ;
 ; to do
 ;
 ; convert hard-coded text to Dialog file entries
 ; create unit tests
 ; change call to top into call to unit tests
 ;
 ;
DASHHELP() ; show extended ?? help for main dashboard action prompt
 ;ven/toad;private;procedure;clean;report or silent;sac
 ; called by:
 ;   PROMPT^HMPMON
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ; input:
 ;   DIQUIET = [optional] =1 for silent mode, else dialog mode
 ; output:
 ;   report to current device, if dialog mode
 ;   ^TMP("DIMSG",$job,line#) = line of help, if silent mode
 ; examples:
 ;   [develop examples]
 ;
 new HELPTEXT
 new LINES set LINES=$piece($text(HELPTEXT),";;",2)
 new LINE
 for LINE=1:1:LINES do
 . set HELPTEXT(LINE)=$piece($text(@("HELPTEXT+"_LINE)),";;",2)
 . quit
 ;
 do EN^DDIOL(.HELPTEXT) ; write or load extended ?? help text
 ;
 quit  ; end of DASHHELP
 ;
 ;
HELPTEXT ;;16
 ;;The available actions at the eHMP Dashboard's main screen include:
 ;;
 ;;U = Update Dashboard, to refresh the main screen. This is the
 ;;    default action at this prompt, which auto-updates frequently.
 ;;V = View HMP Nodes, to inspect the main eHMP data nodes currently
 ;;    stored in the ^XTMP or ^TMP globals.
 ;;J = Job Listing, to inspect the polling jobs and extract batches.
 ;;S = Sync Processes, to switch to the Sync-process Screen.
 ;;E = Errors, to switch to the Errors Screen.
 ;;H = History, to switch to the History Screen.
 ;;C = Change Auto-update Rate, to change the frequency with which
 ;;    the dashboard screens refresh. (This change covers all screens,
 ;;    not just the main screen.)
 ;;M = Monitor a Different Subscription, to change which server in the
 ;;    HMP Subscription file (800000) the dashboard is monitoring.
 ;;Q = Quit, to exit the dashboard.
 ;
 ;
EOR ; end of routine HMPMONDH
