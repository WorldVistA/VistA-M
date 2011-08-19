ECTPP ;B'ham ISC/PTD-Enter/Edit Staffing Data for Pay Period ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$O(^ECC(730,"ALS",0)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"Local services have not been identified!",!,"Use the 'Identify Station's Services' option.",!! S XQUIT="" Q
 S CNT=-1 F J=0:0 S J=$O(^ECC(730,"ALS",J)) S CNT=CNT+1 Q:'J
 I CNT<8 W *7,!!?25,"WARNING",!,"You have only ",CNT," services defined for your station!",!,"Use the 'Identify Station's Services' option to verify before you continue."
 ;
CHS W !!,"At this time, you may:",!!,"1.  Enter data for a new pay period",!,"2.  Edit existing data for a previously entered pay period",!,"3.  Delete a pay period entered in error",!!,"Choose a number (1 - 3): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>3) W !!,*7,"You MUST answer with a number between 1 and 3." G CHS
 ;BRANCH BASED ON ENTER/EDIT CHOICE
 I CHS=2 D EDIT G EXIT
 I CHS=3 D DIK G EXIT
ENTER ;IF CHOICE 1 WAS SELECTED, CREATE NEW ENTRY WITH ASSOCIATED SERVICES
PP R !!,"Enter Pay Period: ",PP:DTIME G:'$T!("^"[PP) EXIT I (PP'?.N)!(PP<1)!(PP>27) W !!,*7,"You MUST answer with a number between 1 and 27." G PP
 S:$L(PP)=1 PP="0"_PP
YR W ! S %DT="AE",%DT("A")="Enter calendar year associated with this pay period: ",%DT(0)=2000000 D ^%DT G:$D(DTOUT)!("^"[X) EXIT S YR=$E(Y,1,3),YRPP=YR_PP
 W ! S DIR(0)="Y",DIR("A")="Is this correct ==> Year: "_(1700+YR)_" Pay Period: "_PP,DIR("B")="YES",DIR("?")="Enter 'Y' if this is correct, 'N' or <RETURN> to exit." D ^DIR
 G:$D(DTOUT)!$D(DUOUT)!(Y=0) EXIT
 I $D(^ECT(731.7,YRPP)) S DA=YRPP W !!,"This is an EXISTING entry.  You may edit if you wish.",!! D DIE G EXIT
DIC S (DIC,DIE)="^ECT(731.7,",DIC(0)="LM",X=YRPP,DLAYGO=731.7 D ^DIC K DIC G:Y<0 EXIT S DA=+Y,DR="1" D ^DIE K DIE
 I '$D(^ECT(731.7,YRPP,1,0)) S $P(^ECT(731.7,YRPP,1,0),"^",2)="731.701PA"
 S RESP="" F SRV=0:0 S SRV=$O(^ECC(730,"ALS",SRV)) Q:'SRV!(RESP="^")  S SRVNM=$P(^ECC(730,SRV,0),"^") D LOOP
EXIT K %,%DT,%X,%Y,C,CHS,CNT,D,DA,DIC,DIE,DIK,DIR,DLAYGO,DR,DTOUT,DUOUT,I,J,PP,RESP,SRV,SRVNM,X,Y,YR,YRPP
 Q
 ;
EDIT I '$O(^ECT(731.7,0)) W *7,!!,"File contains NO pay period data." Q
 W ! S DIC="^ECT(731.7,",DIC(0)="QEAM",DIC("A")="Select CODE for Pay Period: " D ^DIC Q:Y<0  S DA=+Y K DIC
DIE S DIE="^ECT(731.7,",DR="1:10" D ^DIE K DIE
 Q
 ;
DIK I '$O(^ECT(731.7,0)) W *7,!!,"File contains NO pay period data." Q
 W ! S (DIC,DIK)="^ECT(731.7,",DIC(0)="QEAM",DIC("A")="Select CODE for Pay Period to DELETE: " D ^DIC K DIC Q:Y<0  S DA=+Y
 S DIR(0)="Y",DIR("A")="Are you SURE you want to DELETE",DIR("B")="NO",DIR("?")="Enter 'Y' to delete the entry, 'N' or <RETURN> to exit." D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)  I Y=1 D ^DIK K DIK
 Q
 ;
LOOP S (DIC,DIE)="^ECT(731.7,"_YRPP_",1,",DIC(0)="LM",X=SRVNM,DA(1)=YRPP D ^DIC K DIC S DA=+Y W !!,"Service: ",SRVNM,! S DR="1;2;3T" D ^DIE K DIE I $D(Y) S RESP="^"
 Q
 ;
