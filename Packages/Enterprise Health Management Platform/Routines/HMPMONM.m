HMPMONM ;asmr-ven/toad-dashboard: update, server ;2016-06-29 18:52Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMOND
 ;
 ; primary development
 ;
 ; primary developer: Frederick D. S. Marshall (toad)
 ; original author: Kevin Meldrum (kcm)
 ; additional authors: Raymond Hsu (hsu)
 ; original org: U.S. Department of Veterans Affairs (va)
 ; prime contractor ASM Research (asmr)
 ; development org: VISTA Expertise Network (ven)
 ;
 ; 2015-11-02/2016-02-29 va/hsu: refine HMPDJFSM, then develop
 ; HMPDBMN.
 ;
 ; 2016-03-18/04-13 asmr-ven/toad: created routine HMPMONM from
 ; subscription subroutines M, $$GETSRVR, NOSRVR^HMPMOND, the first
 ; of which was created by Salt Lake's $$GETSRV pseudo-function
 ; in HMPDJFSM; adjust selection prompt; move ENDPAGE call to
 ; HMPMONL; add $$GETSUB; add throughput hmpsub to dashboard;
 ; NOSRVR: convert writes to EN^DDIOL for testing; fix org, history
 ; & to-do list & line 1.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; M: dashboard action: monitor a different subscription
 ; $$GETSRVR = default server to monitor
 ; $$GETSUB = subscription record for server
 ; NOSRVR: display help if system has no ehmp subscriptions
 ;
 ;
 ; to do
 ;
 ; add xref to field Default? (.07) of file HMP Subscription (800000)
 ; ...to ensure only one server at a time can be set to YES
 ; convert hard-coded text to Dialog file entries
 ; replace writes with new writer that can reroute output to arrays
 ; replace DIC call with reader call & silent lookup that can:
 ;   1. take pre-answers from arrays
 ;   2. write all outputs to arrays
 ;   3. with each feature independently adjustable
 ; create unit tests
 ; change call to top into call to unit tests
 ;
 ;
M ; dashboard action: monitor a different subscription
 ;ven/toad;private;procedure;clean;dialog;sac
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   ^DIC: to select subscription
 ; input:
 ;   input from the current device's user
 ; throughput:
 ;   HMPSRVR = ien of server to monitor
 ;   HMPSUB = subscription record's header node
 ; output:
 ;   issue prompt to current device's user
 ; examples:
 ;   [develop examples]
 ;
 write !
 ;
 new DIC set DIC="^HMP(800000," ; file hmp subscription (800000)
 set DIC(0)="AEMQ" ; ask, echo choice, multi-index, query bad input
 set DIC("A")="Select eHMP Server to Monitor: " ; prompt
 set DIC("B")=HMPSRVR ; default to current selection
 new DIROUT,DLAYGO,DTOUT,DUOUT,X,Y ; other inputs & outputs
 ;
 do ^DIC ; classic Fileman lookup
 ;
 if $data(DTOUT) do  quit  ; time-out
 . write "   ** time-out **",$char(7)
 . set HMPROMPT=U ; exit ehmp dashboard
 . quit
 ;
 if $data(DUOUT)!$data(DIROUT) do  quit  ; ^-escape
 . set HMPROMPT=U ; exit ehmp dashboard
 . quit
 ;
 else  do  ; valid selection
 . set HMPSRVR=+Y ; update subscription
 . set HMPSUB=$$GETSUB(HMPSRVR) ; and subscription record
 . quit
 ;
 quit  ; end of M
 ;
 ;
GETSRVR() ; default server to monitor
 ;ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   OPTION^HMPMON
 ; calls: none
 ; input:
 ;   file hmp subscription (800000)
 ; output = ien of server to monitor
 ; examples:
 ;   [develop examples]
 ;
 new SRVR set SRVR=0 ; default server
 do
 . new FIRST set FIRST=$order(^HMP(800000,0)) ; 1st server's ien
 . quit:'FIRST
 . new SECOND set SECOND=$order(^HMP(800000,FIRST)) ; 2nd server's ien
 . if 'SECOND do  quit  ; if there's only one
 . . set SRVR=FIRST ; it's the default
 . . quit
 . ;
 . new DEFAULT1 set DEFAULT1=$order(^HMP(800000,"AD",1,0)) ; default?
 . new DEFAULT2 set DEFAULT2=$order(^HMP(800000,"AD",1,DEFAULT1))
 . if DEFAULT1,'DEFAULT2 do  quit  ; if only one default
 . . set SRVR=DEFAULT1 ; it's the default
 . . quit
 . ;
 . set SRVR=FIRST ; otherwise, give up and default to 1st server
 . quit
 ;
 quit SRVR ; return default server ; end of $$GETSRVR
 ;
 ;
GETSUB(SRVR) ; subscription record for server
 ;ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   OPTION^HMPMON
 ; calls: none
 ; input:
 ;   SRVR = server currently monitoring
 ;   file hmp subscription (800000)
 ; output = header node for server's subscription
 ; examples:
 ;   [develop examples]
 ;
 new SUBHDR set SUBHDR=$get(^HMP(800000,SRVR,0)) ; default server
 ;
 quit SUBHDR ; return server's header node ; end of $$GETSUB
 ;
 ;
NOSRVR ; display help if system has no ehmp subscriptions
 ;ven/toad;private;procedure;clean;dialog;sac
 ; called by:
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ;   ENDPAGE^HMPMONL ; issue end-of-page prompt before exiting
 ; input:
 ;   input from the current device's user
 ; throughput:
 ;   HMPSRVR = ien of server to monitor
 ; output:
 ;   issue prompt to current device's user
 ; examples:
 ;   [develop examples]
 ;
 do EN^DDIOL("You need to set up at least one eHMP subscription",,"!!")
 do EN^DDIOL("in file HMP Subscription (800000), before you will")
 do EN^DDIOL("have anything to monitor with this dashboard. If you")
 do EN^DDIOL("set up subscriptions to more than one server, set")
 do EN^DDIOL("field Default? (.07) to YES for your main one, or for")
 do EN^DDIOL("the one you want to be the default server to monitor")
 do EN^DDIOL("when you first enter the eHMP Dashboard.")
 do EN^DDIOL("",,"!")
 ;
 do ENDPAGE^HMPMONL ; issue end-of-page prompt before exiting
 ;
 quit  ; end of NOSRVR
 ;
 ;
EOR ; end of routine HMPMONM
