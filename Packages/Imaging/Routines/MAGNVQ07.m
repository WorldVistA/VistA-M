MAGNVQ07 ;WOIFO/NST - List images for a patient ; NOV 20, 2018@3:59 PM
 ;;3.0;IMAGING;**221**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;+++++ CALLBACK FUNCTION FOR IMAGE QUERY
 ;
 ; IMGIEN        IEN of the image record (file #2005 or #2005.1)
 ;
 ; FLAGS         Parameters passed into the image query API
 ; .MAGDATA      ($$QUERY^MAGGI13). See the GETIMGS^MAGSIXG1 
 ;               for details.
QRY2005(IMGIEN,FLAGS,MAGDATA) ; 
 N CNT,FLTX,GRPCNTS,PTIEN,RC
 ; 
 S RC=$$FILTER^MAGSIXG3(.FLTX,.GRPCNTS,.PTIEN,IMGIEN,FLAGS,.MAGDATA) ; Apply filter 
 Q:'RC 0  ; Check filter
 ;
 Q:RC=2 1  ; Terminate the query when maximum number of records is reached
 ;
 ;=== Append the image item to the result array
 S ^TMP("MAGNVQ07",$J,"QRY2005",0)=$G(^TMP("MAGNVQ07",$J,"QRY2005",0))+1
 S ^TMP("MAGNVQ07",$J,"QRY2005",^TMP("MAGNVQ07",$J,"QRY2005",0))=IMGIEN
 ;
 ;=== Success
 Q 0
