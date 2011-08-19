SRHLZIU ;B'HAM ISC/DLR - Surgery Interface Sender of Scheduling Information Unsolicited ; [ 05/19/98  9:35 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
MSG(CASE,SRSTATUS,SREVENT) ;Send ZSQ message.
 ;This message is sent for every event point within the surgery options.
 ;There will be a ZIU message sent for each of the following surgery
 ;events: S12 New Appointment; S13 Reschedule; S14 Modification; 
 ;S15 Cancellation; and S17 Deletion.  The events codes are set to
 ;SREVENT within the surgery routine options.
 ;
START ;
 I $$V^SRHLU D MSG^SRHLVZIU(CASE,SRSTATUS,SREVENT) Q
 S HLDAP=$O(^HL(771,"B","SR SURGERY",0)) Q:$G(HLDAP)=""
 Q:$P($G(^HL(771,HLDAP,0)),U,2)'="a"
 K ^TMP("HLS",$J)
 N HLSUB,HLREP,SRX,SRDSP,SRET,UPDATE,PRT,OUT
 ;V. 1.6 interface
 ;EID - IEN of event protocol
 ;HL - array of output parameters
 ;INT - only for VISTA-to-VISTA message exchange
 ;SRET - Surgery Event Trigger
 D EVNTP
 S EID=$O(^ORD(101,"B",SRET,0)),HL="HL",INT=0
 D INIT^HLFNC2(EID,.HL,INT) S HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4),HLFS=HL("FS"),HLQ=HL("Q"),HLECH=HL("ECH")
 ;Q:'$O(HL("")) ;read HL for the error message 
 D SEG
 D CHECK I $D(UPDATE) D GEN,DISPLAY
EXIT ;
 K EID,HL,INT,^TMP("HLS",$J)
 Q
GEN ;generate the message
 ;HLEID - IEN of event protocol
 ;HLARYTYP - acknowledgement array (see V. 1.6 HL7 doc)
 ;HLFORMAT - is HLMA is pre-formatted HL7 form
 ;HLMTIEN - IEN in 772
 ;HLRESLT - message ID and/or the error message (for output)
 ;HLP("CONTPTR") - continuation pointer field value (not used)
 ;HLP("PRIORITY") - priority field value (not used)
 ;HLP("SECURITY") - security information (not used)
 S HLEID=EID,HLARYTYP="GM",HLFORMAT=1,HLMTIEN="",HLRESLT=""
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT,HLMTIEN,.HLP)
 Q
SEG ;segments
 N SRI
 S SRI=1
 D ZCH^SRHLUO1(.SRI,.SREVENT,.SRSTATUS,"HLS")
 D PID^SRHLUO(.SRI,"HLS")
 D AL1^SRHLUO(.SRI,"HLS")
 D OBX^SRHLUO(.SRI,"HLS")
 D DG1^SRHLUO(.SRI,"HLS")
 D ZIS^SRHLUO2(.SRI,"HLS")
 D ZIG^SRHLUO1(.SRI,"HLS")
 D ZIP^SRHLUO1(.SRI,"HLS")
 D ZIL^SRHLUO1(.SRI,"HLS")
 Q
CHECK ;checks ^XTMP for duplicate modification messages
 N X
 I $D(^XTMP("SRHL7"_CASE,EID,0)) D
 .S X=0 F  S X=$O(^TMP("HLS",$J,X)) Q:'X!($D(UPDATE))  D
 ..I '$D(^XTMP("SRHL7"_CASE,EID,X)) S UPDATE=1 Q
 ..I ^TMP("HLS",$J,X)'=^XTMP("SRHL7"_CASE,EID,X) S UPDATE=1
 .I $O(^XTMP("SRHL7"_CASE,EID,X)) S UPDATE=1
 I '$D(^XTMP("SRHL7"_CASE,EID,0))!$D(UPDATE) K ^XTMP("SRHL7"_CASE,EID) S UPDATE=1,^XTMP("SRHL7"_CASE,EID,0)=DT D
 .S X=0 F  S X=$O(^TMP("HLS",$J,X)) Q:'X  S ^XTMP("SRHL7"_CASE,EID,X)=^TMP("HLS",$J,X)
 Q
DISPLAY ;screen message to user
 W !,SRDSP
 Q
EVNTP ;set Surgery event trigger protocol and display
 S SRDSP="Sending a Notification of Appointment "
 I SREVENT="S12" S X="Booking"
 I SREVENT="S13" S X="Rescheduling"
 I SREVENT="S14" S X="Modification"
 I SREVENT="S15" S X="Cancellation"
 I SREVENT="S17" S X="Deletion"
 S SRDSP=SRDSP_X_" for case #"_CASE
 S SRET="SR Notification of Appointment "_X
 Q
