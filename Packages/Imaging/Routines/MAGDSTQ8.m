MAGDSTQ8 ;WOIFO/PMK - Study Tracker - Patient Level Query/Retrieve Display; Apr 07, 2022@11:34:20
 ;;3.0;IMAGING;**231,333**;Mar 19, 2002;Build 2
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
 ; Notice: This routine is on both VistA and the DICOM Gateway
 ;
 ; Supported IA #10103 reference $$HTE^XLFDT function call
 ;
 ; Display Retrieve Status
 ;
 Q
 ;
RETRIEVE ;
 N A,ACNUMB,BADTAGS,BADUIDS,COMMENT,COMPLETED,DONE,ERRORID,FAILED,I,K,MEANING,NORESULTS
 N REDISPLAY,REMAINING,STATUS,STATUSCODE,TIMEOUT,TIMESTAMP,X,WARNING
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
 . . S STATUSCODE=$$PARSE(X)
 . . I STATUSCODE="" W STATE Q  ; informational message
 . . ;
 . . S STATUS=$$STATUS(STATUSCODE,.MEANING)
 . . I STATUS="Success" D
 . . . I COMPLETED=0 W "No DICOM objects were retrieved"
 . . . E  I COMPLETED=1 W "One DICOM object retrieved from """,QRSCP,""""
 . . . E  W "A total of ",COMPLETED," DICOM objects retrieved from """,QRSCP,""""
 . . . S DONE=1
 . . . Q
 . . E  D
 . . . D STATUSTEXT(.A)
 . . . F K=1:1:A(0) W:K>1 ! W A(K)
 . . . W:K>1 ! ; so that the last line isn't erased
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
PARSE(X) ; $piece apart the result string and store into variables
 S STATE=$P(X,"|",1)
 S TIMESTAMP=$P(X,"|",2)
 S STATUSCODE=$P(X,"|",3)
 I STATUSCODE="" D
 . ; nothing more, just an informational message
 . Q 
 E  D  ; c-move result data
 . S REMAINING=+$P(X,"|",4) ; coerce null to 0
 . S COMPLETED=+$P(X,"|",5) ; coerce null to 0
 . S FAILED=$P(X,"|",6)
 . S WARNING=$P(X,"|",7)
 . S BADTAGS=$P(X,"|",8)
 . S BADUIDS=$P(X,"|",9)
 . S ERRORID=$P(X,"|",10)
 . S COMMENT=$P(X,"|",11,999) ; may contain "|"
 . Q
 Q STATUSCODE
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
 ;
STATUSTEXT(A) ; formulate status text
 K A,X
 I STATUS="Pending" D
 . I COMPLETED=0 S X="No DICOM object retrieved yet"
 . E  I COMPLETED=1 S X="One DICOM object retrieved"
 . E  S X=COMPLETED_" DICOM objects retrieved"
 . S X=X_" -- "
 . I REMAINING=1 S X=X_"one DICOM object remaining"
 . E  S X=X_REMAINING_" DICOM objects remaining"
 . D TEXT(X)
 . Q
 E  I STATUS="Cancel" D
 . D TEXT("Retrieve operation canceled -- "_MEANING)
 . S DONE=1
 . Q
 E  I STATUS="Failure" D
 . D TEXT("Retrieve operation failed -- "_MEANING)
 . S DONE=1
 . Q
 I FAILED D
 . D TEXT("Number of failed operations: "_FAILED)
 . S REDISPLAY=1
 . Q
 I WARNING D
 . D TEXT("Number of operations with warnings: "_WARNING)
 . S REDISPLAY=1
 . Q
 I ERRORID'="" D
 . D TEXT("Error ID: "_ERRORID)
 . S REDISPLAY=1
 . Q
 I COMMENT'="" D
 . D TEXT("Error Comment: "_COMMENT)
 . S REDISPLAY=1
 . Q
 I BADTAGS'="" D
 . D TEXT("Offending DICOM Elements: "_BADTAGS)
 . S REDISPLAY=1
 . Q
 I BADUIDS'="" D
 . D TEXT("Failed SOP Instance UIDs: "_BADUIDS)
 . S REDISPLAY=1
 . Q
 I STATUS="???" D
 . D TEXT(MEANING)
 . Q
 Q
 ;
TEXT(TEXT) ; save the text in the "A" array
 S A(0)=$G(A(0),0)+1
 S A(A(0))=TEXT
 Q
