DGPPRRPT ;SLC/RM - PRESUMPTIVE PSYCHOSIS RECONCILIATION REPORT ; Dec 02, 2020@3:00 pm
 ;;5.3;Registration;**1034,1035**;Aug 13, 1993;Build 14
 ;
 ;Global References     Supported by ICR#   Type
 ;-----------------     -----------------   ----------
 ; ^TMP($J              SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; COMMA^%DTC           10000               Supported
 ; HOME^%ZIS            10086               Supported
 ; ^%ZISC               10089               Supported
 ; WAIT^DICD            10024               Supported
 ; GETS^DIQ              2056               Supported
 ; ^DIR                 10026               Supported
 ; 2^VADPT              10061               Supported
 ; KVAR^VADPT           10061               Supported
 ; $$SITE^VASITE        10112               Supported
 ; $$FMTE^XLFDT         10103               Supported
 ; EN^XUTMDEVQ           1519               Supported
 Q
 ;
 ;Main entry point for PRESUMPTIVE PSYCHOSIS RECONCILIATION REPORT option
MAIN ; Initial Interactive Processing
 N DGSORT   ;array of report parameters
 N ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE,ZTSTOP,%ZIS
 W @IOF
 W "PRESUMPTIVE PSYCHOSIS RECONCILIATION REPORT"
 W !!,"This option generates a list of patients registered under Presumptive"
 W !,"Psychosis authority who have had episodes of care within the user"
 W !,"specified date range."
 W !!,"Patients registered correctly using VA workaround  and/or Presumptive"
 W !,"Psychosis Category will only be displayed in this report."
 W !!,"*** THIS REPORT REQUIRES 132 COLUMN margin width ***"
 W !!,"At the DEVICE: prompt, please accept the default value of '0;132;99999'"
 W !,"to avoid wrapping of data."
 W !!,"To include pagination, please use ';132;' for the device value.",!
 ;Prompt user for FROM Date of Eligibility Change
 I '$$DATEFROM Q
 ;Prompt user for TO Date of Eligibility Change
 I '$$DATETO Q
 ;prompt for device
 W !
 S %ZIS=""
 S %ZIS("B")="0;132;99999"
 S ZTSAVE("DGSORT(")=""
 S X="PRESUMPTIVE PSYCHOSIS RECONCILIATION REPORT"
 D EN^XUTMDEVQ("START^DGPPRRPT",X,.ZTSAVE,.%ZIS)
 D HOME^%ZIS
 Q
 ;
DATEFROM() ;prompt for FROM Date of Service
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGBEGDT,DGSTRTDT
 S DGBEGDT=3130314 ;03/14/2013 - Presumptive Psychosis legislation date
 S DGDIRA=" Start with Date:  "
 S DGDIRB=$$FMTE^XLFDT(DGBEGDT)
 S DGDIRH="^D HELP^DGPPRRPT(1)"
 S DGDIRO="DA^"_DGBEGDT_":DT:EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGBEG")=$S(DGASK<DGBEGDT:DGBEGDT,1:DGASK)
 Q DGASK>0
 ;
DATETO() ;prompt for TO Date of Service
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGDTEND
 S DGDIRA=" End with Date  :  "
 S DGDIRB="TODAY"
 S DGDIRH="^D HELP^DGPPRRPT(1)"
 S DGDTEND=DGSORT("DGBEG")
 S DGDIRO="DA^"_DGSORT("DGBEG")_":DT:EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGEND")=DGASK
 Q DGASK>0
 ;
ANSWER(DGDIRA,DGDIRB,DGDIR0,DGDIRH) ;
 ; Input
 ; DGDIR0 - DIR(0) string
 ; DGDIRA - DIR("A") string
 ; DGDIRB - DIR("B") string
 ; DGDIRH - DIR("?") string
 ; Output
 ; Function Value - Internal value returned from ^DIR or -1 if user
 ; up-arrows, double up-arrows or the read times out.
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $D(DGDIR0) S DIR(0)=DGDIR0
 I $D(DGDIRA) M DIR("A")=DGDIRA
 I $G(DGDIRB)]"" S DIR("B")=DGDIRB
 I $D(DGDIRH) S DIR("?")=DGDIRH,DIR("??")=DGDIRH
 D ^DIR K DIR
 S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U)) Q Z
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
HELP(DGSEL) ;provide extended DIR("?") help text.
 ; Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 N DGPPDT
 S DGPPDT=3130314
 I (X="?")!(X="??") D  Q
 . W !,"  Enter the VERIFIED Primary Eligibility status date"
 . W !,"  of the patient."
 . W ! D HELP1
 . W ! D HELP2
 . I $D(Y) K Y
 W !,"  The Date you entered is not valid."
 I $D(Y),Y<DGPPDT D HELP1 I $D(Y) K Y Q
 I $D(Y),Y>DT D HELP2 I $D(Y) K Y Q
 Q
 ;
HELP1 ;
 W !,"  The earliest date that you can enter is MARCH 14, 2013."
 W !,"  Date prior to 03/14/2013 is not allowed since the"
 W !,"  Presumptive Psychosis authority was implemented on"
 W !,"  03/14/2013."
 Q
 ;
HELP2 ;
 W !,"  Date cannot be a future date."
 Q
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name where the report is run
 N TRM S TRM=($E(IOST)="C")
 N DGPPLST ;temp data storage used for report list
 N RECORD ;temp data storage for all records found in file #409.68,#52,#405
 N IBOTHSTAT
 S DGPPLST=$NA(^TMP($J,"DGPPMUL")) ;contains all PP data to be displayed in the report
 S RECORD=$NA(^TMP($J,"DGPPEOC")) ;contains all PP episodes of care data found in file #409.68,#52,#405,#45
 S IBOTHSTAT=$NA(^TMP($J,"DGPPRPT1")) ;contains all PP data found in file #350, and #399
 K @DGPPLST,@RECORD,@IBOTHSTAT
 D LOOP(.DGSORT,DGPPLST)
 D PRINTPP^DGPPRRP1(.DGSORT,DGPPLST)
 K @DGPPLST,@RECORD,@IBOTHSTAT
 D EXIT
 Q
 ;
LOOP(DGSORT,DGPPLST) ;
 N DGDFN,VAUTD,SORTENCBY,CPT,DGPTNAME,DGPID,DGDOB,DGENCNT,DGPPWRK,DGPPCAT,DGPPARR,DGPPERR
 N VAEL,VADM,DGDOD,DATA,DGPEELG,DGELIGDATE,VA,DFN,I,I1,OTHER,DGPPFLGRPT
 S SORTENCBY=0
 ;PP VA Workaround
 ; Registration Screen <7>
 ; - Patient Type: SC Veteran
 ; - Veteran : Yes
 ; - Service Connected: Yes
 ; - Service Connected %: 0%
 ; - Primary Elig Code: SC LESS THAN 50%
 ; - Other Elig Code(s): HUMANITARIAN EMERGENCY
 ; Registration Screen <5>
 ; - VHA DIRECTIVE 1029 WNR   (This is a Free text for insurance buffer entry)
 ; Registration Screen <11>
 ; - Select RATED DISABILITIES (VA):  9410 (unspecified neurosis)
 ; - DISABILITY %: 0
 ; and/or with
 ; Registration Screen <7>
 ; - PP Indicator (SHRPE 1.0)
 ;Note: This report will not filter the facility/division of the episodes of care where the report is run
 ;      It will display all facility/division regardless where the report is run
 S VAUTD=1   ;All the divisions in the facility, since we are not prompting user to enter Division
 S DGPPFLGRPT=1 ;this flag will be used to determine which mumps code to execute in DGFSMOUT routine
 ;Loop through all PATIENT file #2
 S (DGDFN,CPT)=0 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . S CPT=CPT+1 W:'(CPT#60000) "." ;write . every 60,000 processed records
 . S DGPPWRK=$$PPWRKARN^DGPPAPI(DGDFN) ;check if this patient is registered correctly using PP VA workaround settings
 . S DGPPCAT=$$PPINFO^DGPPAPI(DGDFN) ;check for PP category
 . I $P(DGPPCAT,U)'="Y" S DGPPCAT="N"
 . I DGPPWRK="Y"!($P(DGPPCAT,U)="Y") D  ;if PP VA Workaround exist or PP Category exist, extract episode of care/inpatient/bill charges/rx
 . . K @RECORD ;evaluate each patient one at a time
 . . S (DGENCNT,I1,I)=0
 . . ;only collect completed encounter with STATUS=CHECKED OUT
 . . D CHKTREAT^DGFSMOUT(+DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),.VAUTD,0) ;check if there any past Outpatient Encounter entry in file #409.68
 . . D CHECKPTF^DGFSMOUT(DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),"DGPPRPT1") ;check if there any Inpatient stay entry in file #405 OR file #45
 . . D CHECKIB^DGFSMOUT("DGPPRPT1",DGSORT("DGBEG"),DGSORT("DGEND")) K ^TMP($J,"DGPPRPT1") ;check if this patient has records in file #350 or file #399
 . . D CHECKRX^DGFSMOUT("DGPPRX52") ;check at file #52 if this patient has any RX not yet charged
 . . I $O(@RECORD@(""))="",DGENCNT<1 Q  ;do not include patient that has no record in any of these files: 409.68, 350, 399, 52, 405, and file 45
 . . ;if all checking above passed, then extract patient name,PID,DOB,PP Category,Date of Service,Primary Eligibility,Other Eligibility,Date of Death
 . . K DATA,DGPPARR,DGPPERR D GETS^DIQ(2,DGDFN_",",".01;.0905;.361;.3611;.3612;.351","IE","DGPPARR","DGPPERR")
 . . Q:$D(DGPPERR)
 . . S DGPTNAME=$G(DGPPARR(2,DGDFN_",",.01,"I")) ;PP name
 . . S DGPID=$G(DGPPARR(2,DGDFN_",",.0905,"I")) ;pid
 . . K VAEL,VADM,DFN S DFN=DGDFN D 2^VADPT
 . . S DGDOB=$P(VADM(3),U) ;date of birth
 . . S DGDOD=$G(DGPPARR(2,DGDFN_",",.351,"I")) ;date of death
 . . S DGPEELG=$G(DGPPARR(2,DGDFN_",",.361,"E")) ;primary eligibility
 . . S DGELIGDATE=$G(DGPPARR(2,DGDFN_",",.3612,"I")) ;PE verified
 . . S DATA=DGPTNAME_U_DGPID_U_DGDOB_U_DGDOD_U_$P(DGPPCAT,U,2)_U_DGPEELG_U
 . . S @DGPPLST@(DGPTNAME,DGDFN)=DATA
 . . K OTHER I $D(VAEL(1))>9 S I1=0 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1,OTHER(I1)=$P(VAEL(1,I),"^",2)
 . . E  S OTHER(1)="NO OTHER ELIG. IDENTIFIED",I1=1
 . . D KVAR^VADPT
 . . D EOC,EOC2
 Q
 ;
EOC ;Episode of care date of service
 N DGDOS,DGSTATN,FILENO,CNT,EOCIEN,IBFILENO,RESULT,EOCIEN399,EOCIEN45,RECNUM,EOCIEN405,NWBL350,TRUINPT,ARY350,RXARY52,RXIEN,OUTPATARY,OUTTRUE
 S (I,EOCIEN45,EOCIEN,EOCIEN399,RECNUM,EOCIEN405,NWBL350,TRUINPT,RXIEN,OUTTRUE)=0
 S DGDOS="" F  S DGDOS=$O(@RECORD@(DGDOS)) Q:DGDOS=""  D
 . S DGSTATN="" F  S DGSTATN=$O(@RECORD@(DGDOS,DGSTATN)) Q:DGSTATN=""  D
 . . S FILENO="" F  S FILENO=$O(@RECORD@(DGDOS,DGSTATN,FILENO)) Q:FILENO=""  D
 . . . S CNT="" F  S CNT=$O(@RECORD@(DGDOS,DGSTATN,FILENO,CNT)) Q:CNT=""  D
 . . . . S (RECNUM,TRUINPT,RXIEN,OUTTRUE)=0
 . . . . I FILENO=350 D  Q  ;manually entered charges and is not linked to any file
 . . . . . S RESULT=$P(@RECORD@(DGDOS\1,+DGSTATN,FILENO,CNT),U,11) ;file #350 resulting from
 . . . . . I $P(RESULT,":")=44 K @RECORD@(DGDOS,DGSTATN,FILENO,CNT) Q  ;we are not including any file #44 records as of the moment
 . . . . . I $P(RESULT,":")=350 D
 . . . . . . S NWBL350=$P($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,10),"-",2) ;same date and bill number, count them as one record
 . . . . . . I NWBL350="" S NWBL350=$P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,9) ;if BILL NO is null, get the IEN instead
 . . . . . . I '$D(ARY350(DGDOS,NWBL350)) D EOC1(FILENO) S ARY350(DGDOS,NWBL350)=""
 . . . . . . K @RECORD@(DGDOS,DGSTATN,FILENO,CNT)
 . . . . . I $P(RESULT,":")=52 D
 . . . . . . S RXIEN=$P($P($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,11),":",2),";") ;file #350 RXIEN from file #52
 . . . . . . I '$D(RXARY52(DGDOS,RXIEN)) D EOC1(FILENO) S RXARY52(DGDOS,RXIEN)=""
 . . . . . . K @RECORD@(DGDOS,DGSTATN,FILENO,CNT)
 . . . . I FILENO=52 D
 . . . . . S RXIEN=$P($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,7),":",2) ;file #52 RXIEN
 . . . . . I '$D(RXARY52(DGDOS,RXIEN)) D EOC1(FILENO) S RXARY52(DGDOS,RXIEN)=""
 . . . . . K @RECORD@(DGDOS,DGSTATN,FILENO,CNT)
 . . . . I FILENO=399 D
 . . . . . S RESULT=$P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,12),RXIEN=$P(RESULT,":",3)
 . . . . . I RESULT["PRESCRIPTION",'$D(RXARY52(DGDOS,RXIEN)) D EOC1(FILENO) S RXARY52(DGDOS,RXIEN)=""
 . . . . . K @RECORD@(DGDOS,DGSTATN,FILENO,CNT)
 . . . . I FILENO=405!(FILENO=409.68) D
 . . . . . I FILENO=409.68,$P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,10)'=1 D  Q:OUTTRUE
 . . . . . . I $D(OUTPATARY($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,3),DGDOS\1)) S OUTTRUE=1 Q  ;this means the record belongs to a secondary stop code, as per business owner, display and count primary and secondary stop code as one
 . . . . . I FILENO=405,$P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,10)>1 Q
 . . . . . S EOCIEN=+$P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,7) ;IEN in either file 409.68
 . . . . . I FILENO=405,$P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,10)<1 D  ;true inpatient care record
 . . . . . . S TRUINPT=1
 . . . . . . S EOCIEN405=$P($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,8),";") ;IEN from file 405
 . . . . . . S EOCIEN45=$P($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,8),";",2) ;IEN from file 45
 . . . . . F IBFILENO=350,399 D
 . . . . . . I $D(@RECORD@(DGDOS\1,$S(IBFILENO=350:+DGSTATN,1:DGSTATN),IBFILENO)) D
 . . . . . . . S RECNUM=+$O(@RECORD@(DGDOS\1,$S(IBFILENO=350:+DGSTATN,1:DGSTATN),IBFILENO,RECNUM))
 . . . . . . . S RESULT=$P(@RECORD@(DGDOS\1,$S(IBFILENO=350:+DGSTATN,1:DGSTATN),IBFILENO,RECNUM),U,11) ;file #350 resulting from
 . . . . . . . I IBFILENO=350 D
 . . . . . . . . I EOCIEN=$P(RESULT,":",2) K @RECORD@(DGDOS\1,+DGSTATN,IBFILENO,RECNUM) ;from file #409.68
 . . . . . . . . I $P(RESULT,":")=45,EOCIEN45=$P(RESULT,":",2) K @RECORD@(DGDOS\1,+DGSTATN,IBFILENO,RECNUM) ;from file #45
 . . . . . . . . I $P(RESULT,":")=405,EOCIEN405=$P(RESULT,":",2) K @RECORD@(DGDOS\1,+DGSTATN,IBFILENO,RECNUM) ;from file #405
 . . . . . . . I IBFILENO=399 D
 . . . . . . . . S EOCIEN399=+$P($G(@RECORD@(DGDOS\1,DGSTATN,IBFILENO,RECNUM)),U,17) ;IEN in either file 405 or file 409.68
 . . . . . . . . I EOCIEN=EOCIEN399!(EOCIEN45=EOCIEN399) K @RECORD@(DGDOS\1,DGSTATN,IBFILENO,RECNUM)
 . . . . . . . . I +EOCIEN<1,EOCIEN45=EOCIEN399 K @RECORD@(DGDOS\1,DGSTATN,IBFILENO,RECNUM)
 . . . . . D EOC1(FILENO)
 ;check if there are any left over from file #350 or file #399. These records are not linked to any record in either file #409.68, #405, or file #45
 I $O(@RECORD@(""))'="" D RECORD
 K ARY350,RXARY52,OUTPATARY
 Q
 ;
EOC1(FILE) ;capture the date of service
 S I=I+1
 S TRUINPT=$S(+TRUINPT<1:"",1:"*")
 S @DGPPLST@(DGPTNAME,DGDFN,DGDOS\1,I,"OTHER",FILE,DGSTATN)=TRUINPT_DGDOS
 I FILENO=405!(FILENO=409.68) S OUTPATARY($P(@RECORD@(DGDOS,DGSTATN,FILENO,CNT),U,3),DGDOS\1)=""
 Q
 ;
EOC2 ;capture the other eligibilities if there are any
 N DGDOS,DGSTATN,FILENO,II,CNTR
 I I=I1!(I>I1) D EOC3 Q  ;the total number of date of service is equal or more to the number of other eligibilities that the patient have
 I I<I1 D  ;the other eligibilities is more than the date of service
 . F CNTR=1:1:I1 D EOC4
 Q
 ;
EOC3 ;
 S DGDOS="" F  S DGDOS=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS)) Q:DGDOS=""  D
 . S II="" F  S II=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,II)) Q:II=""  D
 . . S FILENO="" F  S FILENO=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,II,"OTHER",FILENO)) Q:FILENO=""  D
 . . . S DGSTATN="" F  S DGSTATN=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,II,"OTHER",FILENO,DGSTATN)) Q:DGSTATN=""  D
 . . . . I $D(OTHER(II)) S $P(@DGPPLST@(DGPTNAME,DGDFN,DGDOS\1,II,"OTHER",FILENO,DGSTATN),U,2)=OTHER(II)
 Q
 ;
EOC4 ;
 N RECNT
 S RECNT=0
 S DGDOS="" F  S DGDOS=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS)) Q:DGDOS=""  D
 . I '$D(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,CNTR)),CNTR>I D  Q
 . . S FILENO=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,I,"OTHER",""))
 . . Q:FILENO=""
 . . S DGSTATN=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,I,"OTHER",FILENO,"")),RECNT=1
 . . S @DGPPLST@(DGPTNAME,DGDFN,DGDOS\1,CNTR,"OTHER",FILENO,DGSTATN)=""_U_OTHER(CNTR)
 . S FILENO="" F  S FILENO=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,CNTR,"OTHER",FILENO)) Q:FILENO=""  D
 . . S DGSTATN="" F  S DGSTATN=$O(@DGPPLST@(DGPTNAME,DGDFN,DGDOS,CNTR,"OTHER",FILENO,DGSTATN)) Q:DGSTATN=""  D
 . . . I $D(@DGPPLST@(DGPTNAME,DGDFN,DGDOS\1,CNTR)) S RECNT=1,$P(@DGPPLST@(DGPTNAME,DGDFN,DGDOS\1,CNTR,"OTHER",FILENO,DGSTATN),U,2)=OTHER(CNTR)
 Q
 ;
RECORD ;display those records that are not linked to any IB charges
 N DOS,DGSTATN,CNT,FILENO
 F FILENO=52,350,399 D
 . S DGDOS="" F  S DGDOS=$O(@RECORD@(DGDOS)) Q:DGDOS=""  D
 . . S DGSTATN="" F  S DGSTATN=$O(@RECORD@(DGDOS,DGSTATN)) Q:DGSTATN=""  D
 . . . S CNT="" F  S CNT=$O(@RECORD@(DGDOS,DGSTATN,FILENO,CNT)) Q:CNT=""  D
 . . . . D EOC1(FILENO) K @RECORD@(DGDOS,DGSTATN,FILENO,CNT)
 Q
 ;
CHKDATE(DATE,BEGDT,ENDDT) ;check if dates fall within the Begin and End dates
 Q BEGDT<=DATE&(ENDDT>=DATE)
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"  ;tell TaskMan to delete Task log entry
 I '$D(ZTQUEUED) D
 . I 'TRM,$Y>0 W @IOF
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
 ;
DOLLAR(X) ; Function to return a formatted dollar amount.
 I $G(X)="" Q ""
 N X2,X3
 S X2="2$",X3=0
 D COMMA^%DTC
 Q X
 ;
