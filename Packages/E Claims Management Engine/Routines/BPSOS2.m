BPSOS2 ;BHAM ISC/FCS/DRS - ECME manager's ScreenMan ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ECME Statistics Screen
 ;   Called by option BPS STATISTICS
 ;   Uses List Template BPS STATISTICS AND MANAGEMENT
 ;   Original IHS logic had many management function, which are no
 ;   longer used
 ;
 ; ALL writes of screen lines should be done as follows:
 ;  IF $$VISIBLE(line) DO WRITE^VALM10(line)
 ;  Then NODISPLY can be set so that $$VISIBLE always returns FALSE
 Q
 ;
EN ;EP - Option BPS STATISTICS
 N BASE,CURR,DISP,AVG,CHG
 ; BASE(*) = base values, from when zeroed things out
 ; CURR(*) = current values, from most recent read
 ; CHG(*) = changed value to print, if any
 D FETCHES(0) ; fetch stats into CURR() array - possibly reset BASE array
 M CHG=CURR
 D DIFF
 S ^TMP("BPSOS2",$J,"FREQ")=30
 I $P($G(^BPSECX("S",1,0)),U,2)="" D
 .N %,%H,%I,X D NOW^%DTC S $P(^BPSECX("S",1,0),U,2)=%
 D EN^VALM("BPS STATISTICS AND MANAGEMENT")
 Q
 ;
INIT ; Entry Code - Init variables and list array
 N NODISPLY S NODISPLY=1
 D CLEAN^VALM10
 S VALMCNT=0 ; 0 lines so far
 D LABELS^BPSOS2C
 D HDR
 D FETCHES(1) ; set up CURR
 M CHG=CURR
 D DIFF ; compute DIFF = differences and changed ones go into CHG
 D VALUES^BPSOS2B ; displays whatever's in CHG() and kills it off
 Q
 ;
 ; Define Current (CURR) array and reset BASE
 ;
 ; Input variable -> B = 0 Reset (kill) BASE values and retrieve
 ;                         values
 ;                       1 Just retrieve current values
FETCHES(B) N DST
 S DST="CURR"
 S ^TMP("BPSOS2",$J,"$H",DST)=$H
 D FETCH58(DST_"(""COMM"")")
 D FETSTAT(DST_"(""STAT"")")
 ;
 ;If entering option or resetting permanent values clear base
 I B=0 K BASE S ^TMP("BPSOS2",$J,"$H","BASE")=$H
 Q
 ;
DIFF ;EP - from BPSOS2A
 N A,B S A=""
 F  S A=$O(CURR(A)) Q:A=""  S B="" F  S B=$O(CURR(A,B)) Q:B=""  D
 .I A="STAT" S CHG(A,B)=CURR(A,B)
 .I A="COMM" S CHG(A,B)=CURR(A,B)-$G(BASE(A,B))
 ;
 Q
 ;
FETCH58(DST) ; send DST = closed root of the destination
 K @DST
 N FN,DIC,DR,DA,DIQ,TMP ; note that DA=1 is hardcoded
 S (FN,DIC)=9002313.58,DR="200:219",DIQ="TMP(",DA=1
 D EN^DIQ1
 M @DST=TMP(FN,1)
 Q
 ;
FETSTAT(DEST) ;
 ; send DEST = closed root of the destination
 K @DEST
 N Q,N,A F Q=0:10:90,31 D
 .S A="" F N=0:1 S A=$O(^BPST("AD",Q,A)) Q:A=""
 . I Q#10 S @DEST@(Q\10*10)=@DEST@(Q\10*10)+N
 . E  S @DEST@(Q)=N ; relies on multiples of 10 coming first!
 Q
 ;
UPDFREQ() ;
 Q 3
 ;
CLEARAT() ;
 S Y=$P(^BPSECX("S",1,0),U,2) X ^DD("DD") Q Y
 ;
HDR ; -- header code
 S VALMHDR(1)="Communications statistics last cleared on "_$$CLEARAT
 S XQORM("B")="U1" ; Default action is Update
 Q
 ;
UPD ;EP - From BPSOS2A ; Protocol BPS P2 UPDATE
 D UPDATE(1)
 S VALMBCK="",XQORM("B")="U1"
 Q
 ;
CONTUPD ; Protocol BPS P2 CONTINUOUS
 W !!!!!
 D UPDATE(-1)
 S VALMBCK=""
 Q
 ;
UPDATE(COUNTER) ; with COUNTER = a count down
 N STOP,DTOUT
 F  D  Q:$G(STOP)
 .D UPD1
 .S COUNTER=COUNTER-1 I 'COUNTER S STOP=1 Q
 .I '$G(NODISPLY) D
 ..D MSG^VALM10("In continuous update mode: press Q to Quit")
 ..N X S X=$$READ^XGF(1,$$UPDFREQ) D MSG^VALM10(" ")
 ..I '$G(DTOUT),X]"","Qq^^"[X S STOP=1
 ..N Y F  R Y:0 Q:'$T  ; clean out typeahead (like mistaken arrow keys)
 ..; But if timed out, keep looping and updating
 Q
 ;
UPD1 ; one update cycle
 N A,B,T
 D HDR,RE^VALM4
 D FETCHES(1) ; fetch into CURR array
 D DIFF ; compute differences
 D VALUES^BPSOS2B ; compute values and display if changed
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
