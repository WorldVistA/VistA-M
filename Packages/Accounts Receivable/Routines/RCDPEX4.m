RCDPEX4 ;ALB/DRF - ELECTRONIC EOB EXCEPTION PROCESSING - FILE 344.4 ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;Call to $$RXBIL^IBNCPDPU via private IA #4435
 ;
 ;Cycle through the exception list looking for entries with an ECME number:
EN N ARRAY,ECME,EOB,ERA,RCBILL,RCER
 S RCER=0 F  S RCER=$O(^RCY(344.4,"AEXC",RCER)) Q:'RCER  D
 .S ERA="" F  S ERA=$O(^RCY(344.4,"AEXC",RCER,ERA)) Q:'ERA  D
 ..S EOB="" F  S EOB=$O(^RCY(344.4,"AEXC",RCER,ERA,EOB)) Q:'EOB  D
 ...;Ignore the exception if no ECME number is present
 ...S ECME=$P($G(^RCY(344.4,ERA,1,EOB,4)),U,2) Q:ECME=""
 ...;Lock zero node of ERA DETAIL
 ...L +^RCY(344.4,ERA,1,EOB,0):5 Q:'$T
 ...;Check for a matching bill in #399 (Rx Released) and if found remove error from exception list
 ...K ARRAY S ARRAY("ECME")=ECME,ARRAY("FILLDT")=$$SDATE(ERA)
 ...S RCBILL=$$RXBIL^IBNCPDPU(.ARRAY)     ; DBIA 4435
 ...I RCBILL>0 S RCBILL(1)=$P($G(^PRCA(430,RCBILL,0)),U) D REMOVE(ERA,EOB,.RCBILL,ECME)
 ...;Unlock zero node of ERA DETAIL
 ...L -^RCY(344.4,ERA,1,EOB,0)
 Q
 ;
REMOVE(RCXDA1,RCXDA,RCBILL,RCSAVE) ;Remove from exception list and file EEOB against matched claim
 ;RCXDA1 - ERA IEN
 ;RCXDA - ERA DETAIL IEN
 ;RCBILL - CLAIM array for released Rx
 ;RCSAVE - ORIGINAL CLAIM from ERA (ECME #)
 K ^TMP($J,"RCDP-EOB"),^TMP($J,"RCDPEOB","HDR")
 N DA,Q,Q0,RC0,RCEOB,DIE,DR
 S RC0=$G(^RCY(344.4,RCXDA1,1,RCXDA,0))
 S Q=0 F  S Q=$O(^RCY(344.4,RCXDA1,1,RCXDA,1,Q)) Q:'Q  S Q0=$G(^(Q,0)) D
 .I $P(Q0,U)["835ERA" S ^TMP($J,"RCDPEOB","HDR")=Q0
 .I $P(Q0,U,2)=$P(RC0,U,5) S $P(Q0,U,2)=RCBILL(1)
 .S ^TMP($J,"RCDP-EOB",1,Q,0)=Q0
 S ^TMP($J,"RCDP-EOB",1,.5,0)="835ERA"
 S RCEOB=$$DUP^IBCEOB("^TMP("_$J_",""RCDP-EOB"",1)",RCBILL) ; IA 4042
 K ^TMP($J,"RCDP-EOB",1,.5,0)
 I RCEOB D  Q
 .N RCWHY S RCWHY(1)="EEOB already found on file while trying to change claim # and filing into IB"
 .D STORACT^RCDPEX31(RCXDA1,RCXDA,.RCWHY)
 .S DA(1)=RCXDA1,DA=RCXDA D CHGED(.DA,RCEOB,RCSAVE)
 ;
 ; Add stub rec to 361.1 if not there
 S RCEOB=+$$ADD3611^IBCEOB(+$P($G(^RCY(344.4,RCXDA1,0)),U,12),"","",RCBILL,1,"^TMP("_$J_",""RCDP-EOB"",1)") ; IA 4042
 ;
 I RCEOB<0 D  Q
 .N RCWHY S RCWHY(1)="Error encountered trying to change claim # and file into IB"
 .D STORACT^RCDPEX31(RCXDA1,RCXDA,.RCWHY)
 ;
 ; Update EOB in file 361.1
 ; Call needs ^TMP arrays: $J,"RCDPEOB","HDR" and $J,"RCDP-EOB"
 D UPD3611^IBCEOB(RCEOB,1,1) ; IA 4042
 ; errors in ^TMP("RCDPERR-EOB",$J
 I $O(^TMP("RCDPERR-EOB",$J,0)) D
 .D ERRUPD^IBCEOB(RCEOB,"RCDPERR-EOB") ; Adds error msgs to IB file 361.1 ; IA 4042
 ;
 N RCWHY S RCWHY(1)="EEOB claim # changed and filed into IB under new claim #"
 D STORACT^RCDPEX31(RCXDA1,RCXDA,.RCWHY)
 S DA(1)=RCXDA1,DA=RCXDA
 D CHGED(.DA,RCEOB,RCSAVE)
 S DIE="^RCY(344.4,"_DA(1)_",1,",DR="1///@" D ^DIE
 ;
 K ^TMP($J,"RCDP-EOB"),^TMP($J,"RCDPEOB","HDR"),^TMP("RCDPERR-EOB",$J)
 Q
 ;
CHGED(DA,RCEOB,RCSAVE) ;  Change bad bill # to good one for EOB
 ; DA = DA and DA(1) to use for DIE call
 ; RCEOB = the ien of the entry in file 361.1
 ; RCSAVE = the free text of the original bill #
 N DIE,DR,X,Y
 S DIE="^RCY(344.4,"_DA(1)_",1,",DR=".05///@;.02////"_RCEOB_";.13////1"_$S(RCSAVE'="":";.17////"_RCSAVE,1:"")_";.07///@" D ^DIE
 Q
 ;
SDATE(ERA) ;Return Service Date for the ERA
 ;Scan RAW DATA multiple ignoring all records types except 40 - SERVICE DATE is piece 19 of record type 40
 N SUB,REC,SDATE S SUB=0,SDATE="" F  S SUB=$O(^RCY(344.4,ERA,1,1,1,SUB)) Q:'SUB  D  Q:SDATE]""
 .S REC=$G(^RCY(344.4,ERA,1,1,1,SUB,0)) S:(+REC=40) SDATE=$P(REC,U,19)
 Q SDATE
