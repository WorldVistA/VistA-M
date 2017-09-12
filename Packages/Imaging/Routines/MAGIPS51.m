MAGIPS51 ;Post init routine to queue site activity at install. ; 06/09/2005  09:45
 ;;3.0;IMAGING;**51**;26-August-2005
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
 N DIU
 ; Remove obsolete DD definitions
 F DIU=2006.574,2006.575,2006.5762,2006.587 D
 . S DIU(0)="" D EN^DIU2
 . Q
 ; File-roots can be left.
 Q
 ;
POST N CVT
 ; 1. Convert simple pointers to variable pointers
 ; 2. Add RPCs to secondary menus
 ; 3. Clean up obsolete cross-references
 ; 4. Clean up obsolete FileMan header
 ; 5. Create missing PT pointers (QA issue)
 ; 6. Pre-populate AutoRoute Prior Studies table
 ; 7. Re-Cross-Reference file # 2006.587
 ; 8. Send confirmation message
 ;
 D  ; Pointer Conversion
 . N D0,DE,H1,H2,IM,N,OR,PR,ST,T,TY,X
 . S H1=$H L +^MAGQUEUE(2006.035):1E9 ; Background process MUST wait.
 . W !,"Starting correction of variable pointers in SEND QUEUE."
 . K ^MAGQUEUE(2006.035,"DEST")
 . K ^MAGQUEUE(2006.035,"STS")
 . S N=0,D0=0 F  S D0=$O(^MAGQUEUE(2006.035,D0)) Q:'D0  D
 . . S X=$G(^MAGQUEUE(2006.035,D0,1)),N=N+1
 . . S ST=$P(X,"^",1),PR=$P(X,"^",2)
 . . S X=$G(^MAGQUEUE(2006.035,D0,0))
 . . S IM=$P(X,"^",1),DE=$P(X,"^",2),TY=$P(X,"^",3)
 . . S ME=$P(X,"^",4),OR=$P(X,"^",5)
 . . I DE,ME=1 S DE=(+DE)_";MAG(2005.2,"
 . . I DE,ME=2 S DE=(+DE)_";MAG(2006.587,"
 . . I 'DE!(DE'[";") S DE=""
 . . S $P(X,"^",2)=DE,^MAGQUEUE(2006.035,D0,0)=X
 . . Q:DE=""  Q:ST=""
 . . I IM'="",TY'="" S ^MAGQUEUE(2006.035,"DEST",DE,ST,IM,TY,D0)=""
 . . I OR'="",PR'="" S ^MAGQUEUE(2006.035,"STS",OR,ST,PR,DE,D0)=""
 . . Q
 . L -^MAGQUEUE(2006.035)
 . S H2=$H,H1=H1*86400+$P(H1,",",2),H2=H2*86400+$P(H2,",",2)
 . S X=H2-H1,CVT=N_" entr"_$S(N=1:"y",1:"ies")_" in "
 . S T=X\3600 S:T CVT=CVT_T_" hour" S:T>1 CVT=CVT_"s"
 . S T=X\60#60 I T S:CVT'="" CVT=CVT_", " S SVT=CVT_T_" minute" S:T>1 CVT=CVT_"s"
 . S T=X#60 I T S:CVT'="" CVT=CVT_", " S SVT=CVT_T_" second" S:T>1 CVT=CVT_"s"
 . S:'X CVT=CVT_"less than 1 second."
 . Q
 ;
 D ADDRPC("MAG CFIND QUERY","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG STUDY UID QUERY","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG DICOM CHECK MACHINE ID","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG DICOM UPDATE MACHINE ID","MAG DICOM GATEWAY FULL")
 D ADDRPC("MAG VISTA CHECKSUMS","MAG DICOM GATEWAY FULL")
 ;
 D ADDRPC("MAG CFIND QUERY","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG STUDY UID QUERY","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG DICOM CHECK MACHINE ID","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG DICOM UPDATE MACHINE ID","MAG DICOM GATEWAY VIEW")
 D ADDRPC("MAG VISTA CHECKSUMS","MAG DICOM GATEWAY VIEW")
 ;
 F X="C","DPAT","E" K ^MAGD(2006.575,X)
 K ^MAGDICOM("HL7")
 ;
 S ^DD(2006.587,0,"PT",2005.0111,3)=""
 S ^DD(2006.587,0,"PT",2005.1111,3)=""
 ;
 D  ; Pre-populate AutoRoute Prior Studies Table
 . N A,D0,D1,X
 . S D0=0 F  S D0=$O(^MAG(2006.65,D0)) Q:'D0  D
 . . S D1=0 F  S D1=$O(^MAG(2006.65,D0,1,D1)) Q:'D1  D
 . . . S X=$G(^MAG(2006.65,D0,1,D1,0)),A=0
 . . . I $P(X,"^",2)="" S:$P(X,"^",5) $P(X,"^",2)=$P(X,"^",5),A=1
 . . . I $P(X,"^",3)="" S $P(X,"^",3)=1800,A=1
 . . . I $P(X,"^",4)="" S $P(X,"^",4)=1,A=1
 . . . S:A ^MAG(2006.65,D0,1,D1,0)=X
 . . . Q
 . . Q
 . Q
 ;
 ; Re-Crossreference
 ;
 F X="B","C","D" K ^MAG(2006.587,X)
 S DIK="^MAG(2006.587," D IXALL^DIK
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
