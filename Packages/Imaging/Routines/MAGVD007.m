MAGVD007 ;WOIFO/DAC,MLH - Get images by accession number ; 30 Jan 2012 04:04 PM
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
 ;+++++  Get Images by Accession Number
 ; 
 ; Input Parameters
 ; ================
 ; ACCNUM - Accession Number
 ;
 ; Return Values
 ; =============
 ; OUT - status`status message
 ;       a status of 0 indicates success, a negative integer indicates an error occurred 
 ; 
 ; MAGARR(1..n,"IMAGES")
 ; MAGARR(1..n,"MAGDFN")  - Patient DFN
 ; MAGARR(1..n,"MAGD1")   - Radiology DT
 ; MAGARR(1..n,"MAGD2")   - Radiology P
 ;
GIBYACC(OUT,ACCNUM,MAGARR)  ; Get Images by Accession Number
 N SSEP,ANY,I
 N P,REQ,IARRAY,MAGD0,MAGD1,MAGD2,PROC ; Needed for function call ACCIEN^MAGVD006
 S SSEP=$$STATSEP^MAGVRS41
 I $G(ACCNUM)="" S OUT=-1_SSEP_"No accession number provided" Q
 S OUT=0
 K ^TMP("MAG",$J,"QR")
 K MAGARR
 S REQ("0008,0050",ACCNUM)=ACCNUM
 D ACCNUM^MAGDQR07(.REQ,"0008,0050",ACCNUM,.ANY)
 S P=""
 S I=0
 F  S P=$O(^TMP("MAG",$J,"QR",6,P)) Q:P=""  D
 . K IARRAY
 . S (MAGD0,MAGD1,MAGD2)=0
 . D ACCIEN^MAGVD006(P,.REQ,.IARRAY,.MAGD0,.MAGD1,.MAGD2,.PROC)
 . I $O(IARRAY(""))="" Q
 . S I=I+1
 . M MAGARR(I,"IMAGES")=IARRAY
 . S MAGARR(I,"MAGDFN")=$G(MAGD0)
 . S MAGARR(I,"MAGD1")=$G(MAGD1)
 . S MAGARR(I,"MAGD2")=$G(MAGD2)
 . S MAGARR(I,"PROC")=$G(PROC)
 . Q
 K ^TMP("MAG",$J,"QR")
 Q
