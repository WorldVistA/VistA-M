MAGDHOWC ;WOIFO/PMK - Capture Consult/Procedure Request data ; 27 Nov 2012 12:32 PM
 ;;3.0;IMAGING;**138,174**;Mar 19, 2002;Build 30;Sep 03, 2013
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
 N APTSCHED,DEL,DEL2,DEL3,DEL4,DEL5,DFN,FILLER2,GMRCIEN,HL7,HL7MSH,HL7ORC
 N I,SERVICE
 ;
 I $D(GMRCMSG) M HL7=GMRCMSG
 E  I $D(XQORHSTK(0)) M HL7=XQORHSTK(0)
 E  Q  ; can't find HL7 data to handle this!
 S HL7MSH=HL7(1)
 S DEL=$E(HL7MSH,4),X=$P(HL7MSH,DEL,2)
 F I=1:1:$L(X) S @("DEL"_(I+1))=$E(X,I)
 ;
 ; find PID segment and get the DFN
 S I=0 I '$$FINDSEG^MAGDHOW0(.HL7,"PID",.I,.X) Q  ; no PID segment
 S DFN=$P(X,DEL,3)
 ;
 ; find ORC segment and get GMRCIEN
 S I=0 I '$$FINDSEG^MAGDHOW0(.HL7,"ORC",.I,.HL7ORC) Q  ; no ORC segment
 S GMRCIEN=+$P(HL7ORC,DEL,3) ; GMRC request is in ^GMR(123,GMRCIEN,...)
 ;
 D ^MAGDTR01 ; update the Read/Unread list with the data from the HL7 message
 ;
 S SERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 D APTSCHED(GMRCIEN,SERVICE,.APTSCHED) ; get appointment scheduling information
 ;
 I $P($P(HL7ORC,DEL,16),DEL2,5)="FORWARD" D  ; check for a forwarded request
 . N FROMSERVICE ; original service
 . ; send an order cancellation to the original service
 . S FILLER2="GMRC-CANCELLED" ; override actual GMRC status
 . S FROMSERVICE=$$FWDFROM^MAGDGMRC(GMRCIEN) ; FORWARDED FROM service
 . ;
 . ; cancel the original order to the original service
 . D MSGSETUP^MAGDHOW1(GMRCIEN,FROMSERVICE,"CA","CA") ; cancel order
 . K FILLER2 ; use only for the first cancellation message
 . ;
 . ; send a new order to the new service
 . D MSGSETUP^MAGDHOW1(GMRCIEN,SERVICE,"NW","IP",.APTSCHED) ; new order
 . Q
 ;
 E  D  ; normal processing
 . N ORC1,ORC5
 . S ORC1=$P(HL7ORC,DEL,1) ; original HL7 message order control
 . S ORC5=$P(HL7ORC,DEL,5) ; original HL7 message order status
 . D MSGSETUP^MAGDHOW1(GMRCIEN,SERVICE,ORC1,ORC5,.APTSCHED) ; regular transaction
 Q
 ;
APTSCHED(GMRCIEN,SERVICE,APTSCHED) ; get appointment scheduling information
 ;
 ; first check if the appointment information is in the comment
 I $$CHECKCMT(GMRCIEN,.APTSCHED) Q
 ;
 ; no appointment information in th comment
 ; check if there is an appointment that was previously scheduled
 D CHECKAPT(GMRCIEN,SERVICE,.APTSCHED)
 Q
 ;
CHECKCMT(GMRCIEN,APTSCHED)  ; check if appointment is scheduled (Patch SD*5.3*478)
 N COMMENT,DATETIME,I,SCHEDULE,SS1,SS2,X,Y
 K APTSCHED
 S SCHEDULE=""
 F I=1:1 D  Q:DATETIME=""
 . S SS1=I_","_GMRCIEN ; subscript for file #123.02
 . S DATETIME=$$GET1^DIQ(123.02,SS1,.01) Q:DATETIME=""
 . S SS2="1,"_SS1 ; subscript for file #123.25
 . S COMMENT=$$GET1^DIQ(123.25,SS2,.01) Q:COMMENT=""
 . I COMMENT[" Consult Appt. on " S SCHEDULE=COMMENT
 . Q
 I SCHEDULE'="" D
 . N %DT
 . S X=$P(SCHEDULE," Consult Appt. on ",1)
 . S Y=$S(X'="":$O(^SC("B",X,"")),1:"") ; clinic name could be null - their bug
 . S APTSCHED("CLINIC IEN")=Y ; <file #44 ien>
 . S APTSCHED("CLINIC NAME")=X
 . S X=$P(SCHEDULE," Consult Appt. on ",2)
 . S X=$TR(X," "),%DT="T" D ^%DT ; remove spaces & convert to FM format
 . S APTSCHED("FM DATETIME")=Y
 . Q
 Q (SCHEDULE'="")
 ;
CHECKAPT(GMRCIEN,SERVICE,APTSCHED)  ; check if appointment was previously scheduled
 ; quite often the appointment is entered before the order is entered
 ; if this is the case, see if we can find the corresponding appointment
 N A,CLINIC,DATETIME,EARLIEST,HIT,I,J,SDAMDFN,SDAMGMRCIEN,SS
 ;
 D SDA^VADPT ; get the list of the appointments
 M A=^UTILITY("VASD",$J) K ^UTILITY("VASD",$J)
 ;
 ; remove appointments for other clinics
 S I=0 F  S I=$O(A(I)) Q:'I  D
 . S CLINIC=$P(A(I,"I"),"^",2)
 . I '$$ISCLINIC(GMRCIEN,SERVICE,CLINIC) K A(I)
 . Q
 ; remove appointments for other consult/procedure requests
 S (HIT,I)=0 F  S I=$O(A(I)) Q:'I  D
 . S DATETIME=$P(A(I,"I"),"^",1),CLINIC=$P(A(I,"I"),"^",2)
 . F J=1:1 D  Q:'SDAMDFN
 . . S SS=J_","_DATETIME_","_CLINIC
 . . S SDAMDFN=$$GET1^DIQ(44.003,SS,.01,"I")
 . . I SDAMDFN=DFN D
 . . . S SDAMGMRCIEN=$$GET1^DIQ(44.003,SS,688,"I")
 . . . I SDAMGMRCIEN=GMRCIEN S HIT=I ; found one for this consult!
 . . . E  I SDAMGMRCIEN'="" K A(I)
 . . . ; keep ones without consult pointer 
 . . . Q
 . . Q
 . Q
 ;
 I 'HIT D  ; get the earliest possible date for the appointment
 . S EARLIEST=$$GET1^DIQ(123,GMRCIEN,17,"I")
 . I EARLIEST D
 . . S I=0 F  S I=$O(A(I)) Q:'I  D  Q:HIT
 . . . I A(I,"I")>EARLIEST S HIT=I
 . . . Q
 . . Q
 . E  S HIT=$O(A("")) ; pick the earliest scheduled appointment
 . Q
 ;
 I HIT D
 . S APTSCHED("FM DATETIME")=$P(A(HIT,"I"),"^",1)
 . S APTSCHED("CLINIC IEN")=$P(A(HIT,"I"),"^",2)
 . S APTSCHED("DATETIME")=$P(A(HIT,"E"),"^",1)
 . S APTSCHED("CLINIC NAME")=$P(A(HIT,"E"),"^",2)
 . S FILLER2="GMRC-SCHEDULED" ; over-ride GMRC's status
 . ; Note: If the study has been completed, FILLER2 will be killed in
 . ;       MAGSETUP^MAGHOW1 so that GMRC's actual status will be used.
 . Q
 Q
 ;
ISCLINIC(GMRCIEN,SERVICE,CLINIC) ; is a particular clinic defined for a given service?
 N IEN,ISCLINIC
 S ISCLINIC=0
 I GMRCIEN,SERVICE,CLINIC D
 . S IEN=$$MWLFIND^MAGDHOW1(SERVICE,GMRCIEN)
 . I IEN,$D(^MAG(2006.5831,IEN,1,"B",CLINIC)) S ISCLINIC=1
 . Q
 Q ISCLINIC
