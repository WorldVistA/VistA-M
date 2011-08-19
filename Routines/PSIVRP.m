PSIVRP ;BIR/MLM-REPRINT IV LABELS FROM WARD OR MANUFACTURING LIST ;12 JUL 96 / 10:45 AM
 ;;5.0; INPATIENT MEDICATIONS ;**38,58**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PS(52.6 is supported by DBIA 1231
 ; Reference to ^PS(52.7 is supported by DBIA 2173
 ; Reference to ^DIC(42 is supported by DBIA# 10039
 ;        
 D ^PSIVXU Q:$D(XQUIT)  I '$D(^PS(55,"PSIVWL",PSIVSN)) W $C(7),!!,"THIS OPTION MAY BE USED ONLY AFTER THE WARD LIST HAS BEEN RUN",!! G QUIT^PSIVRP1
 K DIR S DIR(0)="DOA^NE",DIR("A")="Reprint labels for DATE: ",DIR("B")="TODAY",DIR("??")="^S HELP=""REPRINT"" D ^PSIVHLP2" D ^DIR K DIR G:Y<1 QUIT^PSIVRP1 K PS D GTMES^PSIVRP1
 I '$D(PS) W $C(7),!!,"The Ward list & Scheduled Labels options MUST be run for the chosen date",!,"before you may use this option!!",!! K DIR S DIR(0)="E" D ^DIR K DIR G QUIT^PSIVRP1
SELMAN ;
 K PSM S PSCT=0 F I=0:0 S I=$O(^PS(59.5,PSIVSN,2,I)) Q:'I  S PSIVDTS=^(I,0),PSIVDT=Y_"."_$P(PSIVDTS,"^")/1,PSIVDT=$P(PSIVDTS,"^",2)_PSIVDT S:$D(PS(PSIVDT)) PSM(I)=PSIVDTS,PS(I)=PSIVDT,PSCT=PSCT+1
 W !!,?5,"The manufacturing times which scheduled labels have been run for are: " D P0^PSIVWL1 G:'X QUIT^PSIVRP1 K PSR F J=1:1:$L(X,",") S Y=$P(X,",",J) S:$D(PS(+Y)) PSR(PS(Y))=""
FNDLBLS ;
 K PS,DIC S J="LAST",DIC=55,DIC("A")="Select PATIENT on LAST usable label: ",DIC(0)="AEMQ" D GTRANGE G:Y<0 QUIT^PSIVRP1 F X=1:1:$S(LIST="M":7,1:6) S LAST($P(STR,"^",X))=@$P(STR,"^",X)
 S J="NEXT",DIC("A")="Select PATIENT on NEXT usable label or RETURN to print to end: " D GTRANGE K DIC G:X="^" QUIT^PSIVRP1 S:'DFN LIST=LAST("LIST") F X=1:1:$S(LIST="M":7,1:6) S NEXT($P(STR,"^",X))=@$P(STR,"^",X)
 G:NEXT("DFN")="" SKIP F X=2:1:$L(STR,"^") Q:NEXT($P(STR,"^",X))'=LAST($P(STR,"^",X))
 I NEXT($P(STR,"^",X))']LAST($P(STR,"^",X)) W $C(7),!!,"NEXT LABEL MUST FOLLOW LAST LABEL",!! G FNDLBLS
SKIP ;
 I PSIVPL=ION D DEQ^PSIVRP1 G QUIT^PSIVRP1
QUE ;
 K ZTDTH,ZTSAVE S ZTIO=PSIVPL,ZTRTN="DEQ^PSIVRP1",ZTDESC="Reprint I.V. Labels" F X="LAST(","NEXT(","PSR(","PSIVSN","PSIVSITE","PSJSYSW0","PSJSYSU","PSJSYSP0","STR" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"Queued." D QUIT^PSIVRP1
 Q
GTRANGE ;
 K NEXT S (LIST,PSIVDT,PSIVT,X1,X2,DFN,ON,WRD)=""
 ;* D ^DIC Q:'$T!(Y<0)  S DFN=+Y D ENIV^PSJAC D GTORDR S (PRO,ON)="" I '$D(PS) W $C(7),!!,VADM(1)," has no IV orders on the Ward List for the date &",!,"manufacturing times chosen",! G GTRANGE
 D ^DIC Q:(Y<0)  S DFN=+Y D ENIV^PSJAC D GTORDR S (PRO,ON)="" I '$D(PS) W $C(7),!!,VADM(1)," has no IV orders on the Ward List for the date &",!,"manufacturing times chosen",! G GTRANGE
ORDER ;
 S:'PRO ON="" S P="Select order number of the "_J_" usable label: " W !!,$E(P,1,44),$S(ON:" or RETURN to continue: ",1:": ") R X:DTIME
 G:'$T!(X="^") GTRANGE G:$D(PS("A",+X)) ORDER1 I ON,(X="") D PRO G ORDER
 I 'PRO,(X["??") D PRO G ORDER
 G:X="" GTRANGE W $C(7),!!,"Enter the ",$E(P,8,44)," for ",VADM(1),",",! W:'PRO """??"" to see a profile of all orders on the ward list for this patient,",! W " or ""^"" to exit",!! G ORDER
ORDER1 ;
 W !! S ON=+X,Y=^PS(55,DFN,"IV",ON,0),PSIVT=$S($P(Y,"^",4)'="":$P(Y,"^",4),1:0),PSIVDT=$O(PSR(PSIVT)),WRD=$S($D(^DIC(42,+$P(Y,"^",22),0)):$P(^(0),"^",1),1:"Outpatient IV")
 S LIST=$S($D(^PS(55,"PSIVWLM",PSIVSN,PSIVDT)):"M",1:"W")
 S STR=$S(LIST="M":"LIST^PSIVT^PSIVDT^X1^X2^DFN^ON",1:"LIST^PSIVT^WRD^PSIVDT^DFN^ON") Q:LIST="W"  S FILE="AD",X1=0 D BU S X1=X,FILE="SOL",X2=0 D BU S X2=X G:X1=0!(X2=0) QUIT^PSIVRP1 I PSIVT="A" S XT=X1,X1=X2,X2=XT
 Q
BU ;
 S D1=0,D1=$O(^PS(55,DFN,"IV",ON,FILE,D1))
 I $D(^PS(55,DFN,"IV",ON,FILE,+D1,0)) S PSIVDRG=$P(^(0),"^",1,2),NF=$S(FILE="AD":"zz6",1:"zz7"),X=$S($D(^PS("52."_$E(NF,3),+PSIVDRG,0)):$E($P(^(0),"^",1),1,10),1:NF) S X=X_"^"_$P(PSIVDRG,"^",2)_"^"_$E(NF,3)_";"_+PSIVDRG
 Q
GTORDR ;
 K PS S WRD="" F X=0:0 S WRD=$O(^PS(55,"PSIVWL",PSIVSN,WRD)) Q:WRD=""  S PSIVDT="" F X=0:0 S PSIVDT=$O(PSR(PSIVDT)) Q:PSIVDT=""  F ON=0:0 S ON=$O(^PS(55,"PSIVWL",PSIVSN,WRD,PSIVDT,DFN,ON)) Q:ON=""  S PS("A",ON)=""
 Q
PRO ;
 ;N PG S (PG,PSJLN,PRO)=1,PSIVST="A" D HDL^PSIVPRO F X1=1:1 S ON=$O(PS("A",ON)) Q:ON=""!($Y+5>IOSL)  S ON55=ON D GT55^PSIVORFB S ON=9999999999-ON,PSIVX1=ON55 D ENPL^PSIVPRO S ON=9999999999-ON
 D HDR^PSJLMHED(DFN)
 N PG,PSIVX2 S PSIVX2=0,(PG,PSJLN,PRO)=1,PSIVST="A"
 D HDL^PSIVPRO F X1=1:1 S ON=$O(PS("A",ON)) Q:ON=""  S ON55=ON D GT55^PSIVORFB S ON=9999999999-ON,PSIVX1=ON55 D ENPL^PSIVPRO S ON=9999999999-ON
 NEW XX F XX=0:0 S XX=$O(^TMP("PSJPRO",$J,XX)) Q:'XX  W !,^(XX,0)
 S:'ON PRO=""
 K ^TMP("PSJPRO",$J)
 Q
SETP ;
 S Y=^PS(55,DFN,"IV",ON,0) F X=1:1:23 S P(X)=$P(Y,"^",X)
 Q
