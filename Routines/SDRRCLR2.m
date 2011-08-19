SDRRCLR2 ;10N20/MAH- Recall Reminder ENTER EDIT 9/28/04
 ;;5.3;Scheduling;**536,561**;Aug 13, 1993;Build 7
 ;;THIS ROUTINE WILL USE OPTION SDRR CARD ADD
STR ;Start checking entries in 403.5 if there is a "b" goes to update - if not goes to NEW   
 N I,Y,CLINIC,C,D,KY,COMM
 K ^TMP("SDRRCLR")
 D ^DPTLK Q:Y<1
 S DFN=+Y
 I '$D(^SD(403.5,"B",DFN)) W !,"No Clinic Recall on file",! G NEW
EN1 S C=0 F I=0:0 S I=$O(^SD(403.5,"B",DFN,I)) Q:'I  I $D(^SD(403.5,I,0)) S D=^(0),C=C+1 S ^TMP("SDRRCLR",$J,C)=I_"^"_D
 S (ER,OK)=0 W !,"CHOOSE FROM:" F I=0:0 S I=$O(^TMP("SDRRCLR",$J,I)) Q:'I   S CLINIC=$P($G(^TMP("SDRRCLR",$J,I)),"^",3) D
 .W !,$J(I,4),">  "
 .I CLINIC'="" S CLINIC=$$GET1^DIQ(44,CLINIC_",",.01)
 .I CLINIC="" S CLINIC="UNK. CLINIC"
 .S PROV=$P($G(^TMP("SDRRCLR",$J,I)),"^",6) I PROV'="" S PROV=$P($G(^SD(403.54,PROV,0)),"^",1) I PROV'="" S PROV=$$NAME^XUSER(PROV,"F")
 .I PROV="" S PROV="UNK. PROVIDER"
 .S RDT=$P(^TMP("SDRRCLR",$J,I),"^",7) S Y=RDT D DD^%DT S RDT=Y
 .S RS=$P(^TMP("SDRRCLR",$J,I),"^",11) S Y=RS D DD^%DT S RS=Y
 .S COMM="",COMM=$P(^TMP("SDRRCLR",$J,I),"^",8)
 .W ?1,"CLINIC:"_$E(CLINIC,1,15),?28," R/DATE:"_RDT,?53," NOTICE SENT:"_RS
 .W !,?5,"PROVIDER:"_$E(PROV,1,20) S Z=I I $G(COMM)]"" W !,?5,$G(COMM) S Z=I
 W !,"CHOOSE 1-",Z_" OR TYPE ""A"" TO ADD:" W:$D(^TMP("SDRRCLR",$J,I+1)) !,"OR '^' TO QUIT" W ": " R X:DTIME I $S('$T!(X["^"):1,X="":1,1:0) S ER=1 G QUIT
 G QUIT:ER
 X ^%ZOSF("UPPERCASE") S X=Y  ;SD*561 convert lowercase to uppercase
 I X["A" G NEW
 S DA=$P($G(^TMP("SDRRCLR",$J,X)),"^",1) I DA="" K DA,C,CLINIC,PROV,RDT G EN1
 S (PROV1,KEY,FLAG)="" S PROV1=$P($G(^SD(403.5,DA,0)),"^",5) I PROV1'="" S KEY=$P($G(^SD(403.54,PROV1,0)),"^",7) D
 .I PROV1="" Q
 .I KEY="" Q
 .N VALUE
 .S VALUE=$$LKUP^XPDKEY(KEY) K KY D OWNSKEY^XUSRB(.KY,VALUE,DUZ)
 .I $P(KY(0),"^",1)=0 W !,?25,"**YOU DO NOT HAVE ACCESS TO THIS ENTRY**",!,?12,"PLEASE CHECK WITH YOUR ADPAC OR IRM TO GET THE PROPER SECURITY KEY" R X:3 K KEY,PROV1 D QUIT S FLAG=1
 .Q
 I FLAG=1 K FLAG Q
 ;END OF NEW CHANGE
 G UPDATE
 Q
 ;
 ;
NEW ;Adds new entry
 W !!,"*Must have Recall Date,approved Recall Clinic,Recall Provider and Type of Recall"
 S DIR(0)="Y",DIR("A")="Do you have this information",DIR("B")="NO" D ^DIR I Y'=1 G QUIT
 S (DIC,DIE)="^SD(403.5,",DIC(0)="LZ",X=DFN,DLAYGO=403.5 D FILE^DICN S NUM=+Y
 S DA=NUM,DR="[SDRR RECALL CARD ADD]",DIE("NO^")="Not Allowed" D ^DIE
 K DIC,DIE,DR,D0,DA,DLAYGO,NUM,PROV,X,Y,Z,OK,RDT,DIR
 Q
UPDATE ;Asks for new data
 K DIC,DIE,DR S DIE="^SD(403.5,",DR="[SDRR RECALL CARD ADD]",DIE("NO^")="BACKOUTOK" D ^DIE
 K DIC,DIE,DR,D0,DA,DLAYGO,NUM,PROV,X,Y,Z,OK,RDT
 D QUIT
 Q
QUIT K PROV,CLINIC,X,Y,C,D,ER,OK,DFN,FLAG,RS,KEY,KEYIFN,PROV1,PTN,RDT,DIR
 K ^TMP("SDRRCLR",$J)
 Q
