MHV7BU ;WAS/EFJ - HL7 message builder UTILITY ; [12/14/06 11:10am]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Utilities common to message and segment builders.
 ;
 Q
 ;
PID3(PID,ICN,DFN,SSN) ;Build PID3 - Patient Identifier List
 ;  Populates PID array with Patient Identifier List Entries for 
 ; ICN, DFN, and SSN.
 ;
 ;  Integration Agreements:
 ;        10112 : $$SITE^VASITE
 ;
 ;  Input:
 ;     ICN, DFN, SSN - Identifiers
 ;
 ;  Output:
 ;     PID - PID array
 ;
 N STATION,IDCNT
 S STATION=$P($$SITE^VASITE,"^",3)
 S IDCNT=0
 I ICN'="" D
 . S IDCNT=IDCNT+1
 . S PID(3,IDCNT,1)=ICN                 ;Patient ID - ICN
 . S PID(3,IDCNT,4,1)="USVHA"           ;assigning authority ID
 . S PID(3,IDCNT,4,3)="HL70363"         ;assigning authority type
 . S PID(3,IDCNT,5)="NI"                ;Patient ID type
 . S PID(3,IDCNT,6,1)="VA FACILITY ID"  ;assigning facility
 . S PID(3,IDCNT,6,2)=STATION           ;Station number
 . S PID(3,IDCNT,6,3)="L"               ;facility ID type
 ;
 I DFN'="" D
 . S IDCNT=IDCNT+1
 . S PID(3,IDCNT,1)=DFN                 ;Patient ID - DFN
 . S PID(3,IDCNT,4,1)="USVHA"           ;assigning authority ID
 . S PID(3,IDCNT,4,3)="HL70363"         ;assigning authority type
 . S PID(3,IDCNT,5)="PI"                ;Patient ID type
 . S PID(3,IDCNT,6,1)="VA FACILITY ID"  ;assigning facility
 . S PID(3,IDCNT,6,2)=STATION           ;Station number
 . S PID(3,IDCNT,6,3)="L"               ;facility ID type
 ;
 I SSN'="" D
 . S IDCNT=IDCNT+1
 . S PID(3,IDCNT,1)=SSN                 ;Patient ID - SSN
 . S PID(3,IDCNT,4,1)="USSSA"           ;assigning authority ID
 . S PID(3,IDCNT,4,3)="HL70363"         ;assigning authority type
 . S PID(3,IDCNT,5)="SS"                ;Patient ID type
 . S PID(3,IDCNT,6,1)="VA FACILITY ID"  ;assigning facility
 . S PID(3,IDCNT,6,2)=STATION           ;Station number
 . S PID(3,IDCNT,6,3)="L"               ;facility ID type
 Q
 ;
FMTNAME(NAME,SUBSEG,HL,DATATYPE) ;Format comma/space delimited name
 ;  Populates SUBSEG array with formatted and escaped name components
 ; based on the DATATYPE passed.  XCN types and XPN types differ in
 ; that XCN has an ID in the first component effectively shifting the
 ; name components by one.
 ;
 ;  Integration Agreements:
 ;         3065 : NAMEFMT^XLFNAME
 ;
 ;  Input:
 ;         NAME - FileMan formatted name  Ex: PATIENT,FIRST M
 ;           HL - HL7 package array variable
 ;     DATATYPE - HL7 data type to be formatted Ex: XCN, XPN
 ;
 ;  Output:
 ;       SUBSEG - Array to hold the formatted name.
 ;
 ; Example Usage:
 ;      S NAME="SMITH,BOB A"
 ;      K NMARR
 ;      D FMTNAME^MHV7BU(NAME,.NMARR,.HL,"XCN")
 ;      M PD1(4,1)=NMARR
 ;
 N OFFSET
 S OFFSET=(DATATYPE="XCN")
 S NAME=$$NAMEFMT^XLFNAME(.NAME,"F","DSP")
 S SUBSEG(1+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",1),.HL)  ;family
 S SUBSEG(2+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",2),.HL)  ;given
 S SUBSEG(3+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",3),.HL)  ;middle
 S SUBSEG(4+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",4),.HL)  ;suffix
 S SUBSEG(5+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",5),.HL)  ;prefix
 S SUBSEG(6+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",6),.HL)  ;degree
 Q
 ;
FMTNAME2(IEN,FILE,SUBSEG,HL,DATATYPE) ;Lookup and format name
 ;  Looks up name components based on IEN and FILE passed.
 ; Populates SUBSEG array with formatted and escaped name components
 ; based on the DATATYPE passed.  XCN types and XPN types differ in
 ; that XCN has an ID in the first component effectively shifting the
 ; name components by one.
 ;
 ;  Integration Agreements:
 ;         3065 : NAMEFMT^XLFNAME
 ;
 ;  Input:
 ;          IEN - IEN of patient/person in FILE
 ;         FILE - File number of file   Ex: 2 - PATIENT file
 ;           HL - HL7 package array variable
 ;     DATATYPE - HL7 data type to be formatted Ex: XCN, XPN
 ;
 ;  Output:
 ;       SUBSEG - Array to hold the formatted name.
 ;
 ; Example Usage:
 ;      K NMARR
 ;      D FMTNAME^MHV7BU(DFN,2,.NMARR,.HL,"XPN")
 ;      M PID(5,1)=NMARR
 ;
 N NAME,OFFSET
 S OFFSET=(DATATYPE="XCN")
 S NAME("FILE")=FILE,NAME("FIELD")=.01,NAME("IENS")=IEN_","
 S NAME=$$NAMEFMT^XLFNAME(.NAME,"F","DSP")
 S SUBSEG(1+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",1),.HL)  ;family
 S SUBSEG(2+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",2),.HL)  ;given
 S SUBSEG(3+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",3),.HL)  ;middle
 S SUBSEG(4+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",4),.HL)  ;suffix
 S SUBSEG(5+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",5),.HL)  ;prefix
 S SUBSEG(6+OFFSET)=$$ESCAPE^MHV7U($P(NAME," ",6),.HL)  ;degree
 Q
 ;
FMTHL7(DT) ;Convert Fileman formatted dates to HL7 format
 ; Handles imprecise dates properly because $$FMTHL7^XLFDT does not.
 ; Strips Timezone offset
 ;
 ;  Integration Agreements:
 ;        10103 : FMTHL7^XLFDT
 ;
 ;  Input:
 ;     DT - Fileman formatted date/time
 ;
 ;  Output:  Returns HL7 formatted date/time
 ;
 S DT=$$FMTHL7^XLFDT(DT)
 I $E(DT,7,8)="00" S DT=$E(DT,1,6)
 I $E(DT,5,6)="00" S DT=$E(DT,1,4)
 S DT=$P(DT,"-")
 S DT=$P(DT,"+")
 Q DT
 ;
