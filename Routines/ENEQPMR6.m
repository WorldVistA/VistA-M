ENEQPMR6 ;(WASH ISC)/DH-Rapid Deferral of PM Worklist ;1/11/2001
 ;;7.0;ENGINEERING;**24,35,48,68**;Aug 17, 1993
 ;
RD ;  Affected PM work orders will be DEFERRED with a DATE COMPLETE
 ;    of TODAY
 ;
 K ENPMWO S Y=DT X ^DD("DD") S ENDATE=Y,Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="Select Month: ",%DT("B")=Y,%DT="AEPMX" D ^%DT G:Y'>0 EXIT S ENPMDT=$E(Y,2,5),ENPMMN=+$E(Y,4,5),ENPMYR=1700+$E(Y,1,3)
 S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC G:Y'>0 EXIT S ENSHKEY=+Y,ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1),ENSHABR=$P(^(0),U,2)
RD1 R !,"MONTHLY or WEEKLY PM List: MONTHLY// ",X:DTIME G:X="^" EXIT S ENPM=$S(X="":"M",$E(X)="M":"M",$E(X)="W":"W",1:"") G:ENPM="M" RD2 I ENPM']"" D RDH1 G RD1
RD11 R !,"Which week? ",X:DTIME G:X="^" EXIT I X<1!(X>5) W !,"Enter a number, 1 to 5." G RD11
 S ENPMWK=X,ENPM=ENPM_ENPMWK
 ;
RD2 S ENDEL="" I $D(^DIC(6910,1,0)) S ENDEL=$P(^(0),U,5)
 I ENDEL']"" R !!,"Should PM work orders be deleted after close out? YES//",X:DTIME G:X="^" EXIT S:X=""!($E(X)="Y") ENDEL="Y" I ENDEL'="Y",$E(X)'="N" D COBH1^ENEQPMR4 G RD2
 ;
RD2T W !!,"This option will scan the "_$S(ENPM="M":"MONTHLY",ENPM["W":"WEEKLY",1:"")_" PM Worklist of the "_ENSHOP_" Shop",!,"for "_$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER","^",ENPMMN)
 W ", "_ENPMYR_$S(ENPM["W":" (Week "_ENPMWK_")",1:"")_"."
 W !!,"It will automatically assign a PM Status of 'DEFERRED' and a close out date of",!,ENDATE," to each work order on the list."
 W !!,"Default values for labor and material costs (if any) from the Equipment File",!,"will NOT be posted to the Equipment History during RAPID DEFERRAL."
 W !!,"Are you sure you want to proceed " S %=2 D YN^DICN G:%=0 RD2T G:%'=1 EXIT
 S (ENPMWO,ENPMWO("P"))="PM-"_ENSHABR_ENPMDT_ENPM_"-"
 I $O(^ENG(6920,"B",ENPMWO))'[ENPMWO("P") W *7,!!,"Specified worklist doesn't seem to exist.  Nothing to DEFER." D HOLD G EXIT
 ;
RD2P S ENFR="",ENTO="ZZ",ENTO("L")=20
 W !!,"Would you like to specify starting and stopping points for",!,"Rapid Deferral" S %=2 D YN^DICN G:%<0 EXIT G:%=2 RD2PD I %=0 D RD2PH G RD2P
 S J=$O(^ENG(6920,"B",ENPMWO("P"))) G:J'[ENPMWO("P") EXIT
 W !!,"Please enter the starting work order (or the sequential portion thereof)",!,"(ex: '"_J_"' or just '"_+$P(J,"-",3)_"'):"
 R X:DTIME G:'$T!($E(X)="^")!(X="") RD2P
 S:X?1.2N X=$S(X?1N:"00"_X,1:"0"_X) I X?.N S X=ENPMWO("P")_X
 S DIC="^ENG(6920,",DIC("S")="I $P(^(0),U)[ENPMWO(""P"")",DIC(0)="X" D ^DIC K DIC("S") G:Y'>0 RD2P S ENFR=$P(Y,U,2) W "    ("_ENFR_")"
 S ENFR(0)=$O(^ENG(6920,"B",ENFR),-1) S ENFR=$S(ENFR(0)[ENPMWO("P"):ENFR(0),1:ENPMWO("P")_"000")
 W !!,"Now enter last work order to be deferred (or sequential portion thereof)"
 S J=$O(^ENG(6920,"B",ENPMWO("P")_9999),-1)
 W !,"(ex: '"_J_"' or just '"_+$P(J,"-",3)_"'): "
 R X:DTIME G:'$T!(X="^")!(X="") RD2P
 I X?1.N S:X?1.2N X=$S(X?1N:"00"_X,1:"0"_X) S X=ENPMWO("P")_X
 S DIC("S")="I $P(^(0),U)[ENPMWO(""P""),(+$P($P(^(0),U),""-"",3)>+$P(ENFR,""-"",3))"
 D ^DIC K DIC("S") G:Y'>0 RD2P S ENTO=$P(Y,U,2),ENTO("L")=$L(ENTO) W "    ("_ENTO_")"
 ;
RD2PD L +^ENG("PMLIST",ENPMWO):1 I '$T W !!,"Another user is processing this worklist. Please try again later.",*7 G EXIT
 S ENPMWO(0)=ENPMWO
 S ENPMWO=$S(ENFR]"":ENFR,1:ENPMWO("P")_"000"),DIE="^ENG(6920,",DR="35.2///D0;36///T;32///^S X=""COMPLETED"""
 W !,"Would you like to free up this terminal" S %=1 D YN^DICN G:%=1 RD3 G:%<0 EXIT G:%=0 RD2PD
 W !,"Rapid deferral now in progress "
 F ENK=0:0 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO'[ENPMWO("P")!(ENPMWO]ENTO)  I $L(ENPMWO)'>ENTO("L") D
 . W "." S DA=$O(^ENG(6920,"B",ENPMWO,0)) I $D(^ENG(6920,DA)) D POST I $D(DA),ENDEL="Y" D DEL
 G EXIT
 ;
RD3 S ZTDTH=$H,ZTRTN="RD4^ENEQPMR6",ZTDESC="Rapid deferral (PM worklist)",ZTSAVE("EN*")="",ZTIO="",ZTSAVE("DIE")="",ZTSAVE("DR")="" D ^%ZTLOAD K ZTSK D ^%ZISC,HOME^%ZIS
 G EXIT
 ;
RD4 F ENK=0:0 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO'[ENPMWO("P")!(ENPMWO]ENTO)  I $L(ENPMWO)'>ENTO("L") D
 . S DA=$O(^ENG(6920,"B",ENPMWO,0)) I $D(^ENG(6920,DA)) D POST I $D(DA),ENDEL="Y" D DEL
EXIT I $D(ENPMWO(0)) L -^ENG("PMLIST",ENPMWO(0))
 K EN,ENPMWO,ENK,ENDATE,ENDEL,ENPM,ENPMDT,ENPMMN,ENPMWK,ENSHABR,ENSHKEY,ENSHOP,ENFR,ENTO,ENPMYR S:$D(ZTQUEUED) ZTREQ="@"
 K DA,DIC,DR,DIE,DIK
 Q
POST I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" K DA Q
 I $D(^ENG(6920,DA,5)) F I=3,4,6 S $P(^(5),U,I)=""
 I $D(^ENG(6920,DA,7)) F I=0:0 S I=$O(^ENG(6920,DA,7,I)) Q:I'>0  S:$D(^(I,0)) $P(^(0),U,2)=""
 D ^DIE
 Q
DEL I $E($P(^ENG(6920,DA,0),U,1),1,3)="PM-" S DIK="^ENG(6920," D ^DIK
 Q
RDH1 W !,"A MONTHLY PMI list contains work orders for ANNUAL, SEMI-ANNUAL, QUARTERLY,",!,"BI-MONTHLY, and MONTHLY preventive maintenance inspections."
 W !,"A WEEKLY PMI list is for WEEKLY and BI-WEEKLY inspections."
 Q
RD2PH W !!,"If you want to defer only a portion of a PM worklist, you may specify the",!,"first and last work orders that you want Rapid Deferral to operate on."
 W !,"Everything between and including these two work orders will be DEFERRED.",!,"Please enter the entire work order numbers (ex: 'PM-E9702M-102')."
 Q
HOLD R !,"<cr> to continue, '^' to quit...",X:DTIME S ENY=1 Q
 ;ENEQPMR6
