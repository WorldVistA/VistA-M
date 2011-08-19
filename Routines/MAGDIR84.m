MAGDIR84 ;WOIFO/PMK - Read a DICOM image file ; 19 Sep 2007 9:43 AM
 ;;3.0;IMAGING;**11,54**;03-July-2009;;Build 1424
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
 ; M2MB server
 ;
 ; This routine handles the "PATIENT SAFETY" REQUEST item.
 ;
 ; It checks the 0-node of ^MAG(2005) and other files to verify that
 ; they have not been unintentionally decremented.  This is a safety
 ; precaution to prevent an earlier copy of the global from being used.
 ; 
 ; This problem can be caused either by using the VA AXP DSM 
 ; Global/Volume Set Repacking Utility or by restoring an old
 ; copy of the global.
 ; 
ENTRY ; entry point from ^MAGDIR8
 N LASTIEN ;-- internal entry number of last image in ^MAG(2005)
 N LASTPTR ;-- value of "LAST IMAGE POINTER"
 N FILE ;----- name of MUMPS file containing 0-node for testing
 N FILENAME ;- human-readable name of file begin tested
 N NEWVALUE ;- updated value for the last pointer
 N RESULTS ;-- result string (working variable)
 ;
 N EMAIL,LASTIMG,LASTRAD,SYSTITLE
 ;
 S LASTIMG=$P(ARGS,"|",2),LASTRAD=$P(ARGS,"|",3)
 S SYSTITLE=$P(ARGS,"|",4),EMAIL=$P(ARGS,"|",5)
 ;
 I $$MAG D  ; imaging file (2005)
 . ; error with imaging file
 . D ERROR^MAGDIR8("PATIENT SAFETY","-1 IMAGE FILE CORRUPTION",.MSG,$T(+0))
 . Q
 E  D  ; no error with imaging file
 . S RESULTS="0|"_NEWVALUE ; new IMAGEPTR
 . ;
 . I $$RARPT D  ; radiology report file
 . . ; error with radiology report file
 . . D ERROR^MAGDIR8("PATIENT SAFETY","-2 RAD REPORT FILE CORRUPTION",.MSG,$T(+0))
 . . Q
 . E  D  ; no errors
 . . S RESULTS=RESULTS_"|"_NEWVALUE ; new RADPT
 . . I RESULTS'=$P(ARGS,"|",1,3) D  ; do this only if there are changes
 . . . D RESULT^MAGDIR8("PATIENT SAFETY",RESULTS)
 . . . Q
 . . Q
 . Q
 Q
 ;
MAG() ; check that the last image pointer is monotonically increasing
 S FILE="^MAG(2005)",FILENAME="IMAGE",LASTPTR=LASTIMG
 I $$CHECK1'<0 Q 0 ; normal exit, everything is consistent
 ;
 ; Something fishy may be up ... look for multiple deleted entries
 N LAST,LASTDEL,LASTMAG
 H 5 ; wait for other image gateways to complete file update
 S LASTMAG=$O(^MAG(2005," "),-1) ; last image file ien
 S LASTDEL=$O(^MAG(2005.1," "),-1) ; last delete file ien
 S LAST=$S(LASTDEL>LASTMAG:LASTDEL,1:LASTMAG) ; greater of these
 I LAST<LASTPTR D  Q 1  ; issue an error message, as data is missing
 . D MAGZERO^MAGDIRVE($T(+0),LASTIEN,LASTIMG)
 . Q
 Q 0
 ;
RARPT() ; check ^RARPT to make sure that it isn't decremented abnormally
 S FILE="^RARPT",FILENAME="RAD REPORT",LASTPTR=LASTRAD
 Q $$CHECK
 ;
CHECK() ; check the last internal entry with that previously saved
 I $$CHECK1'<0 Q 0 ; normal exit, everything is consistent
 ;
 ; Something fishy may be up ... flag the error
 D ZERONODE^MAGDIRVE($T(+0),LASTIEN,LASTPTR,FILE,FILENAME)
 Q 1
 ;
CHECK1() ; check the last internal entry number against the largest know value
 S LASTIEN=$O(@FILE@(" "),-1) ; changed from piece 3 of zero node - PMK 6/4/02
 S NEWVALUE=LASTPTR,LASTPTR=+LASTPTR
 I LASTIEN=LASTPTR Q 0 ; no change
 I LASTIEN>LASTPTR D UPDATE Q 1 ; record last ien in ^MAGDICOM
 ;
 ; if last entry was deleted, LASTIEN should be one less than LASTPTR 
 I LASTIEN=(LASTPTR-1) D UPDATE Q 1 ; a delete must have happened
 Q -1 ; the last entry number is less that it should be
 ;
UPDATE ; record the largest known internal entry number in ^MAGDICOM
 N Y
 S Y=$$HTE^XLFDT($H,1)
 S NEWVALUE=LASTIEN_" "_$P(Y,",")_" at "_$P(Y,"@",2)
 Q
 ;
