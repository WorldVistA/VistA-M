MAGIPS50 ;Post init routine to queue site activity at install. ; 10/25/2005  10:01
 ;;3.0;IMAGING;**50**;26-May-2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
PRE ;
 ; 1. Remove mis-numbered field from ^DD
 ;
 S DIK="^DD(2005,",DA=112,DA(1)=2005 D ^DIK
 Q
 ;
POST N CVT
 ; 1. Add RPCs to secondary menus
 ; 2. Re-cross-reference file # 2006.574
 ; 3. Send confirmation message
 ;
 ;
 D ADDRPC("MAG DICOM GET ICN","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG NEW SOP INSTANCE UID","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG RAD GET NEXT RPT BY DATE","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG RAD GET NEXT RPT BY PT","MAG DICOM GATEWAY FULL")
 ;
 D ADDRPC("MAG DICOM GET ICN","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG NEW SOP INSTANCE UID","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG RAD GET NEXT RPT BY DATE","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG RAD GET NEXT RPT BY PT","MAG DICOM GATEWAY VIEW")
 ;
 D  ; Re-cross-reference
 . N D0,D1,LOC,PRI,STS,X
 . K ^MAGDOUTP(2006.574,"STS")
 . S D0=0 F  S D0=$O(^MAGDOUTP(2006.574,D0)) Q:'D0  D
 . . S X=$G(^MAGDOUTP(2006.574,D0,0)),LOC=$P(X,"^",4),PRI=$P(X,"^",5)
 . . S:'PRI PRI=500
 . . S D1=0 F  S D1=$O(^MAGDOUTP(2006.574,D0,1,D1)) Q:'D1  D
 . . . S STS=$P($G(^MAGDOUTP(2006.574,D0,1,D1,0)),"^",2)
 . . . I LOC'="",STS'="" S ^MAGDOUTP(2006.574,"STS",LOC,PRI,STS,D0,D1)=""
 . . . Q
 . . Q
 . Q
 ;
 D  ; Confirmation message
 . N CT,CNT,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY
 . ;
 . D GETENV^%ZOSV
 . S CNT=0
 . S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 . S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 . S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XPDNM
 . S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XPDNM)
 . S ST=$$GET1^DIQ(9.7,XPDA,11,"I")
 . S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 . S CT=$$GET1^DIQ(9.7,XPDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT()
 . S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 . S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 . S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 . S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_$$GET1^DIQ(9.7,XPDA,6,"I")
 . S CNT=CNT+1,MAGMSG(CNT)="DATE: "_$$NOW^XLFDT()
 . S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,XPDA,9,"E")
 . S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,XPDA,.01,"E")
 . S DDATE=$$GET1^DIQ(9.7,XPDA,51,"I")
 . S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 . S:$G(CVT)'="" CNT=CNT+1,MAGMSG(CNT)="Conversion time: "_CVT
 . S XMSUB=XPDNM_" INSTALLATION"
 . S XMID=$G(DUZ) S:'XMID XMID=.5
 . S XMY(XMID)=""
 . S XMY("G.MAG SERVER")=""
 . S:$G(MAGDUZ) XMY(MAGDUZ)=""
 . S XMSUB=$E(XMSUB,1,63)
 . D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 . I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 . Q
 Q
 ;
ADDRPC(RPCNAME,OPTNAME) N DA,DIC
 S DIC="^DIC(19,",DIC(0)="",X=OPTNAME D ^DIC
 I Y<0 D  Q
 . W !,"Cannot add """_RPCNAME_""" to """_OPTNAME_"""."
 . W !,"Cannot find """_OPTNAME_"""."
 . Q
 S DA(1)=+Y
 S DIC=DIC_DA(1)_",""RPC"","
 S DIC(0)="L" ; LAYGO should be allowed here
 S X=RPCNAME
 D ^DIC
 I Y<0 D  Q
 . W !,"Cannot add """_RPCNAME_""" to """_OPTNAME_"""."
 . W !,"Cannot find """_RPCNAME_"""."
 . Q
 Q
 ;
