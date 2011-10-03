SOWKDBPN ;B'HAM ISC/SAB-Print notes routine i.e., Discharge, Closing ; 04 Apr 94 / 7:46 AM [ 09/22/94  7:45 AM ]
 ;;3.0; Social Work ;**12,17,28,31,35,34**;27 Apr 93
ASK K DIC W ! S DIC("S")="I $D(^SOWK(650,""W"",DUZ,+Y))",DIC="^SOWK(650,",DIC(0)="AEQMZ",DIC("A")="Select Case: " D ^DIC G:"^"[X CLO G:Y<1 ASK S CN=+Y,(DFN,DA(1))=$P(Y(0),"^",8)
NT W !!?5,"1.  CLOSING NOTES",!?5,"2.  DISCHARGE PLANNING" R !!,"ENTER 1, 2 OR 'ALL' FOR BOTH NOTES TO PRINT or '^' to EXIT: ",TY:DTIME G:"^"[$E(TY)!'$T CLO
 S TY=$S(TY=1!("Cc"[$E(TY)):"CLN",TY=2!("Dd"[$E(TY)):"DPN","Aa"[$E(TY):"ALL",1:"") G:TY']"" NT
DEV ;
 K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLO
 K SOWKION I $D(IO("Q")) S ZTRTN="EN^SOWKDBPN" F G="DA(1)","CN","DFN","DA","TY","DUZ" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:ZTSK !,"Task Queued to Print" K ZTSK G CLO
EN S OUT=0 D INP^VADPT,PID^VADPT6,@TY
CLO I $E(IOST)["C",('$G(OUT)) R !,"Press <RETURN> to continue: ",SWXX:DTIME K SWXX W @IOF
 W ! D ^%ZISC,KVAR^VADPT K IOP,OUT,CN,PG,XX,DFN,DS,SX,DA,DIC,G,I,POP,TY,X,Y,^TMP($J) D:$D(ZTSK) KILL^%ZTLOAD
 Q
CLN U IO S PG=0 D HDR,PAO
 D CHK Q:OUT=1  W !!,"CLOSING NOTE:" S SX=$O(^SOWK(655.2,DA(1),23,"AG",CN,0)) I SX F DS=0:0 S DS=$O(^SOWK(655.2,DA(1),23,SX,2,DS)) Q:'DS!(OUT=1)  D CHK Q:OUT=1  W !,$P(^SOWK(655.2,DA(1),23,SX,2,DS,0),"^")
 D CHK Q:OUT=1  S XX=$O(^SOWK(655.2,DA(1),23,"AG",CN,0)) W !!,"AFTER CARE PLAN: "_$S(XX:$P(^SOWK(655.2,DA(1),23,XX,0),"^",5),1:"")
 D CHK Q:OUT=1  W !,"OPEN DATE:  "_$E($P(^SOWK(650,CN,0),"^",2),4,5)_"/"_$E($P(^(0),"^",2),6,7)_"/"_$E($P(^(0),"^",2),2,3),?30,"CLOSED DATE: "_$E($P(^SOWK(650,CN,0),"^",18),4,5)_"/"_$E($P(^(0),"^",18),6,7)_"/"_$E($P(^(0),"^",18),2,3)
 D CHK Q:OUT=1  W !,"NOTE ENTERED: "_$S(XX:$E($P(^SOWK(655.2,DA(1),23,XX,0),"^",6),4,5)_"/"_$E($P(^(0),"^",6),6,7)_"/"_$E($P(^(0),"^",6),2,3),1:"")
 D TR Q
DPN U IO S PG=0 D HDR
 W !!,"SERVICES OFFERED:" S SX=$O(^SOWK(655.2,DA(1),23,"AG",CN,0)) I SX F DS=0:0 S DS=$O(^SOWK(655.2,DA(1),23,SX,1,DS)) Q:'DS!(OUT=1)  D CHK Q:OUT=1  W !?5,$P(^SOWK(655.202,$P(^SOWK(655.2,DA(1),23,SX,1,DS,0),"^"),0),"^")
 D PAO
 D CHK Q:OUT=1  W !!,"DISCHARGE PLAN: "_$S(SX:$P(^SOWK(655.2,DA(1),23,SX,0),"^",3),1:""),!,"DISCHARGE PLAN ENTERED: "_$S(SX:$E($P(^SOWK(655.2,DA(1),23,SX,0),"^",4),4,5)_"/"_$E($P(^(0),"^",4),6,7)_"/"_$E($P(^(0),"^",4),2,3),1:"")
 D TR
 Q
ALL ;
 N SWXX
 S TY="CLN" D CLN Q:OUT=1
 I $E(IOST)["C" W !,"Press <RETURN> to continue: " R SWXX:DTIME I SWXX["^" S OUT=1 Q
 W @IOF S TY="DPN" D DPN
 Q
HDR Q:OUT=1
 D HDR^SOWKDB1 W "MEDICAL RECORD",?40,$S("C"[$E(TY):"CLOSING ","D"[$E(TY):"DISCHARGE PLANNING ",1:" ")_"NOTE",!,"DIAGNOSIS: "_$P(VAIN(9),"^"),?40,"PRINTED: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),!
 Q
TR D CHK Q:OUT=1  W !!,"PATIENT:  "_$P(^DPT(DFN,0),"^"),!,"ID#: "_VA("PID"),!,"WARD/BED: "_$P(VAIN(4),"^",2)_"/"_$P(VAIN(5),"^")
 D CHK Q:OUT=1  W !!?35,$P(^VA(200,$P(^SOWK(650,CN,0),"^",3),20),"^",2)_", Social Worker",!!?20,"Social Work Service Reports and Summaries",!?20,"10-9034 VAF VICE 10-1349"
 Q
PAO W !!,"PROBLEMS: " F XX=0:0 S XX=$O(^SOWK(655.2,DA(1),17,XX)) Q:'XX!(OUT=1)  D CHK Q:OUT=1  W !,$S($P(^SOWK(655.2,DA(1),17,XX,0),"^"):$P(^SOWK(655.201,$P(^SOWK(655.2,DA(1),17,XX,0),"^"),0),"^"),1:"")
 D CHK Q:OUT=1  W !!,"INITIAL PLAN OF ACTION: " F XX=0:0 S XX=$O(^SOWK(655.2,DA(1),10,XX)) Q:'XX!(OUT=1)  D CHK Q:OUT=1  W !,^SOWK(655.2,DA(1),10,XX,0)
 Q
CHK ;
 Q:($Y+10)'>IOSL
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1 W @IOF Q
 D HDR Q
