PSO508PO ;ALB/BWF - patch 508 post-install ; 1/09/2018 10:43am
 ;;7.0;OUTPATIENT PHARMACY;**508**;DEC 1997;Build 295
 ;
EN ;
 N DIK,DA
 D ERXTYP,ERXPOP,WSUPD
 S DIK="^PS(52.49,",DIK(1)=".02^RTMID" D ENALL^DIK K DIK
 S DIK="^PS(52.49,",DIK(1)="25^CHVID" D ENALL^DIK K DIK
 S DIK="^PS(52.49,",DIK(1)=".14^RTHID" D ENALL^DIK K DIK
 S DIK="^PS(52.49,",DIK(1)=".04^PAT2" D ENALL^DIK K DIK
 S DIK="^PS(52.49,",DIK(1)=".08^MTYPE" D ENALL^DIK K DIK
 ;
 S I=0 F  S I=$O(^PS(52.49,I)) Q:'I  D
 .S DIK="^PS(52.49,"_I_",100,",DIK(1)=".02^C",DA(1)=I
 .D ENALL^DIK K DIK,DA
 Q
ERXTYP ;
 N I
 S I=0
 F  S I=$O(^PS(52.49,I)) Q:'I  D
 .I $$GET1^DIQ(52.49,I,.08,"I")]"" Q
 .S FDA(52.49,I_",",.08)="N" D FILE^DIE(,"FDA") K FDA
 Q
ERXPOP ;
 N I,DONE,NIEN,ELINE,ECODE,EDESC,ELONG,EIEN,TYPE,SUB
 F TYPE="ERXSTAT","CLQUAL","ERR" D
 .I TYPE="ERXSTAT" S SUB="ERX"
 .I TYPE="CLQUAL" S SUB="CLQ"
 .I TYPE="ERR" S SUB="ERR"
 .S DONE=0
 .F I=1:1 D  Q:DONE
 ..K NIEN
 ..I TYPE="ERR" S ELINE=$T(@TYPE+I^PSOERXZ1),ELINE=$P(ELINE,";;",2)
 ..I TYPE'="ERR" S ELINE=$T(@TYPE+I),ELINE=$P(ELINE,";;",2)
 ..I ELINE=" Q"!(ELINE="") S DONE=1 Q
 ..S ECODE=$P(ELINE,U),EDESC=$P(ELINE,U,2),ELONG=$P(ELINE,U,3)
 ..I $D(^PS(52.45,"C",SUB,ECODE)) D  Q
 ...S EIEN=$O(^PS(52.45,"C",SUB,ECODE,0)) Q:'EIEN
 ...S FDA(52.45,EIEN_",",.01)=ECODE
 ...S FDA(52.45,EIEN_",",.02)=EDESC
 ...S FDA(52.45,EIEN_",",.03)=SUB
 ...D FILE^DIE(,"FDA") K FDA
 ..S FDA(52.45,"+1,",.01)=ECODE
 ..S FDA(52.45,"+1,",.02)=EDESC
 ..S FDA(52.45,"+1,",.03)=SUB
 ..D UPDATE^DIE(,"FDA","NIEN") K FDA
 Q
WSUPD ;
 N WSIEN,WSIENS,DIE,DR,DA
 S WSIEN=$$FIND1^DIC(18.12,,,"PSO WEB SERVER","B") Q:'WSIEN
 ; disable web service
 S DIE="^XOB(18.12,",DR=".06///0",DA=WSIEN D ^DIE K DIE,DR,DA
 S WSIENS=WSIEN_","
 S FDA(18.12,WSIENS,.04)=""
 S FDA(18.12,WSIENS,200)=""
 S FDA(18.12,WSIENS,300)=""
 ; clear server, password, and username fields
 D FILE^DIE(,"FDA") K FDA
 Q
ERXSTAT ;
 ;;IEA^INBOUND ERROR ACKNOWLEDGED
 ;;RRN^REFILL REQUEST - NEW
 ;;RRX^REFILL REQUEST EXPIRED
 ;;RRR^REFILL REQUEST RESPONSE RECEIVED
 ;;RRE^REFILL REQUEST ERROR
 ;;RRP^REFILL REQUEST PROCESSED
 ;;RRF^REFILL REQUEST FAILED
 ;;RRC^REFILL REQUEST COMPLETE
 ;;RXA^REFILL RESPONSE ACKNOWLEDGED
 ;;RXD^REFILL RESPONSE DENIED/DNTF
 ;;RXN^REFILL RESPONSE - NEW
 ;;RXF^REFILL RESPONSE FAILED
 ;;RXP^REFILL RESPONSE PROCESSED
 ;;RXC^REFILL RESPONSE COMPLETE
 ;;RXW^REFILL RESPONSE WAITING
 ;;CAN^ORIGINAL ERX CANCELED IN THE HOLDING QUEUE
 ;;CNP^CANCEL RESPONSE PROCESSED
 ;;CAO^CANCEL PROCESS COMPLETE
 ;;CAH^CANCEL COMPLETED IN HOLDING QUEUE
 ;;CAA^CANCEL REQUEST ACKNOWLEDGED
 ;;CAR^CANCEL REQUEST RECEIVED
 ;;CNE^CANCEL RESPONSE/INBOUND ERROR
 ;;CAF^CANCEL PROCESS FAILED
 ;;CAP^CANCEL PAPER RX OR FAXED RX
 ;;CAX^CANCEL RESPONSE FROM VISTA UNSUCCESSFUL
 ;;IRA^INBOUND REFREQ ERROR ACKNOWLEDGED
 Q
 ; code list qualifiers
CLQUAL ;
 ;;AA^Patient unknown to the Prescriber
 ;;AB^Patient never under Prescriber care
 ;;AC^Patient no longer under Prescriber care
 ;;AD^Patient has requested refill too soon
 ;;AE^Medication never prescribed for the patient
 ;;AF^Patient should contact Prescriber first
 ;;AG^Refill not appropriate
 ;;AH^Patient has picked up prescription
 ;;AJ^Patient has picked up partial fill of prescription
 ;;AK^Patient has not picked up prescription, drug returned to stock
 ;;AL^Change not appropriate
 ;;AM^Patient needs appointment
 ;;AN^Prescriber not associated with this practice or location.
 ;;AO^No attempt will be made to obtain Prior Authorization
 ;;AP^Request already responded to by other means (e.g. phone or fax)
 ;;AQ^More Medication History Available
 Q
