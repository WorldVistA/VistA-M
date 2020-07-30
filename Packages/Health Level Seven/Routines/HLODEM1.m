HLODEM1 ;ALB/CJM-HL7 - Demonstration Code ;Mar 12, 2020@16:29
 ;;1.6;HEALTH LEVEL SEVEN;**146,10001**;Oct 13, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
        ;
        ;
PID(DFN,SEQ,SEG)        ;--
        ;
        ;Description:
        ; Builds the PID segment using the HLO segment building APIs.
        ; PIMS APIs are called to obtain data from PATIENT file (#2).
        ;
        ;The fields that are included in the segment are:
        ; PID-1 Set ID
        ; PID-3 Patient Identifier List: This is a repeating field.
        ; The first repetition will be set to the ICN, the second to
        ; the SSN.
        ; PID-5 Patient Name
        ; PID-7 Date/Time of Birth
        ; PID-11 Patient Address
        ;
        ;Input:
        ; DFN (required) The IEN of the record in the PATIENT file (#2).
        ; SEQ (optional) Value for PID-1, the Set ID field. For the first
        ; occurrence of the PID segment it should be set to 1, for the
        ; second 2, etc.
        ;
        ;Output:
        ; SEG (pass-by-reference) The segment, returned as a list of fields.
        ;
        ;
        N VA,VADM,VAHOW,VAROOT,VATEST,VAPA,NAME,DOB,SSN,ICN,ADDRESS
        K SEG S SEG="" ;The segment should start off blank.
        ;
        ;Get the patient data using PIMS utilities.
        ;
        S VAHOW=1
        D DEM^VADPT
        S NAME=VADM("NM") ;The name returned in non-standard (VHA) format.
        ;
        ;Standardize the format of the name using a Kernel utility.
        ;Returns the subscripts "FAMILY","GIVEN","MIDDLE","SUBSCRIPT".
        D STDNAME^XLFNAME(.NAME,"C")
        ;
        S DOB=$P(VADM("DB"),"^") ;in FileMan format
        S SSN=$P(VADM("SS"),"^")
        ;
        ;Get the address.
        S VAHOW=""
        D ADD^VADPT
        ;Move address components into ADDRESS.
        S ADDRESS("STREET1")=VAPA(1)
        S ADDRESS("STREET2")=VAPA(2)
        S ADDRESS("CITY")=VAPA(4)
        S ADDRESS("STATE")=$P(VAPA(5),"^",2)
        S ADDRESS("ZIP")=VAPA(6)
        ;
        ;Call an MPI utility to get the ICN.
        S ICN=$P($$GETICN^MPIF001(DFN),"V")
        ;
        ;Use the HLO APIs to set the data into the segment.
        ;
        D SET^HLOAPI(.SEG,"PID",0) ;Set the segment type.
        D SET^HLOAPI(.SEG,SEQ,1) ;Set PID-1.
        ;
        ;Set ICN into PID-3, repetition 1.
        D SET^HLOAPI(.SEG,ICN,3,1,1,1) ;component 1, subcomponent 1
        D SET^HLOAPI(.SEG,"USVHA",3,4,1,1) ;component 4, subcomponent 1
        D SET^HLOAPI(.SEG,"0363",3,4,3,1) ;component 4, subcomponent 3
        D SET^HLOAPI(.SEG,"NI",3,5,1,1) ;component 5
        ;
        ;Set SSN into PID-3, repetition 2.
        D SET^HLOAPI(.SEG,SSN,3,1,1,2) ;component 1, subcomponent 1
        D SET^HLOAPI(.SEG,"USSSA",3,4,1,2) ;component 4, subcomponent 1
        D SET^HLOAPI(.SEG,"0363",3,4,3,2) ;component 4, subcomponent 3
        D SET^HLOAPI(.SEG,"SS",3,5,1,2) ;component 5
        ;
        ;Set the name into PID-5.
        D SETXPN^HLOAPI4(.SEG,.NAME,5)
        ;
        ;Set DOB into PID-7.
        D SETDT^HLOAPI4(.SEG,DOB,7)
        ;
        ;Set the address into PID-11.
        D SETAD^HLOAPI4(.SEG,.ADDRESS,11)
        Q
        ;
NK1(DFN,SEQ,SEG)        ;--
        ;
        ;Description:
        ; Builds the NK1 segment for the primary emergency contact
        ; using the HLO segment building APIs. A PIMS API is called to get the
        ; necesary data from PATIENT file (#2).
        ;
        ;The fields included in the segment are:
        ; NK1-1 Set ID: Set to the SEQ input parameter. For the 1st
        ; occurrence of the NK1 segment it should be set
        ; to 1, for the 2nd 2, etc.
        ; NK1-2 Name
        ; NK1-3 Relationship
        ; NK1-4 Address
        ; NK1-5 Phone Number
        ; NK1-7 Contact Role
        ;
        ;Input:
        ; DFN (required) The IEN of the record in the PATIENT file (#2).
        ; SEQ (optional) Value for NK1-1.
        ;
        ;Output:
        ; SEG (pass-by-reference) Will return an array containing the segment.
        ; The ADDSEG^HLOAPI API must be called to move the segment into
        ; the message.
        ;
        N VA,VAOA,VAHOW,VAROOT,VATEST,NAME,ADDRESS
        K SEG S SEG="" ;The segment should start off blank.
        ;
        ;Get the patient's emergency contact using a PIMS utility.
        S VAOA("A")=1
        D OAD^VADPT
        ;
        S NAME=VAOA(9) ;The name is returned in non-standard (VHA) format.
        ;
        ;Standardize the format of the name using a Kernel utility.
        ;Returns the subscripts "FAMILY","GIVEN","MIDDLE","SUBSCRIPT".
        D STDNAME^XLFNAME(.NAME,"C")
        ;
        ;Move the address components into ADDRESS.
        S ADDRESS("STREET1")=VAOA(1)
        S ADDRESS("STREET2")=VAOA(2)
        S ADDRESS("CITY")=VAOA(4)
        S ADDRESS("STATE")=$P(VAOA(5),"^",2)
        S ADDRESS("ZIP")=VAOA(6)
        ;
        ;Now set the data into the segment.
        ;
        D SET^HLOAPI(.SEG,"NK1",0) ;Set the segment type.
        D SET^HLOAPI(.SEG,SEQ,1) ;Set NK1-1.
        ;
        ;Set the name into NK1-2.
        D SETXPN^HLOAPI4(.SEG,.NAME,2)
        ;
        ;Set the relationship into NK1-3, component 2.
        D SET^HLOAPI(.SEG,VAOA(10),3,2)
        ;
        ;Set the address into NK1-4.
        D SETAD^HLOAPI4(.SEG,.ADDRESS,4)
        ;
        ;Set the phone number into NK1-5.
        D SET^HLOAPI(.SEG,VAOA(8),5)
        ;
        ;Set the contact role into NK1-7.
        D SET^HLOAPI(.SEG,"EP",7,1)
        D SET^HLOAPI(.SEG,"EMERGENCY CONTACT PERSON",7,2)
        D SET^HLOAPI(.SEG,"0131",7,3)
        Q
A08(DFN,ERROR)  ;--
        ;
        ;Description:
        ; Builds an ADT~A08 message and queues it for transmission.
        ; Included segments are the PID and NK1.
        ;
        ;Input:
        ; DFN (required) ien of a patient record in the PATIENT file (#2)
        ;Output:
        ; function:
        ; On Success: Returns the ien of the messgage in the
        ; HLO MESSAGES file (#778).
        ; On Failure: Returns 0.
        ; ERROR - (optional, pass-by-refernce) On failure returns an
        ; error message.
        ;
        ;Required Setup:
        ;<<HLO APPLICATION PARAMETER - file #779.2>>
        ; ** The sending application. **
        ; APPLICATION NAME: HLO DEMO SENDING APPLICATION
        ; ** The package that is sending the message. **
        ; Package File Link: HL7 OPTIMIZED (HLO)
        ;
        ;<<HL Logical Link, file #870>>
        ; ** The receiving facility. **
        ;NODE: HLODEMO
        ; INSTITUTION: <Institution entered here.>
        ; LLP TYPE: TCP
        ; MAILMAN DOMAIN: <The use of DNS DOMAIN is preferred for new links.>
        ; DNS DOMAIN: <TCP/IP domain name for DNS entered here.>
        ; TCP/IP ADDRESS: <IP address entered here.>
        ; TCP/IP SERVICE TYPE: CLIENT (SENDER)
        ; TCP/IP PORT (OPTIMIZED): <Port # entered here.>
        ;
        ;
        N SEG,PARMS,WHOTO,MSG
        S PARMS("MESSAGE TYPE")="ADT"
        S PARMS("EVENT")="A08"
        I '$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR) Q 0
        D PID(DFN,1,.SEG)
        I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
        D NK1(DFN,1,.SEG)
        I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q 0
        S PARMS("SENDING APPLICATION")="HLO DEMO SENDING APPLICATION"
        S WHOTO("RECEIVING APPLICATION")="HLO DEMO RECEIVING APPLICATION"
        ; SIS/LM - Modify next to match the test link name
        S WHOTO("FACILITY LINK NAME")="HLODEMO"
        Q $$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
        ;
BATCHA08(DFNLIST,ERROR) ;--
        ;
        ;Description:
        ; Builds a batch of ADT~A08 messages and queues it for transmission.
        ; The DFNLIST is a list of patients to include messages for.
        ;
        ;Input:
        ; DFNLIST (required, pass-by-reference) A list of patient DFNs in the
        ; format DFNLIST(<DFN)="".
        ;Output:
        ; Function:
        ; On Success: Returns the ien of the messgage in the
        ; HLO MESSAGES file (#778).
        ; On Failure: Returns 0.
        ; ERROR (optional, pass-by-refernce) On failure returns an error
        ; message.
        ;
        ;Required Setup: Same as for A08^HLODEM1
        ;
        N MSG,PARMS,SEG,WHOTO,MSG,DFN,QUIT
        I '$$NEWBATCH^HLOAPI(,.MSG,.ERROR) Q 0
        S (DFN,QUIT)=0
        F  S DFN=$O(DFNLIST(DFN)) Q:(QUIT!('DFN))  D
        .N PARMS
        .S PARMS("MESSAGE TYPE")="ADT"
        .;SIS/LM - Next event type should be A08
        .;S PARMS("EVENT")="AO8"
        .S PARMS("EVENT")="A08"
        .I '$$ADDMSG^HLOAPI(.MSG,.PARMS,.ERROR) S QUIT=1 Q
        .D PID(DFN,1,.SEG)
        .I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q
        .D NK1(DFN,1,.SEG)
        .I '$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR) Q
        ;
        S PARMS("SENDING APPLICATION")="HLO DEMO SENDING APPLICATION"
        S WHOTO("RECEIVING APPLICATION")="HLO DEMO RECEIVING APPLICATION"
        S WHOTO("FACILITY LINK NAME")="HLODEMO"
        Q $$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
        Q
