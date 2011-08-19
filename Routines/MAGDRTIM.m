MAGDRTIM ;WOIFO/EdM - Routing Statistics ; 02/05/2004  08:45
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
AVERAGE ;
 N D0,D1
 N DEST ;--- Destination where file is sent to
 N PARENT ;- Parent Image
 N PROC ;--- Procedure (closest to "Modality")
 N SEC ;---- Stop time converted to seconds
 N START ;-- Timestamp when transmission started
 N STOP ;--- Timestamp when transmission completed
 N TIME ;--- Duration of transmission
 N TYP ;---- Type of tile (TXT, FULL, ABS, ...)
 N X ;------ Scratch
 ;
 K ^TMP("MAG",$J,"RTTIM")
 S DEST="" F  S DEST=$O(^MAG(2005,"ROUTE",DEST)) Q:DEST=""  D
 . S STOP="" F  S STOP=$O(^MAG(2005,"ROUTE",DEST,STOP)) Q:STOP=""  D
 . . Q:'STOP
 . . S SEC=$$SEC(STOP)
 . . S D0="" F  S D0=$O(^MAG(2005,"ROUTE",DEST,STOP,D0)) Q:D0=""  D
 . . . S X=$G(^MAG(2005,D0,0))
 . . . S PROC=$P(X,"^",8) S:PROC="" PROC="?"
 . . . S PARENT=$P(X,"^",10) S:'PARENT PARENT=D0
 . . . S ^TMP("MAG",$J,"RTTIM",PROC,DEST,PARENT,2)=$G(^TMP("MAG",$J,"RTTIM",PROC,DEST,PARENT,2))+1
 . . . S D1="" F  S D1=$O(^MAG(2005,"ROUTE",DEST,STOP,D0,D1)) Q:D1=""  D
 . . . . S X=$G(^MAG(2005,D0,4,D1,0)) Q:X=""
 . . . . S START=$P(X,"^",5) Q:'START
 . . . . S TIME=SEC-$$SEC(START) S:TIME<0 TIME=TIME+86400
 . . . . S ^TMP("MAG",$J,"RTTIM",PROC,DEST,PARENT,1)=$G(^TMP("MAG",$J,"RTTIM",PROC,DEST,PARENT,1))+TIME
 . . . . Q
 . . . Q
 . . Q
 . Q
 S PROC="" F  S PROC=$O(^TMP("MAG",$J,"RTTIM",PROC)) Q:PROC=""  D
 . S DEST="" F  S DEST=$O(^TMP("MAG",$J,"RTTIM",PROC,DEST)) Q:DEST=""  D
 . . N IMAGE
 . . S (TIME,IMAGE)=0
 . . S D0="" F  S D0=$O(^TMP("MAG",$J,"RTTIM",PROC,DEST,D0)) Q:D0=""  D
 . . . S X=$G(^TMP("MAG",$J,"RTTIM",PROC,DEST,D0,1)) Q:'X
 . . . S TIME=TIME+X,IMAGE=IMAGE+^TMP("MAG",$J,"RTTIM",PROC,DEST,D0,2)
 . . . Q
 . . Q:'IMAGE
 . . W !,"Sending ",IMAGE," ",PROC," image" W:IMAGE'=1 "s"
 . . W " to ",$P($G(^MAG(2005.2,DEST,0),"#"_DEST),"^",1)," took "
 . . S X=$$HMS(TIME)
 . . W X,"."
 . . W !?5,$$HMS(TIME*100\IMAGE)," per 100 images."
 . . Q
 . Q
 K ^TMP("MAG",$J,"RTTIM")
 Q
 ;
HMS(T) N H,M,S,X
 S H=T\3600,M=T\60#60,S=T#60,X=""
 I H S X=H_" hour" S:H'=1 X=X_"s"
 I M S:X'="" X=X_"; |" S X=X_M_" minute" S:M'=1 X=X_"s"
 I S S:X'="" X=$TR(X,";|",",")_" |" S X=X_S_" second" S:S'=1 X=X_"s"
 S:X["|" X=$P($TR(X,";"),"|",1)_"and "_$P(X,"|",2)
 Q X
 ;
SEC(DT) N R,X
 S X=DT-(DT\1)*1000000,R=X\10000,R=R*60+(X\100#100),R=R*60+(X#100)
 Q R
 ;
TRANSID(OUT,LOC) ; RPC = MAG DICOM ROUTE GET TRANS ID
 N PLACE,SITE,X
 S PLACE=$S($G(LOC):$O(^MAG(2006.1,"B",LOC,"")),1:0)
 S:'PLACE PLACE=$O(^MAG(2006.1,0))
 S X=$G(^MAG(2006.1,PLACE,0)),SITE=$P(X,"^",9)
 S:SITE="" SITE=$P(X,"^",2)
 S:SITE="" SITE="!"
 ;
 L +^MAG(2006.1,PLACE,"TRANSACTION")
 S OUT=$G(^MAG(2006.1,PLACE,"TRANSACTION"))+1
 S ^MAG(2006.1,PLACE,"TRANSACTION")=OUT
 L -^MAG(2006.1,PLACE,"TRANSACTION")
 S OUT=SITE_$TR($J(OUT,12)," ",0)
 Q
 ;
TRANSTS(OUT,TRANSID) ; RPC = MAG DICOM ROUTE TRANSACT STS
 N CNT,D0,STS
 I $G(TRANSID)="" S OUT="-1,No Transaction ID Specified" Q
 I '$D(^MAGQUEUE(2006.035,"ID",TRANSID)) S OUT="-2,Invalid Transaction ID" Q
 S D0="" F  S D0=$O(^MAGQUEUE(2006.035,"ID",TRANSID,D0)) Q:D0=""  D
 . S STS=$P($G(^MAGQUEUE(2006.035,D0,1)),"^",1) S:STS="" STS="?"
 . S CNT(STS)=$G(CNT(STS))+1
 . Q
 S OUT="" F STS="WAITING","SENDING","SENT","FAILED","?" D
 . S OUT=OUT_$G(CNT(STS))_"="_STS_"^"
 . Q
 Q
 ;
