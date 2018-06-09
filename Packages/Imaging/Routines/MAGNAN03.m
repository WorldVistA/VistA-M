MAGNAN03 ;WOIFO/NST - Get image annotations ; 21 Dec 2017 3:59 PM
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
 ;*****  Get image annotations by CPRS context or Image IEN
 ;       
 ; RPC: MAGN ANNOT GET IMAGE ANNOT
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; DATA - ContextID in format
 ;         e.g. 'RPT^CPRS^29027^RA^79029185.9998-1'
 ;                or
 ;               RPT^CPRS^4658^TIU^2243408^^^^^^^^1
 ;                or
 ;                  ^    ^    ^MAG^10454
 ;           
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY(0) = 0 ^Error message^
 ; if success MAGRY(0) = 1
 ;            MAGRY(1..n) = NEXT_CONTEXTID | CONTEXTID | 0 or 1 |
 ;                          NEXT_IMAGE | IMAGE IEN  
 ;                          images in format defined in RPC [MAGJ STUDY_DATA] or 
 ;                          [MAG ANNOT GET IMAGE DETAIL], [MAG ANNOT GET IMAGE]
 ;
IMAGEL(MAGRY,DATA) ;RPC [MAGN ANNOT GET IMAGE ANNOT]
 N MAGNCNT,MAGNX,RARPT
 N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGGTERR"
 S MAGRY=$NA(^TMP("MAGNTRAI",$J))
 K @MAGRY
 S @MAGRY@(0)=0
 S MAGNCNT=0
 S MAGNX=$P(DATA,"^",4)
 I MAGNX="RA" D  Q
 . D GRAANNCX(MAGRY,MAGNCNT,DATA)  ; get RAD annotations
 . Q
 ;
 I MAGNX="TIU" D  Q
 . D GTUIANN(MAGRY,MAGNCNT,DATA)  ; Get TIU annotations
 . Q
 ;
 I MAGNX="MAG" D  Q
 . D GMAGANN(MAGRY,MAGNCNT,DATA)  ; Get TIU annotations
 . Q
 ;
 S MAGNCNT=MAGNCNT+1
 S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_DATA_"|0|"_"Invalid ContextId Type"
 S @MAGRY@(0)=1
 Q
 ;
GRAANNCX(MAGRY,MAGNCNT,MAGNCXT)  ; Get RAD annotations by CPRS Context ID
 N MAGX,MAGNRPT,DATA
 ;
 S MAGNRPT=$$GRARPT(MAGNCXT) ; Get RA Report IEN by CPRS Context
 S MAGNCNT=MAGNCNT+1
 S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|"_MAGNRPT_"|RAD"
 I MAGNRPT'>0 Q
 ;
 ; e.g. MAGNCXT=RPT^CPRS^29027^RA^79029185.9998-1
 ; See MAGJEX3
 ; MAGX--TXID ^ DFN ^ DTI ^ CNI ^ RARPT ^ MAGIEN ^ PSDETAIL
 S $P(MAGX,"^",1)=3 ; TXID Key and Interp Images
 S $P(MAGX,"^",2)=$P(MAGNCXT,"^",3) ; DFN
 S $P(MAGX,"^",3)=$P($P(MAGNCXT,"^",5),"-",1)
 S $P(MAGX,"^",4)=$P($P(MAGNCXT,"^",5),"-",2)
 S $P(MAGX,"^",5)=MAGNRPT ; Report IEN
 S $P(MAGX,"^",7)=1 ; PSDETAIL
 ;
 D GRAANN(MAGRY,.MAGNCNT,MAGNCXT,MAGX)
 ;
 ; Get Clinical Annotations
 D GIMGRARP(.DATA,MAGNRPT)
 D GIENANN(MAGRY,.MAGNCNT,MAGNCXT,.DATA)
 Q
 ;
GRAANNRP(MAGRY,MAGNCNT,MAGNCXT,MAGNRPT)  ; Get RAD annotations by RA Report
 N MAGX
 ;
 S MAGNCNT=MAGNCNT+1
 S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|"_MAGNRPT_"|RAD"
 I MAGNRPT'>0 Q
 ;
 ; e.g. MAGNCXT=^^^MAG^10454
 ; See MAGJEX3
 ; MAGX--TXID ^ DFN ^ DTI ^ CNI ^ RARPT ^ MAGIEN ^ PSDETAIL
 S $P(MAGX,"^",1)=3 ; TXID Key and Interp Images
 S $P(MAGX,"^",2)="" ; DFN
 S $P(MAGX,"^",3)=""
 S $P(MAGX,"^",4)=""
 S $P(MAGX,"^",5)=MAGNRPT ; Report IEN
 S $P(MAGX,"^",7)=1 ; PSDETAIL
 ;
 D GRAANN(MAGRY,.MAGNCNT,MAGNCXT,MAGX)
 Q
 ;
GRAANN(MAGRY,MAGNCNT,MAGNCXT,MAGX) ; Get Radiology study annotations
 N J,MAGOUT
 ; 
 D RPCIN^MAGJEX3(.MAGOUT,MAGX)
 S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|"_@MAGOUT@(0)_"|RAD"
 S J=0
 F  S J=$O(@MAGOUT@(J)) Q:'J  D
 . S MAGNCNT=MAGNCNT+1
 . S @MAGRY@(MAGNCNT)=@MAGOUT@(J)
 . Q 
 K @MAGOUT
 S @MAGRY@(0)=1
 Q
 ;
GTUIANN(MAGRY,MAGNCNT,MAGNCXT) ;Get TIU annotations 
 N DATA,MAGNTIU
 ;
 S MAGNTIU=$P(MAGNCXT,"^",5)
 D IMAGES^MAGGNTI(.DATA,MAGNTIU) ;  Get all images for TIU
 ;
 D GIENANN(MAGRY,.MAGNCNT,MAGNCXT,.DATA) ;Get annotations for image IEN
 ;
 Q
 ;
GMAGANN(MAGRY,MAGNCNT,MAGNCXT) ; Get study annotations by image ien
 N DATA,MAGIEN,MAGROOT,MAGD0
 ;
 S MAGIEN=$P(MAGNCXT,"^",5)
 S MAGROOT=$$GET1^DIQ(2005,MAGIEN,16)
 S MAGD0=$$GET1^DIQ(2005,MAGIEN,17)
 ; 
 I MAGROOT="TIU" D  Q
 . D IMAGES^MAGGNTI(.DATA,MAGD0) ;  Get all images for TIU
 . D GIENANN(MAGRY,.MAGNCNT,MAGNCXT,.DATA) ;Get annotations for image IEN
 . Q
 ;
 I MAGROOT="RADIOLOGY" D  Q
 . D GRAANNRP(MAGRY,MAGNCNT,MAGNCXT,MAGD0)
 . ; Try to get images in case of Capture (Clinical) annotation
 . D IMAGES(.DATA,MAGIEN)  ; Get Images by Group image IEN
 . D GIENANN(MAGRY,.MAGNCNT,MAGNCXT,.DATA) ;Get annotations for image IEN
 . Q
 ;
 I MAGROOT="" D  ; No report
 . D IMAGES(.DATA,MAGIEN)  ; Get Images by Group image IEN
 . D GIENANN(MAGRY,.MAGNCNT,MAGNCXT,.DATA) ;Get annotations for image IEN
 . Q
 Q
 ;
GRARPT(DATA) ; Get RA Report IEN by CPRS Context
 N DFN,ENT,INVDTTM,INVDT,INVTM,RARPT
 S DFN=+$P(DATA,U,3)
 S ENT=+$P($P(DATA,U,5),"-",2)
 S INVDTTM=$P($P(DATA,U,5),"-",1)
 S INVDT=$P(INVDTTM,".",1)
 S INVTM=$P(INVDTTM,".",2)
 F  Q:($L(INVDT)<8)  S INVDT=$E(INVDT,2,$L(INVDT))
 S INVDTTM=INVDT_"."_INVTM
 S RARPT=0
 I '$D(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0)) Q "0^INVALID Data : Attempt to access Exam failed."
 S RARPT=$P(^RADPT(DFN,"DT",INVDTTM,"P",ENT,0),U,17)
 I 'RARPT Q "0^No Report for selected Exam"
 I $P($G(^RARPT(RARPT,0)),U,2)'=DFN Q "-2^Patient Mismatch. Radiology File"
 Q RARPT
 ;
GIENANN(MAGRY,MAGNCNT,MAGNCXT,DATA) ;Get annotations for image IEN
 ; MAGRY = Output array
 ; MAGNCNT  = initial output counter
 ; MAGNCXT  = Context ID
 ; DATA(0)  = Result output
 ; DATA(1..n) = Image IEN
 ; 
 N J,I,MAGIEN,MAGNTIU,MAGOUT
 ;
 S MAGNCNT=MAGNCNT+1
 S @MAGRY@(MAGNCNT)="NEXT_CONTEXTID|"_MAGNCXT_"|"_DATA(0)_"|CLN"
 I 'DATA(0) Q   ; Error quit
 ;
 S I=0
 F  S I=$O(DATA(I)) Q:'I  D
 . S MAGIEN=$P(DATA(I),"^",2)
 . K MAGOUT
 . ;P122 handles only one type of annotation (Clinic or VistARAD), but not on both 
 . I '$D(^MAG(2005.002,MAGIEN,0)) Q  ; VistA Rad annotations are present. Quit. We need only Clinic
 . D GETD^MAGSANNO(.MAGOUT,MAGIEN)  ; Get annotation details by image IEN
 . S MAGNCNT=MAGNCNT+1
 . S @MAGRY@(MAGNCNT)="NEXT_IMAGE|"_MAGIEN_"|"_MAGOUT(0)
 . I 'MAGOUT(0) Q   ; Error, get next one
 . S J=0
 . F  S J=$O(MAGOUT(J)) Q:'J  D
 . . S MAGNCNT=MAGNCNT+1
 . . S @MAGRY@(MAGNCNT)=MAGOUT(J)
 . . Q
 . Q
 S @MAGRY@(0)=1
 Q
 ;
IMAGES(DATA,MAGIEN) ; Get all Images for a Group Image IEN
 N GROUP
 S GROUP=$$ISGRP^MAGGI11(MAGIEN)
 S DATA(0)=1 ; Set result to okay
 I GROUP D  Q
 . N NO,CH
 . S NO=0
 . F  S NO=$O(^MAG(2005,MAGIEN,1,NO)) Q:'NO  D 
 . . S CH=+$G(^MAG(2005,MAGIEN,1,NO,0))
 . . Q:'CH
 . . S $P(DATA(NO),"^",2)=CH
 . Q
 S $P(DATA(1),"^",2)=MAGIEN
 Q
 ;
GIMGRARP(DATA,RARPT) ; Get list of images by radiology report
 ; RARPT -- Radiology report IEN
 ; and returns a list in DATA(1..n). 
 ;
 N GROUPS,OUT,REQDFN
 ;
 N CT,OI,IGCT,MAGIEN1,MAGQI,MAGX
 K MAGZRY
 S IGCT=+$P($G(^RARPT(RARPT,2005,0)),U,4)
 ; Quit if no images for RARPT
 I IGCT=0 Q 
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
 I MAGQI<1 S DATA(0)=MAGQI Q  ; Integrity error
 S CT=0
 ;
 S OI=0,CT=1 F  S OI=$O(^RARPT(RARPT,2005,OI)) Q:'OI  D
 . S MAGIEN1=$P(^RARPT(RARPT,2005,OI,0),U) S $P(DATA(OI),"^",2)=MAGIEN1
 . Q
 S DATA(0)=1 ; okay result
 Q
