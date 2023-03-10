MAGDSTV1 ;WOIFO/PMK - Study Tracker - VistA Query/Retrieve user ; Apr 25, 2022@09:21:50
 ;;3.0;IMAGING;**231,305**;Mar 19, 2002;Build 3
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
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ;
SOPUIDQ ; Called from batch compare/retrieve for a SOP Instance Query
 ; suppress text output when doing a batch query
 N BATCHQR
 S BATCHQR=1
 K ^XTMP(MAGXTMP,HOSTNAME,$J,"AUTOMATIC")
 D ENTRY("Q")
 Q
 ;
SOPUIDR ; Called from batch retrieve for a SOP Instance Retrieval
 ; suppress text output when doing a batch retrieve
 N BATCHQR
 S BATCHQR=1
 K ^XTMP(MAGXTMP,HOSTNAME,$J,"AUTOMATIC")
 ;
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ACCESSION NUMBER")=ACNUMB
 ;
 ; indicate if the retrieve monitor is running - P305 PMK 03/15/2022
 I $$ENABLED^MAGDSTV1 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE MONITOR")="YES"
 E  S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE MONITOR")="NO"
 ;
 D ENTRY("R") ; don't show retrieve results
 Q
 ;
 ;
ENTRY(MODE,SHOWRRSL) ; called from ^MAGDSTQ for a VistA Q/R client
 N CMOVEAET,GATEWAYHOSTNAME,I,IEN2006541,KEY,REQUESTDATETIME,VALUE,X,ZERONODE
 S MODE=$G(MODE)
 I MODE'="Q",MODE'="R" D  Q
 . W !,"Illegal mode in ENTRY^"_$T(+0),": ",MODE
 . D CONTINUE^MAGDSTQ
 . Q
 K ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE") ; remove any previous query error message
 S SHOWRRSL=$G(SHOWRRSL) ; 1 = show retrieval results
 ;
 ; store the request on the queue
 L +^MAGDSTT(2006.541):10 ; foreground process
 S ZERONODE=$G(^MAGDSTT(2006.541,0))
 S $P(ZERONODE,"^",1,2)="DICOM VISTA Q/R REQUEST QUEUE^2006.541"
 S IEN2006541=$O(^MAGDSTT(2006.541," "),-1)+1 ; Next number
 S $P(ZERONODE,"^",3)=IEN2006541
 S $P(ZERONODE,"^",4)=$P(ZERONODE,"^",4)+1 ; Total count
 S ^MAGDSTT(2006.541,0)=ZERONODE
 S REQUESTDATETIME=$$NOW^XLFDT
 S ^MAGDSTT(2006.541,IEN2006541,0)=REQUESTDATETIME_"^"_MODE_"^"_MAGXTMP_"^"_HOSTNAME_"^"_$J_"^"_QRSTACK_"^"_DUZ
 S KEY="" F I=1:1 S KEY=$O(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,KEY)) Q:KEY=""  D
 . S VALUE=^TMP("MAG",$J,"Q/R QUERY",QRSTACK,KEY)
 . S VALUE=$TR(VALUE,"^","~") ; change ^'s in names to ~'s
 . S ^MAGDSTT(2006.541,IEN2006541,1,I,0)=KEY_"^"_VALUE
 . S ^MAGDSTT(2006.541,IEN2006541,1,"B",KEY,I)=""
 . Q
 S ^MAGDSTT(2006.541,"B",REQUESTDATETIME,IEN2006541)="" ; create B-xref
 S I=I-1
 S ^MAGDSTT(2006.541,IEN2006541,1,0)="^2006.5411A^"_I_"^"_I
 S ^MAGDSTT(2006.541,0)=ZERONODE
 L -^MAGDSTT(2006.541)
 ;
 I MODE="Q" D
 . I '$G(BATCHQR) W !,"Performing query on DICOM Gateway"
 . ; "DONE" uses the request IEN for proper synchronization
 . I '$$WAIT(.CMOVEAET) Q
 . I '$G(BATCHQR) D DISPLAY^MAGDSTQ5
 . Q
 E  I MODE="R" D
 . I '$$WAIT(.CMOVEAET) Q
 . ; save Move Application Entity Title
 . I $D(RUNNUMBER) S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",8)=CMOVEAET
 . I $G(BATCHQR) Q  ; suppress text output
 . I 'SHOWRRSL D
 . . F  Q:$X=0  W @IOBS," ",@IOBS ; erase the line
 . . W "Performing retrieve from """,QRSCP,""" from DICOM Gateway"
 . . W " (",GATEWAYHOSTNAME,")"
 . . R X:3
 . Q
 Q
 ;
WAIT(CMOVEAET) ; wait up to ten minutes for response from DICOM Gateway
 N I,J,SUCCESS,TIMESTAMP,X
 S CMOVEAET="",SUCCESS=0
 S TIMESTAMP=$$NOW^XLFDT ; time at the beginning of the wait
 ;
 ; check that the gateway surrogated picked up the Q/R request
 F I=1:1:10 D  Q:SUCCESS 
 . S X=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"WORKING...",IEN2006541))
 . I $L(X) D  Q
 . . S GATEWAYHOSTNAME=$P(X,"^",3)
 . . S SUCCESS=1
 . . Q
 . H 1
 . Q
 I 'SUCCESS D  Q SUCCESS
 . W !
 . W ! F J=1:1:80 W "*"
 . W !,"***  No DICOM Gateway Surrogate process is available for VistA Q/R Client"
 . W ?77,"***"
 . W ! F J=1:1:80 W "*"
 . W !
 . I $G(BATCHQR) Q  ; suppress CONTINUE prompt
 . D CONTINUE^MAGDSTQ
 . Q
 ;
 I MODE="Q",'$G(BATCHQR) W " (",GATEWAYHOSTNAME,")"
 ;
 ; check that the Q/R request was processed
 F I=1:1:600 Q:$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"DONE",IEN2006541))  D
 . H 1
 . I $G(BATCHQR) Q  ; suppress text output
 . W "."
 . Q
 S X=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"DONE",IEN2006541))
 S SUCCESS=0
 I $L(X) D
 . S SUCCESS=1
 . S CMOVEAET=$P(X,"^",3)
 . Q
 E  D
 . W !
 . W ! F J=1:1:80 W "*"
 . W !,"***  The "
 . W $S(MODE="Q":"query",MODE="R":"retrieve")
 . W " was not completed by DICOM Gateway"
 . I $D(GATEWAYHOSTNAME) W " (",GATEWAYHOSTNAME,")"
 . W " ",$$FMTE^XLFDT(TIMESTAMP),?77,"***"
 . W ! F J=1:1:80 W "*"
 . W !
 . I $G(BATCHQR) Q  ; suppress CONTINUE prompt
 . D CONTINUE^MAGDSTQ
 . Q
 ;
 ; check for message
 S X=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE","MSG",0))
 I X,'$G(BATCHQR) D
 . W !!,"Error Message: "
 . F I=1:1:X W !,$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE","MSG",I))
 . D CONTINUE^MAGDSTQ
 . S SUCCESS=0,SHOWRRSL=0
 . Q
 ;
 Q SUCCESS
 ;
KILL ; truncate the DICOM VISTA Q/R REQUEST QUEUE file (#2006.541)
 N PROMPT,X
 S X=$P($G(^MAGDSTT(2006.541,0)),"^",3)
 I X="" D  Q
 . W !!,"The DICOM VISTA Q/R REQUEST QUEUE entries have already been deleted."
 . Q
 I X=1 D
 . W !!,"There is one entry in the DICOM VISTA Q/R REQUEST QUEUE."
 . S PROMPT="Do you want to remove it?"
 . Q
 E  D
 . W !!,"There are "_X_" entries in the DICOM VISTA Q/R REQUEST QUEUE."
 . S PROMPT="Do you want to remove them?"
 . Q
 I $$YESNO^MAGDSTQ(PROMPT,"n",.X)>0,X="YES"  D
 . K ^MAGDSTT(2006.541)
 . S ^MAGDSTT(2006.541,0)="DICOM VISTA Q/R REQUEST QUEUE"_"^"_2006.541_"^^"
 . W !!,"The DICOM VISTA Q/R REQUEST QUEUE file has been truncated."
 . Q
 E  W !!,"The DICOM VISTA Q/R REQUEST QUEUE file has not been truncated."
 Q
 ;
ENABLED() ; check if monitor is active - P305 PMK 03/15/2022
 L +^MAGDRMON:0 ; automatic retrieve monitor is active
 L -^MAGDRMON ; automatic retrieve monitor is not active
 Q '$T
