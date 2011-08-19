HLUCM002 ;CIOFO-O/LJA - HL7/Capacity Mgt API ;2/27/01 10:15
 ;;1.6;HEALTH LEVEL SEVEN;**79,88,103**;Oct 13, 1995
 ;
PRINTREG ; Print data in ^TMP(SUB,...) to screen
 ; SUB,JOBN -- req
 N DEB,GBL,IOINHI,IOINORM,JOBN,SUB,TOT,WAY,X,XTMPGBL
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 W @IOF,$$CJ^XLFSTR("Print Totals Report & Debug Data to Screen",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 S XTMPGBL=""
 ;
 ; What is the SUB for the Totals Report...
 S SUB=$$SUB
 I SUB']"" W !!,"OK! No ^TMP(TOTALS,$J) totals report will be printed..."
 I SUB]"" D PTOT
 ;
 ; Debug data...
 I '$D(^TMP($J,"HLUCMSTORE")) D
 .  W !!,"No ^TMP($J,""HLUCMSTORE"") debug data exists..."
 I $D(^TMP($J,"HLUCMSTORE")) D PSTORE
 ;
 I SUB']"",'$D(^TMP($J,"HLUCMSTORE")) D  QUIT  ;->
 .  S X=$$BTE^HLCSMON("Press RETURN to exit... ",1)
 ;
 QUIT:$$BTE^HLCSMON("Press RETURN to restart, or '^' to exit... ",1)  ;->
 ;
 G PRINTREG ;->
 ;
PSTORE ;
 W !!,$$CJ^XLFSTR("----------- "_IOINHI_"Debug Data from ^TMP($J,""HLUCMSTORE"")"_IOINORM_" -----------",IOM)
 R !!,"Print raw DEBUG DATA (Y/N): Yes// ",X:999 S:X="" X="Y" S DEB=$$UP^XLFSTR($E(X_" ")) Q:'$T!(DEB[U)  ;->
 I DEB="Y" D PRINTDBG^HLUCM090
 ;
 R !!,"Print filtered DEBUG DATA (Y/N): Yes// ",X:999 S:X="" X="Y" S DEB=$$UP^XLFSTR($E(X_" ")) Q:'$T!(DEB[U)  ;->
 I DEB="Y" D LOOPU^HLUCM004
 Q
 ;
PTOT ;
 W !!,"You will be allowed to print report totals (from ^TMP(TOTALS,$J), and/or you"
 W !,"may print the debug data (in ^TMP($J,""HLUCMSTORE"")."
 W !!,$$CJ^XLFSTR("------------ "_IOINHI_"Report Totals from ^TMP("""_SUB_""",$J)"_IOINORM_" ------------",IOM)
 R !!,"Print REPORT TOTALS (Y/N): Yes// ",X:999 S:X="" X="Y" S TOT=$$UP^XLFSTR($E(X_" ")) Q:'$T!(TOT[U)  ;->
 I TOT="Y" D
 .  S SUB="TOT",JOBN=$J
 .  I '$D(^TMP(SUB,JOBN)) S SUB="KMPDH"
 .  R !,"Include subtotals (Y/N): NO// ",WAY:999 QUIT:'$T!(WAY[U)  ;->
 .  S:WAY']"" WAY="N"
 .  S WAY=$$UP^XLFSTR($E(WAY_" ")),WAY=$S(WAY="N":0,1:1)
 .  S X=$$XTMPGBL^HLUCM004(0) I X]"" S (GBL,XTMPGBL)=X W !!,"Printing from ",XTMPGBL,"..."
 .  D PRINT1
 Q
 ;
SUB() ; What subscript holds the ^TMP(SUB,$J) data?
 N SUB
 I $D(^TMP("KMPDH",$J)) QUIT "KMPDH" ;->
 I $D(^TMP("TOT",$J)) QUIT "TOT" ;->
 R !!,"Enter subscript holding the ^TMP(TOTALS,$J) data: ",SUB:999 Q:SUB[U!(SUB']"") "" ;->
 Q SUB
 ;
PRINT(SUB,JOBN,WAY) ; Print data in ^TMP(SUB,...) to screen
 ; WAY -- 0 = No totals
 ;        1 = Totals for every section
 N L1,L2,L3
 ;
 S WAY=$S($G(WAY)'>0:0,$G(WAY)=1:1,1:0)
 ;
 S:$G(JOBN)'>0 JOBN=$J
 I $G(SUB)']"" D  QUIT  ;->
 .  W !!,"You must pass in the initial subscript and $JOB number..."
 .  W !
PRINT1 D PRINT1^HLUCM090
 ;
 S GBL=$NA(^TMP($J,"HLUCMSTORE","T"))
 S L1=0 F L2="CCX","CXC","CXX","XCC","XCX","XXC","XXX" I $D(@GBL@(L2)) S L1=1
 QUIT:'L1  ;->
 ;
 W !!,"Some entries were not included in the totals.  There are 3 possible reasons"
 W !,"for entries being excluded: (1) The beginning time of a message or unit is"
 W !,"before the report's start time, (2) The number of seconds to transmit the"
 W !,"message is over 1799 seconds, and (3) The protocol or namespace doesn't meet"
 W !,"the search criteria."
 W !!,"Failure Reason",?30,"#Characters",?42,"#Msg/Units",?54,"#Seconds"
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 F LAST="CCX","CXC","CXX","XCC","XCX","XXC","XXX" I $G(@GBL@(LAST))]"" Q
 ;
 S TYP="XXX",DATA=$G(@GBL@(TYP)) I DATA]"" D
 .  D SHOW("Beginning time too early",DATA)
 .  D SHOW("Excessive xmit time")
 .  D SHOW("Prot/Nmsp mismatch","",1)
 S TYP="XXC",DATA=$G(@GBL@("XXC")) I DATA]"" D
 .  D SHOW("Beginning time too early",DATA)
 .  D SHOW("Excessive xmit time","",1)
 S TYP="XCX",DATA=$G(@GBL@("XCX")) I DATA]"" D
 .  D SHOW("Beginning time too early",DATA)
 .  D SHOW("Prot/Nmsp mismatch","",1)
 S TYP="XCC",DATA=$G(@GBL@("XCC")) I DATA]"" D
 .  D SHOW("Beginning time too early",DATA,1)
 S TYP="CXX",DATA=$G(@GBL@("CXX")) I DATA]"" D
 .  D SHOW("Excessive xmit time",DATA)
 .  D SHOW("Prot/Nmsp mismatch","",1)
 S TYP="CXC",DATA=$G(@GBL@("CXC")) I DATA]"" D
 .  D SHOW("Excessive xmit time",DATA,1)
 S TYP="CCX",DATA=$G(@GBL@("CCX")) I DATA]"" D
 .  D SHOW("Prot/Nmsp mismatch",DATA,1)
 I L1!L2!L3 W !,$$REPEAT^XLFSTR("=",IOM),!,"Totals:",?30,$J(L1,7),?42,$J(L2,7),?54,$J(L3,7)
 ;
 Q
 ;
SHOW(REA,DATA,LINE) ;
 ; LAST,TYP -- req
 S DATA=$G(DATA),LINE=$G(LINE)
 W !,REA
 I $G(DATA)]"" W ?30,$J($P(DATA,U),7),?42,$J($P(DATA,U,2),7),?54,$J($P(DATA,U,3),7)
 I $G(LINE),TYP'=LAST W !,$$REPEAT^XLFSTR("-",IOM)
 S L1=$G(L1)+$P(DATA,U),L2=$G(L2)+$P(DATA,U,2),L3=$G(L3)+$P(DATA,U,3)
 QUIT
 ;
ADD(TL) ; Add to TOT...
 S $P(TOT,U)=$P(TOT,U)+$P(TL,U)
 S $P(TOT,U,2)=$P(TOT,U,2)+$P(TL,U,2)
 S $P(TOT,U,3)=$P(TOT,U,3)+$P(TL,U,3)
 Q
 ;
OKPAR(PAR) ; Is namespace or protocol OK?
 S PAR=$G(PAR)
 I PAR=1!(PAR=2) QUIT 1 ;->
 I $$OK0CALL(PAR) QUIT 1 ;->
 QUIT ""
 ;
OK0CALL(PAR) ; Correct 0^IEN or 0^NAME call format?
 I $E(PAR,1,2)="0^"&($E(PAR,3)]"") QUIT 1 ;->
 QUIT ""
 ;
TYPETMO(IEN772) ; Is this TCP, Mail (via TCP), or Other?
 N D772,I773,MIEN
 ;
 ; RELATED MAILMAN MESSAGE field (0;5) in 772...
 S D772=$G(^HL(772,+IEN772,0)) ; Get node
 S MIEN=$P(D772,U,5) ; get Mailman IEN from field...
 I MIEN QUIT "M" ;-> Mailman via TCP
 ;
 ; There are rare instances when RELATED MAILMAN MESSAGE field is
 ; not filled in, but the LLP TYPE in 870 is Mailman.  So, the next
 ; check is needed...
 ;
 ; Get related 870 and check it's LLP TYPE...
 I $P($G(^HLCS(870,+$$IEN870^HLUCM009(+IEN772),0)),U,3)=1 QUIT "M" ;->
 ;
 ; OK.  Let's give up on proving this 772 entry a Mailman entry.
 ; But, is it TCP?
 ;
 ; Check if TCP by 773 link...
 S I773=$O(^HLMA("B",+IEN772,0))
 I I773>0 QUIT "T" ;->
 ;
 QUIT "U" ; Other...
 ;
TYPEIO(IEN772) ; Is this Input or Output or Unknown?
 N D772,HLIO
 S D772=$G(^HL(772,+IEN772,0))
 S HLIO=$E($P(D772,U,4)_" ")
 QUIT $S("IO"[HLIO:HLIO,1:"U")
 ;
PROTNMSP(IEN772) ; Return PROT~NMSP value to store in ^TMP.  
 ; COND,IEN101,PNMSP -- req
 N CT,FAIL,PCKG,CTPROT,PCKG,PROT
 ;
 S IEN101=$G(IEN101),PNMSP=$G(PNMSP)
 ;
 ; ======================== PROTOCOL ============================
 ; Get actual protocol in IEN772 if not supposed to "lump"...
 S PROT=$S(IEN101'=2:$$GETPROT^HLUCM050(+IEN772),1:"ZZZ")
 ;
 ; Don't lose count if supposed to check everything...
 I IEN101=1!(IEN101=2) D
 .  I PROT']"" S PROT="ZZZ" QUIT  ;->
 .  I IEN101=2 S PROT="ZZZ"
 ;
 ; Is the protocol countable?  (Must also check namespace)
 S CTPROT=$$CTPROT^HLUCM003(PROT)
 ;
 ; ======================== NAMESPACE ============================
 ; Set package here and now...
 S PCKG=$S(PNMSP'=2:$$GETNMSP^HLUCM050(+IEN772),1:"ZZZ")
 ;
 I PNMSP=1!(PNMSP=2) D
 .  I PCKG']"" S PCKG="ZZZ" QUIT  ;->
 .  I PNMSP=2 S PCKG="ZZZ"
 ;
 S CTPCKG=$$CTPCKG^HLUCM003(PCKG)
 ;
 ;
 ; Set up what should be returned...  
 S PROT=$S(PROT=2:"ZZZ",1:PROT),PCKG=$S(PCKG=2:"ZZZ",1:PCKG)
 ; If MIXED make sure the ALL side of things is set to something
 ; so the ALL side doesn't squelch a SPECIFIC match...
 I $$MIXED D
 .  I $G(PNMSP)=1!($G(PNMSP)=2) D
 .  .  QUIT:PROT]""  ;->
 .  .  QUIT:'CTPROT  ;-> Not to be counted anyway...
 .  .  S PROT="ZZZ~0"
 .  I $G(IEN101)=1!($G(IEN101)=2) D
 .  .  QUIT:PCKG]""  ;->
 .  .  QUIT:'CTPCKG  ;-> Not to be counted anyway...
 .  .  S PCKG="ZZZ"
 I '$$MIXED,COND="EITHER" D
 .  QUIT:$$ALL($G(PNMSP),$G(IEN101))  ;-> All 1s or 2s...
 .  I NMSPTYPE'=1 D  ; Asked specifically...
 .  .  QUIT:PROT]""  ;->
 .  .  S PROT="ZZZ~0"
 .  I PROTYPE'=1 D  ; Asked specifically...
 .  .  QUIT:PCKG]""  ;->
 .  .  S PCKG="ZZZ"
 ;
 ; If neither should be counted, don't...
 I 'CTPROT&('CTPCKG) QUIT U ;->
 ;
 ; Either namespace or protocol matches, or both match...
 ;
 ; If BOTH namespace and protocol are required to match, don't count if one isn't a match...
 I COND="BOTH" I 'CTPROT!('CTPCKG) QUIT U ;->
 ;
 ; If 1/2 & SPECIFIC (i.e., MIXED), then SPECIFIC trumps 1/2...
 ; (If SPECIFIC not matched, it is not counted)
 I $$MIXED D  QUIT:FAIL U ;->
 .  S FAIL=1
 .  ; If ALL NMSPs to be counted, but specific PROT fails... BAD!
 .  I $G(PNMSP)=1!($G(PNMSP)=2) QUIT:'CTPROT  ;->
 .  ; If ALL PROTs to be counted, but specific PCKG fails... BAD!
 .  I $G(IEN101)=1!($G(IEN101)=2) QUIT:'CTPCKG  ;->
 .  S FAIL=0
 ;
 QUIT PROT_U_PCKG
 ;
ALL(V1,V2) ; Are both 1 or 2?
 S V1=$G(V1),V2=$G(V2)
 QUIT:V1'=1&(V1'=2) "" ;->
 QUIT:V2'=1&(V2'=2) "" ;->
 QUIT 1
 ;
MIXED() ; Is one 1/2 and the other SPECIFIC?
 N V3
 S V1=$G(PNMSP),V1=$S(V1]"":$S(V1=1!(V1=2):1,1:0),1:0)
 S V2=$G(IEN101),V2=$S(V2]"":$S(V2=1!(V2=2):1,1:0),1:0)
 S V1=$S(V1=1!(V1=2):1,1:0)
 S V2=$S(V2=1!(V2=2):1,1:0)
 S V3=V1+V2
 QUIT $S(V3=1:1,1:"")
 ;
PROT101(IEN772) ; Return 101 information...
 N IEN,MIEN,NM
 ;
 ; Get normal protocol information
 S IEN=$P($G(^HL(772,IEN772,0)),U,10)
 S NM=$P($G(^ORD(101,+IEN,0)),U)
 ;
 ; Maybe this is a Mailman ptr only...
 I NM']"",IEN'>0 D
 .  S MIEN=$P($G(^HL(772,+IEN772,0)),U,5) QUIT:MIEN'>0  ;->
 .  S NM="XMB",IEN=9999999
 ;
 QUIT $S(NM]""!(IEN>0):NM_"~"_IEN,1:"")
 ;
EOR ; HLUCM002 - HL7/Capacity Mgt API ;2/27/01 10:15
