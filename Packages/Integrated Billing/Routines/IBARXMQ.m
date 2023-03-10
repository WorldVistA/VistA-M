IBARXMQ ;LL/ELZ-RX COPAY RPC QUERY ROUTINE (MILL BILL) ;10-OCT-2000
 ;;2.0;INTEGRATED BILLING;**150,156,186,199,563,676**;21-MAR-94;Build 34
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; main entry point for users to request a query of rx bills from all possible facilities
 N DIC,X,Y,DFN,IBT,IBTFL,%,%ZIS,ZTSAVE,POP,ZTSK,DIR,IBDT,IBPAT,IBROOT
 ;
 ; select patient, and get pt info
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEMNQ" D ^DIC Q:Y<1  S DFN=+Y
 D DEM^VADPT S IBPAT=VADM(1)_"^"_VA("BID") D KVAR^VADPT
 ;
 ; ask for month / year
 S DIR(0)="D^::AEMP",DIR("A")="For What Month/Year" D ^DIR Q:Y<1
 S IBDT=Y
 ;
 ; scan for patient to see if different facilities could be involved
 S IBT=$$TFL^IBARXMU(DFN,.IBTFL,2)
 ;
 ; if multiple facilities ask if we should check
 I IBT W !,"This patient could have Pharmacy Co-payment bills at other facilities",!,"Do you want to check those other facilities" S %=0 D YN^DICN S:%'=1 IBT=0 Q:%<0
 ;
 ; now for a device
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN
 . S ZTRTN="DQ^IBARXMQ",(ZTSAVE("DFN"),ZTSAVE("IB*"))=""
 . S ZTDESC="PHARMACY BILLING SUMMARY"
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q") W !,"Task# ",ZTSK
 ;
DQ ; tasked entry point
 ;
 N IBD,IBER,X,IBX,IBC,IBB,IBU,DIRUT,IBE,IBP,IBAR K ^TMP("IBARXM",$J)
 ;
 ; remote stuff, file locally
 I IBT S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 . W:'$D(ZTQUEUED) !,"Now sending query to ",$P(IBTFL(IBX),"^",2)," ..."
 . ;676;BL; Send request to Cerner Separate response message returns transactions
 . I $P(IBTFL(IBX),"^",1)["200CRNR" D  Q
 . . D EN^IBARXCQR(DFN,$E(IBDT,1,5)_"00")
 . D QUERY^IBARXMU(DFN,IBDT,+IBTFL(IBX),.IBD)
 . I $P(IBD(0),"^")=-1!(-1=+IBD)!($P($G(IBD(1)),"^")=-1) S IBER=1 K IBD Q
 . S X=1 F  S X=$O(IBD(X)) Q:X<1  S IBD=$$ADD^IBARXMN(DFN,IBD(X))
 . K IBD
 ;
 ; stuff on local file w/remote stuff, build tmp
 S (IBC,IBX)=0 F  S IBX=$O(^IBAM(354.71,"AD",DFN,IBDT,IBX)) Q:IBX<1  S IBC=IBC+1,IBD=^IBAM(354.71,IBX,0),IBAR=$P($P($G(^IB(+$P(IBD,"^",4),0)),"^",11),"-",2),^TMP("IBARXM",$J,$P(IBD,"^",3),IBC)=IBD,^(IBC,"AR")=IBAR
 ;
 ;
PRINT ;
 U IO
 ;
 S (IBP,IBE,IBB,IBU)=0 D HEAD F  S IBE=$O(^TMP("IBARXM",$J,IBE)) Q:IBE<1!($D(DIRUT))  S IBX=0 F  S IBX=$O(^TMP("IBARXM",$J,IBE,IBX)) Q:IBX<1!($D(DIRUT))  D
 . D:$Y+3>IOSL HEAD Q:$D(DIRUT)
 . S IBD=^TMP("IBARXM",$J,IBE,IBX)
 . W !,$E($P($$FAC^IBARXMU($P(IBD,"^",13)),"^"),1,9),"(",+IBD,")"  ;676;BL Changed call to return Cerner name
 . W ?17,$G(^TMP("IBARXM",$J,IBE,IBX,"AR"))
 . W ?29,$$FMTE^XLFDT(IBE,"2D")
 . W ?40,$P(IBD,"^",20)
 . W ?44,$P(IBD,"^",9)
 . W ?67,$J($P(IBD,"^",11),6,2)
 . W ?74,$J($P(IBD,"^",12),6,2)
 . S IBB=IBB+$P(IBD,"^",11),IBU=IBU+$P(IBD,"^",12)
 I $D(DIRUT) G Q
 W !!?67,"-------",?74,"------"
 W !?67,$J(IBB,6,2),?75,$J(IBU,5,2)
 ;
 ; update totals in the patient's account
 X $S($D(IBER):"W !!,""Unable to perform all remote queries, totals will not be updated!""",IBT=0&($D(IBTFL)):"W !!,""No remote queries needed/performed, account not updated.""",1:"D ACCT^IBARXMN(DFN,IBB,IBU,IBDT,1)")
 ;
 I $E(IOST,1,2)="C-",'$D(DIRUT) N DIR,X,Y,DTOUT,DUOUT,DIROUT S DIR(0)="E" D ^DIR
 ;
Q K ^TMP("IBARXM",$J)
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HEAD ; prints header info
 N DIR,X,Y,DTOUT,DUOUT,DIROUT
 I IBP>0,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 S IBP=IBP+1
 W @IOF,!,"Medication Co-Pay Billing Summary",?IOM-10,"Page: ",IBP
 W !,"Patient: ",$P(IBPAT,"^")," (",$P(IBPAT,"^",2),")",?IOM-11,$$FMTE^XLFDT(IBDT),!
 F X=0:1:IOM-1 W "-"
 W !,"Station          AR Bill      Date     Tier Brief Description      Billed  Not B",! F X=0:1:IOM-1 W "-"
 Q
