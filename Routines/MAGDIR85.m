MAGDIR85 ;WOIFO/PMK - Read a DICOM image file ; 05/06/2004  06:32
 ;;3.0;IMAGING;**11,30**;16-September-2004
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
 ; M2MB server
 ;
 ; This routine handles the "ROLLBACK" RESULT item.
 ; 
ENTRY ; remove ^MAG(2005,IMAGEPTR) entry because of a fatal problem
 N ERRORMSG,IMAGEPTR,ROLLBACK
 S IMAGEPTR=$P(ARGS,"|",2),U="^"
 D DELETE^MAGGTID(.ROLLBACK,IMAGEPTR_"^1",1) ; invoke Garrett's routine
 I ROLLBACK(0)?1"1^".E D
 . S ERRORMSG="0||"_IMAGEPTR
 . Q
 E  D
 . S ERRORMSG="-1|"_$P(ROLLBACK(0),"^",2,999)_"|"_IMAGEPTR
 . Q
 D RESULT^MAGDIR8("ROLLBACK",ERRORMSG)
 Q
