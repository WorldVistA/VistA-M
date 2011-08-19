GMRYINFS ;HIRMFO/YH-ADJUST INFUSION RATE ;4/5/94
 ;;4.0;Intake/Output;;Apr 25, 1997
INFUSE ;
 W @IOF,!!,"*** ADJUST INFUSION RATE ***",!
 S DA=DFN,(GMRDC,GMROUT)=0 D LISTIV^GMRYUT0 D SEL^GMRYED4 G:GMROUT!($G(GMRZ(1))="") Q
 S GDATA=^GMR(126,DA(1),"IV",DA,0),GDT=$P(GDATA,"^"),GTYPE=$P(GDATA,"^",4)
 W !!,?5,$P(GDATA,"^",3)_"  "_$S(GTYPE'["L":$P(GDATA,"^",5)_" mls ("_GTYPE_") ",1:"")_$P(GDATA,"^",2) S Y=GDT X ^DD("DD") W "  started on "_$P(Y,":",1,2),! S GSITE=$P(GDATA,"^",2)
DT S %DT("A")="Please enter Date/Time: ",%DT="AETXRS",%DT("B")="NOW" D ^%DT I Y'>0 S GMROUT=1 G Q
 I $P(GDATA,"^")>Y W !,"The Date/Time has to be after the IV started",! G DT
 S GMRVDT=+Y D NOW^%DTC I GMRVDT>+% W !!,"NO FUTURE DATE/TIME!!!",! G DT
 S GMROUT(1)=0,GMROUT(1)=$$ADM^GMRYUT12(.GMROUT,DFN,GMRVDT) Q:GMROUT
 K GDA S (GDT,GDA)=0 I $D(^GMR(126,DA(1),"IV",DA,"TITR","C")) S GDT=$O(^GMR(126,DA(1),"IV",DA,"TITR","C",0)) D:GDT>0
 .S GDA=$O(^GMR(126,DA(1),"IV",DA,"TITR","C",GDT,0)) S:$D(^GMR(126,DA(1),"IV",DA,"TITR",GDA,0)) GDA(1)=+$P(^(0),"^"),GDA(2)=+$P(^(0),"^",2),GDA(3)=+$P(^(0),"^",3)
 I GDT>0 S Y=GDA(1) X ^DD("DD") W !!,"Rate was adjusted @"_$P(Y,":",1,2),! S GMRZ(3)=GDA(2)
RATE W !,"Infusion rate(ml/hr)"_$S(GMRZ(3)=0:" UNKNOWN //",GMRZ(3)'="":" "_GMRZ(3)_" //",1:": ") S X="" R X:DTIME G:'$T!(X["^") Q I X'=""&(X'?1.3N) S X="" D HELP^GMRYED4 G RATE
 S:X="" X=GMRZ(3) S:X=""!(X=0) X="" I X'=""&((X<0)!(X>999)) D HELP^GMRYED4 G RATE
RATE1 ;
 S GMRZ(3)=X,DA(2)=DA(1),DA(1)=DA S:'$D(^GMR(126,DA(2),"IV",DA(1),"TITR",0)) ^(0)="^126.316DA^0^0"
 K DD S DLAYGO=126.316,X=GMRVDT,DIC="^GMR(126,"_DA(2)_",""IV"","_DA(1)_",""TITR"",",DIC(0)="ML" D FILE^DICN K DR,DIC,DLAYGO,DD S DA=+Y I Y'>0 S GMROUT=1,DA=DA(1),DA(1)=DA(2) G Q
 S DIE="^GMR(126,"_DA(2)_",""IV"","_DA(1)_",""TITR"",",DR="1///^S X=GMRZ(3);2///^S X=""`""_DUZ;3///^S X=""`""_GMRHLOC;4" D WAIT^GMRYUT0,^DIE L -^GMR(126,DFN) K DIE,DR
Q K GMRVDT,GTYPE Q
