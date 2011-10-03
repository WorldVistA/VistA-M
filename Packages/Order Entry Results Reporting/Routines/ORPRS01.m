ORPRS01 ; slc/dcm - Hot'n Summary Report utilities ;6/10/97  15:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11**;Dec 17, 1997
P ; Get Patient(s)
 N %X,%Y,C,DIC,DFN,I,ORATTEND,Y
 K ORSCPAT,^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW"),^("ORLP")
 S ORSHORT=$$SHORT^ORPRS02
 D PATIENT^ORU1(.ORSCPAT,,1)
 I $S($D(DIROUT):1,$D(DUOUT):1,1:0) S (OREND,XQORPOP)=1
 Q
DAY(DAY) ; Get a date for 24 hr printing
 ;DAY=Optional date for default date prompt
 ;Returns: ORSSTRT=Internal Start date/time_"^"_Formatted Start date/time
 ;         ORSSTOP=Internal Stop date/time_"^"_Formatted Stop date/time
 ;         OREND,XQORPOP=1 if user ^'s or times out
 ;         DIROUT=1 if user ^^'s out
 N %,%DT,%I,%T,%H,ORSDFLT,X,Y
D1 ;
 S OREND=0,ORSDFLT=$S($G(DAY):$S($P(DAY,".",2)=2359:DAY+.7641,1:DAY),1:"T")
 W !!,"Order Entry Date: "_$S(+ORSDFLT>0:$$DATE^ORU(ORSDFLT,"AMTH DD, CCYY"),1:"T")_"// "
 R X:$S($D(DTIME):DTIME,1:300)
 I $S(X="^":1,X="^^":1,'$T:1,1:0) S (OREND,XQORPOP)=1 S:X="^^" DIROUT=1 Q
 S:X="" X=ORSDFLT
 S %DT="EX"
 D ^%DT
 I X["?" K DAY G D1
 I Y<1 W $C(7),?40,"Invalid Date." K DAY G D1
 S ORSSTRT=Y-.7641_"^"_$$FMTE^XLFDT(Y-.7641),ORSSTOP=Y+.2359_"^"_$$FMTE^XLFDT(Y+.2359)
 Q
RANGE(X1,X2) ; Get a date range for printing
 ;X1=Default Start Date/time
 ;X2=Default Stop Date/time
 N %DT,%T,ORSDFLT,X,Y
 I $D(ORPRES),+ORPRES=6!(+ORPRES=15)!(+ORPRES=16)!(+ORPRES=17) S (ORSSTRT,ORSSTOP)="" Q
R ;
 S OREND=0,ORSDFLT=$S($G(X1)>0:$S($P(X1,".",2)=2359:X1+.7641,1:X1),1:"T")
 W !!,"Start Date [Time]: "_$S(ORSDFLT>0:$$DATE^ORU(ORSDFLT,"AMTH DD, CCYY"),1:ORSDFLT)_"// "
 R X:$S($D(DTIME):DTIME,1:300)
 S:X="^"!('$T) (OREND,XQORPOP)=1
 Q:OREND
 S:X="" X=ORSDFLT
 S %DT="EXT"
 D ^%DT
 G R:X["?"
 I Y<1 W ?55,"Invalid Start Date/time." G R
 S ORSSTRT=Y
E ; Get Ending Date/time
 S ORSDFLT=$S($G(X2):$S($P(X2,".",2)'=2359:$P(X2,".")_".2359",1:X2),$G(ORSSTRT):$S($P(ORSSTRT,".",2)=2359:(ORSSTRT+.7641)_".2359",1:$P(ORSSTRT,".")_".2359"),1:"T@2359")
 W !!,"Ending Date [Time] (inclusive): "_$S(+ORSDFLT>0:$$DATE^ORU(ORSDFLT,"AMTH DD, CCYY HR:MIN"),1:ORSDFLT)_"// "
 R X:$S($D(DTIME):DTIME,1:300)
 S:X="^"!('$T) (OREND,XQORPOP)=1
 Q:OREND
 S:X="" X=ORSDFLT
 S %DT="EXT"
 D ^%DT
 G E:X["?"
 I Y<1 W ?57,"Invalid End Date/time." G E
 S ORSSTOP=Y
 I ORSSTOP<ORSSTRT S X=ORSSTOP,ORSSTOP=ORSSTRT,ORSSTRT=X
 S ORSSTOP=$S($L(ORSSTOP,".")=2:ORSSTOP,1:ORSSTOP+1)_"^"_$$FMTE^XLFDT(ORSSTOP)
 S ORSSTRT=$S($L(ORSSTRT,".")=2:ORSSTRT,1:ORSSTRT-.7641)_"^"_$$FMTE^XLFDT(ORSSTRT)
 Q
CUSTOM ; Selects order status and display group
 N %,%Y,C,DIC,I,X,Y,XQORM,XQORSPEW,XQORNOD
 S ORBUF=1
 I $D(DIROUT)!($D(DTOUT)) S (OREND,XQORPOP)=1 Q
 S:'$D(ORPRES) ORPRES="2;ACTIVE ORDERS"
 D PRES^ORPRS09
 I $G(OREND) S XQORPOP=1 Q
 D SERV^ORPRS09
 I $G(OREND) S XQORPOP=1 Q
 Q
HSTS(X) ;Help for status descriptions (ORRP STATUS MENU protocol)
 W !,"Valid selections are: "
 I X["???" W ! D HACT1 W ! Q  ;show descriptions and quit
 D DISP^XQORM1
 W !
 Q
HACT1 ;
 K ^TMP("ORRX",$J)
 S Y=0 F I=0:0 S Y=$O(^ORD(101,+XQORNOD,10,Y)) Q:Y'>0  I $D(^ORD(101,+XQORNOD,10,Y,0)) S W=^(0),^TMP("ORRX",$J,$P(W,"^",3))=W
 S Y=0 F I=1:1 S Y=$O(^TMP("ORRX",$J,Y)) Q:Y'>0  S X1=^(Y),W=+X1 D:I=20 READ^ORUTL W !,$P(X1,"^",2),?5 I W,$D(^ORD(101,W,0)) W $P(^(0),"^",2) I $P(^(0),"^",2)'="   ",$D(^ORD(101,W,1,1,0)) W " - "_^(0)
 K W,X,^TMP("ORRX")
 Q
EN(ORDG,ORSEL) ;Setup/Display groups
 ;ORDG(optional)=ptr to display group to setup (All is the default)
 ;ORSEL(optional)=Line label of action to take (BILD<default>, DISP)
 ;Returns: ORGRP if ORSEL="BILD"
 I $G(ORSEL)'="DISP" S ORSEL="BILD"
 I '$G(ORDG) S ORDG=1 ;All if not specified
 N ORMEM,ORSTK
 S ORSTK=0
 D @ORSEL
 S ORSTK=1,ORSTK(ORSTK)=ORDG_"^0",ORSTK(0)=0,ORMEM=0
 F I=0:0 S ORMEM=$O(^ORD(100.98,+ORSTK(ORSTK),1,ORMEM)) D @$S(+ORMEM'>0:"POP",1:"PROC") Q:ORSTK<1
 Q
POP ;
 S ORSTK=ORSTK-1,ORMEM=$P(ORSTK(ORSTK),"^",2)
 Q
PROC ;
 S $P(ORSTK(ORSTK),"^",2)=ORMEM,ORDG=$P(^ORD(100.98,+ORSTK(ORSTK),1,ORMEM,0),"^",1)
 D @ORSEL
 S ORSTK=ORSTK+1,ORSTK(ORSTK)=ORDG_"^0",ORMEM=0
 Q
DISP ;
 I $Y>(IOSL-4) D READ^ORUTL W @IOF
 S W=^ORD(100.98,ORDG,0)
 W !,?((ORSTK*2)),$P(W,"^")
 Q
BILD ;
 S ORGRP(ORDG)=""
 Q
STOP ; Call DIR at bottom of screen
 N DIR,X,Y
 Q:$E(IOST)'="C"
 I IOSL>($Y+5) F  W ! Q:IOSL<($Y+6)
 S DIR(0)="FO^1:1",DIR("A")="Press RETURN to continue or '^' to exit"
 S DIR("?")="Enter '^' to quit present report or '^^' to quit to menu"
 D ^DIR
 Q
TERM(IOST) ;Setup terminal display values
 ;IOST=Terminal type
 ;Returns ORTERM(5)=REVERSE VIDEO ON^REVERSE VIDEO OFF
 ;        ORTERM(7)=HIGH INTENSITY^LOW INTENSITY^NORMAL INTENSITY
 S (ORTERM(7),ORTERM(5))=""
 I $D(IOST),$L(IOST) S X=$O(^%ZIS(2,"B",IOST,0)) I X,$D(^%ZIS(2,X)) S ORTERM(5)=$S($D(^(X,5)):$P(^(5),"^",4,5),1:""),ORTERM(7)=$S($D(^(7)):$P(^(7),"^",1,3),1:"") S:'$L($P(ORTERM(7),"^",3)) $P(ORTERM(7),"^",3)=$P(ORTERM(7),"^",2)
 F I=1:2:3 I '$L($P(ORTERM(7),"^",I)) S ORTERM(7)="" Q
 Q
