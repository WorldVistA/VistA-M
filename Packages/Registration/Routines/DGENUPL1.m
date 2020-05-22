DGENUPL1 ;ALB/CJM,ISA,KWP,CKN,LBD,LMD,TDM,TGH,DJS,HM - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ;30 Oct 2017  7:32PM
 ;;5.3;REGISTRATION;**147,222,232,314,397,379,407,363,673,653,688,797,842,894,871,935,959,975,972,952**;Aug 13,1993;Build 160
 ;
PARSE(MSGIEN,MSGID,CURLINE,ERRCOUNT,DGPAT,DGELG,DGENR,DGCDIS,DGOEIF,DGSEC,DGNTR,DGMST,DGNMSE,DGHBP,DGOTH) ;
 ;
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
 ;  DGNMSE - array define for MILITARY SERVICE EPISODE data (pass by ref)
 ;  DGHBP - array define for HEALTH BENEFIT PLAN data (pass by ref) DG*5.3*871
 ;  DGOTH - array for OTH data (passed by ref)
 ;
 N SEG,ERROR,COUNT,QFLG,NFLG
 ;
 ;DJS, Set TMP global to track the presence of ZMH segment; DG*5.3*935
 K ^TMP($J,"DGENUPL") S ^TMP($J,"DGENUPL","ZMH",0)=0
 ;
 K DGEN,DGPAT,DGELG,DGCDIS,DGNTR,DGMST
 ;
 S ERROR=0,NFLG=1
 F SEG="PID","ZPD","ZIE","ZIO","ZEL"  D  Q:ERROR
 .D:NFLG NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG="ZIO",SEG("TYPE")'="ZIO" S NFLG=0 Q
 .I SEG("TYPE")=SEG D  Q
 ..I SEG'="ZEL" N DGRTN S DGRTN=SEG_"^DGENUPL2" D @DGRTN      ; DG*5.3*894
 ..D:(SEG="ZEL") ZEL^DGENUPL2(1)
 ..S NFLG=1
 .D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUT OF ORDER",.ERRCOUNT)
 .S ERROR=1
 .;
 .;possible that in a bad message we are now past the end
 .S CURLINE=CURLINE-1
 ;
 ;DJS, Set segment before processing possible multiple segments; DG*5.3*935
 I 'ERROR S SEG="ZEL" F COUNT=2:1 D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG) Q:(SEG("TYPE")'="ZEL")  D  Q:ERROR
 .S CURLINE=CURLINE+1
 .D ZEL^DGENUPL2(COUNT)
 ;
 ;ZE2 is optional, If no ZE2 segment delete pension data
 I 'ERROR D
 .I SEG("TYPE")="ZE2" D ZE2^DGENUPLB S CURLINE=CURLINE+1 Q
 .I SEG("TYPE")'="ZE2" D
 ..Q:$$GET1^DIQ(2,DFN,.3852,"I")=$O(^DG(27.18,"C","00",""))
 ..N PSUB
 ..F PSUB="PENAEFDT","PENTRMDT","PENAREAS","PENTRMR1","PENTRMR2","PENTRMR3","PENTRMR4" S DGPAT(PSUB)="@"
 ;
 ; ZTE is optional and repeatable DG*5.3*952
 K DGOTH I 'ERROR S SEG="ZTE" I $$CHKNXT(CURLINE+1,SEG) D
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .S QFLG=0 F  D  Q:QFLG
 ..I SEG("TYPE")'="ZTE" S QFLG=1,CURLINE=CURLINE-1 Q
 ..D ZTE^DGENUPLB
 ..D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 ..Q
 .Q
 ;
 ;ZHP is optional & can repeat. DG*5.3*871
 K DGHBP
 ;DJS, Added call to extrinsic function to determine if multiple segments are present ; DG*5.3*935
 I 'ERROR S SEG="ZHP" I $$CHKNXT(CURLINE+1,SEG) D  Q:ERROR $S(ERROR:0,1:1)
 . D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 . S QFLG=0 F  D  Q:QFLG
 . . I SEG("TYPE")'="ZHP" S QFLG=1,CURLINE=CURLINE-1 Q
 . . D ZHP^DGENUPLB
 . . D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 ;
 ;Phase II Add the capability to accept more than 1 ZCD
 I 'ERROR F SEG="ZEN","ZMT","ZCD" D  Q:ERROR
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")=SEG D
 ..N DGRTN S DGRTN=SEG_"^DGENUPL2" D @DGRTN     ; DG*5.3*894
 .E  D
 ..D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUT OF ORDER",.ERRCOUNT)
 ..S ERROR=1
 ..;
 ..;possible that in a bad message we are now past the end
 ..S CURLINE=CURLINE-1
 ;
 ;DJS, Added call to extrinsic function to determine if multiple segments are present ; DG*5.3*935
 I 'ERROR S SEG="ZCD" I $$CHKNXT(CURLINE+1,SEG) F COUNT=2:1 D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG) Q:(SEG("TYPE")'="ZCD")  D  Q:ERROR
 .S CURLINE=CURLINE+1
 .D ZCD^DGENUPL2
 ;
 ; Purple Heart/OEF-OIF  Addition of optional ZMH segment
 ;              Modified handling of ZSP and ZRD to accommodate ZMH
 ;
 ;DJS, Added call to extrinsic function to determine if multiple segments are present ; DG*5.3*935
 I 'ERROR S SEG="ZSP" I $$CHKNXT(CURLINE+1,SEG) D  Q:ERROR $S(ERROR:0,1:1)
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")="ZSP" D ZSP^DGENUPL2 Q
 .D ADDERROR^DGENUPL(MSGID,$G(DGPAT("SSN")),SEG_" SEGMENT MISSING OR OUT OF ORDER",.ERRCOUNT)
 .S ERROR=1
 .;possible that in a bad message we are now past the end
 .S CURLINE=CURLINE-1
 ;
 ;Modified following code to receive multiple ZMH segment for
 ;Military service information - DG*5.3*653
 ;
 ;DJS, Check for no MSE ZMH segments present and non-MSE ZMH segments ; DG*5.3*959
 I 'ERROR S SEG="ZMH" D  ; DG*5.3*972 ;HM - remove Q:ERROR and let code quit with value below
 .N SEGNAM,MSECNT,CURLN,MHSTYP,NONMSE,SGMNT S SEGNAM="",(MSECNT,NONMSE)=0,CURLN=CURLINE
 .F  S CURLN=$O(^TMP($J,IVMRTN,CURLN)) Q:'CURLN  D
 ..S SGMNT=$G(^TMP($J,IVMRTN,CURLN,0)),SEGNAM=$P($G(SGMNT),U) Q:SEGNAM'="ZMH"  S MHSTYP=$P($G(SGMNT),U,3)
 ..I "^SL^SNL^SNNL^MSD^FDD^"[("^"_MHSTYP_"^") S MSECNT=MSECNT+1 Q
 ..E  S NONMSE=NONMSE+1 Q  ;ZMH segment present, but not an MSE
 .;DJS, No MSE-type ZMH segment present, so branch to DGNOZMH to kill HEC-owned MSEs; DG*5.3*935
 .I MSECNT=0 I ^TMP($J,"DGENUPL","ZMH",0)=0 D EN^DGNOZMH(DFN) K ^TMP($J,"DGENUPL")
 .Q:('NONMSE&('MSECNT))
 .;DJS, Added call to extrinsic function to determine if multiple segments are present ; DG*5.3*935
 .S QFLG=0 F  D  Q:QFLG!(ERROR)
 ..I '$$CHKNXT(CURLINE+1,SEG) S QFLG=1 Q
 ..D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG) ;process any ZMH segments that are present in Z11
 ..D ZMH^DGENUPL2
 ;
 ;DJS, Added call to extrinsic function to determine if multiple segments are present ; DG*5.3*935
 I 'ERROR S SEG="ZRD" I $$CHKNXT(CURLINE+1,SEG) F COUNT=2:1 D NXTSEG^DGENUPL(MSGIEN,CURLINE,.SEG) Q:(SEG("TYPE")'="ZRD")  D  Q:ERROR
 .S CURLINE=CURLINE+1
 .D ZRD^DGENUPL2
 ;
 ;DJS, Added call to extrinsic function to determine if multiple segments are present ; DG*5.3*935
 I 'ERROR S SEG="OBX" F  D  Q:(ERROR!('$$CHKNXT(CURLINE+1,SEG)))
 .;possible if OBX segment not present that we are now past the end
 .Q:'$$CHKNXT(CURLINE+1,SEG)
 .D NXTSEG^DGENUPL(MSGIEN,.CURLINE,.SEG)
 .D OBX^DGENUPL2
 .Q
 ;
 K ^TMP($J,"DGENUPL")
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
 ;       "CDDSCR" data type converts the codes descriptor(s) to DSCR IEN. (HL7TODSC^DGENA5)   DG*5.3*894
 ;       "EXT" convert from code to abbreviation
 ;       "POS" convert from Period of Service code to a point to Period of Service file
 ;       "AGENCY" convert Agency/Allied Country code from file 35
 ;       "PENSIONCD" convert Pension Award/Termination Reason code from file 27.18
 ;       "HBP" convert from code to file 25.11 ien DG*5.3*871
 ;OUTPUT:
 ;  Function Value - the result of the conversion
 ;  ERROR - set to 1 if an error is detected, 0 otherwise (optional,pass by ref)
 S ERROR=0
 D
 .I VAL="" Q
 .I VAL="""""" S VAL="@" Q
 .I $G(DATATYPE)="EXT" D  Q
 ..S VAL=$$HLTOLIMB^DGENA5(VAL)
 .I $G(DATATYPE)="CDRSN" D  Q
 ..S VAL=$$HL7TORSN^DGENA5(VAL)
 .; * check the new DESCRIPTOR seq  -  DG*5.3*894
 .I $G(DATATYPE)="CDDSCR" D  Q
 ..S VAL=$$HL7TODSC^DGENA5(VAL)
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
 .I ($G(DATATYPE)="PENSIONCD") D  Q
 ..N OLDVAL
 ..S OLDVAL=VAL
 ..S VAL=$O(^DG(27.18,"C",OLDVAL,0))
 ..I 'VAL S ERROR=1
 .I ($G(DATATYPE)="HBP") D  Q    ; DG*5.3*871
 ..N OLDVAL
 ..S OLDVAL=VAL
 ..S VAL=$O(^DGHBP(25.11,"C",OLDVAL,0))
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
 N MID
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
 ;
 ;DJS, Added Extrinsic Function to determine if multiple segments are present ; DG*5.3*935
CHKNXT(DGNVAL,DGNSEG) ; Check the SEG in the next segment manually
 ; DGNVAL = CURLINE or CURLINE+1
 ; DGNSEG = SEG (3 character SEG)
 ; Returns 1 if there is a match or 0 if there is no match
 ;
 Q $S($E($G(^TMP($J,IVMRTN,+DGNVAL,0)),1,3)=DGNSEG:1,1:0)
