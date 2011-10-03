RAMAIN3 ;HISC/PW - UPDATE CPRS ORDERABLE ITEMS ;7/24/02  14:45
 ;;5.0;Radiology/Nuclear Medicine;**50**;Mar 16, 1998
 ;called by RAMAIN
ORDITMS ;*50 |=> The message has been changed - task off a job to update
 ; the Orderable Items file 101.43
 Q:'$$ORQUIK^RAORDU()
 S RAMSG=DA N DA
 S ZTRTN="QORDITMS^RAMAIN3",ZTDESC="RA MESSAGE UPDATE:ORDERABLE ITEMS"
 N XX F XX="RAMLNB","RAMSG" S ZTSAVE(XX)=""
 S ZTDTH=DT,ZTIO=""
 D ^%ZTLOAD
 ;D QORDITMS^RAMAIN3
 W !!,"Since the PROCEDURE MESSAGE TEXT has been changed, all CPRS Orderable",!,"Items that have this TEXT will be updated by task job ",$G(ZTSK)," .",!
 Q
QORDITMS ; loop procedures to locate message and then send to CPRS
 ;queued from RAMAIN w RAMSG,RAMLNB
 S ZTREQ="@"
 N RADA,RAINADT,RASTAT,RAFILE,RAY,RAENALL
 S RADA=0 F  S RADA=$O(^RAMIS(71,RADA)) Q:RADA'>0  D
 . Q:'$D(^RAMIS(71,RADA,3,"B",RAMSG))
 . S RAINADT=+$G(^RAMIS(71,RADA,"I"))
 . I $L(RAMLNB),RAINADT,RAINADT<DT Q  ;procedure will update CPRS when activated
 . I '$L(RAMLNB) D DELMESG
 . S RASTAT="1^1",RAENALL=0,RAY=RADA,RAFILE=71
 . D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY) ;as found in RAMAIN2
 Q
DELMESG ;Message was deleted from 71.4, need to delete from 71
 N DA K DIK
 S DA=$O(^RAMIS(71,RADA,3,"B",RAMSG,0)),DA(1)=RADA,DIK="^RAMIS(71,"_DA(1)_",3,"
 D ^DIK
 K DIK
 Q
