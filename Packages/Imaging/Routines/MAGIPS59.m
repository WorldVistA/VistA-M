MAGIPS59 ;Post init routine to queue site activity at install ; 16 Feb 2004  2:41 PM
 ;;3.0;IMAGING;**59**;Mar 27, 2007;Build 20
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
POST ;
 ; create and send the site installation message
 D VERCHKON ; Turn on Version Checking
 D CR ; Run the Cross Reference on Field #2 SPEC LEVEL of File #2005.84
 ; Check for and display Users that are assigned the MAG WINDOWS Option
 ; but do not have either MAGDISP CLIN or MAGDISP ADMIN 
 D CHKKEY^MAGGTU9
 D REMTASK^MAGQE4
 D STTASK^MAGQE4
 D INS(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 D NEWRPC ; Add RPC's to the OPTION: MAG WINDOWS 
 D FIXTASK ; Task off the FIX^MAGGTUX process. 
 Q
NEWRPC ; Add new RPC's to MAG WINDOWS Option.
 D ADDRPC("MAG3 TIU CREATE ADDENDUM","MAG WINDOWS")
 D ADDRPC("MAG3 TIU LONG LIST OF TITLES","MAG WINDOWS")
 D ADDRPC("MAG3 TIU MODIFY NOTE","MAG WINDOWS")
 D ADDRPC("MAG3 TIU NEW","MAG WINDOWS")
 D ADDRPC("MAG3 TIU SIGN RECORD","MAG WINDOWS")
 D ADDRPC("MAG4 INDEX GET EVENT","MAG WINDOWS")
 D ADDRPC("MAG4 INDEX GET SPECIALTY","MAG WINDOWS")
 D ADDRPC("MAG4 INDEX GET TYPE","MAG WINDOWS")
 D ADDRPC("MAGG PAT INFO","MAG WINDOWS")
 D ADDRPC("TIU AUTHORIZATION","MAG WINDOWS")
 D ADDRPC("TIU LOAD BOILERPLATE TEXT","MAG WINDOWS")
 D ADDRPC("TIU IS THIS A CONSULT?","MAG WINDOWS")
 D ADDRPC("GMRC LIST CONSULT REQUESTS","MAG WINDOWS")
 D ADDRPC("MAG4 VERSION STATUS","MAG WINDOWS")
 D ADDRPC("MAGG IS DOC CLASS","MAG WINDOWS")
 Q 
 ; We add RPC to MAG WINDOWS Option this way instead of sending Option : MAG WINDOWS
 ; If we send MAG WINDOWS Option, the last one installed will overwrite others.
 ; ADDRPC copied from Patch 51, added the call "D MES^XPDUTL(" instead of "W !"
ADDRPC(RPCNAME,OPTNAME) ;
 N DA,DIC
 S DIC="^DIC(19,",DIC(0)="",X=OPTNAME D ^DIC
 I Y<0 D  Q
 . D MES^XPDUTL("Cannot add RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . D MES^XPDUTL("Cannot find Option: """_OPTNAME_""".")
 . Q
 I '$D(^XWB(8994,"B",RPCNAME)) D  Q
 . D MES^XPDUTL("Cannot add RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . D MES^XPDUTL("Cannot find RPC: """_RPCNAME_""".")
 . Q
 S DA(1)=+Y
 S DIC=DIC_DA(1)_",""RPC"","
 S DIC(0)="L" ; LAYGO should be allowed here
 S X=RPCNAME
 D ^DIC
 I Y<0 D  Q
 . D MES^XPDUTL("Error Adding RPC: """_RPCNAME_""" to Option: """_OPTNAME_""".")
 . Q
 Q
CR ; Run the Cross reference on Field #2 SPEC LEVEL 
 ; of File #2005.84 IMAGE INDEX FOR SPECIALTY/SUBSPECIALTY
 N DIK
 S DIK="^MAG(2005.84,"
 D IXALL2^DIK ;  Kill all cross references.
 D IXALL^DIK ; Set all cross references.
 Q
VERCHKON ; Turn on Version Checking at the Sites.
 ; We aren't forcing it to stay on, sites can turn it back off.
 N MAGIEN,MAGSITE,VERCHK,MSG
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2006.1,MAGIEN)) Q:'MAGIEN  D
 . S MSG="is already ON, no action taken"
 . S MAGSITE=$P($G(^MAG(2006.1,MAGIEN,0)),"^",1)
 . S VERCHK=$P($G(^MAG(2006.1,MAGIEN,"KEYS")),"^",5)
 . I 'VERCHK S $P(^MAG(2006.1,MAGIEN,"KEYS"),"^",5)=1 S MSG="has been turned ON"
 . D MES^XPDUTL("Patch 59 is turning Version Checking ON...")
 . D MES^XPDUTL("Version Checking "_MSG_" for Site: "_MAGSITE)
 Q
FIXTASK ; This will task off the FIX^MAGGTUX process that will fix the 
 ; Invalid INDEX VALUES in the Image File.
 N ANS
 S ZTDTH=$$NOW^XLFDT
 S ZTRTN="TASK^MAGGTUX",ZTDESC="VALIDATE IMAGE INDEX VALUES",ZTIO=""
 S ZTSAVE("COMMIT")=1,ZTSAVE("MAGN")="MAGGTUX",ZTSAVE("QUEUED")=1
 D ^%ZTLOAD
 D MES^XPDUTL("The Utility to Fix invalid Index Values in the entire")
 D MES^XPDUTL("Image File (#2005) has been Queued as TASK# : "_ZTSK)
 Q
INS(XP,DUZ,DATE,IDA) ;
 N CT,CNT,COM,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY
 D GETENV^%ZOSV
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XP
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XP)
 S ST=$$GET1^DIQ(9.7,IDA,11,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$$GET1^DIQ(9.7,IDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S COM=$$GET1^DIQ(9.7,IDA,6,"I")
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_COM
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_DATE
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,IDA,9,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,IDA,.01,"E")
 S DDATE=$$GET1^DIQ(9.7,IDA,51,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 S XMSUB=XP_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q
