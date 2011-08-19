QAOSPSS ;HISC/DAD-OCCURRENCE SERVICE STATISTICS DRIVER ;6/11/93  15:41
 ;;3.0;Occurrence Screen;;09/14/1993
ASK ;
 R !!,"Do you want the report sorted by CRITERIA or SERVICE: CRITERIA// ",X:DTIME S:'$T X="^" G:$E(X)="^" EXIT X ^%ZOSF("UPPERCASE") S X=Y,QAOSSORT=$S(X]"":$E(X),1:"C")
 I $F("^CRITERIA^SERVICE","^"_X)'>0 W:$E(X)'="?" " ??",*7 D  G ASK
 . W !!?5,"Enter SERVICE to produce a report sorted by Service."
 . W !?7,"(This option produces a 'table-like' report.)"
 . W !?5,"Enter CRITERIA to produce a report sorted by Screen Criteria."
 . W !?7,"(This option produces a 'spreadsheet-like' report.)"
 . Q
 W $P($P("^CRITERIA^SERVICE","^"_X,2),"^"),!
 K DIR S DIR(0)="LO^1:3^K:X[""."" X",DIR("A")="Select screen criteria to include",DIR("B")=1
 S DIR("?",1)="Choose from:",DIR("?",2)="  1   National",DIR("?",3)="  2   Local",DIR("?",4)="  3   Inactive",DIR("?")="Select any combination of the codes listed above, e.g. 1-3, 1,2"
 D ^DIR G:$D(DIRUT) EXIT S QAOSLIST(0)=Y
 W !!,"Select the reporting period:" D ^QAQDATE G:QAQQUIT EXIT
ZIS K %ZIS S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="ENTSK^QAOSPSS",ZTDESC="Occurrence Screen Service Statistics Report",ZTSAVE("QAQ*")="",ZTSAVE("QAO*")="" D ^%ZTLOAD G EXIT
ENTSK D ^QAOSPSS0 U IO D ^QAOSPSS1:QAOSSORT="S",^QAOSPSS2:QAOSSORT="C"
EXIT ;
 W ! D ^%ZISC
 K %DT,%ZIS,DIR,DIRUT,POP,QA,QAO,QAOPIECE,QAOS,QAOSD0,QAOSDATE,QAOSHIEN,QAOSLIST,QAOSPAGE,QAOSQUIT,QAOSRVT,QAOSSCRN,QAOSSEQ,QAOSSERV,QAOSSORT,QAOSTEMP,QAOSTYPE,QAOSWIEN,QAOSZERO,TAB,TODAY,UNDL,X,Y,ZTRTN,ZTSAVE,ZTDESC
 K ^UTILITY($J,"QAOSPSS"),^UTILITY($J,"QAOSXREF"),^UTILITY($J,"QAOQIP")
 K QAOSD1,QAOSCLIN,QAOSFIND,QAOSEXCP,FLG,COLTOT,ROWTOT,QAOSCRN
 D K^QAQDATE S:$D(ZTQUEUED) ZTREQ="@"
 Q
