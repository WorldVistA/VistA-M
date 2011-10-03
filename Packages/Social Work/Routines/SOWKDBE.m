SOWKDBE ;B'HAM ISC/SAB-Routine to enter/edit data profile ; 08 Dec 93 / 9:25 AM [ 09/22/94  7:45 AM ]
 ;;3.0; Social Work ;**17,34**;27 Apr 93
 W ! S TEM="[SOWKDBEMP]^[SOWKDBEDU]^[SOWKDBMIL]^[SOWKDBSOC]^[SOWKDBLE]^[SOWKDBSUB]^[SOWKDBPRO]^[SOWKDBPSY]"
 D SE G:"^"[$E(X) CLOS
BEG W ! D DEM^VADPT S ST=$S($P(VADM(10),"^",2)="MARRIED":1,1:"") D KVA^VADPT S (DIE,DIC)="^SOWK(655.2,",DR=".022;.023;.0221" D ^DIE K DR
 D PID^VADPT6 W @IOF,!,$P(^DPT(DFN,0),"^"),?36 S Y=$P(^DPT(DFN,0),"^",3) X ^DD("DD") W "DOB: "_Y,?57,"ID#: "_VA("PID")
 W !!,"1.  EMPLOYMENT/FINANCIAL",?39,"2.  EDUCATION",!!,"3.  MILITARY HISTORY",?39,"4.  SOCIAL/FAMILY RELATIONSHIPS",!!,"5.  LEGAL SITUATION",?39,"6.  CURRENT SUBSTANCE ABUSE"
 W !!,"7.  PRELIMINARY PROBLEMS",?39,"8.  PSYCHO-SOCIAL ASSESSMENT"
 K I R !!,"Enter number(s) to enter/edit i.e => 1 or 1,8 or All or ""^"": ALL// ",INP:DTIME S:INP=""!("Aa"[$E(INP)) INP="ALL" G:"^"[$E(INP) PR G:"?"[$E(INP) HP W ! G:INP="ALL" ENT
 I ","'[INP,INP>8 W !,*7 G TRY
 I ","'[INP,'+INP W !,*7 G TRY
 F I=1:1 Q:'$P(INP,",",I)  I $P(INP,",",I)>8!($P(INP,",",I)<1) W !,*7 G TRY
 F I=1:1:$L(INP,",") I $P(INP,",",I)>8!($P(INP,",",I)<1) W !,*7 G TRY
 W @IOF F SW=1:1 Q:'$P(INP,",",SW)  S DR=$P(TEM,"^",$P(INP,",",SW)) D ^DIE W @IOF
 S DR=".03////"_SWWRK_";.04////"_SUP_";.031////"_$P(C,"^")_";.02///"_DT D ^DIE
 G PR
ENT W @IOF F SW=1:1 Q:$P(TEM,"^",SW)=""  S DR=$P(TEM,"^",SW) D ^DIE W @IOF
 I $P(^SOWK(655.2,DFN,0),"^",3)'=SWWRK S DR=".03////"_SWWRK_";.04////"_SUP_";.031////"_$P(C,"^")_";.02///"_DT D ^DIE
PR D PID^VADPT6 W @IOF,!!!,$P(^DPT(DFN,0),"^"),?36 S Y=$P(^(0),"^",3) X ^DD("DD") W "DOB: "_Y,?57,"ID#: "_VA("PID")
TR F Q=0:0 W !!?10 R "Do you want to print Assessment data" S %=2 D YN^DICN Q:%  I %Y="?" D YN^SOWKHELP
 G:%=2!(%=-1) CLOS
 K ND,ST,%,%Y,BF,BO,I,DIC,DIE,Y,X,DR,FF,S D EN^SOWKDB
CLOS K ST,IN,INP,TEM,ND,SW,Q,%,%Y,DFN,I,DIC,DIE,Y,X,DA,DR,FF,S,BF,BO,SW,C,SUP,SWWRK,DINUM
 Q
SE K DIC S DIC("S")="I $D(^SOWK(650,""W"",DUZ,+Y))",DIC="^SOWK(650,",DIC(0)="AEQMZ",DIC("A")="SELECT CASE: " D ^DIC Q:"^"[$E(X)  G:Y<1 SE S DA=+Y,C=^SOWK(650,DA,0),(DFN,DA)=$P(C,"^",8) K DIC D PID^VADPT6
 S SUP=$P(^VA(200,$P(C,"^",3),654),"^",2),SWWRK=$P(C,"^",3)
 I $D(^SOWK(655.2,DFN,0)) S DIE="^SOWK(655.2," Q
 D WAIT^DICD K DIC S (DINUM,X)=DFN,DIC(0)="L",DIC="^SOWK(655.2,",DIC("DR")=".03////"_SWWRK_";.04////"_SUP_";.031////"_$P(C,"^")_";.02///"_DT K DD,DO D FILE^DICN
 Q
HP W @IOF,!!!,"Enter the number of the category for this patient you want to enter/edit.",!,"For example if you want to enter/edit the categories ""EDUCATION"" and ""MILITARY""."
 W !,"Enter the number ""2"" and ""3"" i.e. 2,3 separated by comma or enter any"
 W !,"combination of numbers separated by commas or if all categories are to be",!,"edited, press carriage return for default of ""ALL"". VALID NUMBERS ARE 1-8."
TI F Q=0:0 W !!,"Do you want to try again" S %=1 D YN^DICN Q:%  I %Y="?" D YN^SOWKHELP
 G:%=2 PR G:%=-1 CLOS
 G BEG
TRY F Q=0:0 W !!,"INVALID CATEGORY NUMBER(s) !  Do you want to try again" S %=2 D YN^DICN Q:%  I %Y="?" G HP
 G:%=2 PR G:%=-1 CLOS
 G BEG
