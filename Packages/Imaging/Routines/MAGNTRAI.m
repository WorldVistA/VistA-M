MAGNTRAI ;WOIFO/NST - List images for Reports ; 16 Jan 2018 3:59 PM
 ;;3.0;IMAGING;**170,185**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ; RPC: MAGN CPRS IMAGE LIST
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; DATA - Array holds Windows message received from CPRS in format
 ;         e.g. 'RPT^CPRS^29027^RA^79029185.9998-1'
 ;                or
 ;               RPT^CPRS^4658^TIU^2243408^^^^^^^^1
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
IMAGEL(MAGRY,DATA,IMGLESS) ;RPC [MAGN CPRS IMAGE LIST]
 S IMGLESS=$S($D(IMGLESS):+IMGLESS,1:1)  ; Defualt is IMAGELESS
 ;
 N MAGVER,MAGNII
 S MAGVER=""
 S MAGNII=""
 ; Check version of the RPC we need to call
 F  S MAGNII=$O(DATA(MAGNII)) Q:(MAGVER'="")!(MAGNII="")  D
 . S MAGVER=$P(DATA(MAGNII),"~",2)
 . Q
 I MAGVER=2 D IMAGEL^MAGNVQ06(.MAGRY,.DATA,IMGLESS) Q 
 ;
 N MAGNCXT,MAGNI,MAGNCNT,MAGNX,MAGNTIU,RARPT
 N MAGZRY
 N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGGTERR"
 S IMGLESS=$S($D(IMGLESS):+IMGLESS,1:1)  ; Defualt is IMAGELESS
 S MAGRY=$NA(^TMP("MAGNTRAI",$J))
 K @MAGRY
 S @MAGRY@(0)=0
 S MAGNCNT=0
 S MAGNI=""
 F  S MAGNI=$O(DATA(MAGNI)) Q:MAGNI=""  D
 . S MAGNCXT=DATA(MAGNI)  ; CPRS contextID
 . S MAGNX=$P(MAGNCXT,"^",4)
 . I MAGNX="RA" D  Q
 . . D IMAGEC(.MAGZRY,MAGNCXT,IMGLESS,.RARPT)  ; get image list for a single contextID
 . . D APPENDRA(MAGRY,.MAGNCNT,MAGNCXT,MAGZRY,RARPT)  ; Append individual contextID image list to final list
 . . Q
 . I MAGNX="TIU" D  Q
 . . S MAGNTIU=$P(MAGNCXT,"^",5)
 . . K MAGZRY
 . . D IMAGES^MAGGNTI(.MAGZRY,MAGNTIU)
 . . D APPEND2(MAGRY,.MAGNCNT,MAGNCXT,.MAGZRY,MAGNTIU)  ; Append individual contextID image list to final list
 . . Q
 . S MAGNCNT=MAGNCNT+1
 . S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|0|"_"Invalid ContextId Type"
 . Q
 S @MAGRY@(0)=1
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
 I 'RARPT S @MAGZRY@(0)="0^No Report for selected Exam" Q
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
APPENDRA(OUT,MAGNCNT,MAGNCXT,MAGZRY,RARPT)  ;
 ; Append individual contextID image list to final list
 ; and add more data 
 ; OUT  - destination image list array 
 ; .MAGNCNT -- Start position in the array
 ; MAGNCXT -- context ID
 ; MAGZRY  -- Image list to be appended - reference to a global
 ;
 N I,IMGIEN,MAGNCNTN,MAGSTUDY
 S @MAGZRY@(0)=$G(@MAGZRY@(0))
 I '@MAGZRY@(0) D  Q
 . S MAGNCNT=MAGNCNT+1
 . S @OUT@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|0|"_$P(@MAGZRY@(0),"^",2)
 . Q
 ;
 S MAGNCNTN=MAGNCNT
 S MAGNCNT=MAGNCNT+1
 ;
 S I=1  ; start from line number 2. Line number 1 is a records count
 F  S I=$O(@MAGZRY@(I)) Q:'I  D
 . S MAGNCNT=MAGNCNT+1
 . S @OUT@(MAGNCNT)=@MAGZRY@(I)
 . I $P(@MAGZRY@(I),"|")="STUDY_IEN" D   ; Add STUDY_INFO. Better place will be MAGDQR21
 . . S MAGNCNT=MAGNCNT+1
 . . S IMGIEN=$P(@MAGZRY@(I),"|",2)  ; IEN of the group
 . . S @OUT@(MAGNCNT)="STUDY_INFO|"_$$STDINFO(IMGIEN)_"|RA-"_RARPT
 . . S MAGSTUDY=@MAGZRY@(I)
 . . Q
 . I IMGLESS,($P(@MAGZRY@(I),"|")="STUDY_PAT") D INSFIMG(MAGSTUDY,.MAGNCNT,OUT)  ; Append First Image Info
 . Q
 S @OUT@(MAGNCNTN+1)="NEXT_CONTEXTID|"_MAGNCXT_"|1|"_(MAGNCNT-MAGNCNTN)  ; @MAGZRY@(1) is a result lines count
 Q
 ; 
INSFIMG(DATA,MAGNCNT,OUT) ; Append First Image Info I 
 N IMGGRP,IMGIEN
 S IMGGRP=$P(DATA,"|",2)
 S IMGIEN=$P(DATA,"|",4)
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="NEXT_SERIES"
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="SERIES_IEN|"_IMGGRP
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="SERIES_NUMBER|1"
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="NEXT_IMAGE"
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="IMAGE_IEN|"_IMGIEN
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="GROUP_IEN|"_IMGGRP
 S MAGNCNT=MAGNCNT+1,@OUT@(MAGNCNT)="IMAGE_INFO|"_"^"_$$INFO^MAGGAII(IMGIEN,"E")
 Q
 ;
APPEND2(OUT,MAGNCNT,MAGNCXT,MAGZRY,MAGNTIU)  ; 
 ; Append individual contextID image list to final list
 ; and add more data
 ; OUT  - destination image list array 
 ; .MAGNCNT -- Start position in the array
 ; MAGNCXT -- context ID
 ; .MAGZRY  -- Image list to be appended
 ;
 N I,IMGIEN,STDINFO
 S MAGZRY(0)=$G(MAGZRY(0))
 I 'MAGZRY(0) D  Q
 . S MAGNCNT=MAGNCNT+1
 . S @OUT@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|0|"_$P(MAGZRY(0),"^",2)
 . Q
 ;
 S MAGNCNT=MAGNCNT+1
 S @OUT@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|1|"_MAGZRY(0)
 S I=0
 F  S I=$O(MAGZRY(I)) Q:'I  D
 . S IMGIEN=$P(MAGZRY(I),"^",25)  ; IEN of the group
 . S:'IMGIEN IMGIEN=$P(MAGZRY(I),"^",2)  ; Ien of the image
 . S MAGNCNT=MAGNCNT+1
 . S STDINFO=$$STDINFO(IMGIEN)
 . S $P(STDINFO,"^",6)=$P(MAGZRY(I),"^",15)  ; Group image count per VIX request
 . S @OUT@(MAGNCNT)=STDINFO_"|"_$P(MAGZRY(I),"^",2,9999)_"|TIU-"_MAGNTIU
 . Q
 Q
 ;
STDINFO(IMGIEN) ; Get study info
 ; IMGIEN -- Image IEN
 ;
 ; Return Study( Image ) info. The code is a copy from MAGSIXG3 
 N X0,X2,X40
 N PKG,TYPE,EVT,SPEC,ORIG,ORIG,CAPTAPP,CLASS
 N IMGNODE,FLTX
 ;
 S IMGNODE=$$NODE^MAGGI11(IMGIEN)  Q:IMGNODE="" 0
 ;
 S X0=$G(@IMGNODE@(0))
 S X2=$G(@IMGNODE@(2))
 S X40=$G(@IMGNODE@(40))
 ;
 S PKG=$P(X40,U)          ; PACKAGE INDEX (40)
 S TYPE=$P(X40,U,3)       ; TYPE INDEX (42)
 S EVT=$P(X40,U,4)        ; PROC/EVENT INDEX (43)
 S SPEC=$P(X40,U,5)       ; SPEC/SUBSPEC INDEX (44)
 S ORIG=$P(X40,U,6)       ; ORIGIN INDEX (45)
 S:ORIG="" ORIG="V"       ; Show VA by default
 S CAPTAPP=$P(X2,U,12)    ; CAPTURE APPLICATION (8.1)
 ;
 S CLASS=$S(TYPE:$P($G(^MAG(2005.83,+TYPE,0)),U,2),1:"")
 ;
 S FLTX=""
 S $P(FLTX,U,3)=$$RPTITLE^MAGSIXG3($P(X2,U,6),$P(X2,U,7))     ; Report title
 S $P(FLTX,U,4)=$$DTE^MAGSIXG3($P(X2,U,5))                    ; Procedure date
 S $P(FLTX,U,5)=$P(X0,U,8)                           ; Procedure
 S $P(FLTX,U,7)=$P(X2,U,4)                           ; Short descr.
 S $P(FLTX,U,8)=PKG                                  ; Package
 S $P(FLTX,U,9)=$P($G(^MAG(2005.82,+CLASS,0)),U)     ; Class
 S $P(FLTX,U,10)=$P($G(^MAG(2005.83,+TYPE,0)),U)     ; Type
 S $P(FLTX,U,11)=$P($G(^MAG(2005.84,+SPEC,0)),U)     ; (Sub)Specialty
 S $P(FLTX,U,12)=$P($G(^MAG(2005.85,+EVT,0)),U)      ; Proc/Event
 S $P(FLTX,U,13)=$$EXTERNAL^DILFD(2005,45,,ORIG)     ; Origin
 S $P(FLTX,U,14)=$$DTE^MAGSIXG3($P(X2,U))            ; Capture date
 S $P(FLTX,U,15)=$$GET1^DIQ(200,+$P(X2,U,2)_",",.01) ; Captured by
 S $P(FLTX,U,16)=IMGIEN                              ; Image IEN
 Q FLTX
