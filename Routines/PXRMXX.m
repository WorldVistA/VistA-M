PXRMXX ; SLC/PJH - Extract Patient sample;07/29/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Update ^TMP - all patients with encounters
 ;------------------------------------------
TMP S ^TMP(NODE,$J,"TEMP",DFN)="" Q
 ;
 ;Save individual encounter into FIND1
 ;------------------------------------
SAV S FCNT=FCNT+1,FOUND=1 M FIND1(FCNT)=FIND(ENC) Q
 ;
 ;Check if finding is in date range
 ;---------------------------------
DCHK(DNODE) ;
 N DATE,LTERM,LTRAN,TNAM,SNUM,TERMNAM,TERMNAT
 S DATE=$G(FIND(ENC,DNODE)) Q:DATE=""
 ;
 I (DATE<BD)!(DATE>ED) Q
 ;Lab transforms
 I REM(PXRMITEM)="VA-NATIONAL EPI LAB EXTRACT" D  Q:LTRAN
 .S LTRAN=0 D:$P(FIND(ENC,"FINDING"),";",2)="LAB(60," LTRAN
 ;National DB term mapping
 S TERMNAM=$P($G(FIND(ENC,"TERM")),U)
 ;If term exists check if it needs re-mapping for this reminder
 I TERMNAM]"" D
 .;Get the alternate name from the REM array
 .S TERMNAT=$G(REM(PXRMITEM,TERMNAM)) Q:TERMNAT=""
 .;National database code
 .S FIND(ENC,"ALTTRM")=TERMNAT
 ;Set source number code
 S SNUM=""
 I $G(FIND(ENC,"FILE NUMBER"))=9000011 S SNUM=1
 I $G(FIND(ENC,"FILE NUMBER"))=9000010.07 S SNUM=2
 I $G(FIND(ENC,"FILE NUMBER"))=45 S SNUM=3
 S FIND(ENC,"S/N")=SNUM
 ;
 ;Save encounter
 D SAV
 Q
 ;
 ;Check for findings
 ;------------------
FCHEK(PXRMITEM) ;
 N ECNT,EDATE,ENC,LDONE,FOUND
 ;Get reminder name
 S PXRMNAM=$P($G(^PXD(811.9,PXRMITEM,0)),U)
 ;Check each encounter
 S ENC=0,ECNT=0,FOUND=0,LDONE=0
 F  S ENC=$O(FIND(ENC)) Q:'ENC  D
 .;Ignore medications - these are loaded from pharmacy
 .I $D(FIND(ENC,"DRUG")) Q
 .;Check if finding is in date range
 .I $D(FIND(ENC,"FINDING")) D DCHK("DATE")
 ;
 Q
 ;
 ;Update ^TMP - all patients with findings
 ;----------------------------------------
FSAVE N CNT,FIEN,FCNT,FUNIQ,FREC
 N VDATA,VDATE,VFOUND,VLAST,VIEN,VLTYP,VOK,VSERV,VTYP
 ;Extract the visit date and type from visit record
 S CNT=0,FUNIQ=0,VLAST=0,VFOUND=0,VLTYP=""
 F  S CNT=$O(FIND1(CNT)) Q:'CNT  D
 .S VOK=0
 .I $D(FIND1(CNT,"VIEN")) D
 ..S VIEN=$G(FIND1(CNT,"VIEN")) Q:'VIEN
 ..S VDATA=$G(^AUPNVSIT(VIEN,0)) Q:VDATA=""
 ..;Get visit date and service from visit record
 ..S VDATE=$P(VDATA,U),VSERV=$P(VDATA,U,7),VFOUND=1,VOK=1,VTYP="O"
 ..;Calculate visit type from sevice
 ..I (VSERV="D")!(VSERV="H")!(VSERV="I") S VTYP="I"
 .;If no visit info default to finding date
 .I 'VOK S VDATE=$G(FIND1(CNT,"DATE")),VTYP="O" D
 ..N VAIN,VAINDT S VAINDT=VDATE D INP^VADPT
 ..I $G(VAIN(7))'="" S VTYP="I"
 .;Save encounter/finding date and type
 .S FIND1(CNT)=VDATE_U_VTYP
 .;Save count by finding for report
 .S FIEN=$G(FIND1(CNT,"FINDING")) I FIEN="" S FIEN="NO FINDING"
 .S FREC=$G(PXRMFIEN(FIEN)),FCNT=$P(FREC,U),FUNIQ=$P(FREC,U,2)
 .S FCNT=FCNT+1 I '$G(FUNIQ(FIEN)) S FUNIQ=FUNIQ+1
 .S PXRMFIEN(FIEN)=FCNT_U_FUNIQ,FUNIQ(FIEN)=1
 .;Save most recent
 .I VDATE>VLAST S VLAST=VDATE,VLTYP=VTYP
 ;
 ;Save patient
 S ^TMP(NODE,$J,DFN)=VLAST_U_VLTYP
 ;Save findings
 M ^TMP(NODE,$J,DFN,"FIND")=FIND1
 ;
 Q
 ;
 ;Check each patient for findings
 ;-------------------------------
FIND N BD,DFN,ED,LAB,LABN,PXRMITEM,PXRMNAM,OR,REM,SAVE,SEARCH
 ;
 ;Build array of reminders and terms to be re-mapped
 ;
 ;This requires that LAB(69.51) is created to include a list of IEN's
 ;
 S PXRMITEM=0
 F  S PXRMITEM=$O(^LAB(69.51,"B",PXRMITEM)) Q:'PXRMITEM  D
 .S PXRMNAM=$P($G(^PXD(811.9,PXRMITEM,0)),U)
 .I PXRMNAM'="VA-NATIONAL EPI RX EXTRACT" S REM(PXRMITEM)=PXRMNAM
 .;Get finding list for these reminders and medication list
 .D REM^PXRMXX1(PXRMITEM,.SEARCH,.LAB)
 .;Hep A,B,C lab tests
 .S LABN("HEP C VIRUS ANTIBODY POSITIVE")=""
 .S LABN("HEP C VIRUS ANTIBODY NEGATIVE")=""
 .S LABN("HAV Ab positive")=""
 .S LABN("HAV IgM Ab positive")=""
 .S LABN("HAV IgG positive")=""
 .S LABN("HBs Ab positive")=""
 .S LABN("HBs Ag positive")=""
 .S LABN("HBc Ab IgM positive")=""
 .S LABN("HBe Ag positive")=""
 .;NDB Transformations
 .I PXRMNAM="VA-HEP C RISK ASSESSMENT" D
 ..S REM(PXRMITEM,"VA-DECLINED HEP C RISK ASSESSMENT")=1
 ..S REM(PXRMITEM,"VA-NO RISK FACTORS FOR HEP C")=2
 ..S REM(PXRMITEM,"VA-PREVIOUSLY ASSESSED HEP C RISK")=3
 ..S REM(PXRMITEM,"VA-RISK FACTOR FOR HEPATITIS C")=4
 ..S REM(PXRMITEM,"VA-HEP C VIRUS ANTIBODY POSITIVE")=5
 ..S REM(PXRMITEM,"VA-HEP C VIRUS ANTIBODY NEGATIVE")=6
 ..S REM(PXRMITEM,"VA-HEPATITIS C INFECTION")=7
 ;
 ;Build pharmacy codes list
 F FTYPE="PSNDF(50.6,","PSDRUG(","PS(50.605," D
 .S FIEN=""
 .F  S FIEN=$O(SEARCH(FTYPE,FIEN)) Q:'FIEN  D
 ..S OR(FIEN_";"_FTYPE)=""
 ;
 ;Search for pharmacy outpatients
 I $O(OR(""))]"" D EN^PSOORAPI(PXRMBDT,PXRMEDT,.OR,"F","PXRMPSO"_NODE)
 ;
 ;Search for pharmacy inpatients
 I $O(OR(""))]"" D EN^PSJORAPI(PXRMBDT,PXRMEDT,.OR,"","PXRMPSI"_NODE)
 ;
 ;Build Lab codes list
 S FTYPE="LAB(60,",FIEN="" K OR
 F  S FIEN=$O(SEARCH(FTYPE,FIEN)) Q:'FIEN  D
 .S OR(FIEN)=""
 ;
 ;Search for lab patients
 I $O(OR(""))]"" D LAB^PXRMXX2(PXRMBDT,PXRMEDT,.OR,NODE)
 ;
 ;Build Health Factors list
 S FTYPE="AUTTHF(",FIEN="" K OR
 F  S FIEN=$O(SEARCH(FTYPE,FIEN)) Q:'FIEN  D
 .S OR(FIEN)=""
 ;
 ;Search for HF patients
 I $O(OR(""))]"" D HF^PXRMXX2(PXRMBDT,PXRMEDT,.OR,NODE)
 ;
 ;Build Patient Education list
 S FTYPE="AUTTEDT(",FIEN="" K OR
 F  S FIEN=$O(SEARCH(FTYPE,FIEN)) Q:'FIEN  D
 .S OR(FIEN)=""
 ;
 ;Search for PED patients
 I $O(OR(""))]"" D PED^PXRMXX2(PXRMBDT,PXRMEDT,.OR,NODE)
 ;
 ;Build Examination list
 S FTYPE="AUTTEXAM(",FIEN="" K OR
 F  S FIEN=$O(SEARCH(FTYPE,FIEN)) Q:'FIEN  D
 .S OR(FIEN)=""
 ;
 ;Search for Exam patients
 I $O(OR(""))]"" D EXAM^PXRMXX2(PXRMBDT,PXRMEDT,.OR,NODE)
 ;
 ;Build POV codes list
 S FTYPE="ICD9(",FIEN="" K OR
 F  S FIEN=$O(SEARCH(FTYPE,FIEN)) Q:'FIEN  D
 .S OR(FIEN)="",^TMP("PXRMPOV"_NODE,$J,FIEN)=""
 ;
 ;Search for POV patients
 I $O(OR(""))]"" D POV^PXRMXX2(PXRMBDT,PXRMEDT,"PXRMPOV"_NODE,NODE)
 ;
 S BD=PXRMBDT-.0001,ED=PXRMEDT+.2359,DFN=""
 F  S DFN=$O(^TMP(NODE,$J,"TEMP",DFN)) Q:'DFN  Q:TSTOP=1  D
 .;Check if stop task requested
 .I $$S^%ZTLOAD S TSTOP=1 Q
 .;Update total patient count for report
 .S PXRMCNT=PXRMCNT+1
 .N FIND1,FCNT
 .;Process reminders
 .S PXRMITEM=0,FCNT=0
 .F  S PXRMITEM=$O(REM(PXRMITEM)) Q:'PXRMITEM  D
 ..;Check reminder exists
 ..Q:'$D(^PXD(811.9,PXRMITEM,0))
 ..;Evaluate reminder to obtain list of findings
 ..N FIND
 ..D FIDATA^PXRM(DFN,PXRMITEM,.FIND)
 ..;Check if findings exist for the date range
 ..D FCHEK(PXRMITEM)
 .;Save in ^TMP
 .I FCNT D FSAVE K FIND1 S PXRMFCNT=PXRMFCNT+1
 ;
 ;Merge in patients from Outpatient Pharmacy
 D PSMERG^PXRMXX1("PXRMPSO",NODE,.SEARCH)
 ;Merge in patients from Inpatient Pharmacy
 D PSMERG^PXRMXX1("PXRMPSI",NODE,.SEARCH)
 ;
 Q
 ;
 ;Complex logic to handle lab/reminder mismatches
 ;-----------------------------------------------
LTRAN S LTERM=$P($G(FIND(ENC,"TERM")),U) Q:LTERM=""
 ;Skip terms not used in cohort logic
 I $D(LAB(LTERM)) S LTRAN=1 Q
 ;If one of selected list send the latest out of cohort entries instead
 I $D(LABN(LTERM)) S LTRAN=1 Q:LDONE=1  D
 .N ENC,TERM,DATE
 .S ENC=0,LDONE=1
 .F  S ENC=$O(FIND(ENC)) Q:'ENC  D
 ..S TERM=$P($G(FIND(ENC,"TERM")),U) Q:TERM=""
 ..;Check if the term is in the out of cohort list
 ..I $D(LAB(TERM)) D
 ...;Check if lab test is within date range or prior
 ...S DATE=$G(FIND(ENC,"DATE")) Q:DATE=""  Q:DATE>ED
 ...D SAV
 ;
 Q
 ;
 ;
 ;Entry point for API
 ;-------------------
PATS(PXRMBDT,PXRMEDT,NODE) ;
 ;
 ; PXRMBDT - Start date in fileman format
 ; PXRMEDT - End date in fileman format
 ; NODE  - Target name for ^TMP(NODE,$J)
 ;
 ;Task stopped
 N TSTOP S TSTOP=0
 ;
 ;
 ;Build temporary array of all wards
 ;N PXRMLCHL,PXRMLOCN D LCHL^PXRMXAP(1,.PXRMLCHL)
 ;
 ;Patients, patients with findings, finding and term counts
 N PXRMCNT,PXRMFCNT,PXRMFIEN,PXRMTIEN S PXRMCNT=0,PXRMFCNT=0
 ;
 ;Clear ^TMP
 K ^TMP(NODE,$J)
 ;Current inpatients
 ;D INP
 ;Inpatient admissions
 ;D ADM
 ;Outpatient visits
 ;D VISITS Q:TSTOP=1
 ;
 ;Check for findings in the selected patients
 D FIND Q:TSTOP=1
 ;
 ;Save report
 D REPORT^PXRMXX1(NODE)
 ;
 ;Remove list of all patients with encounters
 K ^TMP(NODE,$J,"TEMP")
 ;Remove pharmacy outpatient list
 K ^TMP("PXRMPSO"_NODE,$J)
 ;Remove pharmacy inpatient list
 K ^TMP("PXRMPSI"_NODE,$J)
 ;Remove icd9 list
 K ^TMP("PXRMPOV"_NODE,$J)
 Q
 ;
 ;Build list of inpatients admissions
 ;-----------------------------------
ADM N HLOCIEN,IC,DFN,BD,ED
 ;Get admissions for each selected location
 F IC=1:1 Q:'$D(PXRMLCHL(IC))  D
 .S HLOCIEN=$P(PXRMLCHL(IC),U,2) Q:HLOCIEN=""
 .; Get admissions from patient movements and return DFN's in PATS
 .S BD=PXRMBDT-.0001
 .S ED=PXRMEDT+.2359
 .N PATS D ADM^PXRMXAP(HLOCIEN,.PATS,BD,ED)
 .;Build ^TMP for selected patients 
 .S DFN=""
 .F  S DFN=$O(PATS(DFN)) Q:DFN=""  D TMP
 Q
 ;
 ;Build list of Current inpatients
 ;--------------------------------
INP N HLOCIEN,IC,DFN
 ;Get Current inpatients for each location
 F IC=1:1 Q:'$D(PXRMLCHL(IC))  D
 .S HLOCIEN=$P(PXRMLCHL(IC),U,2) Q:HLOCIEN=""
 .;Get WARDIEN,WARDNAM and return DFN's in PATS
 .N PATS D WARD^PXRMXAP(HLOCIEN,.PATS)
 .;Build ^TMP for selected patients 
 .S DFN=""
 .F  S DFN=$O(PATS(DFN)) Q:DFN=""  D TMP
 Q
 ;
 ;Scan visit file to build list of patients
 ;-----------------------------------------
VISITS N BD,DFN,ED,HLOCIEN,IC,VIEN,VISIT
 ;
 S BD=PXRMBDT-.0001
 S ED=PXRMEDT+.2359
 ;Get Date ; DBIA #2028
 F  S BD=$O(^AUPNVSIT("B",BD)) Q:BD>ED  Q:BD=""  Q:TSTOP=1  D
 .S VIEN=0
 .;Get individual visit
 .F  S VIEN=$O(^AUPNVSIT("B",BD,VIEN)) Q:VIEN=""  Q:TSTOP=1  D
 ..;Check if stop task requested
 ..I $$S^%ZTLOAD S TSTOP=1 Q
 ..;Screen Individual Visit
 ..S VISIT=$G(^AUPNVSIT(VIEN,0)) Q:VISIT=""
 ..;Patient IEN
 ..S DFN=$P(VISIT,U,5) Q:'DFN
 ..;Build patient list in ^TMP
 ..D TMP
 Q
