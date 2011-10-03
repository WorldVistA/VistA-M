HLPRS ;IRMFO-ALB/CJM -RTNs for parsing messages;03/24/2004  14:43
 ;;1.6;HEALTH LEVEL SEVEN;**118**;Oct 13, 1995
 ;
STARTMSG(MSG,IEN,HDR) ;
 ;Description:  This function begins the parsing of the message, parsing
 ;the header and returning the individual values in the array HDR().
 ;Input: 
 ;  IEN - The internal entry number of the message in file 773.
 ;Output:
 ;  Function returns 1 on success, 0 on failure.  Failure would indicate that the message was not found.
 ;  MSG - (pass by reference, required) This array is used by the HL7 package to track the progress of parsing the message.  The application MUST NOT touch it!
 ;  HDR (pass by reference, optional)   This array contains the results of parsing the message header.
 K MSG,HDR
 Q:'$G(IEN) 0
 Q:'$$GETMSG^HLMSG(IEN,.MSG) 0
 N SEG
 M SEG=MSG("HDR")
 Q:'$$PARSEHDR(.SEG,.HDR) 0
 ;after parsing the header, reset these subscripts:
 I HDR("SEGMENT TYPE")="BHS" D
 .S MSG("BATCH")=1
 .S MSG("BATCH","CURRENT MESSAGE")=0
 E  D
 .S MSG("BATCH")=0
 ;
 K MSG("HDR")
 M MSG("HDR")=HDR
 Q 1
 ;
NEXTSEG(MSG,SEG) ;
 ;Description:  Advances parsing to the next segment and returns the parsed values from that segment.
 ;Input:
 ;  MSG - (pass by reference, required) This array is used by the HL7 package to track the current position in the message.  The application MUST NOT touch it!
 ;Output:
 ;  Function  returns 1 on success, 0 if there are no more segments in this message.  For batch messages, a return value of 0 does not preclude the possibility that there are additional individual messages within the batch.
 ;  MSG - (pass by reference, required)
 ;  SEG - (pass by reference, required)  The segment is returned in this array.
 ;
 N TEMP,CODES
 K SEG
 I '$$NEXTSEG^HLMSG(.MSG,.TEMP) Q 0
 S CODES=MSG("HDR","ENCODING CHARACTERS")
 Q $$PARSE^HLOPRS1(MSG("HDR","FIELD SEPARATOR"),$E(CODES,2),$E(CODES,1),$E(CODES,4),$E(CODES,3),.TEMP,.SEG)
 ;
NEXTMSG(MSG,MSH) ;
 ;Description:  Advances to the next message within the batch, with the MSH segment returned.
 ;Input:
 ; MSG (pass by reference, required) This array is used by the HL7 package to track the current position in the message.  The application MUST NOT touch it!
 ;OUTPUT:
 ;  Function returns 1 on success, 0 if there are no more messages
 ;  MSG - (pass by reference) (remember, off limits to the application developer!)
 ;  MSH - (pass by reference, required) Returns the parsed message header
 ;
 K MSH
 N HDR
 Q:'$$NEXTMSG^HLMSG(.MSG,.HDR) 0
 Q:'$$PARSEHDR(.HDR,.MSH) 0
 Q 1
 ;
PARSEHDR(SEG,HDR) ;
 ;Parses the segment (SEG, pass by reference) into the HDR() array using meaningful subscripts.
 ;Input:
 ;  SEG (pass by reference, required) contains the segment in the format SEG(1), SEG(2),...
 ;Output:
 ;  HDR (pass by reference, required) This array will contain all the individual values.
 ;  Function - returns 1 if the segment is indeed an MSH or BHS segment, 0 otherwise
 ;
 N VALUE,TO
 K HDR
 S VALUE=$E($G(SEG(1)),1,3)
 I VALUE'="MSH",VALUE'="BHS" Q 0
 S HDR("SEGMENT TYPE")=VALUE
 S HDR("FIELD SEPARATOR")=$E(SEG(1),4)
 Q:$L(HDR("FIELD SEPARATOR"))'=1 0
 S VALUE=$E(SEG(1),5,8)
 S HDR("ENCODING CHARACTERS")=VALUE
 S HDR("COMPONENT SEPARATOR")=$E(VALUE,1)
 S HDR("REPETITION SEPARATOR")=$E(VALUE,2)
 S HDR("ESCAPE CHARACTER")=$E(VALUE,3)
 S HDR("SUBCOMPONENT SEPARATOR")=$E(VALUE,4)
 I $$PARSE^HLOPRS1(HDR("FIELD SEPARATOR"),$E(VALUE,2),$E(VALUE,1),$E(VALUE,4),$E(VALUE,3),.SEG,.TO) D
 .S HDR("SENDING APPLICATION")=$$GET^HLOPRS(.TO,3)
 .S HDR("SENDING FACILITY",1)=$$GET^HLOPRS(.TO,4,1)
 .S HDR("SENDING FACILITY",2)=$$GET^HLOPRS(.TO,4,2)
 .S HDR("SENDING FACILTY",3)=$$GET^HLOPRS(.TO,4,3)
 .S HDR("RECEIVING APPLICATION")=$$GET^HLOPRS(.TO,5)
 .S HDR("RECEIVING FACILITY",1)=$$GET^HLOPRS(.TO,6,1)
 .S HDR("RECEIVING FACILITY",2)=$$GET^HLOPRS(.TO,6,2)
 .S HDR("RECEIVING FACILITY",3)=$$GET^HLOPRS(.TO,6,3)
 .S HDR("DT/TM OF MESSAGE")=$$FMDATE^HLFNC($$GET^HLOPRS(.TO,7))
 .S HDR("SECURITY")=$$GET^HLOPRS(.TO,8)
 .I HDR("SEGMENT TYPE")="MSH" D
 ..S HDR("MESSAGE TYPE")=$$GET^HLOPRS(.TO,9,1)
 ..S HDR("EVENT")=$$GET^HLOPRS(.TO,9,2)
 ..S HDR("MESSAGE STRUCTURE")=$$GET^HLOPRS(.TO,9,3)
 ..S HDR("MESSAGE CONTROL ID")=$$GET^HLOPRS(.TO,10)
 ..S HDR("PROCESSING ID")=$$GET^HLOPRS(.TO,11)
 ..S HDR("PROCESSING MODE")=$$GET^HLOPRS(.TO,11,2)
 ..S HDR("VERSION")=$$GET^HLOPRS(.TO,12)
 ..S HDR("CONTINUATION POINTER")=$$GET^HLOPRS(.TO,14)
 ..S HDR("ACCEPT ACK TYPE")=$$GET^HLOPRS(.TO,15)
 ..S HDR("APP ACK TYPE")=$$GET^HLOPRS(.TO,16)
 ..S HDR("COUNTRY")=$$GET^HLOPRS(.TO,17)
 .I HDR("SEGMENT TYPE")="BHS" D
 ..S VALUE=$$GET^HLOPRS(.TO,9)
 ..S HDR("BATCH NAME/ID/TYPE")=VALUE
 ..S HDR("PROCESSING ID")=$S((VALUE["PROCESSING ID="):$E($P(VALUE,"PROCESSING ID=",2),1),1:$$GET^HLOPRS(.TO,9,2))
 ..S HDR("ACCEPT ACK TYPE")=$S((VALUE["ACCEPT ACK TYPE="):$E($P(VALUE,"ACCEPT ACK TYPE=",2),1,2),1:$$GET^HLOPRS(.TO,9,3,1,2))
 ..S HDR("APP ACK TYPE")=$S((VALUE["APP ACK TYPE="):$E($P(VALUE,"APP ACK TYPE=",2),1,2),1:$$GET^HLOPRS(.TO,9,4,1,2))
 ..S HDR("BATCH COMMENT")=$$GET^HLOPRS(.TO,10)
 ..S HDR("BATCH CONTROL ID")=$$GET^HLOPRS(.TO,11)
 ..S HDR("REFERENCE BATCH CONTROL ID")=$$GET^HLOPRS(.TO,12)
 ..;
 Q 1
