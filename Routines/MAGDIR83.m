MAGDIR83 ;WOIFO/PMK - Read a DICOM image file ; 06/06/2005  09:20
 ;;3.0;IMAGING;**11,30,51,54**;03-July-2009;;Build 1424
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
 ; M2MB server
 ;
 ; This routine is invoked by the ^MAGDIR8 to update handle DICOM
 ; CORRECT functions, that is, the "CORRECT" REQUEST item.
 ;
 ; This is a four-step process:
 ;
 ;    1) The "QUERY" record is sent, to obtain a list of corrected
 ;       images.  The list is sent back to the gateway in a list of
 ;       "CORRECT" RESULT items, each with new patient/study values.
 ;       If the images are to be deleted, the list will contain "DELETE"
 ;       instead of "FIXED" RESULT items.
 ;    2) The gateway processes each corrected/deleted image, one at a
 ;       time.
 ;    3) The gateway sends a "PROCESSED | IMAGE" record is sent back to
 ;       the server for each corrected image, so that each can be
 ;       deleted from the list.  (This is called an RPC Callback.)
 ;    4) Finally, the gateway sends a "PROCESSED | STUDY" record back to
 ;       the server to delete the remainder of the study from the list.
 ;
ENTRY ; update image acquisition statistics
 N LOCATION,MACHID,STATUS
 S STATUS=$P(ARGS,"|",1)
 I STATUS="QUERY" D
 . D QUERY
 . Q
 E  I STATUS="PROCESSED" D
 . D PROCESS
 . Q
 Q
 ;
QUERY ; get the list of DICOM CORRECTED files
 N DELFLAG,ICOUNT,IMAGEIEN,INSTNAME,LOCATION,MACHID
 N NEW,NEWNAME,NEWPID,NEWACN,NIMAGES,STUDYIEN,STUDYUID
 ;
 S LOCATION=$P(ARGS,"|",2),MACHID=$P(ARGS,"|",3)
 S NIMAGES=0,STUDYIEN=""
 F  S STUDYIEN=$O(^MAGD(2006.575,"AFX",LOCATION,MACHID,STUDYIEN)) Q:'STUDYIEN  Q:NIMAGES>24  D
 . S DELFLAG=^MAGD(2006.575,"AFX",LOCATION,MACHID,STUDYIEN)
 . S INSTNAME=$P(^MAGD(2006.575,STUDYIEN,"AMFG"),"^",1)
 . S STUDYUID=^MAGD(2006.575,STUDYIEN,"ASUID")
 . S NEW=^MAGD(2006.575,STUDYIEN,"FIXD")
 . S NEWNAME=$P(NEW,"^",3),NEWPID=$P(NEW,"^",4),NEWACN=$P(NEW,"^",5)
 . S IMAGEIEN=STUDYIEN ; need to process the first image
 . D QUERY1("NONE") ; first time - defer deleting this node
 . S ICOUNT=0
 . F  S ICOUNT=$O(^MAGD(2006.575,STUDYIEN,"RLATE",ICOUNT)) Q:'ICOUNT  Q:NIMAGES>24  D
 . . S IMAGEIEN=^MAGD(2006.575,STUDYIEN,"RLATE",ICOUNT,0)
 . . D QUERY1("IMAGE") ; regular image - delete it
 . . S NIMAGES=NIMAGES+1
 . . Q
 . I 'ICOUNT D  ; end of study reached - delete first image & study
 . . S IMAGEIEN=STUDYIEN ; need to delete first image and the study
 . . D QUERY1("STUDY") ; second time, now delete the study entry
 . . Q
 . Q
 Q
 ;
QUERY1(DELTYPE) ; build one CORRECT Result PROCESS array node
 N FROMPATH,X
 S FROMPATH=$P($G(^MAGD(2006.575,IMAGEIEN,0)),"^",1) Q:FROMPATH=""
 S X=$S(DELFLAG="D":"DELETE",1:"FIXED")
 S X=X_"|"_IMAGEIEN_"|"_STUDYIEN_"|"_DELTYPE_"|"_INSTNAME
 S X=X_"|"_FROMPATH_"|"_STUDYUID_"|"_NEWNAME_"|"_NEWPID_"|"_NEWACN
 D RESULT^MAGDIR8("CORRECT",X)
 Q
 ;
 ; -----------------------  RPC CALLBACK ------------------------------
 ;
PROCESS ; delete the processed corrected entry from the ^MAGD(2006.575) file
 N DELTYPE,EXIST,FILEPATH,IMAGEIEN,LOCATION,RLATEIEN,STUDYIEN
 S IMAGEIEN=$P(ARGS,"|",2),STUDYIEN=$P(ARGS,"|",3)
 S DELTYPE=$P(ARGS,"|",4),FILEPATH=$P(ARGS,"|",6) ; ignore piece #5
 I DELTYPE'="NONE" D  ; don't delete the first image/study in the list
 . L +^MAGD(2006.575,0):1E9 ; Background process MUST wait
 . I DELTYPE="IMAGE" D  ; delete this image
 . . ; remove the related image cross-references
 . . S RLATEIEN=$O(^MAGD(2006.575,STUDYIEN,"RLATE","B",IMAGEIEN,""))
 . . I RLATEIEN D
 . . . K ^MAGD(2006.575,STUDYIEN,"RLATE",RLATEIEN)
 . . . K ^MAGD(2006.575,STUDYIEN,"RLATE","B",IMAGEIEN,RLATEIEN)
 . . . S $P(^(0),"^",4)=$P(^MAGD(2006.575,STUDYIEN,"RLATE",0),"^",4)-1
 . . . Q
 . . Q
 . E  I DELTYPE="STUDY" D  ; delete the first image and study information
 . . ; remove the "AFX" and "F" cross-references
 . . S STUDYUID=$P(ARGS,"|",7),MACHID=$P(ARGS,"|",8)
 . . S LOCATION=$P(ARGS,"|",9)
 . . K ^MAGD(2006.575,"AFX",LOCATION,MACHID,STUDYIEN)
 . . K ^MAGD(2006.575,"F",LOCATION,STUDYUID,STUDYIEN)
 . . Q
 . ; Only subtract 1 from #entries, if we're actually deleting one:
 . S EXIST=$D(^MAGD(2006.575,IMAGEIEN))
 . K ^MAGD(2006.575,IMAGEIEN)
 . K ^MAGD(2006.575,"B",FILEPATH,IMAGEIEN)
 . S:EXIST $P(^(0),"^",4)=$P(^MAGD(2006.575,0),"^",4)-1
 . L -^MAGD(2006.575,0)
 . Q
 D RESULT^MAGDIR8("CORRECT","COMPLETE|"_IMAGEIEN_"|"_STUDYIEN_"|"_DELTYPE)
 Q
