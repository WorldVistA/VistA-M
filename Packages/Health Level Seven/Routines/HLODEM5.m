HLODEM5 ;ALB/CJM-HL7 - Demonstration Code ;03/15/12  12:39;
 ;;1.6;HEALTH LEVEL SEVEN;**146,10001**;Oct 13, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
        ;
        ;
PARSEMSG        ;--
        ;
        ;Description: This is the default message handler for the receiving
        ; application named HLO DEMO RECEIVING APPLICATION.
        ;
        ;Input:
        ; HLMSGIEN: At the point HLO calls this message handler, the variable
        ; HLMSGIEN is set to the IEN of the message in the HLO
        ; MESSAGE ADMINISTRATION file, #779.2.
        ; ZEXCEPT: HLMSGIEN
        ;
        ;Output: none
        ;
        ;Required Setup:
        ;<<HLO APPLICATION PARAMETER - file #779.2>>
        ; ** The receiving application. **
        ; APPLICATION NAME: HLO DEMO RECEIVING APPLICATION
        ; ** The application chose to specify a private queue for its incoming
        ; messages. If not specified, the queue 'DEFAULT' would be used. **
        ; DEFAULT PRIVATE IN-QUEUE: HLO DEMO RECEIVING APPLICATION
        ; **The application did not specify a message handler for the ADT~A08
        ; message, but did specify a default handler. **
        ; DEFAULT ACTION TAG: PARSEMSG
        ; DEFAULT ACTION ROUTINE: HLODEM5
        ; ** The package that is receiving the message. **
        ; Package File Link: HL7 OPTIMIZED (HLO)
        ;
        N MSG,HDR
        I '$$STARTMSG^HLOPRS(.MSG,HLMSGIEN,.HDR) D ERROR("lost message") QUIT
        I 'MSG("BATCH"),HDR("MESSAGE TYPE")="ADT",HDR("EVENT")="A08" D
        .D A08(.MSG)
        .I HDR("APP ACK TYPE")="AL" ;(Need to respond with an application ack.)
        E  D ERROR("unexpected message type") QUIT  ;SIS/LM - Add space before DO
        Q
        ;
PARSEA08        ;--
        ;
        ;Description:
        ; This is the ADT~A08 message handler for the receiving application
        ; named HLO DEMO RECEIVING APPLICATION.
        ;Input:
        ; At the point it is called, the variable HLMSGIEN is set to the IEN
        ; of the message in the HLO MESSAGE ADMINISTRATION file, #779.2.
        ; ZEXCEPT: HLMSGIEN
        ;
        ;Required Setup:
        ;<<HLO APPLICATION PARAMETER - file #779.2>>
        ; ** The receiving application. **
        ; APPLICATION NAME: HLO DEMO RECEIVING APPLICATION
        ; **The application specified a specific message handler. **
        ; HL7 MESSAGE TYPE: ADT
        ; HL7 EVENT: A08
        ; ACTION TAG: PARSEA08
        ; ACTION ROUTINE: HLODEM5
        ; ** The package that is receiving the message. **
        ; Package File Link: HL7 OPTIMIZED (HLO)
        ;
        ;
        N MSG,HDR,PID,NK1
        I '$$STARTMSG^HLOPRS(.MSG,HLMSGIEN,.HDR) D ERROR("lost message") QUIT
        ;
        ;The message type and event are already known to be ADT~A08 based on the
        ;HLO Application Registry, but they could be checked by looking at
        ;MSG("MESSAGE TYPE") and MSG("EVENT")
        ;
        ;Parse the remaining segments of the message.
        D A08(.MSG,.PID,.NK1)
        ;
        ;
        ;(At this point the message's data has been retrieved into the PID and
        ; NK1 arrays. Process it! Then return an application acknowledgment
        ; if requested.)
        ;
        Q
        ;
A08(MSG,PID,NK1)        ;--
        ;
        ;Description: $$STARTMSG^HLOPRS was already called. Parse the remaining
        ; segments.
        ;Input:
        ; MSG (required, pass-by-reference) The message array returned by
        ; callng $$STARTMSG^HLOPRS.
        ;Output:
        ; PID (pass-by-reference) The fields from the PID segment are returned
        ; in this array.
        ; NK1 (pass-by-reference) The fields parsed from the NK1 segment are
        ; returned in this array.
        ;
        N SEG
        ;SIS/LM - Add spaces after FOR and QUIT in next
        F  Q:'$$NEXTSEG^HLOPRS(.MSG,.SEG)  D
        .;Base the parsing on the type of segment.
        .;SEG(0) is equivalent to SEG("SEGMENT TYPE")
        .I SEG("SEGMENT TYPE")="PID" D PID(.SEG,.PID) Q
        .I SEG(0)="NK1" D PID(.SEG,.PID) Q
        .;If not a PID or NK1 segment, disregard it.
        ;
        Q
        ;
PID(SEG,PID)    ;--
        ;
        ;Description:
        ; Put the needed data into the PID array.
        ;Input:
        ; SEG (pass-by-reference) The parsed segment.
        ;Output:
        ; NK1 (pass-by-reference) Will return the specific data needed by the application.
        ;
        N I,VALUE
        K PID
        ;Get the patient identifiers from the repeating field.
        F I=1:1 S VALUE=$$GET^HLOPRS(.SEG,3,4,1,I) Q:VALUE=""  D  ;SIS/LM - Add space before DO
        .I VALUE="USVHA" S PID("ICN")=$$GET^HLOPRS(.SEG,3,1,1,I)
        .I VALUE="USSSA" S PID("SSN")=$$GET^HLOPRS(.SEG,3,1,1,I)
        ;
        ;Get the patient name.
        D GETXPN^HLOPRS2(.SEG,.VALUE,2)
        M PID("NAME")=VALUE
        ;
        ;Get the patient DOB.
        D GETDT^HLOPRS2(.SEG,.VALUE,7)
        S PID("DOB")=VALUE
        ;
        ;Get the patient address.
        D GETAD^HLOPRS2(.SEG,.VALUE,11)
        M PID("ADDRESS")=VALUE
        ;
        Q
NK1(SEG,NK1)    ;--
        ;
        ;Description: Returns the needed data from the NK1 segment.
        ;Input:
        ; SEG (pass-by-reference) The parsed segment.
        ;Output:
        ; NK1 (pass-by-reference) Will return the specific data needed by the
        N VALUE
        K NK1
        ;
        ;Get the contact's name.
        D GETXPN^HLOPRS2(.SEG,.VALUE,2)
        M NK1("NAME")=VALUE
        ;
        ;Get the contact's relationship.
        S NK1("RELATIONSHIP")=$$GET^HLOPRS(.SEG,3,2)
        ;
        ;Get the contact's address.
        D GETAD^HLOPRS2(.SEG,.VALUE,4)
        M NK1("ADDRESS")=VALUE
        ;
        ;Get the contact's phone number.
        S NK1("PHONE")=$$GET^HLOPRS(.SEG,5)
        ;
        ;get contact's role the contact
        S NK1("ROLE")=$$GET^HLOPRS(.SEG,7,2)
        Q
        ;
ERROR(ERROR)    ;--
        D ^%ZTER ;SIS/LM - DEBUG
        ;report error
        ;{needs to be coded}
        Q
