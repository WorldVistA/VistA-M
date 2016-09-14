MAGDQR72 ;WOIFO/MLH,DAC - Imaging RPCs for Query/Retrieve - acc# scan for rad recs (old DB) ; 22 Dec 2015 3:07 PM
 ;;3.0;IMAGING;**118,162**;Mar 19, 2002;Build 22;Dec 22, 2015
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
ACCRAD(REQ,T,P,ACC) ; scan old structure for Radiology Related Images (including site-specific accession numbers)
 N TMPQ,I,V,MAGD0,MAGD1,MAGD2,RPTIX
 S TMPQ=$NA(^TMP("MAG",$J,"QR")) K @TMPQ@(5)
 S I=$$MATCHD^MAGDQR03(REQ(T,P),"^RADPT(""ADC"",LOOP)","@TMPQ@(5,LOOP)")
 S I=$$MATCHD^MAGDQR03(REQ(T,P),"^RADPT(""ADC1"",LOOP)","@TMPQ@(5,LOOP)")
 S V="" F  S V=$O(@TMPQ@(5,V)) Q:V=""  D
 . S MAGD0="" F  S MAGD0=$O(^RADPT("ADC",V,MAGD0)) Q:MAGD0=""  D
 . . S MAGD1="" F  S MAGD1=$O(^RADPT("ADC",V,MAGD0,MAGD1)) Q:MAGD1=""  D
 . . . S MAGD2="" F  S MAGD2=$O(^RADPT("ADC",V,MAGD0,MAGD1,MAGD2)) Q:MAGD2=""  D
 . . . . S RPTIX=$P($G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0)),"^",17) Q:'RPTIX  ; no report on file
 . . . . Q:'$D(^RARPT(RPTIX,2005))  ; report doesn't have images in old structure
 . . . . S @TMPQ@(6,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)="",ACC=1
 . . . . Q
 . . . Q
 . . Q
 . Q
 ; P162 DAC - Match site specific accession numbers - ADC1 index
 S V="" F  S V=$O(@TMPQ@(5,V)) Q:V=""  D
 . S MAGD0="" F  S MAGD0=$O(^RADPT("ADC1",V,MAGD0)) Q:MAGD0=""  D
 . . S MAGD1="" F  S MAGD1=$O(^RADPT("ADC1",V,MAGD0,MAGD1)) Q:MAGD1=""  D
 . . . S MAGD2="" F  S MAGD2=$O(^RADPT("ADC1",V,MAGD0,MAGD1,MAGD2)) Q:MAGD2=""  D
 . . . . S RPTIX=$P($G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0)),"^",17) Q:'RPTIX  ; no report on file
 . . . . Q:'$D(^RARPT(RPTIX,2005))  ; report doesn't have images in old structure
 . . . . S @TMPQ@(6,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)="",ACC=1
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
