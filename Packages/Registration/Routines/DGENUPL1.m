DGENUPL1 ;ALB/CJM,ISA/KWP,CKN - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ; 8/15/08 11:22am
 ;;5.3;REGISTRATION;**147,222,232,314,397,379,407,363,673,653,688**;Aug 13,1993;Build 29
 ;
 ;
PARSE(MSGIEN,MSGID,CURLINE,ERRCOUNT,DGPAT,DGELG,DGENR,DGCDIS,DGOEIF,DGSEC,DGNTR,DGMST) ;
 ;Description:  This function parses the HL7 segments.  It creates arrays
 ;defined by the PATIENT, ENROLLMENT, ELIGIBILY, CATASTROPHIC DISABILITY,
 ;OEF/OIF CONFLICT objects.
 ;Field values are put in DHCP format and the validity at the
 ;field level is tested.  Fields to be deleted are set to "@".
 ;
 ;Input:
 ;  MSGIEN - the ien of the HL7 message in the HL7 MESSAGE TEXT file (772)
 ;  MSGID -message control id of HL7 msg in the MSH segment
 ;  CURLINE - the subscript of the PID segment of the current message (pass by reference)
 ;  ERRCOUNT - is a count of the number of messages in the batch that can not be processed (pass by ref)
 ;
 ;Output:
 ;  Function Value: Returns 1 on success, 0 on failure.
 ;  CURLINE - upon leaving the procedure this parameter should be set to the end of the current message.
 ;  ERRCOUNT - set to count of messages that were not processed due to errors encountered. (pass by ref)
 ;  DGPAT - array defined by the PATIENT object. (pass by ref)
 ;  DGENR - array defined by the PATIENT ENROLLMENT object. (pass by ref)
 ;  DGELG - array defined by the PATIENT ELIGIBILITY object. (pass by ref)
 ;  DGCDIS - array defined by the CATASTROPHIC DISABILITY object. (pass by ref)
 ;  DGSEC - array defined by the PATIENT SECURITY object. (pass by ref)
 ;  DGOEIF - array defined by the OEF/OIF CONFLICT object.  (pass by ref)
 ;  DGNTR - array defined for NTR data.
 ;  DGMST - array defined for MST data.
 N SEG,ERROR,COUNT,QFLG,NFLG
 ;
 K DGEN,DGPAT,DGELG,DGCDIS,DGNTR,DGMST
 ;
 S ERROR=0,NFLG=1
 F SEG="PID","ZPD","ZIE","ZIO","ZEL"  D  Q:ERROR
 .D:NFLG NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG="ZIO",SEG("TYPE")'="ZIO" S NFLG=0 Q
 .I SEG("TYPE")=SEG D  Q
 ..D:(SEG'="ZEL") @SEG^DGENUPL2
 ..D:(SEG="ZEL") ZEL^DGENUPL2(1)
 ..S NFLG=1
 .D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUT OF ORDER",.ERRCOUNT)
 .S ERROR=1
 .;
 .;possible that in a bad message we are now past the end
 .S CURLINE=CURLINE-1
 ;
 I 'ERROR F COUNT=2:1 D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG) Q:(SEG("TYPE")'="ZEL")  D  Q:ERROR
 .S CURLINE=CURLINE+1
 .D ZEL^DGENUPL2(COUNT)
 ;Phase II Add the capability to accept more than 1 ZCD
 I 'ERROR F SEG="ZEN","ZMT","ZCD" D  Q:ERROR
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")=SEG D
 ..D @SEG^DGENUPL2
 .E  D
 ..D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUTOF ORDER",.ERRCOUNT)
 ..S ERROR=1
 ..;
 ..;possible that in a bad message we are now past the end
 ..S CURLINE=CURLINE-1
 ;
 I 'ERROR F COUNT=2:1 D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG) Q:(SEG("TYPE")'="ZCD")  D  Q:ERROR
 .S CURLINE=CURLINE+1
 .D ZCD^DGENUPL2
 ;
 ; Purple Heart/OEF-OIF  Addition of optional ZMH segment
 ;              Modified handling of ZSP and ZRD to accomodate ZMH
 ;
 I 'ERROR D  Q:ERROR $S(ERROR:0,1:1)
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")="ZSP" D ZSP^DGENUPL2 Q
 .D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUT OF ORDER",.ERRCOUNT)
 .S ERROR=1
 .;possible that in a bad message we are now past the end
 .S CURLINE=CURLINE-1
 ;
 ;Modified following code to receive multiple ZMH segment for
 ;Military service information - DG*5.3*653
 I 'ERROR D  Q:ERROR $S(ERROR:0,1:1)
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .S QFLG=0 F  D  Q:QFLG
 . . I SEG("TYPE")'="ZMH" S QFLG=1 Q
 . . D ZMH^DGENUPL2,NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")="ZRD" D ZRD^DGENUPL2 Q 
 .D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUT OF ORDER",.ERRCOUNT)
 .S ERROR=1
 .;possible that in a bad message we are now past the end
 .S CURLINE=CURLINE-1
 ;
 I 'ERROR F COUNT=2:1 D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG) Q:(SEG("TYPE")'="ZRD")  D  Q:ERROR
 .S CURLINE=CURLINE+1
 .D ZRD^DGENUPL2
 ;
 I 'ERROR F  D  Q:(ERROR!(SEG("TYPE")'="OBX"))
 .;possible if OBX segment not present that we are now past the end
 .I SEG("TYPE")'="OBX" S CURLINE=CURLINE-1 Q
 .D OBX^DGENUPL2
 .S CURLINE=CURLINE+1
 .D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG)
 ;
 Q $S(ERROR:0,1:1)
 ;
CONVERT(VAL,DATATYPE,ERROR) ;
 ;Description: Converts the value found in the HL7 segment to DHCP format
 ;
 ;Input:
 ;  VAL - value parsed from the HL7 segment
 ;  DATATYPE: indicates the type of conversion necessary
 ;      "DATE" - needs to be converted to FM format
 ;      "TS" - time stamp, needs to be converted to FM format
 ;      "Y/N" - 0->"N",1->"Y"
 ;      "1/0" - "Y"->1,"N"->0
 ;      "INSTITUTION" - needs to convert the station number with suffix to a point to the INSTITUTION file
 ;      "ELIGIBILITY" - VAL is a pointer to the national eligibility code file (#8.1), needs to be converted to a local eligibility code (file #8)
 ;
 ;      "MT" - VAL  is a Means Test Status code, it needs to be converted
 ;             to a pointer to the Means Test Status file
 ;       Phase II convert code to RSN IEN for DGCDIS object
 ;       "CDRSN" data type converts the codes diagnosis,procedure,condition to RSN IEN. (HL7TORSN^DGENA5)
 ;       "EXT" convert from code to abbreviation
 ;       "POS" convert from Period of Service code to a point to Period of Service file
 ;       "AGENCY" convert Agency/Allied Country code from file 35
 ;OUTPUT:
 ;  Function Value - the result of the conversion
 ;  ERROR - set to 1 if an error is detected, 0 otherwise (optional,pass by ref)
 ;
 S ERROR=0
 D
 .I VAL="" Q
 .I VAL="""""" S VAL="@" Q
 .I $G(DATATYPE)="EXT" D  Q
 ..S VAL=$$HLTOLIMB^DGENA5(VAL)
 .I $G(DATATYPE)="CDRSN" D  Q
 ..S VAL=$$HL7TORSN^DGENA5(VAL)
 .I ($G(DATATYPE)="MT") D  Q
 ..S VAL=$O(^DG(408.32,"AC",1,VAL,0))
 ..I 'VAL S ERROR=1
 .I ($G(DATATYPE)="DATE") D  Q
 ..I $L(VAL)'=8 S ERROR=1 Q
 ..S VAL=$$FMDATE^HLFNC(VAL)
 ..I ((VAL'=+VAL)!($L($P(VAL,"."))<7)) S ERROR=1
 .I ($G(DATATYPE)="TS") D  Q
 ..I $L(VAL)<8 S ERROR=1 Q
 ..S VAL=$$FMDATE^HLFNC(VAL)
 ..I ((VAL'=+VAL)!($L($P(VAL,"."))<7)) S ERROR=1
 .I ($G(DATATYPE)="Y/N") D  Q
 ..I VAL=0 S VAL="N" Q
 ..I VAL=1 S VAL="Y" Q
 ..S ERROR=1
 .I ($G(DATATYPE)="1/0") D  Q
 ..I VAL="N" S VAL=0 Q
 ..I VAL="Y" S VAL=1 Q
 ..S ERROR=1
 .I ($G(DATATYPE)="ELIGIBILITY") D  Q
 ..S VAL=$$MAP(VAL)
 ..I 'VAL S ERROR=1
 .I ($G(DATATYPE)="INSTITUTION") D  Q
 ..N OLDVAL
 ..S OLDVAL=VAL
 ..S VAL=$O(^DIC(4,"D",OLDVAL,0))
 ..I 'VAL S VAL=$O(^DIC(4,"D",(+OLDVAL),0))
 ..I 'VAL S ERROR=1
 .I ($G(DATATYPE)="POS") D  Q
 ..N OLDVAL
 ..S OLDVAL=VAL
 ..S VAL=$O(^DIC(21,"D",OLDVAL,0))
 ..I 'VAL S ERROR=1
 .I ($G(DATATYPE)="AGENCY") D  Q
 ..N OLDVAL
 ..S OLDVAL=VAL
 ..S VAL=$O(^DIC(35,"C",OLDVAL,0))
 ..I 'VAL S ERROR=1
 Q VAL
 ;
MAP(VALUE) ;
 ;Description: Tries to map an eligibility code from file #8.1 (the national MAS ELIGIBILITY CODE file) to file #8 (the local ELIGIBILITY CODE file)
 ;
 ;Input: VALUE - ien of an entry in file #8.1
 ;
 ;Output: Function value - NULL if mapping is not found, otherwise returns an ien of entry in file #8
 ;
 N ECODE,NODE,COUNT,NAME
 ;try to choose a code from file 8 to use that is appropriate
 S (COUNT,ECODE)=0
 ;
 F  S ECODE=$O(^DIC(8,"D",VALUE,ECODE)) Q:'ECODE  D
 .S NODE=$G(^DIC(8,ECODE,0))
 .;put code on list if active
 .I (NODE'=""),'$P(NODE,"^",7) S ECODE(ECODE)=$P(NODE,"^"),COUNT=COUNT+1
 ;
 ;only one match found, so use it
 Q:COUNT=1 $O(ECODE(0))
 ;
 ;no match found
 Q:'COUNT ""
 ;
 ;multiple matches found, try to match by name
 I COUNT>1 D
 .S ECODE=0
 .S NAME=$P($G(^DIC(8.1,VALUE,0)),"^")
 .F  S ECODE=$O(ECODE(ECODE)) Q:'ECODE  Q:ECODE(ECODE)=NAME
 Q ECODE
 ;
ACCEPT(MSGID) ;
 ;Description: Writes an ack (AA) to a global to be transmitted later.
 ;
 ;Inputs:
 ;  MSGID -message control id of HL7 msg in the MSH segment
 ;
 ;Outputs: none
 ;
 K HL,HLMID,HLMTIEN,HLDT,HLDT1
 D INIT^HLFNC2(HLEID,.HL)
 D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 S HLEVN=1
 S MID=HLMID_"-"_HLEVN
 D MSH^HLFNC2(.HL,MID,.HLRES)
 S ^TMP("HLS",$J,1)=HLRES
 ;
 ;it seems HLFS sometimes disappears upon reaching this point
 I $G(HLFS)="" S HLFS="^"
 ;
 S ^TMP("HLS",$J,2)="MSA"_HLFS_"AA"_HLFS_MSGID
 Q
 ;
MVERRORS ;
 ;Error messages were being deleted from ^TMP("HLS",$J by another package
 ;during the upload.  To fix this, errors are written to another
 ;subscript, then moved when the error list is complete.
 ;
 M ^TMP("HLS",$J)=^TMP("IVM","HLS",$J)
 K ^TMP("IVM","HLS",$J)
 Q
