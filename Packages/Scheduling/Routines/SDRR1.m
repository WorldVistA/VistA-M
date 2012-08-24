SDRR1 ;10N20/MAH ;RECALL REMINDER ENTER EDIT 7/28/04
 ;;5.3;Scheduling;**536,561,566**;Aug 13, 1993;Build 5
EN ;Entry point
 ;Tag STR will determine if the patient has already been enter into open access
 ;This routine is SDRRCLR EVENT protocol which is put on to SDAM MENU
 ;protocol
 ;This routine does not kill off DFN
STR(SDFN) ;Start checking entries in 403.5 if there is a "b" goes to update - if not goes to NEW   
 N I,Y,CLINIC,C,D,KEY,KY,COMM
 S DFN=SDFN
 I '$D(^SD(403.5,"B",DFN)) W !,"No Clinic Recall on file",! S DIR(0)="Y",DIR("A")="Are you sure you want to add a Recall entry ",DIR("B")="NO" D ^DIR I Y'=1 G QUIT
 I $G(Y)>0 I '$D(^SD(403.5,"B",DFN)) G NEW
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
 .W "CLINIC:"_$E(CLINIC,1,15),?28," R/DATE:"_RDT,?53," NOTICE SENT:"_RS
 .W !,?5,"PROVIDER:"_$E(PROV,1,20) S Z=I I $G(COMM)]"" W !,?5,$G(COMM) S Z=I
 W !,"CHOOSE 1-",Z_" OR TYPE ""A"" TO ADD:" W:$D(^TMP("SDRRCLR",$J,I+1)) !,"OR '^' TO QUIT" W ": " R X:DTIME I $S('$T!(X["^"):1,X="":1,1:0) S ER=1 G QUIT
 ;CHECK PARAM IF NEEDED
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
NEW ;Adds new entry
 W !!,"*Must have Recall Date,approved Recall Clinic,Recall Provider and Type of Recall"
 S DIR(0)="Y",DIR("A")="Do you have this information",DIR("B")="NO" D ^DIR I Y'=1 G QUIT
 S (DIC,DIE)="^SD(403.5,",DIC(0)="LZ",X=DFN,DLAYGO=403.5 D FILE^DICN S NUM=+Y
 S DA=NUM,DR="[SDRR RECALL CARD ADD]",DIE("NO^")="Not Allowed" D ^DIE
 I $D(DTOUT) D DELETE  ;SD*566 if time out delete new incomplete record
 K DIC,DIE,DR,D0,DA,DLAYGO,NUM,PROV,X,Y,Z,OK,RDT,CLINIC,RS,KEY,COMM,DIR
 K DTOUT,^TMP("SDRRCLR",$J)
 Q
 ;
DELETE ;SD*566 user timed out - delete new incomplete record & display message
 S DIK=DIE
 D ^DIK K DIK
 W !!,*7,"*** ALL REQUIRED DATA WAS NOT ENTERED. ***",!,"*** RECALL REMINDER NOT CREATED FOR PATIENT:  ",$P(^DPT(DFN,0),U,1),". ***"
 Q
 ;
UPDATE ;Asks for new data
 K DIC,DIE,DR S DIE="^SD(403.5,",DR="[SDRR RECALL CARD ADD]",DIE("NO^")="BACKOUTOK" D ^DIE
 K DIC,DIE,DR,D0,DA,DLAYGO,NUM,PROV,X,Y,Z,OK,RDT,CLINIC,RS,KEY,COMM
 D QUIT
 Q
SDAM ;Entry Point for Appointment Management protocol
 N ORACTION,ORVP,XQORQUIT,SDAMERR,SDCOAP,VALMY
 S VALMBCK=""
 D FULL^VALM1
 I SDAMTYP="P" W !!,VALMHDR(1),! D STR(SDFN)
 I SDAMTYP="C" D
 .D EN^VALM2(XQORNOD(0))
 .S SDCOAP=0 F  S SDCOAP=$O(VALMY(SDCOAP)) Q:'SDCOAP  D
 ..I $D(^TMP("SDAMIDX",$J,SDCOAP)) K SDAT S SDAT=^(SDCOAP) D
 ...W !!,^TMP("SDAM",$J,+SDAT,0),!
 ...D STR(+$P(SDAT,"^",2))
 S VALMBCK="R"
QUIT K PROV,CLINIC,X,Y,C,D,ER,OK,PROV1,KEY,RS,FLAG,DIR,DFN,DIR
 K ^TMP("SDRRCLR",$J)
 Q
