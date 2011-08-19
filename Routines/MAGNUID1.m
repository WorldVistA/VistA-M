MAGNUID1 ;WOIFO/NST - DICOM UID generator ; 15 Oct 2010 12:45 AM
 ;;3.0;IMAGING;**106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
 ;*****  Generates a new DICOM UID
 ;       
 ; RPC: N/A
 ; 
 ; Input Parameters
 ; ================
 ;   SITE      -            VistA Station Number field #99 in INSTITUTION file (#4)
 ;   SUBROOT   - (Optional) A number, Default value is 0.
 ;                            (e.g. 106, 4, 7, 8, or 106.4 
 ;                              4 - STUDY UID,
 ;                              7 - SERIES UID,
 ;                              8 - SOP INSTANCE UID,
 ;                          106.4 - patch 106 STUDY UID.          
 ;   ROOTOWNER - (Optional) Name of the DICOM root owner.
 ;                          Default value is "Veterans' Administration".
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = 0^Error message
 ; if success MAGRY = 1^New DICOM UID
 ;                              
NEWUID(MAGRY,SITE,SUBROOT,ROOTOWNER) ; Generates a new DICOM UID
 N ROOT,DTSTAMP,UNISITE,LASTCNT,CNT
 N ROOTIEN,UID,LASTUPDATE,X
 N MAGRESA,MAGNFDA,MAGNXE
 ;
 I SITE="" S MAGRY="0^Station number is blank" Q  ; fatal error
 S:$G(SUBROOT)="" SUBROOT=0
 S:$G(ROOTOWNER)="" ROOTOWNER="Veterans' Administration" ; VA is a default root owner 
 S ROOTIEN=$$FIND1^DIC(2006.15,"","BX",ROOTOWNER)
 I ROOTIEN'>0 S MAGRY="0^Root UID is not found" Q  ; fatal error
 ;
 S ROOT=$P($G(^MAGD(2006.15,ROOTIEN,"UID ROOT")),"^",1)
 I ROOT="" S MAGRY="0^DICOM root is missing." Q
 S DTSTAMP=$$DATETIME()
 S UNISITE=$$CONVS2N(SITE)
 I UNISITE'>0 S MAGRY="0^Cannot convert SITE NUMBER to numeric value" Q
 L +^MAGD(2006.15,ROOTIEN,1):1E9 ; Lock
 S X=$G(^MAGD(2006.15,ROOTIEN,1))
 S LASTUPDATE=$P(X,"^",1)
 S LASTCNT=$P(X,"^",2)
 ;
 S CNT=LASTCNT+1 ; Increment the TICK
 I (LASTUPDATE\1)'=(DTSTAMP\1) S CNT=1  ; Reset the TICK. New day - new beginning
 ;
 I (LASTUPDATE=DTSTAMP),(LASTCNT'<CNT) D  Q
 . S MAGRY="0^Last UID tick is greater than the new one"
 . L -^MAGD(2006.15,ROOTIEN,1) ; Unlock
 . Q
 I LASTUPDATE>DTSTAMP D  Q
 . S MAGRY="0^Last UID datetime stamp is greater than the new one"
 . L -^MAGD(2006.15,ROOTIEN,1) ; Unlock
 . Q
 ;
 K MAGNFDA
 S MAGNFDA(2006.15,ROOTIEN_",",2)=DTSTAMP
 S MAGNFDA(2006.15,ROOTIEN_",",3)=CNT
 D UPDATE^DIE("","MAGNFDA","","MAGNXE")
 L -^MAGD(2006.15,ROOTIEN,1) ; Unlock
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 ;
 S UID=ROOT_"."_SUBROOT_"."_UNISITE_"."_DTSTAMP_"."_CNT
 I $L(UID)>64 S MAGRY="0^Generated UID is greater than 64 characters" Q
 S MAGRY="1^"_UID
 Q
 ;
DATETIME() ; Get Date time
 Q $$NOW^XLFDT
 ;
CONVS2N(STRTOCNV) ; Convert a string to a unique number
 ; The string should include characters from "0" to "Z"
 ; If other character is found -1 will be return
 ; Before the conversion all characters are converted to upper case
 N I,X,RESULT,FACTOR,ERR
 S ERR=0
 S RESULT=""
 S FACTOR=1
 S STRTOCNV=$$UP^XLFSTR(STRTOCNV) ; All upper case
 ; Start with the last character
 F I=$L(STRTOCNV):-1:1 D  Q:ERR
 . S X=$A($E(STRTOCNV,I))-48  ; offset the ASCII number with 48. "0" is 0, "Z" is 42
 . I (X<0)!(X>42) S ERR=1 Q
 . S RESULT=RESULT+(FACTOR*X)
 . S FACTOR=FACTOR*43         ; 43 is the number of characters between "0" and "Z"
 . Q
 Q:ERR -1  ; a character is not in the "0"-"Z" range
 Q RESULT
