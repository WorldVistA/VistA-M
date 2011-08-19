SRHLOORU ;B'HAM ISC/DLR - Surgery Interface Outgoing ORU message ; [ 05/19/98  9:33 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
MSG(CASE,SRSTATUS,SREVENT) ;send ORU message
 ;This message is sent for every event point within the surgery options.
 ;There will be a ZIU message sent for each of the following surgery
 ;events, if SRSTATUS is equal to (NOT COMPLETE), (COMPLETE), or 
 ;(ABORTED): S12 New Appointment; S13 Reschedule; S14 Modification; 
 ;S15 Cancellation; and S17 Deletion.  The events codes are set to
 ;SREVENT within the surgery routine options.
 ;
 I $$V^SRHLU D MSG^SRHLVOOR(CASE,SRSTATUS,CASE) Q
 I SRSTATUS="(REQUESTED)"!(SRSTATUS="(SCHEDULED)")!(SRSTATUS="(DELETED)")!(SRSTATUS="(CANCELLED)") Q
START ;
 S HLDAP=$O(^HL(771,"B","SR SURGERY",0)) Q:$G(HLDAP)=""
 Q:$P($G(^HL(771,HLDAP,0)),U,2)'="a"
 ;check for the existence of file 133.2
 Q:'$D(^SRO(133.2,0))
 I $P(^SRO(133.2,$O(^SRO(133.2,"AC","OPERATION",0)),0),U,4)'["S",$P(^SRO(133.2,$O(^SRO(133.2,"AC","PROCEDURE",0)),0),U,4)'["S" Q
 K ^TMP("HLS",$J)
 N HLCOMP,HLSUB,HLREP,SRI,SRX,UPDATE,PRT,OUT
 ;V. 1.6 interface
 ;EID - IEN of event protocol
 ;HL - array of output parameters
 ;INT - only for VISTA-to-VISTA message exchange
 ;SRET - Surgery Event Trigger
 S SRET="SR Unsolicited transmission of VistA Requested Observation"
 S EID=$O(^ORD(101,"B",SRET,0)),HL="HL",INT=0
 D INIT^HLFNC2(EID,.HL,INT) S HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4),HLFS=HL("FS"),HLQ=HL("Q"),HLECH=HL("ECH")
 ;Q:'$O(HL("")) ;read HL for the error message
 D SEG
 ;SKIP duplicate messages
 D CHECK I $D(UPDATE) D GEN,DISPLAY
EXIT ;
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
 S SRI=1
 D PID^SRHLUO(.SRI,"HLS")
 D OBR^SRHLUO4(.SRI,CASE,"HLS")
 Q
DISPLAY ;screen message to user
 W !,"Sending an observation result message for case #",CASE
 Q
CHECK ;checks ^XTMP for duplicate modification messages
 N X
 I $D(^XTMP("SRHL7"_CASE,EID_"ORU",0)) D
 .S X=0 F  S X=$O(^TMP("HLS",$J,X)) Q:'X!($D(UPDATE))  D
 ..I '$D(^XTMP("SRHL7"_CASE,EID_"ORU",X)) S UPDATE=1 Q
 ..I ^TMP("HLS",$J,X)'=^XTMP("SRHL7"_CASE,EID_"ORU",X) S UPDATE=1
 .I $O(^XTMP("SRHL7"_CASE,EID_"ORU",X)) S UPDATE=1
 I '$D(^XTMP("SRHL7"_CASE,EID_"ORU",0))!$D(UPDATE) K ^XTMP("SRHL7"_CASE,EID_"ORU") S UPDATE=1,^XTMP("SRHL7"_CASE,EID_"ORU",0)=DT D
 .S X=0 F  S X=$O(^TMP("HLS",$J,X)) Q:'X  S ^XTMP("SRHL7"_CASE,EID_"ORU",X)=^TMP("HLS",$J,X)
 Q
