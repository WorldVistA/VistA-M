PSOACR ;AITC/PD - Auto Close Reject Code ;11/12/2024
 ;;7.0;OUTPATIENT PHARMACY;**748**;DEC 1997;Build 14
 ;;
 ;
 Q
 ;
EN(RX,RFL,REJ) ; Main entry point for PSO Auto Close Reject
 ;
 ; Input parameters:
 ;   RX  - IEN for Prescription File (#52)
 ;   RFL - Refill
 ;   REJ - IEN for BPS NCPDP Rejects File (#9002313.93)
 ;
 ; This routine will be called from CLOSE^PSOREJUT.
 ;
 ; CLOSE^PSOREJUT will only call this routine if the reason for closing the reject
 ; is IGNORED - NO RESUBMISSION and the Ignore Flag is set to 1.
 ; 
 ; In ECME, the BPS SUPERVISOR can define reject codes as auto close reject codes.
 ; The auto close reject codes will be stored in file BPS Auto Reject Code (#9002313.94).
 ; From PSO Reject Notification Screen and PSO Reject Information Screen, if the pharmacist
 ; uses the IGNORE action, to ignore a reject, a call will be made to this routine
 ; to determine if the claim should be automatically closed.
 ;
 ; The logic will fall through a series of checks to verify if the claim should be closed.  If
 ; all checks pass, the claim will be closed.  If any of the checks fail, the claim will not
 ; be closed and will be placed onto the ECME User Screen worklist.
 ;
 N BPSACRIEN,COB,DFN,DOS,DOSIB,PSOAMT,PSOCLST,PSOIEN02,PSOIEN03,PSOIEN59,PSOIENS
 N PSORELCP,PSOSECOND,REJCOB,REJEXT,REJIEN,THRESHOLD,X,Y
 ;
 ; Check if the reject code being ignored is set up as an auto close reject.
 ; If not, quit.
 ;
 S REJEXT=$$GET1^DIQ(52.25,REJ_","_RX,.01)
 I '$D(^BPSACR("C",REJEXT)) Q
 ;
 ; Get COB indicator for the reject
 S REJCOB=$$GET1^DIQ(52.25,REJ_","_RX,27,"I")
 ; 
 ; Get IEN for BPS Transaction file (#9002313.93) and the BPS Claims file (#9002313.02).
 ; These will be needed for the following checks.
 ; Also get IEN for BPS Response file (#9002313.03).
 ;
 S PSOIENS=$$CLAIM^BPSBUTL(RX,RFL,REJCOB)
 S PSOIEN59=$P(PSOIENS,"^",1)
 S PSOIEN02=$P(PSOIENS,"^",2)
 S PSOIEN03=$$GET1^DIQ(9002313.59,PSOIEN59,4,"I")
 ;
 ; Get info needed to check for secondary insurance.
 ;
 S DFN=$$GET1^DIQ(9002313.59,PSOIEN59,5,"I")
 S DOS=$$GET1^DIQ(9002313.02,PSOIEN02,401,"I")
 S X=DOS
 D ^%DT
 S DOSIB=Y
 ;
 ;
 ; At this time, auto close rejects only occurs for primary claims.  If not COB=1, do not auto close.
 I REJCOB'=1 D COMMENT(1) Q
 ;
 ; Do not close if patient has secondary insurance
 ;
 I $$SECINSCK^BPSPRRX(DFN,DOSIB) D COMMENT(1) Q
 ;
 ; Get the IEN of the auto close reject code.
 ;
 S REJIEN=$O(^BPSACR("C",REJEXT,""))
 S BPSACRIEN=$O(^BPSACR("B",REJIEN,""))
 ;
 ; Auto close rejects have a dollar threshold defined.  This amount is compared against the
 ; gross amount due.  If the dollar threshold is 0, the gross amount due will not effect
 ; if the claim is closed or not.  If the dollar threshold is greater than 0, the claim will
 ; be closed if the dollar threshold is less than the gross amount due.
 ;
 ; Get gross amount due
 ;
 S PSOAMT=$$AMT^BPSBUTL(RX,RFL)
 ;
 ; Get dollar threshold from BPS Auto Close Reject file
 ;
 S THRESHOLD=$$GET1^DIQ(9002313.94,BPSACRIEN,.03)
 ;
 ; If the threshold amount is not 0 and the threshold is equal to or greater than
 ; the gross amount due, quit and do not close the claim.
 ;
 I +THRESHOLD'=0&(PSOAMT=THRESHOLD!(PSOAMT>THRESHOLD)) D COMMENT(4) Q
 ;
 ; Check the REJECT COUNT from BPS Responses  If it is not exactly 1, quit.
 ;
 I +$$GET1^DIQ(9002313.0301,"1,"_PSOIEN03,510)'=1 D COMMENT(3) Q
 ;
 ; Make sure the one and only reject code, from BPS Responses, matches the
 ; Auto Close reject currently being ignored.  If not, quit.
 ;
 I $$GET1^DIQ(9002313.03511,"1,1,"_PSOIEN03,.01,"I")'=REJEXT Q
 ;
 ; Get the claim status from the transaction file.
 ;
 S PSOCLST=$$CLAIMST^BPSSCRU3(PSOIEN59)
 ;
 ; Check if Secondary claim.
 ;
 S PSOSECOND=0
 S COB=$$GET1^DIQ(9002313.93,PSOIEN59,18)
 I COB=2 S PSOSECOND=1
 ;
 ; Can only be closed if E REJECTED or E REVERSAL ACCEPTED.
 ;
 I PSOCLST'["E REJECTED",PSOCLST'["E REVERSAL ACCEPTED" D  Q
 . I PSOSECOND=1 D COMMENT(1)
 ;
 ; Cannot close if non-billable.
 ;
 I $$NB^BPSSCR03(PSOIEN59) Q
 ;
 ; Cannot close if already closed.
 ;
 I $$CLOSED02^BPSSCR03(PSOIEN02) Q
 ;
 ; Cannot close if secondary payable claim exists.
 ;
 I COB<2,$$PAYABLE^BPSOSRX5($P(PSOCLST,"^")),$$PAYBLSEC^BPSUTIL2(PSOIEN59) D COMMENT(1) Q
 ;
 ; Default release of copay to 0 - do not release copay.
 ;
 S PSORELCP=0
 ;
 ; If patient eligibilty is VETERAN, release copay.
 ;
 I $$GET1^DIQ(9002313.59,PSOIEN59,901.04,"I")="V" S PSORELCP=1
 ;
 ; At this point, all checks have passed and the claim is okay to close.
 ;
 D CLOSE
 ;
 Q
 ;
CLOSE ; Close the claim
 ;
 N BILLNUM,BPSAR,CLAIMID,DA,DIE,DR,PSOLOCK,RELDT
 ;
 ; Lock claim file
 ;
 S PSOLOCK=0
 L +^BPSC(PSOIEN02):0
 I $T S PSOLOCK=1
 E  D COMMENT(2) Q
 ;
 S BPSAR("FILL NUMBER")=+RFL
 S BPSAR("DOS")=DOS-17000000
 S BPSAR("FILLED BY")=$$GET1^DIQ(52,RX,16,"I")
 S BPSAR("PRESCRIPTION")=RX
 S BILLED=$$GET1^DIQ(9002313.0201,"1,"_PSOIEN02,426)
 S BILLED=$P(BILLED,"DQ",2)
 S BPSAR("BILLED")=$$DFF2EXT^BPSECFM(BILLED)
 S CLAIMID=$$GET1^DIQ(9002313.0201,"1,"_PSOIEN02,402)
 S BPSAR("CLAIMID")=$P(CLAIMID,"D2",2)
 S BPSAR("PLAN")=$$GET1^DIQ(9002313.59902,"1,"_PSOIEN59,.01,"I")
 S BPSAR("STATUS")="CLOSED"
 S BPSAR("PAID")=0
 I +RFL=0 S RELDT=$$GET1^DIQ(52,RX,31,"I")
 E  S RELDT=$$GET1^DIQ(52.1,+RFL_","_RX,17,"I")
 S BPSAR("RELEASE DATE")=RELDT
 S BPSAR("USER")=.5
 S BPSAR("EPHARM")=$$GET1^DIQ(9002313.59,PSOIEN59,1.07,"I")
 S BPSAR("RXCOB")=COB
 S BPSAR("CLOSE REASON")=$$GET1^DIQ(9002313.94,BPSACRIEN,.02,"I")
 S BPSAR("DROP TO PAPER")=0
 S BPSAR("RELEASE COPAY")=+$G(PSORELCP)
 S BPSAR("CLOSE COMMENT")="Auto Closed Claim"
 ;
 ; Call IB
 ;
 S BILLNUM=$$STORESP^IBNCPDP(DFN,.BPSAR)
 ;
 S DIE="^BPSC("
 S DA=PSOIEN02
 S DR="901///1"
 S DR=DR_";902///"_$$NOW^XLFDT()
 S DR=DR_";903////.5"
 S DR=DR_";904///"_BPSAR("CLOSE REASON")
 S DR=DR_";905////N"
 D ^DIE
 ;
 ; Unlock claim file
 ;
 I PSOLOCK L -^BPSC(PSOIEN02)
 ;
 Q
 ;
COMMENT(COM) ; Add comment to BPS Transaction file
 ;
 ; If the claim can not be automatically closed, it is possible to
 ; have the system add a comment.  In the future, if other reasons
 ; are added, that require a comment, they can  be added to COMREAS.
 ;
 N %,DATA,LINE,NUM,PSODA,PSOFDA,PSONOW,PSOREC,REA,REASON
 ;
 S REASON=""
 F LINE=1:1 S DATA=$P($T(COMREAS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";")
 . S REA=$P(DATA,";",2)
 . I NUM=COM S REASON=REA
 I REASON="" Q
 ;
 D NOW^%DTC
 S PSONOW=%
 ;
 S PSOFDA(9002313.59111,"+1,"_PSOIEN59_",",.01)=PSONOW
 D UPDATE^DIE("","PSOFDA","")
 ;
 S PSOREC=$O(^BPST(PSOIEN59,11,"B",PSONOW,""))
 S PSODA(9002313.59111,PSOREC_","_PSOIEN59_",",.02)=.5
 S PSODA(9002313.59111,PSOREC_","_PSOIEN59_",",.03)=$G(REASON)
 D FILE^DIE("","PSODA","")
 ;
 Q
 ;
COMREAS ; Unable to close reason comments
 ;;1;IGNORED by Pharmacy - Not auto closed due to COB
 ;;2;IGNORED by Pharmacy - Not auto closed due to locked claim
 ;;3;IGNORED by Pharmacy - Not auto closed due to multiple rejects
 ;;4;IGNORED by Pharmacy - Not auto closed due to dollar threshold
 ;;
 ;
