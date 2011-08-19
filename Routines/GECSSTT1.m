GECSSTT1 ;WISC/RFJ/KLD-stacker file retransmission                      ;13 Oct 98
 ;;2.0;GCS;*19*;MAR 14, 1995
 N DA,DATA,GECSDOC,GECSXMZ,STATUS,ABORT,DIR
 F  S DA=$$SELECT^GECSSTAA("","","","") Q:'DA  S GECSDOC=$P(DA,"^",2),DA=+DA D
 .   L +^GECS(2100.1,DA):5 I '$T W !,"Another user is working with the stack document, try again later." Q
 .   S STATUS=$P(^GECS(2100.1,DA,0),"^",4) S:STATUS="" STATUS="?"
 .   W $C(7),!!?5,"Current Status: ",$$STATUS^GECSSGET(GECSDOC)
 .   I '$D(^GECS(2100.1,DA,10,1,0)) W !,"There is not a code sheet for this stack entry." Q
 .   I $$GET1^DIQ(2100.1,DA,3,"I")="F" D  Q:ABORT
 .   .   W !?18,"** FINAL DOCUMENTS CANNOT BE RETRANSMITTED **",!
 .   .   S ABORT=1
 .   .   S DIR(0)="E",DIR("A")="Enter RETURN or '^' to exit"
 .   .   D ^DIR
 .   .   Q
 .   I STATUS="A" W !,"WARNING: Accepted documents probably should not be retransmitted."
 .   S XP="Do you want to retransmit this document now",XH="Enter 'YES' to retransmit the document immediately, 'NO' or '^' to exit."
 .   W !!
 .   I $$YN^GECSUTIL(2)'=1 L -^GECS(2100.1,DA) Q
 .   ;
 .   ;  move mail messages
 .   S GECSXMZ=0 F  S GECSXMZ=$O(^GECS(2100.1,DA,20,GECSXMZ)) Q:'GECSXMZ  S DATA=$G(^(GECSXMZ,0)) I DATA'="" D MESSAGE^GECSSTTR(DA,21,GECSXMZ) I $D(^GECS(2100.1,DA,21,GECSXMZ,0)) S ^(0)=DATA
 .   K ^GECS(2100.1,DA,20)
 .   D SETSTAT^GECSSTAA(DA,"M")
 .   S STATUS=$P(^GECS(2100.1,DA,0),"^",4) S:STATUS="" STATUS="?"
 .   W !?5,"NEW Status: ",$$STATUS^GECSSGET(GECSDOC)
 .   L -^GECS(2100.1,DA)
 Q
 ;
 ;
CONFIRM(XMZ,CONFIRM) ;  add confirmation number to mailman message number
 ;  xmz=message number;  confirm=confirmation number
 ;  return the number of documents with message, 0 if none
 S COUNT=0
 S %=0 F  S %=$O(^GECS(2100.1,"AM",XMZ,%)) Q:'%  I $D(^GECS(2100.1,%,0)) D
 .   I $D(^GECS(2100.1,%,20,0)) L +^GECS(2100.1,%,20) S $P(^GECS(2100.1,%,20,0),"^",2)=CONFIRM L -^GECS(2100.1,%,20) S COUNT=COUNT+1
 .   I $D(^GECS(2100.1,%,21,0)) L +^GECS(2100.1,%,21) S $P(^GECS(2100.1,%,21,0),"^",2)=CONFIRM L -^GECS(2100.1,%,21) S COUNT=COUNT+1
 Q COUNT
