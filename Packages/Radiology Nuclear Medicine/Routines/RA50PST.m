RA50PST ;HISC/PW - UPDATE CPRS ORDERABLE ITEMS ;7/24/02  14:45
 ;;5.0;Radiology/Nuclear Medicine;**50**;Mar 16, 1998
QUEUE ;
 I '$$ORQUIK^RAORDU() D BMES^XPDUTL("Postinit will not run, No CPRS Order Dialogue file 101.4") Q
 S ZTDESC="RA*5*50 - postinit to update Orderable Items file (#101.43) from RAD/NUC MED PROCEDURES FILE (#71)"
 S ZTRTN="DEQUE^RA50PST",ZTIO=""
 S ZTDTH=$G(XPDQUES("POS001 POSTINIT TIME")) S:+ZTDTH=0 ZTDTH=DT
 D ^%ZTLOAD
 S RAMSG=$S($G(ZTSK):"The job is scheduled by task "_ZTSK,1:"The job has not been queued")
 D BMES^XPDUTL(RAMSG)
 I $G(ZTSK) D BMES^XPDUTL("Scheduled for "_XPDQUES("POS001 POSTINIT TIME","B"))
 Q 
DEQUE ; loop procedures to locate message and then send to CPRS
 S ZTREQ="@"
 N RADA,RAINADT,RASTAT,RAFILE,RAY,RAENALL
 K ^TMP($J)
 S RADA=0,CNT=0 F  S RADA=$O(^RAMIS(71,RADA)) Q:RADA'>0  D
 . Q:'$D(^RAMIS(71,RADA,3,"B"))
 . S RAINADT=+$G(^RAMIS(71,RADA,"I"))
 . I RAINADT,RAINADT<DT Q  ;procedure will update CPRS when activated
 . S RASTAT="1^1",RAENALL=0,RAY=RADA,RAFILE=71,CNT=CNT+1
 . D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY) ;as found in RAMAIN2
 . S ^TMP($J,CNT+6)=$J(RADA,8)_"   "_$$GET1^DIQ(71,RADA,.01)
 S ^TMP($J,1)="RA*5*50 Postinit - Procedure Update of Orderable Item file Report"
 S ^TMP($J,2)=" "
 S ^TMP($J,2)="    Please forward this email to the Radiology ADPAC."
 S ^TMP($J,4)="    RAD/NUC MED PROCEDURE file (# 71)"
 S ^TMP($J,5)="# 71 IEN   RA Procedure/Orderable Item         Total Updated = "_CNT
 S ^TMP($J,6)=" "
 S XMSUB="RA*5*50 Postinit - Procedure Update of Orderable Item file Report"
 S XMTEXT="^TMP($J,"
 S XMY(DUZ)="",XMDUZ="RA*5*50 POSTINIT"
 D ^XMD
 K ^TMP($J)
 Q
