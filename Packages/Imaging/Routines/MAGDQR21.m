MAGDQR21 ;WOIFO/EdM,NST,MLH,JSL,SAF,BT - RPCs for Query/Retrieve SetUp ; 09 May 2011 4:27 PM
 ;;3.0;IMAGING;**83,104,123,119**;Mar 19, 2002;Build 4396;Apr 19, 2013
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
GET(OUT,DEST,GATEWAY) ; RPC = MAG GET DICOM DEST
 N D0,D1,N,OK,X
 I $G(DEST)="" D  Q
 . S N=1
 . S X="" F  S X=$O(^MAG(2006.587,"B",X)) Q:X=""  S N=N+1,OUT(N)="B^"_X
 . S X="" F  S X=$O(^MAG(2006.587,"D",X)) Q:X=""  S N=N+1,OUT(N)="D^"_X
 . S OUT(1)=N
 . Q
 ;
 S GATEWAY=$G(GATEWAY) S:GATEWAY="--All DICOM Gateways--" GATEWAY=""
 S D0=0,OK=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D  Q:OK
 . S X=$G(^MAG(2006.587,D0,0))
 . Q:$P(X,"^",1)'=DEST
 . I GATEWAY'="",$P(X,"^",5)'=GATEWAY Q
 . S OK=1,N=6
 . S OUT(2)="2^"_$P(X,"^",2)
 . S OUT(3)="3^"_$P(X,"^",3)
 . S OUT(4)="4^"_$P(X,"^",4)
 . S OUT(5)="5^"_$P(X,"^",6)
 . S OUT(6)="6^"_$P(X,"^",7)
 . S D1=0 F  S D1=$O(^MAG(2006.587,D0,1,D1)) Q:'D1  D
 . . S X=$G(^MAG(2006.587,D0,1,D1,0)) Q:$P(X,"^",1)=""
 . . S N=N+1,OUT(N)=X
 . . Q
 . Q
 S OUT(1)=N
 Q
 ;
SET(OUT,DATA,DEST,GATEWAY) ; RPC = MAG SET DICOM DEST
 N D0,D1,I,N,P,Q,O1,O5,O7,OK,T,X
 I $G(DEST)="" S OUT="-1,No Destination Specified." Q
 ;
 S I="" F  S I=$O(DATA(I)) Q:I=""  D
 . S T=DATA(I) Q:T'["^"
 . I +T=2 S P(2)=$P(T,"^",2) Q
 . I +T=3 S P(3)=$P(T,"^",2) Q
 . I +T=4 S P(4)=$P(T,"^",2) Q
 . I +T=5 S P(6)=$P(T,"^",2) Q
 . I +T=6 S P(7)=$P(T,"^",2) Q
 . S Q($P(T,"^",1))=(+$P(T,"^",2))_"^"_(+$P(T,"^",3))
 . Q
 ;
 S OUT=0
 S GATEWAY=$G(GATEWAY) S:GATEWAY="--All DICOM Gateways--" GATEWAY=""
 S D0=0,OK=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D  Q:OK
 . S X=$G(^MAG(2006.587,D0,0)),O1=$P(X,"^",1),O5=$P(X,"^",5),O7=$P(X,"^",7)
 . Q:O1'=DEST
 . I GATEWAY'="",O5'=GATEWAY Q
 . S:GATEWAY'="" OK=1 S OUT=OUT+1
 . I O1'="",O5'="",O7'="" K ^MAG(2006.587,"C",O1,O7,O5,D0)
 . I O5'="",O7'="" K ^MAG(2006.587,"D",O5,O7,D0)
 . S I="" F  S I=$O(P(I)) Q:I=""  S:P(I)'="" $P(X,"^",I)=P(I)
 . S:$G(P(7))'="" O7=P(7)
 . S ^MAG(2006.587,D0,0)=X
 . I O1'="",O5'="",O7'="" S ^MAG(2006.587,"C",O1,O7,O5,D0)=""
 . I O5'="",O7'="" S ^MAG(2006.587,"D",O5,O7,D0)=""
 . K ^MAG(2006.587,D0,1)
 . S D1=0,I="" F  S I=$O(Q(I)) Q:I=""  D
 . . S D1=D1+1,^MAG(2006.587,D0,1,D1,0)=I_"^"_Q(I)
 . . S ^MAG(2006.587,D0,1,"B",I,D1)=""
 . . Q
 . S:D1 ^MAG(2006.587,D0,1,0)="^2006.5871SA^"_D1_"^"_D1
 . Q
 Q
 ;
TMPOUT(NAME) ; Return name of the temp
 N X
 S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1)
 S X=$NA(^TMP("MAG",$J,NAME))
 K @X
 Q X
 ;
STUDY2(OUT,GROUPS,REQDFN,IMGLESS,FLAGS) ; RPC = MAG DOD GET STUDIES IEN
 ; CR, 5-28-09
 ; IMGLESS is a new flag to speed up queries: if=1 (true), just get study-level 
 ;            data, if null or zero get everything. This new flag is optional.
 ; BT, 01-06-12
 ; FLAGS is ""  - Exclude Deleted records (default)
 ;          "D" - Include Deleted records
 ;       
 ;
 N STUDY,INCDEL
 ;
 S REQDFN=$G(REQDFN)
 S INCDEL=$G(FLAGS)["D"
 S IMGLESS=$G(IMGLESS)
 S OUT=$$TMPOUT^MAGDQR21("STUDY")
 S @OUT@(1)=1
 ;
 I $G(GROUPS) D CNVGRP^MAGDQR21(.GROUPS)
 ;
 D GETSTUDY^MAGDQR21(.GROUPS,.STUDY,INCDEL) ; read IENS in GROUPS and sort into STUDY by UID,IEN
 ;
 D GENOUT^MAGDQR21(.STUDY,REQDFN,IMGLESS,INCDEL) ; generate OUT based on STUDY
 ;
 ;update last counter
 S @OUT@(1)=@OUT@(1)-1
 Q
 ;
CNVGRP(GROUPS) ; Add top level GROUPS value to GROUPS array 
 ; GROUPS=10, GROUPS(1)=11, GROUPS(2)=12 becomes GROUPS(1)=11, GROUPS(2)=12, GROUPS(3)=10
 N LAST
 S LAST=$O(GROUPS(""),-1)+1
 S GROUPS(LAST)=GROUPS
 Q
 ;
GETSTUDY(GROUPS,STUDY,INCDEL) ; Read IENS in GROUPS and sort into STUDY by UID,IEN
 N I,IEN
 S I=""
 F  S I=$O(GROUPS(I)) Q:I=""  D
 . S IEN=$G(GROUPS(I))
 . Q:'IEN
 . I 'INCDEL D SRTUID^MAGDQR21(IEN,.STUDY)
 . I INCDEL D SRTUID2^MAGDQR21(IEN,.STUDY)
 . Q
 Q
 ;
SRTUID(IEN,STUDY) ; Sort group by UID, IEN
 N PARENT,UID
 ;get parent IEN
 S PARENT=$P($G(^MAG(2005,IEN,0)),"^",10)
 S:PARENT IEN=PARENT
 ;IEN now is parent IEN or Individual Image
 S UID=$P($G(^MAG(2005,IEN,"PACS")),"^",1) S:UID="" UID="?" ;no pacs
 S STUDY(UID,IEN)=""
 Q
 ; 
SRTUID2(IEN,STUDY) ; Sort group by UID, IEN (include Deleted Images)
 N PARENT,UID,MAGFIL
 ;get parent IEN
 S PARENT=$P($G(^MAG(2005,IEN,0)),"^",10)
 S:'PARENT PARENT=$P($G(^MAG(2005.1,IEN,0)),"^",10)
 S:PARENT IEN=PARENT
 ;IEN now is parent IEN or Individual Image
 S MAGFIL=$$FILE^MAGGI11(IEN)
 S UID=$S(MAGFIL:$P($G(^MAG(MAGFIL,IEN,"PACS")),"^",1),1:"")
 S:UID="" UID="?" ;no pacs
 S STUDY(UID,IEN)=""
 Q
 ;
GENOUT(STUDY,REQDFN,IMGLESS,INCDEL) ; Generate output in ^TMP based on STUDY array
 N UID,IEN
 ;
 S UID=""
 F  S UID=$O(STUDY(UID)) Q:UID=""  D
 . I UID="?" D  Q
 . . S IEN=""
 . . F  S IEN=$O(STUDY(UID,IEN)) Q:IEN=""  D STUDY^MAGDQR21("",IEN,REQDFN,IMGLESS,INCDEL)
 . . Q
 . ;ELSE
 . D STUDY^MAGDQR21(UID,"",REQDFN,IMGLESS,INCDEL)
 . Q
 Q
 ; 
STUDY(UID,IEN,REQDFN,IMGLESS,INCDEL) ; Generate output in ^TMP based on parameters
 N STUDY
 N SERIESARRAY ; array of series numbers for this study
 N TOTIMAGES ; total number of images for all series in this study
 N PAT ; array of IENs by patient
 N PATCOUNT ; array of patients, use for validation purposes, should contain only one patient
 N I0 ;IEN where the patient found
 N D0
 N STUMO ;Procedure array
 ;
 D WRTOUT^MAGDQR21("NEXT_STUDY|"_UID_"|"_IEN)
 ;
 D:UID'="" GETGPUID^MAGDQR21(UID,.STUDY,INCDEL) ;fill STUDY based on UID
 D:IEN GETGPIEN^MAGDQR21(IEN,.STUDY,INCDEL) ;add IEN into STUDY
 Q:'$O(STUDY(""))
 ; 
 D GETPAT^MAGDQR21(.STUDY,.PAT,.PATCOUNT,.TOTIMAGES,REQDFN,INCDEL) ;get images for patient
 Q:'$$VALPAT^MAGDQR21(UID,.PAT,.PATCOUNT,REQDFN)  ;validate to make sure all images belonged to one patient
 ;
 S I0=$O(PAT(REQDFN,"")) ;include the first Image when writing out the STUDY section
 Q:'$$WRTIEN^MAGDQR21(UID,I0,TOTIMAGES,REQDFN)
 ;
 Q:'$$INTEGDFN^MAGDQR21(I0,REQDFN,INCDEL)
 ;
 D WRTOUT^MAGDQR21("STUDY_PAT|"_REQDFN_"|"_$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(REQDFN),1:"-1^NO MPI")_"|"_$P($G(^DPT(REQDFN,0)),"^",1))
 ;
 ; CR, 5-28-09
 ; For study-level data stop here without additional checks 
 Q:IMGLESS=1
 ;end of check above
 ;
 S D0=""
 F  S D0=$O(PAT(REQDFN,D0)) Q:D0=""  D WRTIMG^MAGDQR20(.SERIESARRAY,D0,REQDFN,.STUMO,INCDEL)
 D WRTMOD^MAGDQR21(.STUMO) ; list all modalities
 Q
 ;
GETGPUID(UID,STUDY,INCDEL) ; Given UID, populate STUDY array with Image IEN 
 N D0
 S D0=""
 F  S D0=$O(^MAG(2005,"P",UID,D0)) Q:D0=""  D
 . S:'$P($G(^MAG(2005,D0,0)),"^",10) STUDY(D0)=2005 ; add either Group IEN or individual IEN (not child IEN)
 . Q
 ;
 I INCDEL D
 . S D0=""
 . F  S D0=$O(^MAG(2005.1,"P",UID,D0)) Q:D0=""  D
 . . Q:'$$ISDEL^MAGGI11(D0)
 . . S:'$P($G(^MAG(2005.1,D0,0)),"^",10) STUDY(D0)=2005.1 ; add either deleted Group IEN or deleted individual IEN (not child IEN)
 . . Q
 . Q
 Q
 ;
GETGPIEN(IEN,STUDY,INCDEL) ; Add IEN into STUDY (include deleted images)
 S:'$P($G(^MAG(2005,IEN,0)),"^",10) STUDY(IEN)=2005 ; add image IEN
 ;
 I INCDEL,$$ISDEL^MAGGI11(IEN) D
 . S:'$P($G(^MAG(2005.1,IEN,0)),"^",10) STUDY(IEN)=2005.1 ;add deleted image IEN
 . Q
 Q
 ;
GETPAT(STUDY,PAT,PATCOUNT,TOTIMAGES,REQDFN,INCDEL) ; Get Total Images count and fill Patient array based on STUDY
 ;Input:
 ;   STUDY     - array of all images
 ;   REQDFN    - patient
 ;   INCDEL    - include Deleted Images
 ;Output:
 ;   PAT       - array of all images for the patient
 ;   PATCOUNT  - array to validate all images should belonged only to one patient
 ;   TOTIMAGES - total images for the patient
 ;
 N D0,MAGFIL,DFN,ISGRP
 S TOTIMAGES=0
 S D0=""
 ;
 F  S D0=$O(STUDY(D0)) Q:D0=""  D
 . S MAGFIL=STUDY(D0)
 . S DFN=+$P($G(^MAG(MAGFIL,D0,0)),"^",7)
 . S PATCOUNT(DFN)=""
 . S:REQDFN=DFN PAT(DFN,D0)=""
 . ;
 . ;Add image count to Total Images for the study
 . S ISGRP=$$ISGRP^MAGDQR21(D0,INCDEL)
 . I 'ISGRP,REQDFN=DFN S TOTIMAGES=TOTIMAGES+1 Q
 . I MAGFIL=2005 S TOTIMAGES=TOTIMAGES+$$GETGPIM^MAGDQR21(D0,REQDFN,.PATCOUNT) ; count group images
 . I INCDEL S TOTIMAGES=TOTIMAGES+$$GETGPDIM^MAGDQR21(D0,REQDFN,.PATCOUNT) ; count deleted group images
 . Q
 Q
 ;
ISGRP(D0,INCDEL) ; return 1 if D0 is a group IEN, 0 otherwise
 N ISGRP
 S ISGRP=1
 I 'INCDEL,'$D(^MAG(2005,D0,1)) S ISGRP=0 ; a single image (e.g., photo ID), not a group
 I INCDEL,'$D(^MAG(2005,D0,1)),'$D(^MAG(2005.1,D0,1)) S ISGRP=0 ; a single deleted image (e.g., photo ID), not a group
 Q ISGRP
 ;
GETGPIM(D0,REQDFN,PATCOUNT) ; return total images in the group and PATCOUNT array for patient validation
 N D1,I0,DFN,IMGCNT
 S IMGCNT=0
 S D1=0 ;go through all images. They should belong to one pt
 F  S D1=$O(^MAG(2005,D0,1,D1)) Q:'D1  D
 . S I0=+$G(^MAG(2005,D0,1,D1,0)) Q:'I0
 . S DFN=+$P($G(^MAG(2005,I0,0)),"^",7)
 . S PATCOUNT(DFN)="" ;populate PATCOUNT with DFN for validation (DFN might be different in this case it's a corrupted record)
 . ; increment image count unless single pt was requested and this isn't that pt
 . I REQDFN'=DFN Q
 . S IMGCNT=IMGCNT+1
 . Q
 Q IMGCNT
 ;
GETGPDIM(D0,REQDFN,PATCOUNT) ; return total images in the group and PATCOUNT array for patient validation
 N I0,DFN,IMGCNT
 S IMGCNT=0
 S I0="" ;go through all AUDIT images.
 F  S I0=$O(^MAG(2005.1,"AGP",D0,I0)) Q:I0=""  D
 . S DFN=+$P($G(^MAG(2005.1,I0,0)),"^",7)
 . S PATCOUNT(DFN)="" ;populate PATCOUNT with DFN for validation (DFN might be different in this case it's a corrupted record)
 . ; increment image count unless single pt was requested and this isn't that pt
 . I REQDFN'=DFN Q
 . S IMGCNT=IMGCNT+1
 . Q
 Q IMGCNT
 ;
VALPAT(UID,PAT,PATCOUNT,REQDFN) ; Validate - should only have one patient
 N CONT,DFN
 ;
 S CONT=1,PATCOUNT=0
 S DFN="" F  S DFN=$O(PATCOUNT(DFN)) Q:DFN=""  S PATCOUNT=PATCOUNT+1
 ;
 I PATCOUNT>1 D
 . ; duplicate study instance UID?
 . D WRTOUT^MAGDQR21("STUDY_ERR|"_UID_"|"_PATCOUNT_" different patients")
 . S CONT=$S('REQDFN:0,'$D(PAT(REQDFN)):0,1:1) ;continue processing with error if patient requested found 
 . Q
 ;
 Q CONT
 ;
WRTIEN(UID,I0,TOTIMAGES,REQDFN) ; Output STUDY UID and IEN line
 N OBJGRP
 ; 
 D:UID'="" WRTOUT^MAGDQR21("STUDY_UID|"_UID)
 I 'I0 D WRTOUT^MAGDQR21("STUDY_ERR|"_UID_"|Matching study not found for patient "_REQDFN) Q 0
 S OBJGRP=$$ONEGROUP^MAGDQR21(I0) ; get the first image IEN for group/image I0
 D WRTOUT^MAGDQR21("STUDY_IEN|"_I0_"|"_TOTIMAGES_"|"_OBJGRP_"|"_$$CPTCODE^MAGDQR21(I0)_"|"_$$GETSITE1^MAGDQR21(OBJGRP))
 Q 1
 ; 
INTEGDFN(I0,REQDFN,INCDEL) ; check integrity of study record
 ;Return 1 if Specified DFN (REQDFN) matches study DFN (VA internal use only!)
 ;       0 otherwise
 N X,CONT,MAGFIL,QINTEG
 ;
 D CHK^MAGGSQI(.X,I0)
 S QINTEG='$G(X(0))
 D:QINTEG APDOUT^MAGDQR21("|"_$P($G(X(0)),"^",2))
 S CONT=1
 ; override QI check only if image DFN = DFN specified in call
 ; (VA internal only!)
 I QINTEG D
 . I 'REQDFN S CONT=0 Q
 . S MAGFIL=$$FILE^MAGGI11(I0)
 . I MAGFIL="" S CONT=0 Q
 . S:$P($G(^MAG(MAGFIL,I0,0)),"^",7)'=REQDFN CONT=0
 . Q
 ;
 Q CONT
 ;
WRTMOD(STUMO) ; Output STUDY_MODALITY line
 N M,X
 S X="",M=""
 F  S M=$O(STUMO(M)) Q:M=""  S X=X_$S(X'="":",",1:"")_M
 D:X'="" WRTOUT^MAGDQR21("STUDY_MODALITY|"_X)
 Q
 ;
ONEGROUP(GROUP) ; Get the first IMAGE_IEN for this group in IMAGE file (#2005)
 ;                or IMAGE AUDIT file (#2005.1)  
 N D1,IMGIEN,MAGNODE
 S MAGNODE=$$NODE^MAGGI11(GROUP)
 I MAGNODE="" Q "0^Error 2 - First Image not available; No Data"
 I '$D(@MAGNODE@(1)) Q GROUP ; a single image (e.g., photo ID), not a group
 S IMGIEN=""
 S D1=$O(@MAGNODE@(1,0))
 I D1>0 S IMGIEN=+$G(@MAGNODE@(1,D1,0))
 I IMGIEN'>0 S IMGIEN=$O(^MAG(2005.1,"AGP",GROUP,""))
 I IMGIEN'>0 S IMGIEN="0^Error 1 - First Image not available"
 Q IMGIEN
 ;
WRTOUT(S) ; Write a new line
 N CNT
 S CNT=^TMP("MAG",$J,"STUDY",1)+1
 S ^TMP("MAG",$J,"STUDY",1)=CNT
 S ^TMP("MAG",$J,"STUDY",CNT)=S
 Q
 ;
APDOUT(S) ; Append to last line
 N CNT
 S CNT=^TMP("MAG",$J,"STUDY",1)
 S ^TMP("MAG",$J,"STUDY",CNT)=$G(^TMP("MAG",$J,"STUDY",CNT))_S
 Q
 ;
CPTCODE(MAGIEN) ; Returns CPT code by IEN (image pointer) in IMAGE file (#2005)
 ;                or IMAGE AUDIT file (#2005.1)  
 ; MAGIEN = IEN in IMAGE file (#2005) or IMAGE AUDIT file (#2005.1)
 N RAIEN,CPTCODE,MAGFILE
 S MAGFILE=$$FILE^MAGGI11(MAGIEN)
 S RAIEN=+$$GET1^DIQ(MAGFILE,MAGIEN,62,"I")  ; Get PACS PROCEDURE field #62
 S CPTCODE=$P($G(^RAMIS(71,RAIEN,0)),"^",9) ; IA # 1174  get CPT Code
 Q:CPTCODE="" ""  ; quit with empty code
 S CPTCODE=$$CPT^ICPTCOD(CPTCODE) ; IA # 1995, supported reference
 Q $P(CPTCODE,"^",2) ; Return the code
 ;
GETSITE1(MAGIEN) ; Returns STATION NUMBER where the image is stored
 ; MAGIEN = IEN in IMAGE file (#2005)
 N MAGNODE,TMP,NLOCIEN,PLC
 N SITEIEN,SITENUM
 I MAGIEN'>0 Q ""
 D:'$D(MAGJOB("NETPLC")) NETPLCS^MAGGTU6 ; Initialize MAGJOB("NETPLC")
 S MAGNODE=$$NODE^MAGGI11(MAGIEN)
 I MAGNODE="" Q ""
 S TMP=$G(@MAGNODE@(0))
 S NLOCIEN=+$S($P(TMP,U,3):$P(TMP,U,3),1:$P(TMP,U,5)) ; Get IEN in NETWORK LOCATION file (#2005.2)
 S PLC=$P($G(MAGJOB("NETPLC",NLOCIEN)),U,1)     ; Imaging Site Parameters IEN
 Q $$GETSNUM^MAGDQR21(PLC)  ; Return STATION NUMBER
 ;
GETSNUM(MAGPLC) ; Returns STATION NUMBER by Image Site Parameters IEN
 ; MAGPLC - IEN in IMAGING SITE PARAMETERS file (#2006.1)
 I MAGPLC'>0 Q ""
 N SITEIEN,SITENUM
 S SITEIEN=$P($G(^MAG(2006.1,MAGPLC,0)),U,1)    ; Get Station IEN in INSTITUTION file (#4)
 Q:SITEIEN="" ""  ; if SITE IEN is not defined return blank
 S SITENUM=$P($$NS^XUAF4(SITEIEN),U,2)      ; IA #2171  Get Station Number
 Q SITENUM
