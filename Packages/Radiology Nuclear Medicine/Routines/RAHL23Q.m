RAHL23Q ;HINES OIFO/GJC process query message/event type (QRY/R02) ; 15 Aug 2008  2:27 PM
 ;;5.0;Radiology/Nuclear Medicine;**78**;Mar 16, 1998;Build 5
 ;
 ;Integration Agreements
 ;----------------------
 ;%ZTLOAD(10063), $$FIND1^DIC(2051), $$NEWMSG^HLOAPI(4716), $$SENDONE^HLOAPI1(4717)
 ;$$GET^HLOPRS(4718), $$NEXTSEG^HLOPRS(4718), $$STARTMSG^HLOPRS(4718), $$FMADD^XLFDT(10103)
 ;$$HL7TFM^XLFDT(10103), $$NOW^XLFDT(10103), XMD(10070)
 ;
RCVQRY ;receive & process the inbound query
 S:$G(U)'="^" U="^" ;under development
 N HL,HLA,HLSTART,RAQFC,RAQPRI,RAQID,RAQDRT,RAQDRDT,RAQWHO,RAQWHAT,RAQDEPT
 N RAQWHERE,RAQSTRT,RAQEND,RAQUANT,RAQUNIT
 N RACNTRL,RACS,RADFN,RAECH,RAEDT,RAEND,RAERR,RAESC,RAFS,RAI,RAJ,RAK,RAMSH,RAPRIO,RARPT
 N RARS,RASCS,RASDT,RASEG,RATXT,RAX
 ;Please be aware that when using HLO the database where the message headers and
 ;message bodies are filed have changed.
 ;legacy VistA HL7                  optimized VistA HL7 (HLO)
 ;-----------------------------------------------------
 ;HL7 MESSAGE TEXT (#772)           HLO MESSAGE BODY (#777)
 ;HL7 MESSAGE ADMINISTRATION (#773) HLO MESSAGES (#778)
 ;
MSH ;Parse the header and return individual values
 I '$$STARTMSG^HLOPRS(.HLMSTATE,HLMSGIEN,.RAMSH) D  Q
 .S RATXT(1)="Error processing the NTP query used to return radiology results."
 .S RATXT(2)="",RATXT(3)="Contact the VistA Radiology/Nuclear Medicine development team."
 .D ERR(.RATXT) Q
 ;
 ;RAHDR array elements defined
 ;----------------------------
 ;RAMSH("SEGMENT TYPE")="MSH"                 RAMSH("DT/TM OF MESSAGE")
 ;RAMSH("FIELD SEPARATOR")                    RAMSH("SECURITY")
 ;RAMSH("COMPONENT SEPARATOR")                RAMSH("MESSAGE TYPE")
 ;RAMSH("SUBCOMPONENT SEPARATOR")             RAMSH("EVENT")
 ;RAMSH("REPETITION SEPARATOR")               RAMSH("MESSAGE STRUCTURE")
 ;RAMSH("ESCAPE CHARACTER")                   RAMSH("MESSAGE CONTROL ID")
 ;RAMSH("SENDING APPLICATION")                RAMSH("PROCESSING ID")
 ;RAMSH("SENDING FACILITY",1) 1st component   RAMSH("PROCESSING MODE")
 ;RAMSH("SENDING FACILITY",2) 2nd component   RAMSH("VERSION")
 ;RAMSH("SENDING FACILITY",3) 3rd component   RAMSH("CONTINUATION POINTER")
 ;RAMSH("RECEIVING APPLICATION")              RAMSH("ACCEPT ACK TYPE")
 ;RAMSH("RECEIVING FACILITY",1) 1st component RAMSH("APP ACK TYPE")
 ;RAMSH("RECEIVING FACILITY",2) 2nd component RAMSH("COUNTRY")
 ;RAMSH("RECEIVING FACILITY",3) 3rd component
 ;
 S RACNTRL=RAMSH("MESSAGE CONTROL ID")
 ;
 ;perform some sanity checks...
 ;
 I RAMSH("MESSAGE TYPE")'="QRY"!(RAMSH("EVENT")'="R02") D  Q
 .N X,X1
 .S X=$S(RAMSH("MESSAGE TYPE")'="QRY":"HL7 MESSAGE TYPE",1:"HL7 EVENT TYPE")
 .S X1=$S(RAMSH("MESSAGE TYPE")'="QRY":"(QRY)",1:"(R02)")
 .S RATXT(1)="The "_X_" expected "_X1_" differs from the "_X
 .S RATXT(2)="received: "_$S(RAMSH("MESSAGE TYPE")'="QRY":RAMSH("MESSAGE TYPE"),1:RAMSH("MESSAGE TYPE"))
 .S RATXT(3)="",RATXT(4)="Contact the VistA Radiology/Nuclear Medicine development team."
 .S RATXT(5)="",RATXT(6)="MESSAGE CONTROL ID: "
 .D ERR(.RATXT) Q
 ;
 ;namespace other RA* variables to their RAHDR() equivalent (save keys strokes)
 S RAECH=RAMSH("ENCODING CHARACTERS")
 S RAFS=RAMSH("FIELD SEPARATOR")
 S RACS=RAMSH("COMPONENT SEPARATOR")
 S RARS=RAMSH("REPETITION SEPARATOR")
 S RAESC=RAMSH("ESCAPE CHARACTER")
 S RASCS=RAMSH("SUBCOMPONENT SEPARATOR")
 ;
SEG ;parse the body of the message (segments)
 F  Q:'$$NEXTSEG^HLOPRS(.HLMSTATE,.RASEG)  D  Q:$D(RAERR)#2
 .;get the fields and set the proper local variables...
 .I $$GET^HLOPRS(.RASEG,RAFS,RACS,RASCS,RARS)
 .;the data is in this format: SEG(FIELD #,REP,COMP,SUBCOMP)
 .D @RASEG(0)
 .Q
 ;
 ;I $D(RAERR)#2 D  Q
 ;.S RATXT(1)="Error processing the NTP query used to return radiology results."
 ;.S RATXT(2)="",RATXT(3)="Error: "_$G(RAERR),RATXT(4)=""
 ;.S RATXT(5)="Contact the VistA Radiology/Nuclear Medicine development team."
 ;.D ERR(.RATXT) Q
 ;
 D TASK
 Q
 ;
QRD ;Analyze data from the QRD segment from Non-VistA System
 ;
 ; Local Variable & value                 HL7 segment-field
 ;---------------------------------------------------------
 ;RAQDT   = Query Date/Time                      QRD-1
 ;RAQFC   = Query Format code                    QRD-2 
 ;RAQPRI  = Query Priority                       QRD-3
 ;RAQID   = Query ID                             QRD-4
 ;RAQDRT   = Deferred Resp. Type                 QRD-5
 ;RAQDRDT  = Deferred Resp. Date/Time            QRD-6
 ;RAQUANT = Quantity Limited Request             QRD-7
 ;RAQWHO  = Who Subject Filter (patient SSN)     QRD-8
 ;RAQWHAT = What Subject Filter                  QRD-9
 ;RAQDEPT = What Dept. Data Code (accession)     QRD-10
 ;
 ;RAQUANT (QRD-7) Quantity Limited Request has two components: 1st=quantity, 2nd=units
 ;
 S RAQDT=$G(RASEG(1,1,1,1)),RAQFC=$G(RASEG(2,1,1,1)),RAQPRI=$G(RASEG(3,1,1,1))
 S RAQID=$G(RASEG(4,1,1,1)),RAQDRT=$G(RASEG(5,1,1,1)),RAQDRDT=$G(RASEG(6,1,1,1))
 S RAQUANT=$G(RASEG(7,1,1,1)),RAQUNIT=$G(RASEG(7,1,2,1)),RAQWHO=$G(RASEG(8,1,1,1))
 S RAQWHAT=$G(RASEG(9,1,1,1)),RAQDEPT=$G(RASEG(10,1,1,1))
 ;
 S RAQWHO=$TR(RAQWHO,"-","") ;strip out the dashes in the SSN
 ;
 ;We need to know the type of query: patient or accession
 ;RAQDEPT denotes an accession based query; RAQWHO denotes a patient based query
 ;Both query types require QRD-1, QRD-2, QRD-3, QRD-4, QRD-7, & QRD-9
 ;
 I RAQDT="" S RAERR="Missing Query Date/Time (QRD-1)" Q
 I RAQFC="" S RAERR="Missing Query Format Code (QRD-2)" Q
 I RAQPRI="" S RAERR="Missing Query Priority (QRD-3)" Q
 I RAQID="" S RAERR="Missing Query ID (QRD-4)" Q
 ;
 ;-if the number of reports to return is less than zero default to one
 ;-if the number of reports to return is greater than one hundred default
 ; to one hundred
 S:RAQUANT'>0 RAQUANT=1 S:RAQUANT>1000 RAQUANT=1000
 ;
 I RAQUNIT="" S RAERR="Missing Quantity Limited Request (units QRD-7.2)" Q
 I RAQWHAT="" S RAERR="Missing What Subject Filter (QRD-9)" Q
 I RAQWHO="",(RAQDEPT="") S RAERR="Indeterminable query type" Q
 I $L(RAQWHO),($L(RAQDEPT)) S RAERR="Indeterminable query type" Q
 ;
 ;Who Subject Filter (passed as a SSN, convert to the DFN of the patient)
 ;I $$FIND1^DIC(2,"","","`"_RAQWHO)'>0 S RAERR="Invalid patient identifier; no match in PATIENT (#2) file" Q
 S RADFN=$$FIND1^DIC(2,,"X",RAQWHO,"SSN")
 I RADFN'>0 S RAERR="Invalid patient SSN identifier; no match in PATIENT (#2) file"
 ;
 ;Note: if RAQUANT=1 then there will be not need to implement
 ;a continuation pointer.
 ;
 Q
 ;
QRF ;Analyze data from the QRF segment from Non-VistA System
 ;
 ; Local Variable & value                                  HL7 segment-field
 ;--------------------------------------------------------------------------
 ;RAQWHERE = Where Subject Filter (which department/system)      QRF-1
 ;RAQSTART = When Data Start Date/Time                           QRF-2
 ;  RAQEND = When Data End Date/Time                             QRF-3
 ;
 S RAQWHERE=$G(RASEG(1,1,1,1)),RAQSTART=$G(RASEG(2,1,1,1)),RAQEND=$G(RASEG(3,1,1,1))
 I RAQWHERE="" S RAERR="Missing Where(department/system) Subject Filter (QRF-1)" Q
 I RAQEND="" S RAERR="Missing When Data End Date/Time (QRF-3)" Q
 ;
 ;A patient based query requires 'When Data Start Date/Time' & 'When Data End Date/Time' data
 ;
 I $G(RADFN),(RAQSTART="") S RAERR="Missing When Data Start Date/Time (QRF-2)" Q
 ;check for valid HL7 date/time data
 ;set RAEDT=FileMan end date & RASDT=FileMan START date
 I $L(RAQSTART) D
 .S RASDT=$E($$HL7TFM^XLFDT(RAQSTART),1,12) ;to the minute...
 .S:RASDT=-1 RAERR="Invalid When Data Start Date/Time (QRF-2)"
 .Q
 S RAEDT=$E($$HL7TFM^XLFDT(RAQEND),1,12) ;to the minute...
 S:RAEDT=-1 RAERR="Invalid When Data End Date/Time (QRF-3)"
 Q
 ;
TASK ;look up the the results (verified) for a specific patient over a specific time frame
 ;this is a tasked process
 ;
 ;If RADEBUG is defined then DO NOT task off the HL7 message building process fall right
 ;through to the START subroutine.
 ;  
 I '($D(RADEBUG)#2) D  Q
 .S ZTRTN="START^RAHL23Q",ZTDESC="RA ORF/R04 - return observed radiology results to NTP"
 .S ZTSAVE("RA*")="",ZTIO="",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 .D ^%ZTLOAD
 .Q
 ;
START ;begin the process of replying to the client side query QRY/R02
 ;
 ;Identify the type of the client side query
 ;------------------------------------------
 ; -I $D(RADFN) then the query is patient based (over time; the # results may be capped)
 ; -Else the query is accession based and one result is all that is asked for.
 ;
 ;if there is an error because of the query parameters passed from the
 ;client fire off the negative acknowledgement and exit this process.
 N RACNT S RACNT=0 I $D(RAERR)#2 D NAK,XIT Q
 ;attempt to build the query response. If there are no results to be passed
 ;(RACNT=0) fire off a negative acknowledgement
 I $D(RADFN)#2 D
 .N RACNI,RACONST,RADTE,RADTI,RAIEDT,RAISDT,RARPT,RAESTAT,RAY2,RAY3 S RACONST=9999999.9999
 .S RAZISDT=$$FMADD^XLFDT(RASDT,0,0,-1,0) ;subtract a minute from the start date
 .S RAZIEDT=(RAEDT\1)+.2359 ;the end date must go to the end of the day
 .S RAISDT=RACONST-RAZISDT,(RADTI,RAIEDT)=RACONST-RAZIEDT K RAZIEDT,RAZISDT
 .F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0!(RADTI>RAISDT)  D  Q:RACNT>RAQUANT
 ..S RACNI=0,RADTE=RACONST-RADTI,RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 ..F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  D  Q:RACNT>RAQUANT
 ...I ($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))#2) S RAY3=^(0) D
 ....;what is the status of the exam? cancelled exams (RAESTAT=0) are ignored...
 ....S RAESTAT=$P($G(^RA(72,+$P(RAY3,U,3),0)),U,3) Q:RAESTAT=0
 ....S RARPT=+$P(RAY3,U,17) Q:'RARPT  S RARPT(0)=$G(^RARPT(RARPT,0))
 ....I $P(RARPT(0),U,5)="V" S RACNT=RACNT+1 Q:RACNT>RAQUANT  D
 .....D INIT^RAHL23QU,SENDMSG
 .....K RAI,RAY,RAZCPT,RAZDAYCS,RAZPIMG,RAZPRC
 .....Q
 ....Q
 ...Q
 ..Q
 .;I 'RACNT S RAERR="No results are available for this patient" D NAK
 .Q
 E  D  ;lookup by accession
 .N RACN,RACNI,RACONST,RADFN,RADTE,RAINDX,RARPT,RAX,RAY2,RAY3
 .;the accession number may be in two formats:
 .;station # prefix-mm/dd/yy-case # -OR- mm/dd/yy-case #
 .;the format identifies the cross-referece we need to look up on
 .S RAX=$L(RAQDEPT,"-"),RACONST=9999999.9999
 .;if RAX=2 the index is "ADC"; if RAX=3 the index is "ADC1"
 .;if RAX is any other value that set RAERR & QUIT
 .I RAX'=2,(RAX'=3) S RAERR="Invalid Accession Number format" Q
 .;
 .;define the core variables: RADFN, RADTI, & RACNI...
 .S RAINDX=$S(RAX=2:$NA(^RADPT("ADC")),1:$NA(^RADPT("ADC1")))
 .S RADFN=$O(@RAINDX@(RAQDEPT,0)),RADTI=$O(@RAINDX@(RAQDEPT,RADFN,0))
 .S RACNI=$O(@RAINDX@(RAQDEPT,RADFN,RADTI,0))
 .S:RADFN'>0 RAERR="Invalid Accession Number - RADFN" Q:$D(RAERR)#2
 .S:RADTI'>0 RAERR="Invalid Accession Number - RADTI" Q:$D(RAERR)#2
 .S:RACNI'>0 RAERR="Invalid Accession Number - RACNI" Q:$D(RAERR)#2
 .;
 .;build the zero nodes of 70.02 & 70.03
 .S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)),RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .;get the report pointer...
 .S RARPT=$P(RAY3,U,17)
 .I RARPT="" S RAERR="No report on file for this accession." Q
 .S RARPT(0)=$G(^RARPT(RARPT,0))
 .I RARPT(0)="" S RAERR="Corrupted record #: "_RARPT_" in RAD/NUC MED REPORTS file." Q
 .I $P(RARPT(0),U,5)'="V" S RAERR="Accession: "_RAQDEPT_" is linked to a non-verified report" Q
 .S RADTE=$P(RARPT(0),U,3),RACN=$P(RARPT(0),U,4)
 .I $P(RARPT(0),U,2)'=RADFN S RAERR="Patient DFN mismatch" Q
 .I (RACONST-RADTI)'=RADTE S RAERR="Exam Date/Time mismatch" Q
 .I $P(RAY3,U)'=RACN S RAERR="Case Number mismatch" Q
 .;
 .S RACNT=RACNT+1 ;will be a max of 1
 .D INIT^RAHL23QU D SENDMSG
 .K RAZCPT,RAZDAYCS,RAZPIMG,RAZPRC
 .Q
 D XIT
 Q
 ;
ERR(RATXT) ;inform the radiology users via an email message
 ;that the query was negatively acknowledged.
 ;Input: RATXT=error text as it is displayed to the user
 N XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S XMY(DUZ)="",XMY("G.RAD HL7 MESSAGES")="",XMDUZ=.5
 S XMSUB="VistA Radiology HL7 query alert error",XMTEXT="RATXT("
 S RATXT($O(RATXT($C(32)),-1)+1)="MESSAGE CONTROL ID: "_RACNTRL
 D ^XMD Q
 ;
XIT ;exit the process. Fire off a negative acknowledgement if necessary.
 S:$D(ZTQUEUED)#2 ZTREQ="@"
 Q
 ;
NAK ;negatively acknowledge the QRY/R02 client side query
 ;the query is NAK'ed if the variable RAERR is defined.
 ;
 ;first alert the radiology users that a messages was NAK'ed
 S RAERR(1)=RAERR D ERR(.RAERR) K RAERR(1)
 ;then continue on to build & broadcast the NAK'ed
 ;
SENDMSG ;broadcast the HL7 message. The message/event type is: ORF/R04
 ;Define the message parameters COUNTRY, FIELD SEPARATOR, & ENCODING CHARACTERS
 ;are set to their default values for self documentation.
 N HLECH,HLFS,HLQ,RAERROR,RAPARAM,RATXT,RAWHO,RAX
 S RAPARAM("COUNTRY")="USA",(HLFS,RAPARAM("FIELD SEPARATOR"))="|",HLQ=""
 S (HLECH,RAPARAM("ENCODING CHARACTERS"))="^~\&",RAPARAM("VERSION")=2.3
 S RAPARAM("MESSAGE TYPE")="ORF",RAPARAM("EVENT")="R04"
 ;
 ;Create the new message (builds the MSH segment)
 I '$$NEWMSG^HLOAPI(.RAPARAM,.HLMSTATE,.RAERROR) D  Q
 .S RATXT(1)="An error occurred in the process of building a "_$S($D(RAERR)#2:"negative",1:"positive")
 .S RATXT(2)="acknowledgment to NTP's query." D ERR(.RATXT)
 .Q
 ;if RAX=0 then the MSH segment building function failed.
 ;
 ;build the MSA segment
 S RAX=$$MSA^RAHL23Q1($G(RAERR))
 D:'RAX SEGERR("MSA")
 ;
 ;build the QRD segment
 S RAX=$$BLDQRD^RAHL23Q1() D:'RAX SEGERR("QRD") Q:'RAX
 ;
 ;build the QRF segment
 S RAX=$$BLDQRF^RAHL23Q1() D:'RAX SEGERR("QRF") Q:'RAX
 ;
 ;if the ORF/R04 message is a positive acknowledgement then build the
 ;PID, OBR, & multiple OBX segments. The DSC segment may be created
 ;iff RAQUANT>1
 I '($D(RAERR)#2) D  Q:'RAX
 .S RAX=$$PID^RAHL23Q1() D:'RAX SEGERR("PID") Q:'RAX
 .S RAX=$$OBR^RAHL23Q1() D:'RAX SEGERR("OBR") Q:'RAX
 .S RAX=$$OBXPRC^RAHL23Q1() D:'RAX SEGERR("OBX (Procedure)") Q:'RAX
 .S RAX=$$OBXIMP^RAHL23Q1() D:'RAX SEGERR("OBX (Impression Text)") Q:'RAX
 .S RAX=$$OBXDIA^RAHL23Q1() D:'RAX SEGERR("OBX (Primary Dx. Codes)") Q:'RAX
 .;
 .I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0)) D  Q:'RAX
 ..S RAX=$$OBXDIA2^RAHL23Q1() D:'RAX SEGERR("OBX (Secondary Dx. Codes)") Q
 .;
 .S RAX=$$OBXRPT^RAHL23Q1() D:'RAX SEGERR("OBX (Report Text)") Q:'RAX
 .S RAX=$$OBXPMOD^RAHL23Q1() D:'RAX SEGERR("OBX (Procedure Modifiers)") Q:'RAX
 .S RAX=$$OBXCMOD^RAHL23Q1() D:'RAX SEGERR("OBX (CPT Modifiers)") Q:'RAX
 .S RAX=$$OBXTCM^RAHL23Q1() D:'RAX SEGERR("OBX (Tech. Comments)") Q:'RAX
 .I RAQUANT>1 S RAX=$$DSC^RAHL23Q1() D:'RAX SEGERR("DSC")
 .Q
 ;Define sending and receiving application parameters
 S RAPARAM("SENDING APPLICATION")="RA-NTP-QUERY",RAPARAM("QUEUE")="RA-NTP-ORF_R04"
 S RAPARAM("ACCEPT ACK TYPE")="AL",RAPARAM("APP ACK TYPE")="NE"
 S RAPARAM("ACCEPT ACK RESPONSE")="ACCEPT^RAHL23QU"
 ;
 ;name the outbound queue that is responsible for our query replies
 S RAWHO("RECEIVING APPLICATION")="RA-NTP-RSP",RAWHO("FACILITY LINK NAME")="RA-SCIMAGE"
 ;Send the message
 S RAX=$$SENDONE^HLOAPI1(.HLMSTATE,.RAPARAM,.RAWHO,.RAERROR)
 I $D(RAERROR)#2 D
 .S RATXT(1)="An error was encountered when broadcasting/sending the ORF/R04"
 .S RATXT(2)="HL7 message." D ERR(.RATXT)
 .Q
 Q
 ;
SEGERR(X) ; build the error dialog used whenever the building of a HL7
 ;segment fails.
 ;Input: X=the specific segment that failed: MSA, QRD, QRF, PID, OBR,
 ;OBX, or DSC. 
 N RATXT S RATXT(1)="An error was encountered when building the ORF/R04 HL7 message."
 S RATXT(2)="HL7 segment: "_X D ERR(.RATXT)
 Q
 ;
