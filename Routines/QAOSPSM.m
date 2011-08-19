QAOSPSM ;HISC/DAD-SUMMARY OF OCCURRENCE SCREENING - DRIVER ;6/11/93  15:58
 ;;3.0;Occurrence Screen;;09/14/1993
EN1 ; Automatically print medical center, reporting period, criteria auto
 ; enrolled, computer program used, number of times an action was
 ; taken, and service specific occurrences
 S QAOBLANK=0 G ASKSCR
EN2 ; Print a totally blank report
 S QAOBLANK=1
ASKSCR ;
 K DIR S DIR(0)="LO^1:3^K:X[""."" X"
 S DIR("A")="Select screen criteria to include"
 S DIR("B")=1,DIR("?",1)="Choose from:",DIR("?",2)="  1   National"
 S DIR("?",3)="  2   Local",DIR("?",4)="  3   Inactive"
 S DIR("?")="Select any combination of the codes listed above, e.g. 1-3, 1,2"
 W ! D ^DIR G:$D(DIRUT) EXIT S QAOSLIST(0)=Y
ASKPRT2 ;
 W !!,"Print PART II of the Summary of Occurrence Screening"
 S %=2 D YN^DICN G:%=-1 EXIT S QAOPART2=$S(%=1:1,1:0)
 I '% W !!?5,"Please answer Y(es) or N(o)" G ASKPRT2
ASKPEND ;
 I QAOBLANK S QAOSPEND=0 G ASKDATE
 W !!,"Print a list of all PENDING occurrences"
 S %=2 D YN^DICN G:%=-1 EXIT S QAOSPEND=$S(%=1:1,1:0)
 I '% W !!?5,"Please answer Y(es) or N(o)" G ASKPEND
ASKDATE ;
 W !!,"Select the reporting period:"
 S QAQDATE="Semi-Annually" D ^QAQDATE G:QAQQUIT EXIT
ASKDEV ;
 K %ZIS S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) K IO("Q") D  G EXIT
 . S ZTRTN="ENTSK^QAOSPSM"
 . S (ZTSAVE("QAQ*"),ZTSAVE("QAO*"))=""
 . S ZTDESC="Occurrence Screen Semi-Annual Report"
 . D ^%ZTLOAD
 . Q
ENTSK ;
 K ^UTILITY($J) D ^QAOSPSM0 U IO D ^QAOSPSM1
 I QAOSQUIT'>0,QAOPART2 D ^QAOSPSM2
 I QAOSQUIT'>0,QAOSPEND D ^QAOSPSM5
EXIT ;
 W ! D ^%ZISC K TAB,UNDL,X,Y,ZTRTN,ZTSAVE D K^QAQDATE
 K %ZIS,DIR,DIRUT,POP,QA,QAO,QAOPART2,QAOS,QAOSACTN,QAOSCLIN,QAOSCREV
 K QAOSD0,QAOSD1,QAOSDATE,QAOSFIND,QAOSKIND,QAOSLEVL,QAOSLIST,QAOSLST
 K QAOSMGMT,QAOSNUM,QAOSQUIT,QAOSRFPR,QAOSSCRN,QAOSSEQ,QAOSSITE,QAOSSTAT
 K QAOSTEMP,QAOSZERO,QAOBLANK,QAOSCRN,QAOSPEER,QAOSS1,QAOSS2,QAOSPEND
 K %,%H,QAOSDPT,QAOSPAGE,QAOSPAT,QAOSSN,TODAY,QAOFINAL,QAOSHOSP,QAOSRV
 K QAOSWARD,SERV
 K ^UTILITY($J,"QAOSPSM"),^UTILITY($J,"QAOSXREF"),^UTILITY($J,"QAOSPEND")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
