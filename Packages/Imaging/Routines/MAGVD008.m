MAGVD008 ;WOIFO/DAC - Delete an image by accession number ; 3 Feb 2012 01:17 PM
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
 ;Called by legacy delete function
 ;
 ;Input Variables:
 ;      ACC - Accession number
 ;      REASON - The reason for deletion
 ;      
 ;Output Variable:
 ;OUT - status`status message
 ;      a status of 0 indicates success, a negative integer indicates an error occurred 
 ; 
DELNEW(OUT,ACC,REASON) ; Given an accession number delete entries for the 2005.6x structure
 N OUT20056,PROCIEN,STUDIEN,ISEP,SSEP,OUTAUD,EVENT,HOST,APP,MESSAGE,DATA,OUTAUD
 S ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 I $G(ACC)="" S OUT=-8_SSEP_"No accession number provided" Q
 I $G(REASON)="" S OUT=-9_SSEP_"No reason provided" Q
 I '$D(^MAGV(2005.61,"B",ACC)) S OUT=1_SSEP_"Accession number not found" Q
 S OUT=0
 S PROCIEN=$O(^MAGV(2005.61,"B",ACC,""))
 S STUDIEN=""
 F  S STUDIEN=$O(^MAGV(2005.62,"C",PROCIEN,STUDIEN)) Q:STUDIEN=""  D
 . D INACTIVT^MAGVRS41(.OUT20056,2005.62,STUDIEN,"",1,REASON)
 . I OUT20056(1)<0 S OUT=OUT20056(1)
 . Q
 S EVENT="DELETE"
 S HOST=""
 S APP="MAG SYS-DELETE IMAGEGROUP"
 S MESSAGE=""
 S DATA(1)="DUZ"_ISEP_DUZ
 I OUT'<0 D EVENT^MAGUAUD(.OUTAUD,EVENT,HOST,APP,MESSAGE,.DATA)
 Q
