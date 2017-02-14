HMPMONH ;asmr-ven/zag&toad-dashboard: history ;2016-06-29 17:24Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine ^HMPMONH
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; additional authors: Zach Gonzales (zag)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2016-03-07 asmr-ven/zag: created subroutines HISTORY, EH, MH, and
 ; SH in new routine HMPMON. EH, MH, and SH are just empty shells
 ; for now.
 ;
 ; 2016-03-09/04-06 asmr-ven/toad: moved EH & MH to new routine
 ; HMPMONH, added header comments & selection feedback as temporary
 ; logging lines; add UH shell subroutine; show timestamp at top of
 ; UH to make testing easier; overhaul header; fix org, to-do, lines
 ; 1 & 2.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; UH: update history screen
 ; EH: examine history
 ; MH: manage history
 ;
 ;
 ; to do
 ;
 ; develop actions
 ; convert hard-coded text to Dialog file entries
 ; replace writes with new writer that can reroute output to arrays
 ; replace reader calls with new reader that can:
 ;   1. take pre-answers from arrays
 ;   2. write all outputs to arrays
 ;   3. with each feature independently adjustable
 ; create unit tests
 ; change call to top into call to unit tests
 ;
 ;
UH ; update history screen
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls:
 ;   $$LASTREAM^HMPMONL = get last stream name
 ;   $$UHEAD^HMPMONL = calculate header line
 ; input:
 ;   HMPSRVR = # of server record in file HMP Subscription (800000)
 ; output:
 ; examples:
 ;
 new STREAM ; freshness stream subscript into ^xtmp
 set STREAM=$$LASTREAM^HMPMONL(HMPSRVR) ; get last freshness stream
 write $$UHEAD^HMPMONL(STREAM,"Dashboard History"),! ; header line
 ;
 quit  ; end of UH
 ;
 ;
EH ; examine history
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls: 
 ; input:
 ; output:
 ; examples:
 ;
 write !!,"You have selected the history-action "
 write "Examine History."
 ;
 quit  ; end of EH
 ;
 ;
MH ; manage history
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls: 
 ; input:
 ; output:
 ; examples:
 ;
 write !!,"You have selected the history-action "
 write "Manage History."
 ;
 quit  ; end of MH
 ;
 ;
EOR ; end of routine HMPMONH
