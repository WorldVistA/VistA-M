MAGDQR71 ;WOIFO/MLH,NST,PMK - Imaging RPCs for Query/Retrieve - acc# scan (new); Feb 15, 2022@10:26:54
 ;;3.0;IMAGING;**118,305**;Mar 19, 2002;Build 3
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
 ; called by MAGDQR07
 ;
ACCNEW(REQ,T,P,ACC) ;look in the new database structure
 ; Add patient DFN and Study IEN to ^TMP("MAG",$J,"QR",6) in format
 ; ^TMP("MAG",$J,"QR",6,"N^"_MAGD0_"^"_STUDYIX)
 ;              where MAGD0 is patient DFN
 ;                    STUDYIX is IEN in IMAGE STUDY file (#2005.62)
 ;
 N PROQIX,TMPQ,I,PROBLEM61,V
 S TMPQ=$NA(^TMP("MAG",$J,"QR")) K @TMPQ@(5)
 S I=$$MATCHD^MAGDQR03(REQ(T,P),"^RADPT(""ADC"",LOOP)","@TMPQ@(5,LOOP)")  ; Radiology lookup
 S I=$$MATCHD^MAGDQR03(REQ(T,P),"^RADPT(""ADC1"",LOOP)","@TMPQ@(5,LOOP)")  ; Radiology lookup
 ;
 ; check accession number for inaccessible or artifact not on file - P305 PMK 12/06/2021
 S PROBLEM61=0,PROCIX="" ; procedure level indexed by accession number
 F  S PROCIX=$O(^MAGV(2005.61,"B",ACC,PROCIX)) Q:'PROCIX  D
 . I $$PROBLEM61^MAGDSTA8(PROCIX) S PROBLEM61=1 ; patient not available - quit
 . Q
 I 'PROBLEM61 D
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^MAGV(2005.61,""B"",LOOP)","@TMPQ@(5,LOOP)")
 . Q
 ;
 S V="" F  S V=$O(@TMPQ@(5,V)) Q:V=""  D  ; V is an accession number
 . S:$$ADDSTUDY^MAGDQR74(V,$NA(@TMPQ@(6)),"") ACC=1
 . Q
 Q
