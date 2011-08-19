PXRRWLS2 ;ISA/Zoltan - Sort encounters for encounter summary report.;12/1/1998
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**58,61,133**;Aug 12, 1996
 ;
 ; Code migrated from PXRRWLSE.
 ;
 ; Part 1:  migrated code.
SORT2 ; Migrated from PXRRWLSE
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 ;Location is true if we are screening by location.
 I $P(PXRRWLSC,U,1)="L" D
 . S LOCATION=1
 . S ^XTMP(PXRRXTMP,"STOIND","LOCATION")=""
 E  S LOCATION=0
 ;
 ;CSSCR is true if we want selected clinics.
 I $P($G(PXRRLCSC),U,1)="CS" S CSSCR=1
 E  S CSSCR=0
 ;
 ;CLINIC is true if we want clinics instead of hospital locations.
 I $P($G(PXRRLCSC),U,1)["C" D
 . S CLINIC=1
 . S BYCLOC=$S($P(PXRRLCSC,U,3):1,1:0)
 E  D
 . S CLINIC=0
 . S BYCLOC=0
 ;
 ;HSSCR is true if we want selected hospital locations.
 I $P($G(PXRRLCSC),U,1)="HS" S HSSCR=1
 E  S HSSCR=0
 ;
 ;PROVIDER is true if we select by provider.
 I $P($G(PXRRWLSC),U,1)="P" D
 . S PROVIDER=1
 . S ^XTMP(PXRRXTMP,"STOIND","PROVIDER")=""
 E  S PROVIDER=0
 ;
 ;PRVSCR is true if we have selected providers.
 I $D(NPL) S PRVSCR=1
 E  S PRVSCR=0
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 Q
 ;
VISIT2 ; Migrated from PXRRWLSE
 ;Clinic screen.
 I CSSCR D
 . S FOUND=0
 . S CLINIEN=$P(VISIT,U,8)
 . F IC=1:1:NCS I $P(PXRRCS(IC),U,2)=CLINIEN D  Q
 ..;Mark the clinic as being matched.
 .. S $P(PXRRCS(IC),U,4)="M"
 .. S HLOCNAM=$P(^DIC(40.7,CLINIEN,0),U,1)_U_CLINIEN
 .. S FOUND=1
 ;
 ;Hospital location screen.
 I HSSCR D
 . S FOUND=0
 . S HLOCIEN=$P(VISIT,U,22)
 . F IC=1:1:NHL I $P(PXRRLCHL(IC),U,2)=HLOCIEN D  Q
 ..;Mark the hospital location as being matched.
 .. S $P(PXRRLCHL(IC),U,4)="M"
 .. S CLINIEN=$P(^SC(HLOCIEN,0),U,7)
 .. S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)_U_HLOCIEN
 .. S FOUND=1
 Q
 ;
PRV2 ; Migrated from PXRRWLSE
 ;At this point we have an encounter that can be added to the list.
 ;
 ;Get the hospital location or clinic and stop code.
 I $L(HLOCNAM)'>0 D
 . I 'CLINIC D
 .. ;Get the hospital location.
 .. S HLOCIEN=$P(VISIT,U,22)
 .. I HLOCIEN>0 D
 ... S HLOCNAM=$P(^SC(HLOCIEN,0),U,1)_U_HLOCIEN
 ... S CLINIEN=$P(^SC(HLOCIEN,0),U,7)
 .. E  D
 ...;No hospital location, see if we can at least find the clinic.
 ... S HLOCNAM="Unknown"
 ... S CLINIEN=$P(VISIT,U,8)
 . E  D
 .. ;Get the clinic.
 .. S CLINIEN=$P(VISIT,U,8)
 .. I CLINIEN="" S CLINIEN=0
 .. I CLINIEN,$D(^DIC(40.7,CLINIEN,0))[0 S CLINIEN=0
 .. I CLINIEN>0 S HLOCNAM=$P(^DIC(40.7,CLINIEN,0),U,1)_U_CLINIEN
 .. E  S HLOCNAM="Unknown"
 ;
 ;Append the clinic stop code.
 I CLINIEN>0 S HLOCNAM=HLOCNAM_U_$P(^DIC(40.7,CLINIEN,0),U,2)
 ;
 I LOCATION S STOIND=HLOCNAM
 ;Make sure that all providers are stored with the person class.
 I PROVIDER D
 . I $P(PPNAME,U,3)="" D
 .. S PCLASS=$$OCCUP^PXBGPRV(NEWPIEN,BD,"",1,"")
 .. S PPNAME=PPNAME_U_$P(PCLASS,U,7)
 . S STOIND=PPNAME_U
 . I PXRRPRLL S STOIND=STOIND_HLOCNAM
 ;
 ;Save the patient information.
 S TEMP=^AUPNVSIT(VIEN,0)
 S DATE=$P(TEMP,U,1)
 S DAY=$P(DATE,".",1)
 S DFN=$P(TEMP,U,5)
 ;Get the patient status, 1 is in, 0 is out.
 S INOUT=$P(VISIT150,U,2)
 I $L(INOUT)=0 S INOUT=-1
 Q
 ;
GC2 ; Migrated from PXRRWLSE
 S CPT=$P(^AUPNVCPT(IC,0),U,1)
 I +CPT'>0 D
 . W !,"WARNING AUPNVCPT IS CORRUPTED! ENTRY ",IC," does not have a CPT code."
 . S CPT=0
 E  D
 . S EM=$P($G(^IBE(357.69,CPT,0)),U,5)
 . I EM="" S EM=0
 ;
 ;Increment the CPT and E&M counts.
 S ^XTMP(PXRRXTMP,FACILITY,STOIND,"CPT")=$G(^XTMP(PXRRXTMP,FACILITY,STOIND,"CPT"))+1
 S ^XTMP(PXRRXTMP,FACILITY,STOIND,"EM",EM)=$G(^XTMP(PXRRXTMP,FACILITY,STOIND,"EM",EM))+1
 ;Calculate totals by facility for multiple provider encounters.
 I MULTPR=1 D
 . D FTOT(FACILITY,"&&","CPT")
 . D FTOT1(FACILITY,"&&","EM",EM)
 Q
 ;
 ;Totals for multiple provider encounters - used in PXRRWLPR.
FTOT(FL,FLD,FL1) ;
 S ^XTMP(PXRRXTMP,FL,FLD,FL1)=$G(^XTMP(PXRRXTMP,FL,FLD,FL1))+1
 Q
FTOT1(FL,FLD,FL1,FL2) ;
 S ^XTMP(PXRRXTMP,FL,FLD,FL1,FL2)=$G(^XTMP(PXRRXTMP,FL,FLD,FL1,FL2))+1
 Q
 ;
NF2 ; Migrated from PXRRWLSE
 ;Count the total unique patients and visits at the facility.
 S TOTUNIQ=0
 S TOTVIS=0
 S VISITS(0)=0
 S VISITS(1)=0
 S DFN=0
 F  S DFN=$O(^TMP(PXRRXTMP,$J,FACILITY,"&","PATIENT",DFN)) Q:DFN=""  D
 . S TOTUNIQ=TOTUNIQ+1
 . S DAY=""
 . F  S DAY=$O(^TMP(PXRRXTMP,$J,FACILITY,"&","PATIENT",DFN,DAY)) Q:DAY=""  D
 .. S TOTVIS=TOTVIS+1
 .. S INOUT=-1
 .. F  S INOUT=$O(^TMP(PXRRXTMP,$J,FACILITY,"&","PATIENT",DFN,DAY,INOUT)) Q:INOUT=""  D
 ... S VISITS(INOUT)=VISITS(INOUT)+1
 S ^XTMP(PXRRXTMP,FACILITY,"&","TOTUNIQ")=TOTUNIQ
 S ^XTMP(PXRRXTMP,FACILITY,"&","TOTVIS")=TOTVIS
 S ^XTMP(PXRRXTMP,FACILITY,"&","TOTINOUT",0)=VISITS(0)
 S ^XTMP(PXRRXTMP,FACILITY,"&","TOTINOUT",1)=VISITS(1)
 Q
 ;
CLOC2 ; Migrated from PXRRWLSE
 ;Save this to count the total number of unique patients and
 ;the total unique in/out patient encounters.
 S ^TMP(PXRRXTMP,$J,FACILITY,"&","PATIENT",DFN,DAY,INOUT)=""
 ;
 ;Save this to count the unique in/out patient encounters.
 S ^TMP(PXRRXTMP,$J,FACILITY,STOIND,"PATIENT",DFN,DAY,INOUT)=""
 ;
 ;Save this information so we can search for appointments in PXRRWLSA.
 S ^XTMP(PXRRXTMP,FACILITY,STOIND,"PATIENT",DFN,DATE,VIEN)=MULTPR
 ;
 ;Increment the encounter count.
 S ^XTMP(PXRRXTMP,FACILITY,STOIND,"TOTENC")=$G(^XTMP(PXRRXTMP,FACILITY,STOIND,"TOTENC"))+1
 ;
 ;Calculate totals by facility for multiple provider encounters.
 I MULTPR=1 D FTOT(FACILITY,"&&","TOTENC")
 Q
