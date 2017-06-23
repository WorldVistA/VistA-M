FBUTL9 ;WIOFO/SAB - FEE BASIS UTILITY FOR USER AUDIT ;6/18/2014
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
ADDUA(FBFILE,FBIENS,FBTXT) ; Add record to User Audit multiple
 ; input
 ;   FBFILE - file being edited
 ;   FBIENS - internal entry number of record being edited in file
 ;   FBTXT  - (optional) text describing nature of edit, max 60 char
 ; returns 1 if record added, 0 if record not added
 ;
 N FBAFILE,FBAIENS,FBRET
 S FBRET=0
 ;
 S FBFILE=$G(FBFILE)
 I FBFILE=161.01 S FBAFILE=161.192
 I FBFILE=162.2 S FBAFILE=162.292
 I FBFILE=162.4 S FBAFILE=162.492
 I FBFILE=162.7 S FBAFILE=162.792
 ;
 I $G(FBIENS)]"" S FBAIENS="+1,"_FBIENS
 ;
 I $G(FBAFILE)]"",$G(FBAIENS)]"" D
 . N FBFDA,DIERR
 . S FBFDA(FBAFILE,FBAIENS,.01)=$$NOW^XLFDT ; DATE/TIME EDITED
 . S FBFDA(FBAFILE,FBAIENS,1)=DUZ ; EDITED BY
 . S:$G(FBTXT)]"" FBFDA(FBAFILE,FBAIENS,2)=$E(FBTXT,1,60) ; COMMENTS
 . D UPDATE^DIE("","FBFDA")
 . I $G(DIERR)="" S FBRET=1
 Q FBRET
 ;
UOKPAY(FBDFN,FBAUTHP,FBUSR) ; User OK to Pay
 ; inputs
 ;   FBDFN   = Patient IEN (file 161 and file 2)
 ;   FBAUTHP = Authorization IEN (sub-file 161.01)
 ;   FBUSR   = (Optional) User IEN (file 200), defaults to DUZ
 ; return
 ;   = 1 if OK for user to enter payment associated with authorization
 ;   = 0^message if not OK for user to enter payment 
 ;
 N FBRET
 S FBRET=1
 I $G(FBUSR)="" S FBUSR=$G(DUZ)
 ;
 I $G(FBDFN),$G(FBAUTHP) D
 . N FB583,FB7078,FBX
 . ; check file 161
 . I $O(^FBAAA(FBDFN,1,FBAUTHP,"LOG1","AU",FBUSR,0)) S FBRET="0^authorization edited" Q
 . ;
 . S FBX=$P($G(^FBAAA(FBDFN,1,FBAUTHP,0)),"^",9) ; ASSOCIATED 7078/583
 . I FBX[";FB7078(" S FB7078=+FBX
 . I FBX[";FB583(" S FB583=+FBX
 . ;
 . I $G(FB7078) D  Q:FBRET'>0
 . . N FBNR
 . . ; check file 162.4 when 7078
 . . I $O(^FB7078(FB7078,"LOG1","AU",FBUSR,0)) S FBRET="0^7078 edited" Q
 . . ; check file 162.2 if notification/request exists for 7078
 . . S FBNR=$O(^FBAA(162.2,"AM",FB7078,0))
 . . I FBNR,$O(^FBAA(162.2,FBNR,"LOG1","AU",FBUSR,0)) S FBRET="0^CH notification/request edited"
 . ;
 . ; check file 162.7 when unauthorized claim
 . I $G(FB583),$O(^FB583(FB583,"LOG1","AU",FBUSR,0)) S FBRET="0^unauthorized claim edited" Q
 ;
 Q FBRET
 ;
 ;FBUTL9
