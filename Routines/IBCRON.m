IBCRON ;ALB/ARH - RATES: REPORTS PROVIDER DISCOUNT ; 10-OCT-98
 ;;2.0;INTEGRATED BILLING;**106,148**;21-MAR-94
 ;
EN ;get parameters then run the report
 D HOME^%ZIS N DIR,X,Y,IBRPT,IBSRT W !!
 S DIR("?")="Enter 'Y' for a list of all Providers in a discount group. Enter 'N' for a list of discount groups."
 S DIR(0)="YO",DIR("A")="Print report by Provider",DIR("B")="NO" D ^DIR K DIR I $D(DIRUT) G EXIT
 S IBRPT=Y
 ;
 I +IBRPT S DIR(0)="SO^1:Provider Type;2:Provider Name",DIR("A")="Sort Report By" D ^DIR K DIR I $D(DIRUT) G EXIT
 S IBSRT=+Y
 ;
 ;
DEV ;get the device
 W !!,"Report requires 132 columns."
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="RPT^IBCRON",ZTSAVE("IB*")="",ZTDESC="IB Provider Discount List" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 ;
RPT ;find, save, and print the data that satisfies the search parameters
 ;entry point for tasked jobs
 ;
 K ^TMP($J,"IBCRON")
 ;
 I 'IBRPT D SORT,PRINT
 I +IBRPT,+IBSRT D SORT2,PRINT2
 ;
EXIT ;clean up and quit
 K ^TMP($J,"IBCRON") Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
SORT ;save the data in sorted order in a temporary file, sort by Special Group Name then Provider Type Name
 N IBPD0,IBPDFN,IBPDN,IBSGFN,IBSGN,IBPCFN,IBPCVA
 ;
 S IBPDFN=0 F  S IBPDFN=$O(^IBE(363.34,IBPDFN)) Q:'IBPDFN  D
 . S IBPD0=$G(^IBE(363.34,+IBPDFN,0)),IBPDN=$P(IBPD0,U,1)_" "
 . S IBSGFN=+$P(IBPD0,U,2),IBSGN=$P($G(^IBE(363.32,+IBSGFN,0)),U,1)_" "
 . S ^TMP($J,"IBCRON",IBSGN)=IBSGFN
 . S ^TMP($J,"IBCRON",IBSGN,IBPDN,IBPDFN)=""
 . ;
 . S IBPCFN=0 F  S IBPCFN=$O(^IBE(363.34,IBPDFN,11,"B",IBPCFN)) Q:'IBPCFN  D
 .. S IBPCVA=$$IEN2CODE^XUA4A72(IBPCFN),IBPCVA=IBPCVA_" "
 .. S ^TMP($J,"IBCRON",IBSGN,IBPDN,IBPDFN,IBPCVA,IBPCFN)=""
 Q
 ;
PRINT ;print the report from the temp sort file to the appropriate device
 N IBPGN,IBLN,IBQUIT,IBSGN,IBSG0,IBPDN,IBPDFN,IBPD0,IBPCFN,IBPC0,IBL,IBT,IBI,X,Y,IBPCVA
 S IBPGN=0,IBQUIT=0 D HDR Q:IBQUIT
 ;
 S IBSGN="" F  S IBSGN=$O(^TMP($J,"IBCRON",IBSGN)) Q:IBSGN=""  D  Q:$$LNCHK(7)
 . S IBSG0=^TMP($J,"IBCRON",IBSGN),IBSG0=$G(^IBE(363.32,+IBSG0,0))
 . ;
 . S IBL=$L("GROUP: "_$P(IBSG0,U,1)),IBT=(IOM-IBL)\2
 . W !!,?IBT,"GROUP: ",$P(IBSG0,U,1),!,?IBT S IBLN=IBLN+2
 . S IBI="",$P(IBI,"-",IBL+1)="" W IBI
 . ;
 . S IBPDN="" F  S IBPDN=$O(^TMP($J,"IBCRON",IBSGN,IBPDN)) Q:IBPDN=""  D  Q:IBQUIT
 .. S IBPDFN=0 F  S IBPDFN=$O(^TMP($J,"IBCRON",IBSGN,IBPDN,IBPDFN)) Q:'IBPDFN  D  Q:$$LNCHK(4)
 ... S IBPD0=$G(^IBE(363.34,+IBPDFN,0))
 ... ;
 ... W !!,$E($P(IBPD0,U,1),1,30),?35,$S($P(IBPD0,U,3)'="":$J(+$P(IBPD0,U,3),6)_"%",1:""),! S IBLN=IBLN+3
 ... ;
 ... S IBPCVA="" F  S IBPCVA=$O(^TMP($J,"IBCRON",IBSGN,IBPDN,IBPDFN,IBPCVA)) Q:IBPCVA=""  D  Q:$$LNCHK(2)
 .... S IBPCFN=0 F  S IBPCFN=$O(^TMP($J,"IBCRON",IBSGN,IBPDN,IBPDFN,IBPCVA,IBPCFN)) Q:'IBPCFN  D
 ..... S IBPC0=$$CODE2TXT^XUA4A72(IBPCFN)
 ..... ;
 ..... W !,?5,IBPCVA,?16,$E($P(IBPC0,U,1),1,38),?56,$E($P(IBPC0,U,2),1,37),?95,$E($P(IBPC0,U,3),1,36) S IBLN=IBLN+1
 ;
 I 'IBQUIT D PAUSE
 Q
LNCHK(LNS) ; check if new page is needed
 I 'IBQUIT,IBLN>(IOSL-LNS) D PAUSE I 'IBQUIT D HDR
 Q IBQUIT
 ;
HDR ;print the report header
 N IBNOW,IBI
 S IBQUIT=$$STOP Q:IBQUIT  S IBPGN=IBPGN+1,IBLN=7
 S IBNOW=$$FMTE^XLFDT($$NOW^XLFDT),IBNOW=$P(IBNOW,"@",1)_"  "_$P($P(IBNOW,"@",2),":",1,2)
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ;
 W !,"BILLING PROVIDER DISCOUNT LIST",?(IOM-30),IBNOW,?(IOM-8),"PAGE ",IBPGN,!
 W !,"PROVIDER TYPE",?36,"PERCENT",!,?5,"VA Code",?16,"Occupation",?56,"Specialty",?95,"Subspecialty",!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI
 Q
 ;
PAUSE ;pause at end of screen if beeing displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  N DIR,DUOUT,DTOUT,DIRUT W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
 ;
 ;
SORT2 ;save the data in sorted order in a temporary file, sort by Special Group Name then Provider Type Name
 N IBPRV,IBNM,IBPC,IBPDFN,IBPD0,IBPDNM,IBPDSG,IBCNT S IBCNT=0
 ;
 S IBPRV=0 F  S IBPRV=$O(^VA(200,IBPRV)) Q:'IBPRV  D
 . S IBNM=$P($G(^VA(200,IBPRV,0)),U,1)
 . S IBPC=$$GET^XUA4A72(IBPRV)
 . ;
 . S IBPDFN=0 F  S IBPDFN=$O(^IBE(363.34,"D",+IBPC,IBPDFN)) Q:'IBPDFN  D
 .. S IBPD0=$G(^IBE(363.34,IBPDFN,0)),IBPDNM=$P(IBPD0,U,1),IBPDSG=$P(IBPD0,U,2)
 .. S IBCNT=IBCNT+1
 .. ;
 .. S ^TMP($J,"IBCRON",IBCNT)=IBNM_U_IBPDFN_U_IBPC
 .. ;
 .. I IBSRT=1 S ^TMP($J,"IBCRON","B",IBPDSG,IBPDNM,IBNM)=IBCNT Q
 .. I IBSRT=2 S ^TMP($J,"IBCRON","B",IBPDSG,IBNM,IBPDNM)=IBCNT Q
 Q
 ;
PRINT2 ;print the report from the temp sort file to the appropriate device
 N IBPGN,IBLN,IBQUIT,IBPDSG,IBS1,IBS2,IBTMP,IBLNI,IBPDP,X,Y
 S IBPGN=0,IBQUIT=0
 ;
 S IBPDSG=0 F  S IBPDSG=$O(^TMP($J,"IBCRON","B",IBPDSG)) Q:'IBPDSG  D HDR2 D  Q:IBQUIT  D PAUSE
 . S IBS1="" F  S IBS1=$O(^TMP($J,"IBCRON","B",IBPDSG,IBS1)) Q:IBS1=""  D  Q:$$LNCHK(2)
 .. S IBS2="" F  S IBS2=$O(^TMP($J,"IBCRON","B",IBPDSG,IBS1,IBS2)) Q:IBS2=""  D  Q:$$LNCHK(2)
 ... S IBTMP=$G(^TMP($J,"IBCRON","B",IBPDSG,IBS1,IBS2)) Q:'IBTMP
 ... S IBLNI=$G(^TMP($J,"IBCRON",IBTMP)) Q:IBLNI=""
 ... S IBPDP=$P($G(^IBE(363.34,$P(IBLNI,U,2),0)),U,3),IBPDP=$S(IBPDP'="":IBPDP_"%",1:"")
 ... ;
 ... W !,$E(IBS1,1,21),?25,$E(IBS2,1,21),?47,$J(IBPDP,4) S IBLN=IBLN+1
 ... W ?53,$P(IBLNI,U,9),?62,$E($P(IBLNI,U,4),1,22),?85,$E($P(IBLNI,U,5),1,22),?110,$E($P(IBLNI,U,6),1,22)
 ;
 Q
 ;
HDR2 ;print the report header
 N IBNOW,IBI
 S IBQUIT=$$STOP Q:IBQUIT  S IBPGN=IBPGN+1,IBLN=7
 S IBNOW=$$FMTE^XLFDT($$NOW^XLFDT),IBNOW=$P(IBNOW,"@",1)_"  "_$P($P(IBNOW,"@",2),":",1,2)
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ;
 W !,"BILLING PROVIDER DISCOUNT LIST FOR PROVIDERS",?(IOM-30),IBNOW,?(IOM-8),"PAGE ",IBPGN
 W !,"SPECIAL GROUP: ",$P($G(^IBE(363.32,+$G(IBPDSG),0)),U,1),?53,"PERSON CLASS:"
 I IBSRT=1 W !,"PROVIDER TYPE",?25,"PROVIDER"
 I IBSRT=2 W !,"PROVIDER",?25,"PROVIDER TYPE"
 W ?49,"%",?53,"VA Code",?66,"Occupation",?88,"Specialty",?110,"Subspecialty",!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI
 Q
