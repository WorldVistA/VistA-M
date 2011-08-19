MAGBRTUT ;WOIFO/EdM - Routing Utilities ; 10/30/2008 09:20
 ;;3.0;IMAGING;**9,11,30,51,50,85,54**;03-July-2009;;Build 1424
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
SEND(IMAGE,LOC,PRI,MECH,FROM,ID) ; Enter image into Routing Queue
 ; IMAGE ;---- Internal Entry Number in Image FIle
 ; LOC ;------ Internal Entry Number in either Network Location file
 ;             or SCU_List file
 ; PRI ;------ Priority
 ; MECHanism = 1: Send using MS-DOS-Copy
 ;           = 2: Send using DICOM_Send
 ; FROM ;----- Location from which request originates
 ; ID ;------- Transaction ID
 N D0 ;------- Internal Entry number
 N FLAG ;----- List of file-types to transmit
 N I ;-------- Scratch and loop counter
 N ORIGIN ;--- Location from which image is being sent (IEN in Institution file)
 N QQ ;------- List of queue-entries created
 ;
 S QQ="",MECH=$G(MECH) S:'MECH MECH=1
 I '$D(^MAG(2005,+$G(IMAGE))) Q:$Q QQ Q
 I MECH=1,'$D(^MAG(2005.2,+$G(LOC))) Q:$Q QQ Q
 I MECH=2,'$D(^MAG(2006.587,+$G(LOC))) Q:$Q QQ Q
 I MECH'=1,MECH'=2 Q:$Q QQ Q
 S:MECH=1 LOC=(+LOC)_";MAG(2005.2,"
 S:MECH=2 LOC=(+LOC)_";MAG(2006.587,"
 ;
 S ORIGIN=$G(FROM) D:'ORIGIN
 . S ORIGIN=$P($G(^MAG(2005,IMAGE,100)),"^",3)
 . S:'ORIGIN ORIGIN=$G(DUZ(2))
 . S:'ORIGIN ORIGIN=$$KSP^XUPARAM("INST")
 . Q
 ;
 S PRI=$G(PRI,500),ID=$G(ID)
 S FLAG=$G(^MAG(2005.2,+LOC,1)) S:MECH=2 FLAG="^^^^5"
 ;
 I MECH=2 D  Q:$Q QQ Q
 . ; Stopgap until "native DICOM" storage is supported
 . N APPNAM
 . S APPNAM=$P($G(^MAG(2006.587,+LOC,0)),"^",1)
 . D QUEUE^MAGDRPC3(.QQ,IMAGE,APPNAM,ORIGIN,"","6: Copy to HIPAA Compliant Storage",,PRI)
 . Q
 ;
 F I=1:1:5 D:$P(FLAG,"^",I)
 . N D0,T,X
 . S T=$P("ABSTRACT FULL BIG TEXT DICOM"," ",I)
 . ;
 . S D0=$O(^MAGQUEUE(2006.035,"DEST",LOC,"WAITING",IMAGE,T,"")) I D0 D  Q
 . . N O,P,T,X0,X1
 . . S X0=$G(^MAGQUEUE(2006.035,D0,0)),O=$P(X0,"^",5),T=$P(X0,"^",6)
 . . S X1=$G(^MAGQUEUE(2006.035,D0,1)),P=$P(X1,"^",2)
 . . ; Don't send multiple copies, but do increase priority if needed
 . . Q:PRI'>P
 . . S $P(X0,"^",5)=ORIGIN,^MAGQUEUE(2006.035,D0,0)=X0
 . . I T'=ID,ID'="" D
 . . . S $P(X0,"^",6)=ID
 . . . S ^MAGQUEUE(2006.035,D0,0)=X0
 . . . K:O'="" ^MAGQUEUE(2006.035,"ID",T,D0)
 . . . S ^MAGQUEUE(2006.035,"ID",ID,D0)=""
 . . . Q
 . . S $P(X1,"^",2)=PRI,^MAGQUEUE(2006.035,D0,1)=X1
 . . K:O ^MAGQUEUE(2006.035,"STS",O,"WAITING",P,LOC,D0)
 . . S ^MAGQUEUE(2006.035,"STS",ORIGIN,"WAITING",PRI,LOC,D0)=""
 . . Q
 . ;
 . L +^MAGQUEUE(2006.035,0):1E9 ; Background job MUST wait
 . S D0=$O(^MAGQUEUE(2006.035," "),-1)+1
 . S X=$G(^MAGQUEUE(2006.035,0))
 . S $P(X,"^",1,2)="SEND QUEUE^2006.035"
 . S $P(X,"^",3)=D0
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAGQUEUE(2006.035,0)=X
 . S X=IMAGE_"^"_LOC_"^"_T_"^"_MECH_"^"_ORIGIN_"^"_ID
 . S:ID'="" ^MAGQUEUE(2006.035,"ID",ID,D0)=""
 . S ^MAGQUEUE(2006.035,D0,0)=X
 . S ^MAGQUEUE(2006.035,D0,1)="WAITING^"_PRI_"^"_$$NOW^XLFDT()
 . S ^MAGQUEUE(2006.035,"STS",ORIGIN,"WAITING",PRI,LOC,D0)=""
 . S ^MAGQUEUE(2006.035,"DEST",LOC,"WAITING",IMAGE,T,D0)=""
 . L -^MAGQUEUE(2006.035,0)
 . S QQ=QQ_D0_"^"
 . Q
 Q:$Q QQ Q
 ;
DCMLIST(OUT,LOCATION) N D0,LO,LST,N,NM,X
 S LOCATION=+$G(LOCATION)
 S D0=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.587,D0,0))
 . S NM=$P(X,"^",1),LO=$P(X,"^",7) Q:NM=""
 . I LOCATION,LO,LO'=LOCATION Q
 . S LST(NM,LO)=D0
 . Q
 S N=1,NM="" F  S NM=$O(LST(NM)) Q:NM=""  D
 . S LO="",X=0 F  S LO=$O(LST(NM,LO)) Q:LO=""  S X=X+1,D0=LST(NM,LO)
 . I X=1 S N=N+1,OUT(N)=NM_"^"_D0 Q
 . S LO="" F  S LO=$O(LST(NM,LO)) Q:LO=""  S N=N+1,OUT(N)=NM_" ("_LO_")^"_LST(NM,LO)
 . Q
 S OUT(1)=N-1
 Q
 ;
EVALPU(OUT,UNTIL) ; RPC = MAG DICOM ROUTE EVAL PURGE
 N D0,MORE,N,P1,P4,P5,P6,P7,P8,TIME
 S TIME=$$STAMP($H)+55,N=0,MORE=0
 L +^MAGQUEUE(2006.03,0):1E9 ; Background process must wait
 S D0="" F  S D0=$O(^MAGQUEUE(2006.03,"B","EVAL",D0)) Q:D0=""  D  Q:MORE
 . S X=$G(^MAGQUEUE(2006.03,D0,0))
 . S P4=$P(X,"^",4),P6=$P(X,"^",6)
 . S:P6 P4=-1
 . Q:P4>UNTIL
 . I $$STAMP($H)>TIME S MORE=1 Q
 . S N=N+1,P1=$P(X,"^",1),P5=$P(X,"^",5),P7=$P(X,"^",7),P8=$P(X,"^",8)
 . I P1'="" K ^MAGQUEUE(2006.03,"B",P1,D0)
 . I P5'="" K ^MAGQUEUE(2006.03,"C",P5,D0)
 . I P7'="",P8'="" K ^MAGQUEUE(2006.03,"JD",P7,P8,D0)
 . I P7'="" K ^MAGQUEUE(2006.03,"JX",P7,D0)
 . K ^MAGQUEUE(2006.03,D0)
 . Q
 S X=$G(^MAGQUEUE(2006.03,0))
 S P1=$P(X,"^",4)-N S:P1<1 P1=0 S $P(X,"^",4)=P1
 S $P(X,"^",1,2)="IMAGE BACKGROUND QUEUE^2006.03"
 S ^MAGQUEUE(2006.03,0)=X
 L -^MAGQUEUE(2006.03,0)
 S OUT=N_"^"_MORE
 Q
 ;
STAMP(H) Q H*86400+$P(H,",",2)
 ;
RENAME(OUT,OLD,NEW,KEY) ; RPC = MAG DICOM XMIT RENAME GATEWAY
 N D0,ID,LOC,SVC,N,X
 I $G(OLD)="" S OUT="-1,No previous Gateway name specified" Q
 I $G(NEW)="" S OUT="-2,No new Gateway name specified" Q
 S:'$G(KEY) KEY=5
 I KEY'=5,KEY'=6 S OUT="-3,Invalid key specified ("_KEY_")" Q
 ;
 S (N,D0)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.587,D0,0)),ID=$P(X,"^",KEY) Q:ID'=OLD
 . S N=N+1
 . S $P(X,"^",KEY)=NEW
 . Q:KEY'=5
 . S LOC=$P(X,"^",7),SVC=$P(X,"^",1)
 . I LOC'="",SVC'="" K ^MAG(2006.587,"C",SVC,OLD,LOC,D0)
 . I LOC'="" K ^MAG(2006.587,"D",OLD,LOC,D0)
 . I LOC'="",SVC'="" S ^MAG(2006.587,"C",SVC,NEW,LOC,D0)=""
 . I LOC'="" S ^MAG(2006.587,"D",NEW,LOC,D0)=""
 . Q
 S OUT=N_" entr"_$S(N=1:"y",1:"ies")_" renamed"
 Q
 ;
REMOVE(OUT,OLD,KEY) ; RPC = MAG DICOM XMIT REMOVE GATEWAY
 N D0,ID,LOC,SVC,N,T,X
 I $G(OLD)="" S OUT="-1,No Gateway name specified" Q
 S:'$G(KEY) KEY=5
 I KEY'=5,KEY'=6 S OUT="-3,Invalid key specified ("_KEY_")" Q
 ;
 L +^MAG(2006.587,0):1E9 ; Background process MUST wait
 S (N,D0)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.587,D0,0)),ID=$P(X,"^",KEY) Q:ID'=OLD
 . S N=N+1
 . S LOC=$P(X,"^",7),SVC=$P(X,"^",1)
 . I LOC'="",SVC'="" K ^MAG(2006.587,"C",SVC,OLD,LOC,D0)
 . I LOC'="" K ^MAG(2006.587,"D",OLD,LOC,D0)
 . I SVC'="" K ^MAG(2006.587,"B",SVC,D0)
 . K ^MAG(2006.587,D0)
 . Q
 S X=$G(^MAG(2006.587,0))
 S $P(X,"^",1,2)="DICOM TRANSMIT DESTINATION^2006.587"
 S $P(X,"^",3)=$O(^MAG(2006.587," "),-1)
 S T=$P(X,"^",4)-N S:T<1 T="" S $P(X,"^",4)=T
 S ^MAG(2006.587,0)=X
 L -^MAG(2006.587,0)
 S OUT=N_" entr"_$S(N=1:"y",1:"ies")_" removed"
 Q
 ;
