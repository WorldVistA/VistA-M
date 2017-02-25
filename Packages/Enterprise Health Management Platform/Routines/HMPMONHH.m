HMPMONHH ;asmr-ven/toad-dashboard: history help ;2016-06-29 17:32Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMONHH
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2016-04-06 asmr-ven/toad: created routine HMPMONHH to provide
 ; extended ?? help to action-action prompt, in dialog or
 ; silent mode; fix org & line 1.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; HISTHELP: show extended ?? help for history-action prompt
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
HISTHELP() ; show extended ?? help for history-action prompt
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
 quit  ; end of HISTHELP
 ;
 ;
HELPTEXT ;;12
 ;;The available action at eHMP Dashboard's sync-process screen is:
 ;;
 ;;BD = Back to Dashboard, to return to dashboard's main screen.
 ;;
 ;;Placeholders for future development include:
 ;;
 ;;UH = Update History Screen, to refresh the screen. This is the
 ;;     default action at this prompt, which auto-updates frequently.
 ;;EH = Examine History, to display the log of interventions
 ;;     including actions PS, RS, ME, and MH) by Dashboard users.
 ;;MH = Manage History, to clear or otherwise manage the Dashboard
 ;;     history log, to keep it from growing too large over time.
 ;
 ;
EOR ; end of routine HMPMONHH
