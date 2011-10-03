RAHL23Q1 ;HINES OIFO/GJC process query message/event type (QRY/R02)
 ;;5.0;Radiology/Nuclear Medicine;**78**;Mar 16, 1998;Build 5
 ;
 ;Integration Agreements
 ;----------------------
 ;$$GET1^DIQ(), $$HLDATE^HLFNC(10106), $$ADDSEG^HLOAPI(4716), SET^HLOAPI(4716)
 ;$$EN^VAFHLPID(263), $$FMTHL7^XLFDT(10103), STDNAME^XLFNAME(3065)
 ;WARD LOCATION file (10039), HOSPITAL LOCATION file (10040), INSTITUTION FILE (10090)
 ;
 ;Routine: SET^HLOAPI(SEG,VALUE,FIELD,COMP,SUBCOMP,REP)
 ;Description: This API is used to set a value into a segment that is in the
 ;process of being built.
 ;Input Definition
 ;-------------------------------------------------------------------------------------
 ;SEG (Required) The array where the segment is being built
 ;VALUE (Required) The individual value to be set into the segment
 ;FIELD (Optional) The field number (defaults to 0)
 ;COMP (Optional) The component number(defaults to 1)
 ;SUBCOMP (Optional) The subcomponent number that (defaults to 1)
 ;REP (Optional) The occurrence number (defaults to 1)
 ;
 ;Note: FIELD=0 is used to denote the segment type.
 ;      $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG) return 1 if successful, 0 on an error.
 ;
PID() ;build a HL7 specific PID segment
 N C,DFN,RAB,RAC,RAFLDATA,RAFLDS,RALRAX,RASEG,RAX
 D SET^HLOAPI(.RASEG,"PID",0) S DFN=RADFN,RAFLDS="2,3,5,7,8,19"
 ;RAX is the HL7 segment; RAFLDS defines which fields of that segment are requested
 S RAX=$$EN^VAFHLPID(DFN,RAFLDS)
 ;RACS, RAFS, RASCS, & RARS are all defined ahead of time...
 ;strip off the "PID|" (first four characters)
 S RAX=$E(RAX,5,$L(RAX)),RALRAX=$L(RAX,RAFS)
 ;RALRAX = # of fields of the parent HL7 segment
 ;RAB = the specific instance of a field: first, second, third, etc...
 F RAB=1:1:RALRAX S RAFLDATA=$P(RAX,RAFS,RAB) D:RAFLDATA'=""
 .;RAC = the specific instance of a repeat: first, second, third, etc... (usually one)
 .F RAC=1:1:$L(RAFLDATA,RARS) D PARSE($P(RAFLDATA,RARS,RAC))
 .Q
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
OBR() ;build a HL7 V2.3 OBR segment
 N RASEG,RAX,RAX1,RAX2 D SET^HLOAPI(.RASEG,"OBR",0)
 ;OBR-2 = inv. date/time exam-internal exam record #
 ;OBR-3 (accession) = mm/dd/yy-case #
 S RAX=RADTI_"-"_RACNI
 D SET^HLOAPI(.RASEG,RAX,2),SET^HLOAPI(.RASEG,RAZDAYCS,3)
 ;OBR-4 Universal Service ID (six components)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P(RAZCPT(0),U)),4,1)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P(RAZCPT(0),U,2)),4,2)
 D SET^HLOAPI(.RASEG,"C4",4,3),SET^HLOAPI(.RASEG,RAZPRC,4,4)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P(RAZPRC(0),U)),4,5),SET^HLOAPI(.RASEG,"99RAP",4,6)
 ;
 ;OBR-7 Observ. Date/Time
 D SET^HLOAPI(.RASEG,$$HLDATE^HLFNC(RADTE),7)
 ;
 ;OBR-16 ordering provider (components one & two) from Req. Physician (70.03;14)
 K RAX S RAX=$$GET1^DIQ(200,+$P(RAY3,"^",14),.01)
 D:$L(RAX) STDNAME^XLFNAME(.RAX,"C")
 D SET^HLOAPI(.RASEG,+$P(RAY3,U,14),16,1)
 D SET^HLOAPI(.RASEG,$G(RAX("FAMILY")),16,2)
 D SET^HLOAPI(.RASEG,$G(RAX("GIVEN")),16,3)
 D SET^HLOAPI(.RASEG,$G(RAX("MIDDLE")),16,4)
 ;
 ;OBR-18 Placer field 1 - ward(70.03;6)/hospital location(70.03;8)
 K RAX S RAX=$$ESCAPE^RAHLRU($S($D(^DIC(42,+$P(RAY3,U,6),0)):$P(^(0),U),$D(^SC(+$P(RAY3,U,8),0)):$P(^(0),U),1:"Unknown"))
 D SET^HLOAPI(.RASEG,RAX,18)
 ;
 ;OBR-20 (components 1-4) formated as follows:
 ;Comp 1: ptr to file 79.1, Comp 2: HOSPITAL LOCATION NAME (#44; .01), Comp 3: ptr to file 79
 ;Comp 4: INSTITUTION NAME (#4; .01)
 K RAX S RAX=+$G(^RA(79.1,+$P(RAY2,U,4),0)) ;attribute is a pointer to the HOSPITAL LOCATION file
 D SET^HLOAPI(.RASEG,$P(RAY2,U,4),20,1)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P($G(^SC(RAX,0)),U)),20,2,2)
 D SET^HLOAPI(.RASEG,$P(RAY2,U,3),20,3)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($$GET1^DIQ(4,+$P(RAY2,U,3),.01)),20,4)
 ;
 ;OBR-22 Results Rpt/Status Chng - Verified Date (74;7)
 D SET^HLOAPI(.RASEG,$$HLDATE^HLFNC($P(RARPT(0),U,7)),22)
 ;
 ;OBR-25 Report Status - Report Status (74;5)
 K RAX S RAX=$S($P(RARPT(0),U,5)="V":"F",1:"R")
 D SET^HLOAPI(.RASEG,RAX,25)
 ;
 ;OBR-32 Principal Result Interpreter components one & two
 ;Verifying Physician (74;9)
 I $P(RARPT(0),U,9) D
 .K RAX S RAX=$$GET1^DIQ(200,$P(RARPT(0),U,9),.01) Q:RAX=""
 .D STDNAME^XLFNAME(.RAX,"C")
 .D SET^HLOAPI(.RASEG,$P(RARPT(0),U,9),32,1)
 .D SET^HLOAPI(.RASEG,$G(RAX("FAMILY")),32,2)
 .D SET^HLOAPI(.RASEG,$G(RAX("GIVEN")),32,3)
 .D SET^HLOAPI(.RASEG,$G(RAX("MIDDLE")),32,4)
 .Q
 ;
 ;OBR-33 Assistant Result Interpreter either Staff (70.03;15) or Resident (70.03;12)
 I $P(RAY3,"^",15) D
 .K RAX S RAX=$$GET1^DIQ(200,$P(RAY3,"^",15),.01) Q:RAX=""
 .D STDNAME^XLFNAME(.RAX,"C")
 .D SET^HLOAPI(.RASEG,$P(RAY3,"^",15),33,1)
 .D SET^HLOAPI(.RASEG,$G(RAX("FAMILY")),33,2)
 .D SET^HLOAPI(.RASEG,$G(RAX("GIVEN")),33,3)
 .D SET^HLOAPI(.RASEG,$G(RAX("MIDDLE")),33,4)
 .Q
 E  I $P(RAY3,"^",12) D
 .K RAX S RAX=$$GET1^DIQ(200,$P(RAY3,"^",12),.01) Q:RAX=""
 .D STDNAME^XLFNAME(.RAX,"C")
 .D SET^HLOAPI(.RASEG,$P(RAY3,"^",12),33,1)
 .D SET^HLOAPI(.RASEG,$G(RAX("FAMILY")),33,2)
 .D SET^HLOAPI(.RASEG,$G(RAX("GIVEN")),33,3)
 .D SET^HLOAPI(.RASEG,$G(RAX("MIDDLE")),33,4)
 .Q
 ;
 ;OBR-34 Technician (Technologist - (70.03;175) multiple (get first record only)
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0)) D
 .N RAX1,RAX2 S RAX1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0)) Q:'RAX1
 .S RAX2=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",RAX1,0)),U) Q:'RAX2
 .K RAX S RAX=$$GET1^DIQ(200,RAX2,.01) Q:RAX=""
 .D STDNAME^XLFNAME(.RAX,"C")
 .D SET^HLOAPI(.RASEG,RAX2,34,1)
 .D SET^HLOAPI(.RASEG,$G(RAX("FAMILY")),34,2)
 .D SET^HLOAPI(.RASEG,$G(RAX("GIVEN")),34,3)
 .D SET^HLOAPI(.RASEG,$G(RAX("MIDDLE")),34,4)
 .Q
 ;
 ;OBR-35 Transcriptionist - Transcriptionist (74;11) 
 S RAX1=$G(^RARPT(RARPT,"T")) D:$P(RAX1,U)
 .K RAX S RAX=$$GET1^DIQ(200,$P(RAX1,U),.01) Q:RAX=""
 .D SET^HLOAPI(.RASEG,$P(RAX1,U),35,1)
 .D SET^HLOAPI(.RASEG,$G(RAX("FAMILY")),35,2)
 .D SET^HLOAPI(.RASEG,$G(RAX("GIVEN")),35,3)
 .D SET^HLOAPI(.RASEG,$G(RAX("MIDDLE")),35,4)
 .Q
 ;
 ;OBR-36 Scheduled Date/Time RAZDTE=(9999999.9999-RADTI) Exam Date (70.02;.01 DINUM'ed)
 ;HL7 TS datatype w/offset Ex: 200807101437-0500
 D SET^HLOAPI(.RASEG,$$FMTHL7^XLFDT(RADTE),36)
 ;
 ;add the OBR segment to our HL7 message
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
OBXDIA() ;Compile 'OBX' Segment for Diagnostic Code
 N RAX S RAX=$P($G(^RA(78.3,+$P(RAY3,U,13),0)),U) Q:RAX="" 1
 D SET^HLOAPI(.RASEG,"OBX",0),SET^HLOAPI(.RASEG,1,1) ;set id
 D SET^HLOAPI(.RASEG,"CE",2,1),SET^HLOAPI(.RASEG,"D",3,1)
 D SET^HLOAPI(.RASEG,"DIAGNOSTIC CODE",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU(RAX),5,1)
 D SET^HLOAPI(.RASEG,"F",11,1)
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
OBXDIA2() ;Compile 'OBX' segment for secondary Diagnostic Code
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0)) 1
 N RAERROR,RACNT,RAX,RAY S (RACNT,RAY)=0
 F  S RAY=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RAY)) Q:'RAY  D  Q:'RAERROR
 .S RAY(0)=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RAY,0))
 .S RAX=$P($G(^RA(78.3,+RAY(0),0)),U) Q:RAX=""
 .D SET^HLOAPI(.RASEG,"OBX",0) S RACNT=RACNT+1 D SET^HLOAPI(.RASEG,RACNT,1)
 .D SET^HLOAPI(.RASEG,"CE",2,1),SET^HLOAPI(.RASEG,"D",3,1)
 .D SET^HLOAPI(.RASEG,"DIAGNOSTIC CODE",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 .D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU(RAX),5,1)
 .D SET^HLOAPI(.RASEG,"F",11,1)
 .S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 .Q
 Q RAERROR
 ;
OBXIMP() ;Compile 'OBX' segment for Impression
 N RAERROR D SET^HLOAPI(.RASEG,"OBX",0)
 I '$O(^RARPT(RARPT,"I",0)) D  ;no impression text
 .D SET^HLOAPI(.RASEG,1,1) ;set id
 .D SET^HLOAPI(.RASEG,"TX",2,1),SET^HLOAPI(.RASEG,"I",3,1)
 .D SET^HLOAPI(.RASEG,"IMPRESSION",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 .D SET^HLOAPI(.RASEG,"None Entered",5,1)
 .D SET^HLOAPI(.RASEG,"F",11,1)
 .S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 .Q
 E  D
 .N RACNT,RAI,RAX S (RACNT,RAI)=0
 .F  S RAI=$O(^RARPT(RARPT,"I",RAI)) Q:'RAI  D  Q:'RAERROR
 ..S RAX=$G(^RARPT(RARPT,"I",RAI,0)) D SET^HLOAPI(.RASEG,"OBX",0)
 ..S RACNT=RACNT+1 D SET^HLOAPI(.RASEG,RACNT,1)
 ..D SET^HLOAPI(.RASEG,"TX",2,1),SET^HLOAPI(.RASEG,"I",3,1)
 ..D SET^HLOAPI(.RASEG,"IMPRESSION",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 ..D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU(RAX),5,1)
 ..D SET^HLOAPI(.RASEG,"F",11,1)
 ..S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ..Q
 .Q
 Q RAERROR
 ;
OBXPMOD() ;Compile 'OBX' segment for procedure modifiers
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",0)) 1
 N RAERROR,RACNT,RAI,RAX,RAY
 D SET^HLOAPI(.RASEG,"OBX",0) S (RACNT,RAI)=0
 F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",RAI)) Q:'RAI  D  Q:'RAERROR
 .S RAY=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",RAI,0)),U)
 .S RAX=$P($G(^RAMIS(71.2,RAY,0)),U) Q:RAX=""  D SET^HLOAPI(.RASEG,"OBX",0)
 .S RACNT=RACNT+1 D SET^HLOAPI(.RASEG,RACNT,1)
 .D SET^HLOAPI(.RASEG,"TX",2,1),SET^HLOAPI(.RASEG,"M",3,1)
 .D SET^HLOAPI(.RASEG,"MODIFIERS",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 .D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU(RAX),5,1)
 .D SET^HLOAPI(.RASEG,"F",11,1)
 .S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 .Q
 Q RAERROR
 ;
OBXCMOD() ;Compile 'OBX' segment for CPT Modifiers
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",0)) 1
 N RAERROR,RACNT,RAI,RAX,RAY D SET^HLOAPI(.RASEG,"OBX",0) S (RACNT,RAI)=0
 F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RAI)) Q:'RAI  D  Q:'RAERROR
 .S RAY=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RAI,0)),U)
 .S RAX=$$BASICMOD^RACPTMSC(RAY,DT) Q:RAX=""  D SET^HLOAPI(.RASEG,"OBX",0)
 .S RACNT=RACNT+1 D SET^HLOAPI(.RASEG,RACNT,1)
 .D SET^HLOAPI(.RASEG,"CE",2,1),SET^HLOAPI(.RASEG,"C4",3,1)
 .D SET^HLOAPI(.RASEG,"CPT MODIFIERS",3,2),SET^HLOAPI(.RASEG,"C4",3,3)
 .D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P(RAX,U,2)),5,1)
 .D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P(RAX,U,3)),5,2)
 .D SET^HLOAPI(.RASEG,"C4",5,3)
 .D SET^HLOAPI(.RASEG,"F",11,1)
 .S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 .Q
 Q RAERROR
 ;
OBXPRC() ;Compile 'OBX' segment for procedure
 D SET^HLOAPI(.RASEG,"OBX",0),SET^HLOAPI(.RASEG,1,1) ;set id
 D SET^HLOAPI(.RASEG,"CE",2,1),SET^HLOAPI(.RASEG,"P",3,1)
 D SET^HLOAPI(.RASEG,"PROCEDURE",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 D SET^HLOAPI(.RASEG,$P(RAY3,U,2),5,1)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU($P(RAZPRC(0),U)),5,2)
 D SET^HLOAPI(.RASEG,"L",5,3)
 D SET^HLOAPI(.RASEG,"F",11,1)
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
OBXTCM() ;Compile 'OBX' segment for tech comments
 ;$$GETTCOM^RAUTL11 returns the last TECH COMMENT associated with the exam
 N RAX S RAX=$$GETTCOM^RAUTL11(RADFN,RADTI,RACNI) Q:RAX="" 1
 D SET^HLOAPI(.RASEG,"OBX",0),SET^HLOAPI(.RASEG,1,1) ;set id
 D SET^HLOAPI(.RASEG,"TX",2,1),SET^HLOAPI(.RASEG,"TCM",3,1)
 D SET^HLOAPI(.RASEG,"TECH COMMENT",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU(RAX),5,1)
 D SET^HLOAPI(.RASEG,"F",11,1)
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
OBXRPT() ;Compile 'OBX' Segment for Radiology Report Text
 ;If there is no REPORT TEXT do... 
 N RAERROR D SET^HLOAPI(.RASEG,"OBX",0)
 I '$O(^RARPT(RARPT,"R",0)) D
 .D SET^HLOAPI(.RASEG,1,1) ;set id
 .D SET^HLOAPI(.RASEG,"TX",2,1),SET^HLOAPI(.RASEG,"R",3,1)
 .D SET^HLOAPI(.RASEG,"REPORT",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 .D SET^HLOAPI(.RASEG,"None Entered",5,1)
 .D SET^HLOAPI(.RASEG,"F",11,1)
 .S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 .Q
 ;and if there is REPORT TEXT do...
 E  D
 .N RACNT,RAI,RAX S (RACNT,RAI)=0
 .F  S RAI=$O(^RARPT(RARPT,"R",RAI)) Q:'RAI  D  Q:'RAERROR
 ..S RAX=$G(^RARPT(RARPT,"R",RAI,0)) D SET^HLOAPI(.RASEG,"OBX",0)
 ..S RACNT=RACNT+1 D SET^HLOAPI(.RASEG,RACNT,1)
 ..D SET^HLOAPI(.RASEG,"TX",2,1),SET^HLOAPI(.RASEG,"R",3,1)
 ..D SET^HLOAPI(.RASEG,"REPORT",3,2),SET^HLOAPI(.RASEG,"L",3,3)
 ..D SET^HLOAPI(.RASEG,$$ESCAPE^RAHLRU(RAX),5,1)
 ..D SET^HLOAPI(.RASEG,"F",11,1)
 ..S RAERROR=$$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ..Q
 .Q
 Q RAERROR
 ;
MSA(RAERR) ;generate the MSA segment
 N RACKCODE,RASEG S RACKCODE=$S($L(RAERR):"AE",1:"AA")
 D SET^HLOAPI(.RASEG,"MSA",0),SET^HLOAPI(.RASEG,RACKCODE,1)
 D SET^HLOAPI(.RASEG,RACNTRL,2),SET^HLOAPI(.RASEG,$G(RAERR),3)
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
DSC() ;build the continuation pointer segment. The format is the message ID of the query
 ;message concatenated (by a dash) to the record number count value (RACNT)
 N RASEG,RAX S RAX=RACNTRL_"-"_RACNT
 D SET^HLOAPI(.RASEG,"DSC",0),SET^HLOAPI(.RASEG,RAX,1)
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
BLDQRD() ;build the QRD segment
 N RAI,RAK,RASEG,RAX S RAI=0 D SET^HLOAPI(.RASEG,"QRD",0)
 S RAX=$E(RAQWHO,1,3)_"-"_$E(RAQWHO,4,5)_"-"_$E(RAQWHO,6,9) ;put back the delimiters
 F RAK="RAQDT","RAQFC","RAQPRI","RAQID","RAQDRT","RAQDRDT","RAQUANT","RAX","RAQWHAT","RAQDEPT" D
 .S RAI=RAI+1 Q:'($D(@RAK)#2)
 .I RAI=7 D
 ..D SET^HLOAPI(.RASEG,RAQUANT,RAI,1),SET^HLOAPI(.RASEG,RAQUNIT,RAI,2)
 ..Q
 .E  D SET^HLOAPI(.RASEG,@RAK,RAI)
 .Q
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
BLDQRF() ;build the QRF segment
 N RAI,RAK,RASEG S RAI=0 D SET^HLOAPI(.RASEG,"QRF",0)
 F RAK="RAQWHERE","RAQSTART","RAQEND" D
 .S RAI=RAI+1 Q:'($D(@RAK)#2)
 .D SET^HLOAPI(.RASEG,@RAK,RAI)
 .Q
 Q $$ADDSEG^HLOAPI(.HLMSTATE,.RASEG)
 ;
PARSE(RAFLDATA) ;parse the string down to the component/sub-component
 N RACOMP,RAD,RAE,RASCOMP
 ;RAB & RAC passed globally
 ;RAFLDATA is the field value (may be part of a repetition passed from PID)
 ;RACOMP = is the specific component of a specific HL7 field
 ;RAD = the specific instance of a component: first, second, third, etc...
 F RAD=1:1:$L(RAFLDATA,RACS) S RACOMP=$P(RAFLDATA,RACS,RAD) D:RACOMP'=""
 .;RAE = the specific instance of a sub-component: first, second, third, etc...
 .;RASCOMP = the specific sub-component within a component
 .F RAE=1:1:$L(RACOMP,RASCS) S RASCOMP=$P(RACOMP,RASCS,RAE) D:RASCOMP'=""
 ..;now we have the # of: repetitions, components, & sub-components
 ..;call SET^HLOAPI. paramters: SET(SEG,VALUE,FIELD,COMP,SUBCOMP,REP)
 ..D SET^HLOAPI(.RASEG,RASCOMP,RAB,RAD,RAE,RAC)
 ..Q
 .Q
 Q
 ;
