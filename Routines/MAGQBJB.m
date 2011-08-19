MAGQBJB ;WOIFO/PMK/RMP - Get an image file to copy to the JukeBox ; 18 Jan 2011 4:55 PM
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
 Q
ENTRY(RESULT,QPTR) ; entry point from ^MAGQBTM
 ; RESULT=STATUS^IMAGE PTR^FROM FILE^TO FILE^JUKEBOX DEVICE^
 ;   QUEUE PTR^JUKEBOX-NETWORK LOC PTR^QSN^Abstract^BIG
 ; QSN=QUEUE SEQUENCE NUMBER
 N IMGPTR,L,JBDEVICE,FILENAME,FILE,X,JBPTR,SUBDIR
 N MAGFILE,MAGXX,MAGSTORE,MAGFILE2,PERCENT,SIZERTN,MAGDEV,SRCE
 N TOFILE,TOTAL,QNODE,QSN,ZNODE,BNODE,FULL,ABS,BIG,MSG,PLACE,AGG
 S U="^",QNODE=$G(^MAGQUEUE(2006.03,QPTR,0)),(ZNODE,FULL,ABS,BIG,JBPTR,AGG)=""
 S IMGPTR=$P(QNODE,U,7),QSN=+$P(QNODE,U,9),PLACE=$P(QNODE,U,12)
 I $D(^MAG(2005,IMGPTR,0)) D
 . S ZNODE=$G(^MAG(2005,IMGPTR,0))
 . S BNODE=$G(^MAG(2005,IMGPTR,"FBIG"))
 . Q
 E  I $D(^MAG(2005.1,IMGPTR,0)) D
 . S ZNODE=$G(^MAG(2005.1,IMGPTR,0))
 . S BNODE=$G(^MAG(2005.1,IMGPTR,"FBIG"))
 . Q
 I ZNODE="" D  Q  ;RESULT ;!!!!
 . S RESULT="-101^"_QPTR_"^MAG Global Node #"_IMGPTR_" not present"
 S FILE=$P(ZNODE,U,2)
 I FILE="" D  Q  ;RESULT ;!!!
 . I +$P($G(^MAG(2005,IMGPTR,1,0)),U,4)>0 D
 . . S MSG="Image group parent"
 . E  S MSG="Does not have an image file specified"
 . S RESULT="-5"_U_QPTR_U_MSG
 ; Establish the current Jukebox location
 S JBPTR=$$JBPTR^MAGBAPI($$PLACE^MAGBAPI(+$G(DUZ(2))))
 I 'JBPTR D  Q
 . S RESULT="-4"_U_QPTR_U_"The Jukebox Network Location is not set"
 I $P(^MAG(2005.2,JBPTR,0),"^",6)'="1" D  Q
 . S RESULT="-4"_U_QPTR_U_"Jukebox Network Location "_$P(^MAG(2005.2,JBPTR,0),"^",1)_" is set Offline"
 S JBDEVICE=$$JBDEV(JBPTR)
 ; If the current Jukebox write location differs from the FULL/ABstract Worm or the BIG Worm then aggregate
 S AGG=$S($P(ZNODE,U,5)&($P(ZNODE,U,5)'=JBPTR):1,$P(BNODE,U,2)&($P(BNODE,U,2)'=JBPTR):1,1:"")
 ; Check for FULL
 S SRCE=$S($$SLINE(+$P(ZNODE,U,3)):$P(ZNODE,U,3),1:"")
 I 'SRCE,AGG S SRCE=$S($$SLINE(+$P(ZNODE,U,5)):$P(ZNODE,U,5),1:"")
 I SRCE D 
 . S MAGDEV=$P(^MAG(2005.2,SRCE,0),U,2),FULL=MAGDEV_$$DIRHASH^MAGFILEB(FILE,SRCE)_FILE Q 
 ; Check for Abstract
 S SRCE=$S($$SLINE(+$P(ZNODE,U,4)):$P(ZNODE,U,4),1:"")
 I 'SRCE,AGG S SRCE=$S($$SLINE(+$P(ZNODE,U,5)):$P(ZNODE,U,5),1:"")
 I SRCE D 
 . S MAGDEV=$P(^MAG(2005.2,SRCE,0),U,2),ABS=MAGDEV_$$DIRHASH^MAGFILEB(FILE,SRCE)_$P(FILE,".")_".ABS" Q 
 ; Check for Big
 S SRCE=$S($$SLINE(+$P(BNODE,U,1)):$P(BNODE,U,1),1:"")
 I 'SRCE,AGG S SRCE=$S($$SLINE(+$P(BNODE,U,2)):$P(BNODE,U,2),1:"")
 I SRCE D  ; Including logic for P99 alternative BIG file extension.
 . S MAGDEV=$P(^MAG(2005.2,SRCE,0),U,2)
 . S BIG=MAGDEV_$$DIRHASH^MAGFILEB(FILE,SRCE)_$P(FILE,".")_"."_$S($P(BNODE,U,3)="":"BIG",1:$P(BNODE,U,3))
 . Q 
 I FULL="",BIG="",ABS="" D  Q
 . S MSG=$S(('$P(BNODE,U))&('$P(ZNODE,U,4))&('$P(ZNODE,U,4)):"No VistA Cache Source",1:"")
 . S MSG=$S('MSG:"There are no network location references for this image: "_FILE,1:MSG)
 . S RESULT="-11^"_QPTR_"^"_MSG
 . Q
 K MAGFILE1
 S TOFILE=$$WPATH(FILE,JBPTR)_FILE
 S RESULT="1^"_IMGPTR_U_FULL_U_TOFILE_U
 S RESULT=RESULT_JBDEVICE_U_QPTR_U_JBPTR_U_QSN_U_ABS_U_BIG
 Q
WPATH(FILE,CWP) ; Write path of Current Write Platter (CWP)
 Q $P(^MAG(2005.2,CWP,0),"^",2)_$$DIRHASH^MAGFILEB(FILE,CWP)
JBDEV(JBPTR) ; Jukebox Device (drive spec)
 Q $P($G(^MAG(2005.2,JBPTR,0)),"^",2)
SLINE(PTR) ;Check if the share is online
 Q:PTR<1 ""
 Q $S($P($G(^MAG(2005.2,PTR,0)),U,6)=1:1,1:"")
