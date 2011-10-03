IBCOIVM1 ;ALB/NLR - IB BILLING ACTIVITY (COMPILE/PRINT) ;02-MAY-94
 ;;2.0;INTEGRATED BILLING;**6,51**;21-MAR-94
 ;
LOOP ;  get patient from File 354 AIVM X-ref.  If still has IVM-identified
 ;  insurance, and bills against IVM-identified policies, put in report.
 ;
 K ^TMP("IBOIVM",$J)
 S DFN=0 F  S DFN=$O(^IBA(354,"AIVM",DFN)) Q:'DFN  I $$GETIVM(DFN) D
 .S IBNA=$P($$PT^IBEFUNC(DFN),"^",1,2)
 .S (IBF,IBIFN)=0 F  S IBIFN=$O(^DGCR(399,"C",DFN,IBIFN)) Q:'IBIFN  I $D(^DGCR(399,IBIFN,0)),$$HOWID^IBRFN2(IBIFN)=3,$P($G(^DGCR(399,IBIFN,"S")),"^",12),$P($G(^("S")),"^",17)="" S IBF=1 S ^TMP("IBOIVM",$J,IBNA,IBIFN)=""
 .I 'IBF S ^TMP("IBOIVM",$J,IBNA,0)=""
 ;
 ; - print out the report
 S (IBAB,IBAC,IBQ,IBPAG)=0 D HDR
 I '$D(^TMP("IBOIVM",$J)) W !!?25,"<< NO PATIENTS WITH POLICIES IDENTIFIED BY IVM >>",! G SEND
 S IBNA="" F  S IBNA=$O(^TMP("IBOIVM",$J,IBNA)) Q:IBNA=""!(IBQ)  D
 .W ! I $Y>(IOSL-5) D PAUSE Q:IBQ  D HDR W !
 .W !?1,$E($P(IBNA,"^"),1,25),?27,$E($P(IBNA,"^",2),1,12)
 .I $D(^TMP("IBOIVM",$J,IBNA,0)) W ?51,"<< BILLS NOT YET GENERATED AGAINST IVM POLICIES >>" Q
 .S (IBF,IBIFN)=0 F  S IBIFN=$O(^TMP("IBOIVM",$J,IBNA,IBIFN)) Q:'IBIFN!(IBQ)  D
 ..I $Y>(IOSL-5),IBF D PAUSE Q:IBQ  D HDR W !!?1,$E($P(IBNA,"^"),1,25),?27,$E($P(IBNA,"^",2),1,14) S IBF=0
 ..F IBI=0,"S","U" S IBND(IBI)=$G(^DGCR(399,IBIFN,IBI))
 ..W:IBF !
 ..W ?41,$P(IBND(0),"^")
 ..W ?51,$S($$CLO^PRCAFN(IBIFN)>0:"*",1:"")
 ..W ?57,$$BTYP(IBIFN,IBND(0))
 ..W ?62,$$DAT1^IBOUTL(+IBND("U")),?76,$$DAT1^IBOUTL($P(IBND("U"),"^",2))
 ..W ?87,$$DAT1^IBOUTL($P(IBND("S"),"^",12))
 ..S IBX=$$ORI^PRCAFN(IBIFN),IBAB=IBAB+IBX
 ..W ?105,$J(IBX,8,2)
 ..S IBX=$$TPR^PRCAFN(IBIFN),IBAC=IBAC+IBX
 ..W ?121,$J(IBX,8,2)
 ..S IBF=1
 ;
 G:IBQ ENQ
 ;
 ; - print total amounts billed and collected
 I $Y>(IOSL-7) D PAUSE G:IBQ ENQ D HDR
 I 'IBAB,'IBAC G SEND
 W !,?102,"___________",?118,"___________"
 W !!,?63,"Total Amounts Billed and Collected:" S X=IBAB,X2="2$",X3=16 D COMMA^%DTC W ?95,X S X=IBAC,X2="2$",X3=16 D COMMA^%DTC W ?111,X
SEND D PAUSE
 ;
 ; - send report to the IVM Center if necessary
 I IBFLG W:$E(IOST,1,2)="C-" !!,"Sending the report in a bulletin to the IVM Center... " D ^IBCOIVM2 W:$E(IOST,1,2)="C-" "done."
 ;
ENQ K ^TMP("IBOIVM",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBFID,IBNA,IBIFN,IBF,IBX,DFN,IBAB,IBAC
 K DIR,DIRUT,DUOUT,DTOUT,DIROUT
 K IBQ,IBPAG,IBND,IBINS,X,X2,X3,Y
ENQ1 Q
 ;
 ;
GETIVM(DFN) ;   does patient still have IVM-identified insurance?
 ;  input = dfn
 ;  output = 0 if no ivm-identified insurance
 ;           1 if ivm-identified insurance
 ;
 N IBINS,X,IBFID
 D ALL^IBCNS1(DFN,"IBINS",0)
 S IBFID=0 I $G(IBINS(0)) S X=0 F  S X=$O(IBINS(X)) Q:'X  I $P($G(IBINS(X,1)),"^",9)=3 S IBFID=1 Q 
 Q IBFID
 ;
BTYP(BN,X) ; Determine bill type
 ;  Input:   BN -- Pointer to the bill in file #399
 ;            X -- Zeroth node of pointed-to bill entry
 ; Output:   Bill Type --> R: Pharmacy Refill
 ;                         P: Prosthetics
 ;                         I: Inpatient
 ;                         O: Outpatient
 N Y,Z
 I $G(X)=""!($G(BN)="") S Y="" G BTYPQ
 I $D(^IBA(362.4,"AIFN"_BN)) S Y="R" G BTYPQ
 I $D(^IBA(362.5,"AIFN"_BN)) S Y="P" G BTYPQ
 S Z=$P(X,"^",5),Y=$S(Z=1!(Z=2):"I",1:"O")
BTYPQ Q Y
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'="C-"
 N IBI,DIR,DIRUT,DIROUT,DUOUT,DTOUT
 F IBI=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
HDR ; Display report header.
 N X,Y
 S X="IVM BILLING ACTIVITY"
 S Y=$$SITE^VASITE
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W $J("",56),"IVM BILLING ACTIVITY",!
 W !,"Facility: ",$P(Y,"^",2)," (",$P(Y,"^",3),")",?101,"Run Date: ",$$DAT1^IBOUTL(DT),"   ","Page: ",IBPAG
 W !,"Types ==> I:Inpatient, O:Outpatient, P:Prosthetics, R:Pharmacy Refill",?80,"Note:  '*' after the Bill # denotes a closed bill"
 W !!,$$DASH,!,?55,"Bill",?89,"Date",?107,"Amt",?125,"Amt"
 W !,?5,"Patient Name",?32,"SSN",?40,"Bill #",?55,"Type",?62,"Bill From",?75,"-",?79,"To",?86,"Generated",?105,"Billed",?122,"Collected",!,$$DASH
 Q
 ;
DASH() ; Write dashed line.
 Q $TR($J("",131)," ","=")
