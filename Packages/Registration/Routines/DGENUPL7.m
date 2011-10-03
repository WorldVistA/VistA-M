DGENUPL7 ;ISA/KWP/CKN/TMK,TDM - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ; 6/18/08 12:41pm
 ;;5.3;REGISTRATION;**232,367,397,417,379,431,513,628,673,653,742,688**;Aug 13,1993;Build 29
 ;Phase II split from DGENUPL
Z11(MSGIEN,MSGID,CURLINE,DFN,ERRCOUNT) ;
 ;Description:  This is used to process a single ORU~Z11 or ORF~Z11 msg. 
 ;Input:
 ;  MSGIEN - the internal entry number of the HL7 message in the
 ;      HL7 MESSAGE TEXT file (772)
 ;  MSGID -message control id of HL7 msg in the MSH segment
 ;  CURLINE - the subscript of the MSH segment of the current message (pass by reference)
 ;  DFN - identifies the patient, is the ien of a record in the PATIENT file.
 ;  ERRCOUNT - is a count of the number of messages in the batch that can not be processed (pass by reference)
 ;
 ;Output:
 ;  CURLINE - upon leaving the procedure this parameter should be set to the end of the current message. (pass by reference)
 ;  ERRCOUNT - set to count of messages that were not processed due to errors encountered  (pass by reference)
 ;
 N DGELG,DGENR,DGPAT,DGCDIS,DGOEIF,ERROR,ERRMSG,MSGS,DGELGSUB,DGENUPLD,DGCON
 N DGNEWVAL,DIV,SUB,OLDELG,OLDPAT,OLDDCDIS,OLDEIF,DGSEC,OLDSEC,DGNTR,DGMST,DGPHINC
 ;
 ;some process is killing these HL7 variables, so need to protect them
 S SUB=HLFS
 S DIV=HLECH
 N HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLECH,HLFS,HLNDAP,HLNDAP0,HLPID,HLQ,HLVER,HLERR,HLMTN,HLSDT
 S HLFS=SUB
 S HLECH=DIV
 S HLQ=""""""
 K DIV,SUB
 ;
 ;drops out of block on error
 D
 .Q:'$$PARSE^DGENUPL1(MSGIEN,MSGID,.CURLINE,.ERRCOUNT,.DGPAT,.DGELG,.DGENR,.DGCDIS,.DGOEIF,.DGSEC,.DGNTR,.DGMST)
 .D GETLOCKS^DGENUPL5(DFN)
 .;
 .;Used by cross-references to determine if an upload is in progress.
 .S DGENUPLD="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS"
 .;
 .;Update the PATIENT, ELIGIBILITY, CATASTROPHIC DISABILITY objects in memory
 .Q:'$$UOBJECTS^DGENUPL4(DFN,.DGPAT,.DGELG,.DGCDIS,.DGOEIF,MSGID,.ERRCOUNT,.MSGS,.OLDPAT,.OLDELG,.OLDCDIS,.OLDEIF)
 .S ERROR=0
 .;if the msg contains patient security, process it
 .I $D(DGSEC) D  Q:ERROR
 ..S DGSEC("DFN")=DFN
 ..S DGSEC("USER")=.5
 ..I DGSEC("LEVEL")'="" D
 ...I DGSEC("DATETIME")="" S DGSEC("DATETIME")=$$NOW^XLFDT ;DG*5.3*653 
 ..;
 ..; check consistency of patient security record
 ..I '$$CHECK^DGENSEC(.DGSEC,.ERRMSG) D  Q
 ...S ERROR=1
 ...D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),ERRMSG,.ERRCOUNT)
 ..;
 ..; upload patient security, consistency checks passed
 ..D SECUPLD^DGENUPL5(DFN,.DGSEC,.OLDSEC)
 .;
 .;if the msg has an enrollment process it
 .I DGENR("STATUS")!DGENR("APP") D  Q:ERROR
 ..;use $$PRIORITY to get the eligibility data used to compute priority
 ..I $$PRIORITY^DGENELA4(DFN,.DGELG,.DGELGSUB,DGENR("DATE"),DGENR("APP"))
 ..;
 ..;store the eligibility data in the enrollment record and other missing fields
 ..M DGENR("ELIG")=DGELGSUB
 ..S DGENR("DFN")=DFN
 ..S DGENR("PRIORREC")=""
 ..S DGENR("USER")=.5
 ..S DGENR("DATETIME")=$$NOW^XLFDT
 ..;
 ..;Allow null overwrites of Ineligible data (Ineligible Project):
 ..I $D(DGENR("DATE")),DGENR("DATE")="" S DGENR("DATE")="@"
 ..I $D(DGENR("FACREC")),DGENR("FACREC")="" S DGENR("FACREC")="@"
 ..;
 ..;check the consistency of the enrollment record
 ..I '$$CHECK^DGENA3(.DGENR,.DGPAT,.ERRMSG) D  Q
 ...S ERROR=1
 ...D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),ERRMSG,.ERRCOUNT)
 ..;
 ..; removed EGT consistency check with DG*5.3*628
 ..;Phase II EGT consistency checks (SRS 6.5.1.3)
 ..;Only do the EGT consistency checks for Rejected-Fiscal Year (11),Rejected-Mid Cycle (12),Rejected-Stop enrolling new apps (13),Rejected-Initil App by VAMC (14),Rejected below EGT threshold (22)
 ..;I "^11^12^13^14^22^"[("^"_DGENR("STATUS")_"^"),$$ABOVE^DGENEGT1(DGENR("DFN"),DGENR("PRIORITY"),DGENR("SUBGRP"),"","",1) D  Q
 ..;.S ERROR=1
 ..;.S ERRMSG="THE ENROLLMENT RECORD DID NOT PASS THE EGT CONSISTENCY CHECKS."
 ..;.D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),ERRMSG,.ERRCOUNT)
 ..;
 ..;Allow null overwrites for Ineligible vets (Ineligible Project):
 ..I $G(DGPAT("INELDATE"))'="" S (DGENR("PRIORITY"),DGENR("SUBGRP"))=""
 ..I DGENR("DATE")="@" S DGENR("DATE")=""
 ..I DGENR("FACREC")="@" S DGENR("FACREC")=""
 ..;
 ..D ENRUPLD^DGENUPL8(.DGENR,.DGPAT)
 .;
 .;Store the PATIENT, ELIGIBILITY, & CAT. DISB. objects
 .I $$STORE^DGENPTA1(.DGPAT,,1)
 .I $$STORE^DGENELA1(.DGELG,.DGPAT,.DGCDIS,,1)
 .I $G(DGCDIS("VCD"))'="",$$STORE^DGENCDA2(DFN,.DGCDIS) ;checks first if there is catastrophic disability information
 .;
 .;Call PIMS api to file NTR data.
 .I $D(DGNTR),$$ENRUPD^DGNTAPI1(DFN,.DGNTR)
 .;
 .;Call PIMS api to file MST data.
 .I DGMST("MSTSTAT")'="",DGMST("MSTDT")'="",DGMST("MSTST")'="" D
 ..I $$NEWSTAT^DGMSTAPI(DFN,DGMST("MSTSTAT"),DGMST("MSTDT"),".5",DGMST("MSTST"),0)
 .;
 .;Since HEC is authoritative source, If no OEF/OIF data in Z11, set count to 0 so existing data in VistA will be deleted.
 .I '$D(DGOEIF) S DGOEIF("COUNT")=0
 .;Call PIMS api to file OEF/OIF data.
 .I $D(DGOEIF) D OEIFUPD^DGCLAPI1(DFN,.DGOEIF)
 .;
 .;if the current enrollment is a local then log patient for transmission
 .I $$SOURCE^DGENA(DFN)=1!$G(DGPHINC) K DGENUPLD,DGPHINC D EVENT^IVMPLOG(DFN)
 .;
 .;create the audit trail
 .I $$AUDIT^DGENUPA1(,MSGID,.OLDPAT,.DGPAT,.OLDELG,.DGELG,.OLDCDIS,.DGCDIS,.DGSEC,.OLDSEC)
 .;send notifications
 .D NOTIFY^DGENUPL3(.DGPAT,.MSGS)
 .;
 .;invoke registration consistency checker
 .D REGCHECK^DGENUPL2(DFN)
 ;
 D UNLOCK^DGENUPL5(DFN)
 Q
