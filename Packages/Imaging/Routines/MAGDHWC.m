MAGDHWC ;WOIFO/PMK/NST - Capture Consult/Procedure Request data ; 27 Aug 2010 8:40 AM
 ;;3.0;IMAGING;**10,51,46,54,106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
ENTRY ;
 ; determine the kind of message and branch appropriately
 N APTSCHED,CONSULT,DATETIME,DEL,DEL2,DEL3,DEL4,DEL5,DFN
 N DIVISION,FILLER1,FWDFROM,FMDATE,FMDATETM,GMRCIEN,HL,HL7,HL7ORC,HL7REC
 N I,IGNORE,ITYPCODE,ITYPNAME,IGNORE,MSGTYPE,OBXSEGNO,ORIGSERV,SERVICE,X,Y,Z
 I $D(GMRCMSG) M HL7=GMRCMSG
 E  I $D(XQORHSTK(0)) M HL7=XQORHSTK(0)
 E  Q  ; can't find HL7 data to handle this!
 S HL7REC=HL7(1)
 S DEL=$E(HL7REC,4),X=$P(HL7REC,DEL,2)
 F I=1:1:$L(X) S @("DEL"_(I+1))=$E(X,I)
 S FMDATETM=$$NOW^XLFDT(),FMDATE=FMDATETM\1
 ;
 ; find PID segment and get the DFN
 S I=0 I '$$FINDSEG^MAGDHW0(.HL7,"PID",.I,.X) Q  ; no PID segment
 S DFN=$P(X,DEL,3)
 ;
 ; find ORC segment and get GMRCIEN
 S I=0 I '$$FINDSEG^MAGDHW0(.HL7,"ORC",.I,.HL7ORC) Q  ; no ORC segment
 S GMRCIEN=+$P(HL7ORC,DEL,3) ; GMRC request is in ^GMR(123,GMRCIEN,...)
 ;
 D ^MAGDTR01 ; update the Read/Unread list with the data from the HL7 message
 ;
 S IGNORE=1 ; decide if service is one that requires HL7->DICOM gateway
 ;
 ; find ORC segment and check for an "OK" order control value
 I $P(HL7ORC,DEL)="OK" D  Q  ; generate message by ^MAGDHWS
 . S SERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . D SERVICE ; send this transaction to the DICOM gateway?
 . I 'IGNORE D
 . . D INIT^MAGDHW0 ; initialize variables
 . . S DATETIME=""
 . . D MESSAGE^MAGDHWS("O") ; indicates new order
 . . Q
 . Q
 ;
 I " CA CR DR OC OD "[(" "_$P(HL7ORC,DEL)_" ") D  Q  ; Discontinued order
 . S SERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . D SERVICE ; send this transaction to the DICOM gateway?
 . I 'IGNORE D
 . . D INIT^MAGDHW0 ; initialize variables
 . . S DATETIME=""
 . . D MESSAGE^MAGDHWS("C") ; Cancelled/Discontinued order
 . . Q
 . Q
 ;
 ; check for a FORWARD in the ORC segment
 I $P($P(HL7ORC,DEL,16),DEL2,5)="FORWARD" D
 . ; get previous service from REQUEST PROCESSING ACTIVITY
 . S FWDFROM=$$FWDFROM^MAGDGMRC(GMRCIEN) ; FORWARDED FROM service
 . S Y=0 I FWDFROM S Y=$G(^MAG(2006.5831,FWDFROM,0))
 . I Y D  ; forwarded from location was one in the service group
 . . N DIVISION,Z
 . . ; original service request probably was sent to DICOM Gateway
 . . S ORIGSERV=DEL2_DEL2_DEL2_FWDFROM_DEL2
 . . S ORIGSERV=ORIGSERV_$S(FWDFROM:$$GET1^DIQ(123.5,FWDFROM,.01),1:"")
 . . S ORIGSERV=ORIGSERV_DEL2_"99CON"
 . . D DIVISION(Y)
 . . S Z=$P(Y,"^",2)
 . . S ITYPNAME=$P(^MAG(2005.84,Z,0),"^",1)
 . . S ITYPCODE=$P(^MAG(2005.84,Z,2),"^",1)
 . . S ORIGSERV=ORIGSERV_DEL_ITYPCODE_DEL2_ITYPNAME_DEL2_DIVISION
 . . S (ITYPCODE,ITYPNAME)="" ; may need them nulled in ZSV^MAGDHWA
 . . S IGNORE=0
 . . Q
 . Q
 ;
 ; find ZSV segment and requested service - check if appropriate
 S I=0 I '$$FINDSEG^MAGDHW0(.HL7,"ZSV",.I,.X) Q  ; no ZSV segment
 S SERVICE=$P($P(X,DEL),DEL2,4)
 D SERVICE ; send this transaction to the DICOM gateway?
 ;
 S Z=$P(HL7ORC,DEL,1) ; Order Control
 S Y=$P(HL7ORC,DEL,5) ; Order Status
 I Z="SC" S MSGTYPE="RECEIVED" ; received
 E  I Z="RE" D  ; result
 . I Y="A" S MSGTYPE="PARTIAL RESULT" ; unsigned TIU note
 . E  I Y="CM" D  ; check for a new unsigned note
 . . I $$UNSIGNED^MAGDGMRC(GMRCIEN) D
 . . . S MSGTYPE="PARTIAL RESULT" ; unsigned TIU note
 . . . S FILLER1="GMRC-NEW UNSIGNED RESULT"
 . . . Q
 . . E  S MSGTYPE="COMPLETE RESULT"  ; signed TIU note
 . . Q
 . Q
 E  S MSGTYPE="UNKNOWN"
 ;
 ;-- patch 106: In case the service is not in file #2006.5831
 I IGNORE D  Q  ; just ignore HL7 message, don't send it to DICOM gateway
 . N I
 . I MSGTYPE["RESULT" S I=$$NEWTIU^MAGDHWA(GMRCIEN)
 . Q
 ;
 D MSH^MAGDHWA,PID^MAGDHWA,ORC^MAGDHWA,OBR^MAGDHWA,ZSV^MAGDHWA
 I '$$OBX() D  ; get OBX segment from database
 . S I=$O(HL7(""),-1)+1 S I=$$OBX^MAGDHWS(I)
 . Q
 E  D  ; process existing OBX segment
 . D OBX1
 . Q
 D ALLERGY^MAGDHWA,POSTINGS^MAGDHWA
 D OUTPUT^MAGDHW0
 Q
 ;
SERVICE ; check if the service is in the DICOM Clinical Service dictionary
 N Y
 I SERVICE D  ; ignore SERVICE if it is null
 . S Y=$G(^MAG(2006.5831,SERVICE,0))
 . S DIVISION=DEL2
 . I Y D  ; new service is of interest to DICOM Gateway
 . . D DIVISION(Y)
 . . S Z=$P(Y,"^",2)
 . . S ITYPNAME=$P(^MAG(2005.84,Z,0),"^",1)
 . . S ITYPCODE=$P(^MAG(2005.84,Z,2),"^",1)
 . . S IGNORE=0
 . . D APPOINT
 . . Q
 . Q
 Q
 ;
DIVISION(Y) ;
 S DIVISION=$P(Y,"^",3)
 S DIVISION=DIVISION_DEL2_$S(DIVISION:$$GET1^DIQ(4,DIVISION,.01),1:"")
 Q
 ;
APPOINT ; quite often the appointment is entered before the order is entered
 ; if this is the case, see if we can find the corresponding appointment
 N CLINIC,HIT,I,LOCIEN,ORDERIEN,VASD,XE,XI
 ; look for appointments for today or later - don't need VASD parameters
 D SDA^VADPT ; get the list of the appointments
 ; first check the order record for the patient location
 ; it might be the clinic for the appointment
 S HIT=0 ; indicator for finding an appointment match
 S ORDERIEN=$$GET1^DIQ(123,GMRCIEN,.03,"I")
 S LOCIEN=$S(ORDERIEN:$$GET1^DIQ(100,ORDERIEN,6,"I"),1:"")
 I LOCIEN?1N.N1";SC(" D
 . S CLINIC=+LOCIEN
 . I $$ISCLINIC^MAGDGMRC(SERVICE,CLINIC) D
 . . S I=0 F  S I=$O(^UTILITY("VASD",$J,I)) Q:'I  Q:HIT  D
 . . . S XI=^UTILITY("VASD",$J,I,"I"),XE=^("E")
 . . . ; check if there is an appointment in this clinic
 . . . I CLINIC=$P(XI,"^",2) D APPOINT1 ; select first apt. in clinic
 . . . Q
 . . Q
 . Q
 I 'HIT D  ; no appointment for the pt. location, look for other clinics
 . S I=0 F  S I=$O(^UTILITY("VASD",$J,I)) Q:'I  Q:HIT  D
 . . S XI=^UTILITY("VASD",$J,I,"I"),XE=^("E")
 . . S CLINIC=$P(XI,"^",2)
 . . I $$ISCLINIC^MAGDGMRC(SERVICE,CLINIC) D APPOINT1
 . . Q
 . Q
 K ^UTILITY("VASD",$J)
 Q
 ;
APPOINT1 ; fill the appointment schedule array
 S APTSCHED("FM DATETIME")=$P(XI,"^")
 S APTSCHED("CLINIC IEN")=CLINIC
 S APTSCHED("DATETIME")=$P(XE,"^")
 S APTSCHED("CLINIC NAME")=$P(XE,"^",2)
 S HIT=1 ; to exit loop
 Q
 ;
OBX() ; find OBX segments to determine the highest value of OBXSEGNO
 N I,X
 S OBXSEGNO=0
 S I=0 F  D  Q:I=""  ; $o through HL7 message - quit when at end
 . I $$FINDSEG^MAGDHW0(.HL7,"OBX",.I,.X) S OBXSEGNO=$P(X,DEL,1)
 . Q
 Q OBXSEGNO
 ;
OBX1 ; if there are second level OBX data, add OBX segment prefix
 N I,J
 ; add additional OBX segments to convey the Reason for the Request
 ; more than one, so can't use "I $$FINDSEG^MAGDHW0(.HL7,"OBX",.I) D  "
 S I="" F  S I=$O(HL7(I)) Q:I=""  I $P(HL7(I),DEL)="OBX" D
 . I '$D(HL7(I,1)) Q  ; no additional OBX segments needed
 . S X=$P(HL7(I),DEL,1,5) ; copy pieces 1-5 to other segments
 . S J="" F  S J=$O(HL7(I,J)) Q:'J  S HL7(I,J)=X_DEL_HL7(I,J)
 . Q
 Q
