MAGQBIM ;WOIFO/RMP - Import functions ; 18 Jan 2011 4:52 PM
 ;;3.0;IMAGING;**7,20,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
 Q
ENTRY(QP,QUE,QP2,ZN,RES) ;
 N IEN,TRACKID,ASIEN,XX,X,X2,PLACE
 S IEN=$S($P(ZN,U,11)?1N.N:$P(ZN,U,11),1:QP),TRACKID=""
 S ASIEN=$O(^MAG(2006.041,"B",IEN,""))
 I ASIEN?1N.N S TRACKID=$P($G(^MAG(2006.041,ASIEN,0)),U,2)
 I TRACKID']"" D  Q:TRACKID']""
 . D QSTAT^MAGQBTM(QP,"Import De-queue Holding FIVE sec for TrackID.",QUE,.PLACE)
 . S X=$$DT^XLFDT,X2=$$FMADD^XLFDT(X,30)
 . I '$D(^XTMP("MAGQBIM "_X,0)) D
 . . S ^XTMP("MAGQBIM "_X,0)=X2_"^"_X_"^"_"Recording IMPORT Trackid failure"
 . . Q
 . S ^XTMP("MAGQBIM "_X,$$NOW^XLFDT)="Queue ptr: "_QP_U_"De-queue Holding FIVE sec for Station #: ^"_$P(^MAG(2006.1,$P($G(ZN),U,12),0),U,1)
 . H 5
 . S ASIEN=$O(^MAG(2006.041,"B",IEN,"")) ;try setting again after the hang
 . I ASIEN?1N.N S TRACKID=$P($G(^MAG(2006.041,ASIEN,0)),U,2)
 . S RES="-1"_U_QP_U_" Dequeue Failed on TrackId lookup."
 . Q
 S RES=QP_U_TRACKID_U_$TR($P(ZN,U,10),"|",U)_U_IEN
 S $P(RES,U,8)=+$P(ZN,U,9)
 Q
STAT(QP,TIME,MESS) ;
 N STATID,STATIEN
 S STATIEN=$O(^MAG(2006.041,"B",QP,"")),STATID=""
 I STATIEN?1N.N S STATID=$P($G(^MAG(2006.041,STATIEN,0)),U,2)
 Q:STATID']""
 K FDA
 S FDA(2006.041,"+1,",.01)=QP
 S FDA(2006.041,"+1,",.02)=STATID
 S FDA(2006.041,"+1,",1)="BP QUEUE STATUS"
 S FDA(2006.041,"+1,",2)=TIME
 S FDA(2006.041,"+1,",3)=MESS
 D UPDATE^DIE("U","FDA","","MAGIMP")
 Q
TIDL(QP,QUE,RES) ; Tracking ID Lookup - Used for IMPORT Re-Queue
 N ASIEN,TRACKID
 S RES=0,TRACKID=""
 S ASIEN=$O(^MAG(2006.041,"B",QP,""))
 I ASIEN?1N.N S TRACKID=$P($G(^MAG(2006.041,ASIEN,0)),U,2)
 I TRACKID']"" D  Q
 . D QSTAT^MAGQBTM(QP,QUE_"      Requeue Failed on TrackId lookup.",QUE,$$PLACE^MAGBAPI(+$G(DUZ(2))))
 . Q
 S RES=TRACKID
 Q
