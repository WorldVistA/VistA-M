MAGNUTL2 ;WOIFO/NST - VistRad subroutines for RPC calls ; OCT 22, 2018@1:42PM
 ;;3.0;IMAGING;**201**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ; Subroutines for pre-cache exams images
 ; Entry Points:
 ;   PRECACHE -- Subroutine call via Protocol trigger
 ;
PRECACHE ; Entry point from HL7 processing, to initiate precache at
 ; time of radiology "Register Patient for Exam" RA REG protocol
 ; Do not process if the exam is being Canceled (RACANC true)
 ;
 Q:'$$GET^XPAR("ALL","MAG PRECACHE RAD REG ENABLED",,"I")  ; IA# 2263 
 ;
 N RET S RET=""
 I '($G(RADFN)&$G(RADTI)&$G(RACNI)&'$G(RACANC)) Q  ; Required vars
 ; MAGJEX2 will call CACHE^MAGNUTL2 after collecting all images to be precached - "C" is a new action
 D PRIOR1^MAGJEX2(.RET,"C"_U_RADFN_U_RADTI_U_RACNI)
 Q
 ;
CACHE(RARPT) ; cache this case's images
 ; Input: RARPT: IEN in RAD/NUC MED REPORTS file (#74)
 ;
 N MAGOUT
 D NWRKITEM(.MAGOUT,RARPT)
 Q 1
 ;
NWRKITEM(MAGOUT,RARPT) ;Create New MAG WORK ITEM
 ; RARPT - IEN in RAD/NUC MED REPORTS file (#74)
 ;
 N CRTUSR,CRTAPP,DFN,ICN,J,MAGCTXID,MSGTAGS,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,SSEP
 ;
 S SSEP="`"
 S MAGCTXID=$$RACPRS^MAGNU003(RARPT) ; Radiology CPRS context
 I MAGCTXID="" S MAGOUT=-20_SSEP_"CPRS context is blank"
 S DFN=$$GET1^DIQ(74,RARPT,2,"I")
 ;
 S PLACEID=DUZ(2)
 ;
 ; TAGS
 S J=0
 S J=J+1,MSGTAGS(J)="contextID`"_$TR(MAGCTXID,"^","~")  ;CPRS Report Context ID and translate ^ to ~
 S:DFN J=J+1,MSGTAGS(J)="patientDfn`"_DFN
 I $L($T(GETICN^MPIF001)) D
 . S ICN=$$GETICN^MPIF001(DFN)
 . S:ICN>1 J=J+1,MSGTAGS(J)="patientIcn`"_ICN
 . Q
 S J=J+1,MSGTAGS(J)="registration`1"     ; precache flag
 ;
 S TYPE="PRECACHE"
 S SUBTYPE="REGISTRATION"
 S STATUS="New"
 S PRIORITY=0
 ;
 S PLACEID=$$STA^XUAF4(PLACEID) ;IA # 2171
 ;
 S CRTUSR=DUZ  ; CREATED BY
 ;
 S CRTAPP="PRECACHE"  ; CAPTURE APPLICATION
 ;
 D CRTITEM^MAGVIM01(.MAGOUT,TYPE,SUBTYPE,STATUS,PLACEID,PRIORITY,.MSGTAGS,CRTUSR,CRTAPP)
 Q
