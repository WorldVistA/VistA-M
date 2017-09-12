MAGIP114  ;WOIFO/NST - INSTALL CODE FOR MAG*3.0*114 ; 22 Jun 2010 10:13 AM
 ;;3.0;IMAGING;**114**;Mar 19, 2002;Build 1827;Aug 17, 2010
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
 ; There are no environment checks here but the MAGIP114 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
PRE ;
 Q
 ;
POS ;
 D ADDRPC()  ; Link new remote procedures to the Broker context option
 D RPTSKCP() ; Restart the Imaging Utilization Report task
 D NOTIFY()  ; Send the notification e-mail
 Q
 ;
ADDRPC() ;
 N RPCNAMES,NAME,RPCIEN,IENS,OPTIEN,I,GET,MAGFDA,DIERR
 ;  1. Add RPCs to Secondary menu(s)
 ;
 S OPTIEN=$$LKOPT^XPDMENU("MAG WINDOWS")
 I OPTIEN'>0 W !,"Error getting ""MAG WINDOWS"" context" Q
 ; 
 S RPCNAMES="RPCLST^"_$T(+0)
 ;--- Get the list from the source code
 S GET=$P(RPCNAMES,"^")_"+I^"_$P(RPCNAMES,"^",2)
 S GET="S NAME=$$TRIM^XLFSTR($P($T("_GET_"),"";;"",2))"
 F I=1:1  X GET  Q:NAME=""  S RPCNAMES(NAME)=""
 ;
 S NAME=""
 F  S NAME=$O(RPCNAMES(NAME)) Q:NAME=""  D
 . ;--- Check if the remote procedure exists
 . S RPCIEN=$$FIND1^DIC(8994,,"X",NAME,"B",,"MAGMSG")
 . I $G(DIERR) Q
 . I RPCIEN'>0 Q
 . ;--- Add the remote procedure to the multiple
 . S IENS="?+1,"_OPTIEN_","
 . S MAGFDA(19.05,IENS,.01)=RPCIEN
 . D UPDATE^DIE(,"MAGFDA",,"MAGMSG")
 . I $G(DIERR) W !,"Error updating ""MAG WINDOWS"" context RPC="_NAME
 . ;---
 . Q
 Q
 ;
NOTIFY() ;
 N CNT,CT,IENS,MAGBUF,MAGERR,MAGMSG,MAGRC,ST,Y
 S MAGRC=0,IENS=XPDA_","
 ;
 ;--- Load the build properties from the BUILD file (#9.7)
 D GETS^DIQ(9.7,IENS,".01;6;9;11;17;51","EI","MAGBUF","MAGERR")
 I $G(DIERR) W !,"Error loading the build properties" Q
 ;
 ;--- Compile the message text
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XPDNM
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XPDNM)
 S ST=$G(MAGBUF(9.7,IENS,11,"I"))
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$G(MAGBUF(9.7,IENS,17,"I"))  S:+CT'=CT CT=$$NOW^XLFDT()
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 D GETENV^%ZOSV
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_$G(MAGBUF(9.7,IENS,6,"I"))
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_$$NOW^XLFDT()
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$G(MAGBUF(9.7,IENS,9,"E"))
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$G(MAGBUF(9.7,IENS,.01,"E"))
 S Y=$G(MAGBUF(9.7,IENS,51,"E"))
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_Y
 ;
 ;--- Send the e-mail notification
 D
 . N DIFROM,XMERR,XMID,XMSUB,XMY,XMZ
 . S XMSUB=$E(XPDNM_" INSTALLATION",1,63)
 . S XMID=$G(DUZ)  S:XMID'>0 XMID=.5
 . S (XMY(XMID),XMY("G.MAG SERVER"))=""
 . D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ)
 . Q:'$G(XMERR)
 . K MAGERR  M MAGERR=^TMP("XMERR",$J)
 . Q
 ;
 ;---
 Q
 ;
 ;+++++ LIST OF NEW REMOTE PROCEDURES
RPCLST ;
 ;;MAG3 TELEREADER ACQ SRVC SETUP
 ;;MAG3 TELEREADER PDR SRVC SETUP
 ;;MAG3 TELEREADER SITE SETUP
 ;;MAG3 TELEREADER READER LIST
 ;;MAG3 TELEREADER READER SETUP
 ;;MAG3 TELEREADER DHPS LIST
 ;;MAG3 SET TIMEOUT
 ;;MAGDDR GETS ENTRY DATA
 ;;MAGDDR LISTER
 ;;XWB DEFERRED RPC
 ;;XWB DEFERRED STATUS
 ;;XWB DEFERRED GETDATA
 ;;XWB DEFERRED CLEAR
 Q 0
 ;
 ;+++++ RESTARTS THE IMAGING UTILIZATION REPORT TASK
RPTSKCP() ;
 D REMTASK^MAGQE4,STTASK^MAGQE4
 Q 0
