IBOTR ;ALB/CPM - INSURANCE PAYMENT TREND REPORT - USER INTERFACE; 5-JUN-91
 ;;2.0;INTEGRATED BILLING;**42,100,118,128**;21-MAR-94
 ;
 ;MAP TO DGCROTR
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOTR-1" D T0^%ZOSV ;start rt clock
 D DT^DICRW,HOME^%ZIS
 ;
 ; - Sort by division.
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to sort this report by division"
 S DIR("?")="^S IBOFF=1 W ! D HELP^IBOTR"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G END
 S IBSDIV=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Issue prompt for division.
 I IBSDIV D PSDR^IBODIV G:Y<0 END
 ;
 ; - Select bill type to print.
 S DIC="^DGCR(399.3,",DIC(0)="AEQMN",DIC("S")="I $P(^(0),U,7)=""i"""
 W ! D ^DIC K DIC G END:Y<1 S IBRT=+Y,IBRTN=$P(Y,U,2)
 ;
 ; - Issue selection field decision prompt.
 W !!,"You may select a field from the BILL/CLAIMS file which you may"
 W !,"use to limit the selection of records to appear on the report.",!
 S DIR(0)="Y",DIR("A")="Do you wish to choose such a field"
 S DIR("B")="NO",DIR("?")="^S IBOFF=7 W ! D HELP^IBOTR"
 D ^DIR K DIR G END:$D(DIRUT),CONT:'Y
 ;
 ; - Issue selection field prompts.
 S DIC="^DD(399,",DIC(0)="AEQM",DIC("A")="Select BILL/CLAIMS FIELD: "
 S DIC("S")="S IBX=$P(^(0),U,2) I $S('$D(^DD(+IBX,.01,0)):1,$P(^(0),U,2)[""M"":0,1:1)"
 D ^DIC K DIC,IBX I Y<0 G CONT
 S IBAF=+Y,IBAFN=$P(Y,U,2),IBAFD=$P($G(^DD(399,IBAF,0)),U,2)["D"
 ;
FD1 W !?3,"Start with "_IBAFN_": FIRST// " R X:DTIME G END:'$T!(X["^")
 I $E(X,1,2)="??" S IBOFF=7 D HELP1,HELP2,HELP W ! G FD1
 I $E(X)="?" S IBOFF=13 D HELP2,HELP W ! G FD1
 I "@"[X S IBAFF=$S(IBAFD&(X=""):0,1:X) G FD2
 I IBAFD D ^%DT K %DT S IBAFF=Y I Y<0 K IBAFF W ! S IBOFF=7 D HELP W ! G FD1
 I 'IBAFD S IBAFF=X
 ;
FD2 W !?8,"Go to "_IBAFN_": LAST// " R X:DTIME G END:'$T!(X["^")
 I $E(X,1,2)="??" S IBOFF=19 D HELP1,HELP2,HELP W ! G FD2
 I $E(X)="?" S IBOFF=13 D HELP2,HELP W ! G FD2
 I X="" S IBAFL=$S(IBAFD:9999999,1:"") S:IBAFF="" IBAFZ="ALL" G CONT
 I X="@",IBAFF="@" S IBAFL="@",IBAFZ="NULL" G CONT
 I IBAFD D ^%DT K %DT S IBAFL=Y I Y<0!(IBAFF'="@"&(Y<IBAFF)) K IBAFL W !!?3,"LAST DATE must follow the BEGIN DATE.",! G FD2
 I 'IBAFD,+IBAFF=IBAFF,+X=X G:X'<IBAFF FD21 W !!?3,"The LAST value must follow the FIRST.",! G FD2
 I 'IBAFD,IBAFF'="@",IBAFF]X W !!?3,"The LAST value must follow the FIRST.",! G FD2
FD21 I 'IBAFD S IBAFL=X
 ;
CONT D ^IBOTR1 ; Continue user interface/compile and print report.
 ;
END K IBRT,IBRTN,IBADFREF,IBAF,IBAFN,IBAFD,IBAFF,IBAFL,IBAFZ,IBBRT,IBBRN,IBG
 K IBDF,IBDFN,IBBDT,IBEDT,IBICF,IBICL,IBIC,IBBRTY,IBOFF,IBTEXT,IBARST
 K IBCANC,IBCNC,IBINRC,IBPRNT,IBSDIV,IBSORT,IBICPT,VAUTD
 K DIROUT,DTOUT,DUOUT,DIRUT
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOTR" D T1^%ZOSV ;stop rt clock
 Q
 ;
HELP F  S IBTEXT=$P($T(TEXT+IBOFF),";",3) Q:IBTEXT=""  W !,IBTEXT S IBOFF=IBOFF+1
 Q
 ;
HELP1 W ! S IBX=0 F  S IBX=$O(^DD(399,IBAF,21,IBX)) Q:'IBX  W:$D(^(IBX,0)) !,^(0)
 K IBX Q
 ;
HELP2 W:$D(^DD(399,IBAF,3)) !!,^(3),! Q
 ;
TEXT ; - 'Sort by division' prompt.
 ;;      Enter:  '<CR>' -  To print the report without regard to division
 ;;              'Y'    -  To select those divisions for which a separate
 ;;                         report should be created
 ;;              '^'    -  To quit this option
 ;
 ; - 'Additional field' prompt.
 ;;      Enter:  'Y'    -  To select a field from the BILL/CLAIMS file
 ;;              'N'    -  To skip this prompt and continue with this
 ;;                         option
 ;;              '^'    -  To quit this option
 ;
 ; - 'Start with FIELD NAME' prompt.
 ;;      Enter a valid field value, or
 ;;              '@'    -  To include null values
 ;;              '<CR>' -  To start from the 'first' value for this field
 ;;              '^'    -  To quit this option
 ;
 ; - 'Go to FIELD NAME' prompt.
 ;;      Enter a valid field value, or
 ;;              '@'    -  To include only null values, if 'Start with'
 ;;                         value is @
 ;;              '<CR>' -  To go to the 'last' value for this field
 ;;              '^'    -  To quit this option
 ;
