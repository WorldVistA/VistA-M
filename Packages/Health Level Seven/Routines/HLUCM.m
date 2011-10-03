HLUCM ;CIOFO-O/LJA - HL7/Capacity Mgt API ;09/13/04 14:01
 ;;1.6;HEALTH LEVEL SEVEN;**79,88,103,114**;Oct 13, 1995
 ;
 QUIT
 ;
CM(START,END,PNMSP,IEN101,TOTALS,COND,ERRINFO) ; Capacity management totals
 N NMSPTYPE,PROTYPE,RESULTS,SITENM
 I '$D(HLAPI) N HLAPI S HLAPI="CM"
 QUIT:'$$PREPARE^HLUCM001 "" ;->
 D KILLS^HLUCM009("START")
 S RESULTS=$P($$LOOP,U,1,3)
 D XTMP
 D KILLS^HLUCM009("END")
 KILL HLAPI
 Q RESULTS
 ;
CMF(START,END,PNMSP,IEN101,TOTALS,COND,ERRINFO) ; Collect Remote Facility data - SYNC
 N HLAPI
 S HLAPI="CMF"
 Q $$CM(START,END,.PNMSP,.IEN101,TOTALS,COND,.ERRINFO)
 ;
CM2(START,END,PNMSP,IEN101,TOTALS,COND,ERRINFO) ; Capacity management totals
 N NMSPTYPE,PROTYPE,RESULTS,SITENM
 I '$D(HLAPI) N HLAPI S HLAPI="CM2"
 QUIT:'$$PREPARE^HLUCM001 "" ;->
 D KILLS^HLUCM009("START")
 S RESULTS=$P($$LOOP,U,1,3) ; Counts are aggregate
 D XTMP
 D KILLS^HLUCM009("END")
 KILL HLAPI
 QUIT RESULTS
 ;
CM2F(START,END,PNMSP,IEN101,TOTALS,COND,ERRINFO) ; Collect Remote Facility data - SYNC
 N HLAPI
 S HLAPI="CM2F"
 Q $$CM2(START,END,.PNMSP,.IEN101,TOTALS,COND,.ERRINFO)
 ;
LOOP() ; Loop thru 772's .01... (Called from LOOP^HLUCM)
 N ANS,API,CHAR,COUNTED,CTDBG,CTPCKG,D0,DATA,DEF,ERR,FAC,FAIL,HL,HLASTNM
 N HLUCMADD,IEN772,IEN773,LEN,LOOP772,LOOPDT,NMSP,NUM,OK
 N ORIGETM,ORIGSTM,PCKG,PROT,PROTOCOL,QUES,SEC
 N SP,SUB,SVNO,TIMEP,TM772,TOT,V1,V2,VAL,VALUE,X,Y
 ;
 D LOAD
 D ADJTIME^HLUCM003
 D CMDBD
 D TOTALCM ; Already stored in X (no counted) or C (counted) subscripts...
 S RESULTS=$G(^TMP(TOTALS,$J))
 ;
 QUIT RESULTS
 ;
CMDBD ; Create $$CM debug data...
 ; HLAPI,START,END -- req
 N DATA,IENPAR,IEN772,OKPP,S1,S2,S3,SUB,TOT,VALNMSP,VALPROT
 ;
 S API=$S($G(API)["CM2":1,1:0) ; Async=1, Sync=0
 ;
 S IENPAR=0
 F  S IENPAR=$O(^TMP($J,"HLPARENT",IENPAR)) Q:'IENPAR  D
 .  S DATA=$G(^TMP($J,"HLPARENT",+IENPAR)) QUIT:DATA']""  ;->
 .  S VALPROT=$P(DATA,U,7),VALNMSP=$P(DATA,U,9)
 .  F S1="C","X" F S2="C","X" F S3="C","X" S TOT(S1_S2_S3)=0
 .  S ^TMP($J,"HLUCMSTORE","U",+IENPAR)=DATA
 .  S IEN772=0
 .  F  S IEN772=$O(^TMP($J,"HLPARENT",+IENPAR,IEN772)) Q:'IEN772  D
 .  .  S ^TMP($J,"HLUCMSTORE","X",+IEN772)=+IENPAR
 .  .  S (OKPP,OKPP(1))=$$PP(+IEN772)
 .  .  S OKPP=$S(OKPP=U:"X",1:"C")
 .  .  S OK=$$COLLSYNC(+IEN772,START,END) ; Outside time range?
 .  .  S SUB=$S(OK:"C",1:"X")
 .  .  S DATA=$P($G(^TMP($J,"HLCHILD",+IEN772)),"~",2,999) Q:DATA']""  ;->
 .  .  ; If # seconds exceeds 1799...
 .  .  S SUB=SUB_$S($P(DATA,U,3)>1799:"X",1:"C")_OKPP
 .  .  S:$P(DATA,U,7)']"" $P(DATA,U,7)=VALPROT
 .  .  S:$P(DATA,U,9)']"" $P(DATA,U,9)=VALNMSP
 .  .  S ^TMP($J,"HLUCMSTORE","U",+IENPAR,+IEN772,SUB)=DATA
 .  .  F I=1:1:3 S $P(TOT(SUB),U,I)=$P(TOT(SUB),U,I)+$P(DATA,U,I)
 .  .  S DATA=$G(^TMP($J,"HLPARENT",+IENPAR,+IEN772))
 .  .  S X=OKPP(1),$P(DATA,U,5)=$P(X,U),$P(DATA,U,6)=$P(X,U,2)
 .  .  S ^TMP($J,"HLUCMSTORE","U",+IENPAR,+IEN772,SUB,772)=DATA
 .
 .  ; Position #1  C=Count    (Message BEGIN is not before START)
 .  ;              X=Outside  (Msg BEGIN is before START)
 .  ;          #2  C=Count    (#Seconds<1800)
 .  ;              X=Greater  (#Seconds>1799)
 .  ;          #3  C=Count    (Protocol/Namespace match)
 .  ;              X=Mismatch (Protocol/Namespace mismatch)
 .  F S1="C","X" F S2="C","X" F S3="C","X" S SUB=S1_S2_S3 D
 .  .  QUIT:$TR(TOT(SUB),"0^","")']""  ;->
 .  .  S ^TMP($J,"HLUCMSTORE","U",+IENPAR,SUB)=TOT(SUB)
 .  .
 .  .  S TOT=$G(^TMP($J,"HLUCMSTORE","T",SUB))
 .  .  D UPTOT
 .  .  S ^TMP($J,"HLUCMSTORE","T",SUB)=TOT
 .  .
 .  .  S ^TMP($J,"HLUCMSTORE","T",SUB,IENPAR)=TOT(SUB)
 .  .
 .  .  S TOT=$G(^TMP($J,"HLUCMSTORE","T"))
 .  .  D UPTOT
 .  .  S ^TMP($J,"HLUCMSTORE","T")=TOT
 ;
 KILL ^TMP($J,"HLCHILD"),^TMP($J,"HLPARENT")
 ;
 Q
 ;
UPTOT ; Up the totals...
 ; TOT,TOT(SUB) -- req
 S $P(TOT,U)=$P(TOT,U)+$P(TOT(SUB),U)
 S $P(TOT,U,2)=$P(TOT,U,2)+$P(TOT(SUB),U,2)
 S $P(TOT,U,3)=$P(TOT,U,3)+$P(TOT(SUB),U,3)
 Q
 ;
PP(IEN772) ; Get store value for NMSP and PROT...
 N PCKG,PP,PROT,X
 S PP=$$PROTNMSP^HLUCM002(+IEN772)
 I $P(PP,U)']""!($P(PP,U,2)']"") QUIT U ;->
 S X=$P(PP,U),PROT=$S(X]"":X,1:"ZZZ")
 S X=$P(PP,U,2),PCKG=$S(X]"":X,1:"ZZZ")
 Q PROT_U_PCKG
 ;
LOAD ; Load data (Called by $$CM, $$CM2, and all other APIs)
 ; START,END -- req
 N IEN772,LOOPDT,X
 S LOOPDT=START-.000001
 F  S LOOPDT=$O(^HL(772,"B",LOOPDT)) Q:LOOPDT'>0!(LOOPDT>END)  D
 .  S IEN772=0
 .  F  S IEN772=$O(^HL(772,"B",LOOPDT,IEN772)) Q:IEN772'>0  D
 .  .  QUIT:'$$OK772(+IEN772)  ;->
 .  .  S X=$$LOAD772S^HLUCM009(IEN772)
 Q
 ;
TOTALCM ; Loop, total for $$CM...
 ; HLAPI -- req
 N IEN772,IENPAR
 S IENPAR=0
 F  S IENPAR=$O(^TMP($J,"HLUCMSTORE","U",IENPAR)) Q:'IENPAR  D
 .  ; Don't count anything unless the entire unit is OK...
 .  QUIT:$O(^TMP($J,"HLUCMSTORE","U",+IENPAR,"CCC"))]""  ;->
 .  S IEN772=0,HLUCMADD=""
 .  F  S IEN772=$O(^TMP($J,"HLUCMSTORE","U",IENPAR,IEN772)) Q:'IEN772  D
 .  .  ;QUIT:'$D(^TMP($J,"HLUCMSTORE","U",+IENPAR,+IEN772,"CCC"))  ;->
 .  .  D COLLECT(+IENPAR,+IEN772)
 .  .  I HLAPI["CM2" S HLUCMADD="DON'T ADD.  COLLECT3~HLUCM003"
 Q
 ;
COLLSYNC(IEN772,START,END) ; Does entry fall in START/END range?
 N DATA,X
 S DATA=$G(^TMP($J,"HLCHILD",+IEN772)) QUIT:DATA']"" "" ;->
 S X=$P($P(DATA,"~",2,999),U,4) Q:X'?7N.E!(X<START)!(X>END) "" ;->
 Q 1
 ;
OK772(IEN772) ; Valid entry?
 N D
 S D=$G(^HL(772,+IEN772,0))
 QUIT:$P(D,U)'?7N.E "" ;->
 I $P(D,U,2)']"",$P(D,U,3)']"",$P(D,U,4)']"",$P(D,U,5)']"" QUIT ""
 Q 1
 ;
COLLECT(PAR,IEN772) ; Collect 772 data and associated 773 data...
 N CT,CTPCKG,DATA,DBGBL,IEN773,PP,TOT772,TOT772T,TYPEHR,TYPEIO,TYPELR
 ;
 ; ^("U",PARENT-IEN,CHILD-IEN,"CCC")
 S DATA=$G(^TMP($J,"HLUCMSTORE","U",+PAR,+IEN772,"CCC"))
 S DATA("CHAR")=$P(DATA,U),DATA("DIFF")=$P(DATA,U,3)
 S DATA("START")=$P(DATA,U,4),DATA("END")=$P(DATA,U,5)
 S DATA("FAC")=$P(DATA,U,11)
 ;
 ; ^("U",PARENT-IEN,CHILD-IEN,"CCC",772)
 S DATA=$G(^TMP($J,"HLUCMSTORE","U",+PAR,+IEN772,"CCC",772))
 S DATA("HR")=$P(DATA,U),DATA("IO")=$P(DATA,U,2),DATA("LR")=$P(DATA,U,3)
 S (DATA("PROT"),PROT)=$P(DATA,U,5)
 S (DATA("PCKG"),PCKG)=$P(DATA,U,6)
 ;
 S DBGBL=1
 ;
 ; Store DATA() info in ^TMP(TOTALS,$J,...)
 D ADDTMP^HLUCM001
 ;
 QUIT
 ;
TOT772C(IEN772) ; Total number of characters in message...
 N LEN,LNO,TXT
 ;
 ; Use field if present.  (Not present about 25% of time)
 S LEN=$P($G(^HL(772,IEN772,"S")),U)
 I LEN D  QUIT  ;->
 .  S DATA("CHAR",772)=$G(DATA("CHAR",772))+LEN
 .  S DATA("CHAR")=$G(DATA("CHAR"))+LEN
 ;
 ; Total manually...
 S LNO=0
 F  S LNO=$O(^HL(772,IEN772,"IN",LNO)) Q:LNO'>0  D
 .  S TXT=$G(^HL(772,IEN772,"IN",+LNO,0)) QUIT:TXT']""  ;->
 .  S DATA("CHAR",772)=$G(DATA("CHAR",772))+$L(TXT)
 .  S DATA("CHAR")=$G(DATA("CHAR"))+$L(TXT)
 ;
 QUIT
 ;
TOT772T(IEN772) ; Processing time...
 ; No totals here.  Just set times in DATA() array for later use...
 N TIME
 ;
 ; Time of entry...
 S TIME=+$G(^HL(772,+IEN772,0))
 I TIME?7N.E S DATA("TIME",TIME,772,.01)=""
 ;
 ; Time processed...
 S TIME=$P($G(^HL(772,+IEN772,"P")),U,2)
 I TIME?7N.E S DATA("TIME",TIME,772,21)=""
 ;
 QUIT
 ;
TOT773C(IEN773) ; Total number of characters...
 ; DATA() -- passed in  (See COLLECT)
 N CHAR
 S CHAR=$$MSGSIZE(+IEN773) QUIT:CHAR'>0  ;->
 S DATA("CHAR",773,IEN773)=CHAR
 S DATA("CHAR")=$G(DATA("CHAR"))+CHAR
 S TOT773(IEN773)=CHAR
 QUIT
 ;
MSGSIZE(IEN773) ; Number characters in 773 entry...
 N NCH,NO
 S NCH=0,NO=0
 F  S NO=$O(^HLMA(+IEN773,"MSH",NO)) Q:NO'>0  D
 .  S NCH=NCH+$L($G(^HLMA(+IEN773,"MSH",+NO,0)))
 QUIT NCH
 ;
TOT773T(IEN773) ; Set TIMEs...
 ; DATA() -- passed in  (See COLLECT)
 N TIME
 ;
 ; Creation time already taken from 772...
 ;
 ; Processed time...
 S TIME=+$G(^HLMA(+IEN773,"S")) QUIT:TIME'>0  ;->
 S DATA("TIME",TIME,773,100)=""
 ;
 QUIT
 ;
ERR(REA) ; Record error...
 S NOERR=NOERR+1
 S REA=$S($G(REA)]"":REA,1:"?")
 S ERRINFO(REA)=""
 QUIT
 ;
SEC(FMDT) ;
 S FMDT=$$FMTH^XLFDT(FMDT)
 QUIT $$SEC^XLFDT(FMDT)
 ;
TMDIFF ; DATA("TIME",...) -- req --> DATA("DIFF")
 S (DATA("DIFF"),DATA("END"),DATA("START"))="" ; Default... HL*1.6*114
 S DATA("START")=$O(DATA("TIME",0)) QUIT:DATA("START")'>0  ;->
 S DATA("END")=$O(DATA("TIME",":"),-1)
 S DATA("DIFF")=$$SEC(DATA("END"))-$$SEC(DATA("START"))
 QUIT
 ;
XTMP ; Store in ^XTMP...
 ; API Parameters -- req
 N XTMP
 ;
 QUIT:PNMSP'=1!(IEN101'=1)  ;-> Must be ALL,ALL
 ;
 S XTMP="HLUCM "_$$DT^XLFDT
 S:'$D(^XTMP(XTMP,0)) ^XTMP(XTMP,0)=$$FMADD^XLFDT($$DT^XLFDT,7)_U_$$NOW^XLFDT_U_"HLUCM Data"
 ;
 S SVNO=$G(^XTMP(XTMP,"P",+START,+END,COND))
 I SVNO'>0 S SVNO=$O(^XTMP(XTMP,"N",":"),-1)+1
 S ^XTMP(XTMP,"P",+START,+END,COND)=SVNO_U_$$NOW^XLFDT
 S ^XTMP(XTMP,"N",+SVNO)=START_U_END_U_COND_U_HLAPI
 KILL ^XTMP(XTMP,"D",+SVNO)
 ;
 MERGE ^XTMP(XTMP,"D",+SVNO)=^TMP(TOTALS,$J)
 ;
 Q
 ;
EOR ; HLUCM - HL7/Capacity Mgt API ;2/27/01 10:15
