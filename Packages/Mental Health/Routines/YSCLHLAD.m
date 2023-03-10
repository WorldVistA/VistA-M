YSCLHLAD ;DSS/PO-CLOZAPINE DATA TRANSMISSION-Messaging-ADT ;19 May 2020 14:13:48
 ;;5.01;MENTAL HEALTH;**149**;Dec 30, 1994;Build 72
 Q
 ;
 ; Reference to ^%ZTER supported by DBIA #1621
 ; Reference to ^DICRW supported by DBIA #10005
 ; Reference to ^DIQ supported by DBIA #2056
 ; References to ^HLOAPI supported by DBIA #4716
 ; References to HLOAPI1 supported by DBIA #4717
 ;
ADTA28(YSCLARR,YSILENT) ; Build and send registration message
 ; input:   YSCLARR   data array to build HL7 segments
 ;
 ; APPARMS - HLO application parameters
 ; HL - delimiters for HL7 utilities
 ; HL7RES - Hl7 send result, 0 if message not sent
 ; HLMSTATE - message state for HLO
 ; SEG - segment for HLO
 ; YSCLDEST - destination name for HLO
 ; YSHLERR - message creation error
 ; YSWHTO - destination for HLO
 ;
 N APPARMS,HL,HL7RES,HLMSTATE,SEG,YSCLDEST,YSHLERR,YSWHTO
 ;
 ; create message
 S APPARMS("MESSAGE TYPE")="ADT"
 S APPARMS("EVENT")="A28"
 S APPARMS("MESSAGE STRUCTURE")="ADT_A05"
 S APPARMS("VERSION")="2.5.1"
 I '$$NEWMSG^HLOAPI(.APPARMS,.HLMSTATE,.YSHLERR) U IO W !,$G(YSHLERR) Q
 ;
 ; create EVN segment
 D SET^HLOAPI(.SEG,"EVN",0)
 D SET^HLOAPI(.SEG,$$FMTHL7^XLFDT($$NOW^XLFDT),2)
 Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)
 ;
 D PID^YSCLHLPD(.SEG,.YSCLARR)    ;creat PID segment
 Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)
 ;
 ; create ROL segment
 D SET^HLOAPI(.SEG,"ROL",0)
 D SET^HLOAPI(.SEG,"UP",2) ; update
 D SET^HLOAPI(.SEG,"PRX",3)
 D SET^HLOAPI(.SEG,"HL70443",3,3)
 D SET^HLOAPI(.SEG,"Prescribing Physician",3,2)
 ;
 D SET^HLOAPI(.SEG,YSCLARR("PROVIDER_DEA"),4,1,1,1)
 D SET^HLOAPI(.SEG,YSCLARR("PROVIDER_LAST NAME"),4,2,1,1)
 D SET^HLOAPI(.SEG,YSCLARR("PROVIDER_FIRST NAME"),4,3,1,1)
 D SET^HLOAPI(.SEG,"DEA",4,13,1,1)
 ;
 D SET^HLOAPI(.SEG,YSCLARR("PROVIDER_NPI"),4,1,1,2)
 D SET^HLOAPI(.SEG,YSCLARR("PROVIDER_LAST NAME"),4,2,1,2)
 D SET^HLOAPI(.SEG,YSCLARR("PROVIDER_FIRST NAME"),4,3,1,2)
 D SET^HLOAPI(.SEG,"NPI",4,13,1,2)
 Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)    ; "ROL" segment
 ;
 ; create PV1 segment
 D SET^HLOAPI(.SEG,"PV1",0)
 D SET^HLOAPI(.SEG,YSCLARR("PATIENT_INPAT/OUTPAT"),2)
 Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)    ; "PV1" segment
 ;
 ; create OBX segment for clozapine status
 D  Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)   ;"OBX|1|..."
 . N SEGSEQ S SEGSEQ=1
 . D SET^HLOAPI(.SEG,"OBX",0)
 . D SET^HLOAPI(.SEG,SEGSEQ,1) ; sequence id
 . D SET^HLOAPI(.SEG,"CE",2)   ; value type
 . D SET^HLOAPI(.SEG,"PTSTAT",3,2) ; observation ID
 . D SET^HLOAPI(.SEG,YSCLARR("PATIENT_CLOZ STATUS"),5) ; patient status
 . D SET^HLOAPI(.SEG,"F",11) ; observation result status -  "F" means Final Results   
 ;
 ; create OBX segment for dispense frequency
 D  Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)  ;"OBX|2|..."
 . N SEGSEQ S SEGSEQ=2
 . D SET^HLOAPI(.SEG,"OBX",0)
 . D SET^HLOAPI(.SEG,SEGSEQ,1)  ; sequence id
 . D SET^HLOAPI(.SEG,"CE",2)   ; value type
 . D SET^HLOAPI(.SEG,"DISPENSE FREQUENCY",3,2) ; observation ID
 . D SET^HLOAPI(.SEG,YSCLARR("LAB_FREQ"),5) ;   
 . D SET^HLOAPI(.SEG,"F",11) ; observation result status, "F" means Final Results 
 . Q
 ;
 ; create OBX segment for WBC
 D  Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)      ;"OBX|3|..."
 . N SEGSEQ S SEGSEQ=3
 . D SET^HLOAPI(.SEG,"OBX",0)
 . D SET^HLOAPI(.SEG,SEGSEQ,1)  ; sequence ID
 . D SET^HLOAPI(.SEG,"CE",2)   ; value type
 . D SET^HLOAPI(.SEG,"WBC",3,2)  ; observation ID
 . D SET^HLOAPI(.SEG,YSCLARR("LAB_WBC VAL"),5) ; WBC  value
 . D SET^HLOAPI(.SEG,"F",11) ; observation result status, "F" means Final Results 
 . ;ajf ; Don't set date if wbc value is null
 . I $G(YSCLARR("LAB_WBC VAL")) D SET^HLOAPI(.SEG,YSCLARR("LAB_COLLECTION DATE"),14)
 ; create OBX segment for ANC
 D  Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)  ;"OBX|4|..."
 . N SEGSEQ S SEGSEQ=4
 . D SET^HLOAPI(.SEG,"OBX",0)
 . D SET^HLOAPI(.SEG,SEGSEQ,1)  ; sequence ID
 . D SET^HLOAPI(.SEG,"CE",2)   ; value type
 . D SET^HLOAPI(.SEG,"ANC",3,2) ; observation ID    ;???PVZ should it come form LABSTR  e.g.   "ABS NEUT"
 . D SET^HLOAPI(.SEG,YSCLARR("LAB_ANC VAL"),5)
 . D SET^HLOAPI(.SEG,"F",11) ; observation result status -  "F" means Final Results 
 . ;ajf ; Don't set date if ANC value is null
 . I $G(YSCLARR("LAB_ANC VAL")) D SET^HLOAPI(.SEG,YSCLARR("LAB_COLLECTION DATE"),14)
 ;
 ; create OBX segment for site DEA number
 D  Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)  ;"OBX|5|..."
 . N SEGSEQ S SEGSEQ=5
 . N SITEDEA S SITEDEA=$$GET1^DIQ(4,YSCLARR("PROVIDER_DEFAULT DIV."),52)
 . D SET^HLOAPI(.SEG,"OBX",0)
 . D SET^HLOAPI(.SEG,SEGSEQ,1)  ; sequence ID
 . D SET^HLOAPI(.SEG,"CE",2)  ; value type
 . D SET^HLOAPI(.SEG,"Facility DEA number",3,2)  ; observation ID
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_SITE DEA"),5)  ; facility DEA number
 . D SET^HLOAPI(.SEG,"F",11)  ; observation result status - "F" means Final
 ;
 D  Q:'$$ADDSEG^HLOAPI(.HLMSTATE,.SEG)  ;"OBX|6|..."
 . N SEGSEQ S SEGSEQ=6
 . D SET^HLOAPI(.SEG,"OBX",0)
 . D SET^HLOAPI(.SEG,SEGSEQ,1) ; sequence id
 . D SET^HLOAPI(.SEG,"CE",2)   ; value type
 . D SET^HLOAPI(.SEG,"SITELOC",3,2) ; observation ID
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_ID"),5) ; site ID (division)
 . D SET^HLOAPI(.SEG,"F",11)  ; observation result status - "F" means Final
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_SITE NAME"),23)
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_STATION"),23,10)
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_STREET ADDR 1"),24,1)
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_STREET ADDR 2"),24,2)
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_CITY"),24,3)
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_STATE"),24,4)
 . D SET^HLOAPI(.SEG,YSCLARR("SITE_ZIP"),24,5)
 ;
 S APPARMS("SENDING APPLICATION")="YSCL-REG-SEND"
 S APPARMS("ACCEPT ACK TYPE")="AL"
 S APPARMS("APP ACK TYPE")="NE"
 S APPARMS("ACCEPT ACK RESPONSE")="COMTRESP^YSCLHLAD"  ; temporary to see how COMMIT ack works
 S APPARMS("APP ACK RESPONSE")="APPRESP^YSCLHLAD"  ; temporary to see how APP ack works
 S YSCLDEST="YSCL-REG-REC"
 S YSWHTO("RECEIVING APPLICATION")=YSCLDEST
 S YSWHTO("FACILITY LINK NAME")="YSCL-NCCC"
 S HL7RES=$$SENDONE^HLOAPI1(.HLMSTATE,.APPARMS,.YSWHTO,.YSHLERR)
 I 'HL7RES D APPERROR^%ZTER("HLO error sending ClozMod ADT^AD8")  ; log error (D ^XTER) and continue
 ; leave code for future developers
 ;D:'$G(YSILENT)
 ;. W:HL7RES !,"ADT A05 message IEN=",HL7RES," generated and sent to ",YSCLDEST,!
 ;. W:'HL7RES !,"Error: ",$G(YSHLERR),!,"      No ADT A05 message sent!"
 ;
 Q HL7RES
 ;
COMTRESP ; process COMMIT ACCEPT ACK RESPONSE   
 ;
 D DT^DICRW N HDR,MSG,RES,RTNOW,YSXTMP
 S YSXTMP("1stNode")=$T(+0)_" "_DT  ; first storage node in ^XTMP
 S RES=$$STARTMSG^HLOPRS(.MSG,HLMSGIEN,.HDR)
 S RTNOW=$$NOW^XLFDT
 S ^XTMP(YSXTMP("1stNode"),"COMTRESP",RTNOW,$J,"MSGIEN")=$G(HLMSGIEN)
 S ^XTMP(YSXTMP("1stNode"),"COMTRESP",RTNOW,$J,"RES")=RES
 M ^XTMP(YSXTMP("1stNode"),"COMTRESP",RTNOW,$J,"MSG")=MSG
 M ^XTMP(YSXTMP("1stNode"),"COMTRESP",RTNOW,$J,"HDR")=HDR
 ; expires in 30 days
 S ^XTMP(YSXTMP("1stNode"),0)=$$HTFM^XLFDT($H+30)_U_DT_U_"YSCL* HL7 RESPONSE"
 Q
 ;
APPRESP ; process ACCEPT ACK RESPONSE   
 ;
 N MSGIEN,RTNOW,VAR,YSXTMP
 S YSXTMP("1stNode")=$T(+0)_" "_DT  ; first storage node in ^XTMP
 S RTNOW=$$NOW^XLFDT,MSGIEN=+$G(HLMSGIEN)
 S ^XTMP(YSXTMP("1stNode"),"APPRESP",RTNOW,MSGIEN,$J)="APP ACK RESPONSE"
 S VAR="HL" F  S VAR=$O(@VAR) Q:'($E(VAR,1,2)="HL")  M ^XTMP(YSXTMP("1stNode"),"APPRESP",RTNOW,MSGIEN,$J,VAR)=@VAR
 ; expires in 30 days
 S ^XTMP(YSXTMP("1stNode"),0)=$$HTFM^XLFDT($H+30)_U_DT_U_"YSCL* HL7 RESPONSE"
 Q
 ;
