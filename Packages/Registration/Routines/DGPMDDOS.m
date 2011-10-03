DGPMDDOS ;ALB/MIR - OUT-OF-SERVICE BEDS/WARDS ; 29 MAY 90 @1400
 ;;5.3;Registration;**161**;Aug 13, 1993
 ;called from DDs of files 42 and 405.4 in the out-of-service multiples
 ;and computed out-of-service fields
 ;FOR WARDS
WOOS ;no if before last return to service or next out of service or if last out-of service was not returned to service or after return to service
 I '$D(DGNEW) W !,"Must use supervisor options to place ward out-of-service!" G NOPE
 S DGX=$O(^DIC(42,DA(1),"OOS","AINV",9999998.9-X)),DGX=$O(^(+DGX,0)) I $S(DGNEW:1,DGX=DA:0,1:1),$D(^DIC(42,DA(1),"OOS",+DGX,0)) S DGX=^(0) G:'$P(DGX,"^",4) WOUT I $P(DGX,"^",4)>X W !,*7,"Not before last return to service date" G NOPE
 S DGX=$O(^DIC(42,DA(1),"OOS","B",X)) I DGX,DGNEW W !,"Not before last out-of-service episode" G NOPE
 I 'DGNEW,$D(^DIC(42,DA(1),"OOS",DA,0)),$P(^(0),"^",4),(X>$P(^(0),"^",4)) W !,*7,"Not after return to service date" G NOPE
 I $D(^DGPM("CN",$P(^DIC(42,DA(1),0),"^",1))) W !,*7,"  WARNING...there are patients on this ward"
 K DGX Q
WRTS ;can't be after next out-of-service or before present out-of-service
 S DGX=$S($D(^DIC(42,DA(1),"OOS",DA,0)):^(0),1:"") I X<DGX W !,*7,"Must be after out-of-service date" G NOPE
 I DGX S DGX=$O(^DIC(42,DA(1),"OOS","B",+DGX)) I X>DGX,DGX W !,*7,"Not after next out-of-service date" G NOPE
 K DGX Q
WOUT W !,"Ward was already placed out of service on ",$$FMTE^XLFDT(DGX,"5DZ")
NOPE K X,DGX Q
 ;
 ;
 ;ROOM-BEDS
ROOS ;no if before last return to service or next out of service or if last out-of service was not returned to service
 I '$D(DGNEW) W !,"Must use supervisor options to place room-bed out-of-service!" G NOPE
 S DGX=$O(^DG(405.4,DA(1),"I","AINV",9999998.9-X)),DGX=$O(^(+DGX,0)) I $S(DGNEW:1,DGX=DA:0,1:1),$D(^DG(405.4,DA(1),"I",+DGX,0)) S DGX=^(0) G:'$P(DGX,"^",4) WOUT I $P(DGX,"^",4)>X W !,*7,"Not before last return to service date" G NOPE
 S DGX=$O(^DG(405.4,DA(1),"I","B",X)) I DGX,DGNEW W !,"Not before last out-of-service episode" G NOPE
 I 'DGNEW,$D(^DG(405.4,DA(1),"I",DA,0)),$P(^(0),"^",4),(X>$P(^(0),"^",4)) W !,*7,"Not after return to service date"
 I $D(^DGPM("ARM",DA(1))) W !,*7,"  WARNING...there is a patient occupying this bed"
 K DGX Q
RRTS ;can't be after next out-of-service or before present out-of-service
 S DGX=$S($D(^DG(405.4,DA(1),"I",DA,0)):^(0),1:"") I X<DGX W !,*7,"Must be after out-of-service date" G NOPE
 I DGX S DGX=$O(^DG(405.4,DA(1),"I","B",+DGX)) I X>DGX,DGX W !,*7,"Not after next out-of-service date" G NOPE
 K DGX Q
ROUT W !,"Room-bed was already placed out of service on ",$$FMTE^XLFDT(DGX,"5DZ"),"." G NOPE
 ;
 ;
WARD ;called from ward out-of-service option
 D Q S DIC="^DIC(42,",DIC(0)="AEQM" D ^DIC S DA(1)=+Y G Q:Y'>0
 S DGNEW=1,DIC="^DIC(42,"_DA(1)_",""OOS"",",DIC(0)="AELQM",DA(1)=DA(1),DLAYGO=42.08 S:'$D(^DIC(42,DA(1),"OOS",0)) ^(0)="^42.08D^^" D ^DIC S DA=+Y I Y<0 D Q Q
 S DGNEW=0,DIE=DIC,DIE("NO^")="",DR=".01:.04;.06;S Y=$S(X:.07,1:.11);.11;S Y="""";.07" D ^DIE
 I $D(DA),$D(^DIC(42,DA(1),"OOS",DA,0)) S X=^(0) I '$P(^(0),"^",2) W !,*7,"Incomplete entry...deleted" S DIK=DIE D ^DIK D Q Q
 G WARD
Q K DA,DGIFN,DGNEW,DIC,DIE,DLAYGO,DR,X,Y Q
BED ;called from bed out-of-service option
 W !!,"This option is used to inactivate a bed for bed availability purposes only.",!,"If you want this bed to also show as statistically out-of-service on the",!,"G&L, you must also utilize the 'Edit Ward Out-of-Service Dates' option and"
 W !,"enter the current number of beds out-of-service for the ward you wish."
BEDSEL W !!
 D Q S DIC="^DG(405.4,",DIC(0)="AEQM" D ^DIC S (DGIFN,DA(1))=+Y G Q:Y'>0
 S DGNEW=1,DIC="^DG(405.4,"_DA(1)_",""I"",",DIC(0)="AELQM",DA(1)=DA(1),DLAYGO=405.42 S:'$D(^DG(405.4,DA(1),"I",0)) ^(0)="^405.42ID^^" D ^DIC S DA=+Y I Y<0 D Q Q
 S DGNEW=0,DIE=DIC,DIE("NO^")="",DR=".01:.04" D ^DIE
 I $D(DA),$D(^DG(405.4,DA(1),"I",DA,0)) S X=^(0) I '$P(^(0),"^",2) W !,*7,"Incomplete entry...deleted" S DIK=DIE D ^DIK D Q Q
 G BEDSEL
