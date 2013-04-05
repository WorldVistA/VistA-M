MAGDIR81 ;WOIFO/PMK/JSL/SAF - Read a DICOM image file ; 25 Feb 2008 11:06 AM
 ;;3.0;IMAGING;**11,30,51,50,46,54,53,123**;Mar 19, 2002;Build 67;Jul 24, 2012
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
 ; This routine is invoked by the ^MAGDIR8 for the "STORE1/STORE2"
 ; REQUEST items when there is an image to be stored into the database.
 ; It adds it to the ^MAG global with appropriate pointers to the
 ; "parent data files".
 ;
ENTRY ; process one image
 N MEDATA ;--- medicine pkg patient & study data (set in ^MAGDIR8A)
 N FILEDATA ;- array of data to be passed between routines
 N FIRSTDCM ;- patient first name from the image header (ie, PNAMEDCM)
 N GMRCIEN ;-- internal entry number of consult/procedure request
 N IMPORTER ;- flag set by a gateway that is running the IMPORTER app
 N LASTDCM ;-- patient last name from the image header (ie, PNAMEDCM)
 N MEDIA ;---- source of DICOM object for Importer (D=disk, T=transmission)
 N MAGGP ;---- image's group pointer in ^MAG(2005)
 N MAGIEN ;--- pointer to the entry for the image in ^MAG(2005)
 N MIDCM ;---- patient middle initial from the image header (PNAMEDCM)
 N OLDPATH ;-- original path for imported images (set by Importer)
 N ORIGINDX ;- origin index (file 2005, field 45)
 N PNAMEVAH ;- patient name from VADM(1)
 N PROCDESC ;- procedure description (VA's name)
 N RADATA ;--- radiology pkg patient & study data (set in ^MAGDIR8A)
 N VADM ;----- array of demographic variables filled in by DEM^VADPT
 N I,MAG0,MAG1,MAG2,QUIT,X
 ;
 N ACNUMB,ARG2,CASENUMB,EMAIL,FROMPATH,IMAGEUID,IMAGNAME,IMAGNUMB,IMGSVC
 N INSTLOC,INSTNAME,LASTIMG,LOCATION,MACHID,MFGR,MODALITY,MODEL,MODPARMS
 N MULTFRAM,PID,PNAMEDCM,ROUTRULE,SERINUMB,SERIEUID,SOPCLASS,STAMP,STATUS
 N STUDYDAT,STUDYTIM,STUDYDAT,STUDYTIM,STUDYUID,SYSTITLE
 ;
 S STATUS=$P(ARGS,"|",1),LOCATION=$P(ARGS,"|",2)
 S MACHID=$P(ARGS,"|",3),IMGSVC=$P(ARGS,"|",4)
 S INSTNAME=$P(ARGS,"|",5),FROMPATH=$P(ARGS,"|",6)
 S PID=$P(ARGS,"|",7),PNAMEDCM=$P(ARGS,"|",8)
 S CASENUMB=$P(ARGS,"|",9),ACNUMB=$P(ARGS,"|",10)
 S STUDYDAT=$P(ARGS,"|",11),STUDYTIM=$P(ARGS,"|",12)
 S IMPORTER=$P(ARGS,"|",13),MODALITY=$P(ARGS,"|",14)
 S IMAGNAME=$P(ARGS,"|",15),MODPARMS=$P(ARGS,"|",16)
 S SERINUMB=$P(ARGS,"|",17),IMAGNUMB=$P(ARGS,"|",18)
 S INSTLOC=$P(ARGS,"|",19),MULTFRAM=$P(ARGS,"|",20)
 S SYSTITLE=$P(ARGS,"|",21),EMAIL=$P(ARGS,"|",22)
 S IREQUEST=IREQUEST+1,OPCODE=$P(REQUEST(IREQUEST),"|")
 I OPCODE'="STORE2" D  Q
 . D RESULT^MAGDIR8("STORE","-101 Expecting STORE2, got """_OPCODE_"""")
 . Q
 S ARG2=$P(REQUEST(IREQUEST),"|",2,999)
 S STUDYUID=$P(ARG2,"|",1),SERIEUID=$P(ARG2,"|",2)
 S IMAGEUID=$P(ARG2,"|",3),SOPCLASS=$P(ARG2,"|",4)
 S LASTIMG=$P(ARG2,"|",5),ROUTRULE=$P(ARG2,"|",6)
 S MFGR=$P(ARG2,"|",7),MODEL=$P(ARG2,"|",8)
 S STAMP=$P(ARG2,"|",9),ORIGINDX=$P(ARG2,"|",10)
 S MEDIA=$P(ARG2,"|",11),OLDPATH=$P(ARG2,"|",12)
 ;
 ; get a pointer to the image, if it is already on file
 S MAGIEN=$O(^MAG(2005,"P",IMAGEUID,0))
 ;
 ; the following line will have to be adjusted for DICOM SR
 S FILEDATA("TYPE")=$O(^MAG(2005.83,"B","IMAGE",""))
 ;
 I MULTFRAM,MAGIEN D  ; subsequent image of a multiframe object
 . D MULTFRAM ; require both MULTFRAM and MAGIEN to be non-zero
 . Q
 E  D  Q:ERRCODE  ; new image
 . S ERRCODE=$$NEWIMAGE()
 . I ERRCODE D  ; error - abort image processing
 . . D ERROR^MAGDIR8("STORE",ERRCODE,.MSG,$T(+0))
 . . Q
 . Q
 ;
 ;create the image pointer
 I MODPARMS="<DICOM>" D  ; store DICOM image type in VistA
 . S FILEDATA("OBJECT TYPE")=100 ; DICOM image type
 . S FILEDATA("EXTENSION")="EXT^DCM" ; specify the DICOM file extension
 . Q
 E  D  ; convert DICOM image type to TGA and store it in VistA
 . S FILEDATA("OBJECT TYPE")=3 ; XRAY image type
 . S FILEDATA("EXTENSION")="EXT^TGA" ; specify the TGA file extension
 . Q
 S FILEDATA("ABSTRACT")="ABS^STUFFONLY" ; specify the abstract net loc
 ;
 S ERRCODE=$$IMAGE^MAGDIR9B ; create the ^MAG(2005) entry for the image
 I ERRCODE D  ; error - abort image processing
 . D ERROR^MAGDIR8("STORE",ERRCODE,.MSG,$T(+0))
 . Q
 E  D  ; no error
 . S X="0|"_RETURN
 . ; save pname, pid, dob, age, and sex from DEM^VADPT for gateway
 . F I=1:1:5 S X=X_"|"_VADM(I)
 . I $T(GETICN^MPIF001)'="" S X=X_"|"_$$GETICN^MPIF001(DFN) ; save ICN value
 . E  S X=X_"|"  ;P123 - for sites that have not implemented the MPI package
 . D RESULT^MAGDIR8("STORE",X)
 . Q
 Q
 ;
NEWIMAGE() ; processing for a new image
 N ERRORMSG ;- error message causing processing to stop
 N PIDCHECK ;- return value of from $$PIDCHECK^MAGDIR8A()
 ;
 I MAGIEN D  I $L(ERRORMSG) Q ERRORMSG
 . N I,X
 . K MSG S I=0
 . I IMAGEUID=$$GETUID(MACHID) D  ; same image as last one
 . . ; process the image again, after software crash
 . . ; If the software crashed processing the first image, it might
 . . ; delete the image without ever writing it to the file server.
 . . ; Now, the image processing software has a second chance.
 . . S I=I+1,MSG(I)="Reprocessing image """_FROMPATH_""""
 . . S I=I+1,MSG(I)="which is partially in the database (#"_MAGIEN_") for"
 . . D ERROR^MAGDIR8("STORE","1 Image partially in the database",.MSG,$T(+0))
 . . S ERRORMSG="" ; this is not an error!
 . . Q
 . E  D  ; don't accept images with duplicate UIDs
 . . S I=I+1,MSG(I)="Image """_FROMPATH_""""
 . . S I=I+1,MSG(I)="is already in the database (#"_MAGIEN_") for"
 . . S ERRORMSG="-1 Image already in database"
 . . Q
 . S X=$P($G(^MAG(2005,MAGIEN,2)),"^",1)
 . S X=$S(X:$$FMTE^XLFDT(X,1),1:"<no date known>")
 . S I=I+1,MSG(I)=""""_$P($G(^MAG(2005,MAGIEN,0)),"^")_""""
 . S I=I+1,MSG(I)="Entered into VistA database on "_X
 . S I=I+1,MSG(I)="UID = "_IMAGEUID
 . Q
 ;
 D SAVEUID(MACHID,IMAGEUID) ; record the UID of the image being processed
 ;
 ; lookup the study by ACNUMB/CASENUMB, get DFN, and double-check PID
 S ERRCODE=$$LOOKUP Q:ERRCODE ERRCODE
 ;
 S PIDCHECK=$$PIDCHECK^MAGDIR8A()
 I PIDCHECK D  Q "-2 Image Association Problem" ; didn't find the study
 . N CASETEXT,COLUMNS,MFGR,MODEL,MODIEN,OFFSET,ROWS
 . ; formulate error message
 . K MSG
 . S MSG(1)=PIDCHECK
 . S (ROWS,COLUMNS,OFFSET,MODIEN,MFGR,MODEL,CASETEXT)=""
 . I 'IMPORTER D
 . . D MOVE^MAGDLBAA
 . . Q
 . E  D
 . . D STORE^MAGDIR8R ; record miss-matched image
 . . Q
 . Q
 ; create the group pointer
 I IMGSVC="RAD" D  Q:ERRCODE ERRCODE
 . S ERRCODE=$$GROUP^MAGDIR9A
 . Q
 E  I IMGSVC="CON" D  Q:ERRCODE ERRCODE
 . S ERRCODE=$$GROUP^MAGDIR9E
 . Q
 E  D  Q 3  ; undefined imaging service - same as error #4 in LOOKUP
 . K MSG
 . S MSG(1)="Undefined Imaging Service: "_IMGSVC
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . Q
 ; delete import reconciliation entry
 I IMPORTER,$L(OLDPATH) Q $$DELETE^MAGDIR8R(IMAGEUID,MACHID,OLDPATH)
 Q 0
 ;
SAVEUID(MACHID,UID) ; record the UID of the image being processed
 N D0,X
 S D0=$O(^MAGD(2006.5715,"B",MACHID,"")) D:'D0
 . L +^MAGD(2006.5715):1E9 ; Background process MUST wait
 . S D0=$O(^MAGD(2006.5715," "),-1)+1
 . S X=$G(^MAGD(2006.5715,0))
 . S $P(X,"^",1,2)="CURRENT IMAGE^2006.5715"
 . S $P(X,"^",3)=D0
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAGD(2006.5715,0)=X
 . S ^MAGD(2006.5715,D0,0)=MACHID
 . S ^MAGD(2006.5715,"B",MACHID,D0)=""
 . L -^MAGD(2006.5715)
 . Q
 S $P(^MAGD(2006.5715,D0,0),"^",2)=UID
 Q
 ;
GETUID(MACHID) ; lookup the UID of the last image processed
 N D0
 S D0=+$O(^MAGD(2006.5715,"B",MACHID,""))
 Q $P($G(^MAGD(2006.5715,D0,0)),"^",2)
 ;
MULTFRAM ; Handle additional images in a multiframe object
 ; Get the information from the first image for the additional ones
 ;
 N DIQUIET,INAME,MAG0,MAG40,MAG100,MAGPACS
 N SOPCLASP ; pointer to SOP Class file (#2006.532)
 S MAG0=^MAG(2005,MAGIEN,0),MAG1=$G(^(1)),MAG2=$G(^(2))
 S MAG40=$G(^MAG(2005,MAGIEN,40)),MAG100=$G(^(100))
 S MAGPACS=$G(^MAG(2005,MAGIEN,"PACS"))
 S INAME=$P(MAG0,"^",1) ; field .01
 S PNAMEVAH=$P(INAME,"  ",1),DCMPID=$P(INAME,"  ",2)
 S DFN=$P(MAG0,"^",7) ; field 5
 S MAGGP=$P(MAG0,"^",10) ; field 14
 S DATETIME=$P(MAG2,"^",5) ; field 15
 S FILEDATA("MODALITY")=MODALITY
 S FILEDATA("PARENT FILE")=$P(MAG2,"^",6) ; field 16
 S FILEDATA("PARENT IEN")=$P(MAG2,"^",7) ; field 17
 S FILEDATA("PARENT FILE PTR")=$P(MAG2,"^",8) ; field 18
 S FILEDATA("RAD REPORT")=$P(MAGPACS,"^",2) ; field 61
 S FILEDATA("RAD PROC PTR")=$P(MAGPACS,"^",3) ; field 62
 S FILEDATA("PACKAGE")=$P(MAG40,"^",1) ; field 40
 ; field 41 is not needed
 S FILEDATA("TYPE")=$P(MAG40,"^",3) ; field 42
 S FILEDATA("PROC/EVENT")=$P(MAG40,"^",4) ; field 43
 S FILEDATA("SPEC/SUBSPEC")=$P(MAG40,"^",5) ; field 44
 S FILEDATA("ACQUISITION DEVICE")=$P(MAG100,"^",4) ; field 107
 ; get the SOP Class pointer (file 2005, field 251)
 S SOPCLASP=$O(^MAG(2006.532,"B",SOPCLASS,""))
 S FILEDATA("SOP CLASS POINTER")=SOPCLASP
 S PROCDESC=$P(MAG2,"^",4) ; field 10
 ; S X="" F  S X=$O(FILEDATA(X)) Q:X=""  I FILEDATA(X)="" K FILEDATA(X)
 I PROCDESC?.E1" (#".N1")" S PROCDESC=$P(PROCDESC," (#")
 ; lookup patient in VistA database - needed to build VADM array
 S DIQUIET=1 D DEM^VADPT
 Q
 ;
LOOKUP() ; lookup the patient/study using cross-reference
 I IMGSVC="RAD" D
 . D RADLKUP^MAGDIR8A
 . Q
 E  I IMGSVC="CON" D
 . S ACNUMB=CASENUMB
 . D CONLKUP^MAGDIR8A
 . Q
 E  D  Q 4 ; undefined imaging service - same as error #3 in NEWIMAGE
 . K MSG
 . S MSG(1)="Undefined Imaging Service: "_IMGSVC
 . D ERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . Q
 Q 0
