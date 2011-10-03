IBJDF8R ;ALB/RRG - AR WORKLOAD ASSIGNMENTS (PRINT) ;05-FEB-01
 ;;2.0;INTEGRATED BILLING;**123,159,192**;21-MAR-94
 ;
EN ; - Option entry point
 ;
CLK ; - Select one, more, or all clerks to print
 W !!,"Run list for (S)pecific clerks or (A)ll clerks: ALL// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "SAsa"'[X S IBOFF=61 D HELP^IBJDF8H G CLK
 W "  ",$S("Ss"[X:"SPECIFIC",1:"ALL") G:"Aa"[X DEV K IBSI
CLK1 S DIC="^IBE(351.73,",DIC(0)="AEQMZ"
 S DIC("A")="   Select "_$S($G(IBSI):"another ",1:"")_"Clerk: "
 D ^DIC K DIC I Y'>0 G ENQ:'$G(IBSI),DEV
 I $D(IBSI(+Y)) D  G CLK1
 . W !!?3,"Already selected. Choose another clerk.",!,*7
 S IBSI(+Y)="" S:'$G(IBSI) IBSI=1 G CLK1
 ;
DEV ; - Select a device
 W !!,"This report requires an 80 column printer."
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="PRINT^IBJDF8R",ZTDESC="IB - AR WORKLOAD ASSIGNMENTS LIST"
 .S ZTSAVE("IB*")="" D ^%ZTLOAD
 .I $G(ZTSK) W !!,"This job has been queued. The task no. is ",ZTSK,"."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
PRINT ; - Print the AR Workload Assignments Report
 ; 
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 S IBPAG=0
 ;
 I '$D(^IBE(351.73,0)) D  G ENQ
 . D @("HDR")
 . W !!,"There is no AR Workload Assignment information for the parameters selected."
 ;
 S IBPAG=0 D HDR G:IBQ ENQ
 ;
 I $G(IBSI) G PRINT1
 ;
 ; - print all clerks
 ;
 S (IBCLNUM,IBCLNAM,IBASNUM,IBPRO,IBASNDAT,IBBCAT,IBMIN,IBSUPER,IBEXCRC)=""
 ; retrieve clerk detail and print
 F  S IBCLNUM=$O(^IBE(351.73,IBCLNUM)) Q:IBCLNUM=""  D  Q:IBQ
 . S IBCLDAT=$G(^IBE(351.73,IBCLNUM,0)) Q:IBCLDAT=""
 . S IBCLNAM=$P(^VA(200,$P(IBCLNUM,"^",1),0),"^",1),IBPRO=$P(IBCLDAT,"^",2)
 . W !!!,IBCLNAM,?40,"Productivity report only? "
 . W ?67,$S(IBPRO=0:"NO",1:"YES")
 . I IBPRO=1 Q
 . ; retrieve assignment data and print
 . F  S IBASNUM=$O(^IBE(351.73,IBCLNUM,1,IBASNUM)) Q:IBASNUM=""  D  Q:IBQ
 . . S IBASNDAT=$G(^IBE(351.73,IBCLNUM,1,IBASNUM,0)) Q:IBASNDAT=""
 . . S IBBCAT=$P(IBASNDAT,"^",2),IBMIN=$P(IBASNDAT,"^",3)
 . . S IBSUPER=$P(IBASNDAT,"^",4),IBEXCRC=$P(IBASNDAT,"^",5)
 . . W !,"Assignment #: ",?15,IBASNUM,?20,"Bill Category: "
 . . W ?35,$E($P(^PRCA(430.2,IBBCAT,0),"^",1),1,18)
 . . W ?55,"Min Acct Bal: ",?69,$J($FN(IBMIN,",",2),10)
 . . W !,?20,"Supervisor: ",?35,$E($P($G(^VA(200,+IBSUPER,0)),"^",1),1,18)
 . . W ?55,"Exclude Reg Counsel: ",?75,$S(IBEXCRC=1:"YES",1:"NO")
 . . ; - Page Break
 . . I $Y>(IOSL-8) D PAUSE Q:IBQ  D HDR Q:IBQ
 . . ; print first party parameters if present
 . . I $D(^IBE(351.73,IBCLNUM,1,IBASNUM,1)) D FIRST
 . . ; print third party parameters if present
 . . I $D(^IBE(351.73,IBCLNUM,1,IBASNUM,2)) D THIRD
 . . ;
 . . ; - Page Break
 . . I $Y>(IOSL-6) D PAUSE Q:IBQ  D HDR Q:IBQ
 . . ;
 ;
 G ENQ:IBQ W !!,"------ End of Assignment List ------" D PAUSE
 G ENQ
 ;
PRINT1 ; - print selected clerks only
 ;
 S (IBCLNUM,IBCLNAM,IBASNUM,IBPRO,IBASNDAT,IBBCAT,IBMIN,IBSUPER,IBEXCRC)=""
 ; retrieve clerk detail and print
 F  S IBCLNUM=$O(IBSI(IBCLNUM)) Q:IBCLNUM=""  D  Q:IBQ
 . S IBCLDAT=$G(^IBE(351.73,IBCLNUM,0)) Q:IBCLDAT=""
 . S IBCLNAM=$P(^VA(200,$P(IBCLNUM,"^",1),0),"^",1),IBPRO=$P(IBCLDAT,"^",2)
 . W !!!,IBCLNAM,?40,"Productivity report only? "
 . W ?67,$S(IBPRO=0:"NO",1:"YES")
 . I IBPRO=1 Q
 . ; retrieve assignment data and print
 . F  S IBASNUM=$O(^IBE(351.73,IBCLNUM,1,IBASNUM)) Q:IBASNUM=""  D
 . . S IBASNDAT=$G(^IBE(351.73,IBCLNUM,1,IBASNUM,0)) Q:IBASNDAT=""
 . . S IBBCAT=$P(IBASNDAT,"^",2),IBMIN=$P(IBASNDAT,"^",3)
 . . S IBSUPER=$P(IBASNDAT,"^",4),IBEXCRC=$P(IBASNDAT,"^",5)
 . . W !,"Assignment #: ",?15,IBASNUM,?20,"Bill Category: "
 . . W ?35,$E($P(^PRCA(430.2,IBBCAT,0),"^",1),1,18)
 . . W ?55,"Min Acct Bal: ",?69,$J($FN(IBMIN,",",2),10)
 . . W !?20,"Supervisor: ",?35,$E($P($G(^VA(200,+IBSUPER,0)),"^",1),1,18)
 . . W ?55,"Exclude Reg Counsel: ",?75,$S(IBEXCRC=1:"YES",1:"NO")
 . . ; - page break
 . . I $Y>(IOSL-8) D PAUSE Q:IBQ  D HDR Q:IBQ
 . . ; print first party parameters if present
 . . I $D(^IBE(351.73,IBCLNUM,1,IBASNUM,1)) D FIRST
 . . ; print third party parameters if present
 . . I $D(^IBE(351.73,IBCLNUM,1,IBASNUM,2)) D THIRD
 . . ; - page break
 . . I $Y>(IOSL-6) D PAUSE Q:IBQ  D HDR Q:IBQ
 ;
 W !!,"------ End of Assignment List ------" D PAUSE
 ;
 ;
ENQ D ^%ZISC
 K IBPAG,IBQ,%,X,Y,IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT
 K IBCLNAM,IBCLNUM,IBASNUM,IBPRO,IBASNDAT,IBBCAT,IBMIN,IBSUPER
 K IBEXCRC,IBFPDAT,IBTPDAT,IBTOR,IBSI,IBCLDAT,IBOFF,IBRUN
 Q
 ;
HDR ; - Prints the Report Header
 ; 
 I IBPAG>0 W @IOF,*13
 S IBPAG=$G(IBPAG)+1
 W !,"AR Workload Assignments List",?35,"Run Date: ",IBRUN
 W ?70,"Page: ",$J(IBPAG,3)
 W !,$$DASH(IOM,0) S IBQ=$$STOP^IBOUTL("AR Workload Assignments List")
 Q
 ;
FIRST ; - Prints First Party Parameters
 ;
 S IBFPDAT=""
 S IBFPDAT=^IBE(351.73,IBCLNUM,1,IBASNUM,1)
 W !,"FIRST PARTY PARAMETERS:"
 W !,"Days Since Last Payment",?38,":",?40,$P(IBFPDAT,"^",1)
 W !,"First Patient Name",?38,":",?40,$P(IBFPDAT,"^",2)
 W !,"Last Patient Name",?38,":",?40,$P(IBFPDAT,"^",3)
 W !,"First Social Security Number",?38,":",?40,$P(IBFPDAT,"^",4)
 W !,"Last Social Security Number",?38,":",?40,$P(IBFPDAT,"^",5)
 Q
 ;
THIRD ; - Prints Third Party Parameters
 ;
 S (IBTPDAT,IBTOR)=""
 S IBTPDAT=^IBE(351.73,IBCLNUM,1,IBASNUM,2),IBTOR=$P(IBTPDAT,"^",8)
 W !,"THIRD PARTY PARAMETERS:"
 W !,"Days Since Last Transaction",?38,":",?40,$P(IBTPDAT,"^",1)
 W !,"First Insurance Carrier",?38,":",?40,$P(IBTPDAT,"^",2)
 W !,"Last Insurance Carrier",?38,":",?40,$P(IBTPDAT,"^",3)
 W !,"First Patient Name",?38,":",?40,$P(IBTPDAT,"^",4)
 W !,"Last Patient Name",?38,":",?40,$P(IBTPDAT,"^",5)
 W !,"First Social Security Number",?38,":",?40,$P(IBTPDAT,"^",6)
 W !,"Last Social Security Number",?38,":",?40,$P(IBTPDAT,"^",7)
 W !,"Type of Receivable",?38,":"
 W ?40,$S(IBTOR=1:"Inpatient",IBTOR=2:"Outpatient",IBTOR=3:"Pharmacy Refill",IBTOR=4:"All Receivables",1:"")
 Q
 ;
DASH(X,Y) ; - Return a dashed line.
 ; Input: X=Number of Columns (80 or 132), Y=Char to be printed
 ; 
 Q $TR($J("",X)," ",$S(Y:"-",1:"="))
 ;
PAUSE ; - Page break.
 ; 
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
 ;
DT(X) ; - Return date.
 ;    Input: X=Date in Fileman format
 ;   Output: Z=Date in MMDDYY format
 ;
 Q $E(X,4,7)_$E(X,2,3)
