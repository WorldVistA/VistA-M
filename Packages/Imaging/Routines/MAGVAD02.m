MAGVAD02 ;WOIFO/NST - Delete records in storage files ; 11 Mar 2010 4:39 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;*****  Mark an artifact as deleted in ARTIFACT file (#2006.916)
 ;       
 ; RPC: N/A
 ; 
 ; Input Parameters
 ; ================
 ;   TOKEN = ARTIFACT TOKEN field (#2006.916,01) 
 ;   DELAPP = DELETING APPLICATION field (#2006.916,9) 
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY = Failure status ^ Error message ^
 ; if success MAGRY = Success Status
 ; 
DELAFACT(MAGRY,TOKEN,DELAPP) ; RPC [N/A]
 N IEN,RES,FILE,PFILE,MAGPARAM,ADELETED
 D GETAIENT^MAGVAG02(.RES,TOKEN,"") ; Get Artifact IEN by Token
 I '$$ISOK^MAGVAF02(RES) S MAGRY=RES Q
 S MAGPARAM("PK")=$$GETVAL^MAGVAF02(RES)  ; IEN of the record in ARTIFACT file (#2006.916)
 ;
 S FILE=2006.916  ; ARTIFACT file
 ;
 ; Get deleting application or create a new one
 S PFILE=$$GETFILEP^MAGVAF05(FILE,"DELETING APPLICATION")  ; the file that field points to
 S MAGRY=$$GETIEN^MAGVAF05(PFILE,DELAPP,1)
 I '$$ISOK^MAGVAF02(MAGRY) Q  ; Quit if error. MAGRY is already set
 S MAGPARAM("DELETING APPLICATION")=$$GETVAL^MAGVAF02(MAGRY)  ; Set the internal value
 S MAGPARAM("DELETED DATE/TIME")=$$NOW^XLFDT
 ;
 D UPDRCD^MAGVAF01(.MAGRY,FILE,.MAGPARAM) ; Mark artifact as deleted
 Q
