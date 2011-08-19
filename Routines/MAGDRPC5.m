MAGDRPC5 ;WOIFO/EdM - Routing RPCs ; 06/08/2007 10:12
 ;;3.0;IMAGING;**11,30,51,85,54**;03-July-2009;;Build 1424
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
START(OUT,LOCATION,RULES) ; RPC = MAG DICOM ROUTE EVAL START
 N I,LOC,X,ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 ;
 D XTINIT
 ;
 I '$G(LOCATION) S OUT="-1,No Location Specified" Q
 I '$O(RULES("")) S OUT="-2,No Routing Rules Specified" Q
 ;
 S LOC=$$GET1^DIQ(4,LOCATION,.01)
 L +^MAGDICOM(2006.563,1,"EVAL",LOCATION):0 E  D  Q
 . S OUT="-3,A Rule Evaluator is Already Running for "_LOC
 . Q
 ;
 S ^MAGDICOM(2006.563,1,"EVAL")=1
 S ZTRTN="EVAL^MAGBRTE4"
 S ZTDESC="Evaluate Routing Rules for Origin="_LOC
 S ZTDTH=$H
 S ZTSAVE("LOCATION")=LOCATION
 S I="" F  S I=$O(RULES(I)) Q:I=""  S:+I=I ZTSAVE("RULES("_I_")")=RULES(I)
 D ^%ZTLOAD,HOME^%ZIS
 L -^MAGDICOM(2006.563,1,"EVAL",LOCATION)
 I '$D(ZTSK) S OUT="-4,TaskMan did not Accept Request" Q
 S OUT="0,TaskMan task#="_ZTSK
 Q
 ;
STOP(OUT) ; RPC = MAG DICOM ROUTE EVAL STOP
 S ^MAGDICOM(2006.563,1,"EVAL")=0,OUT=1
 Q
 ;
XMIT(OUT,LOCATION,DEST,PRIOR,MECH,DESTS) ; RPC = MAG DICOM ROUTE NEXT FILE
 N D0,DIR,DL,IM,M,NOW,OK,PLACE,TP,VP,X
 ;
 S PLACE=$$PLACE^MAGDRPC2(LOCATION)
 S $P(^MAG(2006.1,PLACE,"LASTROUTE"),"^",1)=DT
 ;
 K OUT S OUT(1)=0,OK=0
 S:'$G(MECH) MECH=1 I MECH'=1,MECH'=2 S MECH=1
 I '$G(LOCATION) S OUT(1)="-1,No Location Specified" Q
 S VP(1)=";MAG(2005.2,"
 S VP(2)=";MAG(2006.587,"
 S:$G(DEST) DEST=+DEST_VP(MECH)
 S M="" F  S M=$O(DESTS(M)) Q:M=""  D
 . S X=DESTS(M) Q:X'["^"  Q:$P(X,"^",1)'=MECH  Q:'$P(X,"^",2)
 . S DL($P(X,"^",2)_VP(MECH))=""
 . Q
 I $O(DL(""))="" S OUT(1)="-2,No Valid Destinations Specified" Q
 S:'$G(DEST) (PRIOR,DEST)=""
 I $G(PRIOR) D
 . I DEST S X=0 F  D  Q:X
 . . N NXT
 . . I $P($G(^MAG(2005.2,+DEST,0)),"^",6) S X=1 Q
 . . S NOW=$$NOW^XLFDT()*1E6
 . . S X=$P($G(^MAG(2005.2,+DEST,3)),"^",6)*1E6
 . . I NOW-X>1500 D ONOFLINE(.X,+DEST,1) Q
 . . S X=0,NXT=0
 . . F  S DEST=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRIOR,DEST)) Q:DEST=""  D  Q:NXT
 . . . S:$D(DL(DEST)) NXT=1
 . . . Q
 . . S:'DEST X=1
 . . Q
 . I 'DEST S (PRIOR,DEST)="" Q
 . F  D  Q:OK
 . . S D0=+$G(D0)
 . . S D0=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRIOR,DEST,D0))
 . . I 'D0 S OK=1 Q
 . . S M=$P($G(^MAGQUEUE(2006.035,D0,0)),"^",4) I M'=1,M'=2 S M=1
 . . I M=MECH S OK=1 Q
 . . S (PRIOR,DEST)=""
 . . Q
 . Q
 I OK D:$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRIOR))
 . ;
 . ; Ignore higher priority items for destinations that are not accessible
 . ;
 . N A,D,P,T,X
 . S P=PRIOR F  S P=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",P)) Q:'P  D  Q:'PRIOR
 . . S D="" F  S D=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",P,D)) Q:D=""  D  Q:'PRIOR
 . . . ; Interrupt only if we're transmitting there
 . . . Q:'$D(DL(D))
 . . . ;
 . . . D:'$P(^MAG(2005.2,+D,0),"^",6)
 . . . . S NOW=$$NOW^XLFDT()*1E6
 . . . . S X=$P($G(^MAG(2005.2,+D,3)),"^",6)*1E6 Q:NOW-X<1500
 . . . . D ONOFLINE(.X,+D,1)
 . . . . Q
 . . . S:$P(^MAG(2005.2,+D,0),"^",6) PRIOR=0
 . . . Q
 . . Q
 . Q
 I '$G(PRIOR) F  D  Q:OK  Q:'PRIOR
 . S PRIOR=" " F  S PRIOR=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRIOR),-1) Q:'PRIOR  D  Q:OK
 . . S DEST="" F  S DEST=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRIOR,DEST)) Q:DEST=""  D:$D(DL(DEST))  Q:OK
 . . . D:'$P(^MAG(2005.2,+DEST,0),"^",6)
 . . . . S NOW=$$NOW^XLFDT()*1E6
 . . . . S X=$P($G(^MAG(2005.2,+DEST,3)),"^",6)*1E6 Q:NOW-X<1500
 . . . . D ONOFLINE(.X,+DEST,1)
 . . . . Q
 . . . Q:'$P(^MAG(2005.2,+DEST,0),"^",6)
 . . . S D0="" F  S D0=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRIOR,DEST,D0)) Q:D0=""  D  Q:OK
 . . . . S M=$P($G(^MAGQUEUE(2006.035,D0,0)),"^",4) I M'=1,M'=2 S M=1
 . . . . I M=MECH S OK=1 Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q:'PRIOR
 Q:'OK
 I 'D0 S OUT(1)=0 Q  ; All files transmitted
 ;
 S X=^MAGQUEUE(2006.035,D0,0),IM=$P(X,"^",1),TP=$P(X,"^",3)
 I 'IM D STATUS(X,D0,"SENT",LOCATION) S OUT(1)=2 Q
 S OUT(2)=+DEST,OUT(3)=PRIOR,OUT(4)=MECH,OUT(9)=D0
 S X=$G(^MAG(2005.2,+DEST,2)),OUT(5)=$P(X,"^",1),OUT(6)=$P(X,"^",2)
 D STATUS(X,D0,"SENDING",LOCATION)
 S OUT(10)=$P(^MAG(2005.2,+DEST,0),"^",2)
 S DIR=$P($G(^MAG(2005.2,+DEST,4)),"^",2)
 S OUT(11)=$G(^MAG(2005.2,+DEST,3))
 S OUT(12)=IM
 S OUT(13)=$P($G(^MAGQUEUE(2006.035,D0,1)),"^",3)
 S OUT(14)=$P($G(^MAG(2005.2,+DEST,1)),"^",7) S:OUT(14)="" OUT(14)="NONE"
 D XMIT^MAGDRPC6 ; Routine grew over 10,000 characters
 I MECH=2 S OUT(2)=OUT(2)_"^"_$P($G(^MAG(2006.587,+DEST,0)),"^",1)
 Q
 ;
PURGE(OUT,LOCATION,DEST,MAX,DONE) ; RPC = MAG DICOM ROUTE GET PURGE
 N D0,D1,FILE,FMFILE,I,LIMIT,MORE,NOW,RETAIN,STAMP,STATUS,X
 ;
 S NOW=$$NOW^XLFDT()
 K OUT S OUT(1)=1
 S:$D(^MAG(2005.2,DEST,0)) $P(^MAG(2005.2,DEST,3),"^",4)=DT
 S X=^MAG(2005.2,DEST,3)
 S RETAIN=$P(X,"^",1) S:RETAIN="" RETAIN=32 S:RETAIN<0 RETAIN=0
 S LIMIT=$H-RETAIN
 ;
 S X=$G(DONE(1)),MORE="" S:$E(X,1)="^" MORE=$P(X,"^",4,6)
 ;
 S I="" F  S I=$O(DONE(I)) Q:I=""  D
 . N D41,D61
 . S X=$G(DONE(I))
 . S D0=$P(X,"^",2),D41=$P(X,"^",3)
 . S STAMP=$P(X,"^",4)
 . Q:'D0  Q:'D41
 . ; Just in case the image is being deleted as this purge is taking place
 . F FMFILE=2005,2005.1 D
 . . K ^MAG(FMFILE,"ROUTE",DEST,STAMP,D0,D41)
 . . S D61=$P($G(^MAG(FMFILE,D0,4,D41,0)),"^",7)
 . . K ^MAG(FMFILE,D0,4,"LOC",DEST,D41)
 . . K ^MAG(FMFILE,D0,4,D41,0)
 . . S:D61 $P(^MAG(FMFILE,D0,6,D61,0),"^",5)=NOW
 . . Q
 . S MORE=""
 . Q
 ;
 S LIMIT=$$HTFM^XLFDT(LIMIT,1)
 ;
 S MAX=$G(MAX) S:MAX<1 MAX=100
 F FMFILE=2005,2005.1 D  Q:OUT(1)'<MAX
 . S STAMP="" F  S STAMP=$O(^MAG(FMFILE,"ROUTE",DEST,STAMP)) Q:STAMP=""  Q:STAMP'<LIMIT  D  Q:OUT(1)'<MAX
 . . S D0="" F  S D0=$O(^MAG(FMFILE,"ROUTE",DEST,STAMP,D0)) Q:D0=""  D  Q:OUT(1)'<MAX
 . . . S D1="" F  S D1=$O(^MAG(FMFILE,"ROUTE",DEST,STAMP,D0,D1)) Q:D1=""  D  Q:OUT(1)'<MAX
 . . . . I MORE'="",FMFILE_"^"_D0_"^"_D1'=MORE Q
 . . . . S MORE=""
 . . . . S FILE=$P($G(^MAG(FMFILE,D0,4,D1,0)),"^",4),STATUS=0
 . . . . S:FILE="" FILE=$P($G(^MAG(2005.1,D0,4,D1,0)),"^",4)
 . . . . I FILE="" D  Q
 . . . . . K ^MAG(FMFILE,"ROUTE",DEST,STAMP,D0,D1)
 . . . . . K ^MAG(FMFILE,D0,4,"LOC",DEST,D1)
 . . . . . K ^MAG(FMFILE,D0,4,D1,0)
 . . . . . Q
 . . . . S OUT(1)=OUT(1)+1,OUT(OUT(1))=FMFILE_"^"_D0_"^"_D1_"^"_STAMP_"^"_FILE
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
STATUS(OUT,D0,STATUS,LOCATION) ; RPC = MAG DICOM ROUTE STATUS
 ; D0 ------- Internal Entry Number of Send Queue Entry
 ; STATUS --- New Status
 N DEST ;---- Internal Entry Number of destination
 N IMAGE ;--- Internal Entry Number of image
 N OLD ;----- Old Status Value
 N ORIGIN ;-- Origin of image
 N PRIOR ;--- Priority
 N TYPE ;---- File Type (Big, Text, DICOM, etc)
 N X0,X1 ;--- Queue data
 ;
 I '$G(D0) S OUT="-1,Invalid queue identifier: """_$G(D0)_"""." Q
 ;
 S X0=$G(^MAGQUEUE(2006.035,D0,0))
 S X1=$G(^MAGQUEUE(2006.035,D0,1))
 S OUT=0
 ;
 S DEST=$P(X0,"^",2) Q:DEST=""
 S PRIOR=$P(X1,"^",2) Q:PRIOR=""
 S ORIGIN=$P(X0,"^",5)
 S:'ORIGIN ORIGIN=$G(LOCATION) Q:'ORIGIN
 S OLD=$P(X1,"^",1),IMAGE=$P(X0,"^",1),TYPE=$P(X0,"^",3)
 ;
 K:OLD'="" ^MAGQUEUE(2006.035,"DEST",DEST,OLD,IMAGE,TYPE,D0)
 K:OLD'="" ^MAGQUEUE(2006.035,"STS",ORIGIN,OLD,PRIOR,DEST,D0)
 Q:STATUS=""
 S $P(^MAGQUEUE(2006.035,D0,0),"^",5)=ORIGIN
 S $P(^MAGQUEUE(2006.035,D0,1),"^",1)=STATUS
 S ^MAGQUEUE(2006.035,"DEST",DEST,STATUS,IMAGE,TYPE,D0)=""
 S ^MAGQUEUE(2006.035,"STS",ORIGIN,STATUS,PRIOR,DEST,D0)=""
 S OUT=1
 Q
 ;
LISTDEST(OUT,LOCATION) ; RPC = MAG DICOM ROUTE LIST DESTI
 N D0,F,I,X
 ; Return list of possible routing destinations
 K OUT
 S I=1,D0=0 F  S D0=$O(^MAG(2005.2,D0)) Q:'D0  D
 . S X=$G(^MAG(2005.2,D0,0)) Q:'$P(X,"^",9)
 . L +^MAGQUEUE("ROUTE",LOCATION,D0):0 S F='$T
 . L:'F -^MAGQUEUE("ROUTE",LOCATION,D0)
 . S I=I+1,OUT(I)=D0_"^"_F_"^"_$P(X,"^",1,2)
 . Q
 S OUT(1)=I-1
 Q
 ;
LOCK(OUT,D0,LOCATION,PLUSMIN) ; RPC = MAG DICOM ROUTE LOCK TRANSMIT
 S OUT=0
 I $G(PLUSMIN) L +^MAGQUEUE("ROUTE",LOCATION,D0):0 S OUT=$T Q
 L -^MAGQUEUE("ROUTE",LOCATION,D0) S OUT=2
 Q
 ;
ONOFLINE(OUT,DEST,STATUS) ; RPC = MAG DICOM NETWORK STATUS
 N NET
 I '$G(DEST) S OUT="-1,No Network Location Specified" Q
 S STATUS=''$G(STATUS)
 S NET=$P($G(^MAG(2005.2,DEST,0)),"^",2)
 K ^MAG(2005.2,"C",NET,0,DEST)
 K ^MAG(2005.2,"C",NET,1,DEST)
 S ^MAG(2005.2,"C",NET,STATUS,DEST)=""
 S $P(^MAG(2005.2,DEST,0),"^",6)=STATUS
 S $P(^MAG(2005.2,DEST,3),"^",6)=$S(STATUS:"",1:$$NOW^XLFDT())
 S OUT=1
 Q
 ;
XTINIT N NODE
 D DT^DICRW
 F NODE="MAGEVAL","MAGEVALSTUDY" D
 . S X=$G(^XTMP(NODE,0))
 . S $P(X,"^",2)=DT
 . S $P(X,"^",3)="Routing Rule Evaluator Log - Can be purged at any time"
 . S ^XTMP(NODE,0)=X
 . Q
 Q
 ;
