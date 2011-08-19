ABSVTED1 ;VAMC ALTOONA/CTB_CLH - TIME CARD EDIT ;8/3/98  9:30 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**10**;JULY 6, 1994
OUT K %,%DT,%W,%X,%Y,%1,ABSVX("CREATE"),C,COMB,D,D0,DA,DA1,DI,DIC,DIE,DIK,DQ,DR,DUOUT,MONTH,NN,NAME,ORG,SER,VOL,TC,TC1,TC2,TC3,X,X1,Y
 Q
CREATE ;CREATE SINGLE TIME CARD
 N %,%DT,%W,%X,%Y,%Y1,C,COMB,D,D0,DA,DA1,DI,DIC,DIE,DIK,DQ,DR,MONTH,NN,NAME,ORG,SER,VOL,TC,TC1,TC2,TC3,X,X1,Y
 D ^ABSVSITE G:'% OUT
C F  S DIC=503330,DIC("A")="Select VOLUNTEER: ",DIC(0)="AEMQZ" D MDIV^ABSVSITE,^DIC G:+Y<0 OUT  Q:$$ACTIVE^ABSVU2(+Y,ABSV("INST"))
 K DIC S ABSVX("VOLDA")=+Y,DA=+Y,NAME=$P(Y(0),"^"),%DT="AEP",%DT("A")="Select MONTH/YEAR: " D ^%DT G:+Y<0 OUT S MONTH=$E(Y,1,5)_"00"
 D PC1^ABSVE2,SEL1^ABSVE2 K ABSVX("LIST") I Y="" S X="<No Selection Made, Option Terminated>*" D MSG^ABSVQ K ABSVOUT G OUT
 S X=^ABS(503330,DA,1,$P(Y,"^",2),0)
 S COMB=$P(X,"^",5),ORG=$P(X,"^",2),SER=$P(X,"^",4) D WAIT^ABSVYN
 S DIC=503335,DLAYGO=503335,X=NAME,DIC(0)="LM",DIC("S")="S ZZX=^(0) I $P(ZZX,U,5)=MONTH,$P(ZZX,U,12)=ABSV(""SITE""),$P(ZZX,U,2)=COMB" D ^DIC K DIC,ZZX S DA=+Y,VOL=$P(Y,"^",2)
 I $P(Y,"^",3)'=1 G DMSG
C1 S DIE="^ABS(503335,",DR="[ABSV CREATE]" D ^DIE K DIE
 S ABSVXA="Do you want to edit this time card now",ABSVXB="",%=1 D ^ABSVYN I %=1 S ABSVX("CREATE")=1 D TC1^ABSVTED
 S ABSVXA="Is this Time Card ready for Transmission",ABSVXB="",%=1 D ^ABSVYN
 S X=$S(%=1:1,1:0) D STATUS^ABSVU
 S ABSVXA="Do you wish to create another Time Card",ABSVXB="",%=1 D ^ABSVYN G OUT:%'=1 G C
MERGE ;MERGE TIME CARDS
 D ^ABSVSITE G:'% OUT
 S %DT="AEP",%DT("A")="Select MONTH/YEAR: " D ^%DT G:+Y<0 OUT S MONTH=$E(Y,1,5)_"00"
 S DIC=503330,DIC(0)="AEMQZ",DIC("A")="Select VOLUNTEER: ",DIC("S")="I $D(^ABS(503330,+Y,4,ABSV(""INST""),0))"
 D MDIV^ABSVSITE,^DIC S DA=+Y K DIC G:+Y<0 OUT
 S NAME=Y(0,0)
 W !!,"First, select the primary time card. (The one which will remain!)"
 S DIC=503335,DIC(0)="EMQ",X=NAME,DIC("S")="S ZZX=^(0) I $P(ZZX,U,5)=MONTH,$P(ZZX,U,6)<3,$P(ZZX,U,12)=ABSV(""SITE"")" D ^DIC K ZZX S DA=+Y K DIC G:+Y<0 OUT S TC1=$G(^ABS(503335,DA,1))
 W !!,"Select time card to merge and delete: ",!! S DIC=503335,X=NAME,DIC(0)="EMQ",DIC("S")="I $P(^(0),U,5)=MONTH,$P(^(0),U,6)<3,+Y'=DA" D ^DIC S DA1=+Y
 I DA1<0 W !!,*7,"Only one time card exists this time period.",!,"No further action can be taken.",!! G MERGE
 S ABSVXA="I will now merge the two time cards and delete the second entry.",ABSVXA(1)="Are you sure you want to do this",ABSVXB="",%=2 D ^ABSVYN G:%'=1 OUT
 S ABSVXA="ARE YOU SURE",ABSVXB="",%=1 D ^ABSVYN G:%'=1 OUT
 S X="While I merge the two entries..." D WAIT^ABSVYN
 S TC3="",TC2=$G(^ABS(503335,DA1,1)) F I=1:1:32 S X=$P(TC1,"^",I)+$P(TC2,"^",I) S:X=0 X="" S $P(TC3,"^",I)=X
 S $P(^ABS(503335,DA,1),"^",1,32)=TC3 S DIK="^ABS(503335,",DA=DA1 D ^DIK G OUT
 ;
GET ;GET ORG AND TRANSFER ENTRIES
 S DIC=503334,DIC(0)="AEMNQ" D ^DIC Q:Y<0
 I '$D(^ABS(503335,"AD",+Y)) W !,"THERE ARE NO ENTRIES IN THE TIME CARD FILE FOR THIS ORGANIZATION",*7 G GET
 S DA=+Y D WAIT^ABSVYN S N=0 F I=1:1 S N=$O(^ABS(503335,"AD",DA,N)) Q:'N  S ^ABS(503335,"AG",1,N)=""
 S DIC("A")="Select Next ORGANIZATION: " G GET
 ;
ENAME ;EDIT NAME IN MASTER FILE
 NEW %,%W,%Y,%X,ABSVX,C,D0,DA,DI,DIC,DIE,DIG,DIH,DIU,DIV,DIW,DQ,DR,DUOUT,I,N,X,Y
 D ^ABSVSITE Q:'%
E1 S DIC=503330,DIC(0)="AEMNQ" S:'$D(DIC("A")) DIC("A")="Select VOLUNTEER: " S DIC("S")="I $D(^ABS(503330,+Y,4,ABSV(""INST""),0))"
 F  D MDIV^ABSVSITE,^DIC Q:+Y<0  Q:$$ACTIVE^ABSVU2(+Y,ABSV("INST"))
 K DIC Q:+Y<0
 S DA=+Y,ABSVX("VOLDA")=DA,ABSVX("NAME")=$P(Y,"^",2)
 D MORE
 S DIE="^ABS(503330,",DR=".01" D ^DIE K DIE
 I $P(^ABS(503330,DA,0),"^",1)'=ABSVX("NAME") S EDIT="" D TT88^ABSVE3
 S DIC("A")="Select Next VOLUNTEER: " G E1
 ;
DMSG S X="-- TIME CARD ALREADY EXISTS FOR THIS VOLUNTEER. --*" D MSG^ABSVQ S ABSVXA="Are you sure you want to create another time card",ABSVXB="",%=2 D ^ABSVYN G:%'=1 C
 W ! S ABSVXA="  You may create duplicate entries",ABSVXA(1)="ARE YOU SURE YOU WANT CONTINUE",ABSVXB="",%=2 D ^ABSVYN G:%'=1 C
 G C1
MORE I $P(^ABS(503330,DA,4,0),"^",4)>1 S X="This volunteer is registered at more than one station.  REMEMBER to coordinate changes with the other station(s).*" D MSG^ABSVQ
 Q
