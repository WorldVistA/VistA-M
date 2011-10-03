PRCVEE5 ;WOIFO/VAC - Routine to handle Error Messages sent from DynaMed ; 5/16/05 4:34pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;PER VHA Directive 10-93-142, this routine should not be modified
 ;
 ;This routine reads an ACK from DynaMed in answer to a message sent
 ;regarding an Edit/Cancel/Approval to a RIL/2237.
 ;ERRTXT - Text of the error message severity
 ;MSGDAT -A single field that holds an error segment
 ;MSGDAT2 - MSGDAT without the segment identifier
 ;MSGDAT3 - Message type/Event type
 ;MSGTYP - Indicates if there are errors in the message
 ;PRCCNT - Record counter -indicates the message line number
 ;PRCERCD - Error code returned
 ;PRCERTX - Error text returned with error code
 ;PRCFLD - Field where error occurred
 ;PRCSEG - Segment where error has occurred
 ;PRCSEQ - Sequence number where error occurred
 ;PRCTYP - Type of form RIL or 2237
 ;PRCVACK - Acknowledgement type AA, AE, AR, etc
 ;PRCVAEC - Application error code string returned in message - ERR-5
 ;PRCVDT - Second node level of ^XTMP
 ;PRCVEC - Error component - ERR-3
 ;PRCVERR - Array of email message
 ;PRCVID - RIL/2237 ID - ERR-6
 ;PRCVLOC - Error Location component - ERR-2
 ;PRCMID - Message ID of original message
 ;PRCVMID2 - Cross reference into ^XTMP
 ;PRCVPTR - First node level of ^XTMP
 ;PRCVSEV - Severity Component ERR-4
 ;PRCVTYP - Original Form Type - RIL or 2237
 ;SSTOP - Stop flag
 ;PRCFS - Field separator
 ;PRCCS - Component separator
 ;PRCRS - Repetition separator
 ;PRCSC - Sub-component separator
 ;PRCDET - Array of field names inside of HL7 segments
 ;PRCFCP - Fund Control Point for message
 ;PRCSITE and PRCSITE0 - Receiving facility number
 ;ERRCNT - a counter
 ;^TMP - Global to hold error message information
BEGIN N I,J
 N PRCFS,PRCCS,PRCDET,ERRCNT,ERRTXT
 N MSGDAT,PRCCNT,MSGTYP
 N MSGDAT2,MSGDAT3,PRCERCD,PRCERTX,PRCFLD,PRCFCP,PRCSITE,PRCSITE0
 N PRCSEG,PRCSEQ,PRCTYP,PRCVACK,PRCVAEC,PRCVDT,PRCVEC,PRCVERR
 N PRCVID,PRCVLOC,PRCVMID,PRCVMID2,PRCVPTR,PRCVSEV,PRCVTYP,SSTOP
 S PRCFS=HL("FS"),PRCCS=$E(HL("ECH"),1)
 K ^TMP($J)
SETUP ;Set up array for HL7 crosswalk
 S PRCDET("ORC",1)="Order Control"
 S PRCDET("ORC",9)="Date/Time Created"
 S PRCDET("ORC",10)="Entered by"
 S PRCDET("ORC",21)="Ordering Facility"
 S PRCDET("RQD",1)="Line number"
 S PRCDET("RQD",2)="DM Document ID"
 S PRCDET("RQD",3)="Item number"
 S PRCDET("RQD",4)="Packaging Multiple"
 S PRCDET("RQD",5)="Quantity"
 S PRCDET("RQD",6)="Unit of purchase"
 S PRCDET("RQD",9)="Identifier"
 S PRCDET("RQD",10)="Date needed"
 S PRCDET("RQ1",1)="Unit cost"
 S PRCDET("RQ1",2)="Vendor Stock Number"
 S PRCDET("RQ1",3)="BOC"
 S PRCDET("RQ1",4)="Vendor and/or FMS Vendor"
 S PRCDET("RQ1",5)="NIF number"
 S MSGTYP="",PRCVTYP=""
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S ^TMP($J,I)=HLNODE,J=0
 .F  S J=$O(HLNODE(J)) Q:'J  S ^TMP($J,I,J)=HLNODE(J)
 ;
 S PRCCNT="",SSTOP="GO"
 F I=1:1:2 S PRCCNT=$G(^TMP($J,I)) Q:PRCCNT=""  Q:SSTOP="STOP"  D
 .S MSGDAT=$G(^TMP($J,I))
 .Q:MSGDAT=""
 .S MSGDAT2=$P(MSGDAT,PRCFS,2,21)
 .I $E(MSGDAT,1,3)="MSH" D  Q
 ..S MSGDAT3=$P(MSGDAT2,PRCFS,8)
 ..I MSGDAT3'["ORN"_PRCCS_"O08" D
 ...S SSTOP="STOP",MSGTYP="NOK"
 ...S PRCVTYP="ACK",PRCVID=$P(MSGDAT2,PRCFS,9)
 ...S PRCVERR(1)="IN "_PRCVTYP_" "_PRCVID_" there was a bad message type"
 ...S PRCVPTR="*"_$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)_"- - -076"
 .I $E(MSGDAT,1,3)="MSA" D  Q
 ..S PRCVACK=$P(MSGDAT2,PRCFS,1)
 ..S PRCVMID=$P(MSGDAT2,PRCFS,2)
 ..S PRCVMID2="PRCVMID*"_PRCVMID
 ..S PRCVPTR=$P($G(^XTMP(PRCVMID2,1)),U,1)
 ..S PRCVDT=$P($G(^XTMP(PRCVMID2,1)),U,2)
 ..I PRCVACK="AA" D  Q
 ...S MSGTYP="OK"
 ..I (PRCVACK="AE")!(PRCVACK="AR") D  Q
 ...S MSGTYP="NOK"
 I $E(MSGTYP,1,2)="OK" D VALID Q
 I PRCVTYP="ACK" D NOVALID Q
ERROR ;Now process error messages
 ;
 S ERRCNT=1
 S PRCCNT="" F I=3:1 S PRCCNT=$G(^TMP($J,I)) Q:PRCCNT=""  D
 .S MSGDAT=$G(^TMP($J,I))
 .Q:MSGDAT=""
 .S MSGDAT2=$P(MSGDAT,PRCFS,2,7)
 .S PRCVLOC=$P(MSGDAT2,PRCFS,2)
 .S PRCVEC=$P(MSGDAT2,PRCFS,3)
 .S PRCVSEV=$P(MSGDAT2,PRCFS,4)
 .S PRCVAEC=$P(MSGDAT2,PRCFS,5)
 .S PRCVID=$P(MSGDAT2,PRCFS,6)
 .S PRCVTYP="RIL"
 .I PRCVID?.N1"-".N1"-".N1"-".E1"-".N S PRCVTYP="2237"
 .S PRCSEG=$P(PRCVLOC,PRCCS,1)
 .S PRCSEQ=$P(PRCVLOC,PRCCS,2)
 .S PRCFLD=$P(PRCVLOC,PRCCS,3)
 .S PRCERCD=$P(PRCVAEC,PRCCS,1)
 .S PRCERTX=$P(PRCVAEC,PRCCS,2)
 .S ERRTXT="Error"
 .I PRCVSEV="W" S ERRTXT="Warning"
 .S PRCVERR(ERRCNT)="In "_PRCVTYP_" "_PRCVID_" the following occurred"
 .S ERRCNT=ERRCNT+1
 .S PRCVERR(ERRCNT)="For Line item "_PRCSEQ_" the "_PRCDET(PRCSEG,PRCFLD)_" had the following "_ERRTXT_": "
 .S ERRCNT=ERRCNT+1
 .S PRCVERR(ERRCNT)=PRCERTX
 .S ERRCNT=ERRCNT+1
 D NOVALID
 Q
VALID ;Do NOTHING to notify user that message is ok.
 D CLEANUP
 Q
NOVALID ;Mailman message
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S XMSUB="IFCAP to DynaMed "_PRCVTYP_" Errors "_PRCVID_" "
 S XMDUZ="IFCAP/DynaMed Interface"
 S XMTEXT="PRCVERR("
 ;S XMY("CARR.VICTOR@CSL.FO-WASH.MED.VA.GOV")=""
 S PRCFCP=$P(PRCVPTR,"-",4)
 S PRCSITE0=$P(PRCVPTR,"-",1)
 S PRCSITE=$P(PRCSITE0,"*",2)
 D GETFCPU^PRCVLIC(.XMY,PRCSITE,PRCFCP)
 D ^XMD
 K XMSUB,XMMG,XMDUZ,XMTEXT,XMY,XMZ
 D CLEANUP
 Q
 ;
CLEANUP ; Clean up data
 K MSGTYP,MSGDAT,MSGDAT2,MSGDAT3,ERRTXT
 K PRCCNT,PRCFS,PRCCS,I,J,SSTOP,PRCFCP,PRCSITE,PRCSITE0
 K ^TMP($J),ERRCNT,PRCERCD,PRCERTX,PRCFLD,PRCSEG,PRCSEQ
 K PRCTYP,PRCVACK,PRCVAEC,PRCVDT,PRCVEC,PRCVERR,PRCVID,PRCVLOC
 K PRCVMID,PRCVMID2,PRCVPTR,PRCVSEV,PRCVTYP,PRCDET
 ;
