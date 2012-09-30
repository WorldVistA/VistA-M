RAHL24Q ;HINES OIFO/GJC process & respond to query message ; 22 Apr 2011  09:00 AM
 ;;5.0;Radiology/Nuclear Medicine;**107**;Mar 16, 1998;Build 2
 ;
 ;ROUTINE            IA #      USAGE          CUSTODIAN     
 ;     TAG
 ;----------------------------------------------------------
 ;%ZTLOAD            10063     Supported      VA Kernel
 ;     %ZTLOAD
 ;DIC                2051      Supported      VA FileMan
 ;     $$FIND1()
 ;HLOPRS             4718      Supported      VistA HL7
 ;     $$STARTMSG()
 ;     $$NEXTSEG()
 ;     $$GET()
 ;XLFDT              10103     Supported      VA Kernel
 ;     $$FMADD()
 ;     $$HL7TFM()
 ;     $$NOW()
 ;XMD                10070     Supported      VA MailMan
 ;     XMD 
 ;
SRV ;VistA server: receive/process the inbound v2.4 query
 S:$G(U)'="^" U="^" ;under development
 N HL,HLA,HLSTART
 ;
DISMSH ; disassemble the MSH segment
 I '$$STARTMSG^HLOPRS(.HLMSTATE,HLMSGIEN,.RAMSH) D  Q
 .K RATXT S RATXT(1)="$$STARTMSG^HLOPRS failed: Contact the national Rad/Nuc Med"
 .S RATXT(2)="development team."
 .D ERR Q
 ;
 ;RAMSH array elements defined
 ;----------------------------
 ;RAMSH("SEGMENT TYPE")="MSH"                   RAMSH("DT/TM OF MESSAGE")
 ;RAMSH("FIELD SEPARATOR")                      RAMSH("SECURITY")
 ;RAMSH("COMPONENT SEPARATOR")                  RAMSH("MESSAGE TYPE")
 ;RAMSH("SUBCOMPONENT SEPARATOR")               RAMSH("EVENT")
 ;RAMSH("REPETITION SEPARATOR")                 RAMSH("MESSAGE STRUCTURE")
 ;RAMSH("ESCAPE CHARACTER")                     RAMSH("MESSAGE CONTROL ID")
 ;RAMSH("SENDING APPLICATION")                  RAMSH("PROCESSING ID")
 ;RAMSH("SENDING FACILITY",1) 1st component     RAMSH("PROCESSING MODE")
 ;RAMSH("SENDING FACILITY",2) 2nd component     RAMSH("VERSION")
 ;RAMSH("SENDING FACILITY",3) 3rd component     RAMSH("CONTINUATION POINTER")
 ;RAMSH("RECEIVING APPLICATION")                RAMSH("ACCEPT ACK TYPE")
 ;RAMSH("RECEIVING FACILITY",1) 1st component   RAMSH("APP ACK TYPE")
 ;RAMSH("RECEIVING FACILITY",2) 2nd component   RAMSH("COUNTRY")
 ;RAMSH("RECEIVING FACILITY",3) 3rd component
 ;
 S RAMSGCNTID=RAMSH("MESSAGE CONTROL ID")
 ;
 ;Note: The HLO server will use the message type, event type, and version
 ;to look up an entry in the HLO Application Registry. As long as HLO can
 ;find an entry that applies, it will pass the message to the application
 ;and return CA.
 ;
 ;represent encoding characters and the field separator as local variables
 S RAECH=RAMSH("ENCODING CHARACTERS")
 S RAFS=RAMSH("FIELD SEPARATOR")
 S RACS=RAMSH("COMPONENT SEPARATOR")
 S RARS=RAMSH("REPETITION SEPARATOR")
 S RAESC=RAMSH("ESCAPE CHARACTER")
 S RASCS=RAMSH("SUBCOMPONENT SEPARATOR")
 ;
GETSEG ; disassemble the rest (segments after the MSH) of the query message
 F  Q:'$$NEXTSEG^HLOPRS(.HLMSTATE,.RASEG)  D
 .;get the fields and set the proper local variables...
 .I $$GET^HLOPRS(.RASEG,RAFS,RACS,RASCS,RARS)
 .;the data is in this format: SEG(FIELD #,REP,COMP,SUBCOMP)
 .D @RASEG(0)
 .Q
 ;
TASK ;task off the response
 S ZTDESC="RA HL7 2.4 QBP/RSP - return specific radiology results to NTP"
 S (ZTSAVE("RA*"),ZTSAVE("RAMSH("))=""
 ;ZTSAVE("HLMSTATE("))=""
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTIO="",ZTRTN="START^RAHL24U"
 D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 ;
EXIT ;the end... kill variables and exit.
 K HL,HLCS,HLECH,HLFS,HLQ,HLREP,HLSCS,RABEG,RABEGHL7,RACNI,RACNT
 K RACONSTANT,RACS,RADATA,RADFN,RADTE,RADTI,RAECH,RAEND,RAENDHL7
 K RAERR,RAERROR,RAESC,RAFS,RAMSGCNTID,RAMSGQRYNAME,RAMSGPRIOR
 K RAMSG,RAMSH,RAOIFN,RAPSET,RAQCPT,RAQDAYCS,RAQPIMG,RAQPRC
 K RARPT,RARS,RASCS,RASEG,RAX,RAY2,RAY3
 Q
 ;
 ;-----------------------------------------------------------------------------\
FAILURE ;transmission of the message fails: message not sent, commit to message
 ;is missing.
 K RATXT S RATXT(1)="$$SENDONE^HLOAPI1: message issue ("_$G(HLMSGIEN,-1)_")."
 S RATXT(2)="Contact the national Rad/Nuc Med development team."
 ;fall through...
ERR ;come here to generate a VistA MailMan email when there is a problem
 ;Input: RATXT=error text (array) as it is displayed to the user
 ;       RAMSGCNTID set in SRV^RAHL24Q
 N XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S XMY(DUZ)="",XMY("G.RAD HL7 MESSAGES")="",XMDUZ=.5
 S XMSUB="VistA Radiology HL7 query alert error",XMTEXT="RATXT("
 S RATXT($O(RATXT($C(32)),-1)+1)="Message Control ID: "_$G(RAMSGCNTID,-1)
 D ^XMD K RATXT
 Q
 ;
QPD ; disassemble the QPD segment
 ;output: see below...
 ;
 ;Field    HL7 Field Name       VistA local variable assigned its value
 ;-----    --------------       ---------------------------------------
 ; 1       Message Query Name   RAMSGQRYNAME
 ; 2       Query Tag            RAQRYTAG
 ; 3       User Parameters      RAMRN        (patient identifier)
 ;                              RABEG("HL7") (begin date/time; HL7 format)
 ;                              RAEND("HL7") (end date/time; HL7 format)
 S RAMSGQRYNAME=RASEG(1,1,1,1)_RACS_RASEG(1,1,2,1)
 S RAQRYTAG=RASEG(2,1,1,1)
 S RAMRN=RASEG(3,1,3,1)
 S RABEGHL7=RASEG(3,3,3,1),RAENDHL7=RASEG(3,4,3,1)
 ;convert begin & end date/times from HL7 format to internal FileMan format
 S RABEG("FM")=$$HL7TFM^XLFDT(RABEGHL7,"L")
 S RAEND("FM")=$$HL7TFM^XLFDT(RAENDHL7,"L")
 S RADTE=$$FMADD^XLFDT(RABEG("FM"),0,0,0,-1) ;lower limit of our timeframe
 S RADTE=$E(RADTE,1,12)
 S RAEND=((RAEND("FM"))\1)+.2359 ;upper limit of our timeframe
 ;lookup the patient
 S RADFN=$$MRNTDFN(RAMRN)
 K RABEG("FM"),RAEND("FM")
 Q
 ;
RCP ; disassemble the RCP segment
 ;output: sets RAERR in case of error (checked in GETSEG)
 ;
 ;Field    HL7 Field Name       VistA local variable assigned its value
 ;-----    --------------       ---------------------------------------
 ; 1       Query Priority       RAMSGPRIOR   (message priority)
 ; 2       Quantity limited     RAQUANTITY   (max number of records
 ;         request                            to return)
 S RAMSGPRIOR=RASEG(1,1,1,1)
 S RAQUANTITY=RASEG(2,1,1,1)
 Q
 ;
MRNTDFN(RAMRN) ;This function will convert the patient's MRN, the SSN
 ; with or without hyphens, into their DFN
 ;
 ; input: patient MRN
 ;output: patient DFN if successful, 0 if unsuccessful or null if error
 ;  Note: on an error I'll return -1^error text instead of null
 ;
 N DFN S DFN=$$FIND1^DIC(2,,"X",$TR(RAMRN,"-",""),"SSN",,"RAERR")
 S:DFN="" DFN="-1"
 K DIERR,RAERR
 Q DFN
 ;
