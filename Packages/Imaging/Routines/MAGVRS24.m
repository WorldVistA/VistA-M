MAGVRS24 ;WOIFO/DAC - RPC calls for DICOM file processing ; 09 Feb 2012 12:53 PM
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
GETSOP(OUT,SERIEN,SOPIEN,OVERRIDE) ;RPC - MAGV GET SOP
 D REFRESH^MAGVRS41(.OUT,2005.64,$G(SOPIEN),$G(SERIEN),$G(OVERRIDE))
 Q
INSOP(OUT,SOPIEN,SERIEN,OVERRIDE) ; RPC - MAGV INACTIVATE SOP
 D INACTIVT^MAGVRS41(.OUT,2005.64,$G(SOPIEN),$G(SERIEN),$G(OVERRIDE))
 Q
GETORIG(OUT,SOPIEN) ; Get the original file(s) associated with a SOP instance
 ; IIFIEN - Image file IEN   ORIG - Is Original
 N IIFIEN,ORIG,I,SSEP,STATUS
 S IIFIEN="",SSEP=$$STATSEP^MAGVRS41,I=2
 I $G(SOPIEN)="" S OUT(1)="-3"_SSEP_"no IEN provided" Q
 I '$D(^MAGV(2005.64,SOPIEN)) S OUT(1)="-1"_SSEP_"IEN does not exist" Q
 F  S IIFIEN=$O(^MAGV(2005.65,"C",SOPIEN,IIFIEN)) Q:IIFIEN=""  D
 . S ORIG=$P($G(^MAGV(2005.65,IIFIEN,1)),U,2)
 . S STATUS=$P($G(^MAGV(2005.65,IIFIEN,1)),U,5)
 . I $G(ORIG)="1",STATUS'="I" S OUT(I)=IIFIEN,I=I+1  ; Add original Image Instance IEN to output array
 . Q
 S OUT(1)=$S($D(OUT(2)):"0"_SSEP_SSEP,1:"-2"_SSEP_"No associated original file instances found")
 Q
