ECMFCAT ;ALB/JAM-Event Capture Management Category Filer ;12 Dec 00
 ;;2.0; EVENT CAPTURE ;**25**;8 May 96
 ;
FILE ;Used by the RPC broker to file local procedures in #726
 ;     Variables passed in
 ;       ECC    - Category Name
 ;       ECST   - Category Status
 ;       ECIEN  - Category IEN, if editing
 ;
 ;     Variable return
 ;       ^TMP($J,"ECMSG",n)=Success or failure to file in #726^Message
 ;
 N ECFLG,ECERR,ERR,ECOST,OCAT,ECRRX,ECCT
 S ECERR=0 D CHKDT I ECERR Q
 S ECIEN=$G(ECIEN),ECFLG=1
 D CHK^DIE(726,.01,,ECC,.ECRRX) I ECRRX="^" D  Q
 .S ^TMP($J,"ECMSG",1)="0^Invalid Category",ECERR=1
 I ECIEN'="" S ECFLG=0 D  I ECERR Q
 . I '$D(^EC(726,ECIEN,0)) D  Q
 . . S ECERR=1,^TMP($J,"ECMSG",1)="0^Category Not on File"
 . S OCAT=$P($G(^EC(726,ECIEN,0)),U)
 S ERR=0 I (ECIEN="")!(ECIEN&($G(OCAT)'=ECC)) D  I ECERR Q
 .S ECCT=$TR(ECC,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 .I $D(^EC(726,"B",ECC))!($D(^EC(726,"B",ECCT))) D
 ..S ^TMP($J,"ECMSG",1)="0^Category description exist",ECERR=1
 I ECIEN="" D NEWIEN
 K DA,DR,DIE
 S DIE="^EC(726,",DA=ECIEN,DR=".01////"_ECC
 S ECOST=$P($G(^EC(726,ECIEN,0)),U,3),ECOST=$S(ECOST'="":"I",1:"A")
 I $G(ECST)'="","^I^A^"[ECST,ECST'=ECOST D
 . S DR=DR_";2////"_$S(ECST="I":DT,1:"@")
 D ^DIE I $D(DTOUT) D RECDEL S ^TMP($J,"ECMSG",1)="0^Record not Filed" Q
 S ^TMP($J,"ECMSG",1)="1^Record Filed"_U_ECIEN
 Q
 ;
RECDEL ; Delete record
 I ECFLG S DA=ECIEN,DIK="^EC(726," D ^DIK K DA,DIK
 Q
 ;
NEWIEN ;Create new IEN in file #725
 N DIC,DA,DD,DO,DR,DIE
 L +^EC(726)
 S DIC=726,DIC(0)="L",X=ECC
 D FILE^DICN
 S ECIEN=+Y
 L -^EC(726)
 S DIE="^EC(726,",DA=ECIEN,DR="1////"_DT D ^DIE
 Q
 ;
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECC","ECST" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
