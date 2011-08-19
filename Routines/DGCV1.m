DGCV1 ;ALB/ERC,BRM - COMBAT VET REPORTS; 07/10/2003 ; 2/5/04 2:52pm
 ;;5.3;Registration;**528,565**; Aug 13, 1993
 ;
 ;first report is built during the initial seeding, and called by
 ;POST^DG53528P
RPT(DG) ;if, during initial seeding, a veteran could not be evaluated
 ;for CV eligibility because of an imprecise date the veteran will be
 ;added to the appropriate ^XTMP global
 ;  Input: DG - the code corresponding to the missing or imprecise date
 ;
 K VADM
 I $G(DG)']"" Q
 S ^XTMP("DGCV","REPORT",DFN,DG)=""
 Q
REPORT ;if there are veterans in the ^XTMP globals, create a report.
 I '$D(^XTMP("DGCV","REPORT")) Q
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR
 K IOP,%ZIS
 I $G(XPDQUES("POS1","B"))]"" S ZTIO=$G(XPDQUES("POS1","B")) ;result of install question
 I $G(ZTIO)']"" S IOP=$G(^XTMP("DGCV","DEVICE"))
 S ZTSAVE("*")=""
 S ZTRTN="PRINT^DGCV1",ZTDESC="IMPRECISE COMBAT DATE REPORT"
 D ^%ZTLOAD
EXIT ;
 K XPDQUES
 Q
PRINT ;print report
 N PAGE,QUIT,DFN
 S PAGE=1
 S QUIT=""
 D HDR
 N DGF,DGFD,DGLN,DGNAM,DGSSN
 S (DGF,DFN)=""
 F  S DFN=$O(^XTMP("DGCV","REPORT",DFN)) Q:DFN']""  D
 . Q:'$D(^DPT(DFN))
 . S (DGNAM,DGSSN)=""
 . D DEM(DFN)
 . I $G(DGNAM)']""!($G(DGSSN)']"") Q
 . S DGLN=DGNAM_"^"_DGSSN
 . N DGC
 . F  S DGF=$O(^XTMP("DGCV","REPORT",DFN,DGF)) Q:DGF']""!(QUIT)  D
 . . N DGFF
 . . I $L(DGF)=1 S DGFF=DGF S DGC=1 D SET
 . . I $L(DGF)=2 D
 . . . S DGFF=$E(DGF,1),DGC=1 D SET
 . . . S DGFF=$E(DGF,2),DGC=2 D SET
 W !,">>>>END OF REPORT"
 Q
SET ;
 I DGFF["A"!(DGFF["F") S DGFD="SERVICE SEP"
 I DGFF["B"!(DGFF["G") S DGFD="COMBAT TO"
 I DGFF["C"!(DGFF["H") S DGFD="YUGOSLAVIA TO"
 I DGFF["D"!(DGFF["I") S DGFD="SOMALIA TO"
 I DGFF["E"!(DGFF["J") S DGFD="PERS GULF TO"
 I $G(DGFD)']"" Q
 S DGFD=DGFD_" DATE "_$S("ABCDE"[DGFF:"IMPRECISE",1:"MISSING")
 S DGLN=$S(DGC=1:DGLN_"^"_DGFD,DGC=2:"^^"_DGFD,1:"")
 D ADD(DGLN)
 Q
DEM(DFN) ;
 N VADM
 D DEM^VADPT
 S DGNAM=$G(VADM(1))
 S DGSSN=$P($G(VADM(2)),U,2)
 Q
ADD(DGLN) ;add the line to the report
 N DGX
 I $P(DGLN,U)]"" W !
 W !?2,$P(DGLN,U),?39,$P(DGLN,U,2),?52,$P(DGLN,U,3)
 I $E(IOST,1,2)="C-",($Y>(IOSL-4)) D
 . D PAUSE
 . Q:QUIT
 . D TOP
 I '$E(IOST,1,2)="C-",($Y>(IOSL-2)) D TOP
 Q
 ;
TOP ;
 W @IOF
 D HDR
 Q
 ;
HDR ;print header for report
 N Y
 W !!?5,"REPORT OF UPDATES REQUIRED FOR COMBAT VET STATUS" S Y=DT D DD^%DT W ?62,"Date: ",Y
 W !,?62,"Page: ",PAGE
 W !!?5,"The following patients could not be evaluated for Combat Veteran"
 W !?5,"Eligibility status due to having imprecise or missing dates."
 W !!!?2,"Patient Name",?39,"SSN",?52,"Date to be updated"
 W !?2,"===================================",?39,"===========",?52,"=========================="
 S PAGE=PAGE+1
 Q
 ;
RPT2 ;second report is option DG CV STATUS, a report of what veterans were
 ;assigned CV status during a specified date range
 N DIR,DIRUT,X1,X2,X,Y,DGBEG,DGDT,DGEND
 S DIR(0)="DAO^,"_DT
 S X1=DT,X2=-7 D C^%DTC
 S Y=X D DD^%DT
 S DIR("A")="BEGINNING DATE: "
 S DIR("B")=Y
 S DIR("?")="ENTER THE BEGINNING DATE FOR THE REPORT"
 S DIR("??")="^W !,""A BEGINNING AND AN END DATE MUST BE ENTERED FOR THIS REPORT"""
 D ^DIR
 Q:$D(DIRUT)
 S DGBEG=Y
 S DIR(0)="DAO^"_DGBEG_","_DT
 S Y=DT D DD^%DT S DGDT=Y
 S DIR("B")=DGDT
 S DIR("A")="ENDING DATE: "
 S DIR("?")="ENTER THE ENDING DATE FOR THE REPORT"
 D ^DIR
 Q:$D(DIRUT)
 S DGEND=Y
 D REPORT2(DGBEG,DGEND)
 Q
 ;
REPORT2(DGBEG,DGEND) ;
 I $G(DGBEG)']""!($G(DGEND)']"") W !!,"DATE RANGE NOT SET.  EXITING"  Q
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZUSR,POP,X,ERR
 K IOP,%ZIS
 S %ZIS="Q" D ^%ZIS G:POP EXIT2
 I $D(IO("Q")) D  Q
 . S (ZTSAVE("DGBEG"),ZTSAVE("DGEND"))=""
 . S ZTRTN="PRINT2^DGCV1",ZTDESC="COMBAT VET DATE EDITED REPORT"
 . D ^%ZTLOAD
 . D ^%ZISC,HOME^%ZIS
 . W !,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED!")
 D PRINT2
EXIT2 D ^%ZISC,HOME^%ZIS
 ;Q +G(ZTSK)
 Q
PRINT2 ;
 N DGLN,PAGE,QUIT
 S QUIT=""
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 S DGLN=0
 S PAGE=1
 D HDR2
 D DATA
 I DGLN=0 D
 . W !!!,?30,"No data to report."
 . I $E(IOST,1,2)="C-" D PAUSE
 D EXIT2
 Q
HDR2 ;
 N DG1,DG2,Y
 S Y=DGBEG D DD^%DT S DG1=Y
 S Y=DGEND D DD^%DT S DG2=Y
 W !!?15,"COMBAT VETERAN STATUS CHANGED REPORT"
 S Y=DT D DD^%DT W ?60,"Date: ",Y
 W !?20,DG1_" TO "_DG2
 W ?60,"Page: "_PAGE
 W !!!?3,"NAME",?41,"SSN",?63,"CV END DATE",!?41,"PRIORITY GROUP"
 W !,?3,"===================================",?41,"=================",?63,"============"
 S PAGE=PAGE+1
 Q
DATA ;
 N DGENR,DFN,DGNAM,DGSSN,DGDT,DGX,QUIT,Y,VADM
 S QUIT=""
 Q:$G(DGBEG)']""!($G(DGEND)']"")
 S DGX=DGBEG-1
 F  S DGX=$O(^DPT("E",DGX)) Q:DGX'>0!(DGX>DGEND)  D
 . S DFN=""
 . F  S DFN=$O(^DPT("E",DGX,DFN)) Q:DFN']""!(QUIT)  D
 . . Q:'$D(^DPT(DFN))
 . . K VADM,DGENR
 . . D DEM^VADPT
 . . Q:'$D(VADM)
 . . S DGNAM=VADM(1)
 . . S DGSSN=$P(VADM(2),U,2)
 . . S DGDT=$$GET1^DIQ(2,DFN_",",.5295,"E")
 . . I $G(DGDT)']"" S DGDT="DELETED!!!!"
 . . S DGENR=$$PRIOR(DFN)
 . . I $G(DGENR)']"" S DGENR="NONE"
 . . D ADD2
 Q
PRIOR(DFN) ;gets priority and sub group
 ;
 N DGEN,DGIEN,DGSUB
 I $$GET^DGENA($$FINDCUR^DGENA(DFN),.DGEN) D
 . S DGENR=$G(DGEN("PRIORITY"))
 . S DGSUB=$G(DGEN("SUBGRP"))
 . I $G(DGSUB)]"" S DGENR=DGENR_$$EXTERNAL^DILFD(27.11,.12,"F",DGSUB)
 Q $G(DGENR)
PAUSE ;
 N DIR,DIRUT,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!($D(DIRUT)) S QUIT=1
 Q
ADD2 ;
 I $E(IOST,1,2)="C-",($Y>(IOSL-6)) D
 . D PAUSE
 . Q:QUIT
 . D TOP2
 I '$E(IOST,1,2)="C-",($Y>(IOSL-2)) D TOP2
 I '(QUIT) D LINE
 Q
TOP2 ;
 W @IOF
 D HDR2
 Q
LINE ;add a line to the report
 W !?3,DGNAM,?41,DGSSN,?63,DGDT,!?41,DGENR,!
 S DGLN=1
 Q
