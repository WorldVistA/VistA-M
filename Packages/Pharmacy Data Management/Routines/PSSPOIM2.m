PSSPOIM2 ;BIR/RTR/WRT-Orderable Item manual create - initial create ; 09/01/98 7:12
 ;;1.0;PHARMACY DATA MANAGEMENT;**15**;9/30/97
 D WOOPS H 2 Q:$D(^TMP("PSSLOOP"))
 S PSSITE=+$O(^PS(59.7,0)) I $P($G(^PS(59.7,PSSITE,80)),"^",2)'=2 W !!?3,$S($P($G(^(80)),"^",2)<2:"Orderable Item Auto-Create has not been completed!",1:"Manual matching process complete!"),!! K PSSITE D  Q
 .K DIR S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 S PSOUT=0 D MESSZ^PSSPOIM1 G:$G(PSOUT) CHECK
 S PSCREATE=1 D ^PSSPOIM3 G:$G(PSOOOUT) CHECK
BEG ;
 W !!?3,"NOW MATCHING DISPENSE DRUGS!",!
 S X1=DT,X2=-365 D C^%DTC S PSXDATE=X,PSOUT=0,AAA=""
 F  S AAA=$O(^PSDRUG("B",AAA)) Q:AAA=""!($G(PSOUT))  F PSIEN=0:0 S PSIEN=$O(^PSDRUG("B",AAA,PSIEN)) Q:'PSIEN!($G(PSOUT))  I $G(PSIEN),'$P($G(^PSDRUG(PSIEN,2)),"^") D  I ZXX I APLU["I"!(APLU["O")!(APLU["U") S PSNAME=$P(^(0),"^") D START
 .S APLU=$P($G(^PSDRUG(PSIEN,2)),"^",3)
 .S ZXX=1 S PSXDDATE=+$P($G(^PSDRUG(PSIEN,"I")),"^") I PSXDDATE,PSXDDATE<PSXDATE S ZXX=0
CHECK D CHECK^PSSPOIM1
 G END^PSSPOIM1
START K DOSEFV,DOSEFORM,POINT,SPHOLD,NEWSP,RESTART W !!!?5,"Dispense Drug -> ",PSNAME
 S NODE=$G(^PSDRUG(PSIEN,"ND")),DOSEPTR=0,DA=$P($G(NODE),"^"),X=$$VAGN^PSNAPIS(DA),VAGEN=X I +$P(NODE,"^"),+$P(NODE,"^",3),$G(VAGEN)'=0 S K=$P($G(NODE),"^",3),X=$$PSJDF^PSNAPIS(DA,K),DOSEFV=X I $G(DOSEFV)'=0 D
 .S DOSEPTR=$P(X,"^"),DOSEFORM=$P(X,"^",2)
 K PSPOI D TMP
 D MCH D:$G(PSPOI)  I $G(PSOUT) W ! S PSOUT=0,RESTART=1 K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to exit this option" D ^DIR K DIR I Y!(Y["^")!($D(DTOUT)) S PSOUT=1
 .S NEWFLAG=1 D DIR^PSSPOIM3 I $G(PSSDIR) W !!?3,"Now editing Orderable Item:",!?3,$P($G(^PS(50.7,PSPOI,0)),"^")_"   "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^") D INACT^PSSADDIT
 .K NEWFLAG,PSSDIR D EN^PSSPOIDT(PSPOI) K PSPOI
 I $G(RESTART),'$G(PSOUT) G START
 Q
TMP K ^TMP($J,"PSSOO") S PSCNT=0 I +$P(NODE,"^"),+$P(NODE,"^",3) F ZZ=0:0 S ZZ=$O(^PSDRUG("AND",+NODE,ZZ)) Q:'ZZ  I +$P($G(^PSDRUG(ZZ,2)),"^"),$P(^PSDRUG(ZZ,2),"^")'=$G(POINT),$D(^PS(50.7,$P(^PSDRUG(ZZ,2),"^"),0)) S OTH=$G(^PSDRUG(ZZ,"ND")) D
 .I +$P(OTH,"^"),+$P(OTH,"^",3),$G(DOSEFV)'=0 S DA=$P($G(OTH),"^"),K=$P($G(OTH),"^",3),X=$$PSJDF^PSNAPIS(DA,K),DOSA=X I $G(DOSA)'=0,DOSEFV=DOSA D
 ..S NOFLAG=0,TMPTR=$P(^PSDRUG(ZZ,2),"^") F FFF=0:0 S FFF=$O(^TMP($J,"PSSOO",FFF)) Q:'FFF  I $P(^TMP($J,"PSSOO",FFF),"^")=TMPTR S NOFLAG=1
 ..I 'NOFLAG S PSCNT=PSCNT+1 S ^TMP($J,"PSSOO",PSCNT)=$P(^PSDRUG(ZZ,2),"^")_"^"_ZZ
 Q
DISP S MATCH=0 F TT=0:0 S TT=$O(^TMP($J,"PSSOO",TT)) Q:'TT  S SPT=$P(^TMP($J,"PSSOO",TT),"^") W !,TT,"  ",$P($G(^PS(50.7,SPT,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^") I $Y+5>IOSL D  Q:Y=0  I Y="" S PSOUT=1 Q
 .W ! K DIR S DIR(0)="E" D ^DIR I Y W @IOF W !,?3,"Dispense Drug -> ",PSNAME,!
DISPO Q:$G(PSOUT)  W ! K DIR S DIR(0)="N",DIR("A")="Choose number of Orderable Item to match, or '^' to enter a new one" D ^DIR K DIR I Y=""!($D(DTOUT)) S PSOUT=1 Q
 Q:Y["^"  I '$D(^TMP($J,"PSSOO",+Y)) W !!,?5,"INVALID NUMBER" G DISPO
 S MATCH=$P(^TMP($J,"PSSOO",+Y),"^") Q
 S PSOUT=1 Q
MCH I $O(^TMP($J,"PSSOO",0)) W ! K DIR S DIR(0)="E" D ^DIR I 'Y!($D(DTOUT)) S PSOUT=1 Q
 I $O(^TMP($J,"PSSOO",0)) D OTHER,DISP
 Q:$G(PSOUT)  I $O(^TMP($J,"PSSOO",0)),$G(MATCH) S PSSP=MATCH D ^PSSPOIM1 I PSOUT!(PSNO) S PSOUT=1 Q
 I $O(^TMP($J,"PSSOO",0)),$G(MATCH) K DIE S DIE="^PSDRUG(",DA=PSIEN,DR="2.1////"_MATCH D ^DIE S PSPOI=MATCH D COM Q
MCHA W ! I $G(DOSEFORM)'="" W !?3,"Dose Form -> ",DOSEFORM,!! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Match to another Orderable Item with same Dose Form" D ^DIR G:Y=1 LOOK I Y["^"!(Y="")!($D(DTOUT)) S PSOUT=1 Q
 I $G(DOSEFORM)="" K DIC S DIC="^PS(50.606,",DIC(0)="QEAMZ",DIC("A")="Choose Dose Form: " D ^DIC I $D(DTOUT)!($D(DUOUT))!(Y<1) S PSOUT=1 Q
 I $G(DOSEFORM)="" S DOSEPTR=+Y W !!?3,"Dose Form -> ",$G(Y(0,0))
 I $G(DOSEFORM)="" K DIR W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Match to another Orderable Item with same Dose Form" D ^DIR
 I $G(DOSEFORM)="" S DOSEFORM=$P(^PS(50.606,DOSEPTR,0),"^") G:Y>0 LOOK I $D(DTOUT)!($D(DUOUT))!(Y<0) S PSOUT=1 Q
MCHAN W !! I $L(VAGEN)>40 W !,"VA Generic Name -> ",VAGEN,!
 W !,?3,"Dose Form -> ",DOSEFORM,!,?3,"Dispense Drug -> ",PSNAME,!
 K DIR S DIR(0)="F^3:40",DIR("A")="Orderable Item Name" S:$L(VAGEN)>2&($L(VAGEN)<41) DIR("B")=VAGEN
 D ^DIR I $D(DUOUT)!($D(DTOUT))!(Y["^")!(Y="") S PSOUT=1 Q
 I X[""""!($A(X)=45)!('(X'?1P.E))!(X?2"z".E) W $C(7),!!?5,"??" G MCHAN
 S X=Y,SPHOLD=X,(STOP,PSNO)=0 F COMM=0:0 S COMM=$O(^PS(50.7,"ADF",SPHOLD,DOSEPTR,COMM)) Q:'COMM!(STOP)!($G(PSOUT))  I COMM,$P($G(^PS(50.7,COMM,0)),"^",3)="" D
 .S PSSP=COMM D ^PSSPOIM1 S:PSNO STOP=1 Q:PSOUT!(STOP)  K DIE S DIE="^PSDRUG(",DA=PSIEN,DR="2.1////"_COMM D ^DIE S PSPOI=COMM D COM S STOP=1 Q
 Q:PSOUT
 I STOP,$G(PSNO) G MCHAN
 Q:STOP
 S PSMAN=1 D ^PSSPOIM1 G:PSNO MCHAN Q:PSOUT  K DIC S DIC="^PS(50.7,",DIC(0)="L",X=SPHOLD,DIC("DR")=".02////"_DOSEPTR K DD,DO D FILE^DICN D:Y<1  G:(Y<1) MCHAN S NEWSP=+Y,DIE="^PSDRUG(",DA=PSIEN,DR="2.1////"_NEWSP D ^DIE D COM Q
 .W $C(7),!?5,"Unable to create entry, try again!",!! Q
 Q
LOOK W !!!?3,"Enter ?? for Pharmacy Orderable Item List!"
 W ! K DIC S DIC="^PS(50.7,",DIC(0)="QEAM",DIC("S")="I $P($G(^(0)),""^"",2)=DOSEPTR,$P($G(^(0)),""^"",3)=""""" D ^DIC I Y>0 K DIC("S") S (NEWSP,PSSP)=+Y D ^PSSPOIM1 G:PSNO LOOK Q:PSOUT  S DIE="^PSDRUG(",DA=PSIEN,DR="2.1////"_NEWSP D ^DIE D COM Q
 W ! K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Create a new Orderable Item to match" D ^DIR I Y=1 G MCHAN
 S PSOUT=1 Q
COM W !,"Match Complete!",! S:'$G(PSPOI) PSPOI=$G(NEWSP) Q
OTHER W @IOF W !,"There are other Dispense Drugs with the same VA Generic Name and same Dose",!,"Form already matched to orderable items. Choose a number to match, or enter",!,"'^' to enter a new one.",!!?6,"Disp. drug -> ",PSNAME,! Q
WOOPS W:$D(^TMP("PSSLOOP")) !!,$C(7),"Sorry, but someone else is using this option.",!
 Q
