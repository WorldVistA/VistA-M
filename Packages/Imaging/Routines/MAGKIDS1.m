MAGKIDS1 ;WOIFO/SG - INSTALLATION UTILITIES ; 3/9/09 12:52pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
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
 ; This routine uses the following ICRs:
 ;
 ; #3232         Read access to file #9.7 (private)
 ; #4389         Read access to file #9.7 (private)
 ; #10075        R/W access to subfile #19.05 (supported)
 ; #4011         Read access to file #8994 (controlled)
 ;
 ; ??? - #4389 has to be updated to include fields 9, 11,
 ;       and 17 of the file #9.7!
 Q
 ;
 ;##### ADDS RPC NAME(S) TO THE RPC MULTIPLE OF THE OPTION
 ;
 ; [.]RPCNAMES   Names of the remote procedures:
 ;
 ;                 * Single name can be passed by value;
 ;
 ;                 * One or more names can be passed as subscripts of 
 ;                   a local array passed by reference;
 ;
 ;                 * A reference to the list of RPC names in the
 ;                   source code of an routine can be passed as
 ;                   the TAG^ROUTINE value of the RPCNAMES. The
 ;                   routine must be in the MAG namespace.
 ;
 ; OPTNAME       Name of the option (RPC Broker context)
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  If this flag is provided, the procedure will
 ;                    work in "silent" mode. Nothing will be
 ;                    displayed on the console or stored into the
 ;                    INSTALLATION file (#9.7).
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;
ADDRPCS(RPCNAMES,OPTNAME,FLAGS) ;
 N IENS,MAGFDA,MAGMSG,MAGRC,NAME,OPTIEN,RPCIEN,SILENT
 ;
 ;=== Validate and prepare parameters
 S FLAGS=$G(FLAGS),SILENT=(FLAGS["S")
 ;--- Single RPC name or a list?
 I $D(RPCNAMES)<10  Q:$G(RPCNAMES)?." " $$IPVE^MAGUERR("RPCNAMES")  D
 . N I,GET
 . ;--- TAG^ROUTINE or single RPC name?
 . I RPCNAMES'?1.8UN1"^MAG"1.5UN  S RPCNAMES(RPCNAMES)=""  Q
 . ;--- Get the list from the source code
 . S GET=$P(RPCNAMES,"^")_"+I^"_$P(RPCNAMES,"^",2)
 . S GET="S NAME=$$TRIM^XLFSTR($P($T("_GET_"),"";;"",2))"
 . F I=1:1  X GET  Q:NAME=""  S RPCNAMES(NAME)=""
 . Q
 ;--- Name of the menu option (RPC Broker context)
 S OPTIEN=$$LKOPT^XPDMENU(OPTNAME)
 Q:OPTIEN'>0 $$ERROR^MAGUERR(-44,,OPTNAME)
 ;
 ;=== Add the names to the multiple
 D:'SILENT BMES^MAGKIDS("Attaching RPCs to the '"_OPTNAME_"' option...")
 S NAME="",MAGRC=0
 F  S NAME=$O(RPCNAMES(NAME))  Q:NAME=""  D  Q:MAGRC<0
 . D:'SILENT MES^MAGKIDS(NAME)
 . ;--- Check if the remote procedure exists
 . S RPCIEN=$$FIND1^DIC(8994,,,NAME,"B",,"MAGMSG")
 . I $G(DIERR)  S MAGRC=$$DBS^MAGUERR("MAGMSG",8994)  Q
 . I RPCIEN'>0  S MAGRC=$$ERROR^MAGUERR(-45,,NAME)  Q
 . ;--- Add the remote procedure to the multiple
 . S IENS="?+1,"_OPTIEN_","
 . S MAGFDA(19.05,IENS,.01)=RPCIEN
 . D UPDATE^DIE(,"MAGFDA",,"MAGMSG")
 . I $G(DIERR)  S MAGRC=$$DBS^MAGUERR("MAGMSG",19.05,IENS)  Q
 . ;---
 . Q
 I MAGRC<0  D:'SILENT MES^MAGKIDS("ABORTED!")  Q MAGRC
 ;
 ;=== Success
 D:'SILENT MES^MAGKIDS("RPCs have been successfully attached.")
 Q 0
 ;
 ;##### SENDS THE PATCH INSTALLATION E-MAIL
 ;
 ; [MAGDUZ]      IEN of the user who will get the e-mail in
 ;               addition to the G.MAG SERVER mail group.
 ;
 ; Input variables
 ; ===============
 ;  XPDA, XPDNM
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ; Notes
 ; =====
 ;
 ; This entry point should be called ONLY from the KIDS post-install
 ; code.
 ;
 ; This entry point can also be called as a procedure:
 ; D NOTIFY^MAGKIDS1() if you do not need its return value.
 ;
NOTIFY() ;
 N CNT,CT,IENS,MAGBUF,MAGERR,MAGMSG,MAGRC,ST,Y
 S MAGRC=0,IENS=XPDA_","
 ;
 ;--- Load the build properties from the BUILD file (#9.7)
 D GETS^DIQ(9.7,IENS,".01;6;9;11;17;51","EI","MAGBUF","MAGERR")
 D:$G(DIERR) DBS^MAGUERR("MAGERR",9.7,IENS)
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
 . S MAGRC=$$ERROR^MAGUERR(-46,.MAGERR)
 . Q
 ;
 ;---
 Q:$QUIT MAGRC  Q
 ;
 ;##### TURNS THE VERSION CHECKING ON FOR CLINICAL CLIENTS
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  If this flag is provided, the procedure will
 ;                    work in "silent" mode. Nothing will be
 ;                    displayed on the console or stored into the
 ;                    INSTALLATION file (#9.7).
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ; Notes
 ; =====
 ;
 ; This entry point can also be called as a procedure:
 ; D VERCHKON^MAGKIDS1() if you do not need its return value.
 ;
VERCHKON(FLAGS) ;
 N MAGIEN,MAGMSG,MAGRC,MSG1,MSG2,SILENT,TMP
 S FLAGS=$G(FLAGS),SILENT=(FLAGS["S")
 D:'SILENT
 . S TMP=+$P($G(XPDNM),"*",3)  ; Patch number
 . S MSG1=$S(TMP:"Patch "_TMP_" is turning",1:"Turning")
 . S MSG1=MSG1_" Version Checking ON..."
 . D MES^MAGKIDS("")
 . Q
 S MAGRC=0
 ;===
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2006.1,MAGIEN))  Q:'MAGIEN  D  Q:MAGRC<0
 . S MSG2="is already ON, no action taken"
 . ;--- Turn the version checking ON for the site
 . I '$P($G(^MAG(2006.1,MAGIEN,"KEYS")),U,5)  D  Q:MAGRC<0
 . . N MAGFDA
 . . S MAGFDA(2006.1,MAGIEN_",",130)=1
 . . D FILE^DIE(,"MAGFDA","MAGMSG")
 . . I $G(DIERR)  S MAGRC=$$DBS^MAGUERR("MAGMSG",2006.1,MAGIEN_",")  Q
 . . S MSG2="has been turned ON"
 . . Q
 . Q:SILENT
 . ;--- Display the status message
 . S TMP=$P($G(^MAG(2006.1,MAGIEN,0)),U)  ; Institution IEN
 . D MES^MAGKIDS(MSG1)
 . D MES^MAGKIDS("Version Checking "_MSG2_" for Site: "_TMP)
 . Q
 ;===
 Q:$QUIT MAGRC  Q
