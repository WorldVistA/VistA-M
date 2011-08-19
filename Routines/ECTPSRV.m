ECTPSRV ;B'ham ISC/PTD-Identify Local Services from National File ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**3**;
 ;SELECT ENTER/EDIT CHOICE
CHS W !!,"At this time, you may:",!!,"1.  Enter/Edit Station's Services",!,"2.  List 'National' Services",!,"3.  List Identified Local Services",!,"4.  Edit a Single Service"
 W !,"5.  Add OPC to National Service File",!!,"Select a number (1 - 5): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>5) W !!,*7,"You MUST answer with a number between 1 and 5." G CHS
 ;BRANCH BASED ON ENTER/EDIT CHOICE
 I (CHS=2)!(CHS=3) D DIP G EXIT
 I CHS=4 D DIC G EXIT
 I CHS=5 D OPC G EXIT
LOC W !!,"If your station has the following SERVICE,",!,"respond with a ""Y"".  If you DO NOT HAVE the service,",!,"respond with a ""N"" or press <RETURN>.",!!
 S RESP="" F SRDA=0:0 S SRDA=$O(^ECC(730,SRDA)) Q:'SRDA!(RESP="^")  S SRNM=$P(^ECC(730,SRDA,0),"^") D LOOP
EXIT K %,%Y,BY,CHS,D,D0,DA,DHD,DIC,DIE,DIR,DR,DTOUT,DUOUT,FLDS,FR,I,L,OPC,P,RESP,SRDA,SRNM,TO,X,Y
 Q
 ;
DIP S DIC="^ECC(730,",L=0,BY=".01",(FR,TO)="" S FLDS=$S(CHS=3:".01;""NATIONAL SERVICE"",2",1:".01,1"),DHD=$S(CHS=3:"LOCAL SERVICE LIST",1:"NATIONAL SERVICE LIST")
 D EN1^DIP
 Q
 ;
LOOP S (DIC,DIE)="^ECC(730,",DIC(0)="M",X=SRNM D ^DIC K DIC S DA=+Y W !!,SRNM S DR="2" D ^DIE K DIE I $D(Y) S RESP="^"
 Q
 ;
DIC S (DIC,DIE)="^ECC(730,",DIC(0)="QEAM",DIC("A")="Select NATIONAL service: " D ^DIC Q:Y<0  S DA=+Y,DR="2" D ^DIE K DIE
 Q
 ;
OPC W *7,!!?30,"* * W A R N I N G * *",!?20,"Use this functionality with caution!",!?20,"Add the Outpatient Clinic names for which",!?20,"you wish to track management data."
 W ! S DIR(0)="Y",DIR("A")="Are you SURE you wish to continue",DIR("B")="NO",DIR("?")="Enter 'Y' or 'YES' to continue; press <RETURN> to exit." D ^DIR
 Q:$D(DTOUT)  Q:$D(DUOUT)  Q:Y=0
 W !!,"Name must be 3-35 characters in length,",!,"must not begin with punctuation,",!,"and must be all upper case."
ASK K OPC R !!,"Enter OUTPATIENT CLINIC name: ",OPC:DTIME Q:'$T!("^"[OPC)  I $L(OPC)>35!($L(OPC)<3)!'(OPC'?1P.E)!(OPC?.E1L.E) W *7,!,"Answer must be 3-35 upper case characters; not beginning with punctuation." G ASK
 I $D(^ECC(730,"B",OPC)) W *7,!!,OPC," is already in the file!" G ASK
 W !!,"This is the ONLY opportunity you will be given to verify the name.",!,"Please check for correct spelling and accuracy.",!!,"OUTPATIENT CLINIC name: ",OPC,!
 S DIR(0)="Y",DIR("A")="Are you SURE name is correct",DIR("B")="NO",DIR("?")="Enter 'Y' or 'YES' if name is correct; press <RETURN> to re-enter name." D ^DIR
 Q:$D(DTOUT)  Q:$D(DUOUT)  G:Y=0 ASK
 L ^ECC(730) F I=1000:1 Q:'$D(^ECC(730,I,0))
 S ^ECC(730,I,0)=OPC_"^^1",^ECC(730,"B",($E(OPC,1,30)),I)="",$P(^ECC(730,0),"^",3)=I,$P(^ECC(730,0),"^",4)=$P(^ECC(730,0),"^",4)+1,^ECC(730,"ALS",I)="" L
 W *7,!!,OPC," has been ADDED to National Service File!",!! G ASK
