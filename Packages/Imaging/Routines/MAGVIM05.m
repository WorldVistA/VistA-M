MAGVIM05 ;WOIFO/MAT,BT - Utilities for RPC calls for DICOM file processing ; 21 Jun 2013  5:04 PM
 ;;3.0;IMAGING;**118,138,164**;Mar 19, 2002;Build 35;Nov 09, 2016
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
 ;
 Q
 ;
 ;+++++ Wrap call to code underlying RPC: RAMAG EXAM COMPLETE & re-format output
 ;
 ; RPC: MAGV RAD STAT COMPLETE   Private IA #5072
 ;
 ; Inputs:
 ; =======
 ;
 ;  RETURN ...... variable to hold the results
 ;  RADPT ....... IEN of the RAD/NUC MED PATIENT file (#70)
 ;  RAEXAM1 ..... EXAM DATE (#.01) of the REGISTERED EXAMS sub-file (#70.02)
 ;  RAEXAM2 ..... IEN of the EXAMINATIONS sub-file (#70.03)
 ;  MAGVUSR ..... DUZ of the Importer 2 application user.
 ;  MAGVUSRDV ... DUZ(2) of the Importer 2 user.
 ;  RAIMGTYP .... TYPE OF IMAGING (#2) of the REGISTERED EXAMS sub-file (#70.02)
 ; [RASTDRPT] ... IEN of an entry in the STANDARD REPORTS file (#74.1)
 ;           ---- Next two are IEN(s) of entries in the DIAGNOSTIC CODES file(#78.3)
 ; [RADXPRIM]  .. Primary Diagnostic Code --> RAMISC Param PRIMDXCODE
 ; [RADXSCND] ... List of Secondary Diagnostic Codes --> RAMISC Param SECDXCODE
 ;  
 ; Outputs:
 ; ========
 ; 
 ; Notes:
 ; ======
 ; 
 ; The parameters mirror those of the underlying call.
 ;
XMCOMPLT(RETURN,RADPT,RAEXAM1,RAEXAM2,MAGVUSR,MAGVUSRDV,RAIMGTYP,RASTDRPT,RADXPRIM,RADXSCND) ;
 ;
 ;--- Initialize
 K RETURN
 N MSG,RARESULT,SEPSTAT,SEPOUTP D ZRUSEPIN
 ;
 ;--- Validate incoming parameters.
 N MAGERR,PARAM S MAGERR=0
 D
 . F PARAM="RADPT","RAEXAM1","RAEXAM2","MAGVUSR","MAGVUSRDV","RAIMGTYP" D  Q:MAGERR
 . . S:@PARAM="" MAGERR=1
 . . Q
 . Q
 ;
 I MAGERR D  Q
 . S RETURN(0)="-1"_SEPSTAT_"Required parameter "_PARAM_" missing or invalid."
 . Q
 ;
 ;--- Format incoming RAD Exam Identifiers.
 S RAEXAM=RADPT_U_RAEXAM1_U_RAEXAM2
 ;
 ;--- Set IMAGING SITE PARAMETERS file (#2006.1) IEN from DUZ(2).
 N MAGSITEP
 D
 . S MAGVUSRDV=$G(MAGVUSRDV,$G(DUZ(2))),MAGSITEP=$O(^MAG(2006.1,"B",MAGVUSRDV,"")) ;P164
 . I MAGSITEP="" D   ;P164 - if it is not Site IEN, try Station Number
 . . ;--- Get IEN of INSTITUTION file (#4) from STATION NUMBER (Supported IA# 2171)
 . . N IENINST S IENINST=$$IEN^XUAF4(MAGVUSRDV)
 . . S MAGSITEP=$O(^MAG(2006.1,"B",IENINST,"")) Q:+MAGSITEP  ;found the site
 . . S MAGERR=1,MSG="Unable to resolve Imaging Site Parameters entry. {DUZ(2)="_MAGVUSRDV_"} "
 . Q
 ;
 I MAGERR D  Q
 . S RETURN(0)="-1"_SEPSTAT_MSG
 . Q
 ; 
 ;--- Set additional RAD Order/Exam parameters.
 S MAGERR=$$MAKELIST("C",RAIMGTYP,.RAMSC,MAGVUSR,MAGSITEP)
 I MAGERR D  Q
 . S RETURN(0)="-1"_SEPSTAT_$P(MAGERR,U,2)
 . Q
 ;
 ;--- Set flag to insert Primary DX code if passed in.
 D:$G(RADXPRIM)'="" OUTPUT("PRIMDXCODE^^"_RADXPRIM,.RAMSC)
 ;
 ;--- Set flag to insert Secondary DX code(s) if passed in.
 D:$G(RADXSCND(0))'=""
 . ;
 . N CT S CT=""
 . F  S CT=$O(RADXSCND(CT)) Q:CT=""  D OUTPUT("SECDXCODE"_U_(CT+1)_U_RADXSCND(CT),.RAMSC)
 . Q
 ;
 ;--- Set flag to suppress HL7 message to dictation systems.
 D OUTPUT("FLAGS^^FS",.RAMSC)
 ;--- Call code underlying RPC: RAMAG EXAM COMPLETE (Private IA #5072)
 D COMPLETE^RAMAGRP1(.RARESULT,RAEXAM,.RAMSC)
 I $G(RARESULT(1))="-11^2" D  ; add the OUTSIDE STUDY and try the RPC again 
 . N INFO
 . D ADDROOM(.INFO,RAEXAM)
 . K RARESULT
 . I INFO(1)<0 M RARESULT=INFO Q
 . D COMPLETE^RAMAGRP1(.RARESULT,RAEXAM,.RAMSC)
 . Q
 ;
 ;--- Re-format error output or return 0.
 I RARESULT(0)<0 D
 . ;
 . S RETURN(0)=-1_SEPSTAT_$O(RARESULT("A"),-1)_" error lines returned."
 . N X S X=0
 . F  S X=$O(RARESULT(X)) Q:X=""  D
 . . S RETURN(X)=$P(RARESULT(X),U,1)_SEPSTAT_$P(RARESULT(X),U,2,999)
 . . Q
 E  D
 . S RETURN(0)=0_SEPSTAT_RARESULT(0)
 . N X S X=0
 . F  S X=$O(RARESULT(X)) Q:X=""  D
 . . S RETURN(X)=$TR(RARESULT(X),U,SEPOUTP)
 . . Q
 . ;--- Call RA* code to trigger alerts for DX codes.
 . D ALERT^MAGVIMRA(RADPT,RAEXAM1,RAEXAM2,1)
 . Q
 Q
 ;+++++ Wrap call to code underlying RPC: RAMAG EXAMINED & re-format output
 ;
 ; RPC: MAGV RAD STAT EXAMINED  Private IA #5071
 ;
 ; Inputs:
 ; =======
 ;
 ;  See input parameter descriptions above tag XMCOMPLT (above).
 ;
XMEXAMIN(RETURN,RADFN,RAEXAM1,RAEXAM2,MAGVUSR,MAGVUSRDV,RAIMGTYP) ;
 ;
 ;--- Initialize.
 K RETURN
 N MSG,RARESULT,SEPSTAT,SEPOUTP D ZRUSEPIN
 ;--- Validate incoming parameters.
 N MAGERR,PARAM S MAGERR=0
 D
 . F PARAM="RADFN","RAEXAM1","RAEXAM2","MAGVUSR","MAGVUSRDV","RAIMGTYP" D  Q:MAGERR
 . . S:@PARAM="" MAGERR=1
 . . Q
 . Q
 ;
 I MAGERR D  Q
 . S RETURN(0)="-1"_SEPSTAT_"Required parameter "_PARAM_" missing or invalid."
 . Q
 ;
 ;--- Format incoming RAD Exam Identifiers
 N RAEXAM S RAEXAM=RADFN_U_RAEXAM1_U_RAEXAM2
 ;
 ;--- Set IMAGING SITE PARAMETERS file (#2006.1) IEN from DUZ(2).
 N MAGSITEP
 D
 . S MAGSITEP=$O(^MAG(2006.1,"B",MAGVUSRDV,""))
 . I MAGSITEP="" S MAGERR=1,MSG="Unable to resolve Imaging Site Parameters entry."
 . Q
 ;
 I MAGERR D  Q
 . S RETURN(0)="-1"_SEPSTAT_MSG
 . Q
 ;
 ;--- Set required parameters
 S MAGERR=$$MAKELIST("E",RAIMGTYP,.RAMSC,MAGVUSR,MAGSITEP)
 I MAGERR D  Q
 . S RETURN(0)="-1"_SEPSTAT_$P(MAGERR,U,2)
 . Q
 ;
 ;--- Set flag to suppress HL7 message to dictation systems.
 D OUTPUT("FLAGS^^FS",.RAMSC)
 ;--- Call code underlying RPC: RAMAG EXAMINED (Private IA #5071).
 D EXAMINED^RAMAGRP2(.RARESULT,RAEXAM,.RAMSC)
 I $G(RARESULT(1))="-11^2" D  ; add the OUTSIDE STUDY and try the RPC again 
 . N INFO
 . D ADDROOM(.INFO,RAEXAM)
 . K RARESULT
 . I INFO(1)<0 M RARESULT=INFO Q
 . D EXAMINED^RAMAGRP2(.RARESULT,RAEXAM,.RAMSC)
 . Q
 ;
 ;--- Re-format error output or return 0.
 I RARESULT(0)<0 D
 . ;
 . S RETURN(0)=-1_SEPSTAT_$O(RARESULT("A"),-1)_" error lines returned."
 . N X S X=0
 . F  S X=$O(RARESULT(X)) Q:X=""  D
 . . S RETURN(X)=$P(RARESULT(X),U,1)_SEPSTAT_$P(RARESULT(X),U,2,999)
 . . Q
 E  D
 . S RETURN(0)=0_SEPSTAT_RARESULT(0)
 . N X S X=0
 . F  S X=$O(RARESULT(X)) Q:X=""  D
 . . S RETURN(X)=$TR(RARESULT(X),U,SEPOUTP)
 . . Q
 . Q
 Q
 ;+++++ Wrap calls to RPC: RAMAG EXAM ORDER & re-format output.
 ;
 ; RPC: MAGV RAD EXAM ORDER  Private IA #5068
 ;
 ; Inputs:
 ; =======
 ;
 ;  RETURN
 ;  DFN
 ;  RAMLC
 ;  RADPROC
 ;  STUDYDAT
 ;  RACAT
 ;  REQLOC
 ;  REQPHYS
 ;  REASON
 ;  MISC
 ;
 ; Notes:
 ; ======
 ; 
 ; The parameters are the same as those of the underlying call.
 ;
XMORDER(RETURN,DFN,RAMLC,RADPROC,STUDYDAT,RACAT,REQLOC,REQPHYS,REASON,MISC) ;
 ;
 K RETURN
 N SEPSTAT,SEPOUTP D ZRUSEPIN
 ;
 ;--- Private IA #5068.
 D ORDER^RAMAGRP1(.ORDINFO,DFN,RAMLC,RADPROC,STUDYDAT,RACAT,REQLOC,REQPHYS,REASON,.MISC)
 ;
 ;--- Re-format error output or return new IEN in RAD/NUC MED ORDERS File (#75.1)
 I ORDINFO(0)<0 D  K ORDINFO
 . ;
 . S RETURN(0)=-1_SEPSTAT_$O(ORDINFO("A"),-1)_" error lines returned."
 . N X S X=0 F  S X=$O(ORDINFO(X)) Q:X=""  D
 . . ;
 . . S RETURN(X)=$P(ORDINFO(X),U,1)_SEPSTAT_$P(ORDINFO(X),U,2,999)
 . . Q
 . Q
 E  S RETURN(0)=ORDINFO(0)
 K ORDINFO
 Q
 ;
 ;+++++ Wrap calls to RPC: RAMAG EXAM REGISTER & re-format output.
 ;
 ; RPC: MAGV RAD EXAM REGISTER  Private IA #5069.
 ; 
 ; Inputs:
 ; =======
 ; 
 ;  RETURN
 ;  RAOIFN
 ;  EXMDTE
 ;  RAMSC
 ;
 ; Notes:
 ; ======
 ; 
 ;  The parameters are the same as those of the underlying call.
 ;
XMREGSTR(RETURN,RAOIFN,EXMDTE,RAMSC) ;
 ;
 K RETURN
 N SEPSTAT,SEPOUTP,IMAGLOC D ZRUSEPIN
 ;
 ; Check if imaging location is present - if not find outside imaging location for procedure and division
 N RODATA S RODATA=$G(^RAO(75.1,RAOIFN,0))
 D:$P(RODATA,U,20)=""
 . N LOCINFO,PROCIEN,RAMLC S PROCIEN=$P(RODATA,U,2)
 . D IMAGELOC(.RAMLC,PROCIEN,DUZ(2))
 . S:$P(RAMLC,SEPSTAT)<0 RETURN(0)=RAMLC
 . Q:$G(RETURN(0))
 . S RAMLC=$P(RAMLC,SEPSTAT,2)
 . ; call the RPC to update the radiology imaging location in the radiology order file (#75.1).
 . D IMAGELOC^MAGDRPCB(.LOCINFO,RAOIFN,RAMLC)
 . I $G(LOCINFO)<0 S RETURN(0)=LOCINFO ;"-1"_SEPSTAT_"Error in rpc MAG DICOM SET IMAGING LOCATION"
 . Q
 ;
 ;Get imaging location IEN (#79.1)
 K RAMLC,PROCIEN
 S PROCIEN=$P(RODATA,U,2)
 D IMAGELOC(.RAMLC,PROCIEN,DUZ(2))
 S:$P(RAMLC,SEPSTAT)<0 RETURN(0)=RAMLC
 Q:$G(RETURN(0))
 S RAMLC=$P(RAMLC,SEPSTAT,2)
 ;Get corresponding hospital location IEN (#44)
 S IMAGLOC=$$GET1^DIQ(79.1,.RAMLC,.01,"I")
 K RAMSC
 S RAMSC(1)="PRINCLIN^^"_$G(IMAGLOC)
 S RAMSC(2)="FLAGS^^D"
 ;
 Q:$G(RETURN(0))
 ;--- Private IA #5069.
 D REGISTER^RAMAGRP1(.RARESULT,RAOIFN,EXMDTE,.RAMSC)
 ;
 I RARESULT(0)<0 D
 . ;
 . S RETURN(0)=-1_SEPSTAT_$O(RARESULT("A"),-1)_" error lines returned."
 . N X S X=0 F  S X=$O(RARESULT(X)) Q:X=""  D
 . . ;
 . . S RETURN(X)=$P(RARESULT(X),U,1)_SEPSTAT_$P(RARESULT(X),U,2,999)
 . . Q
 E  D
 . S RETURN(0)=0_SEPSTAT_RARESULT(0)
 . N X S X=0 F  S X=$O(RARESULT(X)) Q:X=""  D
 . . ;
 . . S RETURN(X)=$TR(RARESULT(X),U,SEPOUTP)
 . . Q
 . Q
 Q
 ;+++ Routine Utility: Initialize Separators
ZRUSEPIN ;
 S SEPOUTP=$$OUTSEP^MAGVIM01
 S SEPSTAT=$$STATSEP^MAGVIM01
 Q
 ;
MAKELIST(RACTION,RAIMGTYP,RAMSC,MAGVUSR,MAGSITEP) ; output required fields
 ; Load required flags 
 N INFO
 D EXMSTREQ^RAMAGRP2(.INFO,RACTION,RAIMGTYP)
 I INFO(0)<0 Q INFO(1)
 ;
 N TODAYHL7
 S TODAYHL7=$$NOW^XLFDT()\1,$E(TODAYHL7)=$E(TODAYHL7)+17
 ;
 N REQ,RADPVAL
 ;REQ001 - technologist
 S REQ(1)="TECH^1^"_MAGVUSR
 ;
 ;REQ002 - resident or staff
 ;REQ003 - detailed procedure - taken care of already
 ;
 ;REQ004 - film entry
 S RADPVAL=$$GET1^DIQ(2006.1,MAGSITEP,"RAD FILM SIZE","I")
 S REQ(4)="FILMSIZE^1^"_RADPVAL_U_"0"
 ;
 ;REQ005 - diagnostic code default, if not supplied by user.
 D:$G(RADXPRIM)=""
 . S RADPVAL=$$GET1^DIQ(2006.1,MAGSITEP,"RAD PRIMARY DIAGNOSTIC CODE","I")
 . S REQ(5)="PRIMDXCODE^^"_RADPVAL
 . Q
 ;
 ;REQ006 - camera / equipment / room
 S RADPVAL=$$GET1^DIQ(2006.1,MAGSITEP,"RAD PRIMARY CAMERA/EQUIP/RM","I")
 S REQ(6)="PRIMCAM^^"_RADPVAL
 ;
 ;REQ007 - reserved
 ;REQ008 - reserved
 ;REQ009 - reserved
 ;REQ010 - reserved
 ;
 ;REQ011 - report entered
 S REQ(11)="RPTDTE^^"_TODAYHL7
 I $G(RASTDRPT)="" D
 . S REQ(11,1)="REPORT^1^Electronically generated report for outside study."
 . Q
 ;--- Add the REPORT text of a selected STANDARD REPORT to the RAMSC array.
 E  D STNDRPRT(RASTDRPT,"R",1)
 ;
 ;REQ012 - verified report
 S REQ(12)="VERDTE^^"_TODAYHL7
 S REQ(12,1)="RPTSTATUS^^EF"
 ;
 ;REQ013 - procedure modifiers required - previously done
 ;
 ;REQ014 - cpt modifiers
 S RADPVAL=$$GET1^DIQ(2006.1,MAGSITEP,"RAD CPT MODIFIERS","I")
 S:RADPVAL REQ(14)="CPTMODS^1^"_RADPVAL
 ;
 ;REQ015 - reserved
 ;
 ;REQ016 - impression
 I $G(RASTDRPT)="" D
 . S REQ(16)="IMPRESSION^1^Electronically generated report for outside study."
 . Q
 ;--- Add the IMPRESSION text of a selected STANDARD REPORT to the RAMSC array.
 E  D STNDRPRT(RASTDRPT,"I",1)
 ;
 N INDEX
 F INDEX=1:1:16 I $P(INFO(0),"^",INDEX) D
 . D:$D(REQ(INDEX)) OUTPUT(REQ(INDEX),.RAMSC)
 . D:$D(REQ(INDEX,1)) OUTPUT(REQ(INDEX,1),.RAMSC)
 . Q
 ;
 Q 0
 ;
 ;+++++ Add selected STANDARD REPORT text to the Miscellaneous Parameters array.
 ;
STNDRPRT(RASTDRPT,SSCR,INDEX1) ;
 ;
 N PREFIX S PREFIX=$S(SSCR="R":"REPORT",SSCR="I":"IMPRESSION")
 ;
 N CT
 S CT=0 F  S CT=$O(^RA(74.1,RASTDRPT,SSCR,CT)) Q:CT=""  D
 . N RPTXT
 . S RPTXT=PREFIX_U_(CT+INDEX1)_U_$G(^RA(74.1,RASTDRPT,SSCR,CT,0)) D OUTPUT(RPTXT,.RAMSC)
 . Q
 Q
 ;
OUTPUT(TEXT,ARRAY) ;
 N I
 S I=$O(ARRAY(""),-1)+1
 S ARRAY(I)=TEXT
 Q
 ;
 ; MAGV OUTSIDE IMAGE LOCATION
 ;
 ; Inputs:
 ; =======
 ;
 ; PROCIEN -- IEN of procedure in RAD/NUC MED PROCEDURES (file #71)
 ; DIVISION - IEN of division in INSTITUTION (file #4)
 ;  
 ; Output:
 ; ========
 ; 
 ;     <0 Error message
 ;      0 IEN of the Outside Image Location in the IMAGE LOCATIONS (file #79.1)
 ;
IMAGELOC(RESULT,PROCIEN,DIVISION) ;
 ; return the outside imaging location for a given radiology procedure and division
 N IEN,IMAGETYPE,SEPSTAT,SEPOUTP D ZRUSEPIN
 K RESULT
 S PROCIEN=$G(PROCIEN)
 I (PROCIEN'>0)!(PROCIEN'=+PROCIEN) D  Q
 . S RESULT="-1"_SEPSTAT_"Invalid or missing Radiology Procedure pointer: """_PROCIEN_"""."
 . Q
 ;
 S DIVISION=$G(DIVISION)
 I (DIVISION'>0)!(DIVISION'=+DIVISION) D  Q
 . S RESULT="-2"_SEPSTAT_"Invalid or missing Division pointer:"""_DIVISION_"""."
 . Q
 ;
 S IMAGETYPE=$$GET1^DIQ(71,PROCIEN,12,"I")
 I 'IMAGETYPE D  Q
 . S RESULT="-3"_SEPSTAT_"Image Type could not be determined for Radiology Procedure pointer: """_PROCIEN_"""."
 . Q
 ;
 I $$GET1^DIQ(4,DIVISION,.01)="" D  Q
 . S RESULT="-4"_SEPSTAT_"Invalid Division (Institution) pointer:"""_DIVISION_"""."
 . Q
 S IEN=$O(^MAGD(2006.5759,"D",DIVISION,IMAGETYPE,""))
 I IEN="" D  Q
 . S RESULT="-5"_SEPSTAT_"Outside Imaging Location could not be determined for Division: "_DIVISION_" & Procedure: """_PROCIEN_"""."
 . Q
 S RESULT=0_SEPSTAT_$$GET1^DIQ(2006.5759,IEN,.01,"I")
 Q
ADDROOM(INFO,RAEXAM) ; add the OUTSIDE STUDY camera equipment room to the IMAGING LOCATION
 ;S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM ADD CAMERA EQUIP RM","M",.INFO,RAEXAM)
 D ADDROOM^MAGDRPCB(.INFO,RAEXAM)
 Q 
