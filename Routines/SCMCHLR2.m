SCMCHLR2 ;ALB/KCL - PCMM HL7 Reject Processing - Build List Area; 10-JAN-2000
 ;;5.3;Scheduling;**210,272,297,458,505**;AUG 13, 1993;Build 20
 ;
EN(SCARY,SCBEG,SCEND,SCEPS,SCSORTBY,SCCNT) ;
 ; Description: This entry point is used to build list area for
 ; PCMM Transmission Errors.
 ;
 ; The following variables are 'system wide variables' in the
 ; PCMM Transmission Error Processing List Manager application:
 ;  Input:
 ;      SCARY - Global array subscript
 ;      SCBEG - Begin date for date range
 ;      SCEND - End date for date range
 ;      SCEPS - Error processing statuses
 ;                1 -> New
 ;                2 -> Checked
 ;                3 -> Both
 ;   SCSORTBY - Sort by criteria
 ;                N -> Patient Name
 ;                D -> Date/Time Ack Received
 ;                P -> Provider
 ;                I -> Institution
 ;
 ; Output:
 ;  SCCNT - Contains number of lines in the list, pass by reference
 ;
 ;Display FM wait msg
 D WAIT^DICD
 ;
 ;Get PCMM HL7 Trans Log errors
 D GET(SCARY,SCBEG,SCEND,SCEPS,SCSORTBY)
 ;
 ;Build list area for PCMM HL7 Trans Log errors
 D BLDLIST^SCMCHLR3(SCSORTBY,SCEPS,.SCCNT)
 ;
 ;If no PCMM HL7 Trans Log errors, display msg in list area
 I 'SCCNT D
 .D SET^SCMCHLR3(SCARY,1,"",1,36,0,,,,.SCCNT)
 .D SET^SCMCHLR3(SCARY,2,"No 'PCMM Transmission Errors' to display.",4,41,0,,,,.SCCNT)
 Q
 ;
 ;
GET(SCARY,SCBEG,SCEND,SCEPS,SCSORTBY) ;
 ; Description: Get PCMM HL7 Transmission Log errors.
 ;
 ;  Input:
 ;      SCARY - Global array subscript
 ;      SCBEG - Begin date for date range
 ;      SCEND - End date for date range
 ;      SCEPS - Error processing status
 ;   SCSORTBY - Sort by criteria
 ;
 ; Output:
 ;  PCMM transmission log error list sorted by:
 ;
 ;   Patient Name: ^TMP("SCERRSRT",$J,<sort by>,<patient name>,<trans log IEN>,<err code ien>)
 ; OR,
 ;   Date/Time Ack Rec'd: ^TMP("SCERRSRT",$J,<sort by>,<date/time ack rec'd>,<trans log IEN>,<err code ien>)
 ; OR,
 ;   Provider: ^TMP("SCERRSRT",$J,<sort by>,<provider>,<trans log IEN>,<err code ien>)
 ; OR,
 ;   INSTITUTION: ^TMP("SCERRSRT",$J,<sort by>,<institution>,<trans log IEN>,<err code ien>)
 ;   (INSTITUTION SORT INTRO. IN SD*5.3*505)
 ;
 N SCDFN,SCDTR,SCERIEN,SCTLIEN,SCSTAT,SCHLIEN,SCHLIEN1,SCHLIEN2
 N SCHLIEN3,SCHLIEN4,SCHLIEN5,SCTP,SCTPOS,SCTPSS
 ;
 ;Loop thru PCMM HL7 Trans Log for selected date range
 F SCDTR=SCBEG:0 S SCDTR=$O(^SCPT(404.471,"AST",SCDTR)) Q:'SCDTR!($P(SCDTR,".")>SCEND)  D
 .;loop thru status
 .S SCSTAT=0
 .F  S SCSTAT=$O(^SCPT(404.471,"AST",SCDTR,SCSTAT)) Q:SCSTAT=""  D
 ..;loop thru patients
 ..S SCDFN=0
 ..F  S SCDFN=$O(^SCPT(404.471,"AST",SCDTR,SCSTAT,SCDFN)) Q:SCDFN=""  D
 ...;loop through (#404.471) ien's
 ...S SCTLIEN=0
 ...F  S SCTLIEN=$O(^SCPT(404.471,"AST",SCDTR,SCSTAT,SCDFN,SCTLIEN)) Q:'SCTLIEN  D
 ....;loop thru ien's of error code mult. and setup sort array
 ....S SCERIEN=0
 ....F  S SCERIEN=$O(^SCPT(404.471,SCTLIEN,"ERR",SCERIEN)) Q:'SCERIEN  D SORT(SCSORTBY,SCDTR,SCDFN,SCEPS,SCTLIEN,SCERIEN)
 ;
 Q
 ;
 ;
SORT(SCSORTBY,SCDTR,SCDFN,SCEPS,SCTLIEN,SCERIEN) ;
 ; Description: Used to set up sort array based on 'Sort Criteria' and
 ; 'Error Processing Status' for PCMM Transmission Errors list display.
 ;
 ;  Input:
 ;   SCSORTBY - Sort by criteria
 ;      SCDTR - PCMM transmission log date/time ack received
 ;      SCDFN - Patient IEN
 ;      SCEPS - Error processing status
 ;    SCTLIEN - PCMM transmission log IEN
 ;    SCERIEN - IEN of record in Error Code (#404.47142) multiple
 ;
 ; Output: None
 ;
 N SCTLOG
 ;
 ;If sort by criteria is 'Date/Time Ack Received'
 I SCSORTBY="D" D
 .;get data from PCMM HL7 Trans Log
 .I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D
 ..;if Error Proc Status matches selected Error Proc Status
 ..I (SCEPS=$G(SCTLOG("ERR","EPS"))!(SCEPS>2)) D
 ...;setup ^tmp array sorted by date/time ack rec'd
 ...S ^TMP("SCERRSRT",$J,SCSORTBY,SCDTR,SCTLIEN,SCERIEN)=""
 ;
 ;If sort by criteria is 'Provider'
 I SCSORTBY="P" D
 .N SCPTR,SCPROV,SCHL
 .;get data from PCMM HL7 Trans Log
 .I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D
 ..;if Error Proc Status matches selected Error Proc Status
 ..I (SCEPS=$G(SCTLOG("ERR","EPS"))!(SCEPS>2)) D
 ...;get data from PCMM HL7 ID file
 ...I $$GETHL7ID^SCMCHLA2($G(SCTLOG("ERR","ZPCID")),.SCHL) D
 ....;get provider from POSITION ASSIGNMENT HISTORY file
 ....S SCPTR=$P($G(SCHL("HL7ID")),"-",2)  ; pointer to PCMM HL7 ID file
 ....I $G(SCTLOG("WORK")) S SCPROV=$$PROV^SCMCHLP(SCTLOG("WORK"))
 ....I '$G(SCTLOG("WORK")) S SCPROV=$P($G(^SCTM(404.52,+SCPTR,0)),"^",3)
 ....;setup ^tmp array sorted by provider
 ....S ^TMP("SCERRSRT",$J,SCSORTBY,$S($G(SCPROV)'="":$$EXTERNAL^DILFD(404.52,.03,,SCPROV),1:"ZZZUNKNOWN"),SCTLIEN,SCERIEN)=""
 ;
 ;If sort by criteria is 'Patient' (default)
 I SCSORTBY="N" D
 .;get data from PCMM HL7 Trans Log
 .I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D
 ..;if Error Proc Status matches selected Error Proc Status
 ..I (SCEPS=$G(SCTLOG("ERR","EPS"))!(SCEPS>2)) D
 ...;setup ^tmp array sorted by patient
 ...I SCDFN="W" I $G(SCTLOG("WORK"))="" S SCDFN=""
 ...S ^TMP("SCERRSRT",$J,SCSORTBY,$S($P($G(^DPT(+SCDFN,0)),U)'="":$P(^(0),U),SCDFN="W":"Workload Message",1:"UNKNOWN"),SCTLIEN,SCERIEN)=""
 ;
 ;If sort by criteria is 'Institution" SD*5.3*505
 I SCSORTBY="I" D
 .;get data from PCMM HL7 Trans Log
 .I $$GETLOG^SCMCHLA(SCTLIEN,SCERIEN,.SCTLOG) D
 ..I (SCEPS=$G(SCTLOG("ERR","EPS"))!(SCEPS>2)) D
 ...;setup ^tmp array sorted by institution
 ...S SCHLIEN=0
 ...F  S SCHLIEN=$O(^SCPT(404.471,SCTLIEN,"ZPC",SCHLIEN)) Q:SCHLIEN=""  D
 ....S SCHLIEN1=$G(^SCPT(404.471,SCTLIEN,"ZPC",SCHLIEN,0)) Q:SCHLIEN<1  D
 .....S SCHLIEN2=$P(SCHLIEN1,U,2),SCHLIEN3=+$G(^SCPT(404.49,SCHLIEN2,0))
 .....S SCHLIEN4=$G(^SCPT(404.43,SCHLIEN3,0)) Q:SCHLIEN4=""  D
 ......S SCHLIEN5=$G(^SCPT(404.42,+SCHLIEN4,0)) Q:SCHLIEN5=""  D
 .......S SCTPOS=$P(SCHLIEN4,U,2),SCTPSS=$G(^SCTM(404.57,+SCTPOS,0))
 .......S SCTP=$P(SCTPSS,U,2),SCY=$G(^SCTM(404.51,+SCTP,0)),SCINT=$P(SCY,U,7)
 .......S SCINNAM=$$GET1^DIQ(4,+SCINT_",",99)
 .......S ^TMP("SCERRSRT",$J,SCSORTBY,$S($G(SCINNAM)'="":SCINNAM,1:"UNK"),SCTLIEN,SCERIEN)=""
 .......K SCTP,SCTPOS,SCTPSS,SCTP,SCY,SCINNAM,SCINT
 Q
