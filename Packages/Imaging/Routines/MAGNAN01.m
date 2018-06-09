MAGNAN01 ;WOIFO/NST - IMAGING ANNOTATION UTILITY RPCS ; 28 Jul 2017 11:43 AM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;***** STORES THE DETAIL OF STUDY ANNOTATION
 ;
 ; RPC: MAGN ANNOT STORE STUDY
 ;
 ; .MAGOUT       Reference to a local variable where the results are returned to
 ; .MAGPARAM
 ;    MAGPARAM("STUDY UID")
 ;    MAGPARAM("PSTATE UID")
 ;    MAGPARAM("NAME")
 ;    MAGPARAM("SOURCE")
 ;    MAGPARAM("TOOL VERSION")
 ;    MAGPARAM(1..n)  Annotation Data (XML/JSON)
 ;
 ; Return Values
 ; =============   
 ; MAGOUT(0) is defined and its 1st '^'-piece is 0, then an error
 ;   occurred during execution of the procedure.
 ; MAGOUT(0) = Success status - success 
 ;             Failure status - error
STORE(MAGOUT,MAGPARAM) ;RPC [MAGN ANNOT STORE STUDY]
 N MAGNFDA,MAGNXE,IENS,STUDYIEN,STUDYID,PSTATIEN,PSTATUID,EXIT
 ;
 ; Set input variables
 S STUDYID=$G(MAGPARAM("STUDY UID"))
 S PSTATUID=$G(MAGPARAM("PSTATE UID"))
 ;
 K MAGOUT
 S MAGOUT(0)=$$SETERROR^MAGNU002("")
 I '$G(DUZ) S MAGOUT(0)=$$SETERROR^MAGNU002("No DUZ defined") Q
 I STUDYID="" S MAGOUT(0)=$$SETERROR^MAGNU002("No STUDYID") Q
 I PSTATUID="" S MAGOUT(0)=$$SETERROR^MAGNU002("No PSTATEUID") Q
 S STUDYIEN=$$FIND1^DIC(2005.003,"","X",STUDYID,"","","MAGNXE")
 I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) Q   ; Set MAGOUT and quit if error exists
 I 'STUDYIEN D  ; Create Study record
 . S IENS="+1,"
 . S MAGNFDA(2005.003,IENS,.01)=STUDYID
 . D UPDATE^DIE("","MAGNFDA","MAGNIEN","MAGNXE")
 . I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) Q
 . ; What is the Image IEN D ENTRY^MAGLOG("MAG ANNOT",$G(DUZ),IEN,"MAG IMAGE ANNOTATION","","1",$G(SOURCE,"CLINIC")) ;log annotation
 . S STUDYIEN=MAGNIEN(1)
 . Q
 ;
 I $D(MAGNXE) Q  ; MAGOUT is aleady set with the error
 ;
 S PSTATIEN=$$FIND1^DIC(2005.0031,","_STUDYIEN_",","X",PSTATUID,"","","MAGNXE")
 I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) Q  ; Set MAGOUT and quit if error exists
 ;
 I 'PSTATIEN D  Q  ; Create a new annotation record for the study and quit
 . S PSTATIEN=$$UPDATE(.MAGOUT,STUDYIEN,"+2",.MAGPARAM)
 . Q
 ;
 I $G(MAGPARAM("DELETED")) D  Q
 . S EXIT=$$DELANNOT(.MAGOUT,STUDYIEN,PSTATIEN)
 . Q
 ;
 S EXIT=$$UPDATE(.MAGOUT,STUDYIEN,PSTATIEN,.MAGPARAM)
 ; MAGOUT is set at this point
 Q
 ; 
UPDATE(MAGOUT,IEN0,IEN1,MAGPARAM) ; Add new annotation data node w/ DUZ, version, data ...
 N ANNOT,ANSITE,ANSERV,STUDYID,PSTATUID,NAME,SOURCE,VER
 N I,MAGNFDA,MAGNIEN,MAGNXE
 ;
 ; Set input variables
 S PSTATUID=$G(MAGPARAM("PSTATE UID"))
 S NAME=$G(MAGPARAM("NAME"))
 S SOURCE=$G(MAGPARAM("SOURCE"))
 S VER=$G(MAGPARAM("TOOL VERSION"))
 S I=0
 F  S I=$O(MAGPARAM(I)) Q:'I  D
 . S ANNOT(I)=MAGPARAM(I)
 . Q
 ;
 S ANSITE=$G(DUZ(2))  ; Annotation Site
 S ANSERV=$$GET1^DIQ(200,DUZ,29,"E")  ; Annotation service
 ;
 S IENS=IEN1_","_IEN0_","
 S:$E(IEN0)'="+" MAGNIEN(1)=IEN0
 S:$E(IEN1)'="+" MAGNIEN(2)=IEN1
 K MAGNFDA
 S MAGNFDA(2005.0031,IENS,.01)=$G(MAGPARAM("PSTATE UID"))
 S MAGNFDA(2005.0031,IENS,1)=DUZ           ;ANNOTATOR
 S:$D(ANNOT) MAGNFDA(2005.0031,IENS,2)=$$NOW^XLFDT() ;SAVE D/T
 S:VER'="" MAGNFDA(2005.0031,IENS,3)=VER           ;VERSION
 S MAGNFDA(2005.0031,IENS,4)=$G(SOURCE,"CLINIC")
 S MAGNFDA(2005.0031,IENS,7)=$G(ANSERV)     ;SERVICE/SECTION
 S MAGNFDA(2005.0031,IENS,8)=$G(ANSITE)     ;SITE
 S:NAME'="" MAGNFDA(2005.0031,IENS,9)=NAME           ;Annotation name
 D UPDATE^DIE("","MAGNFDA","MAGNIEN","MAGNXE")
 I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) Q 0
 ;
 I '$D(ANNOT) Q MAGNIEN(2)
 S IENS=MAGNIEN(2)_","_IEN0_","
 ; Annotation data 2005.003 field #6
 D WP^DIE(2005.0031,IENS,6,"","ANNOT","MAGNXE")
 I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) D  Q 0
 . N DA,DIK
 . ; clean up data
 . S DIK="^MAG(2005.003,"_IEN0_",1,",DA=IEN1,DA(1)=IEN0
 . D ^DIK
 . Q
 ;
 Q MAGNIEN(2)
 ;
DELANNOT(MAGOUT,IEN0,IEN1)  ; Set Deleted flag
 N IENS,MAGNFDA,MAGNIEN,MAGNXE
 ;
 S IENS=IEN1_","_IEN0_","
 K MAGNFDA
 S MAGNFDA(2005.0031,IENS,5)=1
 D UPDATE^DIE("","MAGNFDA","MAGNIEN","MAGNXE")
 I $$ISERROR^MAGNU002(.MAGOUT,.MAGNXE) Q 0
 ;
 Q 1
