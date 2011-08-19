MAGGSU1 ;WOIFO/GEK - Utilities for Imaging  ; 01 Nov 2001 12:32 PM 
 ;;3.0;IMAGING;**7**;Jul 12, 2002
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
IMGDTTM(X,EXT,INT) ; We call here from anywhere in Imaging, to get 
 ; Internal and External dates/times.  That way all imaging windows will 
 ; have same date format.
 ;X IS THE INPUT.   Internal or External or Partial
 ;EXT is the external form of the date.  Passed by reference
 ;INT is the internal form of the date.  Passed by reference
 ;Return is 1^
 ;       or 0^error message (invalid format)
 ; EXTERNAL FORMAT RETURNED BY THIS CALL IS   
 ;       MM/DD/YYYY   i.e.   01/01/2000
 N MAGY,Y
 D DT^DILF("TE",X,.MAGY)
 I $G(MAGY,-1)=-1 Q ""
 ; Standard external returned by DT^DILF is  Jan 01, 2000
 ; If we wanted that as imaging format, we could stop here
 ; and Return MAGY(0) as External
 S INT=MAGY
 S EXT=$$FMTE^XLFDT(MAGY,"5Z")
 Q 1
IMGDT(X,EXT,INT) ;Return just the date, no time
 N Y
 S Y=$$IMGDTTM(X,.EXT,.INT)
 S EXT=$P(EXT,"@")
 Q Y
EXTDT(X) ;
 N Y,EXT
 S Y=$$IMGDTTM(X,.EXT) I 'Y Q Y
 Q $P(EXT,"@")
EXTDTTM(X) ;
 N Y,EXT
 S Y=$$IMGDTTM(X,.EXT) I 'Y Q Y
 Q EXT
INTDT(X) ;
 N Y,INT,EXT
 S Y=$$IMGDT(X,.EXT,.INT) I 'Y Q Y
 Q INT
