MAGVD002 ;WOIFO/DAC,MLH - Delete old and new studies ;  3 Feb 2012 01:19 PM
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
 ; Input Variables:
 ; MAGARR(1..n,"IMAGES")
 ; MAGARR(1..n,"MAGDFN")  - Patient DFN
 ; MAGARR(1..n,"MAGD1")   - Radiology DT
 ; MAGARR(1..n,"MAGD2")   - Radiology P
 ; REASON - Reason for deletion
 ; 
 ; Output Variable:
 ; OUT - status`status message
 ;       0 indicates success, a negative integer indicates an error occurred 
 ; 
DELACC(OUT,MAGARR,REASON) ; Delete old and new studies using MAGARR info - called from option MAG SYS-DELETE STUDY
 N SSEP,ISEP,IMAGEIEN,OUTAUD,EVENT,HOST,APP,MESSAGE,DATA,I,STUDIEN
 N RESULT
 S SSEP=$$STATSEP^MAGVRS41
 S ISEP=$$INPUTSEP^MAGVRS41
 I $G(REASON)="" S OUT=-8_SSEP_"No reason provided" Q
 I '$D(MAGARR(1,"IMAGES")) S OUT=-9_SSEP_"No image IENs provided" Q 
 S IMAGEIEN="",OUT=""
 F I=1:1 Q:'$D(MAGARR(I,"IMAGES"))!(OUT'="")  D
 . F  S IMAGEIEN=$O(MAGARR(I,"IMAGES",IMAGEIEN)) Q:IMAGEIEN=""  D
 . . I MAGARR(I,"IMAGES",IMAGEIEN)="" D
 . . . D IMAGEDEL^MAGGTID(.RESULT,IMAGEIEN,1,REASON)
 . . . I $P($G(RESULT(0)),"^")=0 S OUT=-10_SSEP_$P($G(RESULT(0)),"^",2) Q
 . . . Q
 . . I MAGARR(I,"IMAGES",IMAGEIEN)'="" D
 . . . S STUDIEN=MAGARR(I,"IMAGES",IMAGEIEN)
 . . . D INACTIVT^MAGVRS41(.RESULT,2005.62,STUDIEN,"",1,REASON)
 . . . I +$G(RESULT(1))<0 S OUT=RESULT(1) Q
 . . . Q
 . . Q
 . Q
 I OUT="" S OUT=0  ; set success value
 S EVENT="DELETE"
 S HOST=""
 S APP="MAG SYS-DELETE STUDY"
 S MESSAGE=""
 S DATA(1)="DUZ"_ISEP_DUZ
 D EVENT^MAGUAUD(.OUTAUD,EVENT,HOST,APP,MESSAGE,.DATA)
 Q
