PRSAENX ; HISC/REL-List Entitlement ;3/12/93  12:58
 ;;4.0;PAID;**34,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 K DIC S DIC="^PRST(457.5,",DIC(0)="AEQM" W ! D ^DIC G:Y<1 EX S ENT=^PRST(457.5,+Y,1),NAM=$P(Y,"^",2)
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSAENX",PRSALST="NAM^ENT" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Display Entitlement Entry
 W:$E(IOST,1,2)="C-" @IOF W !?29,"PAY ENTITLEMENT TABLE"
 W !,"Name: ",NAM,! D Q2
 I $E(IOST,1,2)="C-" R !!,"Press RETURN to Continue. ",X:DTIME
 Q
Q2 ; Display Entitlement List
 S M("H")="Hrs.",M("D")="Days",M(0)="No",M(1)="Yes"
 F K=1:1:19 W !,$P($T(ENT+K),";;",2),?30,M($E(ENT,K)),?40,$P($T(ENT+K+19),";;",2),?70,M($E(ENT,K+19))
 Q
EX G KILL^XUSCLEAN
ENT ;;
1 ;;Regular Scheduled
2 ;;Regular Unscheduled
3 ;;FF Reg. Sch. Hrs. Over 53
4 ;;Reserved for future use
5 ;;Recess Periods
6 ;;Night Differential - 2
7 ;;Night Differential - 3
8 ;;Saturday Premium
9 ;;Sunday - Day
10 ;;Sunday - 2
11 ;;Sunday - 3
12 ;;Overtime - Day
13 ;;Overtime - 2
14 ;;Overtime - 3
15 ;;Hazardous Duty
16 ;;Environmental Differential
17 ;;Scheduled CB OT
18 ;;Travel OT
19 ;;Hrs. >8 - Day
20 ;;Hrs. > 8 - 2
21 ;;Hrs. > 8 - 3
22 ;;Holiday - Day
23 ;;Holiday - 2
24 ;;Holiday - 3
25 ;;Holiday OT
26 ;;On Call
27 ;;Sleep Time
28 ;;CompTime/CreditHrs Earn/Use
29 ;;Standby
30 ;;Annual/Restored Leave
31 ;;Sick Leave
32 ;;NonPay Annual Leave
33 ;;AWOL/Susp/LWOP
34 ;;Military Leave
35 ;;Authorized Absence
36 ;;Non-Pay
37 ;;Continuation of Pay
38 ;;VCS Commission Sales
39 ;;FireFighter Overtime
