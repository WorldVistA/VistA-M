ECTFCON ;B'ham ISC/PTD-Enter/Edit Contract Data for Fiscal Year ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$O(^ECC(730,"ALS",0)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"Local services have not been identified!",!,"Use the 'Identify Station's Services' option.",!! S XQUIT="" Q
 ;
YR W ! S %DT="AE",%DT("A")="Enter two digit code for Fiscal Year: ",%DT(0)=2700000 D ^%DT G:$D(DTOUT)!("^"[X) EXIT S YRDA=$E(Y,1,3),YR=$E(Y,2,3)
 I $D(^ECT(731,YRDA)) G CONTR
DIC S DIC="^ECT(731,",DIC(0)="LM",X=YR,DLAYGO=731 D ^DIC K DIC G:Y<0 EXIT S YRDA=+Y
CONTR I '$D(^ECT(731,YRDA,20,0)) S $P(^ECT(731,YRDA,20,0),"^",2)="731.02A"
 W ! S (DIC,DIE)="^ECT(731,"_YRDA_",20,",DIC(0)="QEALM",DA(1)=YRDA,DIC("A")="Enter CONTRACT number: ",DIC("W")="I $P(^ECT(731,YRDA,20,Y,0),U,2)'="""" W ""    "",$P(^(0),U,2)" D ^DIC K DIC G:Y<0 EXIT S DA=+Y
 S DR=".01:5" D ^DIE K DIE G CONTR
EXIT K %,%DT,%Y,DA,DIC,DIE,DLAYGO,DR,DTOUT,X,Y,YR,YRDA
 Q
 ;
