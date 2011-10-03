DENTPCD ;ISC2/SAW,HAG-COST DISTRIBUTION REPORT ;4/29/96  11:36 ;
 ;;1.2;DENTAL;**4,24**;JAN 26, 1989
 W ! S %DT("A")="Enter CDR REPORT date MONTH/YEAR: ",%DT="AENP" D ^%DT Q:Y<0  K %DT("A") S DATE=Y
 D P S (TD,R,E,F)=0 F X=1:1:7 S TD=TD+$P(A(X),"^"),R=R+$P(A(X),"^",2),E=E+$P(A(X),"^",3),F=F+$P(A(X),"^",4)
 W !!,"The total number of days spent in the area of education is: ",E,!,"Please distribute these days into the three components Instructional,",!,"Administrative and Continuing Education by answering the following",!,"two prompts."
I W !!,"Number of days to distribute to Instructional component: " R X:DTIME G EXIT:X=""!(X="^") G:X["?" I
 I X>E W !!,*7,"You cannot enter a number larger than ",E G I
 S P1=$S(E>0:X/E,1:0)
A W !,"Number of days to distribute to Administrative component: " R X:DTIME G EXIT:X=""!(X="^") G:X["?" A
 S P2=$S(E>0:X/E,1:0) I P1+P2>E W !!,*7,"You only have a total of ",E," days to distribute?",!,"Try again." K P1,P2 G I
 S P3=1-(P1+P2) W !,"Therefore ",P3*E," days are distributed to Continuing Education." R X:3
 S Z3=$O(^DENT(225,0)) G:Z3<1 W I $O(^DENT(225,Z3))>1 D
 .S DIC="^DENT(225,",DIC(0)="AEMNQZ",DIC("A")="Select STATION.DIVISION: "
 .D ^DIC Q:Y<0  K DIC Q
 S Z1=$S(Z3=1:Z3,1:+Y) S (DENTSTA,Z3)=$P(^DENT(225,Z1,0),U,1) I DENTSTA="" D W Q
 W !!,"Note: This report is AUTOMATICALLY QUEUED to print, you must specify a printer.",!! S IOP="Q" D ^%ZIS G CLOSE:IO=""
 S ZTRTN="QUE^DENTPCD",ZTSAVE("A0")="",ZTSAVE("A1")="",ZTSAVE("A2")="",ZTSAVE("DATE")="",ZTSAVE("DENTSTA")="",ZTSAVE("DT2")="",ZTSAVE("P1")="",ZTSAVE("P2")="",ZTSAVE("P3")=""
 S ZTSAVE("TD")="",ZTSAVE("E")="",ZTSAVE("R")="",ZTSAVE("F")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G CLOSE
QUE U IO F I=1:1:18 S B(I)=""
 S A1=A0 F I=0:0 S A1=$O(^DENT(221,"B",A1)),A3="" Q:A1=""!(A1>A2)  F J=0:0 S A3=$O(^DENT(221,"B",A1,A3)) Q:A3=""  S X=^DENT(221,A3,0),P=$P(X,"^",19),N=$S(P>8:18,P=4:16,P=5:17,1:$P(X,"^",6)) S:'N N=1 S:$P(X,"^",9)!($P(X,"^",11)) B(N)=B(N)+2 D P11
 S B=0 F I=1:1:18 S B=B+$P(B(I),"^")
 I B=0 W @IOF,*7,!,"There are no Treatment Data entries for ",DT2,".",!,"Unable to continue." G CLOSE
 S:TD R=R/TD,E=E/TD,F=F/TD
 D ^DENTPCD1 G CLOSE
P11 I $P(X,"^",27)!($P(X,"^",44)) S L=$S($P(X,"^",27)=1:35,$P(X,"^",27)=3:37,1:36),Z=1,B(N)=B(N)+($P(^DIC(220.3,L,0),"^",2)*Z) S:$P(X,"^",45) B(N)=B(N)+$P(X,"^",45) Q
 F M=7,9,11:1:18,20,22:1:26,28:1:38,42,43 I $P(X,"^",M) S L=$P($T(S),";",M),Z=$P(X,"^",M) S:M=7 L=$S(Z="S":4,Z="C":5),Z=1 S:L=18 B(N)=B(N)+(Z-1),Z=1 S B(N)=B(N)+($P(^DIC(220.3,L,0),"^",2)*Z)
 Q
P S DT2=$E(DATE,4,5),DT2=$P($T(DATE),";",DT2+2),(A0,A1)=$E(DATE,1,5)_"00",A2=$E(A0,1,5)_31.2359 F I=1:1:7 S A(I)="^^^"
 F I=0:0 S A1=$O(^DENT(224,"B",A1)),A3="" Q:A1=""!(A1>A2)  F J=0:0 S A3=$O(^DENT(224,"B",A1,A3)) Q:A3=""  S Y=1,X=^DENT(224,A3,0) F K=2,4:1:8 S $P(A(Y),"^")=$P(A(Y),"^")+$P(X,"^",K),Y=Y+1
 S A1=A0 F I=0:0 S A1=$O(^DENT(226,"B",A1)) Q:A1=""!(A1>A2)  F K=0:0 S A3=$O(^DENT(226,"B",A1,A3)) Q:A3=""  D T
 F I=1:1:7 F L=2:1:4 S $P(A(I),"^",L)=$P(A(I),"^",L)+4\8
 Q
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option" G EXIT
T S X=^DENT(226,A3,0),A4=$E($P(X,"^",3),1) Q:A4=0!(A4=3)  S A4=$S(A4=2:1,A4=4:3,A4=5:2,A4>5:7,1:A4)
 S A5=$P(X,"^",4) Q:A5="A"  S A5=$S(A5="R":2,A5="E":3,1:4),$P(A(A4),"^",A5)=$P(A(A4),"^",A5)+$P(X,"^",5) Q
S ;;;;;;;;8;;9;15;16;33;10;20;21;22;;23;;11;12;13;14;17;;24;25;26;27;28;29;30;31;18;19;32;;;;34;6
DATE ;;JANUARY;FEBRUARY;MARCH;APRIL;MAY;JUNE;JULY;AUGUST;SEPTEMBER;OCTOBER;NOVEMBER;DECEMBER
CLOSE X ^%ZIS("C")
EXIT K %DT,A,B,A0,A1,A2,A3,A4,A5,C,DATE,DENTSTA,DT2,E,F,I,IO("Q"),J,K,L,M,N,P,P1,P2,P3,R,RT,ST,TD,X,Y,Z,Z1,Z3 K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK Q
