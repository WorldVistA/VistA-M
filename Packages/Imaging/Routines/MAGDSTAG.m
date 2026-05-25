MAGDSTAG ;WOIFO/PMK - Study Tracker - Automatic Retrieve Monitor; Aug 04, 2025@12:34:57
 ;;3.0;IMAGING;**333**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; 
 ;
 ; Supported IA #10103 reference $$HTE^XLFDT function call
 ;
 ; Display Automatic Retrieve Status - similar to MAGDSTQ8
 ;
 Q
 ;
ENTRY ; Display Automatic Retrieve Status
 N A,ACNUMB,BADTAGS,BADUIDS,COMMENT,COMPLETED,COUNT,DONE
 N ERRORID,FAILED,HOSTNAME,I,IDLE,J,K,MAGXTMP,MEANING,QRSCP
 N REDISPLAY,REMAINING,STATE,STATUS,STATUSCODE,TIMESTAMP,WARNING,X
 ;
 L +^MAGDRMON:0 E  D  Q  ; signal that the monitor is running
 . W !!,"The Automatic Retrieval Monitor is already running"
 . D CONTINUE^MAGDSTQ
 . Q
 ;
 S HOSTNAME=$$HOSTNAME^MAGDFCNV
 S MAGXTMP=$$INITXTMP^MAGDSTQ0
 I $D(^XTMP(MAGXTMP,"Q/R RETRIEVE STATUS")) D
 . I $$YESNO^MAGDSTQ("Initialize the log?","No",.X)<0 Q
 . I X="YES" K ^XTMP(MAGXTMP,"Q/R RETRIEVE STATUS")
 . Q
 ;
 W @IOF R !!,"Use caret (""^"") to exit.  Press <Enter> to begin...",X:DTIME
 W @IOF D HEADING
 S (DONE,IDLE)=0
 S I=0 F  D  Q:DONE
 . S J=$O(^XTMP(MAGXTMP,"Q/R RETRIEVE STATUS",I))
 . I J="" D  Q 
 . . D IDLE(.IDLE,.DONE) ; P333 PMK 08/04/2025
 . . Q
 . S I=J
 . S X=^XTMP(MAGXTMP,"Q/R RETRIEVE STATUS",I)
 . S ACNUMB=$P(X,"|",1)
 . S X=$P(X,"|",2,999) ; align remaining pieces with ^MAGDSTQ8
 . S STATUSCODE=$$PARSE^MAGDSTQ8(X)
 . ;
 . I STATUSCODE="" D  Q  ; informational message
 . . I STATE?1"Building".E D  Q
 . . . I $Y>(IOSL-4) D
 . . . . S $Y=0 W !!
 . . . . D HEADING
 . . . . Q
 . . . Q
 . . I STATE?1"Sending".E D
 . . . S QRSCP=$P(STATE,"""",2)
 . . . W !!,$$DAYTIME(TIMESTAMP),"  ",ACNUMB,?34,"Sent from ",QRSCP,!
 . . . Q
 . . Q
 . ;
 . F  Q:$X=0  W @IOBS," ",@IOBS ; erase the line
 . S STATUS=$$STATUS^MAGDSTQ8(STATUSCODE,.MEANING)
 . I STATUS="Success" D
 . . I COMPLETED=0 W "No DICOM objects were retrieved"
 . . E  W "DICOM objects retrieved: ",COMPLETED
 . . Q
 . E  D
 . . D STATUSTEXT^MAGDSTQ8(.A)
 . . F K=1:1:A(0) W:K>1 ! W A(K)
 . . W:K>1 ! ; so that the last line isn't erased
 . . Q
 . ;
 . I STATUS'="Pending" D  ; update counts when completed
 . . I FAILED S COUNT("FAILED")=$G(COUNT("FAILED"),0)+FAILED
 . . I WARNING S COUNT("WARNING")=$G(COUNT("WARNING"),0)+WARNING
 . . Q
 . ;
 . I STATUS="Pending" Q
 . S COUNT("RETRIEVED")=$G(COUNT("RETRIEVED"),0)+COMPLETED
 . ;
 . D STATS
 . Q
 L -^MAGDRMON ; signal that the monitor is no longer running
 D CONTINUE^MAGDSTQ
 Q
 ;
HEADING ; display heading
 N C,I,L,TAB
 S X="Real-Time Automatic Retrieve Monitor"
 S L=$L(X),TAB=(IOM-L)/2
 W ?TAB,X,!?TAB F I=1:1:L W "-"
 Q
 ;
STATS ;
 W ?34
 W "Total Retrieved: ",$G(COUNT("RETRIEVED"),0)
 W "   Fail:",$G(COUNT("FAILED"),0)
 W "   Warn:",$G(COUNT("WARNING"),0)
 Q
 ;
DAYTIME(NOW) ;
 N DAY,DH,TIME,X
 I NOW="" Q ""
 S DH=$$FMTH^XLFDT(NOW)
 S TIME=$P(NOW,".",2)_"000000"
 S TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)_":"_$E(TIME,5,6)
 S DAY=$P("Thu^Fri^Sat^Sun^Mon^Tue^Wed","^",DH#7+1)
 Q DAY_" "_TIME
 ;
IDLE(I,DONE)  ; output idle ; P333 PMK 08/04/2025
 N X
 S I=I+1 S:I<1 I=1 S:I>4 I=1 W ?78,$E("-\|/",I),$C(8)
 R X:1
 I X="^" S DONE=1
 Q
 ;
ENABLED() ; check if monitor is active - P333 PMK 03/15/2022
 L +^MAGDRMON:0 ; automatic retrieve monitor is active
 L -^MAGDRMON ; automatic retrieve monitor is not active
 Q '$T
