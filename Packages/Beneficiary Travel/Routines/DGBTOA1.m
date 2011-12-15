DGBTOA1 ;ALB/TT,ALB/MAC - BENEFICIARY TRAVEL OUTPUTS ;4/22/91  12:50
 ;;1.0;Beneficiary Travel;**2**;September 25, 2001
 D QUIT D DT^DICRW,ASK2^DGBTDIV G QUIT:Y<0 S VAUTNI=1,(DGBTBEG,DGBTEND)=0
BEG W ! S %DT="AEX",%DT("A")="Enter beginning date: " D ^%DT S DGBTBG=Y,DGBTBEG=Y-.0001 G:X="^"!(X="") QUIT
END W ! S %DT("A")="Enter ending date: " D ^%DT G:X="^" QUIT I Y<1 D HELP^%DTC G END
 S DGBTEND=Y_.9999
 I DGBTEND\1<DGBTBG W !!?5,"The ending date cannot be before the beginning date" G END
 D NOW^%DTC I DGBTEND-.9999>X!(DGBTBG>X) W !!?5,"Future dates are not allowed" G BEG
SORT W !! S DIR("A")="Sort output by: ",DIR("B")="PATIENT",DIR(0)="SA^P:PATIENT;C:CARRIER;A:ACCOUNT;T:ACCOUNT TYPE"
 S DIR("?")="Select one from the above list",DIR("?",1)="Sort Bene Travel claims by one of the following:",DIR("?",2)="   A for Account",DIR("?",3)="   C for Carrier",DIR("?",4)="   P for Patient",DIR("?",5)="   T for Account Type"
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!(Y="^")!(Y<0) G QUIT
 S DGBTSL=$S(Y="A":"ACCT",Y="T":"TYP",Y="C":"CAR",1:"PAT") K Y D ACCT:DGBTSL="ACCT",TYP:DGBTSL="TYP",CAR:DGBTSL="CAR",PAT:DGBTSL="PAT" G:Y<0!(Y="^")!($D(DTOUT))!($D(DUOUT)) QUIT
DISP ;
 S DIR("A",1)="",DIR("A")="Display Report (F)ULL or (T)OTALS ONLY: ",DIR("B")="FULL",DIR("?")="^D HELP^DGBTOA1",DIR(0)="SA^F:FULL;T:TOTALS"
 D ^DIR K DIR G QUIT:$D(DIRUT)
 S DGBTZ=$E(Y)
 S DGVAR="VAUTN#^DGBTBEG^DGBTBG^DGBTEND^DGBTSL^DGBTZ^VAUTD#",DGPGM="START^DGBTOA2" W ! D ZIS^DGBTUTQ I 'POP U IO D START^DGBTOA2
QUIT K %,%DT,DFN,DGBT2,DGBT3,DGBT4,DGBTA,DGBTAT,DGBTB,DGBTBEG,DGBTBG,DGBTBY,DGBTC,DGBTCH,DGBTCL,DGBTCW,DGBTD,DGBTD1,DGBTDD,DGBTDN,DGBTDT,DGBTDV,DGBTEND,DGBTF,DGBTG,DGBTGT
 K DGBTI,DGBTIX,DGBTK,DGBTK9,DGBTK10,DGBTNO,DGBTO,DGBTOD,DGBTODV,DGBTOTX,DGBTP,DGBTPG,DGBTPTC,DGBTS,DGBTSD
 K DGBTSDT,DGBTSL,DGBTSSN,DGBTT,DGBTU,DGBTV,DGBTX,DGBTX1,DGBTXX,DGBTY,DGBTZ,DGPGM,DGSCR,DGVAR,DIC,DIR,DTOUT,DUOUT,K,K1,L1,M,POP,PRCABN,SSN,VA,VADAT,VADATE,VAERR,VAUTD
 K VAUTN,VAUTNI,VAUTSTR,VAUTVB,X,X2,Y,Z,^UTILITY($J)
 Q
 ;Selects the patient,account,carrier,account type (one,many,all).
PAT S VAUTNI=2 D PATIENT^VAUTOMA
 Q
ACCT S VAUTVB="VAUTN",DIC="^DGBT(392.3,",VAUTSTR="account",VAUTNI=2,DIC("S")="I $P(^(0),U,3)'>DGBTEND&('$P(^(0),U,4)!($P(^(0),U,4)>DGBTBG))" D FIRST^VAUTOMA
 Q
CAR I '$P($G(^DG(43,1,"BT")),U,4) S VAUTVB="VAUTN",PRCABN=0,DIC="^PRC(440,",VAUTSTR="carrier",VAUTNI=2 D FIRST^VAUTOMA
 I $P($G(^DG(43,1,"BT")),U,4) S VAUTVB="VAUTN",PRCABN=0,DIC="^DGBT(392.31,",VAUTSTR="CoreFLS Carrier",VAUTNI=2 D FIRST^VAUTOMA
 Q
TYP S DIR("A")="Would you like ALL Account Types",DIR(0)="Y",DIR("B")="NO",DIR("?")="Enter 'Yes' if you wish to include ALL Account Types or press Return to select individual Account Types."
 D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))
 I Y=1 S VAUTN=1 Q
 S DIR("A")="Select ACCOUNT TYPE",DIR(0)="392.3,5"
 S DIR("?")="Enter the account type by which you would like to sort bene travel claims."
 D ^DIR Q:$D(DTOUT)!($D(DUOUT))
 S VAUTN=0,VAUTN(Y)="",DIR("A")="Select another ACCOUNT TYPE",$P(DIR(0),"^",1)=$P(DIR(0),"^",1)_"O"
TYPMNY D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 I X]"" S VAUTN(Y)="" D TYPMNY
 K DIR Q
HELP W !!?10,"Choose either:",!?20,"F - To get FULL DISPLAY as well as TOTALS",!?20,"(Report contains Patient name, Date of claim, Patient ID, ",!?20,"Account, Carrier, Deductible, Amount payable)",!!?20,"T - To display TOTALS ONLY",!!
 Q
