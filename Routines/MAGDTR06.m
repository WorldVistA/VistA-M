MAGDTR06 ;WOIFO/PMK - Read a DICOM image file ; 29 Sep 2008 10:51 AM
 ;;3.0;IMAGING;**46,54**;03-July-2009;;Build 1424
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
GETSITES(OUT) ; MAG DICOM CON UNREAD ACQ SITES
 N ACQSITE,ADMNSITE,I,J,LOCKTIME,PRIMARY,X
 S J=0
 S I=0 F  S I=$O(^MAG(2006.5842,I)) Q:'I  S X=^(I,0) D GETSITE1
 S OUT(1)=J
 Q
 ;
GETSITE1 ;
 S J=J+1
 S ACQSITE=$P(X,"^",1),PRIMARY=$P(X,"^",2)
 S PRIMARY=$$GET1^DIQ(4,PRIMARY,99) ; use station number
 S ADMNSITE=$P(X,"^",3),LOCKTIME=$P(X,"^",4)
 S OUT(J+1)=$$GET1^DIQ(4,ACQSITE,99)_"|"_$$GET1^DIQ(4,ACQSITE,.01)_"|"_PRIMARY_"|"_ADMNSITE_"|"_LOCKTIME
 Q
 ;
GETREAD(OUT) ; MAG DICOM CON GET TELE READER
 N ACQSITE,I,IPROCIDX,ISPECIDX,LOCKTIME,PRIMARY,XACQSITE,X,XDUZ,XPROCIDX,XSPECIDX
 N ADMNPROC,ADMNSITE,ADMNSPEC,USERPREF
 ;
 S (I,XDUZ)=0
 F  S XDUZ=$O(^MAG(2006.5843,"B",DUZ,XDUZ)) Q:'XDUZ  S XACQSITE=0 D
 . F  S XACQSITE=$O(^MAG(2006.5843,XDUZ,1,XACQSITE)) Q:'XACQSITE  D
 . . S X=^MAG(2006.5843,XDUZ,1,XACQSITE,0)
 . . S ACQSITE=$P(X,"^",1),ADMNSITE=$P(X,"^",2)
 . . S PRIMARY=$P(^MAG(2006.5842,ACQSITE,0),"^",2),LOCKTIME=$P(^(0),"^",4)
 . . S PRIMARY=$$GET1^DIQ(4,PRIMARY,99) ; use station number
 . . ; an inactive site in file 2006.5842 overrides the active for the user
 . . I ADMNSITE S ADMNSITE=$P(^MAG(2006.5842,ACQSITE,0),"^",3)  ; site is not active
 . . S XSPECIDX=0
 . . F  S XSPECIDX=$O(^MAG(2006.5843,XDUZ,1,XACQSITE,1,XSPECIDX)) Q:'XSPECIDX  D
 . . . S X=^MAG(2006.5843,XDUZ,1,XACQSITE,1,XSPECIDX,0)
 . . . S ISPECIDX=$P(X,"^",1),ADMNSPEC=$P(X,"^",2)
 . . . S XPROCIDX=0
 . . . F  S XPROCIDX=$O(^MAG(2006.5843,XDUZ,1,XACQSITE,1,XSPECIDX,1,XPROCIDX)) Q:'XPROCIDX  D
 . . . . S X=^MAG(2006.5843,XDUZ,1,XACQSITE,1,XSPECIDX,1,XPROCIDX,0)
 . . . . S IPROCIDX=$P(X,"^",1),ADMNPROC=$P(X,"^",2),USERPREF=$P(X,"^",3)
 . . . . S X=$$GET1^DIQ(4,ACQSITE,99)_"|"_$$GET1^DIQ(4,ACQSITE,.01)
 . . . . S X=X_"|"_PRIMARY_"|"_ADMNSITE_"|"_LOCKTIME
 . . . . S X=X_"|"_ISPECIDX_"|"_$$GET1^DIQ(2005.84,ISPECIDX,.01)_"|"_ADMNSPEC
 . . . . S X=X_"|"_IPROCIDX_"|"_$$GET1^DIQ(2005.85,IPROCIDX,.01)_"|"_ADMNPROC
 . . . . S X=X_"|"_USERPREF
 . . . . S I=I+1,OUT(I+1)=X
 . . . . Q
 . . . Q
 . . Q
 . Q
 S OUT(1)=I
 Q
 ;
SETREAD(OUT,STATNUMB,ISPECIDX,IPROCIDX,USERPREF) ;  MAG DICOM CON SET TELE READER
 N ACQSITE,IENDUZ,IENSITE,IENSPEC,IENPROC,X
 I '$G(STATNUMB) S OUT="-1, ACQUISITION STATION NUMBER PARAMETER IS NOT DEFINED"
 E  I '$G(ISPECIDX) S OUT="-2, SPECIALTY PARAMETER IS NOT DEFINED"
 E  I '$G(IPROCIDX) S OUT="-3, PROCEDURE PARAMETER IS NOT DEFINED"
 E  I '$D(USERPREF) S OUT="-4, USER PREFERENCE SELCTION IS NOT DEFINED"
 E  I USERPREF'=0,USERPREF'=1 S OUT="-5, ILLEGAL VALUE FOR USER PREFERENCE: <<"_USERPREF_">>"
 E  D
 . S IENDUZ=$O(^MAG(2006.5843,"B",DUZ,0))
 . I 'IENDUZ S OUT="-6, USER (DUZ) #"_DUZ_" IS NOT DEFINED IN FILE 2006.5849" Q
 . ;
 . S ACQSITE=+$$ACQSITE(STATNUMB)
 . I ACQSITE<0 S OUT="-7, ACQUISITION STATION NUMBER "_STATNUMB_" IS NOT DEFINED IN FILE 4" Q
 . ;
 . S IENSITE=$O(^MAG(2006.5843,IENDUZ,1,"B",ACQSITE,0))
 . I 'IENSITE S OUT="-8, ACQUISITION SITE #"_ACQSITE_" IS NOT DEFINED IN FILE 2006.5849" Q
 . ;
 . S IENSPEC=$O(^MAG(2006.5843,IENDUZ,1,IENSITE,1,"B",ISPECIDX,0))
 . I 'IENSPEC S OUT="-9, SPECIALTY #"_ISPECIDX_" IS NOT DEFINED IN FILE 2006.5849" Q
 . ;
 . S IENPROC=$O(^MAG(2006.5843,IENDUZ,1,IENSITE,1,IENSPEC,1,"B",IPROCIDX,0))
 . I 'IENPROC S OUT="-10, PROCEDURE #"_IPROCIDX_" IS NOT DEFINED IN FILE 2006.5849" Q
 . ;
 . I $D(^MAG(2006.5843,IENDUZ,1,IENSITE,1,IENSPEC,1,IENPROC,0)) S X=^(0) D
 . . I $P(X,"^",3)=USERPREF S OUT="2, USER PREFERENCE ALREADY SET"
 . . E  D
 . . . S $P(^MAG(2006.5843,IENDUZ,1,IENSITE,1,IENSPEC,1,IENPROC,0),"^",3)=USERPREF
 . . . S OUT="1, USER PREFERENCE SET"
 . . . Q
 . . Q
 . E  S OUT="-10, PROCEDURE #"_IPROCIDX_" IS NOT DEFINED IN FILE 2006.5849"
 . Q
 Q
 ;
ACQSITE(STATNUMB) ; lookup an institution by the station number
 N D,DIC,U,X,Y
 S DIC="^DIC(4," ; INSTITUTION is file #4 
 S D="D" ; use the "D" cross-reference
 S DIC(0)="X" ; only find the exact matching entry
 S X=STATNUMB
 D IX^DIC
 Q Y
