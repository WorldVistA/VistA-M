SRHLVZIU ;B'HAM ISC/DLR - Surgery Interface Sender of Scheduling Information Unsolicited ; [ 05/28/98  11:29 AM ]
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
 I '$D(SRSTATUS) D STATUS^SROERR0
 S HLDAP=$O(^HL(771,"B","SR SURGERY",0)) Q:$G(HLDAP)=""
 Q:$P($G(^HL(771,HLDAP,0)),U,2)'="a"
 K ^TMP("HLS",$J)
 N HLSUB,HLREP,SRX,UPDATE,PRT,OUT
 S (SRI,UPDATE)=1,PRT=0,SRX=$O(^HL(770,"B","SR AAIS",0)) Q:'SRX  S SRNAP=$O(^HL(771,"B","SR AAIS",0)) I SRNAP D:$P($G(^HL(771,SRNAP,0)),"^",2)="a"
 .S PRT=PRT+1
 .S HLNDAP=SRX D INIT^HLTRANS S HLMTN="ZIU",HLSDT=1
 .;default separator and encoding characters
 .S:HLFS="" HLFS="^" S:HLECH="" HLECH="~|\&" S HLQ=""""""
 .S HLCOMP=$E(HLECH,1),HLREP=$E(HLECH,2),HLSUB=$E(HLECH,4)
 .D:'$D(^TMP("HLS",$J)) SEG
 .D CHECK I $G(UPDATE)=0 S OUT=1
 .I $G(OUT)'=1 D DISPLAY,SEND
EXIT ;
 Q
SEG ;segments
 D ZCH^SRHLVUO1(.SRI,.SREVENT,.SRSTATUS)
 I $G(SRSTATUS)'="(DELETED)" D
 .D PID^SRHLVUO(.SRI)
 .D OBX^SRHLVUO(.SRI)
 .D DG1^SRHLVUO(.SRI)
 .D AL1^SRHLVUO(.SRI)
 .D ZIS^SRHLVUO2(.SRI)
 .D ZIG^SRHLVUO1(.SRI)
 .D ZIL^SRHLVUO1(.SRI)
 .D ZIP^SRHLVUO1(.SRI)
 Q
SEND ;
 I $G(UPDATE)=1 D EN^HLTRANS
 I SRSTATUS="(DELETED)" K ^XTMP("SRHL7"_CASE,HLNDAP)
 K HLMTN,HLSDT
 Q
CHECK ;checks ^XTMP for duplicate modification messages
 N X
 I $D(^XTMP("SRHL7"_CASE,SRNAP,0)) D
 .S (UPDATE,X)=0 F  S X=$O(^TMP("HLS",$J,HLSDT,X)) Q:'X!($G(UPDATE)=1)  D
 ..I '$D(^XTMP("SRHL7"_CASE,SRNAP,X)) S UPDATE=1 Q
 ..I ^TMP("HLS",$J,HLSDT,X)'=^XTMP("SRHL7"_CASE,SRNAP,X) S UPDATE=1
 .I $O(^XTMP("SRHL7"_CASE,SRNAP,X)) S UPDATE=1
 I '$D(^XTMP("SRHL7"_CASE,SRNAP,0))!($G(UPDATE)=1) K ^XTMP("SRHL7"_CASE,SRNAP) S ^XTMP("SRHL7"_CASE,SRNAP,0)=DT D
 .S X=0 F  S X=$O(^TMP("HLS",$J,HLSDT,X)) Q:'X  S ^XTMP("SRHL7"_CASE,SRNAP,X)=^TMP("HLS",$J,HLSDT,X)
 Q
DISPLAY ;screen message to user
 N X
 W !,"Sending a "
 I SREVENT="S12" W "New Appointment booking"
 I SREVENT="S13" W "Reschedule"
 I SREVENT="S14" W "Modification"
 I SREVENT="S15" W "Cancellation"
 I SREVENT="S17" W "Deletion"
 W " for case #",CASE
 Q
