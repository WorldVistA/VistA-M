MAGQBJH ;WOIFO/PMK/RMP - Copy an image from the Jukebox to the Hard Disk ; 18 Jan 2011 4:57 PM
 ;;3.0;IMAGING;**8,20,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
 ; RESULT=STATUS^MAGIFN^FROMPATH^TOPATH^FILETYPE^QPTR^VWP^QSN
 ; VWP = VISTA WRITE-LOCATION POINTER, QSN=QUEUE SEQUENCE NUMBER
ENTRY(RESULT,QPTR) ; entry point from ^MAGBMAIN
 N NODE,X,MAGIFN,FILETYPE,MAGXX,STATUS,TODAY,MAGPIECE,MAGREF,MSG
 N FROMPATH,TOPATH,MAGFILE,MAGFILE2,QSN,MSG,PLACE
 S U="^",NODE=^MAGQUEUE(2006.03,QPTR,0),QSN=+$P(NODE,U,9)
 S PLACE=$P(NODE,U,12)
 I "^JBTOHD^PREFET^"'[(U_$P(NODE,U)_U) D  Q
 . S RESULT="-4"_U_QPTR_U_"Not a Jukebox to HardDisk Process"
 S MAGIFN=$P(NODE,U,7),FILETYPE=$P(NODE,U,8)
 S TODAY=$P($$NOW^XLFDT,".",1)
 I "^FULL^ABSTRACT^BIG^"'[("^"_FILETYPE_"^") D  Q
 . S RESULT="-4"_U_QPTR_U_FILETYPE_" Is not a Jukebox to HardDisk Process"
 I $P(^MAG(2005,MAGIFN,0),U,2)="" D  Q
 . I +$P($G(^MAG(2005,MAGIFN,1,0)),U,4)>0 S MSG="Image group parent"
 . E  S MSG="Does not have an image file specified"
 . S RESULT="-5"_U_QPTR_U_MSG
 . K ^MAGQUEUE(2006.03,"F",PLACE,MAGIFN,FILETYPE,QPTR)
 . Q
 D @(FILETYPE_"(PLACE)") ; do either FULL or ABSTRACT
 K ^MAGQUEUE(2006.03,"F",PLACE,MAGIFN,FILETYPE,QPTR)
 K MAGFILE1
 S RESULT=STATUS
 S $P(RESULT,U,8)=QSN
 Q
FULL(PLACE) ; copy a full-size image
 S MAGXX=MAGIFN D VSTNOCP^MAGFILEB
 I (($E(MAGFILE1,1,2)="-1")!('$P(^MAG(2005,MAGIFN,0),"^",5))) D  Q 
 . S STATUS="-3"_U_QPTR_U_"Image IEN:"_MAGIFN_"has no file online"
 S MAGREF=$P(^MAG(2005,MAGIFN,0),"^",3)
 I MAGREF?1N.N D WLSET(.STATUS,MAGIFN,MAGREF,"FULL",PLACE) Q
 S STATUS=$$COPY(PLACE) I +STATUS>0 D  ;
 . S $P(^MAG(2005,MAGIFN,0),"^",9)=TODAY ; update the last access date
 Q 
 ;
ABSTRACT(PLACE) ; copy an image abstract
 S MAGXX=MAGIFN D ABSNOCP^MAGFILEB
 I (($E(MAGFILE1,1,2)="-1")!('$P(^MAG(2005,MAGIFN,0),"^",5))) D  Q
 . S STATUS="-3"_U_QPTR_U_"Image IEN:"_MAGIFN_"has no file online"
 S MAGREF=$P(^MAG(2005,MAGIFN,0),"^",4)
 I MAGREF?1N.N D WLSET(.STATUS,MAGIFN,MAGREF,"ABSTRACT",PLACE) Q
 S STATUS=$$COPY(PLACE) I +STATUS>0 D  ;
 . S $P(^MAG(2005,MAGIFN,0),"^",9)=TODAY ; update the last access date
 Q 
 ;
BIG(PLACE) ; copy a big image
 S MAGXX=MAGIFN D BIGNOCP^MAGFILEB
 I (($E(MAGFILE1,1,2)="-1")!('$P($G(^MAG(2005,MAGIFN,"FBIG")),U,2))) D  Q
 . S STATUS="-3"_U_QPTR_U_"Image IEN:"_MAGIFN_"has no file online"
 S MAGREF=$P(^MAG(2005,MAGIFN,"FBIG"),U)
 I MAGREF?1N.N D WLSET(.STATUS,MAGIFN,MAGREF,"BIG",PLACE) Q
 S STATUS=$$COPY(PLACE) I +STATUS>0 D  ;
 . S $P(^MAG(2005,MAGIFN,0),"^",9)=TODAY ; update the last access date
 Q 
 ;
WLSET(STATUS,MAGIFN,MAGREF,TYPE,PLACE) ;Write Location set already
 N JBREF,JBPATH,CWL,SOURCE,DEST,ALTDEST,ONLINE,PATH
 S $P(^MAG(2005,MAGIFN,0),U,9)=TODAY ; update the last access date
 ; output the warning message
 S JBREF=$S(TYPE="BIG":$P($G(^MAG(2005,MAGIFN,"FBIG")),U,2),1:$P(^MAG(2005,MAGIFN,0),U,5))
 S JBPATH=$P(^MAG(2005.2,JBREF,0),U,2)
 S JBPATH=JBPATH_$$DIRHASH^MAGFILEB(MAGFILE1,JBREF)
 S CWL=$$CWL^MAGBAPI(PLACE)
 S SOURCE=JBPATH_MAGFILE1
 S ONLINE=$P(^MAG(2005.2,MAGREF,0),U,6)
 ;If the current magnetic write location is on line the first
 ;destination path will be to that path and the 2nd path is the 
 ;current write location
 S PATH=$P(^MAG(2005.2,$S(ONLINE:MAGREF,1:CWL),0),U,2)
 S DEST=PATH_$$DIRHASH^MAGFILEB(MAGFILE1,$S(ONLINE:MAGREF,1:CWL))_MAGFILE1
 S:ONLINE ALTDEST=$P(^MAG(2005.2,CWL,0),U,2)_$$DIRHASH^MAGFILEB(MAGFILE1,CWL)_MAGFILE1
 S STATUS="2^"_MAGIFN_U_SOURCE_U_DEST
 S STATUS=STATUS_U_FILETYPE_U_QPTR_U_$S(ONLINE:MAGREF,1:CWL)_U_QSN
 S:ONLINE STATUS=STATUS_U_ALTDEST_U_CWL
 Q
 ;
COPY(PLACE) ; copy an image file from the jukebox to the hard drive
 N MAGREF,MAGDRIVE
 D GETDRIVE(.MAGDRIVE,.MAGREF,PLACE) ;^MAGFILE ; find space to put file
 I MAGREF'?1N.N Q "-4^"_QPTR_"^Current Write Location is not SET"
 I +$P($G(^MAG(2005.2,MAGREF,0)),"^",6)'>0 Q "-4^"_QPTR_"^Current Write Location is OFFLINE"
 S TOPATH=MAGDRIVE_$$DIRHASH^MAGFILEB(MAGFILE1,MAGREF)_MAGFILE1
 S FROMPATH=MAGFILE2
 Q "1"_U_MAGIFN_U_FROMPATH_U_TOPATH_U_FILETYPE_U_QPTR_U_MAGREF
GETDRIVE(DRIVE,MAGREF,PLACE) ; Get the current drive for writing an image
 S MAGREF=$$CWL^MAGBAPI(PLACE)
 S DRIVE=$S('MAGREF:"",1:$P(^MAG(2005.2,MAGREF,0),U,2))
 Q
 ;
