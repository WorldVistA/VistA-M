MAGDRPC8 ;WOIFO/EdM - RPCs for Master Files ; 24 Jul 2008 4:26 PM
 ;;3.0;IMAGING;**11,30,51,54**;03-July-2009;;Build 1424
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
UPDTAPP(OUT,APP) ; RPC = MAG DICOM UPDATE SCU LIST
 N A,D0,D1,DIMSE,GWLOC,GWNAM,HDR,I,MIN,N,NOW,P5,P7,PLUS,SERVNAM,UP,X
 S (GWNAM,GWLOC)="",N=0
 S A="" F  S A=$O(APP(A)) Q:A=""  D
 . Q:A["_"
 . S X=APP(A) F I=1:1:7 S:$P(X,"^",I)="" N=N+1
 . S:GWNAM="" GWNAM=$P(X,"^",5)
 . S:GWLOC="" GWLOC=$P(X,"^",7)
 . S:GWNAM'=$P(X,"^",5) N=N+1
 . S:GWLOC'=$P(X,"^",7) N=N+1
 . S:'N A($P(X,"^",1))=A ; ^MAGDMFBS guarantees unique names
 . Q
 I N S OUT="-1,Missing or Inconsistent Parameters." Q
 ;
 L +^MAG(2006.587,0):1E9 ; Background task MUST wait
 S HDR=$G(^MAG(2006.587,0))
 S $P(HDR,"^",1,2)="DICOM TRANSMIT DESTINATION^2006.587"
 ;
 S NOW=$$NOW^XLFDT(),(MIN,PLUS,UP)=0
 ;
 S D0="" F  S D0=$O(^MAG(2006.587,"D",GWNAM,GWLOC,D0)) Q:D0=""  D
 . S X=$G(^MAG(2006.587,D0,0)),SERVNAM=$P(X,"^",1) Q:SERVNAM=""
 . S P5=$P(X,"^",5),P7=$P(X,"^",7)
 . I P5'="",P7'="" K ^MAG(2006.587,"C",SERVNAM,P7,P5,D0),^MAG(2006.587,"D",P5,P7,D0)
 . I '$D(A(SERVNAM)) D  Q
 . . K ^MAG(2006.587,D0),^MAG(2006.587,"B",SERVNAM,D0) S MIN=MIN+1
 . . Q
 . S X=APP(A(SERVNAM)),$P(X,"^",8)=NOW K APP(A(SERVNAM))
 . S ^MAG(2006.587,D0,0)=$P(X,"^",1,8),UP=UP+1
 . S ^MAG(2006.587,"C",SERVNAM,GWLOC,GWNAM,D0)=""
 . S ^MAG(2006.587,"D",GWNAM,GWLOC,D0)=""
 . K DIMSE S DIMSE=A(SERVNAM)_"_"
 . S X=DIMSE F  S X=$O(APP(X)) Q:$E(X,1,$L(DIMSE))'=DIMSE  D
 . . S N=$P(X,"_",2) Q:N=""
 . . S DIMSE(N)=APP(X)
 . . S DIMSE("C-ECHO")="1^1"
 . . Q
 . K ^MAG(2006.587,D0,1)
 . S D1=0,X="" F  S X=$O(DIMSE(X)) Q:X=""  D
 . . S D1=D1+1,^MAG(2006.587,D0,1,D1,0)=X_"^"_DIMSE(X)
 . . S ^MAG(2006.587,D0,1,"B",X,D1)=""
 . . Q
 . S:D1 ^MAG(2006.587,D0,1,0)="^2006.5871SA^"_D1_"^"_D1
 . Q
 S $P(HDR,"^",4)=$P(HDR,"^",4)-MIN
 ;
 S A="" F  S A=$O(APP(A)) Q:A=""  D
 . Q:A["_"
 . S X=APP(A),$P(X,"^",8)=NOW
 . S D0=$O(^MAG(2006.587," "),-1)+1,PLUS=PLUS+1,$P(HDR,"^",3)=D0
 . S ^MAG(2006.587,D0,0)=$P(X,"^",1,8),SERVNAM=$P(X,"^",1)
 . S ^MAG(2006.587,"B",SERVNAM,D0)=""
 . S ^MAG(2006.587,"C",SERVNAM,GWLOC,GWNAM,D0)=""
 . S ^MAG(2006.587,"D",GWNAM,GWLOC,D0)=""
 . K DIMSE S DIMSE=A_"_"
 . S X=DIMSE F  S X=$O(APP(X)) Q:$E(X,1,$L(DIMSE))'=DIMSE  D
 . . S N=$P(X,"_",2) Q:N=""
 . . S DIMSE(N)=APP(X)
 . . S DIMSE("C-ECHO")="1^1"
 . . Q
 . K ^MAG(2006.587,D0,1)
 . S D1=0,X="" F  S X=$O(DIMSE(X)) Q:X=""  D
 . . S D1=D1+1,^MAG(2006.587,D0,1,D1,0)=X_"^"_DIMSE(X)
 . . S ^MAG(2006.587,D0,1,"B",X,D1)=""
 . . Q
 . S:D1 ^MAG(2006.587,D0,1,0)="^2006.5871SA^"_D1_"^"_D1
 . Q
 S (N,D0)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  S N=N+1
 S $P(HDR,"^",4)=N
 S ^MAG(2006.587,0)=HDR
 L -^MAG(2006.587,0)
 S OUT="1"
 S:PLUS OUT=OUT_", "_PLUS_" added"
 S:MIN OUT=OUT_", "_MIN_" removed"
 S:UP OUT=OUT_", "_UP_" updated"
 Q
 ;
UPDTGW(OUT,ONAM,NNAM,OLOC,NLOC) ; RPC = MAG DICOM UPDATE GATEWAY NAME
 N D0,P1,P5,P7,N
 I $G(NNAM)="" S OUT="-1,No Gateway Name specified" Q
 I '$G(NLOC) S OUT="-2,No Gateway Location specified" Q
 S OLOC=$G(OLOC),ONAM=$G(ONAM)
 S (N,D0)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.587,D0,0)),P5=$P(X,"^",5) Q:P5'=ONAM
 . S P1=$P(X,"^",1),P7=$P(X,"^",7)
 . I OLOC'="",P5'="",P1'="" K ^MAG(2006.587,"C",P1,OLOC,P5,D0)
 . I OLOC'="",P5'="" K ^MAG(2006.587,"D",P5,OLOC,D0)
 . S $P(X,"^",5)=NNAM,$P(X,"^",7)=NLOC
 . S ^MAG(2006.587,D0,0)=X
 . S:P1'="" ^MAG(2006.587,"C",P1,NLOC,NNAM,D0)=""
 . S ^MAG(2006.587,"D",NNAM,NLOC,D0)=""
 . S N=N+1
 . Q
 S OUT=N
 Q
 ;
SIBS(P0,T) N MAGLOC,P1,P2
 S T(P0)=""
 D SIBLING^XUAF4("MAGLOC",P0,"PARENT FACILITY") ; General API, IA #2171
 S P1="" F  S P1=$O(MAGLOC("P",P1)) Q:P1=""  D
 . S P2="" F  S P2=$O(MAGLOC("P",P1,"C",P2)) Q:P2=""  S T(P2)=""
 . Q
 Q
 ;
LOCS(OUT) ; RPC = MAG DICOM VALID LOCATIONS
 N D0,I,MAGM,N,P1,MAGR,T
 S N=1
 S D0=0 F  S D0=$O(^MAG(2006.1,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.1,D0,0)),P1=$P(X,"^",1) Q:P1=""
 . I +P1=P1 S T(P1)="" Q
 . D FIND^DIC(4,"","","BX",P1,"*","","","","MAGR","MAGM") ; IA #4389
 . S I=0 F  S I=$O(MAGR("DILIST",2,I)) Q:'I  D
 . . S P1=MAGR("DILIST",2,I) I P1 K MAGR S T(P1)=""
 . . Q
 . Q
 I $T(+1^XUPARAM)'="" S P1=$$KSP^XUPARAM("INST") D:P1 SIBS(P1,.T)
 S P1=+$G(^DD("SITE",1)) D:P1 SIBS(P1,.T)
 ;
 S P1="" F  S P1=$O(T(P1)) Q:P1=""  D
 . S N=N+1,OUT(N)=P1_"^"_$$GET1^DIQ(4,P1,.01)_"^"_$$GET1^DIQ(4,P1,99)
 . Q
 S OUT(1)=N-1
 Q
 ;
GETPLACE(OUT,LOCATION) ; RPC = MAG DICOM GET PLACE
 N D0,P1,MAGM,MAGR,X
 S LOCATION=+$G(LOCATION)
 S OUT="-1,Location """_LOCATION_""" not found."
 S D0=0 F  S D0=$O(^MAG(2006.1,D0)) Q:'D0  D  Q:OUT>0
 . S X=$G(^MAG(2006.1,D0,0)),P1=$P(X,"^",1) Q:P1=""
 . I +P1=P1,LOCATION=P1 S OUT=D0 Q
 . D FIND^DIC(4,"","","BX",P1,"*","","","","MAGR","MAGM")
 . S I=0 F  S I=$O(MAGR("DILIST",2,I)) Q:'I  D
 . . I LOCATION=MAGR("DILIST",2,I) S OUT=D0
 . . Q
 . Q
 Q
 ;
SETPACS(OUT,D0) ; RPC = MAG DICOM SET PACS PARAMS
 N X
 I '$G(D0) S OUT="-1,No Place Specified." Q
 I '$D(^MAG(2006.1,D0)) S OUT="-2,Invalid Place Specified." Q
 ;
 ; There is a PACS
 S $P(^MAG(2006.1,D0,"PACS"),"^",1)=1
 ;
 ; Number of days to retain "PACS" images
 S X=$P($G(^MAG(2006.1,D0,1)),"^",5)
 S:'X $P(^MAG(2006.1,D0,1),"^",5)=30
 ;
 ; Set minimum % of free disk space to trigger automatic file delete
 S X=$P($G(^MAG(2006.1,D0,3)),"^",6)
 S:'X $P(^MAG(2006.1,D0,3),"^",6)=25
 S OUT=1
 Q
 ;
HIGHHL7(OUT) ; RPC = MAG DICOM GET HIGHEST HL7
 S OUT=+$O(^MAGDHL7(2006.5," "),-1)
 Q
 ;
FINDLOC(OUT,NAME) ; RPC = MAG DICOM FIND LOCATION
 N I,MAGM,P1,MAGR,X
 S OUT="-1,Invalid location """_NAME_"""."
 D FIND^DIC(4,"",.01,"BXA",NAME,"*","","","","MAGR","MAGM")
 S I=0 F  S I=$O(MAGR("DILIST",2,I)) Q:'I  D
 . S P1=MAGR("DILIST",2,I) I P1 K MAGR S OUT=P1
 . Q
 Q
 ;
VALIMGT(OUT) ; RPC = MAG DICOM GET IMAGING TYPES
 N N,X
 S N=1
 ; Lists of valid imaging types
 S X="" F  S X=$O(^RA(79.2,"C",X)) Q:X=""  S N=N+1,OUT(N)="RAD^"_X
 S X="" F  S X=$O(^MAG(2005.84,"C",X)) Q:X=""  S N=N+1,OUT(N)="CON^"_X
 S OUT(1)=N-1
 Q
 ;
CORRECT(OUT,LOCATION,MACHID) ; RPC = MAG DICOM INCORRECT IMAGE CT
 ; Check for images needing corrections
 N CNT,D0,STUDY
 I '$G(LOCATION) S OUT="-1,No Location Specified" Q
 I $G(MACHID)="" S OUT="-2,No Gateway Specified" Q
 S OUT=0
 Q:'$O(^MAGD(2006.575,0))
 Q:'$D(^MAGD(2006.575,"F",LOCATION))
 S STUDY="" F  S STUDY=$O(^MAGD(2006.575,"F",LOCATION,STUDY)) Q:STUDY=""  D
 . S D0=0 S D0=$O(^MAGD(2006.575,"F",LOCATION,STUDY,D0)) Q:'D0  D
 . . Q:'$D(^MAGD(2006.575,D0,0))
 . . S:MACHID=$P($G(^MAGD(2006.575,D0,1)),"^",4) OUT=OUT+1
 . . Q
 . Q
 Q
 ;
HL7PTR(OUT,ACTION,VALUE) ; RPC = MAG DICOM HL7 POINTER ACTION
 ; Manipulate HL7 Pointer
 N D0,P1,P2,X,Y
 S ACTION=$G(ACTION),VALUE=$G(VALUE)
 S OUT="-2,Invalid Request: """_ACTION_"""."
 I ACTION="GetDate" D  Q
 . S X=$G(^MAGDHL7(2006.5,+VALUE,0))
 . I X="" S OUT="-1,Invalid Pointer """_VALUE_"""." Q
 . S OUT=$$FMTE^XLFDT($P(X,"^",3),1)
 . Q
 I ACTION="DatePtr" D  Q
 . S Y=$O(^MAGDHL7(2006.5,"C",VALUE),-1)
 . I 'Y D  ; before any date on file
 . . ; if the requested date is before the first entry,
 . . ; move the pointer to the first entry
 . . S OUT=0
 . . Q
 . E  D  ; if the requested date is in the cross reference, use it.
 . . S Y=$O(^MAGDHL7(2006.5,"C",Y,""))
 . . I Y S OUT=Y ; found date
 . . E  D
 . . . ; otherwise, find the appropriate entry the hard way
 . . . S D0=$O(^MAGDHL7(2006.5,0))
 . . . S Y=$P($G(^MAGDHL7(2006.5,D0,0)),"^",3) I Y'<X S OUT=0 Q
 . . . S D0=" " F  S D0=$O(^MAGDHL7(2006.5,D0),-1) Q:'D0  D  Q:OUT
 . . . . S Y=$P($G(^MAGDHL7(2006.5,D0,0)),"^",3) S:Y<X OUT=D0
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
