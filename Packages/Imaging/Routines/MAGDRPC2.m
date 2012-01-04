MAGDRPC2 ;WOIFO/EdM - Imaging RPCs ; 05/18/2007 11:23
 ;;3.0;IMAGING;**11,30,51,50,54**;03-July-2009;;Build 1424
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
SERVICE(OUT) ; RPC = MAG DICOM GET SERVICE INFO
 N D0,X
 S D0=$O(^MAG(2006.1,0)),OUT="-1,No Imaging Site Parameters defined" Q:'D0
 S X=$G(^MAG(2006.1,D0,"GW"))
 S OUT=$$ENCRYP^XUSRB1($$DECRYP($P(X,"^",1))_";"_$$DECRYP($P(X,"^",2)))
 Q
 ;
SAME(SET,D0,NODE,PIECE,X) ; Called from FileMan ^DD
 N L0
 S L0=0 F  S L0=$O(^MAG(2006.1,L0)) Q:'L0  D:L0'=D0
 . S $P(^MAG(2006.1,L0,NODE),"^",PIECE)=$S(SET:X,1:"")
 . Q
 Q
 ;
IMAGE(OUT,D0) ; RPC = MAG DICOM GET BASIC IMAGE
 N I,MSG,TARGET,V,VE,VI,X
 K OUT S I=1
 I '$G(D0) S OUT(1)="-1,Invalid IEN ("_$G(D0)_")" Q
 I $D(^MAG(2005.1,D0,0)) S OUT(1)="-3,Image #"_D0_" has been deleted." Q
 I '$D(^MAG(2005,D0,0)) S OUT(1)="-2,No data for """_D0_"""." Q
 ;
 D GETS^DIQ(2005,D0_",","*","REIN","TARGET","MSG")
 S X="" F  S X=$O(TARGET(2005,D0_",",X)) Q:X=""  D
 . S VI=$G(TARGET(2005,D0_",",X,"I"))
 . S VE=$G(TARGET(2005,D0_",",X,"E"))
 . S I=I+1,OUT(I)=X_"^"_VI S:VI'=VE OUT(I)=OUT(I)_"^"_VE
 . Q
 ;
 D FILEFIND^MAGDFB(D0,"FULL",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="Full FileName^"_X
 S:V'<0 I=I+1,OUT(I)="Full Path+FileName^"_V
 ;
 D FILEFIND^MAGDFB(D0,"BIG",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="Big FileName^"_X
 S:V'<0 I=I+1,OUT(I)="Big Path+FileName^"_V
 ;
 D FILEFIND^MAGDFB(D0,"ABSTRACT",0,0,.X,.V)
 S:X'<0 I=I+1,OUT(I)="Abstract FileName^"_X
 S:V'<0 I=I+1,OUT(I)="Abstract Path+FileName^"_V
 ;
 S (V,X)=0 F  S X=$O(^MAG(2005,D0,1,X)) Q:'X  S V=V+1
 S:V I=I+1,OUT(I)="# Images^"_V
 ;
 S OUT(1)=I-1
 Q
 ;
GRPIMG(OUT,D0) ; RPC = MAG DICOM GET IMAGE GROUP
 N I,D1,X
 D CHK^MAGGSQI(.OUT,D0) I +$G(OUT(0))'=1 Q  ; patient safety
 K OUT S I=1
 S D1=0 F  S D1=$O(^MAG(2005,D0,1,D1)) Q:'D1  D
 . S X=$P($G(^MAG(2005,D0,1,D1,0)),"^",1) Q:'X
 . S I=I+1,OUT(I)=X
 . Q
 S OUT(1)=I-1
 Q
 ;
DECRYP(X) Q $S(X="":"",1:$$DECRYP^XUSRB1(X))
 ;
IMGVER(OUT) ; RPC = MAG DICOM GET VERSION
 N D0,DATINS,FME,FML,I,L,N,P,PATCH,X
 D FIND^DIC(9.7,"",".01;2I;51I","QU","MAG*3.0","*","B","","","FML","FME")
 S I="" F  S I=$O(FML("DILIST","ID",I)) Q:I=""  D
 . S N=$G(FML("DILIST","ID",I,.01)) Q:$P(N,"*",2)'="3.0"
 . S PATCH=$P(N,"*",3) Q:'PATCH
 . S PATCH(PATCH)=1
 . S DATINS=$G(FML("DILIST","ID",I,2)) Q:DATINS=""
 . S P=$G(FML("DILIST","ID",I,51)) Q:P=""
 . S L(DATINS,PATCH_"-"_P)=""
 . Q
 ;
 S (DATINS,L,OUT)="" F  S DATINS=$O(L(DATINS),-1) Q:DATINS=""  D
 . S PATCH="" F  S PATCH=$O(L(DATINS,PATCH)) Q:PATCH=""  D
 . . S:OUT="" OUT=PATCH
 . . S:$G(PATCH(+PATCH)) PATCH(+PATCH)=0,L=(+PATCH)_","_L
 . . Q
 . Q
 S OUT=L_OUT
 Q
 ;
PLACE(LOCATION) N D0,FST,LST
 S FST=+$O(^MAG(2006.1,0)),LST=+$O(^MAG(2006.1," "),-1) Q:LST=FST FST
 S D0=$O(^MAG(2006.1,"B",+$G(LOCATION),"")) Q:D0 D0
 Q FST
 ;
ROUTEDAY ; Scan for Routing Activity
 N BUCKET ;- Daily tallies
 N D0 ;----- Image pointer for child of current parent
 N D1 ;----- Pointer to multiple in image file
 N D4 ;----- Loop counter
 N DAY ;---- Current FileMan date
 N DAYTIM ;- Current FileMan timestamp
 N DEST ;--- Destination
 N FIRST ;-- First date for scan
 N FSTX ;--- First transmission for current study
 N IMAGE ;-- Image Pointer for current image
 N LAST ;--- Last date for scan
 N LSTQ ;--- Timestamp for last queue entry in current study
 N P3 ;----- Highest IEN in statistics file
 N P4 ;----- Number of entries in statistics file
 N PARENT ;- Image Pointer for parent of current image
 N R ;------ Retention Period
 N X ;------ Scratch
 N XMIT ;--- Total duration of transmissions for current study
 ;
 K ^TMP("MAG",$J,"RTD1")
 K ^TMP("MAG",$J,"RTD2")
 K ^TMP("MAG",$J,"RTD3")
 S FIRST=$$HTFM^XLFDT($H-4)
 S LAST=$$HTFM^XLFDT($H+2)
 ;
 S DEST="" F  S DEST=$O(^MAG(2005,"ROUTE",DEST)) Q:DEST=""  D
 . S NAME(DEST)=$P($G(^MAG(2005.2,DEST,0)," ? "_DEST),"^",1)
 . S DAYTIM=FIRST F  D  S DAYTIM=$O(^MAG(2005,"ROUTE",DEST,DAYTIM)) Q:DAYTIM=""  Q:DAYTIM'<LAST
 . . S DAY=DAYTIM\1
 . . S IMAGE="" F  S IMAGE=$O(^MAG(2005,"ROUTE",DEST,DAYTIM,IMAGE)) Q:IMAGE=""  D
 . . . S PARENT=$P($G(^MAG(2005,IMAGE,0)),"^",10)
 . . . I PARENT,$G(^TMP("MAG",$J,"RTD3",PARENT)) S PARENT=0
 . . . S:PARENT ^TMP("MAG",$J,"RTD3",PARENT)=1
 . . . S (XMIT,LSTQ)=0,FSTX=1E9
 . . . S D0=IMAGE,D1=0 D  I PARENT F  S D1=$O(^MAG(2005,PARENT,1,D1)) Q:'D1  S D0=+$P($G(^MAG(2005,PARENT,1,D1,0)),"^",1) D
 . . . . Q:'D0
 . . . . Q:$D(^TMP("MAG",$J,"RTD1",D0,D1))
 . . . . S ^TMP("MAG",$J,"RTD1",D0,D1)=""
 . . . . S D4=0 F  S D4=$O(^MAG(2005,D0,4,D4)) Q:'D4  D
 . . . . . S X=$G(^MAG(2005,D0,4,D4,0))
 . . . . . Q:$P($P(X,"^",1),".",1)'=DAY
 . . . . . Q:$P(X,"^",2)'=DEST
 . . . . . S:$P(X,"^",6)>LSTQ LSTQ=$P(X,"^",6)
 . . . . . S:$P(X,"^",5)<FSTX FSTX=$P(X,"^",5)
 . . . . . S XMIT=XMIT+$$DELTA($P(X,"^",5),$P(X,"^",1))
 . . . . . Q
 . . . . Q
 . . . S X=$$DELTA(LSTQ,FSTX)
 . . . S:X>$G(BUCKET(DAY,DEST,1)) BUCKET(DAY,DEST,1)=X
 . . . S X=$S(X<300:1,X<900:2,X<3600:3,1:4)
 . . . S BUCKET(DAY,DEST,1,X)=$G(BUCKET(DAY,DEST,1,X))+1
 . . . S:XMIT>$G(BUCKET(DAY,DEST,2)) BUCKET(DAY,DEST,2)=XMIT
 . . . S X=$S(XMIT<300:1,XMIT<900:2,XMIT<3600:3,1:4)
 . . . S BUCKET(DAY,DEST,2,X)=$G(BUCKET(DAY,DEST,2,X))+1
 . . . Q
 . . Q
 . Q
 ;
 S X=$G(^TMP("MAG",$J,"RTD2",0)),P3=+$P(X,"^",3),P4=+$P(X,"^",4)
 S DAY="" F  S DAY=$O(BUCKET(DAY)) Q:DAY=""  D
 . S:'$D(^TMP("MAG",$J,"RTD2",DAY)) P4=P4+1,^TMP("MAG",$J,"RTD2",DAY,0)=DAY
 . S D1=0,DEST="" F  S DEST=$O(BUCKET(DAY,DEST)) Q:DEST=""  D
 . . S D1=D1+1
 . . S X=$G(BUCKET(DAY,DEST,2,1))       ; Less than 5 minutes
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,2,2)) ; Less than 15 minutes
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,2,3)) ; Less than 1 hour
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,2,4)) ; 1 hour or more
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,2))   ; Longest
 . . S X=X_"^Duration ("_NAME(DEST)_")"
 . . S ^TMP("MAG",$J,"RTD2",DAY,1,D1,0)=X
 . . S D1=D1+1
 . . S X=$G(BUCKET(DAY,DEST,1,1))       ; Less than 5 minutes
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,1,2)) ; Less than 15 minutes
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,1,3)) ; Less than 1 hour
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,1,4)) ; 1 hour or more
 . . S X=X_"^"_$G(BUCKET(DAY,DEST,1))   ; Longest
 . . S X=X_"^Lag ("_NAME(DEST)_")"
 . . S ^TMP("MAG",$J,"RTD2",DAY,1,D1,0)=X
 . . Q
 . S:DAY>P3 P3=DAY
 . Q
 ; Purge old entries
 S R=$G(^MAGDICOM(2006.563,1,"RETAIN ROUTING STATISTICS")) S:R<1 R=30
 S DAY=$$HTFM^XLFDT($H-R)
 S D0=0 F  S D0=$O(^TMP("MAG",$J,"RTD2",D0)) Q:'D0  Q:D0'<DAY  D
 . K ^TMP("MAG",$J,"RTD2",D0) S P4=P4-1
 . Q
 ;
 D  ; Get routing statistics
 . N A,W
 . S (A,DAY)=0 F  S DAY=$O(^TMP("MAG",$J,"RTD2",DAY)) Q:'DAY  D
 . . S:'A N=N+1,OUT(N)="Route",A=1
 . . S N=N+1,OUT(N)="RDT="_DAY
 . . S W=0 F  S W=$O(^TMP("MAG",$J,"RTD2",DAY,1,W)) Q:'W  D
 . . . S X=$G(^TMP("MAG",$J,"RTD2",DAY,1,W,0))
 . . . S N=N+1,OUT(N)="DST="_$P($P($P(X,"^",6),"(",2),")",1)
 . . . S W=W+1,$P(X,"^",6,10)=$P($G(^TMP("MAG",$J,"RTD2",DAY,1,W,0)),"^",1,5)
 . . . S N=N+1,OUT(N)="RST="_X
 . . . Q
 . . Q
 . S:A N=N+1,OUT(N)="RouteEnd"
 . Q
 K ^TMP("MAG",$J,"RTD1")
 K ^TMP("MAG",$J,"RTD2")
 K ^TMP("MAG",$J,"RTD3")
 Q
 ;
DELTA(START,STOP) N D,D1,D2,T1,T2
 S D1=$P(START,".",1),D2=$P(STOP,".",1)
 S T1=START*1E6#1E6,T2=STOP*1E6#1E6
 S T1=T1\10000*60+(T1\100#100)*60+(T1#100)
 S T2=T2\10000*60+(T2\100#100)*60+(T2#100)
 S D=0 S:D1'=D2 D=$$FMTH^XLFDT(D2)-$$FMTH^XLFDT(D1)
 Q D*86400+T2-T1
 ;
