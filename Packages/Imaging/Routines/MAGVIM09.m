MAGVIM09 ;WOIFO/DAC,BT,MAT/JSJ - Utilities for RPC calls for DICOM file processing ; Oct 04, 2022@19:19:13
 ;;3.0;IMAGING;**118,138,332**;Mar 19, 2002;Build 34;Sep 03, 2013
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
 ;
 ;P332 IMSTATUS moved from MAGVIM01 because routine size was exceeded
 ; RPC: MAGV IMPORT STATUS from MAGVIM01
IMSTATUS(OUT,UIDS) ; Get import status
 N SSEP,STUDYLIST,SOPLIST,STUDYOUT,SOPOUT,I,CNT,STUDYUID,SERUID,SOPUID,ISEP,SOPIEN,SERIEN,STUDIEN,FOUNDUID
 N ONFILESOP
 S SSEP=$$OUTSEP^MAGVIM01,ISEP=$$INPUTSEP^MAGVIM01,I=0,CNT=0 ;P332 add routine to calls
 I '$D(UIDS) S OUT(1)=-6_SSEP_"No UIDs provided" Q
 F  S I=$O(UIDS(I)) Q:I=""  D
 . S CNT=I,FOUNDUID="",ONFILESOP=0
 . S STUDYUID=$P(UIDS(I),ISEP,1),SERUID=$P(UIDS(I),ISEP,2),SOPUID=$P(UIDS(I),ISEP,3)
 . I $G(STUDYUID)="" S OUT(I+1)=-1_SSEP_"No study UID provided" Q
 . I $G(SERUID)="" S OUT(I+1)=-2_SSEP_"No series UID provided" Q
 . I $G(SOPUID)="" S OUT(I+1)=-3_SSEP_"No SOP UID provided" Q
 . S OUT(I+1)=-1_SSEP_UIDS(I)_SSEP_"not on file"
 . S STUDYLIST(1)=1,STUDYLIST(2)=STUDYUID
 . S SOPLIST(1)=1,SOPLIST(2)=SOPUID
 . ; Check ^MAG(2005) for import study status 
 . D CHECKUID^MAGDRPCA(.STUDYOUT,.STUDYLIST,"STUDY")
 . I STUDYOUT(2)'="",(+STUDYOUT(2))'<0 D
 . . D CHECKUID^MAGDRPCA(.SOPOUT,.SOPLIST,"SOP")
 . . I SOPOUT(2)'="",(+SOPOUT(2))'<0 D  S CNT=I
 . . . S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . . . S ONFILESOP=1
 . . . Q
 . . Q
 . I $G(STUDYOUT(2))="",$G(ONFILESOP)<1 D SOPCHECK(.UIDS,I) Q:$G(ONFILESOP)
 . S SOPOUT=""
 . ; Check SOP original and UID
 . I ('$D(^MAGV(2005.64,"B",SOPUID)))&('$D(^MAGV(2005.66,"B",SOPUID))) D SOPCHECK(.UIDS,I) Q
 . S SOPIEN=$O(^MAGV(2005.64,"B",SOPUID,""),-1)
 . ;if null try dup(replaced) UID
 . I SOPIEN="" S SOPIEN=$$DUPUID(.UIDS,I,SOPUID,3)  ;P332 Check for replacement
 . Q:SOPIEN=""
 . I $G(^MAGV(2005.64,SOPIEN,11))'="A" Q
 . ; Check Series original and UID
 . I ('$D(^MAGV(2005.63,"B",SERUID)))&('$D(^MAGV(2005.66,"B",SERUID))) D  Q:$G(FOUNDUID)=""
 . . I $G(SOPIEN)'="" S FOUNDUID=$$RECHKFLE(.UIDS,I,SOPUID,2)
 . S SERIEN=$O(^MAGV(2005.63,"B",$S($G(FOUNDUID)'="":FOUNDUID,1:SERUID),""),-1)
 . ;if null try dup(replaced) UID
 . I SERIEN="" S SERIEN=$$DUPUID(.UIDS,I,SERUID,2)  ;P332 Check for replacement
 . Q:SERIEN=""
 . I $G(^MAGV(2005.63,SERIEN,9))'="A" Q
 . ; Check Study original and UID
 . I ('$D(^MAGV(2005.62,"B",STUDYUID)))&('$D(^MAGV(2005.66,"B",STUDYUID))) D  Q:$G(FOUNDUID)=""
 . . I $G(SERIEN)'="" S FOUNDUID=$$RECHKFLE(.UIDS,I,SERUID,1)
 . S STUDIEN=$O(^MAGV(2005.62,"B",$S($G(FOUNDUID)'="":FOUNDUID,1:STUDYUID),""),-1)
 . ;if null try dup(replaced) UID
 . I STUDIEN="" S STUDIEN=$$DUPUID(.UIDS,I,STUDYUID,1)  ;P332 Check for replacement
 . Q:STUDIEN=""
 . I $P($G(^MAGV(2005.62,STUDIEN,5)),U,2)'="A" Q
 . S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . I SOPIEN'="" S ONFILESOP=1
 . Q
 ;
 S OUT(1)=0_SSEP_CNT
 Q
 ;
SOPCHECK(UIDS,I) ;
 N MAG2005IEN,MAGPARENTIEN
 S SOPUID=$P(UIDS(I),ISEP,3)
 I $D(^MAG(2005,"P",SOPUID)) D
 . D CHECKUID^MAGDRPCA(.SOPOUT,.SOPLIST,"SOP")
 . I SOPOUT(2)'="",(+SOPOUT(2))'<0 D
 . . D CHECKUID^MAGDRPCA(.STUDYOUT,.STUDYLIST,"STUDY")
 . . I SOPOUT(2)'="",(+SOPOUT(2))'<0 S OUT(I+1)="0"_SSEP_UIDS(I)_SSEP_"on file"
 . . S ONFILESOP=1
 Q
 ;
RECHKFLE(UIDS,I,UID,TYPE) ;
 N FILE,NEWUID
 I TYPE=1 S FILE=2005.63
 I TYPE=2 S FILE=2005.64
 I $D(^MAGV(FILE,"B",UID)) D
 . S IEN=$O(^MAGV(FILE,"B",UID,""))
 . S IEN=$P(^MAGV(FILE,IEN,6),"^")
 . I TYPE=1 D
 . . S NEWUID=$P($G(^MAGV(2005.62,IEN,0)),"^")
 . . ;S $P(UIDS(I),ISEP,TYPE)=NEWUID
 . I TYPE=2 D
 . . S NEWUID=$P($G(^MAGV(2005.63,IEN,0)),"^")
 . . ;S $P(UIDS(I),ISEP,TYPE)=NEWUID
 Q NEWUID
 ;
 ;Set replaced UID in UIDS array if found in 2005.66 duplicate file
DUPUID(UIDS,I,UID,TYPE)  ;P332 added sub
 ; UIDS - Array of UIDs
 ; I    - Current array element of UIDS being processed
 ; UID  - Original UID of TYPE being checked for duplicate
 ; TYPE - UID type - 1-STUDY, 2-SERIES, 3-SOP
 I UID=""!(TYPE="") Q ""
 NEW IEN,FILE,REC0,RPLFND,RPLIEN
 S FILE=$P("2005.62,2005.63,2005.64",",",TYPE)
 S (IEN,RPLIEN,RPLFND)=""
 ;loop dup index from latest and quit if a match is found
 F  S RPLIEN=$O(^MAGV(2005.66,"B",UID,RPLIEN),-1) Q:(RPLIEN="")!RPLFND  D
 . S REC0=$G(^MAGV(2005.66,RPLIEN,0))
 . I TYPE'=$P(REC0,U,5) Q   ;UID type mismatch
 . I UID'=$P(REC0,U) Q      ;UID doesn't match orig in dup record
 . ;verify dup UID is in file index and UID matches original UID in FILE
 . S IEN=$O(^MAGV(FILE,"B",$P(REC0,U,2),""),-1)  ;get IEN from file with replaced UID
 . I IEN="" Q                                    ;replaced UID not in FILE index
 . I UID'=$P($G(^MAGV(FILE,IEN,0)),"^",2) Q      ;original UID does not match
 . S $P(UIDS(I),ISEP,TYPE)=$P(REC0,U,2)          ;set replacement UID
 . S RPLFND=1                                    ;quit loop
 Q IEN  ;return FILE IEN for replaced UID (or null if not found)
