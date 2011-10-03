OREOR0 ; slc/dcm - Check things ;7/23/97  12:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
EN ;Check for mutliple keys
 W !,"This utility identifies users that have more than one OR key assigned."
 W !,"Users with more than one key can encounter problems when adding orders."
 W !,"Any users listed will need to have their Keys edited and correctly assigned.",!
 W !,"Ok to continue" S %=1 D YN^DICN G:%=0 EN Q:%'=1
 N IFN,X,KEY1,KEY2,KEY3,USER
 S IFN=0 F  S IFN=$O(^VA(200,IFN)) Q:IFN<.1  S USER=$P(^(IFN,0),"^"),(KEY1,KEY2,KEY3)=0 D
 . I $D(^XUSEC("ORES",IFN)) S KEY1=1
 . I $D(^XUSEC("ORELSE",IFN)) S KEY2=1
 . I $D(^XUSEC("OREMAS",IFN)) S KEY3=1
 . S X=KEY1+KEY2+KEY3 I X>1 W !,USER_" ("_IFN_") has more than 1 OR key: ",?60 W:KEY1 "ORES " W:KEY2 "ORELSE " W:KEY3 "OREMAS"
 Q
ER ;Error check utility
 N VAR,VAL,ERDT,ERTXT,IFN,VI,FIRST,EVAL,LISTVAR
 W !!,"This utility will look for errors that happened with a certain variable set."
 W !,"You can even specify a specific value to look for.",!
 W !,"Variable: " R X:DTIME Q:'$L(X)  S VAR=X
 W !,"Value (optional- enter 'NULL' to look for """"): " R X:DTIME I $L(X) S:X="NULL" X="" S VAL=X
 W !,"List variables: " S %=2 D YN^DICN S LISTVAR=$S(%=1:1,1:0)
DATE ;
 W ! S %DT="AEX",%DT("A")="ERROR DATE: " D ^%DT Q:$D(DTOUT)  Q:X["^"  G:Y<1 ER
 S X=Y D H^%DTC S ERDT=%H
 I '$D(^%ZTER(1,+ERDT)) W !,"No errors on that date",! G DATE
 S IFN=0 F  S IFN=$O(^%ZTER(1,+ERDT,1,IFN)) Q:IFN<1  S ERTXT=$E($G(^(IFN,"ZE")),1,70),FIRST=1 D
 . S VI=0 F  S VI=$O(^%ZTER(1,+ERDT,1,IFN,"ZV",VI)) Q:VI<1  S X=^(VI,0),EVAL=$G(^("D")) I $E(X,1,$L(VAR))[VAR D
 .. I $G(VAL) Q:VAL'=$P(EVAL,"^")
 .. I FIRST S FIRST=0 W !!,IFN_". "_ERTXT
 .. I LISTVAR W !?3,X,?15,EVAL
 G DATE
 Q
ORYX ;Find things in the OE/RR Error file
 N OREND
 W !!?10,"ORYX('ORERR' file search"
 I '$O(^ORYX("ORERR",0)) W !!,"No errors in the file." Q
 F  D YX Q:OREND
 Q
YX ;
 N ORSSTRT,ORSSTOP,I,X,Y,Z,GOT,YES
 D RANGE^ORPRS01()
 Q:OREND
 W !!,"Enter text to search for (case sensitive & optional): "
 R X:DTIME Q:'$T
 S GOT=0,YES=0,%=1
 I X'="" W !,"Show details" D YN^DICN Q:%=-1  S:%'=2 YES=1
 S I=0 W "  searching..."
 F  S I=$O(^ORYX("ORERR",I)) Q:I<1  S Y=^(I,0),GOT=0 D
 . I +Y<ORSSTRT!(+Y>ORSSTOP) Q
 . I X="" W !,I_"=>"_Y Q
 . I Y[X S GOT=1
 . I 'GOT S J=0 F  S J=$O(^ORYX("ORERR",I,1,J)) Q:J<1  S Z=^(J,0) I Z[X S GOT=1 Q
 . I GOT D VIEW(I,YES) ;W !,I_"=>"_Y Q:'YES  S J=0 F  S J=$O(^ORYX("ORERR",I,1,J)) Q:J<1  W !?12,^(J,0)
V1 I 'YES W !!,"View #: " R X:DTIME I X,$D(^ORYX("ORERR",X)) D VIEW(X,1) G V1
 Q
VIEW(I,DETAIL) ;View log
 N J,Y
 Q:'$D(^ORYX("ORERR",+$G(I),0))  S Y=^(0)
 W !,I_"=>"_Y Q:'$G(DETAIL)  S J=0 F  S J=$O(^ORYX("ORERR",I,1,J)) Q:J<1  W !?12,^(J,0)
 Q
