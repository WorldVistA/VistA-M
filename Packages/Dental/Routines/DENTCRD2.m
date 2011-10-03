DENTCRD2 ;ISC2/SAW-PROCESS DENTAL CARD CON'T ;3/29/89
 ;;1.2;DENTAL;**3,16,19,21,24,28**;JAN 26, 1989
 S M="ERROR-- " G:'$D(D2) NCT S X=$P(D2,"^",19)
 I X<8&(X'=4)&(X'=5)&($P(D2,"^",6)="") S E=1 W !,M,"Bed section is missing."
 I $P(D2,"^",6)'="" I X>8!(X=4)!(X=5) S E=1 W !,M,"Bed section must be blank if patient category is OPT, NHC or DOM."
 I $P(D2,"^",27)!($P(D2,"^",44)) I X>17!(X<9) S E=1 W !,M,"Patient category must be Class I-VI (9-17) for spot check/pre-auth exam."
 I X=7!(X=8)!(X=21)!(X=22) I $P(D2,"^",7)="S"!($P(D2,"^",15))!($P(D2,"^",16))!($P(D2,"^",17))!($P(D2,"^",18))!($P(D2,"^",42))!($P(D2,"^",43)) S E=1 W !,M,"Patient category and type of service code are incompatible."
 I $P(D2,"^",43),$P(D2,"^",7)]"" S E=1 W !,M,"You are not allowed to mark both the screening/complete and evaluation fields."
 I $P(D2,"^",12)'=""!($P(D2,"^",13)'="") I $P(D2,"^",26)'="" S E=1 W !,M,"Patient education must be blank if prophy is marked."
 I $P(D2,"^",24)'=""&($P(D2,"^",25)'="") W !,"WARNING - Both perio and quad fields have been marked, please verify."
 I ($P(D2,"^",30)=""&($P(D2,"^",31)'=""))!($P(D2,"^",31)=""&($P(D2,"^",30)'="")) S E=1 W !,M,"Only one fixed partial field is marked.  Both must be marked or blank."
 I $P(D2,"^",14) I $E($P(D2,"^",10),1)'<3 S E=1 W !,M,"Operating room can only be marked if the provider is a staff dentist."
NCT S M="ERROR-- " I $D(DENT),$E(D,69,73)?5" " W *7,!,M,"All non clinical time fields are blank."
 G:$E(D,69,73)?5" " EXIT
 S Z1=$E(D,14),Z2=$E(D,15),Z3=$E(D,16),Z4=$E(D,17),Z5=$E(D,18)
 I Z1'=" " G:Z2 ERR S Z=Z1+1 G DAY
 G:Z2=" " ERR S Z=Z2+3
DAY G:Z<1!(Z>12) ERR S ZZ=$P($T(DATE),";",Z+2)
 I Z=2 S ZZ=ZZ+$$LEAP^DENTE1(1700+$E(DT,1,3))
 I $L(Z)=1 S Z=0_Z
 S Z3=$S(Z3=7:10,Z3=8:20,Z3=9:30,1:0),Z4=$S(Z4=" "!(Z4>8):0,1:Z4+1),Z4=Z3+Z4 G:Z4<1!(Z4>ZZ) ERR I $L(Z4)=1 S Z4=0_Z4
 S Z5=$E(DT,2,3),Z6=$E(DT,1)_Z5_"01" S:DENTY XX1=$$YR^DENTCRD1(Z6),Z5=$E(XX1,2,3) S:$L(Z5)=1 Z5=0_Z5 S Z=$S(DENTY:$E(XX1,1),1:$E(DT,1))_Z5_Z_Z4
 D NOW^%DTC
 S (A0,Z)=Z_"."_$P(%,".",2)
 S (Z,A0)=+$$CHECK^DENTE1(226,Z)
 G PROV
ERR S E=1,A0="" I $D(DENT) W !,M,"Date entry is incorrect."
PROV S X=$E(D,1,4) I X'?4N S E=1 W !,M,"Provider ID number entry is incorrect." G TIME
 S Z=$O(^DENT(220.5,"C",X,0)) I $D(^DENT(220.5,+Z,0)),$P(^(0),"^",3)="" S A0=A0_"^"_DENTSTA_"^"_X G TIME
 S E=1 W !,M,"Provider ID number does not exist in provider file."
TIME S A1=$E(D,68),A2=$E(D,69),A3=$E(D,70),A4=$E(D,71),A5=$E(D,72),X1=$E(D,1),X1=$S(X1=0:6,X1=2:1,X1>6:6,1:X1)
 I (A1=" "&(A2=" "))!(A3=" "&(A4=" ")&(A5=" ")) S E=1 W !,M,"Non clinical time entries are incorrect." G Q
 I A1,A2 S E=1 W !,M,"Two categories have been marked for non clinical time." G TIME1
 I A1 S A1=$S(A1=1:"R",A1=5:"A",1:"")
 I A2 S A1=$S(A2=1:"E",A2=5:"F",1:"")
 I A1="" S E=1 W !,M,"Non clinical time category entry is incorrect."
 I A1'="" S X2=$S(A1="R":1,A1="E":2,A1="F":3,1:4)
TIME1 S A3=$S(A3=6:10,A3=7:20,A3=8:30,A3=9:40,1:""),A4=$S(A4>0&(A4<10):A4,1:""),A5=$S(A5=1:.25,A5=2:.5,A5=3:.75,1:""),A3=A3+A4+A5
 I A3<.25!(A3>49.75) S E=1 W !,M,"Non clinical time hours/minutes entry is incorrect."
 I X1'=1&(A1="A"!(A1="F")) S E=1 W !,M,"Only dentists may enter non clin. time spent in admin or fee categories."
Q I E S:$D(DENT) DENTERR=DENTERR+1 G EXIT
 I '$D(^DENT(226,0)) S E=1 W !!,"YOUR DENTAL NON CLINICAL TIME FILE IS NOT SET UP PROPERLY",!,"CONTACT YOUR SITE MANAGER" G EXIT
 S P1=$P(^DENT(226,0),"^",4),P1=P1+1,A0=A0_"^"_A1_"^"_A3
 D SAVE^DENTCRD(226,A0,.P)
 S ^DENT(226,0)=$P(^DENT(226,0),"^",1,2)_"^"_P_"^"_P1 S:$D(DENT) DENTVAL=DENTVAL+1
EXIT W:E *7 K:E D2 K A0,A1,A2,A3,A4,A5,D1,E,E1,F,I,L1,L2,L3,L4,L5,L6,M,P,P1,P2,X,X1,X2,X3,XX1,Z,Z1,Z2,Z3,Z4,Z5,Z6,ZZ Q
DATE ;;31;28;31;30;31;30;31;31;30;31;30;31
