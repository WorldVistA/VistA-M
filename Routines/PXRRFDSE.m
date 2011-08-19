PXRRFDSE ;ISL/PKR - Sort through encounters applying the selection criteria. ;3/11/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,31,49**;Aug 12, 1996
SORT ;
 N BD,BUSY,CLASSIEN,CLASSNAM,CLINIC,CLINIEN,CSSCR,DOB,DFN,ED
 N IC,FAC,FACILITY,FOUND
 N HLOC,HLOCIEN,HLOCNAM,HSSCR,NEWPIEN
 N PATSCR,PCLASS,PNAME,PPONLY,PRVIEN,PRVALL,PRVSCR
 N RACEUNK,TEMP,VIEN,VISIT
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 ;CSSCR is true if we want selected clinics.
 I $G(NCS)>0 S CSSCR=1
 E  S CSSCR=0,CLINIC=0
 ;
 ;CLINIC is true if we want clinics instead of hospital locations.
 I $P($G(PXRRLCSC),U,1)["C" S CLINIC=1
 E  S CLINIC=0
 ;
 ;HSSCR is true if we want selected hospital locations.
 I $P($G(PXRRLCSC),U,1)="HS" S HSSCR=1
 E  S HSSCR=0
 ;
 ;HLOC is true if we want hospital locations.
 I $P($G(PXRRLCSC),U,1)["H" S HLOC=1
 E  S HLOC=0
 ;
 ;PATSCR is true if we have a patient screen.
 S PATSCR=0
 I $D(PXRRDOB) D
 . S PATSCR=1
 .;If the starting or ending date of birth is not defined at this point
 .;then we should not screen for them.  So set them to values that will
 .;always be true.  Remember the test is DOBS <= DOB <= DOBE so that
 .;DOBS corresponds to the maximum age and DOBE to the minimum age.
 . I '$D(PXRRDOBS) S PXRRDOBS=0
 . I '$D(PXRRDOBE) S PXRRDOBE=DT
 I $D(PXRRRACE) D
 . S PATSCR=1
 .;Find the "UNKNOWN" race entry.
 . N TRACE,TERR
 . D FIND^DIC(10,"","","O","UNKNOWN",1,"B","","","TRACE","TERR")
 . S RACEUNK=TRACE("DILIST",2,1)_U_TRACE("DILIST",1,1)
 I $D(PXRRSEX) S PATSCR=1
 ;
 ;PRVSCR is true if we have a provider screen
 I $D(PXRRPRSC) S PRVSCR=1
 E  S CLASSNAM=0,PRVSCR=0,PNAME=1
 ;
 ;If they are asking for all providers then we don't really need to
 ; screen.
 ;I PRVSCR I $P(PXRRPRSC,U,1)="A" S CLASSNAM=0,PRVSCR=0,PNAME=1
 ;See if all providers were requested.
 I PRVSCR I $P(PXRRPRSC,U,1)="A" S PRVALL=1
 E  S PRVALL=0
 ;
 ;PPONLY is true if we want primary providers only.
 I PRVSCR I $P(PXRRPRSC,U,1)="P" S PPONLY=1
 E  S PPONLY=0
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 S BD=PXRRBDT-.0001
 S ED=PXRREDT+.2359
NDATE S BD=$O(^AUPNVSIT("B",BD))
 ;If we have passed the ending date we are done.
 I (BD>ED)!(BD="") G DONE
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRFDD
 ;
 ;Get the VISIT IEN
 S VIEN=0
VISIT S VIEN=$O(^AUPNVSIT("B",BD,VIEN))
 I VIEN="" G NDATE
 S VISIT=^AUPNVSIT(VIEN,0)
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting encounters",.BUSY)
 ;
 ;Service category screen.
 I $D(PXRRSCAT) I PXRRSCAT'[$P(VISIT,U,7) G VISIT
 ;
 ;Encounter type screen.
 I $D(PXRRETYP) I PXRRETYP'[$P(VISIT,U,3) G VISIT
 ;
 ;Patient screen.  If we have a patient screen then we need to make a
 ;VADPT call to get the patient information.
 I PATSCR D
 . S DFN=$P(VISIT,U,5)
 . D KVAR^VADPT
 . D DEM^VADPT
 ;
 S FOUND=1
 ;
 ;Patient DOB screen.
 I $D(PXRRDOB) D
 . S DOB=$P(VADM(3),U,1)
 . I (DOB<PXRRDOBS)!(DOB>PXRRDOBE) S FOUND=0
 I 'FOUND G VISIT
 ;
 ;Patient RACE screen.
 I $D(PXRRRACE) D
 . S FOUND=0
 . I VADM(8)="" S VADM(8)=RACEUNK
 . F IC=1:1:NRACE Q:FOUND  D
 .. I PXRRRACE(IC)=VADM(8) S FOUND=1
 I 'FOUND G VISIT
 ;
 ;Patient SEX screen.
 I $D(PXRRSEX) D
 . I PXRRSEX'=VADM(5) S FOUND=0
 I 'FOUND G VISIT
 ;
 ;Make sure that the facility is on the list.
 S FOUND=0
 S FAC=$P(VISIT,U,6)
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FAC D  Q
 . S FACILITY=FAC
 . S FOUND=1
 I 'FOUND G VISIT
 ;
 ;Provider screen.
 S PRVIEN=0
PRV ;To allow for encounters without a provider the check for a null PRVIEN
 ;is made after everything else has been done.
 I PRVIEN="" G VISIT
 I PRVSCR D
 . S PRVIEN=$O(^AUPNVPRV("AD",VIEN,PRVIEN))
 . I $L(PRVIEN)>0 S NEWPIEN=$P(^AUPNVPRV(PRVIEN,0),U,1)
 . E  S NEWPIEN=0
 . S (CLASSNAM,PNAME)=1
 S FOUND=1
 ;
 ;All providers by name.
 I PRVALL D
 . S PNAME=$P($G(^VA(200,NEWPIEN,0)),U,1)
 . I $L(PNAME)=0 S PNAME=1
 . E  S PNAME=PNAME_U_NEWPIEN
 ;
 ;List of providers.
 I $D(PXRRPRPL) D
 . S FOUND=0
 . F IC=1:1:NPL I $P(PXRRPRPL(IC),U,2)=NEWPIEN D  Q
 ..;Mark this provider as being found.
 .. S $P(PXRRPRPL(IC),U,4)="M"
 .. S PNAME=$P(PXRRPRPL(IC),U,1,2)
 .. S FOUND=1
 ;
 ;If we are storing provider names, i.e., PNAME'=1, then store the Person
 ;Class alpha abbreviation as the third piece of PNAME.
 I PNAME'=1 D
 . S PCLASS=$$OCCUP^PXBGPRV(NEWPIEN,BD,"",1)
 . S TEMP=$$ALPHA^PXRRPECU(PCLASS)
 . S PNAME=PNAME_U_TEMP
 I 'FOUND G PRV
 ;
 ;Person class screen.
 I $D(PXRRPECL) D
 . S CLASSNAM=$$OCCUP^PXBGPRV(NEWPIEN,BD,"",1,"")
 . S FOUND=$$MATCH^PXRRPECU(CLASSNAM)
 . I FOUND S CLASSNAM=$P(CLASSNAM,U,7)
 I 'FOUND G PRV
 ;
 ;Primary Provider only.
 I PPONLY D
 . S FOUND=0
 . I PRVIEN>0 D
 .. I $P(^AUPNVPRV(PRVIEN,0),U,4)="P" S FOUND=1
 I 'FOUND G PRV
 ;
 S HLOCNAM=1
 ;By Clinic
 I CLINIC D
 . S CLINIEN=$P(VISIT,U,8)
 . S TEMP=$S(+CLINIEN>0:^DIC(40.7,CLINIEN,0),1:"Unknown")
 . S HLOCNAM=$P(TEMP,U,1)_U_CLINIEN_U_$P(TEMP,U,2)
 ;Clinic screen.
 I CSSCR D
 . S FOUND=0
 . F IC=1:1:NCS I $P(PXRRCS(IC),U,2)=CLINIEN D  Q
 ..;Mark the clinic as being matched.
 .. S $P(PXRRCS(IC),U,4)="M"
 .. S FOUND=1
 I 'FOUND G VISIT
 ;
 ;By hospital location.
 I HLOC D
 . S HLOCIEN=$P(VISIT,U,22)
 . I +HLOCIEN>0 D
 .. S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)_U_HLOCIEN
 .. S CLINIEN=$P(^SC(HLOCIEN,0),U,7)
 .. S TEMP=$S(+CLINIEN>0:^DIC(40.7,CLINIEN,0),1:"")
 .. S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)_U_HLOCIEN_U_$P(TEMP,U,2)
 . E  D
 ..;No hospital location, see if we can at least find the clinic.
 .. S HLOCNAM="Unknown"
 .. S CLINIEN=$P(VISIT,U,8)
 .. S TEMP=$S(+CLINIEN>0:^DIC(40.7,CLINIEN,0),1:"")
 .. S HLOCNAM="Unknown"_U_U_$P(TEMP,U,2)
 ;Hospital location screen.
 I HSSCR D
 . S FOUND=0
 . F IC=1:1:NHL I $P(PXRRLCHL(IC),U,2)=HLOCIEN D  Q
 ..;Mark the hospital location as being matched.
 .. S $P(PXRRLCHL(IC),U,4)="M"
 .. S FOUND=1
 I 'FOUND G VISIT
 ;
 ;At this point we have an encounter that can be added to the list.
 S ^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,CLASSNAM,HLOCNAM,VIEN)=""
 ;
 ;Get the next encounter.
 G VISIT
 ;
DONE ;
 D KVAR^VADPT
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
 ;
 ;If there were selected clinic stops build dummy entries for all
 ;those without entries.
 I $D(PXRRCS) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NCS  D
 ... I $P(PXRRCS(IC),U,4)'="M" D
 .... S PNAME=0
 .... S CLASSNAM=0
 .... S HLOCNAM=PXRRCS(IC)
 .... S ^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,CLASSNAM,HLOCNAM,0)=""
 ;
 ;If there were selected hospital locations build dummy entries for all
 ;those without entries.
 I $D(PXRRLCHL) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NHL  D
 ... I $P(PXRRLCHL(IC),U,4)'="M" D
 .... S PNAME=0
 .... S CLASSNAM=0
 .... S HLOCNAM=PXRRLCHL(IC)
 .... S ^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,CLASSNAM,HLOCNAM,0)=""
 ;
 ;If there were selected providers build dummy entries for all those
 ;without encounters.
 I $D(PXRRPRPL) D
 . N CLASSLST,JC,NPCLASS
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NPL  D
 ... I $P(PXRRPRPL(IC),U,4)'="M" D
 .... S PNAME=$P(PXRRPRPL(IC),U,1,2)
 .... S NEWPIEN=$P(PNAME,U,2)
 ....;Get the person class list for this provider.
 .... S NPCLASS=$$PCLLIST^PXRRPECU(NEWPIEN,PXRRBDT,PXRREDT,.CLASSLST)
 .... F JC=1:1:NPCLASS D
 ..... S TEMP=PNAME_U_CLASSLST(JC)
 ..... S ^XTMP(PXRRXTMP,"ENCTR",FACILITY,TEMP,0,0)=""
 ;
 ;If there were person classes build dummy entries for all those
 ;without entries.
 I $D(PXRRPECL) D
 . F FAC=1:1:NFAC D
 .. S FACILITY=$P(PXRRFAC(FAC),U,1)
 .. F IC=1:1:NCL  D
 ... I $P(PXRRPECL(IC),U,4)'="M" D
 .... S PNAME=0
 .... S CLASSNAM=$P(PXRRPECL(IC),U,1,3)
 .... S HLOCNAM=0
 .... S ^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,CLASSNAM,HLOCNAM,0)=""
 ;
EXIT ;
 ;Run the next task in the series.
 I PXRRQUE D
 . N DESC,ROUTINE,TASK
 . S DESC="Frequency of Diagnosis Report - sort diagnosis data"
 . S ROUTINE="SORT^PXRRFDSD"
 . S TASK=^XTMP(PXRRXTMP,"SORTDZTSK")
 . S ZTDTH=$$NOW^XLFDT
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D SORT^PXRRFDSD
 ;
 Q
