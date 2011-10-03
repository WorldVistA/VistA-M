HLEVUTIL ;O-OIFO/LJA - Event Monitor UTILITIES ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
SLM() ; Return info to Systems Link Monitor [HLCSMON1]...
 N BAD,DATA,DATE,DAY,DOWN,FIEN,HR,IEN,IOBON,IOBOFF,LASTDT,MIN,SEC,X
 ;
 S X="IOBOFF;IOBON" D ENDR^%ZISS
 S DOWN="Monitor "_IOBON_"DOWN"_IOBOFF
 ;
 I $P($G(^HLEV(776.999,1,0)),U,2)'="A" D  QUIT DOWN ;->
 .  S DOWN="Monitor "_IOBON_"STOPPED"_IOBOFF
 ;
 S LASTDT=":",FIEN=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(FIEN)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(FIEN)  D
 .  .  S DATA=$G(^HLEV(776.2,+IEN,0)) QUIT:$P(DATA,U,4)'="Q"  ;->
 .  .  S FIEN=IEN
 I 'FIEN QUIT DOWN ;->
 S DATA=$G(^HLEV(776.2,+FIEN,0))
 S DATE=$P(DATA,U,6) QUIT:DATE'?7N1"."1.N DOWN ;->
 S DATE=$$FMTH^XLFDT(DATE),DATE(1)=$$SEC^HLEVMST0(DATE)
 S NOW=$H,NOW(1)=$$SEC^HLEVMST0(NOW)
 I DATE(1)<NOW(1) D  QUIT $S(BAD:DOWN,1:"Monitor current") ;->
 .  S BAD=0
 .  QUIT:(NOW(1)-DATE(1))<(5*60)  ;-> OK if less than 5 minutes old
 .  S BAD=1,DOWN="Monitor "_IOBON_"OVERDUE"_IOBOFF
 S DIFF=$$DIFFDH^HLCSFMN1(NOW,DATE)
 S DAY=+DIFF,DIFF=$TR($P(DIFF,U,2),":",U)
 S HR=+DIFF+(DAY*24),MIN=+$P(DIFF,U,2),SEC=+$P(DIFF,U,3)
 S:SEC>30 MIN=MIN+1
 S HR=HR+MIN/60,HR=$J(HR,"",1)
 Q "Monitor current [next job "_HR_" hr]"
 ;
DHMSFM(DTFM,NOW,LONG) ; Convert Fileman d/t to Days-Hr-Min-Sec
 N HORO
 QUIT:$G(DTFM)'?7N.1".".10N "" ;->
 S NOW=$$FMTH^XLFDT($S($G(NOW)?7N.E:NOW,1:$$NOW^XLFDT)) ; Default
 S HORO=$$FMTH^XLFDT(DTFM)
 Q $$DHMSH(HORO,NOW,LONG)
 ;
DHMSH(DTH,NOW,LONG) ; Convert HORO d/t to Days-Hr-Min-Sec
 N DIFF,FUTURE,TIME,X
 S LONG=+$G(LONG)
 QUIT:$G(DTH)'?5N1","1.N "" ;->
 S NOW=$S($G(NOW)]"":NOW,1:$H),FUTURE=0
 I +NOW<DTH!(+NOW=+DTH&($P(NOW,",",2)<$P(DTH,",",2))) D
 .  S X=DTH,DTH=NOW,NOW=X,FUTURE=1
 S DIFF=$$DIFFDH^HLCSFMN1(DTH,NOW)
 S TIME=""
 D C($P(DIFF,U),$S(LONG:$S(+$P(DIFF,U)>1:" days",1:" day"),1:"d"))
 D C($P($P(DIFF,U,2),":"),$S(LONG:" hr",1:"h"))
 D C($P($P(DIFF,U,2),":",2),$S(LONG:" min",1:"m"))
 D C($P($P(DIFF,U,2),":",3),$S(LONG:" sec",1:"s"))
 F  Q:$E(TIME)'=" "  S TIME=$E(TIME,2,999)
 F  Q:$E(TIME,$L(TIME))'=" "  S TIME=$E(TIME,1,$L(TIME)-1)
 I FUTURE,TIME]"" S TIME="["_TIME_"]"
 Q TIME
 ;
C(NO,UN) ; Convert to #[UN]...
 I NO'>0 QUIT  ;->
 S TIME=TIME_$S(TIME]"":" ",1:"")_" "_+NO_UN
 Q
 ;
WPTXT(FILE,IEN,NODE,DDNO,TXT) ; Add text to multiple WP field...
 N NO
 QUIT:$G(^HLEV(+FILE,+IEN,0))']""  ;->
 S NO=$O(^HLEV(+FILE,+IEN,NODE,":"),-1)+1
 S ^HLEV(+FILE,+IEN,NODE,+NO,0)=$G(TXT)
 S ^HLEV(+FILE,+IEN,NODE,0)=U_DDNO_U_NO_U_NO
 Q
 ;
DOLRO(SUB,KILL,DAYS) ; Store data in ^XTMP("HLEV-"_SUB)...
 N NO,NOW,X
 ;
 ; Defaults and setup variables...
 S:$E(SUB,1,5)'="HLEV-" SUB="HLEV-"_SUB
 S:$G(DAYS)'>0 DAYS=2
 S NOW=$$NOW^XLFDT
 ;
 ; KILL?
 I $G(KILL)=1 KILL ^XTMP(SUB)
 ;
 ; Always reset 0 node...
 S ^XTMP(SUB,0)=$$FMADD^XLFDT(NOW,DAYS)_U_NOW_"^HL7 Event Monitoring debug code (LJA)"
 ;
 ; Store data...
 S NO=$O(^XTMP(SUB,":"),-1)+1
 S X=$NA(^XTMP(SUB,NO)),X=$E(X,1,$L(X)-1)_"," D DOLRO^%ZOSV
 ;
 Q
 ;
UNQUEUE ; Unqueue any future master jobs...
 N CT,DATA,IEN,LASTDT
 S LASTDT=":",CT=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(CT>4)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(CT>4)  D
 .  .  S DATA=$G(^HLEV(776.2,+IEN,0)) QUIT:DATA']""  ;->
 .  .  QUIT:$P(DATA,U,4)'="Q"  ;-> Not queued for future...
 .  .  S TASKNO=$P(DATA,U,5) QUIT:TASKNO'>0  ;->
 .  .  D UNQ(+IEN,+TASKNO,"Aborted by installation pre-init.")
 Q
 ;
UNQ(IEN7762,TASKNO,REASON) ; Unqueue Taskman task and mark 776.2 properly...
 N ZTSK
 S ZTSK=+TASKNO
 D DQ^%ZTLOAD
 D UPDFLDM^HLEVMST(+IEN7762,4,"A")
 D UPDFLDM^HLEVMST(+IEN7762,50,REASON)
 Q
 ;
PURGEV(HLEVIENM) ; Purge master job entries...
 N CUTIME,IEN,LOOPTM,NOPURG,RETHRM
 ;
 S NOPURG=0
 ;
 ; Get retention time (HR) for master job data...
 S RETHRM=$O(^HLEV(776.999,":"),-1)
 S RETHRM=$P($G(^HLEV(776.999,+RETHRM,0)),U,4)
 S RETHRM=$S(RETHRM>0:RETHRM,1:96) ; Default to 96 hours
 ;
 ; Cutoff time...
 S CUTIME=$$FMADD^XLFDT($$NOW^XLFDT,0,-RETHRM)
 ;
 F  S CUTIME=$O(^HLEV(776,"B",CUTIME),-1) Q:CUTIME'>0  D
 .  S IEN=0
 .  F  S IEN=$O(^HLEV(776,"B",CUTIME,IEN)) Q:IEN'>0  D
 .  .  S NOPURG=NOPURG+1
 .  .  D DELETE(776,+IEN)
 ;
 Q NOPURG
 ;
PURGEME(IEN7762) ; Purge events "pointed to" by 776.2...
 ; NOPURG -- req
 N DATA,IEN776,MIEN
 S MIEN=0
 F  S MIEN=$O(^HLEV(776.2,+IEN7762,51,MIEN)) Q:'MIEN  D
 .  S DATA=$G(^HLEV(776.2,+IEN7762,51,MIEN,0)) Q:DATA']""  ;->
 .  S IEN776=+DATA QUIT:$G(^HLEV(776,+IEN776,0))']""  ;->
 .  D DELETE(776,+IEN776)
 .  S NOPURG=$G(NOPURG)+1
 Q
 ;
 ;
 ;
 ;
 ;
 ;                          GENERAL CODE
PURGEALL(HLEVIENM) ; Purge all EVENT MONITORing files...
 N NOPURGE,NOPURGM,TXT
 ;
 QUIT:$G(^HLEV(776.2,+$G(HLEVIENM),0))']""  ;->
 ;
 ; Check parameter...
 QUIT:$P($G(^HLEV(776.999,1,0)),U,2)'="A"  ;->
 ;
 S NOPURGM=$$PURGEM^HLEVMST(HLEVIENM) ; Master job data...
 S NOPURGE=$$PURGEV(HLEVIENM) ; Event job data...
 QUIT:(NOPURGE+NOPURGM)'>0  ;->
 S TXT="Purges: "_$S(NOPURGE:"#"_NOPURGE_" events.  ",1:"")_$S(NOPURGM:"#"_NOPURGM_" master jobs.  ",1:"")
 D UPDFLDM^HLEVMST(+HLEVIENM,50,TXT)
 ;
 Q
 ;
DELETE(FILE,IEN) ; Delete entry...
 N DA,DIK
 QUIT:$G(^HLEV(+$G(FILE),+$G(IEN),0))']""  ;->
 S DA=+IEN,DIK="^HLEV("_$G(FILE)_","
 D ^DIK
 Q
 ;
REMOVALL ; Remove all Event Monitor Job (#776) and HL7 Monitor Master
 ; Job (#776.2) data.  Leave only setup file (#776.1 & 776.999)
 ; data untouched.
 N FILE,NODE
 W @IOF,$$CJ^XLFSTR("Purging of 776 and 776.2 (non-setup) Data",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !
 I $O(^HLEV(776,0))'>0&($O(^HLEV(776.2,0))'>0) D  QUIT  ;->
 .  W !,"There is no data to delete..."
 F FILE=776,776.2 D
 .  I $O(^HLEV(+FILE,0))'>0 D  QUIT  ;->
 .  .  W !,"No data to delete for file ",FILE,"..."
 .  S X=$$YN^HLCSRPT4("OK to delete file "_FILE_" data","No") I 'X D  QUIT  ;->
 .  .  W " ... not deleted ..."
 .  W " ... deleting!!"
 .  S NODE=$P($G(^HLEV(+FILE,0)),U,1,2)
 .  KILL ^HLEV(+FILE)
 .  S ^HLEV(+FILE,0)=NODE
 Q
 ;
YN(PMT,DEF,FF) ; Generic YES/NO DIR call... ;HL*1.6*85
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F X=1:1:$G(FF) W !
 S DIR(0)="Y",DIR("A")=PMT
 S:$G(DEF)]"" DIR("B")=DEF
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) U ;->
 QUIT $S(Y=1:1,1:"")
 ;
ENDIQ1(FILE,IEN,GBLSV) ; Create ^TMP($J,GBLSV,) data...
 N DA,DIC,DIQ,DR
 ;
 KILL ^TMP($J,GBLSV),^UTILITY("DIQ1",$J)
 ;
 ; Sets...
 S DIC=$G(FILE) QUIT:FILE']""  ;->
 S DR=$$DICDR(FILE) QUIT:DR']""  ;->
 S DA=+IEN
 S GBLSV=$S($G(GBLSV)]"":GBLSV,1:"HLEVDIQ")
 S DIQ(0)="E"
 ;
 ; Generate data...
 D EN^DIQ1
 ;
 ; Add more data (usually multiples)...
 D ADDIQ(FILE,IEN)
 ;
 QUIT:'$D(^UTILITY("DIQ1",$J))  ;->
 ;
 ; Prep fields and move into ^TMP...
 D MOVETMP^HLEVUTI3(FILE,IEN,GBLSV)
 ;
 KILL ^UTILITY("DIQ1",$J)
 ;
 Q
 ;
ADDIQ(FILE,IEN,GBLSV) ; Add more data to ^TMP($J,GBLSV)
 I FILE=772 D ADDMULT(FILE,"^HL(772,"_IEN_",""IN"")",IEN,10,"MESSAGE TEXT",200)
 I FILE=773 D ADDMULT(FILE,"^HLMA("_IEN_",""MSH"")",IEN,10,"MSH",200)
 Q
 ;
ADDMULT(FILE,GBL,IEN,LIM,FLDNM,FLD) ; Add LIM number of lines of multiple...
 N MIEN,NO
 S NO=0,MIEN=0,LIM=$S($G(LIM):LIM,1:10)
 F  S MIEN=$O(@GBL@(MIEN)) Q:MIEN'>0!(NO>LIM)  D
 .  S DATA=$G(@GBL@(MIEN,0)) QUIT:$TR(DATA," ","")']""  ;->
 .  S NO=NO+1
 .  S ^UTILITY("DIQ1",$J,FILE,IEN,FLD,"E",NO)=DATA
 Q
 ;
DICDR(FILE) ; Return fields for display by EN^DIQ1...
 I FILE=772 QUIT ".01:199" ;->
 I FILE=773 QUIT ".01:999" ;->
 I FILE=776 QUIT ".01:20" ;->
 I FILE=776.1 QUIT ".01:20" ;->
 I FILE=776.2 QUIT ".01:20" ;->
 I FILE=776.3 QUIT ".01:20" ;->
 I FILE=776.4 QUIT ".01:20" ;->
 I FILE=776.999 QUIT ".01:20" ;->
 I FILE=870 QUIT ".01:18;21;100:499" ;->
 QUIT ""
 ;
LAST D LASTIEN^HLEVUTI3 Q
LASTIEN D LASTIEN^HLEVUTI3 Q
LAST772 D LASTIEN^HLEVUTI3 Q
LAST773 D LASTIEN^HLEVUTI3 Q
 ;
EOR ;HLEVUTIL - Event Monitor UTILITIES ;5/16/03 14:42
