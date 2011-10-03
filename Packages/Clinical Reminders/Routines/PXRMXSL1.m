PXRMXSL1 ; SLC/PJH - Process Visits/Appts Reminder Due report;06/03/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
 ; Called from PXRMXSE
 ;
TMP(DFN,NAM,FACILITY,INP) ;Update ^TMP("PXRMX"
 N LOC
 I PXRMFCMB="Y" S FACILITY="COMBINED FACILITIES"
 I PXRMLCMB="Y" S NAM="COMBINED LOCATIONS"
 I PXRMCCS="I" S NAM="Clinic Stop "_NAM_" location "_$P(^SC(INP,0),U)
 S LOC=$S(PXRMCCS="B":$P(^SC(INP,0),U),1:"LOC")
 S ^TMP("PXRMX",$J,FACILITY,NAM,LOC,DFN)=INP
 Q
 ;
 ;Mark location as found
MARK(IC) ;
 S ^XTMP(PXRMXTMP,"MARKED AS FOUND",IC)=""
 Q
 ;
 ;Check if facility is on list, PXMRFACN.
HFAC(HLOCIEN) ;
 N DIV,HFAC
 ;DBIA #2804
 S HFAC=$P(^SC(HLOCIEN,0),U,4)
 I HFAC="" S DIV=$P($G(^SC(HLOCIEN,0)),U,15) S:DIV'="" HFAC=$P($G(^DG(40.8,DIV,0)),U,7)
 I HFAC="" S HFAC=+$P($$SITE^VASITE,U,3)
 I HFAC="" Q ""
 I '$D(PXRMFACN(HFAC)) Q ""
 Q HFAC
 ;
INACTCL(HLIEN,PXRMBDT) ;
 ;Check to see if clinic is inactivated before the start of 
 ;the reporting period
 N INACT,REACT
 S INACT=+$P($G(^SC(HLIEN,"I")),U) I INACT=0 Q 0
 S REACT=+$P($G(^SC(HLIEN,"I")),U,2)
 I REACT'<INACT Q 0
 I INACT<PXRMBDT Q 1
 Q 0
 ;
INPADM ;
 ;Build list of inpatients admissions and current patients on a ward
 N BD,DFN,ED,FACILITY,HIEN,NAM
 S NAM="All Locations"
 S HIEN=0
 F  S HIEN=$O(^XTMP(PXRMXTMP,"HLOC",HIEN)) Q:HIEN'>0  D
 .S FACILITY=$P(^XTMP(PXRMXTMP,"HLOC",HIEN),U,1)
 .;Get WARDIEN,WARDNAM and return DFN's in PATS
 .N PATS
 .I PXRMFD="C" D WARD^PXRMXAP(HIEN,.PATS)
 .I PXRMFD="A" D
 ..; Get admissions from patient movements and return DFN's in PATS
 ..S BD=PXRMBDT-.0001
 ..S ED=PXRMEDT+.2359
 ..D ADM^PXRMXAP(HIEN,.PATS,BD,ED)
 .;Split report by location
 .I PXRMLCMB="N" S NAM=$P(^XTMP(PXRMXTMP,"HLOC",HIEN),U,2)
 .;Build ^TMP for selected patients 
 .S DFN=""
 .F  S DFN=$O(PATS(DFN)) Q:DFN=""  D
 ..S ^TMP($J,"PXRM PATIENT EVAL",DFN)=""
 ..D TMP(DFN,NAM,FACILITY,HIEN) D MARK(HIEN)
 Q
 ;
BHLOC ;
 N CLINIEN,CGRPIEN,END,FACILITY,NAM,HLIEN,I,START,TEXT
 N INACT,REACT
 ;Initialize the busy counter.
 S BUSY=0
 ;All inpatient, outpatient all location credit stop and encounter
 S START=$H
 I $P(PXRMLCSC,U)["HA"!($P(PXRMLCSC,U)="CA") D
 .S HLIEN=0 F  S HLIEN=$O(^SC(HLIEN)) Q:HLIEN'>0  D
 ..S FACILITY=$$HFAC(HLIEN) I FACILITY'>0 Q
 ..I $$INACTCL(HLIEN,PXRMBDT)=1 Q
 ..S NAM=$P(^SC(HLIEN,0),U)
 ..D NOTIFY^PXRMXBSY("Building hospital locations list",.BUSY)
 ..;All inpatient locations
 ..I $P(PXRMLCSC,U)="HAI",$D(^SC(HLIEN,42)) S ^XTMP(PXRMXTMP,"HLOC",HLIEN)=FACILITY_U_NAM Q
 ..;All outpatient locations
 ..I $P(PXRMLCSC,U)="HA",'$D(^SC(HLIEN,42)) S ^XTMP(PXRMXTMP,"HLOC",HLIEN)=FACILITY_U_NAM Q
 ..;All encounters with a credit stop
 ..I $P(PXRMLCSC,U)="CA",$P($G(^SC(HLIEN,0)),U,7)>0 S ^XTMP(PXRMXTMP,"HLOC",HLIEN)=FACILITY_U_NAM Q
 ;Selected hosiptal locations
 I $P(PXRMLCSC,U,1)="HS" D
 .S HLIEN=0 F  S HLIEN=$O(PXRMLOCN(HLIEN)) Q:HLIEN'>0  D
 ..S FACILITY=$$HFAC(HLIEN) I FACILITY'>0 Q
 ..I $$INACTCL(HLIEN,PXRMBDT)=1 Q
 ..S NAM=$P(^SC(HLIEN,0),U)
 ..D NOTIFY^PXRMXBSY("Building hospital locations list",.BUSY)
 ..S ^XTMP(PXRMXTMP,"HLOC",HLIEN)=FACILITY_U_NAM
 ;Selected Credit Stops
 I PXRMSEL="L",$P(PXRMLCSC,U)="CS" D
 .S CLINIEN=0 F  S CLINIEN=$O(PXRMCSN(CLINIEN)) Q:CLINIEN'>0  D
 ..S HLIEN=0 F  S HLIEN=$O(^SC("AST",CLINIEN,HLIEN)) Q:HLIEN'>0  D
 ...S FACILITY=$$HFAC(HLIEN) I FACILITY'>0 Q
 ...I $$INACTCL(HLIEN,PXRMBDT)=1 Q
 ...S NAM=$P(^DIC(40.7,CLINIEN,0),U)_" "_$P(PXRMCS($G(PXRMCSN(CLINIEN))),U,3)
 ...D NOTIFY^PXRMXBSY("Building hospital locations list",.BUSY)
 ...S ^XTMP(PXRMXTMP,"HLOC",HLIEN)=FACILITY_U_NAM_U_$P(PXRMCS($G(PXRMCSN(CLINIEN))),U,3)
 ;Selected Clinic Groups
 I PXRMSEL="L",$E(PXRMLCSC)="G" D
 .S CGRPIEN=0 F  S CGRPIEN=$O(PXRMCGRN(CGRPIEN)) Q:CGRPIEN'>0  D
 ..S HLIEN=0 F  S HLIEN=$O(^SC("ASCRPW",CGRPIEN,HLIEN)) Q:HLIEN'>0  D
 ...S FACILITY=$$HFAC(HLIEN) I FACILITY'>0 Q
 ...I $$INACTCL(HLIEN,PXRMBDT)=1 Q
 ...D NOTIFY^PXRMXBSY("Building hospital locations list",.BUSY)
 ...S ^XTMP(PXRMXTMP,"HLOC",HLIEN)=FACILITY_U_$P(^SC(HLIEN,0),U)_U_CGRPIEN
 S END=$H
 S TEXT="Elapsed time for building hospital locations list: "_$$DETIME^PXRMXSL1(START,END)
 S ^XTMP(PXRMXTMP,"TIMING","BUILDING HOSPITAL LOCATIONS")=TEXT
 I '(PXRMQUE!$D(IO("S"))!(PXRMTABS="Y")) W !,TEXT
 Q
 ;
DETIME(START,END) ;
 N ETIME,TEXT
 S ETIME=$$HDIFF^XLFDT(END,START,2)
 I ETIME>90 D
 . S ETIME=$$HDIFF^XLFDT(END,START,3)
 . S TEXT=ETIME
 E  S TEXT=ETIME_" secs"
 Q TEXT
 ;
OERR ;
 N CNT,II,NAM,OTM
 ;Initialize the busy counter.
 S BUSY=0
 S II=""
 ;Get patient list for each team
 F  S II=$O(PXRMOTM(II)) Q:II=""  D
 .S OTM=$P(PXRMOTM(II),U),NAM=$P(PXRMOTM(II),U,2)
 .;Build list of patients for OE/RR team ; DBIA #2692
 .K ^TMP($J,"OTM")
 .D TEAMPTS^ORQPTQ1("^TMP($J,""OTM"",",OTM,1)
 .I $G(^TMP($J,"OTM",1))["No patients found" Q
 .I PXRMTCMB="Y" N OTM,NAM S OTM="COMBINED",NAM="COMBINED TEAMS"
 .S CNT=0 F  S CNT=$O(^TMP($J,"OTM",CNT)) Q:CNT'>0  D
 ..D NOTIFY^PXRMXBSY("Collecting patients from OE/RR List",.BUSY)
 ..S DFN=$P(^TMP($J,"OTM",CNT),U)
 ..D UPD1(DFN,NAM,"FACILITY",II)
 .D MARK(OTM)
 K ^TMP($J,"OTM")
 I PXRMREP="D",$D(^TMP($J,"PXRM PATIENT EVAL"))>0 D SDAM301^PXRMXSL2(DT,"",PXRMSEL,PXRMFD,PXRMREP)
 Q
 ;
 ;PCMM provider selected
PCMMP ;
 N CNT,DCLN,SCDT,LIST,SCERR,SCLIST,II,PCM,NAM,PNAM,PXRM,OK
 N FACILITY,NAM
 ;Initialize the busy counter.
 S BUSY=0
 S SCDT("BEGIN")=PXRMSDT,SCDT("END")=PXRMSDT
 ;Include patient if in team on any day in range
 S SCDT("INCL")=0
 S II=""
 ;Get patient list for each PROVIDER
 F  S II=$O(PXRMPRV(II)) Q:II=""  D
 .S PCM=$P(PXRMPRV(II),U),NAM=$P(PXRMPRV(II),U,2)
 .;Get patients for practs. roles - excluding assoc clinics
 .K ^TMP($J,"PCM")
 .N SCTEAM D PTPR^PXRMXAP(PCM,PXRMREP)
 .I $O(^TMP($J,"PCM",0))="" Q
 .;Save in ^TMP in alpha order within team number (internal)
 .S CNT=0 F  S CNT=$O(^TMP($J,"PCM",CNT)) Q:CNT'>0  D
 ..S DFN=$P(^TMP($J,"PCM",CNT),U)
 ..D NOTIFY^PXRMXBSY("Collecting patients from Primary Provider List",.BUSY)
 ..I PXRMPRIM="P",($$PCASSIGN^PXRMXAP(DFN)'=1) Q
 ..;For detailed provider report get assoc clinic report future 
 ..;appointment for all location
 ..I PXRMREP="D" S DCLN=$P(^TMP($J,"PCM",CNT),U,7)
 ..I $G(DCLN)'="" S PXRMDCLN(DCLN)=""
 ..D UPD1(DFN,NAM,"FACILITY",+$G(DCLN))
 .D MARK(PCM)
 K ^TMP($J,"PCM")
 I PXRMREP="D",$D(^TMP($J,"PXRM PATIENT EVAL"))>0 D SDAM301^PXRMXSL2(DT,"",PXRMSEL,PXRMFD,PXRMREP)
 Q
 ;
 ;PCMM team selected
PCMMT ;
 N CNT,SCDT,LIST,SCERR,SCLIST,II,PCM,NAM,PNAM,OK
 ;Initialize the busy counter.
 S BUSY=0
 S SCDT("BEGIN")=PXRMSDT,SCDT("END")=PXRMSDT
 ;Include patient if in team on any day in range
 S SCDT("INCL")=0
 S II=""
 ;Get patient list for each team
 F  S II=$O(PXRMPCM(II)) Q:II=""  D
 .S PCM=$P(PXRMPCM(II),U),NAM=$P(PXRMPCM(II),U,2)
 .K ^TMP($J,"PCM")
 .S OK=$$PTTM^PXRMXAP(PCM,.SCERR) Q:'OK
 .I $O(^TMP($J,"PCM",0))="" Q
 .S FACILITY=$$FAC^PXRMXAP(PCM)
 .S CNT=0 F  S CNT=$O(^TMP($J,"PCM",CNT)) Q:CNT'>0  D
 ..S DFN=$P(^TMP($J,"PCM",CNT),U)
 ..D NOTIFY^PXRMXBSY("Collecting patients from PCMM Team List",.BUSY)
 ..D UPD1(DFN,NAM,FACILITY,II)
 .D MARK(PCM)
 K ^TMP($J,"PCM")
 I PXRMREP="D",$D(^TMP($J,"PXRM PATIENT EVAL"))>0 D SDAM301^PXRMXSL2(DT,"",PXRMSEL,PXRMFD,PXRMREP)
 Q
 ;
 ;Individual Patients selected
IND ;
 N CNT,DFN,DUMMY,LIST,NAM
 S (DUMMY,NAM)="PATIENT"
 S CNT=0 F  S CNT=$O(PXRMPAT(CNT)) Q:CNT'>0  D
 .S DFN=$P(PXRMPAT(CNT),U)
 .D UPD1(DFN,"INDIVIDUAL PATIENTS","FACILITY",DFN)
 I PXRMREP="D",$D(^TMP($J,"PXRM PATIENT EVAL"))>0 D SDAM301^PXRMXSL2(DT,"",PXRMSEL,PXRMFD,PXRMREP)
 Q
 ;
 ;Patient lists selected
LIST ;
 N DFN,DSUB,DUMMY,LCNT,LIEN,LIST,NAM
 ;Initialize the busy counter.
 S BUSY=0
 S (DUMMY,NAM)="PATIENT",LCNT=0
 F  S LCNT=$O(PXRMLIST(LCNT)) Q:'LCNT  D
 .S LIEN=$P(PXRMLIST(LCNT),U) Q:'LIEN
 .S NAM=$P(^PXRMXP(810.5,LIEN,0),U)
 .S DSUB=0
 .F  S DSUB=$O(^PXRMXP(810.5,LIEN,30,DSUB)) Q:'DSUB  D
 ..S DFN=$P($G(^PXRMXP(810.5,LIEN,30,DSUB,0)),U) Q:'DFN
 ..D NOTIFY^PXRMXBSY("Collecting patients from Reminder Patient List",.BUSY)
 ..D UPD1(DFN,NAM,"FACILITY",LIEN)
 I PXRMREP="D",$D(^TMP($J,"PXRM PATIENT EVAL"))>0 D SDAM301^PXRMXSL2(DT,"",PXRMSEL,PXRMFD,PXRMREP)
 Q
 ;
UPD1(DFN,NAM,FACILITY,INP) ;
 ;Remove test patients.
 I 'PXRMTPAT,$$TESTPAT^VADPT(DFN)=1 Q
 ;Remove patients that are deceased.
 I 'PXRMDPAT,$P($G(^DPT(DFN,.35)),U,1)>0 Q
 S ^TMP($J,"PXRM PATIENT LIST",DFN)=""
 S ^TMP($J,"PXRM PATIENT EVAL",DFN)=""
 D TMP(DFN,NAM,FACILITY,INP)
 Q
 ;
