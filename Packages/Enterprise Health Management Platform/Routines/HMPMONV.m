HMPMONV ;asmr-ven/toad-dashboard: view hmp nodes ;2016-06-29 19:23Z
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;April 14,2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 quit  ; no entry from top of routine HMPMONV
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
 ; HMPDBMN, to include end-of-page checks for long displays, and fix
 ; bug in display of HMP nodes.
 ;
 ; 2016-03-15/04-13 asmr-ven/toad: created routine HMPMONV from Team
 ; Krypton's HMPDBMN subroutine SHOWHMPN -> V; create VIEWXTMP,
 ; VIEWTMP, & VIEWTMPJ; refactor; move CHKIOSL calls to HMPMONL;
 ; passim: check hmprompt=U instead of hmpexit after CHKIOSL,
 ; convert writes to EN^DDIOL; add VDEF, $$VHEAD, VSHOWROW, and
 ; $$VROW, replace write @IOF with do FORMFEED^HMPMONL in V;
 ; updated calls & called-by comments; fix org & history.
 ;
 ; 2016-04-14 asmr/bl HMP*2.0*2: update lines 2 & 3, cut EOR line.
 ;
 ; 2016-06-29 ven/toad: XINDEX is four years behind 2012 VA SAC;
 ; convert variables to uppercase; restore EOR line.
 ;
 ;
 ; contents
 ;
 ; V: action view hmp nodes
 ; VDEF: define table for report
 ; $$VHEAD = header for view hmp nodes
 ; VIEWXTMP: view ^xtmp nodes
 ; VIEWTMP: view ^tmp nodes
 ; VIEWTMPJ: view ^tmp($job) nodes
 ; VSHOWROW: show row for an ehmp global node
 ; $$VROW = each row of the report
 ;
 ;
 ; to do
 ;
 ; convert hard-coded text to Dialog file entries
 ; create unit tests
 ; change call to top into call to unit tests
 ;
 ;
V ; action view hmp nodes
 ;ven/toad;private;procedure;clean;interactive;sac
 ; called by:
 ;   OPTION^HMPMON
 ; calls:
 ;   VDEF: define table for report
 ;   FORMFEED^HMPMONL: form feed to current device or output array
 ;   VHEAD: show view-hmp-nodes report header lines
 ;   VIEWXTMP: view ^xtmp nodes
 ;   VIEWTMP: view ^tmp nodes
 ;   VIEWTMPJ: view ^tmp($job) nodes
 ; input:
 ;   input from the database
 ; throughput: [passed through symbol table]
 ;   HMPROMPT = current prompt; ^ to exit option; else leave alone
 ;   HMPEOP = 1 by default, 0 if exiting
 ; output:
 ;   output to the current device
 ; examples:
 ;   [develop examples]
 ;
 new NODES do VDEF(.NODES) ; define table for report
 do FORMFEED^HMPMONL ; clear screen before report
 do VHEAD(.NODES) ; show view-hmp-nodes report header lines
 ;
 do
 . do VIEWXTMP ; view ^xtmp nodes
 . quit:HMPROMPT=U
 . ;
 . do VIEWTMP ; view ^tmp nodes
 . quit:HMPROMPT=U
 . ;
 . do VIEWTMPJ ; view ^tmp($job) nodes
 . quit
 ;
 if HMPROMPT=U do  ; dashboard exit flag
 . set HMPEOP=0 ; suppress dashboard end-of-page if exiting
 . quit
 ;
 quit  ; end of V
 ;
 ;
VDEF(NODES) ; set table definition for report
 ;ven/toad;private;procedure;clean;silent;sac
 ; called by:
 ;   V
 ; calls: none
 ; input: none
 ; output:
 ;  .NODES = table definition for report
 ; examples: see below
 ;
 set NODES=2 ; table definition for nodes report
 set NODES(1,0)="1^45^current hmp temporary nodes^l" ; column 1
 set NODES(2,0)="50^79^high numeric or last subscript^l" ; column 2
 ;
 quit  ; end of VDEF
 ;
 ;
VHEAD(NODES) ; show view-hmp-nodes report header lines
 ;ven/toad;private;procedure;clean;report;sac
 ; called by:
 ;   V
 ; calls:
 ;   $$TABLHEAD^HMPMONL = table header
 ;   $$TABLLINE^HMPMONL = table line
 ;   EN^DDIOL: write output or load into output array
 ; input:
 ;  .NODES = table definition for report (see example)
 ; output:
 ;   report to current device or output array
 ; examples:
 ;   if:
 ;     nodes(1,0) = "1^45^current hmp temporary nodes^l"
 ;     nodes(2,0) = "50^79^high numeric or last subscript^l"
 ;   [develop examples]
 ;
 new VHEAD set VHEAD=$$TABLHEAD^HMPMONL(.NODES) ; table header
 do EN^DDIOL(VHEAD,,"!!") ; view-hmp-nodes report line 2
 ;
 new VLINE set VLINE=$$TABLLINE^HMPMONL(.NODES) ; table line
 do EN^DDIOL(VLINE) ; view-hmp-nodes report line 3
 ;
 quit  ; end of VHEAD
 ;
 ;
VIEWXTMP ; view ^xtmp nodes
 ;ven/toad;private;procedure;clean;dialog or silent;sac
 ; called by:
 ;   V
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ;   VSHOWROW: show row for an ehmp global node
 ;   CHKIOSL^HMPMONL: check for and handle end of page
 ; input:
 ;   input from the database
 ;   end-of-page prompt input from user on current device
 ; throughput: [passed through symbol table]
 ;   HMPROMPT = current dashboard prompt, ^ = exit now [symbol table]
 ; output:
 ;   output to current device or output array
 ;   end-of-page prompt to user on current device
 ; examples:
 ;   [develop examples]
 ;
 do EN^DDIOL("",,"!")
 new DONE set DONE=0 ; not yet done with loop
 new TREE set TREE="HMOZ"
 for  do  quit:HMPROMPT=U!DONE
 . set TREE=$order(^XTMP(TREE))
 . if $extract(TREE,1,3)'="HMP" do
 . . set DONE=1
 . . quit
 . quit:DONE
 . ;
 . do VSHOWROW($name(^XTMP(TREE))) ; output row for node
 . quit
 quit:HMPROMPT=U
 ;
 do CHKIOSL^HMPMONL ; check for and handle end of page
 ;
 quit  ; end of VIEWXTMP
 ;
 ;
VIEWTMP ; view ^tmp nodes
 ;ven/toad;private;procedure;clean;dialog or silent;sac
 ; called by:
 ;   V
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ;   VSHOWROW: show row for an ehmp global node
 ;   CHKIOSL^HMPMONL: check for and handle end of page
 ; input:
 ;   input from the database
 ;   end-of-page prompt input from user on current device
 ; throughput: [passed through symbol table]
 ;   HMPROMPT = current dashboard prompt, ^ = exit now [symbol table]
 ; output:
 ;   output to current device or output array
 ;   end-of-page prompt to user on current device
 ; examples:
 ;   [develop examples]
 ;
 do EN^DDIOL("",,"!")
 new DONE set DONE=0 ; not yet done with loop
 new TREE set TREE="HMOZ"
 for  do  quit:HMPROMPT=U!DONE
 . set TREE=$order(^TMP(TREE))
 . if $extract(TREE,1,3)'="HMP" do
 . . set DONE=1
 . . quit
 . quit:DONE
 . ;
 . new JOB set JOB=0
 . for  do  quit:HMPROMPT=U!'JOB
 . . set JOB=$order(^TMP(TREE,JOB))
 . . quit:'JOB
 . . ;
 . . do VSHOWROW($name(^TMP(TREE,JOB))) ; output row for node
 . . quit
 . quit
 quit:HMPROMPT=U
 ;
 do CHKIOSL^HMPMONL ; check for and handle end of page
 ;
 quit  ; end of VIEWTMP
 ;
 ;
VIEWTMPJ ; view ^tmp($job) nodes
 ;ven/toad;private;procedure;clean;dialog or silent;sac
 ; called by:
 ;   V
 ; calls:
 ;   EN^DDIOL: write output or load into output array
 ;   VSHOWROW: show row for an ehmp global node
 ; input:
 ;   input from the database
 ;   end-of-page prompt input from user on current device
 ; throughput: [passed through symbol table]
 ;   HMPROMPT = current dashboard prompt, ^ = exit now [symbol table]
 ; output:
 ;   output to current device or output array
 ;   end-of-page prompt to user on current device
 ; examples:
 ;   [develop examples]
 ;
 do EN^DDIOL("",,"!")
 new JOB set JOB=0
 for  do  quit:HMPROMPT=U!'JOB
 . set JOB=$order(^TMP(JOB))
 . quit:'JOB
 . ;
 . new DONE set DONE=0 ; not done with loop yet
 . new TREE set TREE="HMOZ"
 . for  do  quit:HMPROMPT=U!DONE
 . . set TREE=$order(^TMP(JOB,TREE))
 . . if $extract(TREE,1,3)'="HMP" do
 . . . set DONE=1
 . . . quit
 . . quit:DONE
 . . ;
 . . do VSHOWROW($name(^TMP(JOB,TREE))) ; output row for node
 . . quit
 . quit
 ;
 quit  ; end of VIEWTMPJ
 ;
 ;
VSHOWROW(NODE) ; show row for an ehmp global node
 ;ven/toad;private;procedure;clean;dialog or silent;sac
 ; called by:
 ;   VIEWXTMP
 ;   VIEWTMP
 ;   VIEWTMPJ
 ; calls:
 ;   $$VROW = each row of the report
 ;   EN^DDIOL: write output or load into output array
 ;   CHKIOSL^HMPMONL: check for and handle end of page
 ; input:
 ;   NODE = namevalue of global node, e.g., "^XTMP(""THING"")"
 ;   input from the database
 ;   end-of-page prompt input from user on current device
 ;   NODES = table definition for report [passed thru symbol table]
 ; throughput: [passed through symbol table]
 ;   HMPROMPT = current dashboard prompt, ^ = exit now [symbol table]
 ; output:
 ;   output row for node to current device or output array
 ;   end-of-page prompt to user on current device
 ; examples:
 ;   [develop examples]
 ;
 new LAST set LAST=$order(@NODE@(" "),-1)
 set:LAST="" LAST=$order(@NODE@(""),-1)
 new ROW set ROW=$$VROW(.NODES,NODE,LAST)
 do EN^DDIOL(ROW) ; display or load row of report
 do CHKIOSL^HMPMONL ; check for and handle end of page
 ;
 quit  ; end of VSHOWROW
 ;
 ;
VROW(NODES,NODE,LAST) ; row of the view-hmp-nodes report
 ;ven/toad;private;function;clean;silent;sac
 ; called by:
 ;   VIEWXTMP
 ;   VIEWTMP
 ;   VIEWTMPJ
 ; calls:
 ;   SETCOL^HMPMONL: set a value into its column
 ; input:
 ;  .NODES = table definition for report (see example)
 ;   NODE = current hmp temporary node
 ;   LAST = high numeric or last subscript
 ; output = report row for the node
 ; examples:
 ;   if:
 ;     nodes(1,0) = "1^45^current hmp temporary nodes^l"
 ;     nodes(2,0) = "50^79^high numeric or last subscript^l"
 ;   [develop examples]
 ;
 new ROW set ROW="" ; initialize row
 do SETCOL^HMPMONL(.ROW,.NODES,1,NODE)
 do SETCOL^HMPMONL(.ROW,.NODES,2,LAST)
 ;
 quit ROW ; return row of report ; end of $$VROW
 ;
 ;
EOR ; end of routine HMPMONV
