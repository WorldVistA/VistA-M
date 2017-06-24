MAGGA03A ;WOIFO/SG - CALLBACK FOR IMAGE QUERIES ; 3/9/09 12:50pm
 ;;3.0;IMAGING;**93,151**;Mar 19, 2002;Build 21;Dec 19, 2016
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;+++++ CALLBACK FUNCTION FOR IMAGE QUERIES
 ;
 ; IMGIEN        IEN of the image record (file #2005 or #2005.1)
 ;
 ; FLAGS         Flags that control the execution
 ;
 ; .DATA         Reference to a local array passed via the MAG8DATA
 ;               parameter of the $$QUERY^MAGGI13 function.
 ; DATA(
 ;   "FLAGS")    Original control flags passed into the
 ;               $$IMGQUERY^MAGGA03 function.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Continue
 ;           >0  Terminate the query
 ;
 ; This function accumulates the data in the ^TMP($J,"MAGGA03A")
 ; global node:
 ;
 ; ^TMP($J,"MAGGA03A",
 ;
 ;   "S",StatusCode)     Image counts
 ;                         ^01: Number of image entries
 ;                         ^02: Number of images/pages
 ;
 ;   "U",UserIEN,
 ;     StatusCode)       Image counts
 ;                         ^01: Number of image entries
 ;                         ^02: Number of images/pages
 ;
QRYCBK(IMGIEN,FLAGS,DATA) ;
 N FD,FE,GROUP,GRPCNTS,IMGNODE,IMGNP,RC,SKIP,TMP
 ;=== Skip "child" (RC>0) and invalid (RC<0) image entries
 S RC=$$GRPIEN^MAGGI12(IMGIEN)  Q:RC 0
 ;
 ;=== Initialize variables
 S FD=(FLAGS["D"),FE=(FLAGS["E")
 S GROUP=$$ISGRP^MAGGI11(IMGIEN)
 ;
 ;=== Perform additional screening according to the image counts
 S TMP=$$TRFLAGS^MAGUTL05(DATA("FLAGS"),"SU")
 S GRPCNTS=$$GRPCT^MAGGI14(IMGIEN,"P"_TMP,.GRPCNTS)
 S SKIP=0  D  Q:SKIP 0
 . ;--- Check if the image entry references "child" images of
 . ;    requested kind(s). Also, safeguard against a wrong object
 . ;--- type in the group header.
 . I $P(GRPCNTS,U,1)>0  S GROUP=1  Q:FE  ; Existing "child" entries
 . I $P(GRPCNTS,U,2)>0  S GROUP=1  Q:FD  ; Deleted "child" entries
 . ;--- Skip group headers that do not reference
 . ;--- any "child" images of requested kind(s)
 . I GROUP  S SKIP=1  Q
 . ;--- If existing images are not requested, then
 . ;--- skip existing standalone image entries
 . I 'FE,'$$ISDEL^MAGGI11(IMGIEN)  S SKIP=1  Q
 . ;--- Get the number of pages from the standalone image entry
 . S IMGNODE=$$NODE^MAGGI11(IMGIEN)  Q:IMGNODE=""
 . ;P151 - Skip if this image was captured by Dicom Gateway.
 . S CAPP=$P($G(@IMGNODE@(2)),U,12) I (CAPP="D") S SKIP=1 Q
 . S IMGNP=+$P($G(@IMGNODE@(100)),U,10)
 . Q
 ;
 ;=== Image counts (grouped by status)
 I DATA("FLAGS")["S"  D
 . N OLDCNT,STC
 . ;--- Standalone image entry
 . I 'GROUP  D  Q
 . . S STC=+$$IMGST^MAGGI11(IMGIEN)
 . . S TMP=$G(^TMP("MAGGA03A",$J,"S",STC))
 . . S $P(TMP,U,1)=$P(TMP,U,1)+1
 . . S $P(TMP,U,2)=$P(TMP,U,2)+$S($G(IMGNP)>0:IMGNP,1:1)
 . . S ^TMP("MAGGA03A",$J,"S",STC)=TMP
 . . Q
 . ;--- Image group
 . S STC=""
 . F  S STC=$O(GRPCNTS("S",STC))  Q:STC=""  D
 . . S TMP=$G(^TMP("MAGGA03A",$J,"S",STC)),OLDCNT=+TMP
 . . D:FE
 . . . S $P(TMP,U,1)=$P(TMP,U,1)+$P(GRPCNTS("S",STC),U,1)
 . . . S $P(TMP,U,2)=$P(TMP,U,2)+$P(GRPCNTS("S",STC),U,3)
 . . . Q
 . . D:FD
 . . . S $P(TMP,U,1)=$P(TMP,U,1)+$P(GRPCNTS("S",STC),U,2)
 . . . S $P(TMP,U,2)=$P(TMP,U,2)+$P(GRPCNTS("S",STC),U,4)
 . . . Q
 . . S:+TMP'=OLDCNT ^TMP("MAGGA03A",$J,"S",STC)=TMP
 . . Q
 . Q
 ;
 ;=== Image capture users
 I DATA("FLAGS")["U"  D
 . N CNT,STC,USRIEN
 . ;--- Standalone image entry
 . I 'GROUP  D  Q
 . . S USRIEN=$S($G(IMGNODE)'="":+$P($G(@IMGNODE@(2)),U,2),1:0)
 . . I USRIEN=0 S USRIEN=".5" ;150 - Put Postmaster, this will stop <undefined> 
 . . S STC=+$$IMGST^MAGGI11(IMGIEN)
 . . S TMP=$G(^TMP("MAGGA03A",$J,"U",USRIEN,STC))
 . . S $P(TMP,U,1)=$P(TMP,U,1)+1
 . . S $P(TMP,U,2)=$P(TMP,U,2)+$S($G(IMGNP)>0:IMGNP,1:1)
 . . S ^TMP("MAGGA03A",$J,"U",USRIEN,STC)=TMP
 . . Q
 . ;--- Image group
 . S USRIEN=""
 . F  S USRIEN=$O(GRPCNTS("U",USRIEN))  Q:USRIEN=""  D
 . . S STC=""
 . . F  S STC=$O(GRPCNTS("U",USRIEN,STC))  Q:STC=""  D
 . . . S TMP=$G(^TMP("MAGGA03A",$J,"U",USRIEN,STC)),OLDCNT=+TMP
 . . . D:FE
 . . . . S $P(TMP,U,1)=$P(TMP,U,1)+$P(GRPCNTS("U",USRIEN,STC),U,1)
 . . . . S $P(TMP,U,2)=$P(TMP,U,2)+$P(GRPCNTS("U",USRIEN,STC),U,3)
 . . . . Q
 . . . D:FD
 . . . . S $P(TMP,U,1)=$P(TMP,U,1)+$P(GRPCNTS("U",USRIEN,STC),U,2)
 . . . . S $P(TMP,U,2)=$P(TMP,U,2)+$P(GRPCNTS("U",USRIEN,STC),U,4)
 . . . . Q
 . . . S:+TMP'=OLDCNT ^TMP("MAGGA03A",$J,"U",USRIEN,STC)=TMP
 . . . Q
 . . Q
 . Q
 ;
 ;===
 Q 0
