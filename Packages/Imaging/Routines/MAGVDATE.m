MAGVDATE ;WOIFO/RRB - Convert DICOM date to VistA ; 06 Apr 2010 9:58 AM
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
 ;
 ;
 ; Date conversion from DICOM format to VA
 ;
 Q
 ;
 ;
DATE(YYYYMMDD,FORMAT) ; convert date from DICOM format to displayable one
 ; FORMAT: B for birthday mm/dd/yyyy, S for short mm/dd/yy, L for long
 N M
 S FORMAT=$G(FORMAT)
 I FORMAT'="B",FORMAT'="S",FORMAT'="L" Q "Wrong format: "_FORMAT
 I YYYYMMDD="" Q ""
 I YYYYMMDD="<unknown>" Q YYYYMMDD
 I FORMAT="B" Q $E(YYYYMMDD,5,6)_"/"_$E(YYYYMMDD,7,8)_"/"_$E(YYYYMMDD,1,4)
 I FORMAT="S" Q $E(YYYYMMDD,5,6)_"/"_$E(YYYYMMDD,7,8)_"/"_$E(YYYYMMDD,3,4)
 ; long format: Mmm [D]D, YYYY
 S M=+$E(YYYYMMDD,5,6),M=(3*(M-1))+1
 S M=$E("JanFebMarAprMayJunJulAugSepOctNovDec",M,M+2)
 Q M_" "_(+$E(YYYYMMDD,7,8))_", "_$E(YYYYMMDD,1,4)
 ;
 Q
