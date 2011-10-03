ECTPTL ;B'ham ISC/PTD-Identify T&L Units for Station's Services ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$O(^ECC(730,"ALS",0)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"Local services have not been identified!",!,"Use the 'Identify Station's Services' option.",!! S XQUIT="" Q
 ;SELECT ENTER/EDIT CHOICE
CHS W !!,"At this time, you may:",!!,"1.  List All T&L Units",!,"2.  Print Local Services Worksheet",!,"3.  Enter/Edit T&L Units for Services",!,"4.  Display Identified T&L by Service",!,"5.  Edit a Single Service",!!,"Select a number (1 - 5): "
 R CHS:DTIME G:'$T!("^"[CHS) EXIT I CHS'?1N!(CHS<1)!(CHS>5) W !!,*7,"You MUST answer with a number between 1 and 5." G CHS
 ;BRANCH BASED ON ENTER/EDIT CHOICE
 I CHS=1 D DIP G EXIT
 I (CHS=2)!(CHS=4) D DIP2 G EXIT
 I CHS=5 D DIC G EXIT
LOC ;IF CHS=3, FOR EACH 'LOCAL' SERVICE, ASK ASSOCIATED T&L UNITS
 S RESP="" F SRDA=0:0 S SRDA=$O(^ECC(730,"ALS",SRDA)) Q:'SRDA!(RESP="^")  S SRNM=$P(^ECC(730,SRDA,0),"^") S (DIC,DIE)="^ECC(730,",DIC(0)="M",X=SRNM D ^DIC K DIC S DA=+Y W !!,SRNM S DR="10,.01" D ^DIE K DIE I $D(Y) S RESP="^"
EXIT K %,%X,%Y,BY,C,CHS,DA,DHD,DIC,DIE,DIS,DLAYGO,DR,FLDS,FR,I,L,P,RESP,SRDA,SRNM,TO,X,Y
 Q
 ;
DIP S DIC="^PRST(455.5,",L=0,BY="1",(FR,TO)="" S FLDS="1;""DESCRIPTION"",.01;C25;""T&L UNIT""",DHD="T&L UNIT LISTING"
 D EN1^DIP
 Q
 ;
DIP2 S DIC="^ECC(730,",L=0,DIS(0)="I $D(^ECC(730,""ALS"",D0))",BY=".01",(FR,TO)="",DHD=$S(CHS=2:"WORKSHEET FOR IDENTIFYING T&L UNITS FOR LOCAL SERVICES",1:"T&L UNITS IDENTIFIED FOR LOCAL SERVICES")
 S FLDS=$S(CHS=2:".01;S2;L80;""LOCAL SERVICE....................ASSOCIATED T&L UNITS""",1:".01;T;S,10,.01;C40;""T&L UNIT"",.01:1;""T&L DESCRIPTION""")
 D EN1^DIP
 Q
 ;
DIC W ! S (DIC,DIE)="^ECC(730,",DIC(0)="QEAM",DIC("A")="Select SERVICE: ",DIC("S")="I $D(^ECC(730,""ALS"",+Y))" D ^DIC Q:Y<0  S DA=+Y,DR="10,.01" D ^DIE K DIE
 Q
 ;
