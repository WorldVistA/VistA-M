MAGQE6 ;WOIFO/OHH - Counts for Remote Image Views ; 01 Jul 2010 4:49 PM
 ;;3.0;IMAGING;**46,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
 ; This routine collects information related to telereader read/unread
 ; list activities and passes it to MAG-Enterprise, so that it will
 ; appear in the monthly reports.
 ;
START(SDATE,EDATE,INST,NMS) ;
 N AA,AI,COUNT,DIVISION,I,IMAGES,M0,OM,WHERE
 ;
 F AA=0,1 F I=1:1:6 S COUNT(AA,I)=0
 S DIVISION=INST_$$GETAI^MAGQE5($$PLACE^MAGBAPI(INST),"^")
 F I=1:1 S AI=$P(DIVISION,"^",I) Q:'AI  D:$D(^MAG(2006.5849,"E",AI))
 . S AA=$O(^MAG(2006.5849,"E",AI,SDATE),-1)
 . F  S AA=$O(^MAG(2006.5849,"E",AI,AA)) Q:'AA  Q:AA>EDATE  D
 . . S OM="" F  S OM=$O(^MAG(2006.5849,"E",AI,AA,OM)) Q:'OM  D
 . . . S M0=^MAG(2006.5849,OM,0) Q:$P(M0,"^",11)'="R"
 . . . S WHERE=$P(M0,"^",16)=$P(M0,"^",2)
 . . . S COUNT(WHERE,1)=COUNT(WHERE,1)+1
 . . . S COUNT(WHERE,2)=COUNT(WHERE,2)+$P(M0,"^",10)
 . . . I $P(M0,"^",18)>0,$P(M0,"^",17)>0 S COUNT(WHERE,3)=COUNT(WHERE,3)+$$FMDIFF^XLFDT($P(M0,"^",18),$P(M0,"^",17),2)
 . . . I $P(M0,"^",18)>0,$P(M0,"^",17)>0 S COUNT(WHERE,4)=COUNT(WHERE,4)+1
 . . . S:$P(M0,"^",17)="" COUNT(WHERE,6)=COUNT(WHERE,6)+1
 . . . I $P(M0,"^",9)>0,$P(M0,"^",7)>0 S COUNT(WHERE,5)=COUNT(WHERE,5)+$$FMDIFF^XLFDT($P(M0,"^",9),$P(M0,"^",7),2)
 . . . Q
 . . Q
 . Q
 ;
 ; Output collected data:
 D:COUNT(1,1)+COUNT(0,1)
 . I NMS'="",$E(NMS,$L(NMS))'=" " S NMS=NMS_" "
 . D MSG^MAGQE2(NMS_"SPECIALITY: 57")
 . D MSG^MAGQE2(NMS_"PROCEDURE: 88")
 . D MSG^MAGQE2(NMS_"LOCAL STUDIES: "_COUNT(1,1))
 . D MSG^MAGQE2(NMS_"REMOTE STUDIES: "_COUNT(0,1))
 . D MSG^MAGQE2(NMS_"LOCAL IMAGES: "_COUNT(1,2))
 . D MSG^MAGQE2(NMS_"REMOTE IMAGES: "_COUNT(0,2))
 . D MSG^MAGQE2(NMS_"LOCAL READING TIME: "_COUNT(1,3))
 . D MSG^MAGQE2(NMS_"REMOTE READING TIME: "_COUNT(0,3))
 . D MSG^MAGQE2(NMS_"RESULTED LOCALLY BY TELEREADER: "_COUNT(1,4))
 . D MSG^MAGQE2(NMS_"RESULTED LOCALLY BY CPRS: "_COUNT(1,6))
 . D MSG^MAGQE2(NMS_"RESULTED REMOTELY BY TELEREADER: "_COUNT(0,4))
 . D MSG^MAGQE2(NMS_"RESULTED REMOTELY BY CPRS: "_COUNT(0,6))
 . D MSG^MAGQE2(NMS_"LOCAL ACQUISITION TIME:  "_COUNT(1,5))
 . D MSG^MAGQE2(NMS_"REMOTE ACQUISITION TIME:  "_COUNT(0,5))
 . Q
 Q 
 ;
GATH(START,STOP,INST) ;Will count the number of entries for remote views
 ;from DOD to VA and VA to DOD
 ;INST=STATION NUMBER 
 N AI,ENTRIES,ENTRY,CNT,J,JJ,RMTYPE,SITE
 Q:'$G(INST)
 K ^TMP($J,"MAG_ACC")
 I '$G(START)!'$G(STOP) D
 . S STOP=$$FMADD^XLFDT($$NOW^XLFDT()\100_"01",-1)
 . S START=STOP\100_"01"
 Q:'STOP
 Q:'START
 S SITE=$O(^MAG(2006.1,"B",INST,0))
 S I=START F  S I=$O(^MAG(2006.95,"C",SITE,I)) Q:'I!(I>STOP)  S ENTRY=0 D
 . F  S ENTRY=$O(^MAG(2006.95,"C",SITE,I,ENTRY)) Q:'ENTRY  D 
 . . I $D(^MAG(2006.95,ENTRY,0)) S RMTYPE=$P(^MAG(2006.95,ENTRY,0),"^",2)
 . . I RMTYPE]"" D
 . . . I '$D(^TMP($J,"MAG_ACC",RMTYPE)) S ^TMP($J,"MAG_ACC",RMTYPE)=0
 . . . S $P(^TMP($J,"MAG_ACC",RMTYPE),"^")=$P(^TMP($J,"MAG_ACC",RMTYPE),"^")+1
 . . . Q
 . . Q
 . Q
 S J="" F  S J=$O(^TMP($J,"MAG_ACC",J)) Q:J=""   D MSG^MAGQE2("ACCESS TYPE("_J_"): "_$G(^TMP($J,"MAG_ACC",J)))
 K ^TMP($J,"MAG_ACC")
 Q
