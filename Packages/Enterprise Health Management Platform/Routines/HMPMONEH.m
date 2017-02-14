HMPMONEH ;asmr-ven/toad-dashboard: main prompt help ;2016-06-29 17:18Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMONEH
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2016-04-05/06 asmr-ven/toad: created routine HMPMONEH to provide
 ; extended ?? help to error-action prompt, in dialog or silent
 ; mode; fix org.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; ERRHELP: show extended ?? help for error-action prompt
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
ERRHELP() ; show extended ?? help for error-action prompt
 ;ven/toad;private;procedure;clean;report or silent;sac
 ; called by:
 ;   PROMPT^HMPMON
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ; input:
 ;   DIQUIET = [optional] = 1 for silent mode, else dialog mode
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
 quit  ; end of ERRHELP
 ;
 ;
HELPTEXT ;;14
 ;;The available actions at the eHMP Dashboard's error screen include:
 ;;
 ;;UE = Update Error Screen, to refresh the error screen. This is the
 ;;     default action at this prompt, which auto-updates frequently.
 ;;E1 = Examine Kernel Error Log, to select an eHMP error from the
 ;;     main error log used by Vista and examine its variables.
 ;;BD = Back to Dashboard, to return to dashboard's main screen.
 ;;
 ;;Placeholders for future development include:
 ;;
 ;;E2 = Examine XTMP Error Log, to inspect ^XTMP("HMPXTEMP ERRORS").
 ;;E3 = Examine HMPERR Error Log, to inspect ^TMP("HMPERR",$job).
 ;;E4 = Examine HMPFERR Error Log, to inspect ^TMP("HMPFERR",$job).
 ;;E5 = Examine HMP ERROR Error Log, to inspect ^TMP($job,"HMP ERROR").
 ;
 ;
EOR ; end of routine HMPMONEH
