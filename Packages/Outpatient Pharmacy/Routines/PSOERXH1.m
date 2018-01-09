PSOERXH1 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
 ; place eRx on Hold
HOLD ;
 N DIE,DA,DR,CURSTAT,CSTATI,LMATCH,LSTAT,SUBFIEN,NEWSTAT,RESP,DIR,RXSTAT,HCOMM
 Q:'$G(PSOIEN)
 D FULL^VALM1
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!(RXSTAT="PR") D  Q
 .W !!,"Cannot hold a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 .S DIR(0)="E" D ^DIR
 ; check to see if the erx order status is a hold status
 S CSTATI=$$GET1^DIQ(52.49,PSOIEN,1,"I")
 S CURSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 S VALMBCK="R"
 I $E(CURSTAT,1)="H" D  Q
 .S DIR(0)="YO",DIR("B")="NO"
 .S DIR("A",1)="This eRx is already in a 'HOLD' status."
 .S DIR("A")="Would you like to change the hold status and comments?"
 .D ^DIR
 .Q:'Y
 .K DIR
 .S RESP=$$HDIR(1)
 .I 'RESP D  Q
 ..W "Hold Reason required. eRx not placed in a 'Hold' status."
 ..S DIR(0)="E" D ^DIR
 .S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 .I Y="^" W !,"eRx NOT placed on hold." D ^DIR K DIR Q
 .S HCOMM=$G(Y)
 .S DIE="52.49",DR="1///"_RESP,DA=PSOIEN D ^DIE K DIE
 .S SUBFIEN=$$NSTAT(PSOIEN,RESP,HCOMM)
 .K @VALMAR D INIT^PSOERX1
 K Y
 S RESP=$$HDIR()
 I 'RESP D  Q
 .W "Hold Reason required. eRx not placed in a 'Hold' status."
 .S DIR(0)="E" D ^DIR
 S DIR(0)="52.4919,1",DIR("A")="Additional Comments (Optional)" D ^DIR K DIR
 I Y="^" Q
 S HCOMM=Y
 S DIE="52.49",DR="1///"_RESP,DA=PSOIEN D ^DIE K DIE
 S FDA(52.4919,"+1,"_PSOIEN_",",.01)=$$NOW^XLFDT()
 S FDA(52.4919,"+1,"_PSOIEN_",",.02)=RESP
 S FDA(52.4919,"+1,"_PSOIEN_",",.03)=$G(DUZ)
 S FDA(52.4919,"+1,"_PSOIEN_",",1)=HCOMM
 D UPDATE^DIE(,"FDA","NEWSTAT","ERR") K FDA
 S SUBFIEN=$O(NEWSTAT(0)) Q:'SUBFIEN
 S SUBFIEN=$G(NEWSTAT(SUBFIEN))
 K @VALMAR D INIT^PSOERX1
 Q
NSTAT(IEN,STAT,COMM) ;
 N SUBFIEN
 S FDA(52.4919,"+1,"_IEN_",",.01)=$$NOW^XLFDT()
 S FDA(52.4919,"+1,"_IEN_",",.02)=STAT
 S FDA(52.4919,"+1,"_IEN_",",.03)=$G(DUZ)
 S FDA(52.4919,"+1,"_IEN_",",1)=COMM
 D UPDATE^DIE(,"FDA","NEWSTAT") K FDA
 S SUBFIEN=$O(NEWSTAT(0)) Q:'SUBFIEN
 S SUBFIEN=$G(NEWSTAT(SUBFIEN))
 Q SUBFIEN
HDIR(HTYP) ; 
 N DIR,DIC,Y,X
 ;S DIC="^PS(52.45,",X(1)="ERX",X(2)="H",DIC(0)="EMQ",D="C" D IX^DIC K DIC,D
 S DIC("A")="Select HOLD reason code: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),$E($P(^PS(52.45,Y,0),U),1)=""H"""
 D ^DIC K DIC
 I Y<1 Q 0
 Q:'+$P(Y,U) 0
 Q $P(Y,U)
 ; remove hold from eRx
UNHOLD ;
 N Y,DIR,DIE,DA,DR,NEWSIEN,RXSTAT
 D FULL^VALM1
 S VALMBCK="R"
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!(RXSTAT="PR") D  Q
 .W !!,"Cannot un-hold a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 .S DIR(0)="E" D ^DIR
 W !
 I $E($$GET1^DIQ(52.49,PSOIEN,1,"E"),1)'="H" D  Q
 .W !,"This eRx is not currently on hold. Please use the 'Hold'",!,"function to update the hold status and comments.",!!
 .S DIR(0)="E"
 .D ^DIR
 .K @VALMAR D INIT^PSOERX1
 D UPDSTAT^PSOERXU1(PSOIEN,"I","HOLD REMOVED BY "_$$NAME^XUSER(DUZ))
 W !,"eRx removed from hold status, and placed to 'In Progress'."
 S DIR(0)="E" D ^DIR K DIR
 K @VALMAR D INIT^PSOERX1
 Q
