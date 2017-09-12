MAGIPS54 ;Post init routine to queue site activity at install. ; 09/11/2008 02:17 pm
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
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
 F DIU=2006.589 D
 . S DIU(0)="" D EN^DIU2
 . Q
 K ^MAGDICOM(2006.589)
 Q
 ;
POST N CVT,OPT
 ;  1. Add RPCs to Secondary menu(s)
 ;  2. Convert tables
 ;  3. Run INIT^MAGDRUID (create UID root)
 ;  4. Remove any dangling cross references from #2006.575
 ;
 F OPT="MAG DICOM GATEWAY FULL","MAG DICOM GATEWAY VIEW" D
 . ; Don't ADDRPC("MAG DICOM CHECK MACHINE ID",OPT) ; removed at site
 . D ADDRPC("MAG DICOM GET MACHINE ID",OPT)
 . D ADDRPC("MAG DICOM GET UID ROOT",OPT)
 . ; Don't ADDRPC("MAG DICOM UPDATE MACHINE ID",OPT) ; removed at site
 . D ADDRPC("MAG GET SOP CLASS METHOD",OPT)
 . Q
 ;
 D  ; Convert Tables:
 . ; 2006.5641 (Gateway Registry)
 . ; 2006.5715 (Last Image UID)
 . ;
 . ; NOTE: The code below is such that if this routine
 . ;       is run multiple times, the 2nd and later times
 . ;       are no-ops.
 . ;
 . N D0,ID,HN,HOST,L,LO,LOC,N,NA,UID,UP,X
 . S LO="abcdefghijklmnopqrstuvwxyz"
 . S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 . S D0=0 F  S D0=$O(^MAGDICOM(2006.5641,D0)) Q:'D0  D
 . . S X=$G(^MAGDICOM(2006.5641,D0,0)),ID=$P(X,"^",1),NA=$P(X,"^",2)
 . . Q:ID  ; Entry is already converted
 . . S HN=$TR(NA,LO,UP)
 . . D:ID'=""
 . . . K ^MAGDICOM(2006.5641,"B",ID,D0)
 . . . S ^MAGDICOM(2006.5641,"B",D0,D0)=""
 . . . S $P(^MAGDICOM(2006.5641,D0,0),"^",1,2)=D0_"^"_HN
 . . . S HOST(ID)=HN
 . . . Q
 . . D:NA'=""
 . . . K ^MAGDICOM(2006.5641,"C",NA,D0)
 . . . S ^MAGDICOM(2006.5641,"C",HN,D0)=""
 . . . Q
 . . Q
 . S (N,L,D0)=0 F  S D0=$O(^MAGD(2006.5715,D0)) Q:'D0  D
 . . S X=$G(^MAGD(2006.5715,D0,0)),UID=$P(X,"^",2),X=$P(X,"^",1)
 . . Q:X'?1U  ; Entry is empty or already converted
 . . I X'="" K ^MAGD(2006.5715,"B",X,D0) S X=$G(HOST(X))
 . . I X="" K ^MAGD(2006.5715,D0) Q
 . . S N=N+1,L=D0,^MAGD(2006.5715,D0,0)=X_"^"_UID
 . . S ^MAGD(2006.5715,"B",X,D0)=""
 . . Q
 . S ^MAGD(2006.5715,0)="CURRENT IMAGE^2006.5715^"_L_"^"_N
 . Q
 ;
 D INIT^MAGDRUID
 D UPDATE
 ;
 D  ; Add shortcuts to DICOM Correct
 . N FDA,IEN,LBL,MSG,SUB
 . S SUB(1)="MAGD FIX DICOM FILE",LBL(1)="RAD"
 . S SUB(2)="MAGD FIX CLINSPEC DICOM FILE",LBL(2)="CLN"
 . D FIND^DIC(19,"",".001","","MAGD DICOM MENU","","B","","","LST","MSG")
 . S LST="" F  S LST=$O(LST("DILIST",2,LST)) Q:LST=""  D
 . . F SUB=1,2 D
 . . . K FDA,IEN,MSG
 . . . S FDA(19.01,"?1,"_LST("DILIST",2,LST)_",",.01)=SUB(SUB)
 . . . S FDA(19.01,"?1,"_LST("DILIST",2,LST)_",",2)=LBL(SUB)
 . . . D UPDATE^DIE("E","FDA","IEN","MSG")
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
 K ^MAGD(2006.575) S ^MAGD(2006.575,0)="DICOM FAILED IMAGES^2006.575" ; remove any vestigal nodes
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
UP(X) ; special UPPER CASE function -- removes redundant blanks as well
 F  Q:X'["  "  S $E(X,$F(X,"  ")-1)=""  ; remove redundant blank
 I $E(X)=" " S $E(X)=""  ; remove leading blank
 I $E(X,$L(X))=" " S $E(X,$L(X))=""  ; remove trailing blank
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz^|","ABCDEFGHIJKLMNOPQRSTUVWXYZ~~")
 ;
UPDATE ;Update description for menu option
 N IEN
 S IEN=$$FIND1^DIC(19,"","X","MAGD DICOM MENU","","","")
 I 'IEN D BMES^XPDUTL("Menu option MAGD DICOM MENU is undefined in the Option file!") Q
 S ^TMP($J,"WP",1)="Menu to allow correcting of DICOM Image file references that failed"
 S ^TMP($J,"WP",2)="the matching process during the initial DICOM image acquistion."
 D WP^DIE(19,IEN_",",3.5,"","^TMP($J,""WP"")","MAGMSG")
 I $D(MAGMSG) D BMES^XPDUTL("Error setting the description field for MAGD DICOM MENU")
 K ^TMP($J,"WP")
 Q
 
