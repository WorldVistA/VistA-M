HMPMONS ;asmr-ven/zag&toad-dashboard: sync process ;2016-06-29 18:58Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine ^HMPMONS
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; additional authors: Zach Gonzales (zag)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2016-03-07 asmr-ven/zag: create subroutines HISTORY, EH, MH, and
 ; SH in new routine HMPMON. EH, MH, and SH are just empty shells
 ; for now.
 ;
 ; 2016-03-10/04-06 asmr-ven/toad: create routine HMPMONS with
 ; subroutines ES, PS, and RS, with header comments & selection
 ; feedback as temporary logging lines, based on routines HMPMONE
 ; and HMPMONH; add US shell subroutine; show timestamp in US to
 ; make testing easier; adjust header; fix org, to-do list, line 2.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; US: update sync-process screen
 ; ES: examine sync process
 ; PS: park bad sync process
 ; RS: restart sync process
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
US ; update sync-process screen
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls:
 ;   $$LASTREAM^HMPMONL = get last stream name
 ;   $$UHEAD^HMPMONL = calculate header line
 ; input:
 ;   HMPSRVR = # of server record in file HMP Subscription (800000)
 ;      [passed through symbol table]
 ; output:
 ; examples:
 ;
 new STREAM ; freshness stream subscript into ^xtmp
 set STREAM=$$LASTREAM^HMPMONL(HMPSRVR) ; get last freshness stream
 write $$UHEAD^HMPMONL(STREAM,"eHMP Sync Processes"),! ; header line
 ;
 write !!,"You have selected the sync-process-action "
 write "Update Sync-process Screen."
 ;
 quit  ; end of US
 ;
 ;
ES ; examine sync process
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls: 
 ; input:
 ; output:
 ; examples:
 ;
 write !!,"You have selected the sync-process-action "
 write "Examine Sync Process."
 ;
 quit  ; end of ES
 ;
 ;
PS ; park sync process
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls: 
 ; input:
 ; output:
 ; examples:
 ;
 write !!,"You have selected the sync-process-action "
 write "Park Sync Process."
 ;
 quit  ; end of PS
 ;
 ;
RS ; restart sync process
 ;ven/zag&toad;private;procedure;clean;interactive;sac
 ; called by:
 ; calls: 
 ; input:
 ; output:
 ; examples:
 ;
 write !!,"You have selected the sync-process-action "
 write "Restart Sync Process."
 ;
 quit  ; end of RS
 ;
 ;
EOR ; end of routine HMPMONS
