DGPPDRPT ;SLC/RM - PRESUMPTIVE PSYCHOSIS RECONCILIATION REPORT ; Dec 21, 2020@10:00 am
 ;;5.3;Registration;**1035**;Aug 13, 1993;Build 14
 ;
 ;Global References      Supported by ICR#                  Type
 ;-----------------      -----------------                  -----------
 ; ^DG(391               2966 (DG is the Custodial Package)  Cont. Sub.
 ; ^DIC(31               733                                 Cont. Sub.
 ; ^TMP($J               SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; HOME^%ZIS             10086                               Supported
 ; $$FINDCUR^DGENA        3812 (DG is the Custodial Package) Cont. Sub.
 ; DISP^DGIBDSP           4408 (DG is the Custodial Package) Cont. Sub.
 ; $$MTS^DGMTU             642 (DG is the Custodial Package) Cont. Sub.
 ; DIS^DGMTU              3789 (DG is the Custodial Package) Cont. Sub.
 ; $$RDIS^DGRPDB          4807                               Supported
 ; ^DIC                  10006                               Supported
 ; WAIT^DICD             10024                               Supported
 ; RECALL^DILFD           2055                               Supported
 ; $$GET1^DIQ             2056                               Supported
 ; $$GET1^DIQ(27.11       4947 (DG is the Custodial Package) Private
 ; ^DIR                  10026                               Supported
 ; $$INSUR^IBBAPI         4419                               Supported
 ; 2^VADPT               10061                               Supported
 ; KVAR^VADPT            10061                               Supported
 ; $$SITE^VASITE         10112                               Supported
 ; $$FMTE^XLFDT          10103                               Supported
 ; EN^XUTMDEVQ            1519                               Supported
 Q
 ;
 ;Main entry point for PRESUMPTIVE PSYCHOSIS PATIENT DETAIL REPORT option
MAIN ; Initial Interactive Processing
 N DGSORT,IBOTHSTAT   ;array of report parameters
 N ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE,ZTSTOP,DGPTNM,DGMTS,VAUTD,%ZIS,SORTENCBY,DGQ
 N DGDFN,DFN,VAEL,VADM,VA,I3,DGPID,DGPAGE,DGPPDT,IBOTHSTAT,DGPPWRK,DGPPCAT,DGPPYN
 N RECORD ;temp data storage for all records found in file #409.68,and #405 sorted by date of service
 N RECORD1 ;temp data storage for all records found in file #409.68,and #405 sorted by division
 W @IOF
 S DGPPDT=0,SORTENCBY=2
 W "PRESUMPTIVE PSYCHOSIS PATIENT DETAIL REPORT",!!
 W "This option generates a report of an individual  patient treated under"
 W !,"Presumptive Psychosis authority within the user specified date range."
 W !!,"*** THIS REPORT REQUIRES 132 COLUMN OUTPUT TO PRINT CORRECTLY ***"
 W !!,"At the DEVICE: prompt, please accept the default value of '0;132;'"
 W !,"This is to deliberately avoid undesired wrapping problems of the data.",!!
 ;prompt user to enter patient
 D PROMPTPT
 Q:DGPPYN<1!(+DGSORT<1)
 D RECALL^DILFD(2,+DGSORT_",",DUZ)
 ;Prompt user what type of data/report user wish to see
 ;user had two options: Eligibility or Encounters
 W !
 I '$$RPTTYPE Q
 ;if user selected "ALL", prompt user the DATE FROM and TO for report reconcilliation
 I DGSORT("PPRTYPE")="A" D  Q:'DGPPDT
 . W !!,"Please specify a date range for Episodes of Care and Released Prescription:"
 . ;Prompt user for FROM Date of Eligibility Change
 . I '$$DATEFROM^DGPPRRPT Q
 . ;Prompt user for TO Date of Eligibility Change
 . I '$$DATETO^DGPPRRPT Q
 . S DGPPDT=1
 ;
 S RECORD=$NA(^TMP($J,"DGPPDDOS"))
 S RECORD1=$NA(^TMP($J,"DGPPDDIV"))
 S IBOTHSTAT=$NA(^TMP($J,"DGPPIBSTAT"))
 K @RECORD ;temp data storage for all records found in file #409.68, #405, #45 sorted by date of service
 K @RECORD1 ;temp data storage for all records found in file #409.68, #405, #45 sorted by division
 K ^TMP($J,"DGPPDRX52") ;patient's RX information from File #52
 K ^TMP($J,"DGALLPPDRX") ;temporary storage for all Rx information and IB status for printing the report
 K @IBOTHSTAT ;temp storage for file #350 and file # 399 IB status
 W !!
 S %ZIS=""
 S %ZIS("B")="0;132;"
 S ZTSAVE("DGSORT(")=""
 S ZTSAVE("DGDFN")=""
 S X="PRESUMPTIVE PSYCHOSIS PATIENT DETAIL REPORT"
 D EN^XUTMDEVQ("START^DGPPDRPT",X,.ZTSAVE,.%ZIS)
 D HOME^%ZIS
 Q
 ;
PROMPTPT ;prompt user to enter patient
 S DGPPYN=0
 ;keep prompting for patient name until user enter patient with PP VA Workaround exist or PP Category
 F  D  Q:DGPPYN
 . ;Prompt user for OTH patient name
 . S DGPTNM=$$SELPAT(.DGSORT)
 . I +DGSORT'>0 S DGPPYN=1 Q
 . S (DGDFN,DFN)=DGSORT
 . S DGPPWRK=$$PPWRKARN^DGPPAPI(DGDFN) ;check if this patient is registered correctly using PP VA workaround settings
 . S DGPPCAT=$$PPINFO^DGPPAPI(DGDFN) ;check for PP category exist
 . I $P(DGPPCAT,U)'="Y" S DGPPCAT="N"
 . I DGPPWRK="N",($P(DGPPCAT,U)="N") D  Q
 . . W !!,"WARNING:  ** The patient you entered is not a  Presumptive Psychosis patient."
 . . W !,"             Please enter another patient.",!!
 . S DGPPYN=1
 Q
 ;
SELPAT(DGSORT) ;prompt for veteran's name
 ;- input vars for ^DIC call
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DPT(",DIC(0)="AEMQZV"
 S DIC("A")="Enter Patient Name: "
 S DIC("?PARAM",2,"INDEX")="B"
 ;- lookup patient
 D ^DIC K DIC
 ;- result of lookup
 S DGSORT=Y
 ;- if success, setup return array using output vars from ^DIC call
 I (+DGSORT>0) D  Q Y(0,0)  ;patient name
 . S DGSORT=+Y              ;patient ien
 . S DGSORT(0)=$G(Y(0))     ;zero node of patient in (#2) file
 Q -1
 ;
RPTTYPE() ;prompt for type of data user wish to see
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select the type of report ('E'ligibility/'A'll):  "
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHFS2"
 S DGDIRO="SAO^E:Eligibility;A:All (Eligibility, Encounter, Prescription)"
 S DGASK=$$ANSWER^DGOTHFSM(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK="E"!(DGASK="A") S DGSORT("PPRTYPE")=DGASK,DGASK=1
 E  S DGASK=0
 Q DGASK
 ;
START ;starting point to generate report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name where the report is run
 N TRM S TRM=($E(IOST)="C")
 N DGENCNT,DGPPFLGRPT,NOREC,DGYN
 S (DGQ,DGPAGE,I3,DGENCNT,NOREC,DGYN)=0
 S DGPID=$$GET1^DIQ(2,DFN_",",.0905,"I")
 S VAUTD=1   ;All the divisions in the facility, since we are not prompting user to enter Division
 S DGPPFLGRPT=1 ;this flag will be used to determine which mumps code to execute in DGFSMOUT routine
 ;only display PP patients with records found in either of the files #409.68, #45, #405, #350, #399, and file #52 record
 I DGSORT("PPRTYPE")="A" D
 . D GETDATA
 . I $O(@RECORD@(""))="" D NOREC
 I NOREC,'DGYN D CLEAN W !! D ASKCONT^DGOTHFSM(0) W @IOF Q
 ;display its eligibility, episodes of care and released prescription if there any
 ;display the patient's current and verified eligibility
 N VA,VADM,VAEL
 D 2^VADPT
 D CURRENT(DGDFN,DGPTNM)
 W !
 ;display patient's Means Test Status information
 D MTS(DGDFN)
 ;display patient's Rated Disabilities information
 D RTDDIS(DGDFN)
 Q:DGQ
 ;display patient's Insurance information
 D INS(DGDFN)
 Q:DGQ
 ;if user wants to see patient Encounter and Rx information
 I DGSORT("PPRTYPE")="A" D
 . I 'NOREC,DGYN Q  ;if no record found, we are only displaying the Eligibility portion if user answers Y to the question
 . D PPENCTR(DGDFN,.DGSORT) ;display patient's checked out Encounters and inpatient data if there are any
 . Q:DGQ
 . D PPRX^DGPPDRX(DGDFN,.DGSORT) ;display patient's Released Prescriptions
 D CLEAN
 Q:DGQ
 D ASKCONT^DGOTHFSM(0) W @IOF
 Q
 ;
CLEAN ;clean up data
 D KVAR^VADPT
 K @RECORD,@RECORD1,@IBOTHSTAT,^TMP($J,"DGPPDRX52"),^TMP($J,"DGALLDPPRX")
 D EXIT^DGOTHFSM
 Q
 ;
GETDATA ;Extract records for a patient in files #409.68, #45, #405, #350, #399, and file #52
 D CHKTREAT^DGFSMOUT(DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),.VAUTD,0) ;check if there any past Outpatient Encounter entry (file #409.68) for this patient
 D CHECKPTF^DGFSMOUT(DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),"DGPPIBSTAT") ;check if there any Inpatient stay entry in file #405 and file #45
 D CHECKIB^DGFSMOUT("DGPPIBSTAT",DGSORT("DGBEG"),DGSORT("DGEND")) ;check if this patient has records in file #350 or file #399
 D CHECKRX^DGFSMOUT("DGPPDRX") ;check at file #52 if this patient has any RX not yet charged
 Q
 ;
NOREC ;diplay verbiage if no recor found
 N VA,VADM,VAEL
 D 2^VADPT
 D PTHDR^DGPPDRP1("PRESUMPTIVE PSYCHOSIS PATIENT DETAIL REPORT")
 D LINE^DGPPDRP1(0)
 W !!!,">> No Episode of Care and Released Prescription found FROM "_$$FMTE^XLFDT(DGSORT("DGBEG")\1,"5ZF")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND")\1,"5ZF")
 W !,"   You may repeat the query with a different date range."
 W !,"   Or run the Presumptive Psychosis Reconciliation Report option to"
 W !,"   identify Presumptive Psychosis patients with Episode(s) of Care or"
 W !,"   Released Prescription."
 W !!
 S DGYN=$$YESNO("Do you still want to view the Eligibility section of the report (Y/N)")
 I DGYN S NOREC=0 Q
 S NOREC=1
 D CLEAN
 Q
 ;
YESNO(QUESTION) ;prompt user if still want to display the eligibility portion though no EOC or Rx found
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=QUESTION
 S DIR("?")=" "
 S DIR("?",1)="  Enter 'Y'es if you still want to view the Eligibility of the patient."
 S DIR("?",2)="  Otherwise, enter 'N'o"
 D ^DIR
 Q +Y
 ; 
CURRENT(DFN,PTNAME) ;display patient current and verified PE eligibility
 N I1,DGENR,DGENRIEN,DGENRPRI,DGENRGRP
 S (DGENRIEN,DGENRPRI,DGENRGRP)=""
 D 2^VADPT
 D PTHDR^DGPPDRP1("PRESUMPTIVE PSYCHOSIS PATIENT DETAIL REPORT")
 D LINE^DGPPDRP1(0)
 W !,"Current Eligibility Code :  ",$P(VAEL(1),"^",2),"  --  ",$S(VAEL(8)']"":"NOT VERIFIED",1:$P(VAEL(8),"^",2))
 W "     ",$$FMTE^XLFDT($$GET1^DIQ(2,DFN_",",.3612,"I"),"5Z") ;PE eligibility changed date
 W !,"Other Eligibility Code(s):  " I $D(VAEL(1))>9 S I1=0 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1 W:I1>1 !?28 W $P(VAEL(1,I),"^",2)
 E  W "NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 W !,"Presumptive Psychosis    :  ",$S($P(DGPPCAT,U,3)'="":$P(DGPPCAT,U,3),1:"NONE STATED")
 S DGENRIEN=$$FINDCUR^DGENA(DFN)
 I DGENRIEN'="" S DGENRPRI=$$GET1^DIQ(27.11,DGENRIEN_",",.07,"E"),DGENRGRP=$$GET1^DIQ(27.11,DGENRIEN_",",.12,"E")
 W !,"Enrollment Priority      :  ",$S(DGENRIEN="":"NOT ENROLLED",((DGENRPRI="")&(DGENRGRP="")):"NONE STATED",1:DGENRPRI_DGENRGRP)
 W ! D LINE^DGPPDRP1(1)
 Q
 ;
MTS(DFN) ;display patient's Means Test Status information
 S DGMTS=$$MTS^DGMTU(DFN)
 I DGMTS="" W !,"Means Test Status : NOT IN MEANS TEST FILE"
 E  D DIS^DGMTU(DFN)
 Q
 ;
RTDDIS(DFN) ;display patient's rated disabilities information
 N DGPTYPE,DGC,DGARR
 W !!,"Service Connected : ",$S('+VAEL(3):"NO",1:"YES")
 W:+VAEL(3) ?33,"SC Percent :  ",$P(VAEL(3),"^",2)_"%"
 W !!,"Rated Disabilities: " I 'VAEL(4),$S('$D(^DG(391,+VAEL(6),0)):1,$P(^(0),"^",2):0,1:1) W "NOT A VETERAN" Q
 I '$$RDIS^DGRPDB(DFN,.DGARR) W "NONE STATED" Q
 F DGC=0:0 S DGC=$O(DGARR(DGC)) Q:'DGC  D  Q:DGQ
 . S I3=I3+1
 . N DGP1,DGP2,DGP3,DGZERO
 . I $G(DGARR(DGC))']"" Q
 . S DGZERO=+DGARR(DGC)
 . I '$D(^DIC(31,DGZERO,0)) Q
 . S DGP1=$P(^DIC(31,DGZERO,0),U,3)
 . S DGP2=$P(^DIC(31,DGZERO,0),U)
 . S DGP3="("_$S($P(DGARR(DGC),U,3)=1:$P(DGARR(DGC),U,2)_"% SC",$P(DGARR(DGC),U,3)]"":$P(DGARR(DGC),U,2)_"% NSC",1:"Unspecified")_")"
 . I $Y>(IOSL-4) W ! D PAUSE^DGPPDRP1(.DGQ) Q:DGQ  D PTHDR^DGPPDRP1,LINE^DGPPDRP1(0)
 . W:I3>1 !?20
 . W $G(DGP1)_" - ",$E(DGP2,1,30)," ",DGP3
 W:'I3 "NONE STATED"
 Q
 ;
INS(DFN) ;display patient's health insurance information
 N Z,I,I1
 ;if patient had more than 6 rated disability, then display the insurance information in a separate page
 I I3>6 W !! D PAUSE^DGPPDRP1(.DGQ) Q:DGQ  D PTHDR^DGPPDRP1,LINE^DGPPDRP1(0)
 W !!,"Health Insurance  : "
 S Z=$$INSUR^IBBAPI(DFN,DT)
 W $S(Z:"YES",1:"NO")
 D DISP^DGIBDSP
 K I,I1,Z
 I $G(DGMTS)="" W !
 ;break before going back to parent menu
 I DGSORT("PPRTYPE")="E" D
 . I $Y>(IOSL-4) W ! D PAUSE^DGPPDRP1(.DGQ) Q:DGQ  D PTHDR^DGPPDRP1,LINE^DGPPDRP1(0)
 . W !!,"<< end of report >>"
 Q
 ;
PPENCTR(DFN,DGSORT) ;display patient's checked out Encounters and inpatient data
 N DGTOTENC,PRINTRPT,PPFLG
 S DGTOTENC=0
 D PAUSE^DGPPDRP1(.DGQ) Q:DGQ  D PTHDR^DGPPDRP1,LINE^DGPPDRP1(0)
 D ENCHDR^DGPPDRP1(0),ENCTRCOL^DGPPDRP1,LINE^DGPPDRP1(1)
 I $O(@RECORD@(""))="" D NOREC
 E  D
 . S $P(DGSORT("SORTENCBY"),U)=1,PRINTRPT=0,PPFLG=1
 . D EOC ;remove any RX record and extract the IB status for the oupatient and inpatient record(s)
 . S PRINTRPT=1 D EOC ;display PP episode of care
 Q
 ;
EOC ;remove any RX record and extract the IB status for the oupatient and inpatient record(s)
 N DGPPDOS,DGPPDIV,FILENO,RECNT,RESULT,STATCNTR,ACTYP,OLDIEN,ENCDT,STATNUM,CHRGCNT,TMPDATA
 N NWBILL,OLDBILL,OLDOEDT,SUB1,SUB2,PRNTSEC,DFN405,DFN409,IBFILENO,OUTPATARY
 S OLDIEN=""
 S (CHRGCNT,PRNTSEC)=0
 I PRINTRPT S (OLDBILL,OLDOEDT)=""
 S DGPPDOS="" F  S DGPPDOS=$O(@RECORD@(DGPPDOS)) Q:DGPPDOS=""  D  Q:DGQ
 . S DGPPDIV="" F  S DGPPDIV=$O(@RECORD@(DGPPDOS,DGPPDIV)) Q:DGPPDIV=""  D  Q:DGQ
 . . S FILENO="" F  S FILENO=$O(@RECORD@(DGPPDOS,DGPPDIV,FILENO)) Q:FILENO=""  D  Q:DGQ
 . . . S RECNT="" F  S RECNT=$O(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT)) Q:RECNT=""  D  Q:DGQ
 . . . . S CHRGCNT=0,(ACTYP,ENCDT,STATNUM)=""
 . . . . S SUB1=DGPPDOS,SUB2=DGPPDIV
 . . . . I FILENO=350 S ACTYP=$P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT),U,7)
 . . . . I FILENO=399 S ACTYP=$P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT),U,12)
 . . . . I ACTYP["RX"!(ACTYP["PRESCRIPTION")!(FILENO=52) K @RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT) Q  ;remove any RX record
 . . . . S ENCDT=DGPPDOS,STATNUM=DGPPDIV
 . . . . I 'PRINTRPT,(FILENO=409.68!(FILENO=405)) D
 . . . . . F IBFILENO=350,399 D
 . . . . . . S (DFN405,DFN409)=0
 . . . . . . I FILENO=409.68!(FILENO=405) S (DFN405,DFN409)=$P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT),U,7) ;file #409.68 IEN
 . . . . . . I FILENO=405,$P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT),U,8)'="" S DFN405=$P($P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT),U,8),";") ;file #405 IEN for file #350 evaluation
 . . . . . . I IBFILENO=399 S DFN405=$P($P(@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT),U,8),";",2) ;File #45 IEN for file #399 record evaluation
 . . . . . . D IBSTATUS^DGFSMOUT(IBFILENO,ENCDT)
 . . . . I PRINTRPT>0 D
 . . . . . S TMPDATA=@RECORD@(DGPPDOS,DGPPDIV,FILENO,RECNT)
 . . . . . S NWBILL=$S(FILENO=350:$P($P(TMPDATA,U,10),"-",2),FILENO=399:$P(TMPDATA,U,11),1:0)
 . . . . . D PRNTENC^DGPPDRP1(TMPDATA,ENCDT) K TMPDATA S OLDBILL=NWBILL,OLDOEDT=ENCDT\1
 . . . . Q:DGQ
 . . . Q:DGQ
 . . Q:DGQ
 . Q:DGQ
 I PRINTRPT D
 . I $O(@RECORD@(""))="" D NOREC1 Q
 . Q:DGQ
 . W ! D LINE^DGPPDRP1(1)
 . W !!,"Total Number of Episode(s) of Care:  ",DGTOTENC
 K OUTPATARY
 Q
 ;
NOREC1 ;display no record verbiage back to the screen of the user
 W !!,">> No Episode of Care found for the date range "_$$FMTE^XLFDT(DGSORT("DGBEG"),"5ZF")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5ZF")_"."
 W !,"   You may repeat the query with a different date range.",!
 W ! D LINE^DGPPDRP1(1)
 Q:DGQ
 W !!,"Total Number of Episode(s) of Care:  ",DGTOTENC
 Q
 ;
