MAGDIR9F ;WOIFO/PMK - Read a DICOM image file ; 17 Jul 2013 11:42 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; This routine creates the group entry in ^MAG(2005) and links it
 ; to the request in Anatomic Pathology.
 ; 
GROUP() ; entry point from ^MAGDIR8 for Anatomic Pathology groups
 N ACQDEVP ;-- pointer to acquisition device file (#2006.04)
 N D0 ;------- fileman variable
 N ERRCODE ;-- error trap code
 N GROUP ;---- array to pass group data to ^MAGGTIA
 N IENS ;----- lookup string for Fileman
 N MAGGPP ;--- pointer to group in DICOM LAB TEMP LIST ^MAG(20006.5838)
 N P ;-------- scratch variable (pointer to ACQUISITION DEVICE file)
 N PARENTFILE ; one of four anatomic pathology files
 N RESULT ;--- scratch variable
 N SOPCLASP ;- pointer to SOP Class file (#2006.532)
 N TIUIEN ;--- TIU file 8925 IEN value
 N TIUREF ;--- Anatomic Pathology reference file
 N ERROR ;---- error return for GETS^DIQ Filename API call
 ;
 S ERRCODE=""
 ;
 I STUDYDAT,STUDYTIM D  ; get study date/time from image header
 . S DATETIME=(STUDYDAT_"."_STUDYTIM)-17000000 ; FileMan date.time fmt
 . Q
 E  S DATETIME=$$NOW^XLFDT() ; use current date/time
 ;
 ; initialize FILEDATA for GROUP and IMAGE
 ; get the acquisition device pointer (file 2005, field 107)
 S ACQDEVP=$$ACQDEV^MAGDFCNV(MFGR,MODEL,INSTLOC)
 S FILEDATA("ACQUISITION DEVICE")=ACQDEVP
 ; get the SOP Class pointer (file 2005, field 251)
 S SOPCLASP=$O(^MAG(2006.532,"B",SOPCLASS,""))
 S FILEDATA("SOP CLASS POINTER")=SOPCLASP
 ;
 D SUBFILES(LRSS) ; get LAB DATA (#63)subfile
 S FILEDATA("SPEC/SUBSPEC")=$O(^MAG(2005.84,"B","PATHOLOGY",""))
 ;
 S MAGGP="" ; initialize pointer to the image group
 ;
 ; check if there already is a TIU note attached to this request
 ;
 S TIUIEN=0
 ;
 ; look up TIU note
 S IENS="1,"_LRI_","_LRDFN_","
 S TIUIEN=$$GET1^DIQ(TIUREF,IENS,1,"I")
 ;
 I TIUIEN D  Q:ERRCODE ERRCODE ; there is TIU note already
 . ; double check TIU note DFN to make sure that it matches
 . N HIT ; scratch variable used in finding corresponding image group
 . N TIUDFN ; DFN value from ^TIU for double checking
 . N TIUXDIEN ; TIU External Data File IEN
 . S TIUDFN=$P($G(^TIU(8925,TIUIEN,0)),"^",2)
 . I TIUDFN'=DFN D  Q  ; fatal error
 . . D TIUMISS^MAGDIRVE($T(+0),DFN,TIUIEN,TIUDFN)
 . . S ERRCODE=-501
 . . Q
 . ;
 . S FILEDATA("PARENT FILE")=8925 ; TIU file
 . S FILEDATA("PARENT IEN")=TIUIEN
 . ;
 . ; is there an entry in TIU External Data File for this note
 . S (HIT,TIUXDIEN)=0
 . F  S TIUXDIEN=$O(^TIU(8925.91,"B",TIUIEN,TIUXDIEN)) Q:'TIUXDIEN  D  Q:HIT  Q:ERRCODE
 . . N MAG2 ;----- data value for getting parent file attributes
 . . N GROUPDFN ;- DFN value from image group entry for double checking
 . . ; there is a TIU External Data File
 . . ; does the TIU External Data File entry point to an image group?
 . . S MAGGP=$$GET1^DIQ(8925.91,TIUXDIEN,.02,"I") Q:'MAGGP
 . . ; double check image group entry DFN
 . . S GROUPDFN=$P($G(^MAG(2005,MAGGP,0)),"^",7)
 . . I GROUPDFN'=DFN D  Q  ; fatal error
 . . . D MISMATCH^MAGDIRVE($T(+0),DFN,MAGGP)
 . . . S ERRCODE=-502
 . . . Q
 . . I $P($G(^MAG(2005,MAGGP,0)),"^",6)'=11 D  Q  ; 11=XRAY GROUP
 . . . S MAGGP="" ; wrong object type - skip this image group
 . . . Q
 . . ; create a new group if this is for a different Study Instance UID
 . . I STUDYUID'=$P($G(^MAG(2005,MAGGP,"PACS")),"^",1) S MAGGP="" Q
 . . S P=$P($G(^MAG(2005,MAGGP,"SOP")),"^",1)
 . . ; skip this image group if wrong SOP Class
 . . I '$$EQUIVGRP^MAGDFCNV(P,SOPCLASP) S MAGGP="" Q
 . . ; add the new image to this existing image group
 . . S HIT=1,MAG2=$G(^MAG(2005,MAGGP,2))
 . . S FILEDATA("PARENT FILE")=$P(MAG2,"^",6)
 . . S FILEDATA("PARENT IEN")=$P(MAG2,"^",7)
 . . S FILEDATA("PARENT FILE PTR")=$P(MAG2,"^",8)
 . . I FILEDATA("PARENT IEN")'=TIUIEN D  ; fatal error
 . . . D TIUMISS2^MAGDIRVE($T(+0),TIUIEN,FILEDATA("PARENT IEN"),TIUXDIEN,MAGGP)
 . . . S ERRCODE=-503
 . . . Q
 . . Q
 . Q
 ;
 ; need a temporary association for the anatomic pathology study
 ;
 E  D  Q:ERRCODE ERRCODE ; check if there is a temporary association
 . ;
 . ; Note: this algorithm creates multiple groups for a study,
 . ;       for instance a GI fluoroscopy + color images
 . ;
 . S MAGGPP=""
 . F  S MAGGPP=$O(^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,MAGGPP)) Q:'MAGGPP  D  Q:ERRCODE
 . . N GROUPDFN ; DFN value from image group entry for double checking
 . . S MAGGP=$P(^MAG(2006.5838,MAGGPP,0),"^",4)
 . . ; double check image group entry DFN in existing 2005 group node
 . . S GROUPDFN=$P($G(^MAG(2005,MAGGP,0)),"^",7)
 . . I GROUPDFN'=DFN D  ; fatal error
 . . . D MISMATCH^MAGDIRVE($T(+0),DFN,MAGGP)
 . . . S MAGGP="" ; bad group
 . . . S ERRCODE=-504
 . . . Q
 . . E  S P=$P($G(^MAG(2005,MAGGP,100)),"^",4) I P,P'=ACQDEVP D  ; wrong device
 . . . S MAGGP="" ; wrong acquisition device - skip this image group
 . . . Q
 . . E  D  ; add the new image to this existing image group
 . . . N MAG2 ; data value for getting parent file attributes
 . . . S MAG2=$G(^MAG(2005,MAGGP,2))
 . . . S FILEDATA("PARENT FILE")=$P(MAG2,"^",6)
 . . . S FILEDATA("PARENT IEN")=$P(MAG2,"^",7)
 . . . S FILEDATA("PARENT FILE PTR")=$P(MAG2,"^",8)
 . . . I FILEDATA("PARENT FILE")'=2006.5838 D  ; fatal error
 . . . . D TMPMISS^MAGDIRVE($T(+0),FILEDATA("PARENT FILE"),MAGGP)
 . . . . S ERRCODE=-505
 . . . . Q
 . . . Q
 . . Q
 . ;
 . I 'MAGGP  D  ; no group exists yet create a temporary association
 . . S FILEDATA("PARENT FILE")=2006.5838 ; Anatomic Pathology temporary file
 . . S FILEDATA("PARENT IEN")=LRDFN
 . . S FILEDATA("PARENT FILE PTR")=LRI
 . . Q
 . Q
 ;
 S FILEDATA("MODALITY")=MODALITY
 S FILEDATA("PACKAGE")="LAB"
 ;
 ; add an image to the MAG PATH CASELIST file (#2005.42)
 D IMAGECNT^MAGTP005(ACNUMB,1)
 ;
 ; if the 2005 group node does not yet exist, create it
 ;
 I 'MAGGP D  Q:ERRCODE ERRCODE ; create the imaging group
 . ;
 . D NEWGROUP^MAGDIR9A("PATHOLOGY") Q:ERRCODE
 . ;
 . I FILEDATA("PARENT FILE")=8925 D  Q:ERRCODE  ; fix for ^TIU
 . . S ERRCODE=$$TIUXLINK^MAGDIR9E()
 . . Q
 . E  I FILEDATA("PARENT FILE")=2006.5838 D  ; fix for Anatomic Pathology
 . . L +^MAG(2006.5838):1E9 ; Background job MUST wait
 . . I '$D(^MAG(2006.5838,0)) D
 . . . S ^MAG(2006.5838,0)="DICOM LAB TEMP LIST^2006.5838S^0^0"
 . . . Q
 . . S D0=$P(^MAG(2006.5838,0),"^",3)+1
 . . S $P(^MAG(2006.5838,0),"^",3)=D0,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 . . L -^MAG(2006.5838)
 . . S ^MAG(2006.5838,D0,0)=PARENTFILE_"^"_LRDFN_"^"_LRI_"^"_MAGGP
 . . S ^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,D0)=""
 . . Q
 . Q
 ;
 Q 0
 ;
SUBFILES(LRSS) ; get LAB DATA (#63)subfiles - called by MAGDRPC4
 N FILE ; ---- LAB DATA subfile numbers and other info
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to repor
 S ERRSTAT=$$GETFILE^MAGT7MA(LRSS)
 I ERRSTAT S (FILEDATA("PROC/EVENT"),PARENTFILE,TIUREF)="" Q
 S PARENTFILE=FILE("PARENT FILE")
 S TIUREF=FILE("TIU REFERENCE")
 S FILEDATA("PROC/EVENT")=FILE("PROC/EVENT")
 Q
