DGOTHFSM ;SLC/RM - FORMER OTH PATIENT ELIGIBILITY CHANGE REPORT ; July 13, 2020@09:44am
 ;;5.3;Registration;**1025,1034,1035,1047**;Aug 13, 1993;Build 13
 ;
 ;Global References                       Supported by ICR#         Type
 ;-----------------                       -----------------         ----------
 ; ^DGPT("AFEE"                           418 (DG is the Cust.Pkg.) Cont. Sub.
 ; ^TMP($J                                SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; HOME^%ZIS                               10086                    Supported
 ; ^%ZISC                                  10089                    Supported
 ; $$S^%ZTLOAD                             10063                    Supported
 ; WAIT^DICD                               10024                    Supported
 ; GETS^DIQ                                 2056                    Supported
 ; ^DIR                                    10026                    Supported
 ; $$CODEC^ICDEX                            5747                    Cont. Sub.
 ; 2^VADPT,KVAR^VADPT                      10061                    Supported
 ; $$SITE^VASITE                           10112                    Supported
 ; $$FMADD^XLFDT,$$FMTE^XLFDT, $NOW^XLFDT  10103                    Supported
 ; $$CJ^XLFSTR                             10104                    Supported
 ; $$STA^XUAF4                              2171                    Supported
 ; EN^XUTMDEVQ                              1519                    Supported
 ; $$GET1^DIQ(45.7  1359,1154 (DG is the Custodial Package) Cont. Sub.,Supported
 ;
 ;No direct call
 Q
 ;
 ;Entry point for DG FORMER OTH PATIENTS ELIG. CHANGE REPORT option
MAIN ; Initial Interactive Processing
 N DGSORT   ;array of report parameters
 N ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE,ZTSTOP,%ZIS
 ;check for database
 I '+$O(^DGOTH(33,"B","")) W !!!,$$CJ^XLFSTR(">>> No OTH records have been found. <<<",80) D ASKCONT(0) Q
 W @IOF
 W "FORMER OTH PATIENT ELIGIBILITY CHANGE REPORT"
 W !!,"This report identifies Former Service Members whose Primary Eligibility"
 W !,"changed from EXPANDED MH CARE NON-ENROLLEE to a new Primary Eligibility"
 W !,"with a VERIFIED eligibility status. These patients are no longer treated"
 W !,"under the Other Than Honorable (OTH) authority (VHA Directive 1601A.02)."
 W !!,"*** THIS REPORT REQUIRES 132 COLUMN margin width ***"
 W !!,"At the DEVICE: prompt, please accept the default value of '0;132;99999'"
 W !,"to avoid wrapping of data."
 W !!,"To include pagination, please use ';132;' for the device value."
 W !!,"Enter Primary Eligibility Changed Date: "
 ;Prompt user for FROM Date of Eligibility Change
 I '$$DATEFROM Q
 ;Prompt user for TO Date of Eligibility Change
 I '$$DATETO Q
 ;prompt for device
 W !
 S %ZIS=""
 S %ZIS("B")="0;132;99999"
 S ZTSAVE("DGSORT(")=""
 S X="FORMER OTH PATIENT ELIGIBILITY CHANGE REPORT"
 D EN^XUTMDEVQ("START^DGOTHFSM",X,.ZTSAVE,.%ZIS)
 D HOME^%ZIS
 Q
 ;
DATEFROM() ;prompt for FROM Date of Service
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGBEGDT,DGSTRTDT
 S DGBEGDT=3200220 ;February 20,2020 is the date OTH project was released
 S DGDIRA=" Start with Date:  "
 S DGDIRB=$$FMTE^XLFDT(3200220)
 S DGDIRH="^D HELP^DGOTHFSM(1)"
 S DGDIRO="DA^"_DGBEGDT_":DT:EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGBEG")=$S(DGASK<DGBEGDT:DGBEGDT,1:DGASK)
 Q DGASK>0
 ;
DATETO() ;prompt for TO Date of Service
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGDTEND
 S DGDIRA=" End with Date  :  "
 S DGDIRB="TODAY"
 S DGDIRH="^D HELP^DGOTHFSM(1)"
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
 N DGOTHDT
 S DGOTHDT=3200220
 I (X="?")!(X="??") D  Q
 . W !,"  Enter the date when the former OTH patient has an Episode of Care"
 . W !,"  or Released Prescription."
 . W ! D HELP1
 . W ! D HELP2
 . I $D(Y) K Y
 W !,"  The Date you entered is not valid."
 I $D(Y),Y<DGOTHDT D HELP1 I $D(Y) K Y Q
 I $D(Y),Y>DT D HELP2 I $D(Y) K Y Q
 Q
 ;
HELP1 ;
 W !,"  The earliest date that you can enter is February 20,2020."
 W !,"  This is the date the new Primary Eligibility code"
 W !,"  EXPANDED MH CARE NON-ENROLLEE became available."
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
 N DGLIST ;temp data storage used for report list
 N DGOTHIN ;temp data storage for INACTIVE OTH patient list
 N RECORD ;temp data storage for all records found in file #409.68,#52,#405,#350, and #399
 N IBOTHSTAT
 S DGLIST=$NA(^TMP($J,"OTHEL"))
 S DGOTHIN=$NA(^TMP($J,"OTHINACTV"))
 S RECORD=$NA(^TMP($J,"DGENCTR"))
 S IBOTHSTAT=$NA(^TMP($J,"DGOTHFSM"))
 K @DGLIST,@DGOTHIN,@RECORD,@IBOTHSTAT
 D LOOP(.DGSORT,DGLIST,DGOTHIN)
 I $O(@DGOTHIN@(""))'="" D PRINT(.DGSORT,DGLIST)
 K @DGLIST,@DGOTHIN,@RECORD,@IBOTHSTAT
 D EXIT
 Q
 ;
LOOP(DGSORT,DGLIST,DGOTHIN) ;
 N DDASH,DGPAGE,DGDFN,DGIEN33,DGERR,DGOTHARR,VAUTD,DATA,DGIBRX,SORTENCBY,DGOTHMST
 N DGOTHREGDT,DGELIGDATE,DGPTNAME,DGNEWELG,DGPID,DGDOB,DGENCNT,DGELGDTV,DGMSTRSLT
 S $P(DDASH,"=",81)=""
 S (DGPAGE,SORTENCBY)=0
 ;gather all registered OTH patients with INACTIVE status only
 ;patients with INACTIVE OTH status, either the patient received VBA adjudication or entered in error
 D INACTOTH(.DGSORT)
 ;No INACTIVE OTH patients found, display message and quit
 I $O(@DGOTHIN@(""))="" D  Q
 . Q:'+$O(^DGOTH(33,"F",""))
 . D HEADER,COLHEAD
 . W !!!," >>> No records were found in the selected date range.",!!
 . W ! D LINE
 . D ASKCONT(0) W @IOF
 ;Otherwise, loop thru all INACTIVE OTH patients temporarily stored in the global and see
 ;which of this patients received primary eligibility status of VERIFIED
 S VAUTD=1   ;All the divisions in the facility, since we are not prompting user to enter Division
 S DGDFN="" F  S DGDFN=$O(@DGOTHIN@(DGDFN)) Q:DGDFN=""  D
 . S DGIEN33="" F  S DGIEN33=$O(@DGOTHIN@(DGDFN,DGIEN33)) Q:DGIEN33=""  D
 . . K DGERR,DGOTHARR,DATA,DGELIGDATE,DGPTNAME,DGNEWELG,DGOTHREGDT,DGPID,DGDOB,DGELGDTV
 . . K @RECORD ;evaluate each patient one at a time
 . . S DGENCNT=0,(DGMSTRSLT,DGOTHMST)=""
 . . D GETS^DIQ(2,DGDFN_",",".01;.0905;.361;.3611;.3612","IE","DGOTHARR","DGERR") ;DG is the custodial package for file #2, no ICR needed
 . . Q:$D(DGERR)
 . . Q:$G(DGOTHARR(2,DGDFN_",",.3611,"I"))'="V"  ;quit if eligibility status not VERIFIED
 . . S DGOTHREGDT=$G(@DGOTHIN@(DGDFN,DGIEN33)) ;the date when the patient became OTH
 . . S DGELGDTV=$G(DGOTHARR(2,DGDFN_",",.3612,"I")) ;the date when the PE eligibility status of patient became VERIFIED
 . . ;quit if not within the user specified date range
 . . I (DGELGDTV<DGSORT("DGBEG"))!(DGOTHREGDT>DGSORT("DGEND")) Q
 . . ;If patient had entries in file #409.68, #405, #350, #399, and #52 on the selected date range but
 . . ;the SITE where the encounter happen does not belong to the facility/division where the report is run,
 . . ;the patient will not be displayed/included in the report
 . . ;for file #409.68 only collect completed encounter with STATUS=CHECKED OUT
 . . D CHKTREAT^DGFSMOUT(+DGDFN,DGOTHREGDT,DGELGDTV,.VAUTD,0) ;check if there any past Outpatient Encounter entry in file #409.68
 . . D CHECKPTF^DGFSMOUT(DGDFN,DGOTHREGDT,DGELGDTV,"DGOTHFSM") ;check if there any Inpatient stay entry in file #405 OR file #45
 . . D CHECKIB^DGFSMOUT("DGOTHFSM",DGOTHREGDT,DGELGDTV) K ^TMP($J,"DGOTHFSM") ;check if this patient has records in file #350 or file #399
 . . D CHECKRX^DGFSMOUT("DGOTHFSMRX") ;check at file #52 if this patient has any RX not yet charged
 . . I $O(@RECORD@(""))="",DGENCNT<1 Q  ;do not include patient that has no record in any of these files: 409.68, 350, 399, 52, and file 405 OR file 45
 . . ;if all checking above passed, then extract patient name,PID, New Eligibility Code, SC%, Eligibility Change Date, Station ID
 . . S DGELIGDATE=$G(DGOTHARR(2,DGDFN_",",.3612,"I"))
 . . S DGPTNAME=$G(DGOTHARR(2,DGDFN_",",.01,"I"))
 . . S DGPID=$G(DGOTHARR(2,DGDFN_",",.0905,"I"))
 . . S DGNEWELG=$G(DGOTHARR(2,DGDFN_",",.361,"E"))
 . . S DATA=DGPTNAME_U_DGPID_U_DGOTHREGDT_U_DGNEWELG_U_DGELIGDATE
 . . I $G(IBMST) D  ;extract the most current MST screening results for this patient
 . . . S DGOTHMST=$$GETSTAT^DGMSTAPI(DGDFN)
 . . . S DGMSTRSLT=$P(DGOTHMST,U,2),DGMSTRSLT=$S(DGMSTRSLT="Y":"YES",DGMSTRSLT="N":"NO",DGMSTRSLT="D":"DECLINE",DGMSTRSLT="U":"UNKNOWN",1:"NO DATA FOUND")
 . . . I DGMSTRSLT="UNKNOWN",$P(DGOTHMST,U)<1 S DGMSTRSLT="NO DATA FOUND"
 . . S DATA=$$SCPRCT(DGDFN,DATA) ;extract the SC%
 . . D CHKINT(DATA) ;determine if the facility belongs to integrated or non-integrated site
 Q
 ;
INACTOTH(DGSORT) ;Gather all registered OTH Patients with INACTIVE status within the user-specified date range
 N DGDFN,DGIEN33,DGERR,DGOTHARR,DGREGDT,DGOTHELDT,DGRECNUM,DGFOUND,DGELGDT,DGSTDT,II,DGTOTREC
 ;check first the existence of the "F" cross reference
 I '+$O(^DGOTH(33,"F","")) W !!!,$$CJ^XLFSTR(">>> The ""F"" cross reference use to run the report does not exist . <<<",80) D ASKCONT(0) Q
 ;only extract INACTIVE OTH patients within the user-specified date range
 ;this is to ensure for fast data extraction
 ;EXEMPTION (only do this process): If the user's starting date is February 20, 2020 but the OTH patient
 ;                                  had previous information stored in File #33, go ahead and include that patient
 ;check if starting date is February 20, 2020 - if true, reset the starting date to the OTH legislation date to Jul 01, 2017
 ;loop thru cross reference "F" to run report
 I DGSORT("DGBEG")=3200220 S DGSTDT=3170701
 E  S DGSTDT=DGSORT("DGBEG")
 S DGOTHELDT=$$FMADD^XLFDT(DGSTDT,-1)
 F  S DGOTHELDT=$O(^DGOTH(33,"F",DGOTHELDT)) Q:DGOTHELDT=""!((DGOTHELDT\1)>DGSORT("DGEND"))  D
 . K DGERR,DGOTHARR,DGOTHREGDT,DGREGDT,DGIEN33
 . S DGIEN33=+$O(^DGOTH(33,"F",DGOTHELDT,""))
 . ;find only those INACTIVE OTH patients whose registration date falls within the user-specified date range
 . ;either these patients received adjudication or the PE is entered in error
 . D GETS^DIQ(33,DGIEN33_",",".01;.02;2*","IE","DGOTHARR","DGERR")
 . Q:$D(DGERR)
 . Q:$G(DGOTHARR(33,DGIEN33_",",.02,"I"))  ;quit if status is ACTIVE
 . ;loop through all the OTH Registration Date and determine the original date the former OTH service member become EXPANDED MH CARE NON-ENROLLEE
 . S (DGFOUND,DGTOTREC)=0
 . S DGTOTREC=$P(^DGOTH(33,DGIEN33,2,0),U,4)
 . Q:+DGTOTREC<1
 . F II=1:1:DGTOTREC S DGREGDT(II)=""
 . S DGRECNUM="" F  S DGRECNUM=$O(DGREGDT(DGRECNUM)) Q:DGRECNUM=""!(DGFOUND)  D
 . . I DGOTHARR(33.02,DGRECNUM_","_DGIEN33_",",.02,"E")="EXPANDED MH CARE NON-ENROLLEE" D  ;check if the eligibility is EXPANDED MH CARE NON-ENROLLEE
 . . . ;the original OTH registration date
 . . . S DGOTHREGDT=$G(DGOTHARR(33.02,DGRECNUM_","_DGIEN33_",",.01,"I"))
 . . . S DGDFN=$G(DGOTHARR(33,DGIEN33_",",.01,"I"))
 . . . S @DGOTHIN@(DGDFN,+DGIEN33)=DGOTHREGDT\1
 . . . S DGFOUND=1
 Q
 ;
SCPRCT(DFN,DATA) ;extract the service connected percentage
 N VAEL,VADM,DGDOB,VA
 D 2^VADPT ;extract patients demographics and eligibility information
 S DGDOB=$P(VADM(3),U)
 S DATA=DATA_U_$P(VAEL(3),"^",2)_U_DGDOB_U
 D KVAR^VADPT
 Q DATA
 ;
CHKINT(DATA) ; check for integrated site divisions
 N INTFCLTY,DGDIV,DGSTATN,OLDSTA,DGENCTRDT,RECNT,FILENO
 S OLDSTA=""
 S INTFCLTY="^528^589^636^657^" ; list of integrated site parent facilities (station #s)
 S DGENCTRDT="" F  S DGENCTRDT=$O(@RECORD@(DGENCTRDT)) Q:DGENCTRDT=""  D
 . S DGDIV="" F  S DGDIV=$O(@RECORD@(DGENCTRDT,DGDIV)) Q:DGDIV=""  D
 . . S FILENO="" F  S FILENO=$O(@RECORD@(DGENCTRDT,DGDIV,FILENO)) Q:FILENO=""  D
 . . . S RECNT="" F  S RECNT=$O(@RECORD@(DGENCTRDT,DGDIV,FILENO,RECNT)) Q:RECNT=""  D
 . . . . S DGSTATN=$P(@RECORD@(DGENCTRDT,DGDIV,FILENO,RECNT),U,2)
 . . . . Q:DGSTATN=""
 . . . . ;only extract station # belong to the facility/division where the report is run
 . . . . Q:+DGSTATN'=+$P(HERE,U,3)
 . . . . I INTFCLTY[(U_+DGSTATN_U) D  Q
 . . . . . ;if integrated facility, display all station # patient was treated
 . . . . . S @DGLIST@(DGPTNAME,DGDFN,DGSTATN)=DATA_U_DGMSTRSLT
 . . . . ;roll up the station to its site parent facilities e.g. 442,442GA,442GC - this will roll up to 442
 . . . . I OLDSTA'=+DGSTATN S @DGLIST@(DGPTNAME,DGDFN,+DGSTATN)=DATA_U_DGMSTRSLT
 . . . . S OLDSTA=+DGSTATN
 Q
 ;
PRINT(DGSORT,DGLIST) ;output report
 N DGPAGE,DDASH,DGQ,DGDFN,DGTOTAL,DGPRINT,DGOLD,DGSTATN,DGPTNAME
 S (DGQ,DGTOTAL,DGPAGE,DGPRINT,DGOLD)=0,$P(DDASH,"=",81)=""
 I $O(@DGLIST@(""))="" D  Q
 . D HEADER,COLHEAD
 . W !!!," >>> No records were found using the report criteria.",!!
 . W ! D LINE
 . D ASKCONT(0) W @IOF
 ; loop and print report
 D HEADER,COLHEAD
 S DGPTNAME="" F  S DGPTNAME=$O(@DGLIST@(DGPTNAME)) Q:DGPTNAME=""  D  Q:DGQ
 . I DGOLD'=DGPTNAME S DGPRINT=0
 . S DGDFN="" F  S DGDFN=$O(@DGLIST@(DGPTNAME,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 . . S DGSTATN="" F  S DGSTATN=$O(@DGLIST@(DGPTNAME,DGDFN,DGSTATN)) Q:DGSTATN=""  D  Q:DGQ
 . . . I $Y>(IOSL-4) W ! D LINE D PAUSE(.DGQ) Q:DGQ  D HEADER,COLHEAD
 . . . W !
 . . . I 'DGPRINT D PRINT1 S DGPRINT=1
 . . . W ?$S($G(IBMST):48,1:54),$$FMTE^XLFDT($P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,3),"5Z") ;OTH registration date
 . . . W ?$S($G(IBMST):60,1:69),$P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,4) ;new primary eligibility code
 . . . I $G(IBMST) W ?91,$P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,9) ;user wants to display the current MST status date for a patient}
 . . . W ?$S($G(IBMST):107,1:103),$P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,6) ;SC%
 . . . W ?$S($G(IBMST):112,1:110),$$FMTE^XLFDT($P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,5),"5Z") ;primary eligibility changed date
 . . . W ?125,DGSTATN
 . . . Q:DGQ
 . . Q:DGQ
 . S DGTOTAL=DGTOTAL+1
 . Q:DGQ
 . S DGOLD=DGPTNAME
 Q:DGQ
 W !
 D LINE
 W !!,"Number of Unique Patients:  ",$J(DGTOTAL,5)
 W !!,"<< end of report >>"
 D ASKCONT(0) W @IOF
 Q
 ;
PRINT1 ;print the name, pid, and DOB only once
 W $E($P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,1),1,$S($G(IBMST):27,1:30)) ;patient name
 W ?$S($G(IBMST):29,1:33),$$FMTE^XLFDT($P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,7),"5Z") ;DOB
 W ?$S($G(IBMST):41,1:46),$P(@DGLIST@(DGPTNAME,DGDFN,DGSTATN),U,2) ;PID
 Q
 ;
HEADER ;Display header for the report
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 I TRM!('TRM&DGPAGE) W @IOF
 S DGPAGE=$G(DGPAGE)+1
 W !,?44,$G(ZTDESC),?120,"Page: ",?127,DGPAGE
 W ! D LINE
 W !,"OTH Eligibility Change Date Range: ",?12,$$FMTE^XLFDT(DGSORT("DGBEG"),"5Z")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5Z")
 W ?92,"Date Printed  : ",$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !!,"List of Patients whose primary eligibility changed from EXPANDED MH CARE NON-ENROLLEE to a new primary eligibility code with"
 W !,"eligibility status of VERIFIED and episode(s)of care.",!
 I $G(IBMST) W !,"The Current MST Screening indicates the latest MST screening result for the patient."
 W !,"The Station column provides data on which site(s) the patient was treated."
 W ! D LINE W !
 Q
 ;
LINE ;prints double dash line
 N LINE
 F LINE=1:1:132 W "="
 Q
 ;
COLHEAD ;report column header
 I $G(IBMST) D  Q  ;user wants the MST Information to be displayed
 . W "PATIENT NAME",?29,"DATE OF",?41,"PID",?48,"OTH REG",?60,"NEW ELIGIBILITY CODE",?91,"CURRENT MST",?107,"SC%",?112,"ELIGIBILITY",?125,"STATION"
 . W !,?29,"BIRTH",?48,"DATE",?91,"SCREEN STATUS",?112,"CHANGE DATE"
 . W !,"---------------------------",?29,"----------",?41,"-----",?48,"----------",?60,"-----------------------------"
 . W ?91,"--------------",?107,"---",?112,"-----------",?125,"-------"
 W "PATIENT NAME",?33,"DATE OF",?46,"PID",?54,"OTH REG DATE",?69,"NEW ELIGIBILITY CODE",?103,"SC%",?110,"ELIGIBILITY",?125,"STATION"
 W !,?33,"BIRTH",?110,"CHANGE DATE"
 W !,"------------------------------",?33,"----------",?46,"-----",?54,"------------"
 W ?69,"------------------------------",?103,"----",?110,"-----------",?125,"-------"
 Q
 ;
ASKCONT(FLAG) ; display "press <Enter> to continue" prompt
 N Z
 W !!,$$CJ^XLFSTR("Press <Enter> to "_$S(FLAG=1:"continue.",1:"exit."),20)
 R !,Z:DTIME
 Q
 ;
CHKDATE(DATE,BEGDT,ENDDT) ;check if dates fall within the Begin and End dates
 Q BEGDT<=DATE&(ENDDT>=DATE)
 ;
PAUSE(DGQ) ; pause screen display
 ; Input: 
 ; DGQ - var used to quit report processing to user CRT
 ; Output:
 ; DGQ - passed by reference - 0 = Continue, 1 = Quit
 I $G(DGPAGE)>0,TRM K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQ=1
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"  ;tell TaskMan to delete Task log entry
 I '$D(ZTQUEUED) D
 . I 'TRM,$Y>0 W @IOF
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
 ;
PTFDATA ;extract data for the inpatient
 ;If patient still not discharged (still in the hospital)extract the ward location in Patient file #2,otherwise, extract the ward at discharge in file #45
 N PRIMDX,PTFIEN405
 S PRIMDX="NONE"
 I DSCHRGDT>0 D  ;patient is discharged
 . S WRDLOC=$$GET1^DIQ(45,PTFIEN_",",2.2,"E") ;ward location discharge
 . S TRTFCLTY="*DISCH("_$$FMTE^XLFDT($P(DSCHRGDT,".")\1,"5ZF")_")" ;treating facility
 E  D
 . S WRDLOC=$G(^DPT(DGDFN,.1)) ;ward location
 . S TRTFCLTY=$$GET1^DIQ(45.7,+$G(^DPT(DGDFN,.103))_",",.01,"E") ;treating facility - DG is the custodial package for file #45.7, no icr needed
 S WRDLOC=$S(WRDLOC'="":WRDLOC,1:"NON-VA ADMISSION")
 D ATID1^DGOTHFS4 ;extract the ward and the last user edited the record in file #405
 I $D(^DGPT(PTFIEN,70)) D  ;Extract primary diagnosis if there are any
 . S PRIMDX=$P(^DGPT(PTFIEN,70),U,10)
 . S PRIMDX=$$CODEC^ICDEX(80,PRIMDX)
 . S PRIMDX=$S($P(PRIMDX,U)=-1:"NONE",1:PRIMDX)
 I $D(^DGPT("AFEE",DGDFN,ADMDT,PTFIEN)) D  ;check if this record is a NONVA transaction
 . I '$G(^DGPT(PTFIEN,70)) S PRIMDX="NONE" ;this is to exit the routine gracefully. Some inpatient episode of care does not have primary dx listed
 . I PRIMDX="NONE",$G(^DGPT(PTFIEN,70))'="" S PRIMDX=$P(^DGPT(PTFIEN,70),U,10),PRIMDX=$$CODEC^ICDEX(80,PRIMDX),PRIMDX=$S($P(PRIMDX,U)=-1:"NONE",1:PRIMDX)
 . I DGSTA="" D
 . . K DGOUT,DGOUTERR D GETS^DIQ(45,PTFIEN_",","3","IE","DGOUT","DGOUTERR")
 . . S DGSTA=DGOUT(45,PTFIEN_",",3,"I")
 . . I DGSTA="" S DGSTA="NON-VA"
 . . S DGDIVNME="NON-VA HOSPITAL"
 . . I LSTUSR="" S LSTUSR="N/A"
 . S WRDLOC="NON-VA ADMISSION",TRTFCLTY=$S($G(DSCHRGDT)>0:TRTFCLTY,1:"NON-VA FACILITY")
 I $G(DGDIVNME)="" S DGDIVNME="NONE" I $G(DGDIV)="" S DGDIV="NONE"
 I $G(DGSTA)="" S DGSTA="NONE" I $G(LSTUSR)="" S LSTUSR="NONE ENTERED"
 ;the 0 at the end of TMPDATA designates that the is inpatient
 S TMPDATA=DGDIVNME_U_DGSTA_U_WRDLOC_U_$S(TRTFCLTY'="":TRTFCLTY,1:"N/A")_U_LSTUSR_U_DGDIV_U_""_U_PTFIEN405_";"_PTFIEN_U_PRIMDX_U_0
 S DGENCNT=DGENCNT+1
 S @RECORD@(ADMDT,DGSTA,405,DGENCNT)=TMPDATA ;sort by date of service
 I SORTENCBY=2 S @RECORD1@(DGSTA,ADMDT,405,DGENCNT)=TMPDATA ;sort by division
 K DGOUT,DIVINPT
 Q
 ;
