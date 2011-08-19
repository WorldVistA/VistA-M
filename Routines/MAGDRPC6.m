MAGDRPC6 ;WOIFO/EdM - Routing RPCs ; 05/18/2007 11:23
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
 Q
 ;
PURGDONE(OUT,DAYS,LOCATION) ; RPC = MAG DICOM ROUTE PURGE DONE
 ; Purge Entries from Queue that have been sent successfully
 N D0,DE,ID,IM,LIM,PR,RT,STS,TP,TX,X
 I '$G(LOCATION) S OUT="-1,No Location Specified" Q
 ;
 S OUT=0
 F STS="SENT","NOT FOUND" D
 . S PR="" F  S PR=$O(^MAGQUEUE(2006.035,"STS",LOCATION,STS,PR)) Q:PR=""  D
 . . S DE="" F  S DE=$O(^MAGQUEUE(2006.035,"STS",LOCATION,STS,PR,DE)) Q:DE=""  D
 . . . S RT=$P($G(^MAG(2005.2,DE,3)),"^",1) S:'RT RT=31
 . . . S:$G(DAYS)'<1 RT=DAYS
 . . . S LIM=$H-RT
 . . . S D0="" F  S D0=$O(^MAGQUEUE(2006.035,"STS",LOCATION,STS,PR,DE,D0)) Q:D0=""  D
 . . . . Q:$$FMTH^XLFDT($P($G(^MAGQUEUE(2006.035,D0,1)),"^",4)\1)'<LIM
 . . . . S X=$G(^MAGQUEUE(2006.035,D0,0)),IM=$P(X,"^",1),TP=$P(X,"^",3),ID=$P(X,"^",6)
 . . . . K ^MAGQUEUE(2006.035,"STS",LOCATION,STS,PR,DE,D0)
 . . . . K:ID'="" ^MAGQUEUE(2006.035,"ID",ID,D0)
 . . . . I IM'="",TP'="" K ^MAGQUEUE(2006.035,"DEST",DE,STS,IM,TP,D0)
 . . . . K ^MAGQUEUE(2006.035,D0)
 . . . . S OUT=OUT+1
 . . . . Q
 . . . Q
 . . Q
 . S DE="" F  S DE=$O(^MAGQUEUE(2006.035,"DEST",DE)) Q:DE=""  D
 . . S IM="" F  S IM=$O(^MAGQUEUE(2006.035,"DEST",DE,STS,IM)) Q:IM=""  D
 . . . S TP="" F  S TP=$O(^MAGQUEUE(2006.035,"DEST",DE,STS,IM,TP)) Q:TP=""  D
 . . . . S D0="" F  S D0=$O(^MAGQUEUE(2006.035,"DEST",DE,STS,IM,TP,D0)) Q:D0=""  D
 . . . . . S PR=$P($G(^MAGQUEUE(2006.035,D0,1)),"^",2)
 . . . . . S ID=$P($G(^MAGQUEUE(2006.035,D0,0)),"^",6)
 . . . . . K ^MAGQUEUE(2006.035,D0)
 . . . . . K:ID'="" ^MAGQUEUE(2006.035,"ID",ID,D0)
 . . . . . K ^MAGQUEUE(2006.035,"DEST",DE,STS,IM,TP,D0)
 . . . . . K:PR'="" ^MAGQUEUE(2006.035,"STS",LOCATION,STS,PR,DE,D0)
 . . . . . S OUT=OUT+1
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 S D0=0 F  S D0=$O(^MAGQUEUE(2006.035,D0)) Q:'D0  D
 . S X=$P($G(^MAGQUEUE(2006.035,D0,1)),"^",1) I X'="SENT",X'="NOT FOUND" Q
 . S ID=$P($G(^MAGQUEUE(2006.035,D0,0)),"^",6)
 . K ^MAGQUEUE(2006.035,D0)
 . K:ID'="" ^MAGQUEUE(2006.035,"ID",ID,D0)
 . S OUT=OUT+1
 . Q
 Q
 ;
REQUEUE(OUT,LOCATION) ; RPC = MAG DICOM ROUTE REQUEUE
 ; ReQueue Files that Failed during transmission
 N D0,DE,FL,IM,PR,TP,WW,X
 I '$G(LOCATION) S OUT="-1,No Location Specified" Q
 ;
 S WW="WAITING",OUT=0
 F FL="FAILED","SENDING" D
 . S PR="" F  S PR=$O(^MAGQUEUE(2006.035,"STS",LOCATION,FL,PR)) Q:PR=""  D
 . . S DE="" F  S DE=$O(^MAGQUEUE(2006.035,"STS",LOCATION,FL,PR,DE)) Q:DE=""  D
 . . . S D0="" F  S D0=$O(^MAGQUEUE(2006.035,"STS",LOCATION,FL,PR,DE,D0)) Q:D0=""  D
 . . . . K ^MAGQUEUE(2006.035,"STS",LOCATION,FL,PR,DE,D0)
 . . . . I '$D(^MAGQUEUE(2006.035,D0,0)) K ^MAGQUEUE(2006.035,D0) Q
 . . . . S $P(^MAGQUEUE(2006.035,D0,1),"^",1)=WW
 . . . . S ^MAGQUEUE(2006.035,"STS",LOCATION,WW,PR,DE,D0)=""
 . . . . S X=^MAGQUEUE(2006.035,D0,0),IM=$P(X,"^",1),TP=$P(X,"^",3)
 . . . . I IM'="",TP'="" K ^MAGQUEUE(2006.035,"DEST",DE,FL,IM,TP,D0)
 . . . . I IM'="",TP'="" S ^MAGQUEUE(2006.035,"DEST",DE,WW,IM,TP,D0)=""
 . . . . S OUT=OUT+1
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
REMOBSO(OUT,UPTO,LOCATION) ; RPC = MAG DICOM ROUTE REMOVE OBSO
 ; Purge Unprocessed entries requested before a certain date
 N D0,DE,ID,IM,N,PRI,RDT,ST,TY
 I '$G(LOCATION) S OUT="-1,No Location Specified" Q
 ;
 S OUT=0
 S PRI="" F  S PRI=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI)) Q:PRI=""  D
 . S DE="" F  S DE=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI,DE)) Q:DE=""  D
 . . S D0="" F  S D0=$O(^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI,DE,D0)) Q:D0=""  D  Q:'D0
 . . . S X=$G(^MAGQUEUE(2006.035,D0,0)),IM=$P(X,"^",1),TY=$P(X,"^",3),ID=$P(X,"^",6)
 . . . S X=$G(^MAGQUEUE(2006.035,D0,1)),ST=$P(X,"^",1),RDT=$P(X,"^",3)
 . . . I RDT'<UPTO S D0=0 Q
 . . . I ST'="",IM'="",TY'="" K ^MAGQUEUE(2006.035,"DEST",DE,ST,IM,TY,D0)
 . . . K ^MAGQUEUE(2006.035,"STS",LOCATION,"WAITING",PRI,DE,D0)
 . . . K:ID'="" ^MAGQUEUE(2006.035,"ID",ID,D0)
 . . . K ^MAGQUEUE(2006.035,D0)
 . . . S OUT=OUT+1
 . . . Q
 . . Q
 . Q
 Q
 ;
EVALLOG(OUT,TASK,MSG,MAX,LOCATION) ; RPC = MAG DICOM ROUTE EVAL LOG
 N L,N,PLACE,ZTSK
 ;
 S PLACE=$$PLACE^MAGDRPC2(LOCATION)
 S $P(^MAG(2006.1,PLACE,"LASTROUTE"),"^",1)=DT
 ;
 I '$D(^XTMP("MAGEVAL",+$G(TASK))) S OUT(1)="-1,No task #"_(+$G(TASK)) Q
 I $G(MAX)<1 S OUT(1)="-2,MAXIMUM parameter = "_$G(MAX)_" < 1" Q
 S (L,MSG)=+$G(MSG),N=1
 F  S MSG=$O(^XTMP("MAGEVAL",TASK,MSG)) Q:MSG=""  D  Q:N'<MAX
 . S L=MSG,N=N+1,OUT(N)=^XTMP("MAGEVAL",TASK,MSG)
 . Q
 S OUT(1)=(N-1)_" "_L
 Q:N>1
 S ZTSK=TASK D STAT^%ZTLOAD
 I $G(ZTSK(2))["Inactive" S OUT(1)="-3,"_ZTSK(2) Q
 Q
 ;
XMIT ; Continuation from MAGDRPC5
 N FROM,HASH,TO,TTP
 S (FROM,TO,OUT(7),OUT(8))=-13
 S TTP=TP S:TP="TEXT" TTP="FULL" ; MAGFILEB does not support type="TEXT"
 D FILEFIND^MAGDFB(IM,TTP,0,0,.TO,.FROM)
 S:FROM["~NO NETWORK LOCATION DEFINED" (FROM,TO)="-1~No routable files found for image "_IM
 I TP="TEXT" S TO=$E(TO,1,$L(TO)-4)_".TXT",FROM=$E(FROM,1,$L(FROM)-4)_".TXT"
 I (FROM<0)!(TO<0)!(FROM="") D STATUS^MAGDRPC5(X,D0,"SENT",LOCATION) S OUT(1)=2 Q
 S HASH=$$DIRHASH^MAGFILEB(TO,+DEST) D:HASH'=""
 . I $E(TO,1)="\",$E(HASH,$L(HASH))="\" S HASH=$E(HASH,1,$L(HASH)-1)
 . I $E(TO,1)'="\",$E(HASH,$L(HASH))'="\" S HASH=HASH_"\"
 . S TO=HASH_TO
 . Q
 D:DIR'=""
 . I $E(TO,1)="\",$E(DIR,$L(DIR))="\" S DIR=$E(DIR,1,$L(DIR)-1)
 . I $E(TO,1)'="\",$E(DIR,$L(DIR))'="\" S DIR=DIR_"\"
 . S TO=DIR_TO
 . Q
 S:$E(TO,1)'="\" TO="\"_TO
 S OUT(7)=FROM,OUT(8)=TO
 S OUT(1)=1
 Q
 ;
