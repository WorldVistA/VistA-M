MAGVRS82 ;WOIFO/MLH - RPC calls for DICOM file processing ; 12 Apr 2010 5:48 PM
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
GETCPROC(OUT,CONNUM) ; Call from GETPROCI^MAGVRS08 - get consult procedure information
 N CONIX,CONREC,CONSCODPTR,CONSCODFIL,CONSCOD,TERMGY,CONSDESC,TIUPTR,OUTIX,CONSDT,REFPHY
 I CONNUM="" S OUT(1)="-41"_SSEP_SSEP_"No consult number provided" Q
 ;
 S CONSCODPTR=$$GET1^DIQ(123,CONNUM,4,"I") ; IA #4110
 D:CONSCODPTR[";"  ; variable pointer populated?
 . ; yes
 . S CONSCODFIL=+$P($P(CONSCODPTR,";",2),"(",2)
 . S CONSCOD=$P(CONSCODPTR,";",1)
 . Q
 S CONSDESC=$$GET1^DIQ(123,CONNUM,4,"E") ; IA #4110
 S TERMGY=$G(CONSCODFIL)
 S REFPHY=$$GET1^DIQ(123,CONNUM,10,"E")
 S:REFPHY="" REFPHY=$$GET1^DIQ(123,CONNUM,.126,"E")
 S TIUPTR=$$GET1^DIQ(123,CONNUM,16,"I")
 S:TIUPTR CONSDT=$$GET1^DIQ(8925,TIUPTR,1201,"I")
 ;
 S OUTIX=0
 D:$G(CONSDESC)'="" POP(.OUT,"DESCRIPTION",CONSDESC)
 D:$G(CONSDT)'="" POP(.OUT,"DATE/TIME",(17000000+$P(CONSDT,".",1))_"."_$P($J(CONSDT#1,0,6),".",2))
 D:$G(CONSCOD)'="" POP(.OUT,"PROCEDURE CODE",CONSCOD)
 D:$G(TERMGY)'="" POP(.OUT,"TERMINOLOGY",TERMGY)
 D POP(.OUT,"CODING AUTHORITY","USDVA")
 D:$G(REFPHY)'="" POP(.OUT,"REFERRING PHYSICIAN",REFPHY)
 Q
GETCRPT(OUT,CONNUM) ; Call from GETPROCI^MAGVRS08 - get a consult report (TIU note)
 N RPTIX,TIUIX,DOCTYPE,EDAT,XDAT,TEXT,RET,ERR,OSEP,ISEP,SSEP
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 I CONNUM="" S OUT(1)="-61"_SSEP_SSEP_"No consult number provided" Q
 I '$D(^GMR(123,CONNUM)) S OUT(1)="-62"_SSEP_SSEP_"No record on file for this consult" Q
 S TIUIX=$$GET1^DIQ(123,CONNUM_",",16,"I") ; ICR 4110
 I 'TIUIX S OUT(1)="-63"_SSEP_SSEP_"No TIU note on file for this consult" Q
 S DOCTYPE=$$GET1^DIQ(8925,TIUIX_",",".01","E")
 I DOCTYPE="" S OUT(1)="-64"_SSEP_SSEP_"No TIU note on file for this consult" Q
 D POP(.OUT,"DOCUMENT TYPE",DOCTYPE)
 S RET=$$GET1^DIQ(8925,TIUIX_",","2",,"TEXT")
 I '$D(TEXT) S OUT(1)="-65"_SSEP_SSEP_"No report text on file for this consult's TIU note" Q
 S EDAT=$$GET1^DIQ(8925,TIUIX_",","1201","I")
 D:EDAT POP(.OUT,"ENTRY DATE/TIME",$$CVTDT(EDAT))
 S XDAT=$$GET1^DIQ(8925,TIUIX_",",".08","I")
 D:XDAT POP(.OUT,"EPISODE END DATE/TIME",$$CVTDT(EDAT))
 D POP(.OUT,"REPORT TEXT",.TEXT)
 Q
CVTDT(FMDT) ; convert from FM to ISO date
 Q (17000000+$P(FMDT,".",1))_"."_$P($J(FMDT#1,0,6),".",2)
POP(ARY,NAME,VALUE) ; populate an array with a name value pair
 N IX
 S:$D(VALUE)#10 ARY($O(ARY(" "),-1)+1)=NAME_OSEP_VALUE_SSEP
 S IX=0
 F  S IX=$O(VALUE(IX)) Q:'IX  S ARY($O(ARY(" "),-1)+1)=NAME_OSEP_VALUE(IX)_SSEP
 Q
