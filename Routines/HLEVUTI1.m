HLEVUTI1 ;OIFO-O/LJA - Event Monitor UTILITIES ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;;
 ;
 ; Utility to aid in displaying 870 data...
 ;
CTRL ;
 N ABRT,CT,CONT,DATA,DATE,DIC,GBL,HD,IOINHI,IOINORM,L870,LAST
 N LNM,LNO,LNS,N,NO,NODE,TOT,TXT,WAY,WHAT,X,Y
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
CTRL0 W @IOF,$$CJ^XLFSTR("Logical Link Display",IOM),!,$$REPEAT^XLFSTR("=",IOM)
 D QUEUES
 W ! S L870=$$LINK Q:'L870
 S GBL="^HLCS(870,"_L870_")"
 S LNM=$$LNM(L870)
 W "       ",LNM
CTRL1 D SHOWHD(LNM,L870)
 W !!,"What information for IN and OUT QUEUEs do you want to see?"
 W !!,"1  Show IENs",!,"2  Show Summary nodes",!,"3  Totals",!,"4  Dots",!,"5  Find skips",!,"6  Message date search"
 R !!,"Enter #: ",WHAT:99 G:WHAT<1!(WHAT>6) CTRL0 ;->
 W !!,$$CJ^XLFSTR(" "_IOINHI_LNM_IOINORM_" ",IOM+$L(IOINHI)+$L(IOINORM),"=")
 S ABRT=0,CONT=0,CT=0
 S WAY=$$ASKWAY QUIT:WAY[U  ;->
 S NO=$$ASKNO(LNM,L870,WAY) QUIT:NO[U  ;->
 I WHAT=6 D SEARCH(L870,WAY,NO) G CTRL1 ;->
 S TOT(WAY)=0,LAST=""
 QUIT:$O(@GBL@(WAY,0))'>0  ;->
 W !,$$CJ^XLFSTR(" "_$S(WAY=1:"IN",1:"OUT")_" QUEUE ",IOM,"-")
 I WHAT=3 W !,"Totaling..."
 F  S NO=$O(@GBL@(WAY,NO)) Q:'NO!ABRT  D
 .  S CT=CT+1
 .  S NODE=$G(@GBL@(WAY,NO,0)),DATE=$P($G(@GBL@(WAY,NO,1,0)),U,5)
 .  S TXT=$G(@GBL@(WAY,NO,1,1,0))
 .  S TXT=$E(DATE_"            ",1,10)_$E(NODE_"            ",1,12)_"  "_$E(TXT,1,56)
 .  I WHAT=1 W:($X+$L(NO)+1)>IOM ! W:$X>0 "," W NO
 .  I WHAT=2 D
 .  .  W !,TXT
 .  I WHAT=3 W:'(CT#5000) "." S TOT(WAY)=TOT(WAY)+1
 .  I WHAT=4 Q:$$CT  W "."
 .  I WHAT=5 D
 .  .  I LAST,+LAST'=(NO-1) D
 .  .  .  W !,+LAST,?10," ",$E($P(LAST,"~",2,999),1,IOM-$X)
 .  .  .  W !,+NO,?10," ",$E(TXT,1,69)
 .  .  S LAST=NO_"~"_TXT
 .  I 'CONT,'(CT#20) R X:999 S:X[U ABRT=1 S:X=" " CONT=1
 I 'ABRT,TOT(WAY) W !,"--- Total = #",TOT(WAY)
 S ABRT="",CT=0
 ;
 R !,"End of output... ",X:999
 ;
 W !!,$$CJ^XLFSTR(" "_LNM_" ",IOM,"=")
 ;
 G CTRL1 ;->
 ;
SHOWHD(LNM,L870) ; Show summary information...
 N NODE
 W !!,$$REPEAT^XLFSTR("=",IOM)
 F NODE=0,100,200,300,400,"IN QUEUE BACK POINTER","IN QUEUE FRONT POINTER","OUT QUEUE BACK POINTER","OUT QUEUE FRONT POINTER" D
 .  S DATA=$G(@GBL@(NODE)) Q:DATA']""  ;->
 .  D PHD(NODE,DATA)
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
CT() QUIT:(CT#500) ""
 R X:999 Q:X']"" ""
 S ABRT=1
 Q 1
 ;
PHD(HD,DATA) ;
 S HD=$$HD(HD)
 S HD=$E("    ",1,4-$L(HD))_HD
 W !,HD,"="
 F  D  QUIT:DATA']""
 .  QUIT:DATA']""
 .  W $E(DATA,1,76)
 .  S DATA=$E(DATA,77,999)
 .  W:DATA]"" !,?4
 Q
 ;
HD(HD) ;
 I HD["IN QUEUE F" S HD="IQFP"
 I HD["IN QUEUE B" S HD="IQBP"
 I HD["OUT QUEUE F" S HD="OQFP"
 I HD["OUT QUEUE B" S HD="OQBP"
 Q HD
 ;
LINK() N DIC,X,Y
 S DIC=870,DIC(0)="AEMQN",DIC("A")="Select LINK: "
 D ^DIC
 QUIT $S(+Y:+Y,1:"")
 ;
QUEUES N LNM,LNO
 KILL ^TMP($J,"ZZLJA")
 S LNM=""
 F  S LNM=$O(^HLCS(870,"B",LNM)) Q:LNM']""  D
 .  S LNO=0
 .  F  S LNO=$O(^HLCS(870,"B",LNM,LNO)) Q:'LNO  D
 .  .  S LNS=$$LNM(LNO)
 .  .  I $O(^HLCS(870,+LNO,1,0))>0 D
 .  .  .  S ^TMP($J,"ZZLJA",LNS,1)=$P($G(^HLCS(870,+LNO,1,0)),U,3)
 .  .  I $O(^HLCS(870,+LNO,2,0))>0 D
 .  .  .  S ^TMP($J,"ZZLJA",LNS,2)=$P($G(^HLCS(870,+LNO,2,0)),U,3)
 ;
 W !!,"Links with queues"
 W !,"Link",?30,"IQ Totals",?45,"OQ Totals"
 W !,$$REPEAT^XLFSTR("-",IOM)
 ;
 S LNS=""
 F  S LNS=$O(^TMP($J,"ZZLJA",LNS)) Q:LNS']""  D
 .  W !
 .  W:LNS["Mail]" IOINHI W $E(LNS_" --------------------",1,20),IOINORM
 .  F WAY=1,2 D
 .  .  S TOT=$G(^TMP($J,"ZZLJA",LNS,WAY))
 .  .  S TOT=$E("---------------",1,15-$L(TOT))_TOT
 .  .  W TOT
 ;
 KILL ^TMP($J,"ZZLJA")
 ;
 Q
 ;
LNM(L870) N GBL,X
 S GBL="^HLCS(870,"_L870_")",X=$G(@GBL@(0))
 Q $P(X,U)_" #"_L870_" ["_$P("Mail^HLLP^X3.28^TCP",U,+$P(X,U,3))_"] "
 ;
ASKNO(LNM,L870,WAY) ; Ask for beginning IEN to display...
 N DIR,DIRUT,DTOUT,DUOUT,FIRST,LAST,X,Y
 S FIRST=$O(^HLCS(870,+L870,WAY,0))
 S LAST=$O(^HLCS(870,+L870,WAY,":"),-1)
 W !!,"First IEN = ",FIRST
 W !," Last IEN = ",LAST
 W !
 S DIR(0)="N^"_FIRST_":"_LAST,DIR("A")="Enter IEN"
 I FIRST S DIR("B")=FIRST
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) U ;->
 QUIT:+Y>0 (+Y-1) ;->  Will be used for $ORDER
 Q 0
 ;
ASKWAY() ; In or Out...
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^1:Inbound Queue;2:Outbound Queue"
 S DIR("A")="Select QUEUE"
 D ^DIR
 QUIT:+Y>0&(+Y<3) $P("1^2",U,+Y)
 Q U
 ;
SEARCH(L870,WAY,NO,SKIP) ; Search for a date...
 ; LNM -- req
 N ABRT,CONT,CT,NUM
 I '$D(SKIP) N SKIP
S1 S SKIP=$S($G(SKIP):+SKIP,1:5000),ABRT=0,CT=0,CONT=0
 S NUM=NO-1,NUM=$O(^HLCS(870,+L870,WAY,NUM))
 W !!
 D SRCH1(L870,WAY,+NUM)
 F  D  QUIT:NUM'>0!(ABRT)
 .  S NUM=NUM+SKIP
 .  S NUM=$O(^HLCS(870,+L870,WAY,NUM)) QUIT:NUM'>0  ;->
 .  D SRCH1(L870,WAY,+NUM)
 W !,"Just completed a search using a starting point of IEN=",NO,", and an offset"
 W !,"of #",SKIP,".  You may now enter a new starting IEN and offset."
 W !
 S NO=$$ASKNO(LNM,L870,WAY) QUIT:NO[U  ;->
 R !,"Enter OFFSET: ",OFFSET:90 I OFFSET>0 S SKIP=OFFSET G S1 ;->
 Q
 ;
SRCH1(L870,WAY,IEN) ; Show date of entry...
 N MSH,DATE,DEL
 S MSH=$G(^HLCS(870,+L870,WAY,IEN,1,1,0))
 S DEL=$E(MSH,4),DATE=$P(MSH,DEL,7)
 S DATE=$S(DATE?14N.1"-".N:$$HTFM^XLFDT(DATE),1:"")
 S DATE=$S(DATE?7N.E:DATE,1:$P($G(^HLCS(870,+L870,WAY,IEN,1,0)),U,5))
 QUIT:DATE'?7N.E  ;->
 W $J($$SDT(DATE)_"(#"_IEN_")",18)_"  "
 S CT=CT+1
 I 'CONT,'(CT#80) R X:999 S:X[U ABRT=1 S:X=" " CONT=1
 Q
 ;
SDT(DATE) ; Return shortened form of date...
 I DATE?7N QUIT $E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3) ;->
 I DATE?7N1"."1.N QUIT $E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)_"@"_$E($P($$FMTE^XLFDT(DATE),"@",2),1,5)
 QUIT ""
 ;
TEST ; Hardwire IENs and test M code in monitor (only)...
 N IEN,MCODE,STATE,WAY
 ;
 W @IOF,$$CJ^XLFSTR("Monitor Test Utility",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !,"This utility sets the ^TMP(""HLEVFLAG"",$J) node to ""STOP"" to avoid any"
 W !,"Event Monitor activity.  This enables the debugging of M code."
 ;
 S STATE=$G(^TMP("HLEVFLAG",$J))
 ;
 F  D  QUIT:'IEN
 .  W !
 .  S IEN=$$ASKIEN^HLEVREP(776.1) QUIT:'IEN  ;->
 .
 .  S MCODE=$TR($P($G(^HLEV(776.1,+IEN,0)),U,6),"~",U)
 .  I MCODE']"" W "   no M code found..." QUIT  ;->
 .  W !!,"M code = ",MCODE
 .
 .  W !!,"You may ZG ",MCODE," or D ",MCODE,"..."
 .  W !
 .  S WAY=$$YN^HLCSRPT4("DO the MCODE","Yes")
 .  S WAY=$S(WAY=1:1,1:2) ; 1=DO, 2=ZG
 .
 .  W !
 .  I '$$YN^HLCSRPT4("OK to test now","Yes") D  QUIT  ;->
 .  .  W "   no action taken..."
 .
 .  S ^TMP("HLEVFLAG",$J)="STOP"
 .
 .  D TESTRUN
 .
 .  KILL ^TMP("HLEVFLAG",$J)
 .  W !!,$$REPEAT^XLFSTR("-",IOM)
 ;
 I STATE]"" S ^TMP("HLEVFLAG",$J)=STATE
 ;
 Q
 ;
TESTRUN ; Call here from above to avoid LEVEL ERRORs with ZGo...
 ; MCODE,WAY -- req
 I WAY=1 D
 .  W "  DOing ",MCODE,"... "
 .  D @MCODE
 I WAY=2 D
 .  W "  ZGOing ",MCODE,"... "
 .  X "ZG "_@MCODE
 Q
 ;
COLLECT(I772) ; Collect 772 & 773 data...
 N CT,I773
 D ADD(""),ADD($$CJ^XLFSTR(" 772# "_I772_" ",74,"-"))
 S I773=0,CT=0
 F  S I773=$O(^TMP($J,"HLIEN",IEN,I773)) Q:'I773  D
 .  I CT>0 D ADD("")
 .  D COLL773(+I773)
 .  S CT=CT+1
 D ADD($$CJ^XLFSTR("----------------------------------------",74))
 D COLL772(+I772)
 Q
 ;
COLL773(I773) ;
 N LP,ST
 S LP="^HLMA("_I773,ST=LP_",",LP=LP_")"
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  D ADD(LP_"="_@LP)
 Q
 ;
COLL772(I772) ;
 N CT,LASTIN,LP,ST
 S LP="^HL(772,"_I772,ST=LP_",",LP=LP_")",CT=0,LASTIN=""
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  I $TR(LP,"""","")?1"^HL(772,"1.N1",IN,"1.N.E D  QUIT:CT>5  ;->
 .  .  S CT=CT+1
 .  .  I CT=7 D ADD("... some data not shown ...")
 .  .  S LASTIN=LP
 .  D ADD(LP_"="_@LP)
 I LASTIN]"",CT>6 D ADD(LASTIN_"="_@LASTIN)
 Q
 ;
ADD(TXT) ; Add text for report...
 ; SCRN -- req
 N NO,POSX
 S POSX=$L($P(TXT,"="))+1
 F  D  QUIT:TXT']""
 .  I 'SCRN D  ; Store for email message...
 .  .  S NO=$O(^TMP($J,"HLMAIL",":"),-1)+1
 .  .  S ^TMP($J,"HLMAIL",+NO)=$E(TXT,1,74)
 .  I SCRN W !,$E(TXT,1,74) ; Display on-screen
 .  S TXT=$E(TXT,75,999) QUIT:TXT']""  ;->
 .  S TXT=$$REPEAT^XLFSTR(" ",$S(POSX:POSX,1:5))_TXT
 Q
 ;
DOLRO(TAG,SNO) ; Store debug data in ^XTMP("HLEVUTI1 "_DT,NO)...
 N NO,X,XTMP
 ;
 S XTMP="HLEVUTI1 "_TAG_"-"_DT
 S:'$D(^XTMP(XTMP,0)) ^XTMP(XTMP,0)=$$FMADD^XLFDT(DT,1)_U_$$NOW^XLFDT_"^Debug data created by DOLRO~HLEVUTI1"
 ;
 S NO=$O(^XTMP(XTMP,":"),-1)+1,NO=$S(NO>($G(SNO)-1):NO,1:SNO)
 ;
 S X="^XTMP("""_XTMP_""","_NO_"," D DOLRO^%ZOSV
 ;
 Q
 ;
EOR ;HLEVUTI1 - Event Monitor UTILITIES ;5/16/03 14:42
