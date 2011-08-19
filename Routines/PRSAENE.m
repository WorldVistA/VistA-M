PRSAENE ; HISC/REL-Display Employee Entitlement ;3/21/94  13:44
 ;;4.0;PAID;;Sep 21, 1995
 S PRSTLV=7 D ^PRSAUTL G:TLI<1 EX
E1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC G:DFN<1 EX
 D ^PRSAENT I ENT="" W !!?5,"No Entitlement Table entry was found for this Employee." G E1
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSAENE",PRSALST="DFN^ENT" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; List Entitlement for Employee
 W:$E(IOST,1,2)="C-" @IOF W !?28,"EMPLOYEE PAY ENTITLEMENTS"
 S X=$G(^PRSPC(DFN,0)) W !,$P(X,"^",1) S X=$P(X,"^",9) I X W ?67,$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9)
 W ! D Q2^PRSAENX
 I $E(IOST,1,2)="C-" R !!,"Press RETURN to Continue. ",X:DTIME
 Q
EX G KILL^XUSCLEAN
