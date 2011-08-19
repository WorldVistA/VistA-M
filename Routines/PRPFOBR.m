PRPFOBR ;ALTOONA/CTB-OPTION TO RECALCULATE PATIENT BALANCES ;04/15/02
V ;;3.0;PATIENT FUNDS;**6,13**;JUNE 1, 1989
SE S %A="This option will recalculate the balances of a patient account",%A(1)="It should only be used after the account has be audited and it",%A(2)="has been determined that all transactions are valid."
 S %=2,U="^" W !,*7 S %A(3)="Do you really want to run this option",%B="" D ^PRPFYN G:%'=1 NA
SE1 W !! S DIC="^PRPF(470,",DIC(0)="AEQMNZ" D ^DIC G:Y<0 OUT S (PF("PBAL"),PF("GBAL"),PF("BAL"))=0,DFN=+Y D CALC
 W !,?10,"BALANCE IN ACCOUNT",?50,"CORRECTED BALANCE" S X=$S($D(^PRPF(470,DFN,1)):^(1),1:"")
 W !,"TOTAL",?15,$J($P(X,U,4),8,2),?55,$J(PF("BAL"),8,2),!,"P/S",?15,$J($P(X,U,5),8,2),?55,$J(PF("PBAL"),8,2),!,"GRAT",?15,$J($P(X,U,6),8,2),?55,$J(PF("GBAL"),8,2)
 S %=2 W ! S %A="Are you ready to Post the corrected balances to the account",%B="" D ^PRPFYN G:%<0 NA I %'=1 D NA S DIC("A")="Select Next Patient: " G SE1
 S %A="ARE YOU SURE",%B="",%=2 D ^PRPFYN G:%<0 NA I %'=1 D NA S DIC("A")="Select Next Patient: " G SE1
 S $P(^PRPF(470,DFN,1),U,4,6)=PF("BAL")_U_PF("PBAL")_U_PF("GBAL") W "  ---Done---" R X:2 D OUT
 W !! S DIC("A")="Select Next Patient: " G SE1
CALC S (DA,PF("BAL"),PF("PBAL"),PF("GBAL"))=0 F N=0:0 S DA=$O(^PRPF(470,DFN,3,DA)) Q:'DA  D CALC1
 Q
CALC1 S X=^PRPF(470,DFN,3,DA,0) S PF("PBAL")=PF("PBAL")+$P(X,U,4),PF("GBAL")=PF("GBAL")+$P(X,U,5),PF("BAL")=PF("BAL")+$P(X,U,3),$P(^(0),U,6)=PF("BAL") Q
TM S PRPFRNG="@",PRPFRNG2=""
ALL ;;SCREEN ALL PATIENT FUND ACCOUNTS AND PRINT LIST OF OUT OF BALANCES
 K ^TMP("PRPFAH",$J)
 S X="  Hold on while I search the file . . .*" D MSG^PRPFQ
 S DFN=0,U="^" F I=1:1 S DFN=$O(^PRPF(470,DFN)) Q:DFN'=+DFN  D CHECK
 I '$D(^TMP("PRPFAH",$J)) D NONE G OUT
 S DIC="^PRPF(470,",L=0,L(0)=1,BY="@73:99;S1,.01",BY(0)="^TMP(""PRPFAH"",$J,",FLDS="[PRPF OUT OF BALANCE]",FR=""_PRPFRNG_"",TO=""_PRPFRNG2_"" S IOP=$S($D(PRIOP):PRIOP,1:ION)
 S DIOEND="K ^TMP(""PRPFAH"") W !,""The information contained in this report is protected by the Privacy Act of 1974"""
 S:PRPFRNG="@" BY="@73,@73:99;S1,.01",FR="@,@",TO=","
 D EN1^DIP
 S ZTREQ="@"
OUT K %,%W,C,DA,DFN,DIC,DIYS,K,N,PF,POP,PRPFRNG,PRPFRNG2,S,X,XBAL,XPBAL,XGBAL,X1,Y D DIKILL^PRPFQ,ZTKILL^PRPFQ
 Q
NONE S IOP=ION W @IOF D NOW^PRPFQ W "PATIENT FUNDS OUT OF BALANCE REPORT",?50,%X,!!,"No Out of Balance Accounts Were Found While Running This Report" W:$E($G(IOST))="P" @IOF
 Q
CHECK D CALC S X=PF("BAL")+PF("PBAL")+PF("GBAL"),X2=$S($D(^PRPF(470,DFN,1)):^(1),1:""),XBAL=$P(X2,U,4),XPBAL=$P(X2,U,5),XGBAL=$P(X2,U,6)
 S X1=XBAL+XPBAL+XGBAL
 I +X'=+X1 G SET
 I +PF("BAL")'=+XBAL G SET
 I +PF("PBAL")'=+XPBAL G SET
 I +PF("GBAL")'=+XGBAL G SET
 Q
SET S ^TMP("PRPFAH",$J,DFN)=""
 Q
NA W:(IOM-$X)<25 ! W "  <No action taken>",*7 R X:3 W !! G OUT
QUE ;QUEUE ALL^PRPFOBR TO RUN AS TASKMAN JOB
 W !,"This program will review all Patient Funds Accounts and print a",!,"report of all accounts which are out of balance in any way. ",!!
 W "Due to the length of time that this report may take, it is suggested that it,",!," be queued.",!!
 D SELRNG^PRPFQ
 I PRPFRNG="" D OUT QUIT
 I PRPFRNG="@" S PRPFRNG2=""
 E  S PRPFRNG2=PRPFRNG
 S ZTSAVE("PRPFRNG")=PRPFRNG,ZTSAVE("PRPFRNG2")=PRPFRNG2
 S ZTRTN="ALL^PRPFOBR",ZTDESC=$P($T(ALL),";",3) D ^PRPFQ G OUT
