MAGDIRVE ;WOIFO/PMK - Serious Fatal Image Processing Error Messages ; 17 Sep 2008 7:42 AM
 ;;3.0;IMAGING;**11,30,54**;03-July-2009;;Build 1424
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
 ; new version for RPC client-server image processing error messages
 ;
MAGZERO(RTN,LASTIEN,LASTIMG) ; from ^MAGDIR84 for bad ^MAG(2005)
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - IMAGE FILE CORRUPTION"
 S MSG(2)="The ^MAG(2005) file has been corrupted so that new images will"
 S MSG(3)="overwrite old ones and general image database inconsistency"
 S MSG(4)="will result."
 S MSG(5)=""
 S MSG(6)="Latest internal entry number processed: "
 S MSG(6)=MSG(6)_LASTIMG ; ^MAGDICOM(2006.563,1,"LAST IMAGE POINTER")
 S MSG(7)="Bad ^MAG(2005,0) internal entry number: "_LASTIEN
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
ZERONODE(RTN,LASTIEN,LASTPTR,FILE,FILENAME) ; from ^MAGDIR84
 ; invoked for an arbitrary file corrupted value
 N TITLE,ZERONODE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - "_FILE_" FILE CORRUPTION"
 S MSG(2)="The "_FILENAME_" file has been corrupted so that new reports will"
 S MSG(3)="overwrite old ones and general image/report database inconsistency"
 S MSG(4)="will result."
 S MSG(5)=""
 S MSG(6)="Latest internal entry number processed: "
 S MSG(6)=MSG(6)_LASTPTR ; from ^MAGDICOM(2006.563,1,"LAST ... POINTER")
 S ZERONODE=$S(FILE[")":$P(FILE,")")_",0)",1:FILE_"(0)")
 S MSG(7)="Bad "_ZERONODE_" internal entry number: "_LASTIEN
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
OBJECT(RTN,MAGGP) ; from ^MAGDIR9B
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - WRONG GROUP OBJECT TYPE"
 S MSG(2)="The group entry in ^MAG(2005) does not have the proper group"
 S MSG(3)="object type."
 S MSG(4)=""
 S MSG(5)="The expected value is 11.  The value in the group entry is "
 S MSG(5)=MSG(5)_$P($G(^MAG(2005,MAGGP,0),"^^^^^not defined"),"^",6)_"."
 S MSG(6)=""
 S MSG(7)="Internal entry number of incorrect group: "_MAGGP
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
MISMATCH(RTN,DFN,MAGGP) ; from ^MAGDIR9A/B/E for a patient mismatch
 N GROUPDFN,TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - PATIENT MISMATCH PROBLEM"
 S GROUPDFN=$P($G(^MAG(2005,MAGGP,0)),"^",7)
 S MSG(2)="The image and the group point to different patients."
 S MSG(3)=""
 S MSG(4)="The Image points to PATIENT file internal entry number "_DFN
 S MSG(5)=$$PATDEMO(DFN)
 S MSG(6)=""
 S MSG(7)="The Group points to PATIENT file internal entry number "_GROUPDFN
 S MSG(8)=$$PATDEMO(GROUPDFN)
 S MSG(9)=""
 S MSG(10)="Internal entry number of group: ^MAG(2005,"_MAGGP_")"
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
PATDEMO(DFN) ; display patient demographics
 N %,%H,DISYS,DTIME,VA,VADM,VAERR
 Q:'$G(DFN) "<null DFN>"
 D DEM^VADPT
 Q "("_$P($G(VADM(5)),"^",2)_" - "_$P($G(VADM(3)),"^",2)_")" ; sex & dob
 ;
RADMISS(RTN,DFN,RARPT,RARPTDFN) ; from ^MAGDIR9A for a patient mismatch
 ; this is bad DFN value for the radiology report in ^RARPT
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - RAD PATIENT/REPORT MISMATCH"
 S MSG(2)="The image and the radiology report point to different patients."
 S MSG(3)=""
 S MSG(4)="The Image points to PATIENT file internal entry number "_DFN
 S MSG(5)=$$PATDEMO(DFN)
 S MSG(6)=""
 S MSG(7)="The Rad Report points to PATIENT file internal entry number "_RARPTDFN
 S MSG(8)=$$PATDEMO(RARPTDFN)
 S MSG(9)=""
 S MSG(10)="Internal entry number of report: ^RARPT("_RARPT_")"
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
TIUMISS(RTN,DFN,TIUIEN,TIUDFN) ; from ^MAGDIR9E for a patient mismatch
 ; this is bad DFN value for the consult/procedure request note in ^TIU(8925)
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - TIU PATIENT/REPORT MISMATCH"
 S MSG(2)="The image and the TIU note point to different patients."
 S MSG(3)=""
 S MSG(4)="The Image points to PATIENT file internal entry number "_DFN
 S MSG(5)=$$PATDEMO(DFN)
 S MSG(6)=""
 S MSG(7)="The TIU note points to PATIENT file internal entry number "_TIUDFN
 S MSG(8)=$$PATDEMO(TIUDFN)
 S MSG(9)=""
 S MSG(10)="Internal entry number of TIU note: ^TIU(8925,"_TIUIEN_")"
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
TIUMISS2(RTN,TIUIEN1,TIUIEN2,TIUXDIEN,MAGGP) ; from ^MAGDIR9E - TIU mismatch
 ; mismatch between TIU, TIU External Data File, and the image group  
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - TIU/IMAGE GROUP MISMATCH"
 S MSG(2)="The image group and TIU point to different notes."
 S MSG(3)=""
 S MSG(4)="TIU points to TUI note ien #"_TIUIEN1
 S MSG(5)="The image points to TIU note ien #"_TIUIEN2
 S MSG(6)="TIU External Data File (8925.91) ien #"_TIUXDIEN
 S MSG(7)="points to image group ien #"_MAGGP
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
TMPMISS(RTN,PARENTFP,MAGGP) ; from ^MAGDIR9E
 ; the image group does not have 2006.5839 for the PARENT FILE
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - IMAGE GROUP MISMATCH"
 S MSG(2)="The image group does not point to PARENT FILE 2006.5839."
 S MSG(3)=""
 S MSG(4)="The image group should point to PARENT FILE 2006.5839."
 S MSG(5)="Instead it point to PARENT FILE #"_PARENTFP
 S MSG(6)="The image group is ^MAG(2005,"_MAGGP_")"
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
IMAGEPTR(RTN,IMAGEPTR,LASTIMG) ; from ^MAGDIR9B for a corrupted image pointer value
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - IMAGE ENTRY NUMBER PROBLEM"
 S MSG(2)="The internal entry number for this image is less than that of the"
 S MSG(3)="last processed image.  This will cause new images to overwrite"
 S MSG(4)="old ones and general image database inconsistency will result."
 S MSG(5)=""
 S MSG(6)="Latest internal entry number processed: "
 S MSG(6)=MSG(6)_LASTIMG ; ^MAGDICOM(2006.563,1,"LAST IMAGE POINTER")
 S MSG(7)="Bad internal entry number of new image: "_IMAGEPTR
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
GROUPPTR(RTN,MAGGP,LASTIMG) ; from ^MAGDIR9A for bad group pointer
 N TITLE
 K MSG
 S TITLE="DICOM IMAGE PROCESSING ERROR - GROUP ENTRY NUMBER PROBLEM"
 S MSG(2)="The internal entry number for this group is less than that of the"
 S MSG(3)="last processed image.  This will cause new images to overwrite"
 S MSG(4)="old ones and general image database inconsistency will result."
 S MSG(5)=""
 S MSG(6)="Latest internal entry number processed: "
 S MSG(6)=MSG(6)_LASTIMG ; ^MAGDICOM(2006.563,1,"LAST IMAGE POINTER")
 S MSG(7)="Bad internal entry number of new group: "_MAGGP
 D BADERROR(RTN,TITLE,.MSG)
 Q
 ;
BADERROR(RTN,TITLE,MSG) ; final common pathway for all msgs
 ; invoked by other image processing error checking code as well
 N I
 S I=$O(MSG(" "),-1)
 S MSG(1)=$G(MSG(1)) ; usually null
 S MSG(I+1)="Gateway: """_$G(SYSTITLE,"<unknown>")_""""
 S MSG(I+2)=""
 S MSG(I+3)="          This is a VERY SERIOUS ERROR.  Image processing"
 S MSG(I+4)="              will be halted until it is resolved."
 S MSG(I+5)=""
 S MSG(I+6)="Call IRM and the National VistA Support Help Desk (888) 596-HELP"
 S MSG(I+7)=""
 S MSG(I+8)="Problem detected by routine "_RTN_"."
 S MSG(I+9)=""
 S MSG("TITLE")=TITLE,MSG("CRITICAL")=1 ; send email to Silver Spring
 Q
 ;
ERROR(RTN,TITLE,MSG) ; application error - local to the site - no email
 N I
 S I=$O(MSG(" "),-1)
 S MSG(I+1)="Problem detected by routine "_RTN_"."
 S MSG(I+2)=""
 S MSG("TITLE")=TITLE,MSG("CRITICAL")=0 ; no email to Silver Spring
 Q
