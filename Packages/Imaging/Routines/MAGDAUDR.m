MAGDAUDR ;WOIFO/EdM - RPC to fetch a Audit Info ; 03/17/2003  10:30
 ;;3.0;IMAGING;**11**;14-April-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
GET1(OUT,LOCATION,TODAY) ; Get the numbers of text-messages per day per purpose
 N COUNT,D2,DATE,I,MSG,N,X
 D:'$D(DT) DT^DICRW
 K OUT S (OUT(0),N)=0,I=100
 S TODAY=+$G(TODAY),DATE=DT
 D:TODAY  I 'TODAY S DATE=0 F  S DATE=$O(^MAGDAUDT(2006.5761,DATE)) Q:'DATE  D
 . Q:'$D(^MAGDAUDT(2006.5761,DATE,1,LOCATION))
 . ; Retrieve one day's statistics
 . S MSG="" F  S MSG=$O(^MAGDAUDT(2006.5761,DATE,1,LOCATION,1,"B",MSG)) Q:MSG=""  D
 . . S D2=$O(^MAGDAUDT(2006.5761,DATE,1,LOCATION,1,"B",MSG,"")) Q:'D2
 . . S X=$G(^MAGDAUDT(2006.5761,DATE,1,LOCATION,1,D2,0))
 . . S COUNT=$P(X,"^",2) Q:'COUNT
 . . S LAST=$P(X,"^",3)
 . . S I=I+1,N=N+1,OUT(I)=DATE_"^"_COUNT_"^"_MSG_"^"_LAST,MSG(MSG)=""
 . . Q
 . Q
 S I=0,MSG="" F  S MSG=$O(MSG(MSG)) Q:MSG=""  D
 . S I=I+1,N=N+1,OUT(I)="^^"_MSG
 . Q
 S OUT(0)=N
 Q
 ;
GET2(OUT,LOCATION,START,STOP) ; Get the numbers of messages per day per instrument
 N COUNT,D2,DATE,I,INSTR,N,X
 D:'$D(DT) DT^DICRW
 K OUT S (OUT(0),N)=0,I=100
 S START=+$G(START)-1,STOP=+$G(STOP)
 S:START<0 START=0
 S:'STOP STOP=9999999
 S DATE=START F  S DATE=$O(^MAGDAUDT(2006.5762,DATE)) Q:'DATE  Q:DATE>STOP  D
 . Q:'$D(^MAGDAUDT(2006.5762,DATE,1,LOCATION))
 . ; Retrieve one day's statistics
 . S INSTR="" F  S INSTR=$O(^MAGDAUDT(2006.5762,DATE,1,LOCATION,1,"B",INSTR)) Q:INSTR=""  D
 . . S D2=$O(^MAGDAUDT(2006.5762,DATE,1,LOCATION,1,"B",INSTR,"")) Q:'D2
 . . S X=$G(^MAGDAUDT(2006.5762,DATE,1,LOCATION,1,D2,0))
 . . S COUNT=$P(X,"^",2) S:$P(X,"^",4)>COUNT COUNT=$P(X,"^",4)
 . . Q:'COUNT
 . . S INSTR(INSTR)=""
 . . S I=I+1,N=N+1,OUT(I)=DATE_"^"_$P(X,"^",2)_"^"_INSTR_"^"_$P(X,"^",3,5)
 . . Q
 . Q
 S I=0,INSTR="" F  S INSTR=$O(INSTR(INSTR)) Q:INSTR=""  D
 . S I=I+1,N=N+1,OUT(I)="^^"_INSTR
 . Q
 S OUT(0)=N
 Q
 ;
RANGE(OUT) ; Get the date-ranges for the various audit files
 N DF,DL,FM,N
 K OUT S N=0
 F FM=2006.5761,2006.5762 D
 . S DF=$O(^MAGDAUDT(FM,0)) S:'DF DF=""
 . S DL=$O(^MAGDAUDT(FM," "),-1) S:'DL DL=""
 . S N=N+1,OUT(N)=FM_"^"_DF_"^"_DL
 . Q
 S N=N+1,OUT(N)="-END-"
 Q
 ;
PURGE(OUT,FM,DATE) ; Purge Audit FIle
 N D0,DATE,DAYS,X
 L +^MAGDAUDT(FM)
 S DAYS=$P($G(^MAGDAUDT(FM,0)),"^",4),OUT=0
 S X=0 F  S X=$O(^MAGDAUDT(FM,X)) Q:'X  Q:X'<DATE  D
 . K ^MAGDAUDT(FM,X)
 . S DAYS=DAYS-1,OUT=OUT+1
 . Q
 S:DAYS<1 DAYS=0
 S $P(^MAGDAUDT(FM,0),"^",4)=DAYS
 L -^MAGDAUDT(FM)
 S OUT=OUT_" day"_$S(OUT=1:"",1:"s")_" purged."
 Q
 ;
COUNT(OUT,LOCATION,MESSAGE) ; update today's count
 N %,D2,%H,%I,TODAY,NOW,X
 I '$G(LOCATION) S OUT="-1,No Location Specified" Q
 I $G(MESSAGE)="" S OUT="-2,No Message Specified" Q
 ;
 D NOW^%DTC S TODAY=X,NOW=%
 S D2=$O(^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,"B",MESSAGE,""))
 D:'D2
 . L +^MAGDAUDT(2006.5761,TODAY)
 . S D2=$O(^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1," "),-1)+1
 . S X=$G(^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,0))
 . S $P(X,"^",2)="2006.576111"
 . S $P(X,"^",3)=D2
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAGDAUDT(2006.5761,TODAY,1,LOCATION,0)=LOCATION
 . S ^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,0)=X
 . S ^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,D2,0)=MESSAGE
 . S ^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,"B",MESSAGE,D2)=""
 . L -^MAGDAUDT(2006.5761,TODAY)
 . Q
 S X=$G(^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,D2,0))
 S X=MESSAGE_"^"_($P(X,"^",2)+1)_"^"_NOW
 S ^MAGDAUDT(2006.5761,TODAY,1,LOCATION,1,D2,0)=X
 S OUT=$P(X,"^",2)
 Q
