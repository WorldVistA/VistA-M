SRHLVOOR ;B'HAM ISC/DLR - Surgery Interface Outgoing ORU message ; [ 06/02/98  9:04 AM ]
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
INIT S HLDAP=$O(^HL(771,"B","SR SURGERY",0)) Q:$G(HLDAP)=""
 Q:$P($G(^HL(771,HLDAP,0)),U,2)'="a"
 ;check for the existence of file 133.2
 Q:'$D(^SRO(133.2,0))
 I $P(^SRO(133.2,$O(^SRO(133.2,"AC","OPERATION",0)),0),U,4)'["S",$P(^SRO(133.2,$O(^SRO(133.2,"AC","PROCEDURE",0)),0),U,4)'["S" Q
 I '$D(SRSTATUS) D STATUS^SROERR0
 I SRSTATUS="(REQUESTED)"!(SRSTATUS="(SCHEDULED)")!(SRSTATUS="(DELETED)")!(SRSTATUS="(CANCELLED)") Q
START ;
 N SRNAP
 K ^TMP("HLS",$J)
 N HLCOMP,HLSUB,HLREP,SRI,SRX,UPDATE,PRT,OUT
 S (UPDATE,SRI)=1,PRT=0,SRX=$O(^HL(770,"B","SR AAIS",0)) Q:'SRX  S SRNAP=$O(^HL(771,"B","SR AAIS",0)) I SRNAP D:$P($G(^HL(771,SRNAP,0)),"^",2)="a"
 .S PRT=PRT+1
 .S HLNDAP=SRX D INIT^HLTRANS S HLMTN="ORU",HLSDT=1
 .S:HLFS="" HLFS="^" S:HLECH="" HLECH="~|\&" S HLQ=""""""
 .S HLCOMP=$E(HLECH,1),HLREP=$E(HLECH,2),HLSUB=$E(HLECH,4)
 .;check outgoing message for duplication, if OBR segment exists
 .D:'$D(^TMP("HLS",$J)) SEG
 .I $G(OUT)'=1 D CHECK I $G(UPDATE)=0 S OUT=1
 .I $G(OUT)'=1 D DISPLAY,SEND
EXIT ;
 D KILL^HLTRANS
 Q
SEG ;segments
 D PID^SRHLVUO(.SRI)
 ;check for OBR, if none exist quit
 S OBRCHK=SRI
 D OBR^SRHLVUO4(.SRI,CASE)
 I OBRCHK=SRI S OUT=1
 Q
SEND ;
 I $G(UPDATE)=1 D EN^HLTRANS
 K HLMTN,HLSDT
 Q
DISPLAY ;screen message to user
 W !,"Sending an observation result message for case #",CASE
 Q
CHECK ;checks ^XTMP for duplicate modification messages
 N X
 I $D(^XTMP("SRHL7"_CASE,SRNAP_"ORU",0)) D
 .S (UPDATE,X)=0 F  S X=$O(^TMP("HLS",$J,HLSDT,X)) Q:'X!($G(UPDATE)=1)  D
 ..I '$D(^XTMP("SRHL7"_CASE,SRNAP_"ORU",X)) S UPDATE=1 Q
 ..I ^TMP("HLS",$J,HLSDT,X)'=^XTMP("SRHL7"_CASE,SRNAP_"ORU",X) S UPDATE=1
 .I $O(^XTMP("SRHL7"_CASE,SRNAP_"ORU",X)) S UPDATE=1
 I '$D(^XTMP("SRHL7"_CASE,SRNAP_"ORU",0))!($G(UPDATE)=1) K ^XTMP("SRHL7"_CASE,SRNAP_"ORU") S ^XTMP("SRHL7"_CASE,SRNAP_"ORU",0)=DT D
 .S X=0 F  S X=$O(^TMP("HLS",$J,HLSDT,X)) Q:'X  S ^XTMP("SRHL7"_CASE,SRNAP_"ORU",X)=^TMP("HLS",$J,HLSDT,X)
 Q
