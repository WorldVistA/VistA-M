IBCOMA1 ;ALB/CMS/JNM - IDENTIFY ACTIVE POLICIES W/NO EFFECTIVE DATE (CON'T) ; 09-29-2015
 ;;2.0;INTEGRATED BILLING;**103,516,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
BEG ; Entry to run Active Policies w/no Effective Date Report
 ; Input variables:
 ; IBAIB    - Required.    How to sort
 ;            1= Patient Name Range      2= Terminal Digit Range
 ; IBSIN    - Required.   Include Active Policies with
 ;            1= Verification Date  2= No Verification Date 3= Both
 ;
 ; IBRF     - Required.  Name or Terminal Digit Range Start value
 ; IBRL     - Required.  Name or Terminal Digit Range Go to value
 ; IBBDT    - Optional.  Beginning Verification Date Range
 ; IBEDT    - Optional.  Ending Verification Date Range
 ; IBEXCEL  - 1 = Excel Format
 ;
 ; IB*2*549 - New filter variables
 ; IBPTYPE  - Living/Deceased/Both filter ;
 ; IBAPPTS  - Last Appointment Date Range Start
 ; IBAPPTE  - Last Appointment Date Range End
 ;
 N APPTDATA,CAPPT,CDOD,CGRP,CINS,CLVBY,CLVDAT,CSSN,DFN,IBC,IBC0,IBCDA
 N IBCDA0,IBCDA1,IBI,IBPAGE,IBQUIT,IBTD,IBTMP,IBX,IDX,LASTAPPT,LASTVER
 N LVDATE,MAXGRP,MAXINS,MAXPT,MAXRPT,MAXVERBY,VA,VADM,VAERR,X,Y
 ;
 ; Set starting max field sizes to length of header text
 F IDX=1:1:2 S MAXPT(IDX)=12,MAXINS(IDX)=13,MAXGRP(IDX)=9,MAXVERBY(IDX)=5
 K ^TMP("IBCOMA",$J)
 S IBPAGE=0,IBQUIT=0
 ;
 ; Set up filter data for the call to SDAPI^SDAMA301 for IB*2*549
 I IBAPPTS>0 S APPTDATA(1)=IBAPPTS_";"_IBAPPTE
 S APPTDATA("FLDS")=1                       ; Return Appt Date/Time Data
 S APPTDATA("MAX")=-1                       ; Return Last Appt
 K ^TMP($J,"SDAMA301")
 ;
 S IBC=0 F  S IBC=$O(^DPT("AB",IBC)) Q:'IBC  D
 . S IBC0=$G(^DIC(36,IBC,0))
 . ;
 . ; If company inactive quit
 . Q:$P(IBC0,U,1)=""
 . Q:$P(IBC0,U,5)=1
 . S DFN=0 F  S DFN=$O(^DPT("AB",IBC,DFN)) Q:'DFN  D
 . . K VA,VADM,VAERR
 . . D DEM^VADPT
 . . ;
 . . ; IB*2*549 If Pt. deceased and not showing deceased patients quit 
 . . I IBPTYPE=1,($G(VADM(6))>0) Q
 . . ;
 . . ; IB*2*549 If Pt. not deceased and not showing living patients quit 
 . . I IBPTYPE=2,($G(VADM(6))'>0) Q
 . . S VADM(1)=$P($G(VADM(1)),U,1)
 . . ;
 . . ; I Pt. name out of range quit
 . . Q:VADM(1)=""
 . . I IBAIB=1,VADM(1)]IBRL Q
 . . I IBAIB=1,IBRF]VADM(1) Q
 . . ;
 . . ; I Terminal Digit out of range quit
 . . I IBAIB=2 S IBTD=$$TERMDG^IBCONS2(DFN) S:IBTD="" IBTD="000000000" I (+IBTD>IBRL)!(IBRF>+IBTD) Q
 . . ;
 . . ; Fix subscript error if terminal digit is null
 . . I IBAIB=2,IBTD="" S IBTD=" "
 . . ;
 . . ; IB*2*549 Filter on last appointment date using ICR# 4433
 . . S APPTDATA(4)=DFN
 . . I $$SDAPI^SDAMA301(.APPTDATA)>0 D
 . . . S LASTAPPT=@$Q(^TMP($J,"SDAMA301"))
 . . . K ^TMP($J,"SDAMA301")
 . . E  S LASTAPPT=0 I IBAPPTS>0 Q  ; Filtering on Appt Date but no date in range
 . . ;
 . . S IBCDA=0 F  S IBCDA=$O(^DPT("AB",IBC,DFN,IBCDA)) Q:'IBCDA  D
 . . . ;IB*2.0*516/TAZ - Retrieve data from HIPAA compliant fields.
 . . . ;S IBCDA0=$G(^DPT(DFN,.312,IBCDA,0))  ;516 - baa
 . . . S IBCDA0=$$ZND^IBCNS1(DFN,IBCDA)  ;516 - baa
 . . . ;
 . . . ; I Effective Date populated quit
 . . . Q:$P(IBCDA0,U,8)
 . . . ;
 . . . ; I Expiration Date entered and expired quit
 . . . I $P(IBCDA0,U,4),$P(IBCDA0,U,4)'>DT Q
 . . . ;
 . . . ; Sorting by verification date or no date check
 . . . S IBCDA1=$G(^DPT(DFN,.312,IBCDA,1))
 . . . S LVDATE=+$P($P(IBCDA1,U,3),".",1)
 . . . I IBSIN=1,LVDATE=0 Q
 . . . I IBSIN=1,IBBDT>0,(LVDATE<IBBDT)!(LVDATE>IBEDT) Q
 . . . I IBSIN=2,LVDATE>0 Q
 . . . I IBSIN=3,LVDATE>0,IBBDT>0,(LVDATE<IBBDT)!(LVDATE>IBEDT) Q
 . . . ;
 . . . ; Set data line for global
 . . . ;S IBTMP(1)=PT NAME^SSN^DATE OF DEATH^LAST APPT DATE
 . . . ;S IBTMP(2)=INSURANCE NAME
 . . . ;S IBTMP(3)=VERIFICATION DATE^LAST VERIFIED BY^GROUP NUMBER
 . . . ;
 . . . S IBTMP(1)=VADM(1)_U_$E(VADM(2),6,9)_U_$$FMTE^XLFDT($P(VADM(6),U,1),"2ZD")
 . . . S IBTMP(1)=IBTMP(1)_U_$$FMTE^XLFDT(LASTAPPT,"2ZD")
 . . . S IBTMP(2)=$P(IBC0,U,1)
 . . . S LASTVER=$P(IBCDA1,U,4)
 . . . I LASTVER'="" S LASTVER=$P($G(^VA(200,LASTVER,0)),U)
 . . . S IBTMP(3)=$$FMTE^XLFDT(LVDATE,"2ZD")_U_LASTVER_U_$P(IBCDA0,U,3)
 . . . ;
 . . . ; Set variable IBI for Verified=1 or Non verified=2 
 . . . S IBI=$S(+$P(IBCDA1,U,3):1,1:2)
 . . . I 'IBEXCEL D
 . . . . D SETMAX(VADM(1),.MAXPT,IBI),SETMAX($P(IBC0,U,1),.MAXINS,IBI)
 . . . . D SETMAX(LASTVER,.MAXVERBY,IBI),SETMAX($P(IBCDA0,U,3),.MAXGRP,IBI)
 . . . ;
 . . . ; Set Global array
 . . . S ^TMP("IBCOMA",$J,IBI,$S(IBAIB=2:+IBTD,1:VADM(1)),DFN)=IBTMP(1)
 . . . S ^TMP("IBCOMA",$J,IBI,$S(IBAIB=2:+IBTD,1:VADM(1)),DFN,IBC)=IBTMP(2)
 . . . S ^TMP("IBCOMA",$J,IBI,$S(IBAIB=2:+IBTD,1:VADM(1)),DFN,IBC,IBCDA)=IBTMP(3)
 I 'IBEXCEL D CALCCOLS
 I '$D(^TMP("IBCOMA",$J)) D  G QUEQ
 . D HD(1)
 . W !!,"** NO RECORDS FOUND **"
 . D ASK^IBCOMC2
 D WRT
 W !!,"** END OF REPORT **",!
 ;
QUEQ ; Exit clean-UP
 W !
 D ^%ZISC
 K IBAIB,IBAPPTE,IBAPPTS,IBEXCEL,IBPTYPE,IBRF,IBRL,IBSIN,IBTMP,VA,VADM,VAERR,^TMP("IBCOMA",$J)
 Q
 ;
HD(IBA) ; Write Heading
 ; Input:   IBA         - 1 - Header for non-verified policies
 ;                        2 - Header for verified policies
 ;          CAPPT(IBA)  - Starting Column Position for the 'Last Apt' Column
 ;          CDOD(IBA)   - Starting Column Position for the 'DoD' Column
 ;          CGRP(IBA)   - Starting Column Position for the 'Group No.' Column
 ;          CINS(IBA)   - Starting Column Position for the 'Insurance Co.' Column
 ;          CSSN(IBA)   - Starting Column Position for the 'SSN' Column
 ;          CLVDAT(IBA) - Starting Column Position for the 'Last VC' Column
 ;          CLVBY(IBA)  - Starting Column Position for the 'VC By' Column
 ;          IBPAGE      - Current Page Number
 ;          MAXRPT(IBA) - Maximum number of characters in column header line
 ; Output:  IBPAGE      - Updated Page Number
 ;
 ; IB*2.0*549 changed include Appoint Date filtering and
 ;   dynamic column width based on actual data sizes
 I IBEXCEL D  I 1
 . D PGHD(0)
 . W !!,"Patient Name^SSN^Insurance Co.^Group No.^Last VC^VC By^Last Apt^DoD"
 E  D
 . S IBPAGE=IBPAGE+1
 . D PGHD(IBPAGE)
 . W !!,"Patient Name",?CSSN(IBA),"SSN",?CINS(IBA),"Insurance Co.",?CGRP(IBA),"Group No."
 . I IBA=1 W ?CLVDAT(IBA),"Last VC",?CLVBY(IBA),"VC By"
 . W ?CAPPT(IBA),"Last Apt",?CDOD(IBA),"DoD"
 . W !
 . F IBX=1:1:MAXRPT(IBA) W "="
 Q
 ;
PGHD(IBPAGE) ; Print Report Page Header
 ; Input:   IBPAGE  - Current Page Number, 0 if exporting to Excel
 ;          IBAIB   - 1 Sorting by Patient Name, 2 - Sorting by Terminal Digit
 ;          IBAPPTE - Internal Appointment Date Range End
 ;                    0 if no Appointment Date Range filter
 ;          IBAPPTS - Internal Appointment Date Range Start
 ;                    0 if no Appointment Date Range filter
 ;          IBBDT   - Internal Verification Start date for Verification filter
 ;                    Null if no Verification filter
 ;          IBEDT   - Internal Verification End date for Verification filter
 ;                    Null if no Verification filter
 ;          IBRF    - "A" - First Patient Name, otherwise start of range filter
 ;          IBRL    - End of range filter
 ;
 N IBHDT
 S IBHDT=$$FMTE^XLFDT($$NOW^XLFDT,"Z")
 W:IBPAGE @IOF
 W:'IBPAGE !!
 W "Active Policies with no Effective Date Report "
 I 'IBPAGE D
 . W "          Run On: ",IBHDT
 E  D
 . W ?IOM-34,IBHDT,?IOM-10,"Page: ",IBPAGE
 I IBPAGE W !,?5,"Sorted by: "
 E  W !,?6,"Contains: "
 W $S(IBAIB=1:"Patient Name",1:"Terminal Digit")
 W "  Range: "_$S(IBRF="A":"FIRST",1:IBRF)_" to "_$S(IBRL="zzzzzz":"LAST",1:IBRL)
 I IBBDT>0 D
 . W !,?7,"Include: Verification Date Range: "_$$FMTE^XLFDT(IBBDT,"Z")
 . W " to "_$$FMTE^XLFDT(IBEDT,"Z")
 I IBAPPTS>0 D
 . W !,?7,"Include: Last Appointment Date Range: "_$$FMTE^XLFDT(IBAPPTS,"Z")
 . W " to "_$$FMTE^XLFDT(IBAPPTE,"Z")
 W !,?8,"Filter: "_$S(IBPTYPE=1:"Living Patients",IBPTYPE=2:"Deceased Patients",1:"Both Living & Deceased Patients")
 W ", "_$S(IBSIN=1:"Verified Policies",IBSIN=2:"Non-Verified Policies",1:"Both Verified & Non-Verified Policies")
 Q
 ;
WRT ; Write data lines
 N IBA,IBCDA,IBDA,IBFIRST,IBDFN,IBINS,IBNA,IBPOL,IBPT,X,Y
 S IBQUIT=0,IBFIRST=1
 S IBA=0 F  S IBA=$O(^TMP("IBCOMA",$J,IBA)) Q:('IBA)!(IBQUIT=1)  D
 . I IBPAGE D ASK^IBCOMC2 I IBQUIT=1 Q
 . I IBEXCEL,IBFIRST D
 . . D HD(IBA)
 . . S IBFIRST=0
 . ;
 . I 'IBEXCEL D
 . . D HD(IBA)
 . . W !,$S(IBA=1:"Verified",1:"Non-Verified"),!
 . S IBNA="" F  S IBNA=$O(^TMP("IBCOMA",$J,IBA,IBNA)) Q:(IBNA="")!(IBQUIT=1)  D
 . . S IBDFN=0 F  S IBDFN=$O(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN)) Q:('IBDFN)!(IBQUIT=1)  D
 . . . S IBPT=$G(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN))
 . . . ;
 . . . I 'IBEXCEL,($Y+7)>IOSL D  I IBQUIT=1 Q
 . . . . D ASK^IBCOMC2 I IBQUIT=1 Q
 . . . . D HD(IBA)
 . . . ;
 . . . S IBDA=0 F  S IBDA=$O(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA)) Q:('IBDA)!(IBQUIT=1)  D
 . . . . S IBINS=$G(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA))
 . . . . ;
 . . . . S IBCDA=0 F  S IBCDA=$O(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA,IBCDA)) Q:('IBCDA)!(IBQUIT=1)   D
 . . . . . S IBPOL=$G(^TMP("IBCOMA",$J,IBA,IBNA,IBDFN,IBDA,IBCDA))
 . . . . . I IBEXCEL D  I 1
 . . . . . . W !,$P(IBPT,U,1),U,$P(IBPT,U,2),U,$P(IBINS,U,1),U,$P(IBPOL,U,3),U
 . . . . . . I $P(IBPOL,U,1)'=0 W $P(IBPOL,U,1)
 . . . . . . W U_$P(IBPOL,U,2)_U
 . . . . . . W $P(IBPT,U,4),U,$P(IBPT,U,3)
 . . . . . E  D
 . . . . . . W !,$E($P(IBPT,U,1),1,MAXPT(IBA)),?CSSN(IBA),$P(IBPT,U,2),?CINS(IBA)
 . . . . . . W $E($P(IBINS,U,1),1,MAXINS(IBA)),?CGRP(IBA),$E($P(IBPOL,U,3),1,MAXGRP(IBA))
 . . . . . . I IBA=1 W ?CLVDAT(IBA),$P(IBPOL,U,1),?CLVBY(IBA),$E($P(IBPOL,U,2),1,MAXVERBY(IBA))
 . . . . . . W ?CAPPT(IBA),$P(IBPT,U,4),?CDOD(IBA),$P(IBPT,U,3)
 Q
 ;
SETMAX(NAME,MAX,IBI) ; Get max length of data
 ; Input:   NAME    - Data to get maximum length for
 ;          MAX(IBI)- Current Max length array
 ;          IBI     - Verified or Non-Verified section of the array
 ; Output   MAX(IBI)- Updated Max length array (potentially)
 N LEN
 S LEN=$L(NAME)
 I LEN>MAX(IBI) S MAX(IBI)=LEN
 Q
 ;
CALCCOLS ; Truncates the patient and insurance name field lengths if the total
 ; field lengths will not fit on the report (132 columns)
 ; Input:   MAXGRP(IBA)     - Maximum width of the 'Group No' column for 
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXINS(IBA)     - Current Maximum width of the 'Insurance Co' column for 
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXPT(IBA)      - Current Maximum width of the 'Patient Name' column for
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXVERBY(IBA)   - Maximum width of the 'VC By' column for 
 ;                            verified (IBA=1) policies
 ; Output:  MAXINS(IBA)     - Updated Maximum width of the 'Insurance Co' column for 
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXPT(IBA)      - Updated Maximum width of the 'Patient Name' column for
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 N DIFF,DIFF2,DIFF3,IDX,MAX
 S MAX(1)=89  ; MAX=131 - SSN(4) - 3 Dates(24) - 14 (Spaces between columns)
 S MAX(2)=101 ; MAX=131 - SSN(4) - 2 Dates(16) - 10 (Spaces between columns)
 F IDX=1:1:2 D
 . S DIFF=MAX(IDX)-MAXPT(IDX)-MAXINS(IDX)-MAXGRP(IDX)
 . I IDX=1 S DIFF=DIFF-MAXVERBY(IDX)
 . I DIFF<0 D
 . . S DIFF2=(-DIFF)\2
 . . S DIFF3=(-DIFF)-DIFF2
 . . S MAXPT(IDX)=MAXPT(IDX)-DIFF2
 . . S MAXINS(IDX)=MAXINS(IDX)-DIFF3
 . D SETCOLS(IDX)
 Q
 ;
SETCOLS(IDX) ; Sets the column positions based on maximum data sizes
 ; Input:   IDX             - 1 - Verified policies section of the report
 ;                            2 - Non-Verified policies section of the report
 ;          MAXGRP(IBA)     - Maximum width of the 'Group No' column for 
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXINS(IBA)     - Maximum width of the 'Insurance Co' column for 
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXPT(IBA)      - Maximum width of the 'Patient Name' column for
 ;                            verified (IBA=1) and non-verified (IBA=2) policies
 ;          MAXVERBY(IBA)   - Maximum width of the 'VC By' column for 
 ;                            verified (IBA=1) policies
 ; Output:  CAPPT(IDX)      - Starting Column position for the 'Last Apt'
 ;                            Column for Verified and Non-Verified policies
 ;          CDOD(IDX)       - Starting Column position for the 'DoD'
 ;                            Column for Verified and Non-Verified policies
 ;          CGRP(IDX)       - Starting Column position for the 'Group No'
 ;                            Column for Verified and Non-Verified policies
 ;          CINS(IDX)       - Starting Column position for the 'Insurance Co.'
 ;                            Column for Verified and Non-Verified policies
 ;          CLVBY(IDX)      - Starting Column position for the 'VC By'
 ;                            Column for Verified and Non-Verified policies
 ;          CLVDAT(IDX)     - Starting Column position for the 'Last VC'
 ;                            Column for Verified and Non-Verified policies
 ;          CSSN(IDX)       - Starting Column position for the 'SSN'
 ;                            Column for Verified and Non-Verified policies
 S CSSN(IDX)=MAXPT(IDX)+2
 S CINS(IDX)=CSSN(IDX)+6
 S CGRP(IDX)=CINS(IDX)+MAXINS(IDX)+2
 I IDX=1 D
 . S CLVDAT(IDX)=CGRP(IDX)+MAXGRP(IDX)+2
 . S CLVBY(IDX)=CLVDAT(IDX)+10
 . S CAPPT(IDX)=CLVBY(IDX)+MAXVERBY(IDX)+2
 E  S CAPPT(IDX)=CGRP(IDX)+MAXGRP(IDX)+2
 S CDOD(IDX)=CAPPT(IDX)+10
 S MAXRPT(IDX)=CDOD(IDX)+8
 Q
 ;IBCOMA1
