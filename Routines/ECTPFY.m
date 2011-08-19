ECTPFY ;B'ham ISC/PTD-Enter/Edit Staffing Data for Fiscal Year ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$O(^ECC(730,"ALS",0)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"Local services have not been identified!",!,"Use the 'Identify Station's Services' option.",!! S XQUIT="" Q
 S CNT=-1 F J=0:0 S J=$O(^ECC(730,"ALS",J)) S CNT=CNT+1 Q:'J
 I CNT<8 W *7,!!?25,"WARNING",!,"You have only ",CNT," services defined for your station!",!,"Use the 'Identify Station's Services' option to verify before you continue."
 ;
CHS W !!,"At this time, you may:",!!,"1.  Enter data for a new fiscal year",!,"2.  Edit existing data for a previously entered fiscal year",!,"3.  Delete a fiscal year entered in error",!!,"Choose a number (1 - 3): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>3) W !!,*7,"You MUST answer with a number between 1 and 3." G CHS
 ;BRANCH BASED ON ENTER/EDIT CHOICE
 I CHS=2 D EDIT G EXIT
 I CHS=3 D DIK G EXIT
ENTER ;IF CHOICE 1 WAS SELECTED, CREATE NEW ENTRY WITH ASSOCIATED SERVICES
YR W ! S %DT="AE",%DT("A")="Enter two digit code for Fiscal Year: ",%DT(0)=2700000 D ^%DT G:$D(DTOUT)!("^"[X) EXIT S YRDA=$E(Y,1,3),YR=$E(Y,2,3)
 I $D(^ECT(731,YRDA,10)) S DA=YRDA W !!,"This is an EXISTING entry.  You may edit if you wish.",!! D DIE G EXIT
DIC S (DIC,DIE)="^ECT(731,",DIC(0)="LM",X=YR,DLAYGO=731 D ^DIC K DIC G:Y<0 EXIT S DA=+Y,DR="1" D ^DIE K DIE
 I '$D(^ECT(731,YRDA,10,0)) S $P(^ECT(731,YRDA,10,0),"^",2)="731.01PA"
 S RESP="" F SRV=0:0 S SRV=$O(^ECC(730,"ALS",SRV)) Q:'SRV!(RESP="^")  S SRVNM=$P(^ECC(730,SRV,0),"^") D LOOP
EXIT K %,%DT,%X,%Y,CHS,CNT,DA,DIC,DIE,DIK,DLAYGO,DR,DTOUT,DUOUT,I,J,RESP,SRV,SRVNM,X,Y,YR,YRDA
 Q
 ;
EDIT I '$O(^ECT(731,0)) W *7,!!,"File contains NO fiscal year data." Q
 W ! S DIC="^ECT(731,",DIC(0)="QEAM",DIC("A")="Select Fiscal Year: " D ^DIC Q:Y<0  S DA=+Y K DIC
DIE S DIE="^ECT(731,",DR="1:10" D ^DIE K DIE
 Q
 ;
DIK I '$O(^ECT(731,0)) W *7,!!,"File contains NO fiscal year data." Q
 W ! S (DIC,DIK)="^ECT(731,",DIC(0)="QEAM",DIC("A")="Select Fiscal Year to DELETE: " D ^DIC K DIC Q:Y<0  S DA=+Y
 S DIR(0)="Y",DIR("A")="Are you SURE you want to DELETE",DIR("B")="NO",DIR("?")="Enter 'Y' to delete the entry, 'N' or <RETURN> to exit." D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)  I Y=1 D ^DIK K DIK
 Q
 ;
LOOP S (DIC,DIE)="^ECT(731,"_YRDA_",10,",DIC(0)="LM",X=SRVNM,DA(1)=YRDA D ^DIC K DIC S DA=+Y W !!,"Service: ",SRVNM,! S DR="1" D ^DIE K DIE I $D(Y) S RESP="^"
 Q
 ;
