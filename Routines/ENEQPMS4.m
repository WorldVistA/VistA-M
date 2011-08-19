ENEQPMS4 ;(WASH ISC)/DH-Delete PMI Work Orders ;1/11/2001
 ;;7.0;ENGINEERING;**35,48,51,68**;Aug 17, 1993
LSTH1 W !!,"All worklists are sorted by shop, and within shop they may be sorted again by",!,"RESPONSIBLE TECHNICIAN. You must now choose how this list should be sorted"
 W !,"further. You have the following choices:"
 W !,?10,"'E' for Equipment Entry #"
 W !,?10,"'P' for PM #"
 W !,?10,"'I' for Local Identifier"
 W !,?10,"'L' for Location"
 W !,?10,"'C' for Equipment Category"
 W !,?10,"'S' for Owning Service",!
 Q
 ;
DEL ;  delete PM worklist
 W !!,"Which do you wish to delete?",!,?7,"1. Individual work order(s), or",!,?7,"2. An entire PM work list."
 R !,"Select 1 or 2: ",X:DTIME Q:X="^"!(X="")  G:X["?" DELH1 I X?1N,X>0,X<3 G:X=1 DEL1 G DEL2
 W "??",*7 G DEL
 ;
DEL1 ;  delete individual work orders
 S DIC="^ENG(6920,",DIC(0)="AEQM",DIC("A")="Please enter first work order to be deleted ",DIC("S")="I $E($P(^(0),U,1),1,3)=""PM-""" D ^DIC K DIC("S") G:Y'>0 OUT S DA=+Y,ENPMWO=$P(^ENG(6920,DA,0),U,1)
 W !,ENPMWO,"   Are you sure" S %=1 D YN^DICN G:%'=1 DEL1 S DIK="^ENG(6920," D:$E(^ENG(6920,DA,0),1,3)="PM-" ^DIK
DEL10 S ENPMWO(1)=$O(^ENG(6920,"B",ENPMWO)) G:$P(ENPMWO(1),"-",2)'=$P(ENPMWO,"-",2) OUT
DEL11 W !!,"Next work order: ",ENPMWO(1),"// " R X:DTIME G:X="^" OUT I X?1.3N S X=$S($L(X)=1:"00"_X,$L(X)=2:"0"_X,1:X),X=$P(ENPMWO,"-",1,2)_"-"_X
 I X="" S X=ENPMWO(1)
 I $E(X,1,3)'="PM-" D DELH0 G DEL11
 S ENPMWO=X,DIC(0)="X",DIC("S")="I $E($P(^(0),U,1),1,3)=""PM-""" D ^DIC K DIC("S") S DA=+Y I Y'>0 W "??",*7 D DELH0 G DEL11
 W !,ENPMWO,"   Are you sure" S %=1 D YN^DICN G:%'=1 DEL10 S DIK="^ENG(6920," D:$E(^ENG(6920,DA,0),1,3)="PM-" ^DIK
 G DEL10
 ;
DEL2 ;  delete an entire work list
 S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC Q:Y'>0  S ENSHKEY=+Y,ENSHABR=$P(^DIC(6922,ENSHKEY,0),U,2),ENSHOP=$P(^(0),U,1)
 S Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="Select Month: ",%DT("B")=Y,%DT="AEFMX" D ^%DT G:Y'>0 OUT S ENPMDT=$E(Y,2,5),ENPMMN=+$E(Y,4,5),ENPMYR=1700+$E(Y,1,3)
DEL20 R !,"MONTHLY or WEEKLY PM list: MONTHLY// ",X:DTIME G:X="^" OUT S ENPM=$S(X="":"M",$E(X)="M":"M",$E(X)="W":"W",1:"") G:ENPM="M" DEL22 I ENPM']"" D RCOH1^ENEQPMR2 G DEL20
DEL21 R !,"Which week? ",X:DTIME G:X="^" OUT I X'?1N D DELH2 G DEL21
 I X<1!(X>5) D DELH2 G DEL21
 S ENPMWK=X,ENPM=ENPM_ENPMWK
DEL22 W @IOF,!!
 W "This option will delete the entire "_$S(ENPM="M":"MONTHLY",ENPM["W":"WEEKLY",1:"")_" PM List of the "_ENSHOP,!,"Shop for "_$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER",U,ENPMMN)
 W ", "_ENPMYR_$S(ENPM["W":" (Week "_ENPMWK_")",1:"")_"."
 W !!,"Just a moment, please..."
 S I=0,ENPMWO("P")="PM-"_ENSHABR_ENPMDT_ENPM_"-",ENPMWO=ENPMWO("P") F I=0:1 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO']""!($P(ENPMWO,"-",2)'=$P(ENPMWO("P"),"-",2))
 W !!,"There are ",I," PM work orders on this list. Deletion of these work orders will",!,"not affect equipment histories. Are you sure you want to proceed" S %=1 D YN^DICN
 I %'=1 W !,"Nothing deleted.",*7 D MSG G OUT
 S ENLOCK=ENPMWO("P") L +^ENG("PMLIST",ENPMWO("P")):1 I '$T W !!,"Sorry, another user is processing worklist. Please try again later.",*7 K ENLOCK G OUT
 S ZTRTN="DELDQ^ENEQPMS4",ZTSAVE("EN*")="",ZTDESC="Delete PMI List",ZTIO="" D ^%ZTLOAD K ZTSK D HOME^%ZIS G OUT
DELDQ L +^ENG("PMLIST",ENLOCK):1
 I $T S ENPMWO=ENPMWO("P"),DIK="^ENG(6920," F I=0:0 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) Q:ENPMWO']""!($P(ENPMWO,"-",2)'=$P(ENPMWO("P"),"-",2))  S DA=$O(^ENG(6920,"B",ENPMWO,0)) I DA]"",$D(^ENG(6920,DA,0)),$E(^(0),1,3)="PM-" D ^DIK
OUT I $D(ENLOCK) L -^ENG("PMLIST",ENLOCK) K ENLOCK
 K ENPMWO,ENINN,ENWON,ENPM,ENPMDT,ENPMMN,ENPMWK,ENSHKEY,ENSHOP,ENSHABR,I,DIC,DIK,DA,ENPMYR
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
MSG R !,"Press <RETURN> to continue...",X:DTIME Q
DELH0 W !,"Entry must be an existing PM work order, beginning with 'PM-', or the",!,"sequential (numeric) portion thereof. Enter '^' to exit." Q
DELH1 W !,"Enter '1' to delete individual PM work orders or '2' to delete a specific",!,"worklist (MONTHLY or WEEKLY) for an entire shop."
 W !,"Deletion of PM work orders which have been closed out does NOT remove them",!,"from the equipment history."
 G DEL
DELH2 W !,"Please enter an integer from 1 to 5."
 Q
 ;ENEQPMS4
