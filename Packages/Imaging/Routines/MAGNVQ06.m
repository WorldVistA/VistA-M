MAGNVQ06 ;WOIFO/NST - List images for Reports ; 26 Dec 2017 3:59 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;*****  List Images for Rad Exams or TIU Notes by CPRS context
 ;        
 ; Input Parameters
 ; ================
 ; 
 ; DATA - Array holds Windows message received from CPRS in format
 ;         e.g. 'RPT^CPRS^29027^RA^79029185.9998-1~2'
 ;                or
 ;               RPT^CPRS^4658^TIU^2243408^^^^^^^^1~2
 ; [IMGLESS]  flag to speed up queries: if=1 (true), just get study-level data
 ;           
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY(0) = 0 ^Error message^
 ; if success MAGRY(0) = 1
 ;            MAGRY(1..n) = CONTEXTID | 0 or 1 | images in format defined in
 ;                        RPC [MAGG CPRS RAD EXAM] or [MAG3 CPRS TIU NOTE]
 ;
IMAGEL(MAGRY,DATA,IMGLESS) ;called by RPC [MAGN CPRS IMAGE LIST]
 N MAGNCXT,MAGNI,MAGNCNT,MAGNX,REFIEN,REFTYPE
 N MAGZRY,MAGRYNEW
 N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGGTERR"
 S IMGLESS=$S($D(IMGLESS):+IMGLESS,1:1)  ; Defualt is IMAGELESS
 S MAGRY=$NA(^TMP("MAGNVQ06",$J))
 K @MAGRY
 S @MAGRY@(0)=0
 S MAGNCNT=0
 S MAGNI=""
 F  S MAGNI=$O(DATA(MAGNI)) Q:MAGNI=""  D
 . S MAGNCXT=$P(DATA(MAGNI),"~")  ; CPRS contextID
 . S MAGNX=$P(MAGNCXT,"^",4)
 . I (MAGNX'="RA")&(MAGNX'="TIU") D  Q
 . . S MAGNCNT=MAGNCNT+1
 . . S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|0|"_"Invalid ContextId Type"
 . . Q
 . S REFTYPE=$S(MAGNX="RA":"RAD",MAGNX="TIU":"TIU",1:"")
 . I REFTYPE="RAD" D
 . . D IMAGEC(.MAGZRY,MAGNCXT,IMGLESS,.REFIEN)          ; Get image list for a single contextID
 . . Q
 . I REFTYPE="TIU" D
 . . S REFIEN=$P(MAGNCXT,"^",5)
 . . D IMAGETIU(.MAGZRY,MAGNCXT,IMGLESS)
 . . Q
 . K @MAGZRY@(1)  ; delete counter node
 . D GSTUDY^MAGNVQ01(MAGZRY,REFTYPE,REFIEN,MAGNCXT,IMGLESS)  ; Get imagage from new image data structure (P34) 
 . D APPEND(MAGRY,.MAGNCNT,MAGNCXT,MAGZRY,REFTYPE,REFIEN)  ; Append individual contextID image list to final list
 . Q
 S @MAGRY@(0)=1
 Q
 ;
IMAGETIU(MAGZRY,DATA,IMGLESS) ; Get 2005 Images by TIU Note
 N I,OUT,GROUPS,IMGIEN,MAGOUT1,DFN,MAGNTIU
 ;
 K MAGZRY
 S DFN=+$P(DATA,U,3)
 S MAGNTIU=$P(DATA,U,5)
 D IMAGES^MAGGNTI(.MAGOUT1,MAGNTIU)
 ;
 S I=0
 F  S I=$O(MAGOUT1(I)) Q:'I  D
 . S IMGIEN=$P(MAGOUT1(I),"^",25)  ; IEN of the group
 . S:'IMGIEN IMGIEN=$P(MAGOUT1(I),"^",2)  ; Ien of the image
 . S GROUPS(I)=IMGIEN
 . Q
 D STUDY2^MAGDQR21(.OUT,.GROUPS,DFN,IMGLESS)  ; MAG DOD GET STUDIES IEN
 ;
 S MAGZRY=OUT
 S @MAGZRY@(0)=1
 ;
 Q
 ;
IMAGEC(MAGZRY,DATA,IMGLESS,RARPT) ;A copy from MAGGTRAI
 ; Call to list Images for a Rad Exam that was selected from CPRS 
 ; and Imaging Window was notified via windows messaging
 ;   INPUT :  DATA is in format of Windows message received from CPRS
 ;    example   'RPT^CPRS^29027^RA^i79029185.9998-1'
 N DFN,ENT,INVDTTM,INVDT,INVTM
 S MAGZRY=$NA(^TMP("MAGGTRAI",$J))
 K @MAGZRY
 S DFN=+$P(DATA,U,3)
 S ENT=+$P($P(DATA,U,5),"-",2)
 S INVDTTM=$P($P(DATA,U,5),"-",1)
 S INVDT=$P(INVDTTM,".",1)
 S INVTM=$P(INVDTTM,".",2)
 F  Q:($L(INVDT)<8)  S INVDT=$E(INVDT,2,$L(INVDT))
 S INVDTTM=INVDT_"."_INVTM
 S RARPT=0
 I '$D(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0)) S @MAGZRY@(0)="0^INVALID Data : Attempt to access Exam failed." Q
 S RARPT=$P(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0),U,17)
 I 'RARPT S @MAGZRY@(0)="1^No Report for selected Exam" Q
 ; MAGQI 8/22/01
 I $P($G(^RARPT(RARPT,0)),U,2)'=DFN S @MAGZRY@(0)="-2^Patient Mismatch. Radiology File" Q
 D GETSTUDY(.MAGZRY,RARPT,IMGLESS)  ; Pass input parameters
 Q
 ;
GETSTUDY(MAGZRY,RARPT,IMGLESS) ; Private call. From other points in this routine, when RARPT is defined
 ; RARPT -- Radiology report IEN
 ; and returns a list in MAGZRY(1..n). 
 ; We'll make a tmp list of just the image IEN's
 ;  splitting groups into individual image entries.
 ; If more than 1 Image group points to this report, we
 ;  will prefix the Image Description with (G1), (G2) etc
 ; We call GROUP^MAGGTIG to get the images for the group, this call
 ;  sorts the images in Dicom Series, Dicom Image number order.
 ;
 N GROUPS,OUT,REQDFN
 ;
 N CT,OI,IGCT,MAGIEN1,MAGQI,MAGX
 S IGCT=+$P($G(^RARPT(RARPT,2005,0)),U,4)
 ; Quit if no images for RARPT
 I IGCT=0 S @MAGZRY@(0)="0^0 Images for Radiology Report." Q 
 ;
 ; Check all Image entries in RARPT 2005 NODE. for Patient match Pointer match, from both 
 ;   RARPT end, and Imaging end.
 S MAGQI=1
 S OI=0,CT=1 F  S OI=$O(^RARPT(RARPT,2005,OI)) Q:'OI  D  Q:(MAGQI<1)
 . S MAGIEN1=$P(^RARPT(RARPT,2005,OI,0),U)
 . ; Assure magdfn = rarpt dfn
 . I $P($G(^RARPT(RARPT,0)),U,2)'=$P($G(^MAG(2005,MAGIEN1,0)),U,7) S MAGQI="-2^Patient Mismatch. Radiology Report" Q
 . ; Assure magien1 is pointing to this rarpt
 . I $P($G(^MAG(2005,MAGIEN1,2)),U,7)'=RARPT S MAGQI="-2^Pointer Mismatch. Radiology Report" Q
 . ; Now run the Imaging integrity check
 . D CHK^MAGGSQI(.MAGX,MAGIEN1) I 'MAGX(0) S MAGQI="-2^"_$P(MAGX(0),U,2,99) Q
 ;
 I MAGQI<1 S @MAGZRY@(0)=MAGQI Q
 S CT=0
 ;
 S OI=0,CT=1 F  S OI=$O(^RARPT(RARPT,2005,OI)) Q:'OI  D
 . S MAGIEN1=$P(^RARPT(RARPT,2005,OI,0),U) S GROUPS(OI)=MAGIEN1
 . Q
 ;
 S REQDFN=$P($G(^RARPT(RARPT,0)),U,2)
 D STUDY2^MAGDQR21(.OUT,.GROUPS,REQDFN,IMGLESS)  ; MAG DOD GET STUDIES IEN
 ;
 S MAGZRY=OUT
 S @MAGZRY@(0)=1
 ;
 Q
 ;
APPEND(MAGOUT,MAGNCNT,MAGNCXT,MAGIN,REFTYPE,REFIEN)  ;
 ; Append individual contextID image list to final list
 ; and add more data 
 ; MAGOUT  - destination image list array 
 ; .MAGNCNT -- Start position in the array
 ; MAGNCXT -- context ID
 ; MAGIN  -- Image list to be appended - reference to a global
 ;
 N I,IMGIEN,MAGNCNTN,MAGSTUDY,OLDSTUDY
 S @MAGIN@(0)=$G(@MAGIN@(0))
 I '@MAGIN@(0) D  Q
 . S MAGNCNT=MAGNCNT+1
 . S @MAGOUT@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|0|"_$P(@MAGIN@(0),"^",2)
 . Q
 ;
 S MAGNCNTN=MAGNCNT
 S MAGNCNT=MAGNCNT+1
 ;
 S OLDSTUDY=0
 S I=0
 F  S I=$O(@MAGIN@(I)) Q:'I  D
 . S MAGNCNT=MAGNCNT+1
 . S @MAGOUT@(MAGNCNT)=@MAGIN@(I)
 . I $P(@MAGIN@(I),"|")="NEXT_STUDY" S OLDSTUDY=$P(@MAGIN@(I),"|",3)=""
 . I OLDSTUDY,$P(@MAGIN@(I),"|")="STUDY_IEN" D   ; Add STUDY_INFO. Better place will be MAGDQR21
 . . S MAGNCNT=MAGNCNT+1
 . . S IMGIEN=$P(@MAGIN@(I),"|",2)  ; IEN of the group
 . . S @MAGOUT@(MAGNCNT)="STUDY_INFO|"_$$STDINFO^MAGNU003(IMGIEN,REFTYPE,REFIEN,MAGNCXT)
 . . S MAGSTUDY=@MAGIN@(I)
 . . Q
 . I OLDSTUDY,IMGLESS,($P(@MAGIN@(I),"|")="STUDY_PAT") D INSFIMG^MAGNU003(MAGSTUDY,.MAGNCNT,MAGOUT)  ; Append First Image Info
 . Q
 S @MAGOUT@(MAGNCNTN+1)="NEXT_CONTEXTID|"_MAGNCXT_"|1|"_(MAGNCNT-MAGNCNTN)  ; @MAGIN@(1) is a result lines count
 Q
