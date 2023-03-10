MAGSIXG3 ;WOIFO/SG/NST/DAC - LIST OF IMAGES RPCS (CALLBACK) ; Aug 20, 2020@06:55:25
 ;;3.0;IMAGING;**93,117,150,138,167,221,258**;Mar 19, 2002;Build 21
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
 ;
 ; This routine uses the following ICRs:
 ;
 ; #3268         Read file #8925 (controlled)
 ; #10060        Read file #200 (supported)
 ; #2321         Read file #8925.1 (controlled)
 ; #2937         Read file #8925 (controlled)
 ;
 ; LOCAL VARIABLE ------ DESCRIPTION
 ;
 ; MAGDATA               See the ^MAGSIXG4.
 ;
 ; TEMPORARY GLOBAL ---- DESCRIPTION
 ;
 ; ^TMP("MAGSIXG3",$J)   See the ^MAGSIXG4.
 ;
 Q
 ;
 ;+++++ APPENDS THE IMAGE ENTRY TO THE RPC RESULT ARRAY
 ;
 ; IMGIEN        IEN of the image record in file #2005 or #2005.1
 ;
 ; DATA          First half ("|"-piece) of the result item
 ;
 ; GRPCNTS       Group counts (result of the $$GRPCT^MAGGI14)
 ;
 ; FLAGS         Control flags for the $$INFO^MAGGAII
 ;
 ; Input Variables
 ; ===============
 ;   MAGDATA
 ;
 ; Output Variables
 ; ================
 ;   MAGDATA, MAGOUT
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;
APPEND(IMGIEN,DATA,GRPCNTS,FLAGS) ;
 N IMGINFO,X
 ;
 ;--- Get the internal image data
 S IMGINFO=$$INFO^MAGGAII(IMGIEN,FLAGS,GRPCNTS)
 Q:IMGINFO<0 IMGINFO
 S $P(DATA,U,2)=$P(IMGINFO,U,16)  ; Site Code
 S $P(DATA,U,6)=$P(IMGINFO,U,14)  ; Number of images in the group
 S $P(DATA,U,16)=$P(IMGINFO,U)    ; Image ID (IEN)
 ;
 ;--- Append the image data to the result array
 S MAGDATA("RESCNT")=$G(MAGDATA("RESCNT"))+1
 S $P(DATA,U)=MAGDATA("RESCNT")
 S @MAGDATA@(MAGDATA("RESCNT")+1)=DATA_U_"|"_IMGINFO
 Q:MAGDATA("RESCNT")<76 0  Q:MAGDATA["^" 0
 ;
 ;--- Image count is getting big, switch from
 ;--- a local array to a global node
 S MAGDATA=$NA(^TMP("MAGSIXG1",$J))
 K @MAGDATA  M @MAGDATA=MAGOUT
 S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1)
 K MAGOUT  S MAGOUT=MAGDATA
 Q 0
 ;
 ;+++++ PERFORMS SPECIAL CONVERSION OF THE DATE/TIME
DTE(DTI) ;
 N X  S X=$$FMTE^XLFDT(DTI,"5Z")
 Q $P(X,"@")_" "_$S($P(X,"@",2)'="":$P(X,"@",2),1:"00:01")
 ;
 ;+++++ CALLBACK FUNCTION FOR IMAGE QUERY
 ;
 ; IMGIEN        IEN of the image record (file #2005 or #2005.1)
 ;
 ; FLAGS         Parameters passed into the image query API
 ; .MAGDATA      ($$QUERY^MAGGI13). See the GETIMGS^MAGSIXG1
 ;               for details.
 ;
 ; Input Variables
 ; ===============
 ;   MAGJOB, MAGOUT
 ;
 ; Output Variables
 ; ================
 ;   MAGJOB, MAGOUT, ^TMP("MAGSIXG3",$J,...)
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Continue
 ;           >0  Terminate the query
 ;
QRYCBK(IMGIEN,FLAGS,MAGDATA) ;
 N FLTX,IIFLAGS,GRPCNTS,PTIEN,RC
 ;
 S RC=$$FILTER(.FLTX,.GRPCNTS,.PTIEN,IMGIEN,FLAGS,.MAGDATA) ; Apply filter 
 Q:'RC 0  ; Filter is not matched
 ;
 Q:RC=2 1  ; Terminate the query when maximum number of records is reached
 ;
 ;=== Flags for $$INFO^MAGGAII
 S IIFLAGS=$$TRFLAGS^MAGUTL05(FLAGS,"DE")
 ;
 ;=== Sparse subset query does not append image entries to the result 
 ;    array right away. It saves them to the temporary buffers in the
 ;    ^TMP("MAGSIXG3",$J) global node instead. After all images are
 ;    preselected, the $$SUBSET^MAGSIXG4 processes those buffers and
 ;=== appends required number of image entries to the result array.
 I MAGDATA("FLAGS")["S"  S RC=0  D  Q $S(RC<0:RC,1:0)
 . N I,TCNT,X
 . S (MAGDATA("TCNT"),TCNT)=$G(MAGDATA("TCNT"))+1
 . ;--- If the image is associated with the same patient as the
 . ;--- previous one, save it in the regular temporary buffer.
 . I PTIEN=$G(MAGDATA("PREVPT")) D  Q
 . . S I=$O(^TMP("MAGSIXG3",$J,"R",""),-1)+1
 . . S ^TMP("MAGSIXG3",$J,"R",I)=TCNT_"|"_IMGIEN_"|"_GRPCNTS
 . . S ^TMP("MAGSIXG3",$J,"R",I,0)=FLTX
 . . Q
 . ;--- If the image is associated with a different patient, remember
 . ;--- the new DFN and store the image into the "priority" buffer.
 . S MAGDATA("PREVPT")=PTIEN
 . S ^TMP("MAGSIXG3",$J,"P",TCNT)=TCNT_"|"_IMGIEN_"|"_GRPCNTS
 . S ^TMP("MAGSIXG3",$J,"P",TCNT,0)=FLTX
 . ;--- If the image that precedes the patient change is not in the
 . ;--- "priority" buffer yet, move it there from the regular buffer.
 . S X=TCNT-1  Q:$D(^TMP("MAGSIXG3",$J,"P",X))
 . S I=$O(^TMP("MAGSIXG3",$J,"R",""),-1)  Q:I=""
 . I $P(^TMP("MAGSIXG3",$J,"R",I),"|")'=X  D  Q
 . . S RC=$$ERROR^MAGUERR(-47)  ; This should never happen!
 . . Q
 . M ^TMP("MAGSIXG3",$J,"P",X)=^TMP("MAGSIXG3",$J,"R",I)
 . K ^TMP("MAGSIXG3",$J,"R",I)
 . Q
 ;
 ;=== Append the image item to the result array
 S RC=$$APPEND(IMGIEN,FLTX,GRPCNTS,IIFLAGS)  Q:RC<0 RC
 ;
 ;=== Success
 Q 0
 ;
 ;+++++ RETURNS THE NOTE TITLE
RPTITLE(FILE,IEN) ;
 N TITLE,TMP
 I FILE=8925,IEN>0  D  S TITLE=$P($G(^TIU(8925.1,TMP,0)),U)  ; IA #2321
 . S TMP=+$P($G(^TIU(8925,+IEN,0)),U)   ; IA #2937
 . Q
 Q $S($G(TITLE)'="":TITLE,1:"   ")
 ;
MODALITY(IMGIEN)  ; Get Image modality
 N G,M,P,MAGFILD,MAGFILG,X
 S MAGFILD=$$FILE^MAGGI11(IMGIEN)
 S X=$S(MAGFILD:$G(^MAG(MAGFILD,IMGIEN,0)),1:"")
 S G=+$P(X,"^",10) ;Group IEN
 S M=$P(X,"^",8)   ;Procedure
 S:$E(M,1,4)="RAD " M=$E(M,5,$L(M))
 Q:M="" ""
 S MAGFILG=$$FILE^MAGGI11(G)
 S G=$S(MAGFILG:$P($G(^MAG(MAGFILG,G,2)),"^",6),1:"") ;Parent Data File# for Group IEN
 S P=$S(MAGFILD:$P($G(^MAG(MAGFILD,IMGIEN,2)),"^",6),1:"") ;Parent Data File# for IEN
 I P'=74,G'=74 Q ""  ;quit if not RAD/NUC MED REPORTS file (#74)
 Q M
 ;
 ; Filter image based on filter data
FILTER(FLTX,GRPCNTS,PTIEN,IMGIEN,FLAGS,MAGDATA) ;
 N CAPTAPP,CLASS,EVT,GROUP,IMGNODE
 N ORIG,PKG,SENSIMG,SKIP,SPEC,STATUS,TYPE
 N CPTCODE,MODALITY
 N X,X0,X01,X100,X2,X40
 N MAGFOUND  ; temp loop flag
 S FLTX=""
 S IMGNODE=$$NODE^MAGGI11(IMGIEN)  Q:IMGNODE="" 0
 ;=== Terminate the query when maximum number of records is reached
 I MAGDATA("MAXNUM"),MAGDATA("RESCNT")'<MAGDATA("MAXNUM")  Q 2
 ;
 ;=== Skip, if a group member
 S X0=$G(@IMGNODE@(0))
 Q:$P(X0,U,10) 0         ; GROUP PARENT (14)
 ;
 ;=== Check who captured the image
 S X2=$G(@IMGNODE@(2)),X=+$G(MAGDATA("SAVEDBY"))
 I X  Q:$P(X2,U,2)'=X 0  ; IMAGE SAVE BY (8)
 ;
 ;=== Perform additional screening according to the image counts
 S GRPCNTS=$$GRPCT^MAGGI14(IMGIEN)
 S:GRPCNTS<0 GRPCNTS=""  ;??? Ignore errors
 S GROUP=$$ISGRP^MAGGI11(IMGIEN)
 S SKIP=0  D  Q:SKIP 0
 . ;--- Check if the image entry references "child" images of
 . ;    requested kind(s). Also, safeguard against a wrong object
 . ;--- type in the group header.
 . I $P(GRPCNTS,U,1)>0  S GROUP=1  Q:FLAGS["E"  ; Existing "children"
 . I $P(GRPCNTS,U,2)>0  S GROUP=1  Q:FLAGS["D"  ; Deleted "children"
 . ;--- Skip group headers that do not reference
 . ;--- any "child" images of requested kind(s)
 . I GROUP  S SKIP=1  Q
 . ;--- If existing images are not requested, then
 . ;--- skip existing standalone image entries
 . I FLAGS'["E",'$$ISDEL^MAGGI11(IMGIEN) S SKIP=1 Q
 . Q
 ;
 ;=== Load other data associated with the image
 S X40=$G(@IMGNODE@(40)),X100=$G(@IMGNODE@(100))
 S PTIEN=+$P(X0,U,7)      ; PATIENT (5)
 S PKG=$P(X40,U)          ; PACKAGE INDEX (40)
 S TYPE=$P(X40,U,3)       ; TYPE INDEX (42)
 S EVT=$P(X40,U,4)        ; PROC/EVENT INDEX (43)
 S SPEC=$P(X40,U,5)       ; SPEC/SUBSPEC INDEX (44)
 S ORIG=$P(X40,U,6)       ; ORIGIN INDEX (45)
 S:ORIG="" ORIG="V"       ; Show VA by default
 S SENSIMG=+$P(X100,U,7)  ; CONTROLLED IMAGE (112)
 S STATUS=$P(X100,U,8)    ; STATUS(113)
 S CAPTAPP=$P(X2,U,12)    ; CAPTURE APPLICATION (8.1)
 S CPTCODE=$$CPTCODE^MAGDQR21(IMGIEN)  ; CPT CODE
 S MODALITY=$$MODALITY(IMGIEN)  ; Get Modality
 ;
 ; 150 T2 - if Group and Deleted and only 1 child: get Status of child.
 I GROUP,$$ISDEL^MAGGI11(IMGIEN),$P(GRPCNTS,U,2)=1 D  ;
 . S X=$O(^MAG(2005.1,"AGP",IMGIEN,""))
 . I 'X Q
 . S X=$P($G(^MAG(2005.1,X,100)),"^",8)
 . I X S STATUS=X
 . Q
 ;=== Patch 150-  Status 13 is a Non Existant Image. Don't include in Image List.
 I STATUS=13 Q 0  ;P150
 ;=== Patch 59.  Treat Class as a computed field.
 ;=== Arrange with Mike to change DB.
 S CLASS=$S(TYPE:$P($G(^MAG(2005.83,+TYPE,0)),U,2),1:"")
 I $D(MAGDATA("PKG")),PKG'=""    Q:'$D(MAGDATA("PKG",PKG)) 0
 I $D(MAGDATA("ORIG")),ORIG'=""  Q:'$D(MAGDATA("ORIG",ORIG)) 0
 I $D(MAGDATA("CLS")),CLASS'=""  Q:'$D(MAGDATA("CLS",CLASS)) 0
 ; P258 DAC - Modified to exclude null types when doing a search with type parameters
 I $D(MAGDATA("TYPE")) Q:TYPE="" 0
 I $D(MAGDATA("TYPE")) Q:'$D(MAGDATA("TYPE",TYPE)) 0
 I $D(MAGDATA("CPTCODE")),CPTCODE="" Q 0
 I $D(MAGDATA("MODALITY")),MODALITY="" Q 0
 I $D(MAGDATA("CPTCODE")),CPTCODE'=""  Q:'$D(MAGDATA("CPTCODE",CPTCODE)) 0
 I $D(MAGDATA("MODALITY")),MODALITY'=""  Q:'$D(MAGDATA("MODALITY",MODALITY)) 0
 ;
 I '(FLAGS["G") D  Q:'MAGFOUND 0  ; doesn't meet the criteria. One strike and you have to quit
 . S MAGFOUND=1
 . I $D(MAGDATA("ISTAT")),'$D(MAGDATA("ISTAT",+STATUS)) S MAGFOUND=0 Q
 . Q
 ;
 I FLAGS["G" D  Q:'MAGFOUND 0  ; Quit. It doesn't meet the criteria
 . S MAGFOUND=0
 . I '$D(MAGDATA("ISTAT")) S MAGFOUND=1 Q  ;nothing to check. It means it is found
 . ; Check for single images first
 . I 'GROUP D  Q
 . . I $D(MAGDATA("ISTAT",+STATUS)) S MAGFOUND=1  ; need this image
 . . Q
 . ;-- check all children in the group
 . N CHI,CHIEN,CHNODE,CH100,CHSTATUS
 . S CHI=0
 . F  S CHI=$O(@IMGNODE@(1,CHI)) Q:CHI'>0  D  Q:MAGFOUND
 . . S CHIEN=+$G(@IMGNODE@(1,CHI,0))
 . . Q:CHIEN'>0
 . . S CHNODE=$$NODE^MAGGI11(CHIEN) Q:CHNODE=""
 . . S CH100=$G(@CHNODE@(100))
 . . S CHSTATUS=$P(CH100,U,8)    ; STATUS(113)
 . . I $D(MAGDATA("ISTAT",+CHSTATUS)) S MAGFOUND=1
 . . Q
 . Q
 ;
 ;=== Skip list entries with no event if event is in
 ;=== the selection criteria (MAG*3*8)
 I $D(MAGDATA("EVT"))   Q:EVT="" 0   Q:'$D(MAGDATA("EVT",EVT)) 0
 ;
 ;=== Skip list entries with no specialty if specialty is in
 ;=== the selection criteria (MAG*3*8)
 I $D(MAGDATA("SPEC"))  Q:SPEC="" 0  Q:'$D(MAGDATA("SPEC",SPEC)) 0
 ;
 ;=== Skip list entries with no capture application if
 ;=== application is in the selection criteria
 I $D(MAGDATA("CAPTAPP"))  Q:CAPTAPP="" 0  Q:'$D(MAGDATA("CAPTAPP",CAPTAPP)) 0
 ;
 ;=== Check the short description
 I $D(MAGDATA("GDESC"))  Q:$$UP^XLFSTR($P(X2,U,4))'[MAGDATA("GDESC") 0
 ;
 ;=== Build the result item
 S $P(FLTX,U,3)=$$RPTITLE($P(X2,U,6),$P(X2,U,7))     ; Report title
 S $P(FLTX,U,4)=$$DTE($P(X2,U,5))                    ; Procedure date
 S $P(FLTX,U,5)=$P(X0,U,8)                           ; Procedure
 S $P(FLTX,U,7)=$P(X2,U,4)                           ; Short descr.
 S $P(FLTX,U,8)=PKG                                  ; Package
 S $P(FLTX,U,9)=$P($G(^MAG(2005.82,+CLASS,0)),U)     ; Class
 S $P(FLTX,U,10)=$P($G(^MAG(2005.83,+TYPE,0)),U)     ; Type
 S $P(FLTX,U,11)=$P($G(^MAG(2005.84,+SPEC,0)),U)     ; (Sub)Specialty
 S $P(FLTX,U,12)=$P($G(^MAG(2005.85,+EVT,0)),U)      ; Proc/Event
 S $P(FLTX,U,13)=$$EXTERNAL^DILFD(2005,45,,ORIG)     ; Origin
 S $P(FLTX,U,14)=$$DTE($P(X2,U))                     ; Capture date
 S $P(FLTX,U,15)=$$GET1^DIQ(200,+$P(X2,U,2)_",",.01) ; Captured by
 Q 1
