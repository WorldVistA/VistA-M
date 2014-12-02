MAGVD010 ;WOIFO/BT,NST,MLH - Delete Study By Accession Number - display outputs ; 11 Apr 2012 4:27 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
STYSERKT(KT,SUBARY) ; count all the studies & series referenced by a subarray node
 Q:SUBARY=""
 N STYARY
 D  ; process matching image indices
 . N MAGIX,STYIX
 . S MAGIX=0 F  S MAGIX=$O(@SUBARY@(MAGIX)) Q:'MAGIX  D
 . . S STYIX=@SUBARY@(MAGIX)
 . . ; old or new structure?
 . . I STYIX="" D OLD(MAGIX,.KT) Q  ; old
 . . I STYIX'="" S STYARY(STYIX)="" Q  ; new
 . . Q
 . Q
 D  ; do counts from new structure
 . S STYIX="" F  S STYIX=$O(STYARY(STYIX)) Q:'STYIX  D NEW(STYIX,.KT)
 . Q
 D  ; do counts from old structure
 . N STYUID,SERUID,MAGIX
 . S STYUID="" F KT=0:1 S STYUID=$O(KT("STUDY",STYUID)) Q:STYUID=""
 . S KT("STUDY")=$G(KT("STUDY"))+KT
 . S SERUID="" F KT=0:1 S SERUID=$O(KT("SERIES",SERUID)) Q:SERUID=""
 . S KT("SERIES")=$G(KT("SERIES"))+KT
 . S MAGIX="" F KT=0:1 S MAGIX=$O(KT("IMAGE",MAGIX)) Q:MAGIX=""
 . S KT("IMAGE")=$G(KT("IMAGE"))+KT
 . Q
 Q
NEW(STYIX,KT) ; new structure - can build counts directly from structure
 Q:'STYIX
 N SERIX
 S KT("STUDY")=$G(KT("STUDY"))+1
 S SERIX=""
 F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . N SOPIX
 . ; If Series deleted don't count - quit
 . Q:$G(^MAGV(2005.63,SERIX,9))'="A"
 . S KT("SERIES")=$G(KT("SERIES"))+1
 . S SOPIX=""
 . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D
 . . ; If SOP deleted don't count - quit
 . . Q:$G(^MAGV(2005.64,SOPIX,11))'="A"
 . . S KT("IMAGE")=$G(KT("IMAGE"))+1
 . . Q
 . Q
 Q
OLD(MAGIX,KT) ; old structure - must build counts from instances
 Q:'$G(MAGIX)
 N PARENT,UID,CHILD,CHILDIX
 I '$D(^MAG(2005,MAGIX,1)) D  Q  ; child
 . S KT("IMAGE",MAGIX)=""
 . S UID=$P($G(^MAG(2005,MAGIX,"SERIESUID")),"^",1) ; series instance UID
 . S:UID'="" KT("SERIES",UID)=""
 . S PARENT=$P($G(^MAG(2005,MAGIX,0)),"^",10)
 . S UID=$P($G(^MAG(2005,PARENT,"PACS")),"^",1) ; study instance UID
 . S:UID'="" KT("STUDY",UID)=""
 . Q
 I $D(^MAG(2005,MAGIX,1)) D  Q  ; parent
 . S UID=$P($G(^MAG(2005,MAGIX,"PACS")),"^",1)
 . S:UID'="" KT("STUDY",UID)="" ; study instance UID
 . S CHILD=0
 . F  S CHILD=$O(^MAG(2005,MAGIX,1,CHILD)) Q:'CHILD  D
 . . S CHILDIX=$P($G(^MAG(2005,MAGIX,1,CHILD,0)),"^",1)
 . . S KT("IMAGE",CHILDIX)=""
 . . S UID=$P($G(^MAG(2005,CHILDIX,"SERIESUID")),"^",1) ; series instance UID
 . . S:UID'="" KT("SERIES",UID)=""
 . . Q
 . Q
 Q
