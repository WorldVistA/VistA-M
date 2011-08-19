IVMPTRN3 ;ALB/KCL - SEND INITIAL TRANSMISSION TO IVM CENTER ; 9/24/03
 ;;2.0;INCOME VERIFICATION MATCH;**1,9,34,92**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FILE ; - call HL7 to send batch of segments
 ;
 I IVMCT'>0 Q
 ;
 N HLRESLT
 ;
 ; - send batch of HL7 messages
 D GENERATE^HLMA(HLEID,"GB",1,.HLRESLT,MTIEN)
 ;
 K ^TMP("HLS",$J)
 S IVMGTOT=$G(IVMGTOT)+HLEVN
 S (HLEVN,IVMCT)=0
 Q
 ;
FILE1 ; - call HL7 to send batch of segments
 ; (V1.6 - call this if non-ack batch but still has an MSA segment.)
 ; Called by ^IVMPTRN and ^IVMPTRN7 with ^TMP("HLS",$J) global set.
 ; Must convert ^TMP("HLS" into ^TMP("HLA" for GENACK^HLMA1 to work.
 ;
 I IVMCT'>0 Q
 ;
 N HLP,HLRESLTA
 S HLEIDS=$O(^ORD(101,HLEID,775,"B",0))
 ;
 ; - send batch of HL7 messages
 K ^TMP("HLA",$J)
 M ^TMP("HLA",$J)=^TMP("HLS",$J)
 D GENACK^HLMA1(HLEID,MTIEN,HLEIDS,"GB",1,.HLRESLTA,.HLP)
 ;
 K ^TMP("HLS",$J)
 K ^TMP("HLA",$J)
 S IVMGTOT=$G(IVMGTOT)+HLEVN
 S (HLEVN,IVMCT)=0
 Q
 ;
FILEPT(DFN,IVMYR,WHEN,MSGID,EVENTS,MTSTAT,INSSTAT) ;
 ;Description: File patient in IVM PATIENT (#301.5) file and file
 ;TRANSMISSION LOG entry.
 ;
 ;Input:
 ;  DFN - ien of record in the PATIENT file.
 ;  IVMYR - income year of the ORU~Z07 message.
 ;  WHEN -  date/time message sent, in FM format.
 ;  MSGID - message id used for message, in format used by MESSAGE CONTROL ID field.
 ;  EVENTS () - an array of reasons for transmission, pass by reference.
 ;  EVENTS("IVM") = 1 if transmission due to IVM criteria, 0 otherwise
 ;  EVENTS(" "DCD")=1 if transmission due to DCD criteria, 0 otherwise
 ;  EVENTS("ENROLL")=1 if transmission due to enrollment criteria, 0 otherwise
 ;  MTSTAT - pointer to the MEANS TEST STATUS file.  Is the status of the patient's means test at the time of the transmission for the income year of the transmission.
 ;  INSSTAT - 1 if the patient had active insurance at the time of the transmission, 0 otherwise.
 ;
 N IVMPTR,DGSENFLG
 ;
 ; - ignore security checks in MAS (DGSEC)
 S DGSENFLG=1
 ;
 ;find or create entry in IVM PATIENT file
 S IVMPTR=$$FIND^IVMPLOG(DFN,IVMYR)
 S:'IVMPTR IVMPTR=$$LOG^IVMPLOG(DFN,IVMYR,.EVENTS)
 Q:'IVMPTR
 ;
 ; Check the 301.5 record for Transmission Status
 N TRSTAT S TRSTAT=+$P(^IVM(301.5,IVMPTR,0),U,3)
 ;
 ; If this record is not updated, update it only
 I 'TRSTAT D UPDTLOG(IVMPTR,WHEN,MSGID,.EVENTS,MTSTAT,INSSTAT)
 ;
 ; If this record is already updated, check all other records
 ; for this patient that should be updated.
 I TRSTAT D
 .N NXTPTR,NXTYR S NXTPTR=0
 .F  S NXTPTR=$O(^IVM(301.5,"B",DFN,NXTPTR)) Q:'NXTPTR  D
 ..Q:NXTPTR=IVMPTR
 ..S TRSTAT=+$P(^IVM(301.5,NXTPTR,0),U,3)
 ..Q:TRSTAT
 ..S NXTYR=$P(^IVM(301.5,NXTPTR,0),U,2)
 ..I $$LOG^IVMPLOG(DFN,NXTYR,.EVENTS)
 ..D UPDTLOG(NXTPTR,WHEN,MSGID,.EVENTS,MTSTAT,INSSTAT)
 ;
 Q
 ;
UPDTLOG(IVMPTR,WHEN,MSGID,EVENTS,MTSTAT,INSSTAT) ;
 ; Update record to TRANSMITTED, and remove duplicates
 ;
 ; Update the IVM PATIENT (#301.5) record to a TRANSMITTED status.
 I $$CLEAR^IVMPLOG(IVMPTR,WHEN)
 ;
 ; Add an entry in the IVM TRANSMISSION LOG (#301.6) File.
 I $$LOG^IVMTLOG(IVMPTR,WHEN,MSGID,.EVENTS,MTSTAT,INSSTAT)
 ;
 D DUP(DFN,IVMYR,IVMPTR) ; remove duplicates
 ;
 Q
 ;
DUP(DFN,IVMYR,IVMPTR) ; remove duplicate entries in file 301.5
 ;
 ; Input - IVMPTR - IEN of original entry in file 301.5
 ;         DFN - IEN of PATIENT file
 ;         IVMYR - income year
 ;
 N DA,DIE,DIK,DR,IVMIEN,X,Y
 ;
 S IVMIEN=IVMPTR
 F  S IVMIEN=$O(^IVM(301.5,"APT",DFN,IVMYR,IVMIEN)) Q:'IVMIEN  D
 .;remove 301.5 entry
 .I $$DELETE^IVMPLOG2(IVMIEN) F DA=0:0 S DA=$O(^IVM(301.6,"B",IVMIEN,DA)) Q:'DA  D  ; reset ptrs
 ..S DIE="^IVM(301.6,",DR=".01///^S X=IVMPTR" D ^DIE
 Q
