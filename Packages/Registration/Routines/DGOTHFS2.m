DGOTHFS2 ;SLC/RM - FORMER OTH PATIENT DETAIL REPORT 2 ; July 30,2020@09:44am
 ;;5.3;Registration;**1025,1034,1035**;Aug 13, 1993;Build 14
 ;
 ;Global References      Supported by ICR#                   Type
 ;-----------------      -----------------                   ---------
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
 ; EN^IBEFSMUT            7202 DG has permission to access)  Private
 ; RX^PSO52API            4820                               Supported
 ; 2^VADPT               10061                               Supported
 ; KVAR^VADPT            10061                               Supported
 ; $$SITE^VASITE         10112                               Supported
 ; $$FMTE^XLFDT          10103                               Supported
 ; $$CJ^XLFSTR           10104                               Supported
 ; EN^XUTMDEVQ            1519                               Supported
 ;
 ;No direct call
 Q
 ;
 ;Entry point for DG FORMER OTH PATIENTS DETAIL REPORT option
MAIN ; Initial Interactive Processing
 N DGSORT,IBOTHSTAT   ;array of report parameters
 N ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE,ZTSTOP,DGPTNM,DGMTS,VAUTD,%ZIS,DGENCNT,SORTENCBY,DGRTNSTCK,DGPRTLRXFL
 N INACTIVE,DGDFN,DFN,VAEL,VADM,VA,I3,DGPID,DGPAGE,DGRPTSRT,DGTOTALRX,IBOTHSTAT,DGTOTRX52
 N RECORD ;temp data storage for all records found in file #409.68,and #405 sorted by date of service
 N RECORD1 ;temp data storage for all records found in file #409.68,and #405 sorted by division
 ;check for database
 I '+$O(^DGOTH(33,"B","")) W !!!,$$CJ^XLFSTR(">>> No OTH records have been found. <<<",80) D ASKCONT^DGOTHFSM(0) Q
 W @IOF
 S (INACTIVE,DGRPTSRT,DGRTNSTCK,DGPRTLRXFL)=0,SORTENCBY=2
 W "FORMER OTH PATIENT DETAIL REPORT",!!
 W "This option assists billing user in reviewing Former Service Member's past"
 W !,"episodes of care and released prescription details to determine if"
 W !,"potential back-billing is necessary."
 W !!,"*** THIS REPORT REQUIRES 132 COLUMN OUTPUT TO PRINT CORRECTLY ***"
 W !!,"At the DEVICE: prompt, please accept the default value of '0;132;'"
 W !,"This is to deliberately avoid undesired wrapping problems of the data.",!!
 ;prompt user to enter patient
 D PROMPTPT
 Q:'INACTIVE!(DGSORT'>0)
 D RECALL^DILFD(33,+DGSORT_",",DUZ)
 ;Prompt user what type of data/report user wish to see
 ;user had two options: Eligibility or Encounters
 I '$$RPTTYPE Q
 S RECORD=$NA(^TMP($J,"DGOTHFSDOS"))
 S RECORD1=$NA(^TMP($J,"DGOTHFSDIV"))
 S IBOTHSTAT=$NA(^TMP($J,"IBOTHSTAT"))
 K @RECORD ;temp data storage for all records found in file #409.68,and #405 sorted by date of service
 K @RECORD1 ;temp data storage for all records found in file #409.68,and #405 sorted by division
 K ^TMP($J,"OTHFSMR2") ;patient's RX information from File #52
 K ^TMP($J,"OTHFSMRX") ;temporary storage for all Rx information and IB status ready for printing report
 K @IBOTHSTAT ;temp storage for file #350 and file # 399 IB status
 ;if user select report type ALL, prompt user how it will be sorted
 ;do not continue, if user does not select any sorting
 I DGSORT("RTYPE")="A" D  Q:DGRPTSRT<1
 . ;determine first the original date the former OTH service member become EXPANDED
 . ;MH CARE NON-ENROLLEE and loop through all the OTH Registration Date
 . S DGIEN33=DGSORT,(DGENCNT,DGTOTALRX,DGTOTRX52,DGRTNSTCK,DGPRTLRXFL)=0
 . S DGSORT("DGBEG")=$$OTHREGDT(DGIEN33) ;the date when the patient became OTH
 . S DGSORT("DGEND")=$$GET1^DIQ(2,DGDFN_",",.3612,"I") ;the date when the PE eligibility status of patient became VERIFIED
 . S VAUTD=1   ;All the divisions in the facility, since we are not prompting user to enter Division
 . D CHKTREAT^DGFSMOUT(DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),.VAUTD,0) ;check if there any past Outpatient Encounter entry (file #409.68) for this patient
 . D CHECKPTF^DGFSMOUT(DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),"IBOTHSTAT") ;check if there any Inpatient stay entry in file #405
 . D CHECKIB^DGFSMOUT("IBOTHSTAT",DGSORT("DGBEG"),DGSORT("DGEND")) ;check if this patient has records in file #350 or file #399
 . D RX^PSO52API(DGDFN,"OTHFSMR2",,,"2,R,P",DGSORT("DGBEG"),$$FMADD^XLFDT(DGSORT("DGEND"),366)) ;get the medication profile of a patient from PRESCRIPTION file (#52)
 . ;before moving forward remove RX data from the patient's episode of care array first
 . I $O(@RECORD@(""))'="" D FLTRENC^DGOTHFS4 ;determines whether to prompt Encounter sorting
 . I DGTOTALRX<2 S DGTOTRX52=+$P(^TMP($J,"OTHFSMR2",DGDFN,0),U) I +DGTOTRX52>0 D TOTRX^DGOTHFS4 ;determines whether to prompt the Rx sorting and see if the Rx released date is within the date range
 . S DGTOTALRX=DGTOTALRX+DGTOTRX52
 . I $O(@IBOTHSTAT@(""))="" D EN^IBEFSMUT(DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),"IBOTHSTAT") ;extract in advance the IB STATUS in both file #350 and file #399
 . I (DGENCNT>1),(DGTOTALRX>1) D  Q
 . . W !!,"Please select sorting order for Episodes of Care and Released Prescription",!,"report section:"
 . . ;prompt user how the Encounter report section will be sorted
 . . I '$$SORTENC^DGOTHFS3 Q
 . . ;prompt user Rx report section will be sorted
 . . I '$$SORTRX^DGOTHFS3 Q
 . . S DGRPTSRT=1
 . I (DGENCNT>1),(DGTOTALRX<2) D  Q
 . . W !!,"Please select sorting order for Episodes of Care report section:"
 . . I '$$SORTENC^DGOTHFS3 Q
 . . S DGRPTSRT=1,DGSORT("SORTRXBY")=1
 . I (DGENCNT<2),(DGTOTALRX>1) D  Q
 . . W !!,"Please select sorting order for Released Prescription report section:"
 . . I '$$SORTRX^DGOTHFS3 Q
 . . S DGRPTSRT=1
 . . S DGSORT("SORTENCBY")=1
 . S DGSORT("SORTENCBY")=1,DGSORT("SORTRXBY")=1
 . S DGRPTSRT=1
 W !!
 S %ZIS=""
 S %ZIS("B")="0;132;"
 S ZTSAVE("DGSORT(")=""
 S ZTSAVE("DGSORT")=""
 S ZTSAVE("DGDFN")=""
 S ZTSAVE("DGPTNM")=""
 S ZTSAVE("DGTOTALRX")=""
 S X="FORMER OTH PATIENT ELIGIBILITY CHANGE REPORT"
 D EN^XUTMDEVQ("START^DGOTHFS2",X,.ZTSAVE,.%ZIS)
 D HOME^%ZIS
 Q
 ;
START ;starting point to generate report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name where the report is run
 N TRM S TRM=($E(IOST)="C")
 S (DGQ,DGPAGE,I3)=0
 S DGIEN33=DGSORT
 S DFN=DGDFN
 S DGPID=$$GET1^DIQ(2,DFN_",",.0905,"I")
 ;display the patient's current and verified eligibility
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
 ;display patient's all Primary Eligibility history
 D HISTORY(DGIEN33)
 Q:DGQ
 ;if user wants to see patient Encounter and Rx information
 I DGSORT("RTYPE")="A" D
 . ;display patient's checked out Encounters and inpatient data
 . D ENCTR(DGDFN,.DGSORT)
 . Q:DGQ
 . ;display patient's Released Prescriptions
 . D RX(DGDFN,.DGSORT)
 D KVAR^VADPT
 K @RECORD,@RECORD1,@IBOTHSTAT,^TMP($J,"OTHFSMR2"),^TMP($J,"OTHFSMRX")
 D EXIT^DGOTHFSM
 Q
 ;
PROMPTPT ;prompt user to enter patient
 ;keep prompting for patient name until user enter patient with INACTIVE status
 F  D  Q:INACTIVE
 . ;Prompt user for OTH patient name
 . S DGPTNM=$$SELPAT(.DGSORT)
 . I DGSORT'>0 S INACTIVE=1 Q
 . I $$ACTIVE(.DGSORT) D  Q
 . . W !!,"The patient you selected is still PENDING for VBA Adjudication."
 . . D RUNOPT
 . ;if INACTIVE STATUS, check if the eligibility status is VERIFIED
 . S DGDFN=$P(DGSORT(0),U)
 . I $$GET1^DIQ(2,DGDFN_",",.3611,"I")'="V" D  Q
 . . W !!,"The primary eligibility status of the patient you selected is not VERIFIED."
 . . D RUNOPT
 . S INACTIVE=1
 Q
 ;
RUNOPT ;display message to run FORMER OTH PATIENT ELIGIBILITY CHANGE REPORT option
 W !,"Please run FORMER OTH PATIENT ELIGIBILITY CHANGE REPORT option"
 W !,"to identify Former OTH Service Member whose Primary Eligibility"
 W !,"changed from EXPANDED MH CARE NON-ENROLLEE to a new Primary"
 W !,"Eligibility with a VERIFIED eligibility status.",!
 Q
 ;
ACTIVE(DGSORT) ;determine the current status of OTH patient
 ;return 0 for INACTIVE
 ;otherwise, 1 for ACTIVE
 N DGIEN33,DGOTHSTAT
 S DGIEN33=DGSORT
 S DGOTHSTAT=$$GET1^DIQ(33,DGIEN33_",",.02,"I")
 Q DGOTHSTAT
 ;
SELPAT(DGSORT) ;prompt for veteran's name
 ;- input vars for ^DIC call
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DGOTH(33,",DIC(0)="AEMQZV"
 S DIC("A")="Enter Patient Name: "
 S DIC("?PARAM",33,"INDEX")="B"
 S DIC("?N",33)=12
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
 S DGDIRO="SAO^E:Eligibility;A:All (Eligibility, Episodes of Care, Prescription)"
 S DGASK=$$ANSWER^DGOTHFSM(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK="E"!(DGASK="A") S DGSORT("RTYPE")=DGASK,DGASK=1
 E  S DGASK=0
 Q DGASK
 ;
CURRENT(DFN,PTNAME) ;display patient current and verified PE eligibility
 N I1,DGENR,DGENRIEN,DGENRPRI,DGENRGRP
 S (DGENRIEN,DGENRPRI,DGENRGRP)=""
 D 2^VADPT
 D PTHDR("FORMER OTH PATIENT DETAIL REPORT")
 D LINE(0)
 W !,"Current Eligibility Code :  ",$P(VAEL(1),"^",2),"  --  ",$S(VAEL(8)']"":"NOT VERIFIED",1:$P(VAEL(8),"^",2))
 W "     ",$$FMTE^XLFDT($$GET1^DIQ(2,DGDFN_",",.3612,"I"),"5Z") ;PE eligibility changed date
 W !,"Other Eligibility Code(s):  " I $D(VAEL(1))>9 S I1=0 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1 W:I1>1 !?28 W $P(VAEL(1,I),"^",2)
 E  W "NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 S DGENRIEN=$$FINDCUR^DGENA(DFN)
 I DGENRIEN'="" S DGENRPRI=$$GET1^DIQ(27.11,DGENRIEN_",",.07,"E"),DGENRGRP=$$GET1^DIQ(27.11,DGENRIEN_",",.12,"E")
 W !,"Enrollment Priority      :  ",$S(DGENRIEN="":"NOT ENROLLED",((DGENRPRI="")&(DGENRGRP="")):"NONE STATED",1:DGENRPRI_DGENRGRP)
 W ! D LINE(1)
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
 . I $Y>(IOSL-4) W ! D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0)
 . W:I3>1 !?20
 . W $G(DGP1)_" - ",$E(DGP2,1,30)," ",DGP3
 W:'I3 "NONE STATED"
 Q
 ;
INS(DFN) ;display patient's health insurance information
 N Z,I,I1
 ;if patient had more than 6 rated disability, then display the insurance information in a separate page
 I I3>6 W !! D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0)
 W !!,"Health Insurance  : "
 S Z=$$INSUR^IBBAPI(DFN,DT)
 W $S(Z:"YES",1:"NO")
 D DISP^DGIBDSP
 K I,I1,Z
 I $G(DGMTS)="" W !
 Q
 ;
HISTORY(IEN33) ;extract all eligibility history
 N DGELHIST,DGOTHIST,DGRECNUM,DGLINE,DGOTHTYP
 ;display this piece of information to its own page so that the report will not look cluttered
 D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0) W !
 D HDR(0)
 W !
 K DGOTHIST
 S DGELHIST=$$CROSS^DGOTHINQ(IEN33,.DGOTHIST)
 ;go through all the eligibility history and only display date starting from Feb. 20,2020
 ;3200220 is the Release Date of EXPANDED MH CARE NON-ENROLLEE
 S DGRECNUM="" F  S DGRECNUM=$O(DGOTHIST(IEN33,DGRECNUM)) Q:DGRECNUM=""  D  Q:DGQ
 . I $Y>(IOSL-4) W ! D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0) W !! D HDR(1)
 . S DGLINE=DGOTHIST(IEN33,DGRECNUM)
 . S DGOTHTYP=$$OTHTYP^DGOTHINQ($P(DGLINE,U))
 . W $S($P(DGLINE,U)="":"UNKNOWN",+DGOTHTYP:"EXPANDED MH CARE NON-ENROLLEE"_"  ("_$P(DGLINE,U)_")",1:$P(DGLINE,U))
 . I $P(DGLINE,U)="EXPANDED MH CARE NON-ENROLLEE" W "  (N/A)"
 . W ?60,$$FMTE^XLFDT($P(DGLINE,U,2),"5Z")
 . W !
 ;break before going back to parent menu
 I DGSORT("RTYPE")="E" W !!,"<< end of report >>" D ASKCONT^DGOTHFSM(0)  W @IOF
 Q
 ;
OTHREGDT(DGIEN33) ;determine the original date the former OTH service member become EXPANDED MH CARE NON-ENROLLEE
 ;return the original OTH registration date
 N DGFOUND,DGTOTREC,DGRECNUM,DGOTHARR,DGOTHREGDT,DGERR,DGREGDT,II
 S (DGFOUND,DGTOTREC,DGOTHREGDT)=0
 S DGTOTREC=$P(^DGOTH(33,DGIEN33,2,0),U,4)
 Q:+DGTOTREC<1
 F II=1:1:DGTOTREC S DGREGDT(II)=""
 S DGRECNUM="" F  S DGRECNUM=$O(DGREGDT(DGRECNUM)) Q:DGRECNUM=""!(DGFOUND)  D
 . K DGOTHARR,DGERR
 . D GETS^DIQ(33,DGIEN33_",","2*","IE","DGOTHARR","DGERR")
 . Q:$D(DGERR)
 . ;check if the eligibility is EXPANDED MH CARE NON-ENROLLEE
 . I DGOTHARR(33.02,DGRECNUM_","_DGIEN33_",",.02,"E")="EXPANDED MH CARE NON-ENROLLEE" D
 . . ;the original OTH registration date
 . . S DGOTHREGDT=$G(DGOTHARR(33.02,DGRECNUM_","_DGIEN33_",",.01,"I"))
 . . S DGFOUND=1
 Q DGOTHREGDT\1
 ;
ENCTR(DFN,DGSORT) ;display patient's episodes of care
 N DGDIV,DGENCTRDT,DGTOTENC,SUB1,SUB2,JJ,DGENCTRIB,FILENO,STAT350,STAT399,BILLNO,ACRTYP,CHRGCNT,PRINTRPT
 ;display this piece of information to its own page so that the report will not look cluttered
 D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0)
 D ENCHDR(0),ENCTRCOL,LINE(1)
 S (DGTOTENC,PRINTRPT)=0
 I $O(@RECORD@(""))="" D
 . W !!,">> NO DATA FOUND FROM "_$$FMTE^XLFDT(DGSORT("DGBEG"),"5ZF")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5ZF")_"."
 . W ! D LINE(1)
 . Q:DGQ
 . W !!,"Total Number of Encounter:  ",DGTOTENC
 E  D
 . I 'PRINTRPT D
 . . I $P(DGSORT("SORTENCBY"),U)=2 D
 . . . K @RECORD
 . . . M @RECORD=@RECORD1
 . . . K @RECORD1
 . . D ENCTRIB^DGOTHFS3 ;extract the IB status
 . . S PRINTRPT=1
 . D ENCTRIB^DGOTHFS3 ;use the same loop to display status
 Q
 ;
ENCTRCOL ;display encounter column name
 W !,"Location of",?22,"Clinic Stop/",?45,"Primary",?55,"Div.",?61,"Date of",?72,"Last Updated",?89,"Bill #",?100,"Action Type/",?116,"IB Status"
 W !,"Care",?22,"Treating Specialty",?45,"DX",?61,"Service",?77,"By",?100,"Rate Type",!
 Q
 ;
ENCHDR(FLAG) ;Encounter Header
 N TITLE
 S TITLE="PATIENT'S EPISODE OF CARE"_$S(FLAG:" - Continuation",1:"")
 W !,?132-$L(TITLE)\2,TITLE,!
 D DTRANGE
 S TITLE="Sorted By: "_$E($P(DGSORT("SORTENCBY"),U,2),4,20)
 I $P(DGSORT("SORTENCBY"),U,2)'="" W ?132-$L(TITLE)\2,TITLE,!
 D LINE(1)
 Q
 ;
DTRANGE ;display date range
 N DTRANGE
 S DTRANGE="Date Range: "_$$FMTE^XLFDT(DGSORT("DGBEG"),"5ZF")_" - "_$$FMTE^XLFDT(DGSORT("DGEND"),"5ZF")
 W ?132-$L(DTRANGE)\2,DTRANGE,!
 Q
 ;
RX(DFN,DGSORT) ;extract patient's released prescription
 N FILENO,OTHIBDT,OTHIBREC,ACCTYP,RESULT,CNTR,OTHIBRX
 ;display this piece of information to its own page so that the report will not look cluttered
 D PAUSE(.DGQ) Q:DGQ  D PTHDR,LINE(0)
 ;traverse ^TMP($J,"IBOTHSTAT" if the dates listed exist 
 ;in the ^TMP($J,"OTHFSMR2", this is where all the RX's of the patient
 ;is stored.
 S CNTR=0
 F FILENO=350,399 D  Q:DGQ
 . Q:$P(^TMP($J,"IBOTHSTAT",FILENO,DFN,0),U)<1
 . S OTHIBDT="" F  S OTHIBDT=$O(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT)) Q:OTHIBDT=""  D  Q:DGQ
 . . S OTHIBREC="" F  S OTHIBREC=$O(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC)) Q:OTHIBREC=""  D  Q:DGQ
 . . . ;quit if not within the date range selected by the user
 . . . Q:'$$CHKDATE(OTHIBDT,.DGSORT)
 . . . I FILENO=350 D  Q:ACCTYP'["RX"
 . . . . S ACCTYP=$P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U)
 . . . I FILENO=399 D  Q:$P(ACCTYP,U)'=3
 . . . . S ACCTYP=$P($P($P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,5),";"),":")
 . . . S RESULT=$P(^TMP($J,"IBOTHSTAT",FILENO,OTHIBDT,DFN,OTHIBREC),U,5)
 . . . I $P(RESULT,":")=52 S OTHIBRX=+$P(RESULT,":",2) ;file #350 RX IEN 
 . . . I $P(RESULT,":")=350 S OTHIBRX=0
 . . . I ACCTYP=3 S OTHIBRX=$P(RESULT,":",3) ;file #399 RX IEN
 . . . D RX1^DGOTHFS3
 . . Q:DGQ
 . Q:DGQ
 I DGQ K ^TMP($J,"OTHFSMR2"),^TMP($J,"OTHFSMRX") Q
 D RXNOSTAT^DGOTHFS3 ;Extract those RX's that has not been charge
 D PRINTRX^DGOTHFS4
 K ^TMP($J,"OTHFSMR2"),^TMP($J,"OTHFSMRX")
 W !!,"<< end of report >>"
 Q:DGQ
 D ASKCONT^DGOTHFSM(0)  W @IOF
 Q
 ;
LINE(FLAG) ;prints double dash line
 N LINE
 I FLAG<1 F LINE=1:1:132 W "="
 E  F LINE=1:1:132 W "-"
 Q
 ;
PTHDR(TITLE) ;patient name and DOB header
 S TITLE=$G(TITLE)
 I $G(TRM)!('$G(TRM)&DGPAGE) W @IOF
 I $L(TITLE) W ?132-$L(TITLE)\2,TITLE W !!
 S DGPAGE=$G(DGPAGE)+1
 W "Patient Name:  ",DGPTNM_"  ("_DGPID_")",?112,"DOB:  ",$P(VADM(3),U,2),!
 Q
 ;
HDR(FLAG) ;Primary Eligibility History header
 N TITLE
 S TITLE="PRIMARY ELIGIBILITY/EXPANDED CARE TYPE HISTORY"_$S(FLAG:" - Continuation",1:"")
 W ?132-$L(TITLE)\2,TITLE,!
 D LINE(1)
 W "Primary Eligibility",?60,"Date of Change",!
 D LINE(1)
 Q
 ;
PAUSE(DGQ) ; pause screen display
 N J
 I $Y<(IOSL-4) D
 . F J=1:1 Q:($Y>(24-4))  W !
 I $G(DGPAGE)>0,TRM,$$E("Press <Enter> to continue or '^' to exit:")<1 S DGQ=1
 Q
 ;
E(MSG) ; ----- ask user to press enter to continue
 ;  Return: -2:Time-out; -1:'^'-out  1:anything else
 S MSG=$G(MSG)
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="EA"
 I $L(MSG) S DIR("A")=MSG
 D ^DIR
 S X=$S($D(DTOUT):-2,$D(DUOUT):-1,1:1)
 Q X
 ;
HELP ;provide extended DIR("?") help text.
 I (X="?")!(X="??") D
 . W !,"Select ""E""ligibility if you wish to see the Primary Eligibility history"
 . W !,"          Means Test, and Health Insurance information of the selected"
 . W !,"          patient.",!
 . W !,"Select ""A""ll if you wish to see the Primary Eligibility history,"
 . W !,"          Means Test, Health Insurance information, Patient's"
 . W !,"          Episodes of Care, and patient's Released Prescriptions"
 . W !,"          of the selected patient.",!
 Q
 ;
CHKDATE(DATE,DGSORT) ;check if dates fall within the Begin and End dates
 Q DGSORT("DGBEG")<=DATE&(DGSORT("DGEND")>=DATE)
 ;
