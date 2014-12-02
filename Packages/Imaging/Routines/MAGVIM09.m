MAGVIM09 ;WOIFO/DAC,BT,MAT - Utilities for RPC calls for DICOM file processing ; 1 Oct 2012 2:25 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; +++++  Get a record from a WORK ITEM file (#2006.941) by IEN 
 ; 
 ; Input parameters
 ; ================
 ; ID = IEN in the file
 ; STARTCNT = starting line in OUT array
 ; 
 ; Return Values
 ; =============
 ;   OUT(STARTCNT)="WorkItemHeader"_delimited "`" fields values
 ;   OUT(STARTCNT+1..n)=Message
 ;   OUT(n+1..m)=Tags`TagName`TagValue
 ;
GETWI(OUT,ID,STOPTAG) ; Return Work Item record in OUT array
 ; OUT      - array that holds the result
 ; ID       - IEN of the Work Item 
 ; STOPTAG  - The last tag of a record to be returned (optional)
 N FILE,IENS,MAGOUT,ERR,FLD,CNT,TAGS,I,AFLD,DATA
 N SSEP,OSEP,STOP,TAGNAME,TAGVALUE
 S SSEP=$$STATSEP^MAGVIM01,OSEP=$$OUTSEP^MAGVIM01
 S FILE=2006.941
 S IENS=ID_","
 D GETS^DIQ(FILE,ID_",","*","IE","MAGOUT","ERR")
 I $D(ERR) S OUT="-1"_SSEP_$G(ERR("DIERR",1,"TEXT",1)) Q 
 ; Type of the return field values - internal, external, date
 S AFLD(.01)="D"  ; CREATED DATE/TIME
 S AFLD(1)="E"    ; TYPE
 S AFLD(2)="E"    ; SUBTYPE
 S AFLD(3)="E"    ; STATUS
 S AFLD(4)="I"    ; LOCATION
 S AFLD(5)="E"    ; PRIORITY
 S AFLD(8)="IE"   ; CREATING USER
 S AFLD(9)="D"    ; LAST UPDATED DATE/TIME
 S AFLD(10)="IE"  ; LAST UPDATING USER
 S AFLD(14)="E"   ; CREATING APPLICATION
 S AFLD(15)="E"   ; LAST UPDATING APPLICATION
 S AFLD(16)="E"   ; SC TRANSACTION ID
 ;
 ;Convert Institution IEN to Station Number
 I $G(MAGOUT(FILE,IENS,4,"I")) D
 . S MAGOUT(FILE,IENS,4,"I")=$$STA^XUAF4(MAGOUT(FILE,IENS,4,"I")) ;IA #2171 Get station number for an IEN
 . Q
 ;
 S CNT=OUT(0)+1
 S FLD=0
 S OUT(CNT)="WorkItemHeader"_SSEP_ID
 F  S FLD=$O(MAGOUT(FILE,IENS,FLD)) Q:FLD=""  D
 . Q:FLD=13  ; Word-processing field
 . I AFLD(FLD)["D" S OUT(CNT)=OUT(CNT)_OSEP_$$FMTE^XLFDT(MAGOUT(FILE,IENS,FLD,"I"),5)  ; Date fields
 . I AFLD(FLD)["I" S OUT(CNT)=OUT(CNT)_OSEP_MAGOUT(FILE,IENS,FLD,"I")
 . I AFLD(FLD)["E" S OUT(CNT)=OUT(CNT)_OSEP_MAGOUT(FILE,IENS,FLD,"E")
 . Q
 ; Get Message
 S I=0 F  S I=$O(MAGOUT(FILE,IENS,13,I)) Q:I'>0  D
 . S CNT=CNT+1,OUT(CNT)="Message"_SSEP_MAGOUT(FILE,IENS,13,I)
 . Q
 ; Get Tags
 S TAGS=2006.94111,I="",STOP=0
 S I=0
 F  S I=$O(^MAGV(2006.941,ID,4,I)) Q:I=""  D  Q:STOP=1
 . S DATA=$G(^MAGV(2006.941,ID,4,I,0))
 . S TAGNAME=$P(DATA,U,1),TAGVALUE=$P(DATA,U,2)
 . S CNT=CNT+1,OUT(CNT)="Tag"_SSEP_TAGNAME_OSEP_TAGVALUE
 . I $G(STOPTAG)'="",STOPTAG=TAGNAME S STOP=1
 S OUT(0)=CNT
 Q
