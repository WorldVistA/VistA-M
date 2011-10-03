DGPHIST ;WASH/ERC - PURPLE HEART REQUEST HISTORY ;23 AUG 00
 ;;5.3;Registration;**343**,Aug 13, 1993
 ;
 ;This report will show the Purple Heart Request history on a patient
 Q
 ;
EN ;Entry point
 N DGDFN,DGPAT,DGNAM,DGSSN
 S DGDFN=$$GETDFN()
 Q:DGDFN'>0
 S DGPAT=$$GETPAT(DGDFN)
 Q:$P(DGPAT,U)=""
 S DGNAM=$P(DGPAT,U),DGSSN=$P(DGPAT,U,2)
 I '$$PH(DGDFN) D  Q
 . W !!,"There is no Purple Heart history for patient "_$G(DGNAM)_"."
 . W !
 . I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR K DIR
 I $$DEVICE() D START
 D EXIT
 Q
 ;
GETDFN() ;Ask the user to select patient
 ;
 ; Input: none
 ;
 ; Output: DFN
 ;
 N DIC,X,Y
 S DIC="^DPT(",DIC(0)="AEMQ"
 D ^DIC
 Q $S(+Y>0:+Y,1:0)
 ;
GETPAT(DFN) ; get patient name and ssn
 ;
 ; Input:  DFN - patient IEN
 ;
 ; Output:
 ;      Function value:  patient name^SSN
 ;
 N VADM,DGNAM,DGSSN
 S (DGNAM,DGSSN)=""
 I $G(DFN)>0 D
 . D ^VADPT
 . S DGNAM=VADM(1)
 . S DGSSN=$P(VADM(2),U,2)
 Q DGNAM_"^"_DGSSN
 ;
PH(DGDFN1) ; does patient PH history exist
 ;
 ; Input:  DGDFN1 - Patient IEN
 ;
 ; Output:
 ;    Function value:  0 - No PH Status history 
 ;                     >0 - History exists
 ;
 Q $P($G(^DPT(DGDFN1,"PH",0)),U,3)>0
 ;
DEVICE() ;select output device
 ;
 ; Input: none
 ;
 ; Output: Function value    Interpretation
 ;               0           User decides to queue or not print report.
 ;               1           Device selected to generate report NOW.
 ;
 N OK,IOP,POP,%ZIS
 S OK=1
 S %ZIS="MQ"
 D ^%ZIS
 S:POP OK=0
 I OK,$D(IO("Q")) D
 . N ZTRTN,ZTDESC,ZTSAVE,ZTSK
 . S ZTRTN="START^DGPHIST"
 . S ZTDESC="Current PH Status Pending/In Process report."
 . S ZTSAVE("DGDFN")=""
 . S ZTSAVE("DGNAM")=""
 . S ZTSAVE("DGSSN")=""
 . F DG1=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 . W !,$S($D(ZTSK):"Request "_ZTSK_" Queued!",1:"Request Cancelled!"),!
 . D HOME^%ZIS
 . S OK=0
 Q OK
 ;
START ;
 U IO
 N DGSITE,DGSTNUM,DGSTN,DGSTTN,DGDTN
 S DGSITE=$$SITE^VASITE
 S DGSTNUM=$P(DGSITE,U,3),DGSTN=$P(DGSITE,U,2)
 S DGSTTN=$$NAME^VASITE(DT)
 S DGDTN=$S($G(DGSTTN)]"":DGSTTN,1:$G(DGSTN))
 D DATA
 D EXIT
 Q
 ;
DATA ;Build line data and print
 ;
 ; Division name retrieved from pointer to the INSTITUTION file (#4)
 ; in PH DIVISION field (#.535) of PATIENT file (#2).
 ; DBIA: #10090 - Supported read to the INSTITUTION file with FileMan
 ;
 N DGLINE,DGDATE,DGIND,DGSTAT,DGREM,DGUSER
 N DGQUIT,DGPAGE,DGDIV
 N DG1,DG2
 S (DGPAGE,DGQUIT)=0
 S DGDIV=$$GET1^DIQ(2,DGDFN,.535)
 D HEAD
 S DG1=0
 F  S DG1=$O(^DPT(DGDFN,"PH",DG1)) Q:DG1'>0  D
 . S DGLINE(DG1)=^DPT(DGDFN,"PH",DG1,0)
 S DG2=0
 F  S DG2=$O(DGLINE(DG2)) Q:DG2'>0  D
 . D:$Y>(IOSL-4) HEAD Q:DGQUIT
 . S DGDATE=$P($P(DGLINE(DG2),U),".")
 . S DGDATE=$E(DGDATE,4,5)_"/"_$E(DGDATE,6,7)_"/"_$E(($E(DGDATE,1,3)+1700),3,4)
 . S DGIND=$P(DGLINE(DG2),U,2)
 . S DGIND=$S($G(DGIND)="Y":"Yes",$G(DGIND)="N":"No",1:"Unk")
 . S DGSTAT=$P(DGLINE(DG2),U,3)
 . S DGSTAT=$S($G(DGSTAT)="1":"Pending",$G(DGSTAT)="2":"In Process",$G(DGSTAT)="3":"Confirmed",1:"")
 . S DGREM=$P(DGLINE(DG2),U,4)
 . S DGREM=$S($G(DGREM)=1:"UNACCEPTABLE DOCUMENTATION",$G(DGREM)=2:"NO DOCUMENTATION REC'D",$G(DGREM)=3:"ENTERED IN ERROR",$G(DGREM)=4:"UNSUPPORTED PURPLE HEART",$G(DGREM)=5:"VAMC",$G(DGREM)=6:"UNDELIVERABLE MAIL",1:"")
 . S DGUSER=$P(DGLINE(DG2),U,5)
 . I $G(DGSTAT)["2"!($G(DGSTAT)["3") S DGUSER="HEC User"
 . I $G(DGREM)]"",($G(DGREM)'["VAMC") S DGUSER="HEC User"
 . W !,$G(DGDATE),?10,$G(DGIND),?15,$G(DGSTAT),?27,$G(DGREM),?55,$E($G(DGUSER),1,24)
 W !!?30,"End of Report."
 W !
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR K DIR
 Q
HEAD ; page header
 N DGDT
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQUIT)=1 Q
 I $G(DGPAGE)>0 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQUIT=1
 Q:DGQUIT
 W @IOF
 S Y=DT X ^DD("DD") S DGDT=Y
 S DGPAGE=$G(DGPAGE)+1
 W !!,"PURPLE HEART REQUEST HISTORY REPORT",?48,DGDT,?70,"Page: ",$G(DGPAGE)
 W !,"STATION: "_$G(DGSTN)
 I DGDIV]"" W !,"DIVISION: ",DGDIV
 W !,"_____________________________________________________________________________"
 W !!,"Patient Name: "_$G(DGNAM),?55,"SSN: "_$G(DGSSN)
 W !,"-----------------------------------------------------------------------------"
 W !!,"Date",?10,"PH?",?15,"Status",?27,"Remarks",?55,"Updated By"
 W !,"--------",?10,"---",?15,"----------",?27,"--------------------------",?55,"---------------"
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
