MAGDSTQ8 ;WOIFO/PMK - Study Tracker - Patient Level Query/Retrieve Display; Apr 06, 2020@13:36:50
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Aug 30, 2013
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
 ; Notice: This routine is on both VistA and the DICOM Gateway
 ;
 ; Supported IA #10103 reference $$HTE^XLFDT function call
 ;
 ; Display Retrieve Status
 ;
 Q
 ;
RETRIEVE ;
 N ACNUMB,BADTAGS,BADUIDS,COMMENT,COMPLETED,DONE,ERRORID,FAILED,I,MEANING,NORESULTS
 N REDISPLAY,REMAINING,STATUS,STATUSCODE,TIME,TIMEOUT,TIMESTAMP,X,WARNING
 ;
 S TIMEOUT=1
 ;
 S ACNUMB=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ACCESSION NUMBER"))
 I ACNUMB="",^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE LEVEL")="PATIENT" D
 . S ACNUMB=^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID")
 . Q
 ;
 K ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"Q/R RETRIEVE STATUS",ACNUMB)
 ;
 D DISPLAY(.REDISPLAY)
 ;
 S (DONE,NORESULTS)=0
 F  D  Q:DONE
 . I REDISPLAY D DISPLAY(.REDIPLAY)
 . F  Q:$X=0  W @IOBS," ",@IOBS ; erase the line
 . S X=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"Q/R RETRIEVE STATUS",ACNUMB))
 . I X="" D
 . . W "No retrieve results yet"
 . . S NORESULTS=NORESULTS+1
 . . F I=1:1:NORESULTS W "."
 . . I NORESULTS>45 S DONE=-1
 . . Q
 . E  D
 . . S STATE=$P(X,"|",1)
 . . S TIMESTAMP=$P(X,"|",2)
 . . S STATUSCODE=$P(X,"|",3)
 . . I STATUSCODE="" W STATE Q  ; informational message
 . . S REMAINING=+$P(X,"|",4) ; coerce null to 0
 . . S COMPLETED=+$P(X,"|",5) ; coerce null to 0
 . . S FAILED=$P(X,"|",6)
 . . S WARNING=$P(X,"|",7)
 . . S BADTAGS=$P(X,"|",8)
 . . S BADUIDS=$P(X,"|",9)
 . . S ERRORID=$P(X,"|",10)
 . . S COMMENT=$P(X,"|",11,999) ; may contain "|"
 . . S TIME=$P($$HTE^XLFDT(TIMESTAMP),"@",2)
 . . S STATUS=$$STATUS(STATUSCODE,.MEANING)
 . . I STATUS="Pending" D
 . . . I COMPLETED=0 W "No DICOM object retrieved yet"
 . . . E  I COMPLETED=1 W "One DICOM object retrieved"
 . . . E  W COMPLETED," DICOM objects retrieved"
 . . . W " -- "
 . . . I REMAINING=1 W "one DICOM object remaining"
 . . . E  W REMAINING," DICOM objects remaining"
 . . . Q
 . . E  I STATUS="Success" D
 . . . I COMPLETED=0 W "No DICOM objects were retrieved"
 . . . E  I COMPLETED=1 W "One DICOM object retrieved from """,QRSCP,""""
 . . . E  W "A total of ",COMPLETED," DICOM objects retrieved from """,QRSCP,""""
 . . . S DONE=1
 . . . Q
 . . E  I STATUS="Cancel" D
 . . . W "Retrieve operation canceled"
 . . . S DONE=1
 . . . Q
 . . E  I STATUS="Failure" D
 . . . W "Retrieve operation failed: ",MEANING
 . . . S DONE=1
 . . . Q
 . . I FAILED D
 . . . W !,"Number of failed operations: ",FAILED
 . . . S REDISPLAY=1
 . . . Q
 . . I WARNING D
 . . . W !,"Number of operations with warnings: ",WARNING
 . . . S REDISPLAY=1
 . . . Q
 . . I ERRORID'="" D
 . . . W !,"Error ID: ",ERRORID
 . . . S REDISPLAY=1
 . . . Q
 . . I COMMENT'="" D
 . . . W !,"Error Comment: ",COMMENT
 . . . S REDISPLAY=1
 . . . Q
 . . I BADTAGS'="" D
 . . . W !,"Offending Elements: ",BADTAGS
 . . . S REDISPLAY=1
 . . . Q
 . . I BADUIDS'="" D
 . . . W !,"Failed SOP Instance UIDs: ",BADUIDS
 . . . S REDISPLAY=1
 . . . Q
 . . Q
 . Q:DONE
 . W ?68,"More?"
 . R "  y// ",X:TIMEOUT
 . I X="" S X="y" W X
 . I "Yy"'[$E(X) S DONE=1
 . Q
 I DONE<1 W !,"*** Possible problem with DICOM Gateway C-Move Request process ***"
 D CONTINUE^MAGDSTQ
 Q
 ;
DISPLAY(REDISPLAY) ; refresh the top of the screen
 D DISPLAY^MAGDSTQ
 W !!!
 S REDISPLAY=0
 Q
 ;
STATUS(CODE,MEANING) ; return status codes
 ; from Table C.4-2 C-MOVE Response Status Values PS3.4 2108b
 I CODE="FF00" D  Q "Pending"
 . S MEANING="Sub-operations are continuing"
 . Q
 I CODE="FF01" D  Q "Pending"
 . S MEANING="Sub-operations are continuing but one or more Optional Keys were not supported"
 . Q
 I (CODE="0000")!(CODE=0) D  Q "Success"
 . S MEANING="Sub-operations Complete - No Failures"
 . Q
 I CODE="A700" D  Q "Failure"
 . S MEANING="Refused: Out of Resources"
 . Q
 I CODE="A701" D  Q "Failure"
 . S MEANING="Refused: Out of Resources - Unable to calculate number of matches"
 . Q
 I CODE="A702" D  Q "Failure"
  . S MEANING="Refused: Out of Resources - Unable to perform sub-operations"
  . Q
 I CODE="A801" D  Q "Failure"
 . S MEANING="Refused: Move Destination unknown"
 . Q
 I CODE="A900" D  Q "Failure"
 . S MEANING="Error: Data Set does not match SOP Class"
 . Q
 I CODE?1"C"3E D  Q "Failure"
 . S MEANING="Failed: Unable to Process"
 . Q
 I CODE="FE00" D  Q "Cancel"
 . S MEANING="Sub-operations terminated due to Cancel Indication"
 . Q
 I CODE="B000" D  Q "Warning"
 . S MEANING="Sub-operations Complete - One or more Failures"
 . Q
 S MEANING="Unknown Status Code: """_CODE_""""
 Q "???"
