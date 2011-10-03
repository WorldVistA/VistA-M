IBCOMC2 ;ALB/CMS - IDENTIFY PT BY AGE WITH OR WITHOUT INSURANCE (CON'T); 10-09-98
 ;;2.0;INTEGRATED BILLING;**103,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
ENH ; Sort help Text
 W !!,?5,"Enter 1 to search by a Patient Name Range. (i.e. ADAMS to ADAMSZ)"
 W !,?5,"Enter 2 to search by Terminal Digit.  The output will be sorted"
 W !,?5,"by the 8th and 9th digits and then the 6th and 7th digits of the"
 W !,?5,"Patient's SSN.",!
 Q
 ;
INSH ; Search criteria help Text
 W !!,?5,"Enter 1 to List patients covered by policies in Insurance Co. Name Range"
 W !,?15,"(i.e. Sort By: MEDICARE  To: MEDICAREZZZ)"
 W !,?5,"Enter 2 to List patients covered by policies of the selected Insurance Co."
 W !,?15,"(User may enter up to six Companies.)"
 W !,?5,"Enter 3 to list patients with NO Coverage on file."
 Q
 ;
AGEH ; Sort AGE help text
 W !!,?5,"Enter an Age Range to sort by (1-250). Or press return at the Start Age"
 W !,?5,"prompt to not include Age range in search criteria."
 Q
 ;
HD ;Write Heading
 N IBX S IBPAGE=IBPAGE+1
 W @IOF,!,"Patients "_$S(IBSIN=3:"Without",1:"With")_" Insurance Report",?50,$$FMTE^XLFDT($$NOW^XLFDT,"Z"),?70," Page ",IBPAGE
 I IBPAGE=1 D
 .W !,?5,"Sorted by: "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_" Range: "_$S(IBRF="A":"FIRST",1:IBRF)_" to "_$S(IBRL="zzzzzz":"LAST",1:IBRL)
 .W !,?5,"Date Last Treated Range: "_$$FMTE^XLFDT(IBBDT,"Z")_" to "_$$FMTE^XLFDT(IBEDT,"Z")
 .I IBSIN=1 W !,?5,"Insurance Company Range: "_$S(IBSINF="A":"FIRST",1:IBSINF)_" to "_$S(IBSINL="zzzzzz":"LAST",1:IBSINL)
 .I IBSIN=3 W !,?5,"Patients with no Insurance on File"
 .I IBAGEF W !,?5,"Age Range: "_IBAGEF_" to "_IBAGEL
 .W !,?5,"*  -  Patient Deceased"
 .I IBSIN=2 W !,?5,"Active Policies with selected Insurance Companies:" F IBX=1:1:6 Q:'$D(IBSIN(IBX))  W !,?10,$P(IBSIN(IBX),U,2)
 W !!?58,"Means",!,"Patient Name   (SSN)",?39,"Age",?44,"DOB",?58,"Test?",?70,"Last Visit"
 W ! F IBX=1:1:80 W "="
 Q
 ;
WRT ;Write data lines
 N IBCDA,IBDA,IBDFN,IBINS,IBNA,IBPOL,IBPT,X,Y S IBQUIT=0
 S IBNA="" F  S IBNA=$O(^TMP("IBCOMC",$J,1,IBNA)) Q:(IBNA="")!(IBQUIT=1)  D
 .S IBDFN=0 F  S IBDFN=$O(^TMP("IBCOMC",$J,1,IBNA,IBDFN)) Q:('IBDFN)!(IBQUIT=1)  D
 ..S IBPT=$G(^TMP("IBCOMC",$J,1,IBNA,IBDFN))
 ..;
 ..I ($Y+5)>IOSL D  I IBQUIT=1 Q
 ...D ASK I IBQUIT=1 Q
 ...D HD
 ..;
 ..W !!,$E($P(IBPT,U,1),1,30)_"   "_$P(IBPT,U,2),?39,$P(IBPT,U,3),?44,$P(IBPT,U,4),?58,$P(IBPT,U,5),?65,$P(IBPT,U,6)
 ..;
 ..S IBDA=0 F  S IBDA=$O(^TMP("IBCOMC",$J,1,IBNA,IBDFN,IBDA)) Q:('IBDA)!(IBQUIT=1)  D
 ...S IBINS=$G(^TMP("IBCOMC",$J,1,IBNA,IBDFN,IBDA))
 ...I IBSIN=3 W !,IBINS Q
 ...W !?3,$E($P(IBINS,U,1),1,30),?35,"Reimb VA? ",$P(IBINS,U,2),?50,"Plan Name: ",$E($P(IBINS,U,3),1,20)
 ...;
 Q
 ;
ASK ; Ask to Continue with display
 ; also called from IBCNSUR1 and IBCOMA1
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBQUIT=1
 Q
 ;IBCOMC2
