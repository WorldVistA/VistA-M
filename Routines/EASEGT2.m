EASEGT2 ;ALB/PJH - PROCESS INCOMING MFN TYPE HL7 MSGS ; 11/27/07 3:03pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**71**;15-MAR-01;Build 18
 ;
 ; CLONED FROM DGENEGT2 (ESR EVENT DRIVER)
 ;
MFN ; Description: This entry point is the handler for incoming MFN type
 ; HL7 messages.  This entry point is called from the PROCESSING ROUTINE
 ; field of the HL7 MESSAGE (multiple) field of the #771 file entry.
 ;
 ;  Input:
 ;   The following HL7 variables are set when the DHCP Application
 ;   processing routine is invoked:
 ;      HLDA - the internal entry number for the entry created in
 ;             file #772.
 ;     HLDAN - the name of the receiving application from the HL7 DHCP
 ;             APPLICATION #771 file
 ;     HLDAP - ien of the receiving application from the HL7 DHCP
 ;             APPLICATION #771 file
 ;      HLDT - date/time message was received in internal fileman format
 ;     HLDT1 - date/time message was received in HL7 format
 ;     HLECH - HL7 Encoding Characters from the 'EC' node of file #771
 ;      HLFS - HL7 Field Separator from the 'FS' node of file #771
 ;     HLMID - HL7 message control ID of the message received
 ;     HLMTN - 3-7 character message type of the message received
 ;    HLNDAP - Non-DHCP Application Pointer from file #770
 ;   HLNDAP0 - Zero node from file #770 corresponding to HLNDAP
 ;       HLQ - Double quotes ("") for use in building HL7 segments
 ;     HLVER - HL7 version number of the HL7 protocol that was used to
 ;             build the message received
 ;
 ;  other HL7 variables used:
 ;     HLEVN - number of HL7 events included in the HL7 message 
 ;     HLSDT - a flag that indicates that the data to be sent is
 ;             stored in the ^TMP("HLS") global array.
 ;   HLTRANS - existence of this variable indicates that the incoming
 ;             HL7 message is being processed by the HLSERV routine and
 ;             VA MailMan is the lowere level protocol being used.
 ;
 ;
 N EVENT,MSGID,SEG
 N CNT,HL,IVMRTN,SEGCNT
 ;
 ; SET UP WORK GLOBAL WITH INCOMING MESSAGE
 S IVMRTN="DGENEGT2"
 K ^TMP($J,IVMRTN)
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S CNT=0
 .S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE
 .F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 ..S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE(CNT)
 S HLDA=HLMTIEN
 ;
 ; INITIALIZE HL7 VARIABLES
 S HLEID="EAS ESR "_$P($$SITE^VASITE,"^",3)_" MFN-ZEG SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^HLFNC2(HLEID,.HL)
 S HLEIDS=$O(^ORD(101,HLEID,775,"B",0))
 ;
 D NXTSEG^DGENUPL(HLDA,0,.SEG)
 Q:(SEG("TYPE")'="MSH")
 S EVENT=$P(SEG(9),$E(HLECH),2)
 ;
 I EVENT="ZEG" D
 .S MSGID=SEG(10)
 .D EGT(HLDA,MSGID)
 ;
 K ^TMP($J,IVMRTN)
 Q
 ;
 ;
EGT(MSGIEN,MSGID) ;
 ; Description:  This procedure is used to process an MFN~ZEG message.
 ; It uploads the enrollment group threshold (EGT) data. An HL7
 ; Master File Acknowledgement (MFK) will be returned.
 ;
 ;  Input:
 ;   MSGIEN - the internal entry number of the HL7 message in the
 ;            HL7 MESSAGE TEXT (#772) file
 ;    MSGID - the message control id from the MSH segment
 ;
 ; Output: None
 ;
 N CURLINE,ERRCOUNT,SEG
 ;
 ; initialize HL7 variables
 S HLSDT="IVMQ"  ; subscript in ^TMP( global for MFK message
 K ^TMP("HLA",$J)
 ;
 ; init variables
 S ERRCOUNT=0  ; used to indicate error
 S CURLINE=1
 ;
 ; process master file notification msg
 D MFNZEG(MSGIEN,MSGID,.CURLINE,.ERRCOUNT)
 ;
 ; transmit master file application acknowledgment (MFK)
 S HLEVN=$S(+$G(ERRCOUNT):+$G(ERRCOUNT),1:1)
 S HLARYTYP="GM",HLFORMAT=1
 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,.HLRESLTA)
 ;
 Q
 ;
 ;
MFNZEG(MSGIEN,MSGID,CURLINE,ERRCOUNT) ;
 ; Description:  This procedure is used to process a MFN~ZEG msg.
 ; 
 ;  Input:
 ;     MSGIEN - the internal entry number of the HL7 message in the
 ;              HL7 MESSAGE TEXT (#772) file
 ;      MSGID - message control id of HL7 msg in the MSH segment
 ;    CURLINE - the subscript of the MSH segment of the current message
 ;              (pass by reference)
 ;
 ; Output:
 ;   CURLINE - upon leaving the procedure this parameter should be set to
 ;             the end of the current message. (pass by reference)
 ;  ERRCOUNT - set if error encountered (pass by reference)
 ;
 N DGEGT,DGMFI,DGMFE,ERRMSG,OLDEGT
 ;
 ; drops out of DO block on error
 D
 .; parse the message
 .Q:'$$PARSE(MSGIEN,MSGID,.CURLINE,.ERRCOUNT,.DGEGT,.DGMFI,.DGMFE)
 .;
 .; get the current EGT record if it exists
 .I $$GET^DGENEGT($$FINDCUR^DGENEGT(),.OLDEGT)
 .;
 .; add assumed values to the EGT record containing the update
 .S DGEGT("ENTDATE")=$$NOW^XLFDT  ; set to currnet date/time
 .S DGEGT("SOURCE")=1  ; set source of EGT to 'HEC'
 .;
 .; perform field validation checks on the EGT record
 .I '$$VALID^DGENEGT(.DGEGT,.ERRMSG) D  Q
 ..D ADDERROR(MSGID,ERRMSG,.ERRCOUNT,.DGMFI,.DGMFE)
 .;
 .; store enrollment group threshold (EGT) record 
 .D UPLDEGT^DGENEGT3(.DGEGT)
 .;
 .; if no error encountered, create an 'AA' MFK
 .D ACCEPT(MSGID,.DGMFI,.DGMFE)
 .;
 .; send local EGT notification msg
 .D NOTIFY^DGENEGT1(.DGEGT,.OLDEGT)
 ;
 Q
 ;
 ;
PARSE(MSGIEN,MSGID,CURLINE,ERRCOUNT,DGEGT,DGMFI,DGMFE) ;
 ; Description: This function is used to parse the HL7 segments of the message.
 ;
 ;  Input:
 ;     MSGIEN - the internal entry number of the HL7 message in the
 ;              HL7 MESSAGE TEXT (#772) file
 ;      MSGID - message control id of HL7 msg in the MSH segment
 ;    CURLINE - the subscript of the MSH segment of the current message
 ;              (pass by reference)
 ;
 ; Output:
 ;  Function Value: Returns 1 on success, 0 on failure
 ;     DGEGT - array containing the EGT record (pass by reference)
 ;     DGMFI - array containing fields of MFI segment needed for
 ;             MFK (pass by reference)
 ;     DGMFE - array containing fields of MFE segment needed for
 ;             MFK (pass by reference)
 ;  ERRCOUNT - set if error encountered (pass by reference)
 ;
 N ERROR,SEG
 S ERROR=0
 ;
 K DGEGT,DGMFI,DGMFE
 S (DGMFI,DGMFE)=""
 ;
 F SEG="MFI","MFE","ZEG" D  Q:ERROR
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")=SEG D
 ..D @(SEG_"^DGENEGT3")
 .E  D
 ..D ADDERROR(MSGID,SEG_" SEGMENT MISSING",.ERRCOUNT,.DGMFI,.DGMFE)
 ..S ERROR=1
 ;
 Q $S(ERROR:0,1:1)
 ;
 ;
ADDERROR(MSGID,ERRMSG,ERRCOUNT,DGMFI,DGMFE) ;
 ; Description - This procedure writes an MFK - Application Error (AE)
 ; to the global that is used in the transmission of the 'MFK' msg.
 ;
 ;  Inputs:
 ;      MSGID - message control id of HL7 msg in the MSH segment
 ;     ERRMSG - the error msg text
 ;   ERRCOUNT - count of errors written (pass by reference)
 ;      DGMFI - array containing fields of MFI segment received, needed
 ;              for MFK (pass by reference)
 ;      DGMFE - array containing fields of MFI segment received, needed
 ;              for MFK (pass by reference)
 ;
 ; Outputs:
 ;   ^TMP("HLS",$J,I) - global array containing all segments of
 ;      the HL7 message that the receiving application wishes to send
 ;      as response. The HLSDT variable is a flag that indicates that
 ;      the data to be sent is stored in in the ^TMP("HLS") global
 ;      array. The variable (I) is sequential number. 
 ;
 S ERRCOUNT=+$G(ERRCOUNT)
 ;
 ; MSA segment
 S ^TMP("HLA",$J,(ERRCOUNT*2)+1)="MSA"_HLFS_"AE"_HLFS_MSGID_HLFS_ERRMSG
 ;
 ; MFI segment
 S ^TMP("HLA",$J,(ERRCOUNT*2)+2)="MFI"_HLFS_$G(DGMFI("MASTERID"))_HLFS_HLFS_$G(DGMFI("EVENT"))
 ;
 ; MFA segment
 S ^TMP("HLA",$J,(ERRCOUNT*2)+3)="MFA"_HLFS_$G(DGMFE("RECEVNT"))_HLFS_$G(DGMFE("CNTRLNUM"))_HLFS_HLFS_"U"_HLFS_$G(DGMFE("PRIMKEY"))
 S ERRCOUNT=ERRCOUNT+1
 Q
 ;
 ;
ACCEPT(MSGID,DGMFI,DGMFE) ;
 ; Description - This procedure writes an MFK - Application Accept (AA)
 ; to the global that is used in the transmission of the 'MFK' msg.
 ;
 ;  Inputs:
 ;      MSGID - message control id of HL7 msg in the MSH segment
 ;      DGMFI - array containing fields of MFI segment received, needed
 ;              for MFK (pass by reference)
 ;      DGMFE - array containing fields of MFI segment received, needed
 ;              for MFK (pass by reference)
 ;
 ; Outputs:
 ;   ^TMP("HLS",$J,HLSDT,I) - global array containing all segments of
 ;      the HL7 message that the receiving application wishes to send
 ;      as response. The HLSDT variable is a flag that indicates that
 ;      the data to be sent is stored in in the ^TMP("HLS") global
 ;      array. The variable (I) is sequential number. 
 ;
 N DGCOUNT
 S DGCOUNT=1   ; sequential number used as array subscript
 ;
 ; MSA segment
 S DGCOUNT=DGCOUNT+1
 S ^TMP("HLA",$J,DGCOUNT)="MSA"_HLFS_"AA"_HLFS_MSGID
 ;
 ; MFI segment
 S DGCOUNT=DGCOUNT+1
 S ^TMP("HLA",$J,DGCOUNT)="MFI"_HLFS_$G(DGMFI("MASTERID"))_HLFS_HLFS_$G(DGMFI("EVENT"))
 ;
 ; MFA segment
 S DGCOUNT=DGCOUNT+1
 S ^TMP("HLA",$J,DGCOUNT)="MFA"_HLFS_$G(DGMFE("RECEVNT"))_HLFS_$G(DGMFE("CNTRLNUM"))_HLFS_HLFS_"S"_HLFS_$G(DGMFE("PRIMKEY"))
 Q
