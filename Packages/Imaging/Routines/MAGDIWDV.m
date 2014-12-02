MAGDIWDV ;WOIFO/PMK - Formatted listing of On Demand Routing request file ; 29 Aug 2013 10:50 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ; This is the VistA version of the DICOM Gateway MAGDIWDG routine
 ; It also includes the RPC that is used by both routines
 ;
SENDLIST ; display the list of studing in the output file
 N A,LOC,MSG,ODEVTYPE,X
 N IO,IOBS,IOF,IOHG,IOM,ION,IOPAR,IOS,IOSL,IOST,IOT,IOUPAR,IOXY,POP
 ;
 D LISTORIG^MAGDRPC1(.LOC)
 I '$G(LOC(1)) W !!,"There are no entries in the transmission queue.",! Q
 S LOC("DEFAULT")=$$KSP^XUPARAM("INST")
 ;
 D LOOKUP(.A)
 ;
 D ^%ZIS Q:POP  ; Select device quit if none
 S ODEVTYPE=$S(IO["|TRM|":"SCREEN",1:"FILE")
 ;
 D REPORT^MAGDIWDX(.LOC,.A,IO,ODEVTYPE)
 ;
 Q
 ;
LOOKUP(OUT) ; RPC = MAG DICOM GET EXPORT IMAGE STS
 ; get the summary information from ^MAGDOUTP
 N ACCNUMB,D0,D1,DATETIME,DATETIME1,GROUP,LIST,LOCATION
 N PRIORITY,REQUESTDATETIME,STATUS,STATUSNAME,USERAPP,X,Y,Z
 K OUT
 S (D0,OUT(1))=0 F  S D0=$O(^MAGDOUTP(2006.574,D0)) Q:'D0  D
 . N COUNT
 . S X=$G(^MAGDOUTP(2006.574,D0,0))
 . S USERAPP=$P(X,"^",1),GROUP=$P(X,"^",2),ACCNUMB=$P(X,"^",3)
 . S LOCATION=$P(X,"^",4),PRIORITY=$P(X,"^",5),REQUESTDATETIME=$P(X,"^",7)
 . S D1=0 F  S D1=$O(^MAGDOUTP(2006.574,D0,1,D1)) Q:'D1  D
 . . S Y=$G(^MAGDOUTP(2006.574,D0,1,D1,0)) Q:Y=""
 . . S STATUS=$P(Y,"^",2) Q:STATUS=""
 . . S DATETIME=$P(Y,"^",3) Q:DATETIME=""
 . . S COUNT(STATUS,DATETIME)=$G(COUNT(STATUS,DATETIME))+1
 . . Q
 . ;
 . ; compress the times so that all events within 10 minutes are recorded as one
 . S STATUS="" F  S STATUS=$O(COUNT(STATUS)) Q:STATUS=""  D
 . . S (DATETIME,DATETIME1)="" F  S DATETIME=$O(COUNT(STATUS,DATETIME)) Q:DATETIME=""  D
 . . . I DATETIME1="" S DATETIME1=DATETIME
 . . . E  I $$HDIFF^XLFDT(DATETIME,DATETIME1,2)<600 D  ; less than ten minutes
 . . . . S COUNT(STATUS,DATETIME1)=COUNT(STATUS,DATETIME1)+COUNT(STATUS,DATETIME)
 . . . . K COUNT(STATUS,DATETIME)
 . . . . Q
 . . . E  S DATETIME1=DATETIME
 . . . Q
 . . Q
 . ;
 . ; store the counts into report order
 . S STATUS="" F  S STATUS=$O(COUNT(STATUS)) Q:STATUS=""  D
 . . S (DATETIME,Z)="" F  S DATETIME=$O(COUNT(STATUS,DATETIME)) Q:DATETIME=""  D
 . . . I STATUS="FAIL" S STATUSNAME="BAD IMAGE"
 . . . ; assume the tranmission is completed in five minutes, if not, then it probably wasn't sent
 . . . E  I STATUS="XMIT" S STATUSNAME=$S($$HDIFF^XLFDT($H,DATETIME,2)<300:"TRANSMIT",1:"NOT SENT")
 . . . E  S STATUSNAME=STATUS
 . . . S Z=Z_"^"_STATUSNAME_"|"_DATETIME_"|"_COUNT(STATUS,DATETIME)
 . . . Q
 . . S LIST(LOCATION,USERAPP,STATUS,PRIORITY,D0)=ACCNUMB_"^"_REQUESTDATETIME_"^"_GROUP_Z
 . . Q
 . Q
 ; transfer the information to the OUT array
 S LOCATION="" F  S LOCATION=$O(LIST(LOCATION)) Q:LOCATION=""  D
 . S USERAPP="" F  S USERAPP=$O(LIST(LOCATION,USERAPP)) Q:USERAPP=""  D
 . . F STATUS="FAIL","XMIT","WAITING","SUCCESS" D
 . . . S PRIORITY="" F  S PRIORITY=$O(LIST(LOCATION,USERAPP,STATUS,PRIORITY)) Q:PRIORITY=""  D
 . . . . S D0="" F  S D0=$O(LIST(LOCATION,USERAPP,STATUS,PRIORITY,D0)) Q:D0=""  D
 . . . . . S Z=LOCATION_"^"_USERAPP_"^"_PRIORITY_"^"_D0
 . . . . . S OUT(1)=OUT(1)+1
 . . . . . S OUT(OUT(1)+1)=Z_"^"_LIST(LOCATION,USERAPP,STATUS,PRIORITY,D0)
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
