QAPFILE ;557/THM-POPULATE THE DEMOGRAPHIC REFERENCE FILE [ 06/19/95  11:59 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN I $D(DUZ)#2=0 W !!,*7,"Your DUZ is missing !   " H 2 G EXIT
 I '$D(DUZ(0)) W !!,*7,"Your DUZ(0) is missing !   " H 2 G EXIT
 ;
BEGIN W @IOF,! S QAPHDR="Populate the Demographic Reference File" X QAPBAR W !!
 I DUZ(0)'="@" W !!,*7,"Programmer access required for this program !   " H 2 G EXIT
 W !,"Enter DEMOGRAPHIC REFERENCE FILE NAME: "  R X:DTIME I X[U!(X="") G EXIT
 S DLAYGO=748.2,DIC="^QA(748.2,",DIC(0)="EQLMZ"
 I X["?" S IOTM=1,IOBM=24 W @TOPBOT,@IOF,! D ^DIC G:$D(DTOUT) EXIT W !!,"Press RETURN  " R ANS:DTIME G:'$T EXIT S IOTM=8,IOBM=24 W @TOPBOT G BEGIN
 D ^DIC G:X=""!(X[U) EXIT S DA=+Y I +Y<0 H 1 G EN
 I $P(Y,U,3)'=1 S DR=".01",DIE=DIC W !! D ^DIE G EN
 ;
EXIT G EXIT^QAPUTIL
 ;
SCREEN ;screen any user file selections on demographics
 ;they are not allowed to use files they have no normal access to
 S QAPY=Y,QAPY=+$P($G(^QA(748.2,+QAPY,0)),U,1)
 S PROTECT=$G(^DIC(+QAPY,0,"RD"))
 I DUZ(0)="@"!(DUZ(0)[PROTECT) ;set $T
 K PROTECT,DIC("S"),QAPY Q
