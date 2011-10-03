SOWKBH ;B'HAM ISC/SAB-Print routine for Community Resource Module ; 22 Jan 93 / 9:58 AM [ 07/18/94  1:02 PM ]
 ;;3.0; Social Work ;**33,60,61**;27 Apr 93
ASK W !!,"Do you want",!?5,"Single level sort (S)" R !?5,"Multiple level sort (M):  S// ",SW:DTIME S:SW="" SW="S" G:"^"[SW!('$T) CLO
 I "SM"'[$E(SW) W !!,"'S' for single level sort",!,"'M' for multiple level sort" G ASK
 W $S("S"[$E(SW):" SINGLE LEVEL SORT",1:" MULTIPLE LEVEL SORT"),@IOF G @$S("S"[$E(SW):"SORT1",1:"SORT2")
DEV K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K POP,IOP,SOWKION,SWP,DA,DIC,DIE,DR,FF,I,SW,SWE,X,Y G CLO Q
 K SOWKION I $D(IO("Q")) S ZTDESC="COMMUNITY RESOURCE MODULE REPORT",ZTRTN="SWDE^SOWKBH",G="DA" S:$D(@G) ZTSAVE(G)="" D ^%ZTLOAD K SWP,G,DA,DIC,DIE,DR,FF,I,IOP,SW,SWDE,SWE,X,Y,ZTSK G CLO Q
SWDE D PRI
CLO I $E(IOST)["C" R !,"PRESS RETURN TO CONTINUE or '^' TO EXIT: ",SWXX:DTIME
 W:$E(IOST)'["C" @IOF D ^%ZISC K BY,D,D0,FLDS,Z0,SWP,DA,DIC,DIE,DR,FF,I,SW,SWDE,SWE,SWXX,X,Y D:$D(ZTSK) KILL^%ZTLOAD
 Q
PRI U IO W:$Y @IOF W !,"AGENCY:",?30,$P(^SOWK(656,DA,0),"^"),!,"STREET ADDRESS 1:",?30,$P($G(^(0)),"^",2),!,"STREET ADDRESS 2:",?30,$P($G(^SOWK(656,DA,4)),"^",3),!,"CITY:",?30,$P($G(^SOWK(656,DA,0)),"^",3),!
 W "STATE:",?30,$S($P($G(^SOWK(656,DA,4)),"^",2)="":"",1:$P($G(^DIC(5,$P(^SOWK(656,DA,4),"^",2),0)),"^")),!,"COUNTY:",?30,$P($G(^SOWK(656,DA,4)),"^"),!,"ZIP:",?30,$P($G(^SOWK(656,DA,0)),"^",5),!
 W "PHONE NUMBER:",?30,$P($G(^SOWK(656,DA,0)),"^",6),!,"PHONE NUMBER #2:",?30,$P($G(^SOWK(656,DA,1)),"^",4),!,"FAX NUMBER:",?30,$P($G(^SOWK(656,DA,0)),"^",8),!,"HOURS:",?30,$P($G(^(0)),"^",7)
 W !,"SERVICE:",?30,$P($G(^SOWK(656,DA,1)),"^"),!,"ELIGIBILITY:",?30,$P($G(^(1)),"^",2),!,"FEES:",?30,$P($G(^(1)),"^",3),!
 W "REFERRAL:",?30,$P($G(^SOWK(656,DA,2)),"^"),!,"COMMENTS:",?30,$E($P($G(^SOWK(656,DA,2)),"^",2),1,48),!?30,$E($P($G(^SOWK(656,DA,2)),"^",2),49,70)
 W !,"DATE OF INFO:",?30 S Y=$P($G(^(2)),"^",3) X ^DD("DD") W Y,!,"VA LIAISON:",?30,$P($G(^SOWK(656,DA,2)),"^",4),!,"SPECIAL POPULATION:",?30,$P($G(^(2)),"^",6)
 W !,"TYPE:" F I=0:0 S I=$O(^SOWK(656,DA,3,I)) Q:'I  W ?30,$P($G(^SOWK(656,DA,3,I,0)),"^")_", "
 Q
LOK ;SOW*3*60 (Dave B)
 W !,"AD will stand for ADDICTION",!,"DA will stand for DAY CARE",!,"EM will stand for EMPLOYMENT",!,"FI will stand for FINANCES",!,"FO will stand for FOOD",!,"HE will stand for HEALTH"
 W !,"HO will stand for HOUSING",!,"IH will stand for IN HOME SERVICES",!,"IN will stand for INFORMATION/REFERRALS",!,"LE will stand for LEGAL",!,"MH will stand for MENTAL HEALTH"
 W !,"SH will stand for SELF HELP",!,"SP will stand for SP ED/RECREATION",!,"TR will stand for TRANSPORTATION",!,"VO will stand for VOLUNTEER"
 W ! Q
EN1 ;ENTRY POINT TO GET A VALID COUNTY FOR A SELECTED STATE/013086
 S Z0=$S($D(^SOWK(656,D0,4)):+$P(^(4),"^",2),1:0) S DIC="^DIC(5,Z0,1,",DIC(0)="QEM" D ^DIC
 Q
SORT1 W !!,?25,"SINGLE LEVEL SORT",!!,"Select By: ",!,?5,"County",!,?5,"Agency",!,?5,"City",!,?5,"Zip",!,?5,"Type " R !,"Enter two or more characters: ",SW:DTIME G:"^"[SW!('$T) CLO S SW=$E(SW,1,2)
SEA W @IOF,!! S DR=".01:99",(DIC,DIE)="^SOWK(656,",DIC(0)="AEQ",DIC("A")=$S(SW="CO":"COUNTY: ",SW="TY":"TYPE: ",SW="CI":"CITY: ",SW="ZI":"ZIP: ",SW="AG":"AGENCY: ",1:"1") D:SW="TY" LOK I DIC("A") D HLP G SORT1
 ;
 ;SOW*3*60 (Dave B, removed $T check on next line 12/12/99)
TY S D=$S(SW="CO":"M",SW="TY":"C",SW="CI":"E",SW="ZI":"D",1:"B") D IX^DIC G:"^"[X CLO G:Y'>0 TY S DA=+Y K DIC G DEV
 Q
SORT2 W !!,?25,"MULTIPLE SORT"
 S ZTDESC="COMMUNITY RESOURCE MODULE PRINT OPTION",BY="@",FLDS="[SOWKBHP]",DIC="^SOWK(656," D EN1^DIP G CLO
 Q
HLP W !,"Enter",!!?5,"CO for COUNTY",!!?5,"AG for AGENCY",!!?5,"CI for CITY",!!?5,"ZI for ZIP",!!?5,"TY for TYPE" Q
