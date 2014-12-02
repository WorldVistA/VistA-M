MAGVRS81 ;WOIFO/MLH - RPC calls for DICOM file processing ; 12 Apr 2010 5:45 PM
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
GETRPROC(OUT,ACCNUM) ; Call from GETPINFO^MAGVRS08 - get radiology procedure information
 N RPTIX,RPTREC,EXAMDT,MAGD0,MAGD1,V,MAGD2,EXAMREC,OUTIX
 N EXAMCODE,EXAMCODEREC,EXAMDESC,EXAMCODECPT,CPTREC,CPTCODE,CPTDESC,REFPHY,TERMGY
 S RPTIX=$O(^RARPT("B",ACCNUM,"")) ; ICR 3323
 I RPTIX="" S OUT(1)="-21"_SSEP_SSEP_"Accession number doesn't point to Radiology report" Q
 S RPTREC=$G(^RARPT(RPTIX,0))
 I RPTREC="" S OUT(1)="-22"_SSEP_SSEP_"Radiology report record not found" Q
 S EXAMDT=$P(RPTREC,"^",3)
 S MAGD0=$P(RPTREC,"^",2)
 S MAGD1=9999999.9999-EXAMDT
 S V=$P(RPTREC,"^",4)
 I $L(MAGD0)*$L(MAGD1)*$L(V)=0 D  Q
 . S OUT(1)="-23"_SSEP_SSEP_"Radiology exam reference pointers not found" Q
 . Q
 S MAGD2=$O(^RADPT(MAGD0,"DT",MAGD1,"P","B",V,"")) ; ICR 65
 I MAGD2="" S OUT(1)="-24"_SSEP_SSEP_"Radiology exam record pointer not found" Q
 S EXAMREC=$G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0))
 I EXAMREC="" S OUT(1)="-25"_SSEP_SSEP_"Radiology exam record not found" Q
 ;
 ; EXAM FOUND - populate attributes to return
 S EXAMCODE=$P(EXAMREC,"^",2),TERMGY="LOCAL"
 D:EXAMCODE
 . S EXAMCODEREC=$G(^RAMIS(71,EXAMCODE,0))
 . S EXAMDESC=$P(EXAMCODEREC,"^",1)
 . S EXAMCODECPT=$P(EXAMCODEREC,"^",9)
 . D:EXAMCODECPT'=""
 . . S CPTREC=$$CPT^ICPTCOD(EXAMCODECPT,EXAMDT) ; ICR 1995
 . . S CPTCODE=$P(CPTREC,"^",2)
 . . S CPTDESC=$P(CPTREC,"^",3)
 . . D:$L(CPTCODE)*$L(CPTDESC)
 . . . S EXAMCODE=CPTCODE
 . . . S EXAMDESC=CPTDESC
 . . . S TERMGY=$P(CPTREC,"^",5)
 . . . S TERMGY=$S(TERMGY="C":"CPT",TERMGY="H":"HCPCS",TERMGY="L":"LOCAL",1:"")
 . . . Q
 . . Q
 . Q
 S REFPHY=$$GET1^DIQ(200,(+$P(EXAMREC,"^",14))_",",.01)
 S OUTIX=0
 D:$G(EXAMDESC)'="" POP(.OUT,"DESCRIPTION",EXAMDESC)
 D:$G(EXAMDT)'="" POP(.OUT,"DATE/TIME",$$CVTDT(EXAMDT))
 D:$G(EXAMCODE)'="" POP(.OUT,"PROCEDURE CODE",EXAMCODE)
 D:$G(TERMGY)'="" POP(.OUT,"TERMINOLOGY",TERMGY)
 D POP(.OUT,"CODING AUTHORITY","USDVA")
 D:$G(REFPHY)'="" POP(.OUT,"REFERRING PHYSICIAN",REFPHY)
 Q
GETRRPT(OUT,ACCNUM) ; Call from GETPINFO^MAGVRS08 - get a radiology report
 N RPTIX,RPTIEN,TEXT,RET,ERR,TXTIX,OSEP,ISEP,SSEP
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 I ACCNUM="" S OUT(1)="-51"_SSEP_SSEP_"No accession number provided" Q
 ; look up reports for this accession number - ICR 2479
 K ^TMP("DILIST",$J)
 D LIST^DIC(74,,"6I;7I",,,,ACCNUM,"B")
 ; did Lister encounter an exception?
 I $D(^TMP("DIERR",$J)) D  Q  ; yes, exception encountered; report and terminate
 . S OUT(1)="-53"_SSEP_SSEP_$G(^TMP("DIERR",$J,1,"TEXT",1))
 . Q
 I '$D(^TMP("DILIST",$J,1)) D  Q  ; no, but no report on file; bail
 . S OUT(1)="-52"_SSEP_SSEP_"No report on file for this exam"
 . Q
 ; no exception encountered, report results
 S RPTIX=0
 F  S RPTIX=$O(^TMP("DILIST",$J,2,RPTIX)) Q:'RPTIX  D
 . S RPTIEN=^TMP("DILIST",$J,2,RPTIX) Q:'RPTIEN
 . S RET=$$GET1^DIQ(74,RPTIEN_",",200,,"TEXT") Q:'$D(TEXT)  ; no report text, plow on
 . D POP(.OUT,"REPORT INDEX",RPTIEN)
 . D POP(.OUT,"DATE REPORT ENTERED",$$CVTDT($G(^TMP("DILIST",$J,"ID",RPTIX,6))))
 . D POP(.OUT,"VERIFIED DATE",$$CVTDT($G(^TMP("DILIST",$J,"ID",RPTIX,7))))
 . D POP(.OUT,"REPORT TEXT",.TEXT)
 . Q
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 Q
 ;
POP(ARY,NAME,VALUE) ; populate an array with a name value pair
 N IX
 S:$D(VALUE)#10 ARY($O(ARY(" "),-1)+1)=NAME_OSEP_VALUE_SSEP
 S IX=0
 F  S IX=$O(VALUE(IX)) Q:'IX  S ARY($O(ARY(" "),-1)+1)=NAME_OSEP_VALUE(IX)_SSEP
 Q
CVTDT(FMDT) ; convert from FM to ISO date
 Q $S(FMDT:(17000000+$P(FMDT,".",1))_"."_$P($J(FMDT#1,0,6),".",2),1:"")
