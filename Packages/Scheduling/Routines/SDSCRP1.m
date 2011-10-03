SDSCRP1 ;ALB/JAM/RBS - Unbilled Amt Report for ASCD ; 3/6/07 10:45am
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;  This report shall be used by billing clerks and the MCCR
 ;  Coordinator or other Billing Supervisor
 Q
START ;SC Unbilled Amount Report
 N SDOPT,SCOPT,SDSCCR,SDSCTAT,SDTYPE,SDSUPER,DIR,DIRUT,Y
 W !,"Service Connected Unbilled Amount Report"
 S DIR(0)="SO^R:Regular;S:Supervisor",DIR("B")="R",SDSUPER=0
 S DIR("A")="Which option do you want to run?"
 D ^DIR I $D(DIRUT) Q
 I Y="S" D  I 'SDSUPER Q
 .;Determine type of user
 .D TYPE^SDSCUTL
 .I $G(SDTYPE)'="S" D EN^DDIOL("You do not have privileges to run this report.") Q
 .S SDSUPER=1
 D SCSEL I $G(SDABRT) K SDABRT Q
 D RPT
 Q
 ;
SCSEL ;Service connection selection
 N DIR,DIRUT,X,Y
 W !!,"Encounter to Report"
 S DIR(0)="SO^S:SC to NSC;N:NSC to SC"
 S DIR("B")="S",DIR("A")="Which option do you want to run?"
 D ^DIR I $D(DIRUT) S SDABRT=1 Q
 S SCOPT=$S(Y="S":2,1:1)
 Q
RPT ;  Build the report
 N DIR,SDSCDVSL,SDSCDVLN,SDRUN,SDSCTDT,ZTIO,ZTSAVE,%ZIS,ZTDESC,ZTRTN
 ; Get Divisions
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G END
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 K X,Y
 ;
 S SDRUN=$$HTE^XLFDT($H,1)
 ;  Get start and end date for report.
 D GETDATE^SDSCOMP I SDSCTDT="" G END
 ;
 W !!,"You will need a 132 column printer for this report!",!
 S ZTDESC="BILLED/UNBILLED AMOUNT REPORT",ZTRTN="BEG^SDSCRP1"
 S %ZIS="QM" D ^%ZIS G END:POP
 I '$D(IO("Q")) K ZTDESC G @ZTRTN
 S ZTIO=ION,ZTSAVE("*")=""
 D ^%ZTLOAD
 G END
 ;
BEG ; Begin report
 N P,L,SDABRT,CT,SDSCDIV,SDSCDNM,AI,THDR,CT,DITOT,DPTOT
 S (P,L,SDABRT,CT)=0
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:SDSCDVSL,1:"")
 I SDSCDIV="" S SDSCDNM="ALL" D PRT G EXT
 I SDSCDIV'="" D
 . S THDR=""
 . F AI=1:1:$L(SDSCDVSL,",") S SDSCDIV=$P(SDSCDVSL,",",AI) Q:SDSCDIV=""  D  Q:$G(SDABRT)=1
 .. S SDSCDNM=$P(^DG(40.8,SDSCDIV,0),"^",1),THDR=THDR_SDSCDNM_",",CT=CT+1
 .. S DITOT(SDSCDNM)=0,DPTOT(SDSCDNM)=0
 .. D PRT
 G EXT
 ;
PRT ; Print
 N SDOEDT,ITOTAL,PTOTAL,SDOE,DFN,VADM,SDIBAMT,SSN,SDINST,SDPROF,SCVAL
 U IO D HDR I $G(SDABRT)=1 Q
 S SDOEDT=SDSCTDT,ITOTAL=0,PTOTAL=0
 F  S SDOEDT=$O(^SDSC(409.48,"C","C",SDOEDT)) Q:SDOEDT=""!(SDOEDT\1>SDEDT)  D  Q:$G(SDABRT)=1
 . S SDOE=""
 . F  S SDOE=$O(^SDSC(409.48,"C","C",SDOEDT,SDOE)) Q:SDOE=""  D  Q:$G(SDABRT)=1
 .. I SDSCDIV'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 .. ;if encounter was not changed quit
 .. S SCVAL=$$SCHNG^SDSCUTL(SDOE) I '+SCVAL Q
 .. I '$S(($P(SCVAL,U,3))&(SCOPT=1):1,($P(SCVAL,U,2))&(SCOPT=2):1,1:0) Q
 .. ;Call Billing API
 .. S SDIBAMT=$$TPCHG^IBRSUTL(SDOE) I SDIBAMT="" Q
 .. S SDPROF=$P(SDIBAMT,U,2),SDINST=$P(SDIBAMT,U)
 .. I SDPROF=0,SDINST=0 Q
 .. S SDBILL=$$TPBILL^IBRSUTL(SDOE),SDBILL=$TR(SDBILL,"^","/")
 .. S ITOTAL=ITOTAL+SDINST,PTOTAL=PTOTAL+SDPROF
 .. I SDSCDNM'="" S DITOT(SDSCDNM)=$G(DITOT(SDSCDNM))+SDINST,DPTOT(SDSCDNM)=$G(DPTOT(SDSCDNM))+SDPROF
 .. I L+4>IOSL D HDR Q:$G(SDABRT)=1
 .. S DFN=$$GET1^DIQ(409.48,SDOE_",",.11,"I") I DFN="" Q
 .. D DEM^VADPT
 .. W !,$E(VADM(1),1,20)
 .. S SSN=$P(VADM(2),U)
 .. S SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)
 .. W ?22,SSN
 .. W ?35,$E($$FMTE^XLFDT(SDOEDT,"5Z"),1,16),?55,SDOE
 .. W !,?5,$E($$GET1^DIQ(409.68,SDOE_",",.04,"E"),1,20)
 .. W ?27,$E($$GET1^DIQ(409.48,SDOE_",",.08,"E"),1,20)
 .. S SDLEDT=$$GET1^DIQ(409.48,SDOE_",",.02,"I")
 .. W ?49,$E($$FMTE^XLFDT(SDLEDT,"5Z"),1,16)
 .. W ?65,$J(SDINST,0,2)
 .. W ?75,$J(SDPROF,0,2)
 .. W ?85,$E(SDBILL,1,$L(SDBILL)-1)
 .. ;
 .. I SDSUPER D PER W ?110,$E(SDNAME,1,$L(SDNAME)-1)
 .. S L=L+2
 I $G(SDABRT)=1 Q
 ;
 I L+3>IOSL D HDR I $G(SDABRT)=1 Q
 W !,$TR($J(" ",IOM)," ","-")
 W !,"TOTAL:",?65,$J(ITOTAL,0,2),?75,$J(PTOTAL,0,2)
 S L=L+2
 Q
 ;
PER ;  Last 2 Persons who edited record
 N SDI,SDLI
 S SDLI="A",SDNAME=""
 F SDI=1:1:2 S SDLI=$O(^SDSC(409.48,SDOE,1,SDLI),-1) Q:'SDLI  D
 . S APER=$$GET1^DIQ(409.481,SDLI_","_SDOE_",",.03,"E")
 . S SDNAME=SDNAME_APER_"/"
 . Q
 Q
 ;
HDR ; Header
 ; Do not ask 'RETURN' before first page on CRT.
 I $E(IOST,1,2)="C-",P N DIR S DIR(0)="E" D ^DIR I 'Y S SDABRT=1 Q
 ; Do not print a form feed before first page on printer. Top of form is set at end of previous report.
 I $E(IOST,1,2)="C-"!P W @IOF
 S P=P+1,L=5
 W "ASCD "_$S(SCOPT=2:"Unbilled (SC to NSC)",1:"Billable (NSC to SC)")_" Amounts Report by Division "_SDSCDNM_" ",?90,"Run Date: ",SDRUN,?124,"Page ",$J(P,3)
 W !,"*** Report reflects ONLY reviewed encounters ***"
 W !!,"Name",?22,"SSN",?35,"Enc Date/Time",?55,"Encounter No."
 W !,?5,"Clinic",?27,"Prim Prov",?49,"Date Edited",?65,"Instit $",?75,"Profess $",?85,"Bill Nos."
 I SDSUPER W ?110,"Editors"
 W !,$TR($J(" ",IOM)," ","-"),!
 Q
 ;
EXT ;
 I CT>1,$G(SDABRT)'=1 D
 . I $E(IOST,1,2)="C-",P N DIR S DIR(0)="E" D ^DIR I 'Y S SDABRT=1 Q
 . ; Do not print a form feed before first page on printer. Top of form is set at end of previous report.
 . I $E(IOST,1,2)="C-"!P W @IOF
 . I $E(THDR,$L(THDR))="," S THDR=$E(THDR,1,$L(THDR)-1)
 . W $S(SCOPT=2:"Unbilled (SC to NSC)",1:"Billable (NSC to SC)")_" Amounts Report",?90,"Run Date: ",SDRUN,?124,"Page ",$J(P,3)
 . W !,"*** Report reflects ONLY reviewed encounters ***"
 . W !!,"By Division(s) "_THDR
 . W !,?65,"Instit $",?75,"Profess $"
 . W !,$TR($J(" ",IOM)," ","-"),!
 . S DIV="" F  S DIV=$O(DITOT(DIV)) Q:DIV=""  D
 .. W !,?20,DIV,?65,$J(DITOT(DIV),0,2),?75,$J(DPTOT(DIV),0,2)
 .. S TOTAI=TOTAI+DITOT(DIV),TOTAP=TOTAP+DPTOT(DIV)
 .. Q
 . W !,$TR($J(" ",IOM)," ","-"),!
 . W !,?20,"TOTAL",?65,$J(TOTAI,0,2),?75,$J(TOTAP,0,2)
 . Q
 D RPTEND^SDSCRPT1
 ;
END ; Exit tag
 K SDBILL,SDLI,SDNAME,APER,SDSUPER,DIV,POP,P,L,SDABRT,DFN,TOTAI,TOTAP
 K SDLEDT,SDRUN,SDEDT,SDOE,SDOEDT,SDSCTDT,SDSCBDT,SDSCEDT
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,SCLN D KVA^VADPT
 Q
