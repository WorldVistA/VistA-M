ECMFLPX ;ALB/JAM-Event Capture Management Local Procedure Filer ;1 Dec 00
 ;;2.0; EVENT CAPTURE ;**25,87**;8 May 96;Build 1
 ;
FILE ;Used by the RPC broker to file local procedures in #725
 ;     Variables passed in
 ;       ECIEN  - IEN of #725, if editing
 ;       ECPN   - Local Procedure Name
 ;       ECNA   - National Number
 ;       ECST   - Active/Inactive Status
 ;       ECSYN  - Synonym
 ;       ECPT   - CPT Code
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #725^Message
 ;
 N ECFLG,ECERR,ERR,ECOST,ECDAT,ONM,ONA,ECRES
 S ECERR=0 D CHKDT I ECERR Q
 S ECIEN=$G(ECIEN),ECFLG=1
 I $L(ECNA)'=5 D  Q
 .S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid Procedure Number"
 I $G(ECPT)'="" D  I ECERR Q
 .D CHK^DIE(725,4,,ECPT,.ECRES) I +ECRES<1 D  Q
 ..S ECERR=1,^TMP($J,"ECMSG",1)="0^Invalid CPT Code"
 I ECIEN'="" S ECFLG=0 D  I ECERR Q
 .I '$D(^EC(725,ECIEN,0)) D  Q
 ..S ECERR=1,^TMP($J,"ECMSG",1)="0^Local Procedure Not on File" Q
 .I ECIEN<90001 D  Q
 ..S ECERR=1,^TMP($J,"ECMSG",1)="0^National Procedure cant be changed"
 .S ECDAT=$G(^EC(725,ECIEN,0)),ONM=$P(ECDAT,U),ONA=$P(ECDAT,U,2)
 S ERR=0 D PXCHK^ECUMRPC1(.ERR,ECPN_"^"_ECNA) D  I ECERR Q
 .I +ERR,(ECIEN="")!(ECIEN&($G(ONM)'=ECPN)) D  Q
 ..S ^TMP($J,"ECMSG",1)="0^Procedure description already exist",ECERR=1
 .I +$P(ERR,U,2),(ECIEN="")!(ECIEN&($G(ONA)'=ECNA)) D
 ..S ^TMP($J,"ECMSG",1)="0^Procedure number already exist",ECERR=1
 I ECIEN="" D  I ECERR Q
 . D NEWIEN
 K DA,DR,DIE
 S DIE="^EC(725,",DA=ECIEN
 S ECOST=$P($G(^EC(725,ECIEN,0)),U,3),ECOST=$S(ECOST'="":"I",1:"A")
 S DR=".01////"_ECPN_";1////"_ECNA_";3////"_$G(ECSYN)_";4////"_$G(ECPT)
 I $G(ECST)'="","^I^A^"[ECST,ECST'=ECOST D
 .S DR=DR_";2////"_$S(ECST="I":DT,1:"@")
 D ^DIE I $D(DTOUT) D RECDEL D  Q
 . S ^TMP($J,"ECMSG",1)="0^Record not Filed"
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_ECIEN
 Q
 ;
RECDEL ; Delete record
 I ECFLG S DA=ECIEN,DIK="^EC(725," D ^DIK K DA,DIK
 Q
 ;
NEWIEN ;Create new IEN in file #725
 N DIC,DA,DD,DO
 L +^EC(725)
 S ECIEN=$O(^EC(725,"A"),-1)
 F  S ECIEN=ECIEN+1 Q:'$D(^EC(725,ECIEN))
 I ECIEN<90001 S ECIEN=90001
 S $P(^EC(725,0),U,3)=ECIEN,$P(^EC(725,0),U,4)=$P(^EC(725,0),U,4)+1
 L -^EC(725)
 Q
 ;
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECPN","ECNA" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
