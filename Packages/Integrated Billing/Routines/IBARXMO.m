IBARXMO ;LL/ELZ - PHARMACY COPAY CAP REPORTS ;21-JAN-2001
 ;;2.0;INTEGRATED BILLING;**156,261**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CAP ; cap report entry point
 ; this report will produce a summary of patient's who have met or exceed their cap for the period selected.  They may select either a mo/year or just a year.
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="D^::AEMP",DIR("A")="Select a Month/Year or just a Year" D ^DIR
 Q:$D(DIRUT)  S IBD=+Y
 D DEV("CAPDQ^IBARXMO","Medication Co-Pay Cap Report")
 Q
 ;
CAPDQ ; cap report processing entry
 N IBP,IBT,IBS,IBDT,IBST,IBM,IBNAM,DFN,IBAB,IBAT,IBDATA,IBTOT K ^TMP("IBARXMO",$J)
 ;
 U IO
 S (IBP,IBAT,IBAB,IBTOT)=0,IBT="Patient/SSN                      Non-Billed Total   Above Cap   Patient Priority",IBS=$$SITE^IBARXMU,IBN=IBN_" for ("_$P(IBS,"^",3)_") "_$P(IBS,"^",2)_" - "_$$FMTE^XLFDT(IBD),IBDT=IBD-1
 D HEAD(IBN,IBT)
 ;
 ; build tmp for output
 ; format ^tmp("ibarxmo",$j,name (last 4),dfn)=total not billed ^ at or above cap 
 ;
 F  S IBDT=$O(^IBAM(354.7,"AC",IBDT)) Q:IBDT<1!($S($E(IBD,4,5)="00"&($E(IBD,1,3)'=$E(IBDT,1,3)):1,$E(IBD,4,5)'="00"&($E(IBDT,1,5)'=$E(IBD,1,5)):1,1:0))  S IBST=0 F  S IBST=$O(^IBAM(354.7,"AC",IBDT,IBST)) Q:IBST<1  D
 . S DFN=0 F  S DFN=$O(^IBAM(354.7,"AC",IBDT,IBST,DFN)) Q:DFN<1  D DEM^VADPT S IBM=0 F  S IBM=$O(^IBAM(354.7,"AC",IBDT,IBST,DFN,IBM)) Q:IBM<1  D
 .. S IBNAM=$E(VADM(1),1,25)_" ("_VA("BID")_")",^TMP("IBARXMO",$J,IBNAM,DFN)=$G(^TMP("IBARXMO",$J,IBNAM,DFN))+$P(^IBAM(354.7,DFN,1,IBM,0),"^",4)_"^"_IBST
 ;
 ; now lets do some printing
 S IBNAM=0 F  S IBNAM=$O(^TMP("IBARXMO",$J,IBNAM)) Q:IBNAM=""!($D(DIRUT))  S DFN=0 F  S DFN=$O(^TMP("IBARXMO",$J,IBNAM,DFN)) Q:DFN<1!($D(DIRUT))  D
 . S IBDATA=^TMP("IBARXMO",$J,IBNAM,DFN)
 . W !,IBNAM,?37,$J($FN(+IBDATA,",",2),12),?53,$S($P(IBDATA,"^",2)=1:"At Cap",1:"Above Cap"),?71,$$PRIORITY^IBARXMU(DFN)
 . S @$S($P(IBDATA,"^",2)=1:"IBAT",1:"IBAB")=@$S($P(IBDATA,"^",2)=1:"IBAT",1:"IBAB")+1,IBTOT=IBTOT+IBDATA
 . D:$Y+3>IOSL HEAD(IBN,IBT)
 ;
 W !!,?12,"Patient Count At Cap: ",$J($FN(IBAT,",",0),12)
 W !,?9,"Patient Count Above Cap: ",$J($FN(IBAB,",",0),12)
 W !,?18,"Total Unbilled: ",?37,$J($FN(IBTOT,",",2),12)
 ;
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR
 ;
 K IBR,IBN,IBD,^TMP("IBARXMO",$J)
 ;
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 Q
NOBILL ; non-billable report entry point
 ; this report will produce a list of copay transaction which could not be billed (fully or partly) for the Month/Year selected.
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="D^::AEMPX",DIR("A")="Select a Month/Year" D ^DIR
 Q:$D(DIRUT)  S IBD=+Y
 D DEV("NOBILLDQ^IBARXMO","Non-Billable Copayments Report")
 Q
NOBILLDQ ; entry point to produce the non-billable report
 N IBDT,IBP,IBT,IBX,IBZ,DFN,IBS
 U IO
 ;
 S IBP=0,IBS=+$P($$SITE^IBARXMU,"^",3),IBN=IBN_" - "_$$FMTE^XLFDT(IBD),IBT="Patient/SSN                       Rx #        Date          Drug          Amount" D HEAD(IBN,IBT)
 ;
 S IBDT=IBD F  S IBDT=$O(^IBAM(354.71,"AE",IBDT)) Q:IBDT<1!($D(DIRUT))!($E(IBDT,1,5)'=$E(IBD,1,5))  S IBX=0 F  S IBX=$O(^IBAM(354.71,"AE",IBDT,IBX)) Q:IBX<1  D
 . S IBZ=^IBAM(354.71,IBX,0),$P(IBZ,"^",12)=$P($$NET^IBARXMC(IBX),"^",2)
 . Q:$P(IBZ,"^",12)'>0!($P(IBZ,"^",10)'=IBX)!($E(IBZ,1,3)'=IBS)
 . S DFN=$P(IBZ,"^",2) D DEM^VADPT
 . W !,$E(VADM(1),1,25)_" ("_VA("BID")_")",?32,$P($P(IBZ,"^",9),"-"),?43,$$FMTE^XLFDT(IBDT),?58,$E($P($P(IBZ,"^",9),"-",2),1,13),?72,$J($FN($P(IBZ,"^",12),",",2),8)
 . D:$Y+3>IOSL HEAD(IBN,IBT)
 ;
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR
 ;
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 Q
DEV(IBR,IBN) ; device selection
 ; IBR=routine, IBN=task name (only used of tasked)
 N %ZIS,ZTSK,ZTSAVE,POP,ZTRTN,ZTDESC
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN=IBR,ZTDESC=IBN,ZTSAVE("IB*")=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q") W !,"QUEUED TASK #",ZTSK
 D @IBR
 ;
 Q
HEAD(IBX,IBY) ; print header
 ; IBX=report name, IBY=data description for second line
 ; IBP is assumed for page #
 N DIR,X,Y
 I $E(IOST,1,2)="C-",IBP S DIR(0)="E" D ^DIR
 S IBP=IBP+1
 W @IOF,!,IBX,?IOM-10,"Page: ",IBP,!,IBY,! F X=1:1:IOM W "-"
 W !
 Q
