MAGDRPCF ;WOIFO/PMK - Imaging RPCs ; Feb 15, 2022@10:34:46
 ;;3.0;IMAGING;**305**;Mar 19, 2002;Build 3
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
 ;; Supported IA #2056 reference $$GET1^DIQ function call
 ;; Supported IA #10090 to read with Fileman the INSTITUTION file (#4)
 ;;
 Q
 ;
STATE(OUT) ; RPC = MAG DICOM EXPORT QUEUE STATE
 ; get STATE of non-transmitted entries
 N ACNUMB,FROMLOC,I,J,NOUT,STATIONNUMBER,STATE,STATEARRAY,X
 K OUT
 S NOUT=1
 S I=0 F  S I=$O(^MAGDOUTP(2006.574,I)) Q:'I  D
 . S J=0 F  S J=$O(^MAGDOUTP(2006.574,I,1,J)) Q:'J  D
 . . S STATE=$P($G(^MAGDOUTP(2006.574,I,1,J,0)),"^",2)
 . . I "^SUCCESS^IGNORE^NOT ON FILE^"[("^"_STATE_"^") Q  ; exclude processed images
 . . ; allow STATE="WAITING", "XMIT", "HOLD", and "FAIL"
 . . S STATEARRAY(I,STATE)=$G(STATEARRAY(I,STATE))+1
 . . Q
 . Q
 S I=0 F  S I=$O(STATEARRAY(I)) Q:I=""  D
 . S X=$G(^MAGDOUTP(2006.574,I,0))
 . ; update FROM location with STATION NUMBER
 . S FROMLOC=$P(X,"^",4)
 . S STATIONNUMBER=$$GET1^DIQ(4,FROMLOC,99,"E")
 . S $P(X,"^",4)=STATIONNUMBER
 . ;
 . S NOUT=NOUT+1
 . S OUT(NOUT)=$G(^MAGDOUTP(2006.574,I,0))_"^"_I ; index is last piece
 . S STATE="" F  S STATE=$O(STATEARRAY(I,STATE)) Q:STATE=""  D
 . . S NOUT=NOUT+1
 . . S OUT(NOUT)="^"_STATE_"^"_STATEARRAY(I,STATE)
 . . Q
 . Q
 S OUT(1)=NOUT-1
 Q 
 ;
HOLDREL(OUT,STUDYIEN,NEWSTATE) ; RPC = MAG DICOM EXPORT QUEUE HOLD
 N COUNT,IMAGEIELOCATION,IMAGEIEN,PRIORITY,OLDSTATE,X
 K OUT
 I $G(STUDYIEN)="" D  Q
 . S OUT(1)="-1,^MAGDOUTP(2006.574,...) STUDYIEN must be the first input parameter"
 . Q
 I '$D(^MAGDOUTP(2006.574,STUDYIEN)) D  Q
 . S OUT(1)="-2,^MAGDOUTP(2006.574,...) STUDYIEN """_STUDYIEN_""" is not in the export queue"
 . Q
 I $G(NEWSTATE)="" D  Q
 . S OUT(1)="-3,NEWSTATE must be the second input parameter"
 . Q
 I NEWSTATE'="HOLD",NEWSTATE'="RELEASE",NEWSTATE'="RETRY" D  Q
 . S OUT(1)="-4,NEWSTATE must be either HOLD, RELEASE, or RETRY"
 . 
 S X=^MAGDOUTP(2006.574,STUDYIEN,0)
 S LOCATION=$P(X,"^",4),PRIORITY=$P(X,"^",5)
 ;
 S NEWSTATE=$S(NEWSTATE="HOLD":"HOLD",1:"WAITING")
 ;
 S NOUT=1,COUNT=0
 L +^MAGDOUTP(2006.574):1E9
 S IMAGEIEN=0 F  S IMAGEIEN=$O(^MAGDOUTP(2006.574,STUDYIEN,1,IMAGEIEN)) Q:'IMAGEIEN  D
 . S OLDSTATE=($P(^MAGDOUTP(2006.574,STUDYIEN,1,IMAGEIEN,0),"^",2))
 . I OLDSTATE="SUCCESS" Q
 . S $P(^MAGDOUTP(2006.574,STUDYIEN,1,IMAGEIEN,0),"^",2)=NEWSTATE
 . S $P(^MAGDOUTP(2006.574,STUDYIEN,1,IMAGEIEN,0),"^",3)=$H
 . K ^MAGDOUTP(2006.574,"STATE",LOCATION,PRIORITY,OLDSTATE,STUDYIEN,IMAGEIEN)
 . S ^MAGDOUTP(2006.574,"STATE",LOCATION,PRIORITY,NEWSTATE,STUDYIEN,IMAGEIEN)=""
 . S COUNT=COUNT+1
 . Q
 L -^MAGDOUTP(2006.574)
 ;
 S NOUT=NOUT+1,OUT(NOUT)="Number of updated DICOM object entries: "_COUNT
 S OUT(1)=NOUT-1
 Q
 ;
RETRY ; Entry point from option driver
 N FAILTIME,MAGERR,MAGFDA,SITE,XMITTIME
 ;
 W !!!,?7,"--- UPDATE THE RETRY TIMES FOR EXPORTING DICOM IMAGES ---"
 ;
 S SITE=$O(^MAG(2006.1,"B",DUZ(2),""))
 S XMITTIME=$$GET1^DIQ(2006.1,SITE,208)
 S FAILTIME=$$GET1^DIQ(2006.1,SITE,209)
 ;
 S XMITTIME=$$RETRY1("XMIT",XMITTIME,0) ; XMIT is disabled by default
 S FAILTIME=$$RETRY1("FAIL",FAILTIME,300) ; default for FAIL is 5 minutes
 ;
 S SITE=SITE_","
 S MAGFDA(2006.1,SITE,208)=XMITTIME
 S MAGFDA(2006.1,SITE,209)=FAILTIME
 D UPDATE^DIE("","MAGFDA",,"MAGERR")
 Q
 ;
RETRY1(STATE,ORIGINALVALUE,DEFAULTVALUE) ; function for Retry option
 N DEFAULT,DONE
 S DEFAULT=ORIGINALVALUE I DEFAULT="" S DEFAULT=DEFAULTVALUE
 S DONE=0
 F  D  Q:DONE
 . W !!,"Enter time to retry exporting an image in the ",STATE," STATE: //",DEFAULT
 . R " ",X:DTIME E  S X="^"
 . I X="" S X=DEFAULT W X
 . I X["^" S DONE=-1 Q
 . I X["?" D
 . . W !!,"Enter the number of seconds to retry transmitting an image with the ",STATE," state."
 . . W !,"Entering zero (0) will cause the retry process to be disabled."
 . . W !,"The default value is ",DEFAULT," seconds.  The minimum time is 60 seconds."
 . . Q
 . I X="@" W !,"-- Removing ",STATE," DICOM export site parameter --" S DONE=1 Q
 . I X'?1N.N W " ???" Q
 . I 'X W !,"-- Disabling retrying export of an image in the ",STATE," state --"
 . E  I X<60 W "  ???",!," -- Minimum time is 60 seconds --" Q
 . S DONE=1
 . Q
 Q X
