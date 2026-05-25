PSOERXUX ;BIRM/MFR - eRx Un Process action ;07/19/23
 ;;7.0;OUTPATIENT PHARMACY;**700,746,770**;DEC 1997;Build 145
 ;
UNPROC ; Un-Process
 I '$D(PSOIEN) D MSG("No eRx IEN found") Q
 D FULL^VALM1
 N DIR,ERXSTAT,UKEY,PSRXNUM,STAT,MTYPE,RVALUE,RVFLAG,SEQ,CMFLAG,PSODFN,PSOPLCK,DIE,DA,DR,HCOMM,INCOM
 N Y,REA,PSONOOR,RCODE,RESP,FDA,PSCAN,PSOCANRC,PSOCANRD,PSOCANRN
 ;
 ; #1 - Check if status is "Processed"
 S ERXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 I ",PR,RXP,CXP,RXC,"'[(","_ERXSTAT_",") D MSG("eRx status must be 'PR','RXP', 'RXC' or 'CXP' to Un-Process") Q
 ;
 ; #2 - Check if user hold the KEY "PSDRPH"
 S UKEY=$O(^DIC(19.1,"B","PSDRPH",0))
 I '$D(^VA(200,DUZ,51,"B",UKEY)) D MSG("Cannot Un-Process if you don't hold the KEY 'PSDRPH'") Q
 ;
 ; #3 - Check if 52.49/.13 exists
 S PSRXNUM=$P(^PS(52.49,PSOIEN,0),"^",12)
 I 'PSRXNUM D MSG("No prescription number found in eRx") Q
 ;
 ; #4 - Check 52/zero node
 I '$D(^PSRX(PSRXNUM,0)) D MSG("Prescription number not valid") Q
 ;
 ; #5 - Check Message Type, only "N","RE", and "CX" can be Un-Processed
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 I ",N,RE,CX,"'[(","_MTYPE_",") D MSG("Cannot Un-Process Message Types other than 'N','RE', or 'CX'") Q 
 ;
 ; #6 - Check 52/100 if value is 5 (Suspended) or 3 (Hold)
 S STAT=+$G(^PSRX(PSRXNUM,"STA"))
 I STAT'=5,STAT'=3,STAT'=13 D MSG("Prescription status is not SUSPENDED, HOLD or DELETED") Q
 ;
 ; #7 - Check if original fill, check if partial entered, check if transmitted to CMOP (Rx not DELETED)
 I $D(^PSRX(PSRXNUM,1)),STAT'=13!(STAT=13&$$CSRX^PSOUTL(PSRXNUM)) D MSG("Refill(s) already entered, cannot Un-Process") Q      ;Refill request
 I $D(^PSRX(PSRXNUM,"P")),STAT'=13!(STAT=13&$$CSRX^PSOUTL(PSRXNUM)) D MSG("Partial(s) already entered, cannot Un-Process") Q   ;At least 1 partial has been entered
 ;
 ; #8 - CMOP logic - check if original fill and if not dispensed (Rx not DELETED)
 I $D(^PSRX(PSRXNUM,4)),STAT'=13!(STAT=13&$$CSRX^PSOUTL(PSRXNUM)) D
 . S SEQ=0
 . F  S SEQ=$O(^PSRX(PSRXNUM,4,SEQ)) Q:'SEQ  D
 . . I ($P($G(^PSRX(PSRXNUM,4,SEQ,0)),"^",3)'=0),($P($G(^PSRX(PSRXNUM,4,SEQ,0)),"^",4)'=3) S CMFLAG=1
 I $G(CMFLAG) D MSG("Already transmitted to CMOP, cannot Un-Process") Q
 ;
 ; User comments, to both 52 and 52.49
 S DIR("A")="Comments",DIR("B")="Un-Process for correction",DIR(0)="F^5:100" D ^DIR K DIR
 S (HCOMM,INCOM)=Y
 ;
 ; Final confirmation to Un-Process
 S DIR(0)="YO",DIR("A")="Would you like to 'Un-Process' eRx #"_$$GET1^DIQ(52.49,PSOIEN,.01,"E")_" and Rx #"_$$GET1^DIQ(52,PSRXNUM,.01,"E")
 S DIR("B")="Y" D ^DIR K DIR
 Q:'Y
 ;
 ; Once the user confirms the Un-Process, then put a lock/unlock on the patient
 S PSODFN=+$P(^PSRX(PSRXNUM,0),"^",2)
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D  Q
 . W !,"Patient is locked by another user. Please, try again later.",$C(7) Q
 ;
CANCEL ; Requirement - DC - discontinue prescription (PSO CANCEL)
 N DA
 S PSONOOR="S",DA=PSRXNUM,REA="C"
 S PSOCANRC=DUZ,PSOCANRN=$P(^VA(200,DUZ,0),"^"),PSOCANRD=$P(^PSRX(DA,0),"^",4)
 S PSCAN(+^PSRX(DA,0))=DA_"^C"
 D CAN1^PSOCAN3
 ;
 ; Replace status code from 12 (Discontinued) to 15 (Discontinued - Edit)
 S DIE=52,DA=PSRXNUM,DR="100///15" D ^DIE K DIE
 ;
 ; Replace Reason code in RX activity log from "C" (Discontinued) to "E" (Edit)
 S RCODE=+$P($G(^PSRX(PSRXNUM,"A",0)),"^",3)
 I $G(RCODE) S $P(^PSRX(PSRXNUM,"A",RCODE,0),"^",2)="E"
 ;
 D UL^PSSLOCK(PSODFN)
 ;
ERX ; Change eRx status to "Wait"
 N DA
 S RESP=$O(^PS(52.45,"C","ERX","W",0))
 S DIE="52.49",DR="1///"_RESP_";.13///@;25.2///@",DA=PSOIEN D ^DIE K DIE
 ; Add eRx history
 S FDA(52.4919,"+1,"_PSOIEN_",",.01)=$$NOW^XLFDT()
 S FDA(52.4919,"+1,"_PSOIEN_",",.02)=RESP
 S FDA(52.4919,"+1,"_PSOIEN_",",.03)=$G(DUZ)
 S FDA(52.4919,"+1,"_PSOIEN_",",1)=HCOMM
 D UPDATE^DIE(,"FDA","NEWSTAT","ERR") K FDA
 ;
 ; Killing the VistA Rx suggestion for this record
 I $$DRUGHASH^PSOERUT(PSOIEN) K ^PS(52.49,"ADRGVRX",$$DRUGHASH^PSOERUT(PSOIEN))
 ;
 S VALMBCK="R"
 Q
 ;
MSG(TXT) ;
 S DIR("A",1)="",DIR("A")="Press Enter to continue"
 S DIR("A",2)=TXT
 S DIR(0)="FO"
 D ^DIR K DIR
 S VALMBCK="R"
 Q
