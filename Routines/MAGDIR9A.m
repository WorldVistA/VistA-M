MAGDIR9A ;WOIFO/PMK - Read a DICOM image file ; 01 Oct 2009 6:28 AM
 ;;3.0;IMAGING;**11,30,51,46,54,53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
 ; M2MB server
 ;
 ; This routine creates a ^mag(2005) group entry and links it to the
 ; associated radiology report
 ;
 ;   XXXXXX      XX    XXXXXX
 ;    XX  XX    XXXX    XX  XX
 ;    XX  XX   XX  XX   XX  XX
 ;    XXXXX    XX  XX   XX  XX
 ;    XX XX    XXXXXX   XX  XX
 ;    XX  XX   XX  XX   XX  XX
 ;   XXX  XX   XX  XX  XXXXXX
 ;
GROUP() ; entry point from ^MAGDIR81
 N ACQDEVP ;-- pointer to acquisition device file (#2006.04)
 N DA ;------ fileman variable
 N ERRCODE ;- error trap code
 N GROUP ;--- array to pass group data to ^MAGGTIA
 N GROUPDFN ; DFN value from image group entry for double checking
 N P ;-------- scratch variable (pointer to ACQUISITION DEVICE file)
 N RACNE ;--- external "3rd level" subscript in ^RADPT
 N RACNI ;--- internal "3rd level" subscript in ^RADPT
 N RADFN ;--- radiology package's DFN
 N RADTE ;--- external "2nd level" subscript in ^RADPT
 N RADTI ;--- internal "2nd level" subscript in ^RADPT
 N RARPT ;--- 1st level node in ^RARPT for report (ie, the ien)
 N RARPT3 ;-- 3rd level node for 2005 multiple under ^RARPT's report
 N RARPTDFN ; DFN value from ^RARPT for double checking
 N SOPCLASP ; pointer to SOP Class file (#2006.532)
 N HIT,ISPECIDX,X,Y ; scratch variables
 ;
 S ERRCODE=""
 ;
 S (RADFN,DA(2))=DFN ; patient DFN variables
 S RADTI=RADATA("RADPT2") ; case subscript
 I RADTI="" D  Q ERRCODE
 . K MSG
 . S MSG(1)="No radiology case number specified for patient "_DFN
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-301
 . Q
 ;
 S RADTE=9999999.9999-RADTI ; 9's complement conversion
 S RACNI=RADATA("RADPT3")
 S RACNE=$P(CASENUMB,"-",$L(CASENUMB,"-")) ; short case #
 ;
 ; check for the existence of the entry in ^RADPT (redundant)
 I '$D(^RADPT(RADFN,"DT",RADTI,0)) D  Q ERRCODE ; can't process further
 . K MSG
 . S MSG(1)="Radiology case "_RADTI_" is not in ^RADPT("_RADFN_")"
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-302
 . Q
 ;
 ; check for the existence of the report pointer
 S RARPT=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",17)
 ; if the report does not yet exist, create it
 D:RARPT=""
 . N RACN
 . S RACN=RACNE D CREATE^RARIC ; create the report
 . Q
 ;
 ; If RARPT is no longer defined at this point, this means
 ; that we're dealing with an old study, and the report has
 ; been archived and purged.
 ;
 I '$G(RARPT) D  Q ERRCODE
 . K MSG
 . S MSG(1)="IMAGE GROUP CREATION ERROR:"
 . S MSG(2)="Radiology Report has been archived and purged."
 . S MSG(3)="Patient "_$G(RADFN)_", Date "_$G(RADTI)_", Case "_$G(RACNI)
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-303
 . Q
 ;
 ; double check the DFN value from ^RARPT to make sure its right
 S RARPTDFN=$P($G(^RARPT(RARPT,0)),"^",2)
 I RARPTDFN'=DFN D  Q ERRCODE ; fatal error
 . D RADMISS^MAGDIRVE($T(+0),DFN,RARPT,RARPTDFN)
 . S ERRCODE=-304
 . Q
 ;
 ; initialize FILEDATA for GROUP and IMAGE
 ; get the acquisition device pointer (file 2005, field 107)
 S ACQDEVP=$$ACQDEV^MAGDFCNV(MFGR,MODEL,INSTLOC)
 S FILEDATA("ACQUISITION DEVICE")=ACQDEVP
 ; get the SOP Class pointer (file 2005, field 251)
 S SOPCLASP=$O(^MAG(2006.532,"B",SOPCLASS,""))
 S FILEDATA("SOP CLASS POINTER")=SOPCLASP
 ;
 S FILEDATA("MODALITY")=MODALITY
 S FILEDATA("PARENT FILE")=74
 S FILEDATA("PARENT IEN")=RARPT
 S FILEDATA("RAD REPORT")=RARPT
 S FILEDATA("RAD PROC PTR")=RADATA("PROCIEN")
 S FILEDATA("PACKAGE")="RAD"
 S X=$S(MODALITY="NM":"NUCLEAR MEDICINE",1:"RADIOLOGY")
 S ISPECIDX=$O(^MAG(2005.84,"B",X,""))
 S X=$$FIELD43^MAGXMA(MODALITY,ISPECIDX,.Y)
 S FILEDATA("PROC/EVENT")=$S(X=0:Y,1:"")
 S FILEDATA("SPEC/SUBSPEC")=ISPECIDX
 ;
 ; find the corresponding image group node under the report
 S (HIT,RARPT3)=0
 F  S RARPT3=$O(^RARPT(RARPT,2005,RARPT3)) Q:'RARPT3  D  Q:HIT  Q:ERRCODE
 . S MAGGP=+$G(^RARPT(RARPT,2005,RARPT3,0)) ; get imaging group pointer
 . S GROUPDFN=$P($G(^MAG(2005,MAGGP,0)),"^",7) ; check image DFN value
 . I GROUPDFN'=DFN D  ; fatal error
 . . D MISMATCH^MAGDIRVE($T(+0),DFN,MAGGP)
 . . S ERRCODE=-305
 . . Q
 . E  I $P($G(^MAG(2005,MAGGP,0)),"^",6)=11 D
 . . ; check to see that this group is for the same SOP Class
 . . S P=$P($G(^MAG(2005,MAGGP,"SOP")),"^",1)
 . . S HIT=$$EQUIVGRP^MAGDFCNV(P,SOPCLASP) ; equivalent groups?
 . . Q
 . Q
 ;
 I ERRCODE Q ERRCODE ; fatal image DFN problem
 ;
 I 'HIT D  Q:ERRCODE ERRCODE ; the 2005 node does not yet exist
 . ; create the radiology imaging group
 . N PROCEDUR,RADRPT,RADPTR
 . S PROCEDUR="RAD "_FILEDATA("MODALITY")
 . S RADRPT=FILEDATA("RAD REPORT")
 . S RADPTR=FILEDATA("RAD PROC PTR")
 . D NEWGROUP(PROCEDUR,RADRPT,RADPTR) Q:ERRCODE
 . ;
 . ; store the cross-reference for the report
 . D PTR^RARIC
 . Q
 ;
 I 'MAGGP D  Q ERRCODE ; fatal error
 . K MSG
 . S MSG(1)="IMAGE GROUP LOOKUP ERROR:"
 . S MSG(2)="Looking for 2005 cross reference in ^RARPT("_RARPT_")"
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-308
 . Q
 Q 0
 ;
NEWGROUP(PROCEDUR,RADRPT,RADPTR) ; create an imaging group (called by ^MAGDIR9E)
 N I
 K GROUP S I=0
 S I=I+1,GROUP(I)=".01^"_PNAMEVAH_"  "_DCMPID_"  "_PROCDESC
 S I=I+1,GROUP(I)="3^11" ; Object Type -- XRAY Group
 S I=I+1,GROUP(I)="5^"_DFN
 S I=I+1,GROUP(I)="6^"_PROCEDUR
 S I=I+1,GROUP(I)="2005.04^0"
 S I=I+1,GROUP(I)="10^"_PROCDESC
 S I=I+1,GROUP(I)="15^"_DATETIME
 S I=I+1,GROUP(I)="16^"_FILEDATA("PARENT FILE")
 S I=I+1,GROUP(I)="17^"_FILEDATA("PARENT IEN")
 S I=I+1,GROUP(I)="60^"_STUDYUID
 ;
 ; the following two fields are only for radiology
 I $D(RADRPT) S I=I+1,GROUP(I)="61^"_RADRPT
 I $D(RADPTR) S I=I+1,GROUP(I)="62^"_RADPTR
 ;
 S I=I+1,GROUP(I)=".05^"_INSTLOC
 S I=I+1,GROUP(I)="40^"_FILEDATA("PACKAGE")
 S I=I+1,GROUP(I)="41^"_$O(^MAG(2005.82,"B","CLIN",""))
 S I=I+1,GROUP(I)="42^"_FILEDATA("TYPE")
 S I=I+1,GROUP(I)="43^"_FILEDATA("PROC/EVENT")
 S I=I+1,GROUP(I)="44^"_FILEDATA("SPEC/SUBSPEC")
 S I=I+1,GROUP(I)="45^"_ORIGINDX
 S I=I+1,GROUP(I)="107^"_FILEDATA("ACQUISITION DEVICE")
 S I=I+1,GROUP(I)="110^"_STAMP
 S I=I+1,GROUP(I)="251^"_FILEDATA("SOP CLASS POINTER")
 D ADD^MAGGTIA(.RETURN,.GROUP)
 S MAGGP=+RETURN
 I 'MAGGP D  Q  ; fatal error
 . K MSG
 . S MSG(1)="IMAGE GROUP CREATION ERROR:"
 . S MSG(2)=$P(RETURN,"^",2,999)
 . D BADERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . S ERRCODE=-306
 . Q
 ;
 I MAGGP<LASTIMG D  Q  ; fatal last image pointer error
 . D GROUPPTR^MAGDIRVE($T(+0),MAGGP,LASTIMG)
 . S ERRCODE=-307
 . Q
 Q
 ;
