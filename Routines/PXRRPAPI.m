PXRRPAPI ;ISL/PKR - Build the patient specific info for each patient on the list. ;6/27/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**18,121,165**;Aug 12, 1996
 ;
PAT ;
 N ACTIVITY,BACDATE,BD,BUSY,DATE,DFN,EACDATE,ED,ERIEN,ERR
 N IC,IEN,JC,FACIEN,FACNAM
 N HLOCIEN,HLOCNAM,LABTEST,LOCIEN,LRDFN,NERM
 N PNAME,SPEC,SSN,SSNF,UNITS
 N TEMP
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 S BACDATE=PXRRBCDT-.0001
 S EACDATE=PXRRECDT+.2359
 ;
 ;Build a list of emergency room iens, get list from PCE parameter file.
 S NERM=0
 S IC=0
 F  S IC=$O(^PX(815,IC)) Q:+IC=0  D
 . S JC=0
 . F  S JC=$O(^PX(815,IC,"RR1",JC)) Q:+JC=0  D
 .. S NERM=NERM+1
 .. S TEMP=^PX(815,IC,"RR1",JC,0)
 .. S ERIEN(NERM)=TEMP_U_$P(^SC(TEMP,0),U,1)
 ;
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 S FACIEN=""
NFAC1 S FACIEN=$O(^XTMP(PXRRXTMP,"APPT",FACIEN))
 I +FACIEN=0 G DONE
 ;
 S HLOCIEN=""
NHLOC1 S HLOCIEN=$O(^XTMP(PXRRXTMP,"APPT",FACIEN,HLOCIEN))
 I +HLOCIEN=0 G NFAC1
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRGUT
 ;
 S DFN=0
NPAT S DFN=$O(^XTMP(PXRRXTMP,"APPT",FACIEN,HLOCIEN,DFN))
 I +DFN=0 G NHLOC1
 S ACTIVITY=0
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting patient information",.BUSY)
 ;
 ;Emergency room visits.
 I NERM>0 D
 . S BD=BACDATE
 . S ED=EACDATE
 . F  S BD=$O(^AUPNVSIT("AET",DFN,BD)) Q:((BD>EACDATE)!(BD=""))  D
 .. S LOCIEN=""
 .. F  S LOCIEN=$O(^AUPNVSIT("AET",DFN,BD,LOCIEN)) Q:LOCIEN=""  D
 ... F IC=1:1:NERM  D
 .... I $P(ERIEN(IC),U,1)=LOCIEN D
 ..... S ^TMP(PXRRXTMP,$J,"ER",DFN,BD)=ERIEN(IC)
 . I $D(^TMP(PXRRXTMP,$J,"ER",DFN)) S ACTIVITY=1
 ;
 ;Build a list of future appointments.
 D KVA^VADPT
 S VASD("F")=PXRRBFDT
 S VASD("T")=PXRREFDT
 D SDA^VADPT
 S IC=0
 F  S IC=$O(^UTILITY("VASD",$J,IC)) Q:+IC=0  D
 . S ^TMP(PXRRXTMP,$J,"FUT",DFN,IC)=^UTILITY("VASD",$J,IC,"E")
 K ^UTILITY("VASD",$J)
 D KVA^VADPT
 I $D(^TMP(PXRRXTMP,$J,"FUT",DFN)) S ACTIVITY=1
 ;
 ;Save all admissions and discharges in the date range.
 ;We will need a DBIA to use the cross-ref.  Numerous similar
 ;ones are already in place, i.e.,  DBIA244-D, DBIA325-B, DBIA966, DBIA1358.
 S BD=BACDATE
 S ED=EACDATE
NADM S BD=$O(^DGPM("APTT1",DFN,BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G DIS
 S IEN=$O(^DGPM("APTT1",DFN,BD,""))
 S ^TMP(PXRRXTMP,$J,"ADM",DFN,BD,IEN)=""
 G NADM
 I $D(^TMP(PXRRXTMP,$J,"ADM",DFN)) S ACTIVITY=1
 ;
DIS S BD=BACDATE
 S ED=EACDATE
NDIS S BD=$O(^DGPM("APTT3",DFN,BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G CLAB
 S IEN=$O(^DGPM("APTT3",DFN,BD,""))
 S ^TMP(PXRRXTMP,$J,"DIS",DFN,BD,IEN)=""
 G NDIS
 I $D(^TMP(PXRRXTMP,$J,"DIS",DFN)) S ACTIVITY=1
 ;
 ;Get critical lab values.
 ;This will probably require a DBIA to read DPT.
 ;We will need a DBIA to look at lab stuff.
CLAB S LRDFN=$G(^DPT(DFN,"LR"))
 I LRDFN="" G SAVPAT
 S ED=$$FMDFINVL(BACDATE,0)
 S BD=$$FMDFINVL(EACDATE,0)
NLAB S BD=$O(^LR(LRDFN,"CH",BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G SAVPAT
 S IC=0
 F  S IC=$O(^LR(LRDFN,"CH",BD,IC)) Q:+IC=0  D
 . S TEMP=$G(^LR(LRDFN,"CH",BD,IC))
 . I $P(TEMP,U,2)["*" D
 .. D FIELD^DID(63.04,IC,"","LABEL","LABTEST","ERR")
 ..;Try to get the units.
 .. S SPEC=$P(^LR(LRDFN,"CH",BD,0),U,5)
 .. S JC=$O(^LAB(60,"C","CH;"_IC_";1",""))
 .. S UNITS=$P($G(^LAB(60,JC,1,SPEC,0)),U,7)
 .. S ^TMP(PXRRXTMP,$J,"CLAB",DFN,BD,IC)=LABTEST("LABEL")_U_TEMP_U_UNITS
 G NLAB
 I $D(^TMP(PXRRXTMP,$J,"CLAB",DFN)) S ACTIVITY=1
 ;
SAVPAT ;Save the patient data in XTMP in a format suitable for printing.
 ;We only want those patients that had some activity.
 I 'ACTIVITY G NPAT
 S TEMP=$G(^DPT(DFN,0))
 S PNAME=$P(TEMP,U,1)
 S SSN=$P(TEMP,U,9)
 S FACNAM=PXRRFACN(FACIEN)_U_FACIEN
 S HLOCNAM=$P($G(^SC(HLOCIEN,0)),U,1)
 S ^XTMP(PXRRXTMP,"ALPHA",FACNAM,HLOCNAM_U_HLOCIEN,PNAME,SSN)=DFN
 D KVA^VADPT
 D ADD^VADPT
 S SSNF=$$SSNFORM(SSN)
 S ^XTMP(PXRRXTMP,"PATIENT",DFN)=SSNF_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_VAPA(5)_U_VAPA(6)_U_VAPA(8)
 D KVA^VADPT
 ;
 ;Appointment data.
 S IC=0
 F  S IC=$O(^XTMP(PXRRXTMP,"APPT",FACIEN,HLOCIEN,DFN,IC)) Q:+IC=0  D
 . S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"APPT",IC)=^XTMP(PXRRXTMP,"APPT",FACIEN,HLOCIEN,DFN,IC)
 ;
 ;Process admission data, build a complete entry including discharge
 ;date, last treating specialty, last provider, admitting diagnosis.
 S IC=0
 F  S IC=$O(^TMP(PXRRXTMP,$J,"ADM",DFN,IC)) Q:+IC=0  D
 . S IEN=$O(^TMP(PXRRXTMP,$J,"ADM",DFN,IC,""))
 . D ADMISS(DFN,IC,IEN)
 ;
 ;Process discharge admission data, build a complete entry just as for
 ;admissions above.  Match the discharge to the admission, avoiding
 ;duplicate entries.
 S IC=0
 F  S IC=$O(^TMP(PXRRXTMP,$J,"DIS",DFN,IC)) Q:+IC=0  D
 . S IEN=$O(^TMP(PXRRXTMP,$J,"DIS",DFN,IC,""))
 . D DISCHRG(DFN,IC,IEN)
 ;
 ;Look for any current inpatient data whose admission we may have
 ;missed.
 I '$D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS")) D
 . D KVA^VADPT
 . D IN5^VADPT
 . I $L(VAIP(13))>0 D
 .. S DATE=$P(VAIP(13,1),U,1)
 ..;The admission date must be less than the beginning activity date
 ..;in order for the patient to be an inpatient during the activity
 ..;date range.
 .. I DATE<PXRRBCDT D
 ...;Ward
 ... S TEMP=$P(VAIP(14,4),U,2)
 ...;Last treating specialty
 ... S TEMP=TEMP_U_$P(VAIP(14,6),U,2)
 ... ;Last provider
 ... S TEMP=TEMP_U_$P(VAIP(14,5),U,2)
 ...;Admitting diagnosis
 ... S TEMP=TEMP_U_VAIP(13,7)
 ... S DISDATE=DT+1
 ... S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",DATE,DISDATE)=TEMP
 ;
 ;Critical lab data.
 S IC=0
 F  S IC=$O(^TMP(PXRRXTMP,$J,"CLAB",DFN,IC)) Q:+IC=0  D
 . S TEMP=$$FMDFINVL(IC,1)
 . S JC=0
 . F  S JC=$O(^TMP(PXRRXTMP,$J,"CLAB",DFN,IC,JC)) Q:+JC=0  D
 .. S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"CLAB",TEMP,JC)=^TMP(PXRRXTMP,$J,"CLAB",DFN,IC,JC)
 ;
 ;Emergency room visits.
 S IC=0
 F  S IC=$O(^TMP(PXRRXTMP,$J,"ER",DFN,IC)) Q:+IC=0  D
 . S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ER",IC)=^TMP(PXRRXTMP,$J,"ER",DFN,IC)
 ;
 ;Future appointments.
 S IC=0
 F  S IC=$O(^TMP(PXRRXTMP,$J,"FUT",DFN,IC)) Q:+IC=0  D
 . S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"FUT",IC)=^TMP(PXRRXTMP,$J,"FUT",DFN,IC)
 ;
 G NPAT
DONE ;
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
 ;
EXIT ;
 K ^TMP(PXRRXTMP)
 ;
 ;Print the report.
 I PXRRQUE D 
 .;Start the report that was queued but not scheduled.
 . N DESC,ROUTINE,TASK
 . S DESC="Patient Activity Report - print"
 . S ROUTINE="PXRRPAPR"
 . S ZTDTH=$$NOW^XLFDT
 . S TASK=^XTMP(PXRRXTMP,"PRZTSK")
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D ^PXRRPAPR
 Q
 ;
 ;=======================================================================
ADMISS(DFN,DATE,IEN) ;Given a patient and an admission date find the
 ;associated discharge, if any.  Save the other information listed
 ;below.
 N DISDATE,TEMP
 D KVA^VADPT
 S VAIP("D")=DATE
 S VAIP("E")=IEN
 S VAIP("M")=0
 D IN5^VADPT
 ;Store the information in TEMP in printing order.
 ;Ward
 S TEMP=$P(VAIP(14,4),U,2)
 ;Last treating specialty
 S TEMP=TEMP_U_$P(VAIP(14,6),U,2)
 ;Last provider
 S TEMP=TEMP_U_$P(VAIP(14,5),U,2)
 ;Admitting diagnosis
 S TEMP=TEMP_U_VAIP(13,7)
 I $L(VAIP(17))>0 D
 . S DISDATE=$P(VAIP(17,1),U,1)
 E  D
 . S DISDATE=DT+1
 S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",DATE,DISDATE)=TEMP
 ;
ADMDONE ;
 D KVA^VADPT
 Q
 ;
 ;=======================================================================
DISCHRG(DFN,DATE,IEN) ;Given a patient and a discharge date find the
 ;associated admission.  Determine if the combined admission-discharge
 ;data has already been stored.  If it has quit otherwise store it.
 N ADMDATE,ICD9IEN,TEMP
 D KVA^VADPT
 S VAIP("D")=$P(DATE,".",1)
 S VAIP("E")=IEN
 S VAIP("M")=0
 D IN5^VADPT
 S ADMDATE=$P(VAIP(13,1),U,1)
 I ADMDATE="" S ADMDATE=DATE_"NA"
 I $D(^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",ADMDATE,DATE)) G DISDONE
 ;Information is not already there, store the data.
 ;Ward
 S TEMP=""
 ;Last treating specialty
 S TEMP=TEMP_U_$P(VAIP(17,6),U,2)
 ;Last provider
 S TEMP=TEMP_U_$P(VAIP(17,5),U,2)
 ;Admitting diagnosis
 S TEMP=TEMP_U_VAIP(13,7)
 ;Will need a DBIA for these reads.
 ;Try to get DXLS
 I +VAIP(12)>0 S ICD9IEN=$P($G(^DGPT(VAIP(12),70)),U,10)
 ;I +$G(ICD9IEN)>0 S TEMP=TEMP_U_$P(^ICD9(ICD9IEN,0),U,3)
 I +$G(ICD9IEN)>0 S TEMP=TEMP_U_$P($$ICDDX^ICDCODE(ICD9IEN),U,4)
 ;
 S ^XTMP(PXRRXTMP,FACIEN,HLOCIEN,DFN,"ADMDIS",ADMDATE,DATE)=TEMP
DISDONE ;
 D KVA^VADPT
 Q
 ;
 ;=======================================================================
SSNFORM(SSN) ;Format the social security number with dashes.
 N FSSN,TEMP
 S TEMP=$E(SSN,1,3)
 S FSSN=TEMP_"-"
 S TEMP=$E(SSN,4,5)
 S FSSN=FSSN_TEMP_"-"
 S TEMP=$E(SSN,6,9)
 S FSSN=FSSN_TEMP
 Q FSSN
 ;
 ;=======================================================================
FMDFINVL(INVDT,DATE) ;Convert an inverse date (LABORATORY format
 ;9999999-date) to Fileman format.
 I $L(INVDT)=0 Q INVDT
 N TEMP
 S TEMP=9999999-INVDT
 ;If DATE is TRUE return only the date portion.
 I DATE S TEMP=$P(TEMP,".",1)
 Q TEMP
 ;
