PRCPRPHW ;WISC/RFJ-physical count form ; 3/22/99 11:17am
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%H,%I,A,ACCOUNT,ACCT,ACCTALL,D,DIR,DIRUT,DTOUT,DUOUT,ITEMDA,MAIN,NOW,NSN,PAGE,PRCPEXIT,PRCPFLAG,PRCPOH,SCREEN,X,Y
 S PRCPOH=0
 S XP="Do you need to print the ON-HAND column"
 S XH="Enter 'YES' only if you are NOT performing a physical count."
 W ! S %=$$YN^PRCPUYN(2)
 I %=0 Q
 I %=1 S PRCPOH=1
 W !!,"Selected account codes will be used to generate the physical count form."
 K ACCOUNT D ALLACCT I $G(PRCPFLAG) Q
 F  D  I $G(PRCPFLAG) Q
 .   I $O(ACCOUNT("YES",0))!($G(ACCTALL)) D
 .   .   W !!,"  Currently selected account codes:",!,"  "
 .   .   I $G(ACCTALL) W "<< ALL ACCOUNT CODES >>"
 .   .   E  S A=0 F  S A=$O(ACCOUNT("YES",A)) Q:'A  W:$X>70 !,"  " W A,"          "
 .   .   W !,"  You can DE-select one of the above account codes by reselecting it."
 .   I $O(ACCOUNT("NO",0)) D
 .   .   W !!,"  Currently DE-selected account codes:",!,"  "
 .   .   S A=0 F  S A=$O(ACCOUNT("NO",A)) Q:'A  W:$X>70 !,"  " W A,"          "
 .   .   W !,"  You can RE-select one of the above account codes by reselecting it."
 .   W !!,"Select the number of the account code created, '^' to exit."
 .   S DIR(0)="SO^1:Account Code 1;2:Account Code 2;3:Account Code 3;6:Account Code 6;8:Account Code 8;",DIR("A")="Select ACCOUNT Code" D ^DIR I $D(DTOUT)!($D(DUOUT)) S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S Y=+Y
 .   I Y=0,'$O(ACCOUNT("YES",0)),'$G(ACCTALL) D ALLACCT S:$G(PRCPFLAG) PRCPEXIT=1 Q
 .   I Y=0 S PRCPFLAG=1 Q
 .   I $G(ACCTALL),'$D(ACCOUNT("NO",Y)) K ACCOUNT("YES",Y) S ACCOUNT("NO",Y)="" W !?10,"DE-selected !" Q
 .   I $D(ACCOUNT("YES",Y)) K ACCOUNT("YES",Y) S ACCOUNT("NO",Y)="" W !?10,"DE-selected !" Q
 .   I $D(ACCOUNT("NO",Y)) K ACCOUNT("NO",Y) S ACCOUNT("YES",Y)="" W !?10,"RE-selected !" Q
 .   S ACCOUNT("YES",Y)="" W !?10,"selected !"
 I $G(PRCPEXIT) D Q Q
 I $G(ACCTALL) K ACCOUNT("YES")
 I '$G(ACCTALL),'$O(ACCOUNT("YES",0)) W !!,"NO ACCOUNT CODES SELECTED." D Q Q
 I $G(ACCTALL) F A=1,2,3,6,8 I '$D(ACCOUNT("NO",A)) S ACCOUNT("YES",A)=""
 S %ZIS="Q" W ! D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Physical Count Form",ZTRTN="DQ^PRCPRPHW"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ACC*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;queue comes here
 K ^TMP($J,"PRCPRPH"),PRCPFLAG
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S NSN=$$NSN^PRCPUX1(ITEMDA),ACCT=$$ACCT1^PRCPUX1($E(NSN,1,4)) I $D(ACCOUNT("YES",ACCT)) D
 .   S:NSN="" NSN=" "
 .   S %=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),MAIN=+$P(%,"^",6),MAIN=$$STORELOC^PRCPESTO(MAIN) S:MAIN="?" MAIN=" ?"
 .   S ^TMP($J,"PRCPRPH",MAIN,ACCT,NSN,ITEMDA)=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)_"^"_$$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/")_"^"_$P(%,"^",7)
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S MAIN="" F  S MAIN=$O(^TMP($J,"PRCPRPH",MAIN)) Q:MAIN=""!($G(PRCPFLAG))  D
 .   W !!?5,"MAIN STORAGE LOCATION: ",MAIN
 .   S ACCT="" F  S ACCT=$O(^TMP($J,"PRCPRPH",MAIN,ACCT)) Q:ACCT=""!($G(PRCPFLAG))  D
 .   .   W !?10,"ACCOUNT CODE: ",ACCT
 .   .   S NSN="" F  S NSN=$O(^TMP($J,"PRCPRPH",MAIN,ACCT,NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRPH",MAIN,ACCT,NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   .   .   W !,$TR(NSN,"-"),?17,$E($P(D,"^"),1,23),?42,ITEMDA,?47,$J($P(D,"^",2),10)
 .   .   .   I PRCPOH=1 W $J($P(D,"^",3),12)
 .   .   .   W ?71,"_________"
 .   .   .   S X=0 F Y=1:1 S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,1,X)) Q:'X  S D=$G(^(X,0)) I D'="" D
 .   .   .   .   I Y=1 W !?20,"ADD STORAGE: "
 .   .   .   .   I $X>50 W !?20
 .   .   .   .   W $E($$STORELOC^PRCPESTO($P(D,"^")),1,15),"   "
 .   .   .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   .   I $G(PRCPFLAG) Q
 .   .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   I $G(PRCPFLAG) Q
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 .   I $G(PRCPFLAG) Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I '$G(PRCPFLAG) D END^PRCPUREP
Q K ^TMP($J,"PRCPRPH") D ^%ZISC Q
 ;
 ;
ALLACCT ;  select all account codes
 K ACCTALL,PRCPFLAG
 S XP="Do you want to select ALL account codes",XH="Enter 'YES' to generate the physical count form for ALL acount codes",XH(1)="enter 'NO' to print the physical count form for selectable account codes"
 S XH(2)="or enter '^' to exit."
 W ! S %=$$YN^PRCPUYN(1)
 I %=2 Q
 I %=1 S ACCTALL=1 Q
 S PRCPFLAG=1 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PHYSICAL COUNT FORM: ",$E(PRCP("IN"),1,12),?(80-$L(%)),%
 S %="",$P(%,"-",81)="" W !,"NSN",?15,"DESCRIPTION",?42,"MI",?50,"UNIT/ISS"
 I PRCPOH=1 W ?62,"ON HAND"
 W ?71,"NEW COUNT",!,%
 Q
