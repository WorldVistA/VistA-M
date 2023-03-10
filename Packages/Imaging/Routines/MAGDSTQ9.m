MAGDSTQ9 ;WOIFO/PMK - Study Tracker - Query/Retrieve user ; Feb 15, 2022@10:23:02
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
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #10090 to read LOCATION file (#4)
 ;
 ;
 ; Select the DICOM Service Class Provider
 ; 
 ; Modeled after PICKSCP^MAGDACU on the DICOM Gateway
 ;
PICKSCP(DEFAULT,SCPTYPE) ; Pick the SCP for the site
 N FOUND,HIT,I,LOCATION,MAGIEN,MAGSCPTYPE,N,NEXT,NEXTDATETIME
 N USERAPP,STATNUMB,TARGET,TIMESTAMP,X
 S STATNUMB=$$STATNUMB^MAGDFCNV
 S DEFAULT=$G(DEFAULT),SCPTYPE=$G(SCPTYPE)
 S USERAPP="",(HIT,I)=0
 F  S USERAPP=$O(^MAG(2006.587,"B",USERAPP)) Q:USERAPP=""  D
 . S (FOUND,MAGIEN,TIMESTAMP)=""
 . F  S MAGIEN=$O(^MAG(2006.587,"B",USERAPP,MAGIEN)) Q:MAGIEN=""  D
 . . S NEXT=^MAG(2006.587,MAGIEN,0)
 . . S LOCATION=$P(NEXT,"^",7)
 . . S LOCATION=$$GET1^DIQ(4,LOCATION,99,"E") ; compare station numbers
 . . I LOCATION'=STATNUMB Q  ; ignore entries for other locations
 . . S MAGSCPTYPE=$P(NEXT,"^",9)
 . . I SCPTYPE'="",SCPTYPE'=MAGSCPTYPE Q  ; skip entries for other types
 . . S NEXTDATETIME=$P(NEXT,"^",8)
 . . I NEXTDATETIME>TIMESTAMP D  ; get latest version
 . . . S FOUND=NEXT,TIMESTAMP=NEXTDATETIME
 . . . Q
 . . Q
 . I FOUND'="" D
 . . S I=I+1,TARGET(I)=FOUND
 . . I USERAPP=DEFAULT S HIT=I
 . . Q
 . Q
 S N=I
 I N<1 W !!,"No Service Class Providers defined in SCU_LIST.DIC." Q ""
 F  D  Q:X'=""
 . W !,"DICOM ",$S(SCPTYPE'="":SCPTYPE_" ",1:""),"Service Class Providers"
 . S X=$X W ! F I=1:1:X W "-"
 . F I=1:1:N W !,$J(I,3)," -- ",$P(TARGET(I),"^")
 . I N=1 W " (selected)" S X=1 Q
 . W !!,"Select the provider application (1-",N,"): "
 . W:HIT HIT,"// " R X:DTIME E  S X="^"
 . I X["^" Q  ; a caret will terminate the program
 . I X="" S X=HIT W X I X="" S X="^" Q
 . I (X<1)!(X>N)!'$D(TARGET(X)) W " ??? -- try again",!! S X="" Q
 . Q
 I X["^" S X=""
 I X S X=$P(TARGET(X),"^",1)
 Q X
