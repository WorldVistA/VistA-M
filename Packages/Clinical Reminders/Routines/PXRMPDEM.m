PXRMPDEM ;SLC/PKR - Computed findings for patient demographics. ;06/22/2011
 ;;2.0;CLINICAL REMINDERS;**5,4,11,12,17,18**;Feb 04, 2005;Build 152
 ;
 ;======================================================
AGE(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for returning a patient's
 ;age
 S DATE=$$NOW^PXRMDATE,TEST=1
 I $D(PXRMPDEM) D  Q
 . S VALUE=PXRMPDEM("AGE")
 . I +PXRMPDEM("DOD")=0 S VALUE("DECEASED")=0 Q
 . I +PXRMPDEM("DOD")>0 S VALUE("DECEASED")=1,TEXT="Patient is deceased"
 I '$D(PXRMPDEM) D
 . N DOB,DOD
 .;DBIA #10035
 . S DOB=$P(^DPT(DFN,0),U,3)
 . S DOD=$P($G(^DPT(DFN,.35)),U,1)
 . S VALUE=$$AGE^PXRMAGE(DOB,DOD,$$NOW^PXRMDATE)
 . I +DOD=0 S VALUE("DECEASED")=0 Q
 . I +DOD>0 S VALUE("DECEASED")=1,TEXT="Patient is deceased"
 Q
 ;
 ;======================================================
DFA(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;This computed finding
 ;returns the date the patient turns a specified age. Based on
 ;work by AJM: 9/16/08.
 ;DBIA #10035 DATE OF BIRTH is a required field.
 I TEST="" S NFOUND=0,DATE(1)=$$NOW^PXRMDATE,TEST(1)=0 Q
 S TEST=$P(TEST,".",1)
 N BDAY,DOB,YEAR,YOB
 S NFOUND=1
 S DOB=$S($D(PXRMDOB):PXRMDOB,1:$P(^DPT(DFN,0),U,3))
 S YOB=$E(DOB,1,3)
 S BDAY=$E(DOB,4,7)
 S YEAR=YOB+TEST
 I BDAY="0229",'$$ISLEAP^PXRMDATE(YEAR) S BDAY="0228"
 S (DATE(1),VALUE(1,"VALUE"))=YEAR_BDAY
 S TEST(1)=1
 S TEXT(1)="Patient "_$S(DATE(1)>$$NOW^PXRMDATE:"will be ",1:"was ")_+TEST_" years old on "_$$FMTE^XLFDT(DATE(1),"5Z")
 Q
 ;
 ;======================================================
DOB(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for a patient's
 ;date of birth.
 I $D(PXRMPDEM) S VALUE=PXRMPDEM("DOB")
 ;DBIA #10035 DATE OF BIRTH is a required field.
 I '$D(PXRMPDEM) S VALUE=$P(^DPT(DFN,0),U,3)
 S TEST=$S(VALUE<$$NOW^PXRMDATE:1,1:0)
 I TEST S DATE=VALUE,TEXT=$$EDATE^PXRMDATE(VALUE)
 Q
 ;
 ;======================================================
DOD(DFN,TEST,DATE,VALUE,TEXT)   ;Computed finding for a patient's
 ;date of death.
 I $D(PXRMPDEM) S VALUE=+PXRMPDEM("DOD")
 ;DBIA #10035
 I '$D(PXRMPDEM) S VALUE=+$P($G(^DPT(DFN,.35)),U,1)
 S TEST=$S(VALUE=0:0,VALUE>$$NOW^PXRMDATE:0,1:1)
 I TEST S DATE=VALUE,TEXT=$$EDATE^PXRMDATE(VALUE)
 Q
 ;
 ;======================================================
EMPLOYE(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;This computed finding
 ;will return true if the patient is an employee.
 ;DBIA #10035, #10060
 N IEN,PAID,SSN
 S NFOUND=1,DATE(1)=$$NOW^PXRMDATE,TEST(1)=0
 S SSN=$P($G(^DPT(DFN,0)),U,9)
 I SSN="" Q
 ;Use SSN to make the link.
 S IEN=+$O(^VA(200,"SSN",SSN,""))
 I IEN=0 Q
 S PAID=+$P($G(^VA(200,IEN,450)),U,1)
 I PAID=0 Q
 ;Check for a termination date.
 I +$P(^VA(200,IEN,0),U,11)<BDT Q
 S TEST(1)=1,TEXT(1)="Patient is an employee."
 Q
 ;
 ;======================================================
ETHNY(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;Computed finding for
 ;a patient's ethnicity.
 N CNT,CNT1,VADM
 D DEM^VADPT
 I $D(VADM(11))'=11 S NFOUND=0 D KVA^VADPT Q
 S NGET=$S(NGET<0:-NGET,1:NGET)
 S (CNT,CNT1)=0
 F  S CNT=$O(VADM(11,CNT)) Q:(CNT="")!(CNT1=NGET)  D
 . S CNT1=CNT1+1,TEST(CNT1)=1,DATE(CNT1)=$$NOW^PXRMDATE
 . S TEXT(CNT1)="",VALUE(CNT1,"VALUE")=$P($G(VADM(11,CNT)),U,2)
 S NFOUND=CNT1
 D KVA^VADPT
 Q
 ;
 ;======================================================
HDISCH(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;Computed finding for
 ;a list of a patient's discharge dates from PTF.
 ;References to ^DGPT covered by DBIA #1372.
 N DAS,DDATE,DDATEL,DONE,FEEBASIS,IEN,IND,INCEN,INFEE,NF,SDIR,TEMP,TYPE
 S TEMP=$$UP^XLFSTR(TEST)
 S TEMP=$P(TEMP,"IN:",2)
 S INFEE=$S(TEMP["FEE":1,1:0)
 S INCEN=$S(TEMP["CEN":1,1:0)
 S IEN="",NFOUND=0
 F  S IEN=$O(^DGPT("B",DFN,IEN)) Q:IEN=""  D
 . S DDATE=+$P($G(^DGPT(IEN,70)),U,1)
 . I DDATE>0,DDATE'<BDT,DDATE'>EDT S NFOUND=NFOUND+1,DDATEL(DDATE,NFOUND)=^DGPT(IEN,0)
 I NFOUND=0 Q
 S SDIR=$S(NGET<0:1,1:-1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 S (DONE,NF)=0
 S DDATE=""
 F IND=1:1:NFOUND Q:DONE  D
 . S DDATE=$O(DDATEL(DDATE),SDIR)
 . I DDATE="" S DONE=1 Q
 . S IEN=0
 . F  S IEN=$O(DDATEL(DDATE,IEN)) Q:(IEN="")!(DONE)  D
 .. S FEEBASIS=$P(DDATEL(DDATE,IEN),U,4)
 .. I FEEBASIS=1,'INFEE Q
 ..;Type 1 is PTF, Type 2 is Census
 .. S TYPE=$P(DDATEL(DDATE,IEN),U,11)
 .. I TYPE=2,'INCEN Q
 .. S NF=NF+1
 .. S TEST(NF)=1,(DATE(NF),VALUE(NF))=DDATE
 .. I FEEBASIS=1 S TEXT(NF)="Fee basis"
 .. I TYPE=2 S TEXT(NF)="Census"
 .. I NF=NGET S DONE=1
 S NFOUND=NF
 Q
 ;
 ;======================================================
INP(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;Computed finding for
 ;determining if a patient is an inpatient on the evaluation date.
 N VAIN,VAINDT
 S NFOUND=1
 S (DATE(1),VAINDT)=$$NOW^PXRMDATE
 D INP^VADPT
 I VAIN(1)="" S TEST(1)=0 D KVA^VADPT Q
 S TEST(1)=1
 S VALUE(1,"PRIMARY PROVIDER")=$P(VAIN(2),U,2)
 S VALUE(1,"TREATING SPECIALTY")=$P(VAIN(3),U,2)
 S VALUE(1,"WARD LOCATION")=$P(VAIN(4),U,2)
 S VALUE(1,"ADMISSION DATE/TIME")=$P(VAIN(7),U,1)
 S VALUE(1,"ADMISSION TYPE")=$P(VAIN(8),U,2)
 S VALUE(1,"ATTENDING PHYSICIAN")=$P(VAIN(11),U,2)
 S TEXT(1)="Patient is an inpatient; admission date/time: "_$$FMTE^XLFDT(VALUE(1,"ADMISSION DATE/TIME"),"5Z")
 D KVA^VADPT
 Q
 ;
 ;======================================================
NEWRACE(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;Computed finding
 ;for returning a patient's multi-valued race.
 N IND,VADM
 D DEM^VADPT
 S NFOUND=VADM(12)
 I NFOUND=0 D KVA^VADPT Q
 S NGET=$S(NGET<0:-NGET,1:NGET)
 I NFOUND>NGET S NFOUND=NGET
 F IND=1:1:NFOUND D
 . S TEST(IND)=1,DATE(IND)=$$NOW^PXRMDATE,TEXT(IND)=""
 . S (VALUE(IND,"VALUE"),VALUE(IND,"RACE"))=$P(VADM(12,IND),U,2)
 D KVA^VADPT
 Q
 ;
 ;======================================================
PATTYPE(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding to return the patient
 ;type
 N VAEL
 S VALUE=""
 S DATE=$$NOW^PXRMDATE
 D ELIG^VADPT
 S TEST=$S($G(VAEL(6))'="":1,1:0)
 S VALUE=$P(VAEL(6),U,2)
 D KVA^VADPT
 Q
 ;
 ;======================================================
RACE(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for checking a patient's race.
 N RACE
 S DATE=$$NOW^PXRMDATE
 ;DBIA #10035
 S RACE=$P($G(^DPT(DFN,0)),U,6)
 I RACE="" S TEST=0,VALUE="" Q
 Q
 ;
 ;======================================================
SEX(DFN,TEST,DATE,VALUE,TEXT) ;Computed finding for returning a patient's
 ;sex.
 S DATE=$$NOW^PXRMDATE,TEST=1
 I $D(PXRMPDEM) S VALUE=PXRMPDEM("SEX") Q
 ;DBIA #10035 SEX is a required field.
 I '$D(PXRMPDEM) S VALUE=$P(^DPT(DFN,0),U,2)
 Q
 ;
 ;======================================================
WASINP(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,VALUE,TEXT) ;Computed finding for
 ;determining if a patient was an inpatient in the period defined
 ;by BDT and EDT.
 ;Access to DGPM covered by DBIA #1378
 N ADATE,ADM,ADML,AWARD,DDATE,DWARD,IEN,INDT,FDATE,LOS,NOCC,SDIR,TEMP
 S FDATE=$S(TEST="DISCH":"DISCH",1:"ADM")
 S SDIR=$S(NGET<0:1,1:-1)
 S NOCC=$S(NGET<0:-NGET,1:NGET)
 S NFOUND=0
 ;Use the "ATID3" index to build a last of past admissions and
 ;discharges.
 S INDT=""
 F  S INDT=$O(^DGPM("ATID3",DFN,INDT)) Q:INDT=""  D
 . S IEN=$O(^DGPM("ATID3",DFN,INDT,""))
 . S TEMP=^DGPM(IEN,0)
 . S DDATE=$P(TEMP,U,1)
 . S ADM=$P(TEMP,U,14)
 . S ADATE=$P(^DGPM(ADM,0),U,1)
 . I $$OVERLAP^PXRMINDX(ADATE,DDATE,BDT,EDT)'="O" Q
 . S AWARD=$$GET1^DIQ(405,ADM,.06),DWARD=$$GET1^DIQ(405,IEN,200)
 . S ADML(ADATE)=DDATE_U_AWARD_U_DWARD
 ;Check for the last admission and add it if it is not on the list.
 S INDT=$O(^DGPM("ATID1",DFN,""))
 I INDT'="" D
 . S IEN=$O(^DGPM("ATID1",DFN,INDT,""))
 . S TEMP=^DGPM(IEN,0)
 . S ADATE=$P(TEMP,U,1),AWARD=$$GET1^DIQ(405,IEN,.06)
 . I $D(ADML(ADATE)) Q
 . S IEN=$P(TEMP,U,17)
 .;Since this is the last admission there may not be a discharge.
 . S DDATE=$S(IEN="":$$NOW^PXRMDATE,1:$P(^DGPM(IEN,0),U,1))
 . I $$OVERLAP^PXRMINDX(ADATE,DDATE,BDT,EDT)="O" D
 .. S DWARD=$S(IEN="":"",1:$$GET1^DIQ(405,IEN,200))
 .. S ADML(ADATE)=DDATE_U_AWARD_U_DWARD
 ;Sort the list.
 S ADATE=""
 F  S ADATE=$O(ADML(ADATE),SDIR) Q:(NFOUND=NOCC)!(ADATE="")  D
 . S NFOUND=NFOUND+1,TEST(NFOUND)=1
 . S DDATE=$P(ADML(ADATE),U,1),AWARD=$P(ADML(ADATE),U,2),DWARD=$P(ADML(ADATE),U,3)
 . I DDATE="" S DDATE=PXRMDATE
 . S DATE(NFOUND)=$S(FDATE="DISCH":DDATE,1:ADATE)
 . S LOS=$$FMDIFF^XLFDT(DDATE,ADATE)
 . S TEMP="Inpatient from: "_$$FMTE^XLFDT(ADATE,"5Z")_" to "
 . S TEMP=TEMP_$S(DDATE=PXRMDATE:"now",1:$$FMTE^XLFDT(DDATE,"5Z"))
 . S TEMP=TEMP_"; Length of stay "_LOS_" days"
 . S TEMP=TEMP_"; Admission ward: "_AWARD
 . I DWARD'="" S TEMP=TEMP_"; Discharge ward: "_DWARD
 . S TEXT(NFOUND)=TEMP
 . S VALUE(NFOUND,"ADMISSION DATE")=ADATE
 . S VALUE(NFOUND,"ADMISSION WARD")=AWARD
 . S VALUE(NFOUND,"DISCHARGE DATE")=DDATE
 . S VALUE(NFOUND,"DISCHARGE WARD")=DWARD
 . S VALUE(NFOUND,"LENGTH OF STAY")=LOS
 Q
 ;
