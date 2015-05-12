PXVPST01 ;BIR/CML3 - V IMMUNIZATION FILE CONVERSION ; 26 Sep 2014  9:38 AM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**201**;Aug 12, 1996;Build 41
 ;
MVDIAGS ;
 ; moves the data in the previous DIAGNOSIS fields to the new fields:
 ; the PRIMARY DIAGNOSIS (#1304) and the OTHER DIAGNOSIS (#3) multiple
 ; this is a one-time task
 ; ^AUPNVIMM( is the V IMMUNIZATION file (#9000010.11)
 ; PXVV is the IENs of that file
 ; PXVD are pieces 8-15 of the zero node, where the data for the
 ; previous diagnosis fields (#s .08 thru .15) is stored
 N %,%H,%I,CNT,DA,DIC,DIE,DIK,DR,Q,X,Y,PXVD,PXVNOW,PXVV
 D NOW^%DTC S Y=% D DD^%DT S PXVNOW=Y
 D BMES^XPDUTL("Moving the DIAGNOSIS data of the V IMMUNIZATION file to the global locations of the new fields (in the same file).  Process started "_PXVNOW)
 S (CNT,PXVV)=0
 F  S PXVV=$O(^AUPNVIMM(PXVV)) Q:'PXVV  S PXVD=$P($G(^(PXVV,0)),"^",8,15) I PXVD'="",PXVD'?1.7"^" D  ;
 . ; DIAGNOSIS becomes PRIMARY DIAGNOSIS
 . S CNT=CNT+1,X=$P(PXVD,"^")
 . I X'="" K DA S DIE="^AUPNVIMM(",DA=PXVV,DR="1304////"_X D ^DIE S $P(^AUPNVIMM(PXVV,0),"^",8)=""
 . ; DIAGNOSES 2-8 become entries in the OTHER DIAGNOSIS multiple
 . F Q=2:1:8 S X=$P(PXVD,"^",Q) I X'="" D  ;
 .. K DA,DIC S DIC="^AUPNVIMM("_PXVV_",3,",DIC(0)="L",DA(1)=PXVV
 .. D FILE^DICN S $P(^AUPNVIMM(PXVV,0),"^",Q+7)=""
 ;
MVDONE ; DIAGNOSIS data move completed
 D NOW^%DTC S Y=% D DD^%DT S PXVNOW=Y
 K Q S Q(1)=" ",Q(3)=" "_CNT_" entr"_$S(CNT'=1:"ies",1:"y")_" processed."
 S Q(2)=" Process moving DIAGNOSIS data within the V IMMUNIZATION file completed at "_PXVNOW
 D BMES^XPDUTL(.Q)
 ;
RMVFLD ;
 ; following code no longer needed . . .
 ; I $P($G(^DD(9000010.11,.1,0)),"^")="DIAGNOSIS 3" K DA S DIK="^DD(9000010.11,",DA=.1,DA(1)=9000010.11 D ^DIK
 Q
