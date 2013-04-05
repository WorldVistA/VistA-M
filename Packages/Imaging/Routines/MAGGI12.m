MAGGI12 ;WOIFO/GEK/SG/JSL - IMAGE FILE API (PROPERTIES) ; 1/13/09 11:20am
 ;;3.0;IMAGING;**93,94,122**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;##### RETURNS IEN OF THE GROUP PARENT FOR THE IMAGE
 ;
 ; IEN           Internal Entry Number of the image record
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Image is not a member of a group
 ;           >0  IEN of the group parent
 ;
 ; Notes
 ; =====
 ;
 ; For a deleted image, the function returns the IEN of the group
 ; that the image belonged to before it was marked as deleted.
 ;
GRPIEN(IEN) ; Returns IEN of the Group parent for the Image.
 N ERR,NODE
 S NODE=$$NODE^MAGGI11(IEN,.ERR)
 I NODE=""  D STORE^MAGUERR(ERR)  Q ERR
 Q +$P($G(@NODE@(0)),U,10)  ; GROUP PARENT (14)
 ;
 ;##### ALLOCATES A NEW RECORD IN THE IMAGE FILE (#2005) AND LOCKS IT
 ; 
 ; Return Values
 ; =============
 ;           >0  IEN for the new record in the IMAGE file (#2005)
 ;
 ; Notes
 ; =====
 ;
 ; The placeholder for the new record (^MAG(2005,IEN) node) is LOCKed 
 ; by this function. It is responsibility of the caller to unlock the 
 ; record after it is created or the record creation is canceled.
 ;
NEWIEN() ;
 N DIEN,IEN,NEWIEN,NODE
 S NEWIEN=0
 ;---
 F  D  Q:NEWIEN
 . S IEN=$O(^MAG(2005," "),-1)+1
 . ;--- Check the IMAGE AUDIT file for a deleted image
 . S DIEN=$O(^MAG(2005.1," "),-1)+1
 . S:DIEN>IEN IEN=DIEN
 . ;--- If the record already exists, skip it
 . S NODE=$NA(^MAG(2005,IEN))  Q:$D(@NODE)
 . ;--- Lock the placeholder in order to make sure that nobody
 . ;--- else is trying to allocate it at the same time.
 . D LOCK^DILF(NODE)  E  Q
 . ;--- Double check that the record has not been created after the
 . ;--- previous $D() check and the LOCK command (a race condition)
 . I $D(@NODE)  L -@NODE  Q
 . ;--- Success
 . S NEWIEN=IEN
 . Q
 ;---
 Q NEWIEN
 ;
 ;##### RETURNS THE PARENT DATA (SUB)FILE REFERENCE
 ;
 ; IEN           Internal Entry Number of the image record
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Image does not have a parent file reference
 ;           >0  Parent data file reference (file/subfile number and
 ;               IEN in the PARENT DATA FILE file (#2005.03) at the
 ;               same time).
 ;
PARFILE(IEN) ;
 N ERR,NODE,PARENTFILE,PFN0
 S NODE=$$NODE^MAGGI11(IEN,.ERR)
 I NODE=""  D STORE^MAGUERR(ERR)  Q ERR
 ;--- Check if the image record has a parent data file reference
 S PARENTFILE=$P($G(@NODE@(2)),U,6)  ; PARENT DATA FILE# (16)
 Q:PARENTFILE="" 0
 ;--- Check if the pointer to the PARENT DATA FILE
 ;--- file (#2005.03) is valid
 S PFN0=$G(^MAG(2005.03,PARENTFILE,0))
 Q:PFN0="" $$ERROR^MAGUERR(-34,,IEN,PARENTFILE)
 ;--- Check if file descriptor has a value in FILE POINTER field (.04)
 Q:$P(PFN0,U,4)="" $$ERROR^MAGUERR(-35,,PARENTFILE)
 ;--- Return the reference
 Q PARENTFILE
 ;
 ;##### RETURNS STATUS OF THE IMAGE
 ;
 ; IEN           Internal Entry Number of the image record
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;           ""  Status is not defined
 ;           >0  Image status
 ;                 ^01: Status code (internal value)
 ;                 ^02: Description (external value)
 ;
STATUS(IEN) ;
 N ERR,STATUS
 S STATUS=$$IMGST^MAGGI11(IEN,.ERR)
 D:ERR<0 STORE^MAGUERR(ERR)
 Q $S(STATUS>0:STATUS,ERR<0:ERR,1:"")
 ;
 ;##### RETURNS THE VIEWABLE STATUS OF THE IMAGE
 ;
 ; IEN           IEN of the image record in the file #2005
 ;
 ; [FLAGS]       Flags that control execution (can be combined):
 ;
 ;                 Q  Perform the integrity checks
 ;
 ; [.MESSAGES]   Reference to a local array for messages returned
 ;               by the image data checks. A node in this array is
 ;               defined only if the result value contains the 
 ;               corresponding subscript value (e.g. the "Q" node is
 ;               defined only if integrity checks fail and the result 
 ;               contains "Q").
 ;
 ; MESSAGES(
 ;
 ;   "Q")        Message returned by the integrity checks.
 ;
 ;   "R")        Message returned by the Radiology report checks
 ;               (reserved but not implemented)
 ;
 ;   "S")        Message regarding the image status.
 ;
 ;   "T")        Message returned by the TIU note checks.
 ;
 ; Return Values
 ; =============
 ;           ""  Image can be viewed
 ;          ...  One or more characters that indicate why
 ;               the image cannot be viewed "as usual":
 ;
 ;                 D  Deleted image
 ;                 Q  Questionable integrity
 ;                 R  Problem with the Radiology report
 ;                    (reserved but not implemented)
 ;                 S  Check the value of the STATUS field
 ;                 T  Can't view the TIU note
 ;
VIEWSTAT(IEN,FLAGS,MESSAGES) ;
 N MAGCF,MAGVS
 K MESSAGES  S MAGVS="",MAGCF=$G(FLAGS)
 D
 . N BUF,ERR,GRPIEN,NODE,STATUS
 . ;--- Validate IEN and get the image status
 . S STATUS=$$IMGST^MAGGI11(IEN,.ERR)
 . S NODE=$$NODE^MAGGI11(IEN)
 . ;--- Force the integrity check in case of error(s)
 . I (ERR<0)!(NODE="")  S MAGCF=MAGCF_"Q" Q
 . ; gek/ P94t7  if IEN is in a group, we also mark child as "T" if Grp is "T"
 . S GRPIEN=+$P($G(@NODE@(0)),U,10)
 . I GRPIEN D
 . . N GBUF,GNODE
 . . S GNODE=$$NODE^MAGGI11(GRPIEN)
 . . S GBUF=$G(@GNODE@(2))
 . . D:+$P(GBUF,U,6)=8925
 . . . N IEN,TMP
 . . . S IEN=+$P(GBUF,U,7)  Q:'IEN
 . . . S TMP=$$CANDO^TIULP(IEN,"VIEW")
 . . . S:'TMP MAGVS=MAGVS_"T",MESSAGES("T")=$P(TMP,U,2)
 . . . Q
 . . Q
 . I MAGVS["T" Q
 . ; gek/ p94t7 __ Done changes
 . ;--- Check the image status
 . D:STATUS'<10
 . . I +STATUS=12  S MAGVS=MAGVS_"D"  Q
 . . S MAGVS=MAGVS_"S"
 . . S MESSAGES("S")=$$MSG^MAGUERR(-33,,$P(STATUS,U,2))
 . . Q
 . ;--- Check if the TIU note can be viewed
 . S BUF=$G(@NODE@(2))
 . D:+$P(BUF,U,6)=8925
 . . N IEN,TMP  S IEN=+$P(BUF,U,7)  Q:'IEN
 . . S TMP=$$CANDO^TIULP(IEN,"VIEW")
 . . S:'TMP MAGVS=MAGVS_"T",MESSAGES("T")=$P(TMP,U,2)
 . . Q
 . ;--- Check the status of the group if necessary
 . I MAGVS'["D",MAGVS'["S"  D
 . . S GRPIEN=$P($G(@NODE@(0)),U,10)   Q:GRPIEN'>0  ; GROUP PARENT
 . . S STATUS=$$IMGST^MAGGI11(GRPIEN)  Q:STATUS<10
 . . ;--- Force the integrity check if the existing
 . . ;--- image entry belongs to a deleted group.
 . . I +STATUS=12  S MAGCF=MAGCF_"Q" Q
 . . ;--- Extend the "non-viewable" group status to the image
 . . S MAGVS=MAGVS_"S"
 . . S MESSAGES("S")=$$MSG^MAGUERR(-33,,$P(STATUS,U,2))
 . . Q
 . Q
 ;
 ;--- Radiology report
 ; Reserved but not implemented
 ;
 ;--- Questionable integrity
 D:MAGCF["Q"
 . N MAGQI
 . D CHK^MAGGSQI(.MAGQI,IEN)
 . S:'$G(MAGQI(0)) MAGVS=MAGVS_"Q",MESSAGES("Q")=$P(MAGQI(0),U,2)
 . Q
 ;
 ;---
 Q MAGVS
 ;+++++   ANNSTAT     *******
 ;  Determine if this image can be annotated.
 ;  *** INPUT Parameters  
 ;  
 ;  VSTCODE    : The Image 'View Status' numeric code.
 ;    if this isn't sent as a parameter, it is computed.
 ;   
 ;  MAGIEN     : Image IEN (^MAG(2005))
 ;
 ; *** OUTPUT Parameters  (optional)
 ;  DESC    : Text Reason for the result;
 ;  
 ; Result Values
 ; --------------------------
 ;  RESULT of this call is a numeric value 
 ;     0 : success, image can be annotated.
 ;     
 ;          Values of STATUS field (113) that are okay. 
 ;     1 :  Viewable   (RESULT will be changed to 0)
 ;     2 :  QA Reviewed (RESULT will be changed to 0)
 ;     
 ;     
 ;          Values of STATUS field (113) 
 ;                   that will block Annotation.
 ;     10 : Image capture is in progress, (Future for groups.)
 ;     11 : Image Needs Review
 ;     12 : Image is Deleted.
 ;     
 ;          Values of Image "View Status" that will block Annotation
 ;          ("View Status" is a computed value, not an IMAGE Field)
 ;     21 : Image has Questionable Integrity issues.
 ;     22 : User cannot "VIEW" the associated TIU Note. 
 ;                 due to TIU Business Rules
 ;     23 : Image is not Viewable by Radiology Rule (Future ) 
 ;     
 ;          Values of other codes specific for blocked Annotation 
 ;     30 : User Cannot "MAKE ADDENDUM" to the associated TIU Note. 
 ;                 due to TIU Business Rules
 ;     31 : Image in Rescinded.
 ;    
 ;   
ANNSTAT(MAGIEN,VSTCODE,DESC) ;Annotation Status
 N ANCODE,FLG,STI,VSTCD,TIUIEN,AMND,MSG,X,X2,GRPIEN
 ;
 S ANCODE=$G(VSTCODE)
 S DESC=""
 I ANCODE="" D
 . ; compute View Status Code if not sent.
 . ; QI Check already done in MAGAII ;S FLG="Q"
 . S FLG=""
 . S VSTCD=$$VIEWSTAT(MAGIEN,FLG,.MSG)
 . ;   example of Result from $$VIEWSTAT 
 . ;   ""    : success , viewable
 . ;   "QT"  : a Text String if not viewable   
 . ;   
 . ;   -MSG- : is an array of reasons for failure, each letter 
 . ;           of Result is node of array i.e. MSG("Q")="..."
 . ;           MSG("T")="..." 
 . ;    for this call ANNSTAT, we will just get first entry
 . ;
 . ;if the View Status Code (VSTCD) is not "", return it's text in MSG
 . I VSTCD]"" S X=$O(MSG("")) S DESC=$G(MSG(X))
 . S STI=+$P($G(^MAG(2005,MAGIEN,100)),"^",8)       ; STATUS (113)
 . ;--- Now get View Status Numeric value
 . S ANCODE=$$VSTCODE^MAGGAII(VSTCD,STI)
 . Q
 ;
 ; if the View Status Code > 9 then user cannot view the image, so
 ;   we won't let user annotate the image.
 ;   and will get a generic description of the code, if DESC is still ""
 I (ANCODE>9) S DESC=$S(DESC="":$$VSTTEXT(ANCODE),1:DESC) Q ANCODE
 ; if Image is attached to TIU Note, we check TIU Business Rules.
 S GRPIEN=$P($G(^MAG(2005,MAGIEN,0)),U,10),GRPIEN=$S(+GRPIEN:GRPIEN,1:MAGIEN)
 S X2=$G(^MAG(2005,GRPIEN,2))
 I $P(X2,"^",6)=8925 D
 . S TIUIEN=$P(X2,"^",7)
 . ; If we don't have a pointer to 8925, that is DB corruption
 . ; This would probably already be caught, 
 . ;    but check in case. VIEWSTAT wasn't run prior to this call.
 . I 'TIUIEN S ANCODE=21,DESC="Invalid pointer to TIU Package ("_TIUIEN_")" Q
 . S AMND=$$CANDO^TIULP(TIUIEN,"MAKE ADDENDUM")  ;IA#?
 . ; Example of result from TIULP
 . ;   0^ You may not ADDEND this UNSIGNED PRIMARY CARE.
 . ;   1
 . I 'AMND S ANCODE=30,DESC=$P(AMND,"^",2)
 . Q
 ; if ANCODE > 9 then TIU Business rule says no Annotation.
 I (ANCODE>9) S DESC=$S(DESC="":$$VSTTEXT(ANCODE),1:DESC) Q ANCODE
 ;
 I $P($G(^MAG(2005,MAGIEN,100)),"^",12)=1 D
 . ; Image is Rescinded
 . S ANCODE=31
 . Q
 ; if ANCODE > 9 then Image is rescinded and stop Annotation.
 I (ANCODE>9) S DESC=$$VSTTEXT(ANCODE) Q ANCODE
 ; If we get here, Image can be annotated.
 ; - not changing to 0.  Status here is 1 or 2 for viewable.
 ;S DESC="Image can be annotated."
 ; Send exact numeric code.  Delphi understands < 10 is viewable
 ; and can be annotated.
 S DESC=$$VSTTEXT(ANCODE)
 Q ANCODE
 ;
 ; ##### VSTTEXT  returns a Description of the Status Code.
 ; 
 ; CODE is the numeric code for the Annotation Status.
 ;    This is based on Status, Viewable Status, and 
 ;    two new return values for Annotation Status. 
 ;    
VSTTEXT(CODE) ;Description for Annotation Status
 N I,DONE,STR
 S (I,DONE)=0
 F  D  Q:DONE
 . S I=I+1
 . S STR=$T(DATA+I)
 . I $P(STR,";",3)=CODE S DESC=$P(STR,";",4),DONE=1
 . I $P(STR,";",3)="END" S DESC=$P(STR,";",4)_CODE,DONE=1
 . Q
 Q DESC
 ; ##### DATA Table for Image Status, View Status,  Annotation Status.
 ;    
 ;    the Code is in Piece 3, and the Description is in Piece 4.
 ;    
 ; Image STATUS field (113) 
 ;    Codes 0..12 are the Status Codes from field 113
 ;    
 ; Viewable Status and Annotation Status are computed values, 
 ;    based on, but not equal to STATUS (113)
 ;    they depend on TIU Business Rules, QI Of image, User Keys.
 ;    The Codes are computed in other functions.  Description of the 
 ;    code is returned from this table.
 ;
 ;    Codes 21..23 are the Viewable Status Codes. (computed value)
 ;    Codes 30..31 are Annotation Status Codes.
DATA ;
 ;;0;Image is Viewable;
 ;;1;Image is Viewable.;
 ;;2;Image is QA Reviewed.;
 ; 
 ;;10;Image capture is in progress.; (Future for groups.)
 ;;11;Image needs review.;
 ;;12;Image is deleted.;
 ;     
 ;;21;Image has Questionable Integrity issues.;
 ;;22;User cannot 'View' the associated TIU note. TIU Business Rule.;
 ;;23;Image is not Viewable by Radiology Rule.; (future) 
 ;     
 ;;30;User cannot 'Make Addendum' to the associated TIU Note. TIU Business Rule.;
 ;;31;Image is Rescinded.;
 ;;END;User cannot Annotate the Image. Unknown CODE: ;
 Q
