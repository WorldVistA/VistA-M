DGENUPL7 ;ISA/KWP,CKN,TMK,TDM,LBD,HM,KUM - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ;9/12/20 5:48pm
 ;;5.3;REGISTRATION;**232,367,397,417,379,431,513,628,673,653,742,688,797,871,972,952,977,993,1014,1027,1045,1082,1090**;Aug 13,1993;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
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
 N DGELG,DGENR,DGPAT,DGCDIS,DGOEIF,ERROR,ERRMSG,MSGS,DGELGSUB,DGENUPLD,DGCON,DGNMSE,DGCCPG,DGSUB,DGFDA,DGERR,DGIENS
 N DGNEWVAL,DIV,SUB,OLDELG,OLDPAT,OLDDCDIS,OLDEIF,DGSEC,OLDSEC,DGNTR,DGMST,DGPHINC,DGHBP,DGOTH,DGSUB,DGCOVF,DGESCO,DGCOV
 N DGELCV,DGOAPP,DGZHF
 ;
 ;some process is killing these HL7 variables, so need to protect them
 S SUB=HLFS
 S DIV=HLECH
 N HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLECH,HLFS,HLNDAP,HLNDAP0,HLPID,HLQ,HLVER,HLERR,HLMTN,HLSDT
 S HLFS=SUB
 S HLECH=DIV
 S HLQ=""""""
 K DIV,SUB
 ;DG*5.3*1090 - Kill ^TMP global Combat Vet Elig End Date Source
 K ^TMP("DGCVE",$J,"COMBAT VET ELIG END DATE SOURCE",DFN)
 ;
 ;drops out of block on error
 D
 .;DG*5.3*1082 - Add ZHF Parsing to load DGZHF array
 .Q:'$$PARSE^DGENUPL1(MSGIEN,MSGID,.CURLINE,.ERRCOUNT,.DGPAT,.DGELG,.DGENR,.DGCDIS,.DGOEIF,.DGSEC,.DGNTR,.DGMST,.DGNMSE,.DGHBP,.DGOTH,.DGZHF)
 .; DG*5.3*1014 - Capture Z11 eligibilities
 .M DGELCV=DGELG
 .D GETLOCKS^DGENUPL5(DFN)
 .;
 .;Used by cross-references to determine if an upload is in progress.
 .S DGENUPLD="ENROLLMENT/ELIGIBILITY UPLOAD IN PROGRESS"
 .;
 .;Update the PATIENT, ELIGIBILITY, CATASTROPHIC DISABILITY objects in memory
 .Q:'$$UOBJECTS^DGENUPL4(DFN,.DGPAT,.DGELG,.DGCDIS,.DGOEIF,MSGID,.ERRCOUNT,.MSGS,.OLDPAT,.OLDELG,.OLDCDIS,.OLDEIF)
 .;DG*5.3*1014 - Delete Vista secondary eligibilities from DGELG array
 .S DGSUB=0 F  S DGSUB=$O(DGELG("ELIG","CODE",DGSUB)) Q:'DGSUB  D
 ..I '$D(DGELCV("ELIG","CODE",DGSUB)) K DGELG("ELIG","CODE",DGSUB)
 .;
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
 .; KUM - DG*5.3*1014 - BEGIN
 .; Upload Community Care Program Data to Patient file (#2)
 .;
 .; End date all CCPs and Set Archive flag if COV is removed from eligibilities
 .S DGCOV=$$FIND1^DIC(8,"","B","COLLATERAL OF VET")
 .S DGCOVF=""
 .S DGESCO=""
 .I $$GET1^DIQ(2,DFN_",",".361","I")=$G(DGCOV) S DGCOVF="Y"
 .S DGSUB=0 F  S DGSUB=$O(^DPT(DFN,"E",DGSUB)) Q:'DGSUB  D
 ..I +$G(^DPT(DFN,"E",DGSUB,0))=$G(DGCOV) S DGCOVF="Y"
 .I DGELCV("ELIG","CODE")=$G(DGCOV) S DGESCO="Y"
 .S DGSUB=0 F  S DGSUB=$O(DGELCV("ELIG","CODE",DGSUB)) Q:'DGSUB  D
 ..I DGSUB=$G(DGCOV) S DGESCO="Y"
 .I DGCOVF="Y",DGESCO'="Y" D ARCHALL^DGRP1152U(DFN)
 .;
 .; Allow moving of cov from Primary to Other
 .; Removing COV from patient eligibilities is not allowed if there are active CCPs
 .; But uisng Z11, moving COV from primary to Other eligibilities is allowed, in this Case, bypassing the Check
 .I DGELG("ELIG","CODE")'=$G(DGCOV),$$GET1^DIQ(2,DFN_",",".361","I")=$G(DGCOV),DGESCO="Y" D
 ..S $P(^DPT(DFN,.36),"^",1)=""
 .;
 .S DGSUB=""
 .F  S DGSUB=$O(DGCCPG(DGSUB)) Q:DGSUB=""  D
 ..N DGMAT,DGPGCD,DGEFDT,DGEDDT,DGLUTS,DGZ,IENS,DGPGC1,DGEFD1
 ..S DGMAT="N"
 ..S DGPGCD=$P(DGCCPG(DGSUB),"^",1)
 ..S DGEFDT=$P(DGCCPG(DGSUB),"^",2)
 ..S DGEDDT=$P(DGCCPG(DGSUB),"^",3)
 ..I $G(DGEDDT)="@" S DGEDDT=""
 ..I $G(DGEDDT)="" S DGEDDT=""
 ..S DGLUTS=$P(DGCCPG(DGSUB),"^",4)
 ..S DGZ=0 F  S DGZ=$O(^DPT(DFN,5,"AC",$G(DGEFDT),DGZ)) Q:'DGZ  D
 ...S IENS=DGZ_","_DFN_","
 ...I $$GET1^DIQ(2.191,IENS,4,"I")'=1 D
 ....S DGPGC1=$$GET1^DIQ(2.191,IENS,1,"I")
 ....S DGEFD1=$$GET1^DIQ(2.191,IENS,2,"I")
 ....I ($G(DGPGCD)=$G(DGPGC1)),($G(DGEFDT)=$G(DGEFD1)) S DGMAT="Y" D CCCUPD
 ..I DGMAT'="Y" D CCCADD
 .Q:ERROR
 .; KUM - DG*5.3*1014 - END
 .; 
 .;if the msg has an enrollment process it
 .I DGENR("STATUS")!DGENR("APP") D  Q:ERROR
 ..N DGENRYN,DGSTS
 ..S DGENRYN=""
 ..S DGSTS=DGENR("STATUS")
 ..I DGSTS=25 S DGENRYN=0 ;DG*5.3*993
 ..I DGSTS'=25,'$$PREEXIST^DGREG(DFN) S DGENRYN=1
 ..;use $$PRIORITY to get the eligibility data used to compute priority
 ..I $$PRIORITY^DGENELA4(DFN,.DGELG,.DGELGSUB,DGENR("DATE"),DGENR("APP"),$G(DGENRYN)) ;DG*5.3*993 Added DGENRYN REGISTRATION ONLY
 ..;
 ..;store the eligibility data in the enrollment record and other missing fields
 ..M DGENR("ELIG")=DGELGSUB
 ..S DGENR("ELIG","OTHTYPE")=$G(DGELG("OTHTYPE")) ; DG*5.3*952
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
 ..;DG5.3*1027 - Do not reject Z11 when VistA stored YES for DO YOU WISH TO ENROLL and receive NO from HEC
 ..; DG*5.3*993 - BEGIN
 ..;Find patient's current enrollment record
 ..;N DGENRIEN,DGENRYN
 ..;S DGENRIEN=""
 ..;S DGENRYN=""
 ..;S DGENRIEN=$$FINDCUR^DGENA(DFN)
 ..;I DGENRIEN S:$G(DGENRYN)="" DGENRYN=$$GET1^DIQ(27.11,DGENRIEN_",",.14,"I") ;DG*5.3*993 Added REGISTRATION ONLY
 ..;I DGENRYN=1,DGENR("PTAPPLIED")=0,DGPAT("VETERAN")="Y" D Q
 ..;S ERROR=1
 ..;S ERRMSG="Veteran has applied for enrollment. Do You Wish to Enroll cannot be No."
 ..;D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),ERRMSG,.ERRCOUNT)
 ..;
 ..; DG*5.3*993 - END
 ..;DG*5.3*1027 - END
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
 .; store OTH data
 .D OTHUPLD^DGENUPL8(DFN,.DGOTH,$G(DGPAT("SSN")),$G(DGELG("ELIG","CODE"))) ; DG*5.3*952
 .;
 .;Call PIMS api to file NTR data.
 .I $D(DGNTR),$$ENRUPD^DGNTAPI1(DFN,.DGNTR)
 .;
 .;Call PIMS api to file MST data.
 .I DGMST("MSTSTAT")'="",DGMST("MSTDT")'="",DGMST("MSTST")'="" D
 ..I $$NEWSTAT^DGMSTAPI(DFN,DGMST("MSTSTAT"),DGMST("MSTDT"),".5",DGMST("MSTST"),0)
 ..Q
 .; create new entry in sub-file 33.02
 .D CRTEELCH^DGOTHEL(DFN,$$HASENTRY^DGOTHD2(DFN),$G(DGELG("OTHTS"))) ; DG*5.3*977 OTH-EXT - moved after MST data update
 .;
 .;Since HEC is authoritative source, If no OEF/OIF data in Z11, set count to 0 so existing data in VistA will be deleted.
 .I '$D(DGOEIF) S DGOEIF("COUNT")=0
 .;Call PIMS api to file OEF/OIF data.
 .I $D(DGOEIF) D OEIFUPD^DGCLAPI1(DFN,.DGOEIF)
 .;
 .;File the Military Service Episode (MSE) data (DG*5.3*797)
 .I $D(DGNMSE) D UPDMSE^DGMSEUTL(DFN,.DGNMSE)
 .;
 .;File the Health Benefit Plan (HBP) data
 .D HL7UPD^DGHBPUTL(DFN,.DGHBP,MSHDT)
 .;DG*5.3*1082 - File the Health Factor Segment (ZHF) data
 .D ZHFUPD
 .;
 .;if the current enrollment is a local then log patient for transmission
 .;DG*5.3*1045 - Don't trigger Z07 if source is VAMC 
 .;I $$SOURCE^DGENA(DFN)=1!$G(DGPHINC) K DGENUPLD,DGPHINC D EVENT^IVMPLOG(DFN)
 .I $G(DGPHINC) K DGENUPLD,DGPHINC D EVENT^IVMPLOG(DFN)
 .;
 .;create the audit trail
 .K OLDPAT("MOH"),DGPAT("MOH") ;remove MOH from audit demographics report DG*5.3*972 HM
 .I $$AUDIT^DGENUPA1(,MSGID,.OLDPAT,.DGPAT,.OLDELG,.DGELG,.OLDCDIS,.DGCDIS,.DGSEC,.OLDSEC)
 .;send notifications
 .D NOTIFY^DGENUPL3(.DGPAT,.MSGS)
 .;
 .;invoke registration consistency checker
 .D REGCHECK^DGENUPL2(DFN)
 ;
 D UNLOCK^DGENUPL5(DFN)
 ;DG*5.3*1090 - Kill ^TMP global Combat Vet Elig End Date Source
 K ^TMP("DGCVE",$J,"COMBAT VET ELIG END DATE SOURCE",DFN)
 Q
CCCADD ; Add new entry to #2.191
 N DGERR,DGIENS,DGFDA
 S DGERR=0
 S DGIENS=DFN_","
 S DGIENS="+1,"_DGIENS
 S DGFDA(2.191,DGIENS,.01)=$G(DGLUTS)
 S DGFDA(2.191,DGIENS,1)=$G(DGPGCD)
 S DGFDA(2.191,DGIENS,2)=$G(DGEFDT)
 S DGFDA(2.191,DGIENS,3)=$G(DGEDDT)
 D UPDATE^DIE("","DGFDA","","DGERR")
 I DGERR D
 .S ERROR=1
 .D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),$G(DGERR("DIERR",1,"TEXT",1)),.ERRCOUNT)
 Q
CCCUPD ; Update entry in #2.191
 N DGFDA,DGERR,DGIENS,DGTMTS
 S DGERR=0
 S DGIENS=IENS
 S DGTMTS=+$$GET1^DIQ(2.191,DGIENS,.01,"I")
 I $G(DGLUTS)>$G(DGTMTS) D
 .S DGFDA(2.191,DGIENS,.01)=$G(DGLUTS)
 .S DGFDA(2.191,DGIENS,3)=$G(DGEDDT)
 .S DGFDA(2.191,DGIENS,4)=0
 .D FILE^DIE("","DGFDA","DGERR")
 .I DGERR D
 ..S ERROR=1
 ..D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),$G(DGERR("DIERR",1,"TEXT",1)),.ERRCOUNT)
 Q
ZHFUPD ; DG*5.3*1082 - Update database with the ZHF data
 ; a date is always expected when updating.
 I $G(DGZHF("PPCATCHGDT"))'="" D
 .; Update Presumptive Psychosis Category (#.5601) field in the Patient (#2) file, and the Presumptive Psychosis Category Change (#33.1) file.
 .I '$$PT^DGPPSYCH(DFN,DGZHF("PPCATEGORY"),DGZHF("PPCATCHGDT")) D
 ..S ERRMSG="FILEMAN FAILED TO UPDATE PRESUMPTIVE PSYCHOSIS CATEGORY"
 ..S ERROR=1
 ..D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),$G(ERRMSG),.ERRCOUNT) Q
 Q
