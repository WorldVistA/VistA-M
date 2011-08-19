LRBLJC ;AVAMC/REG - COMPONENT DISPOSITION LIST ;2/18/93  09:10
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?20,"COMPONENT DISPOSITION BY DATE UNIT RECEIVED"
 W ! S DIC=66,DIC(0)="AEQM",DIC("A")="Select BLOOD COMPONENT: " D ^DIC K DIC G:Y<1 END S LRM=+Y,LRM(1)=$P(Y,U,2)
ABO R !,"Select ABO Group: ",X:DTIME G:X=""!(X[U) END I X'="A",X'="B",X'="AB",X'="O" W $C(7),"  Enter A, B, AB or O" G ABO
 S LRABO=X
ASK W !!,"Select (T)ransfusions or (A)ll other dispositions: " R X:DTIME G:X=""!(X[U) END S X=$A(X) S:X>97 X=X-32 I X'=65,X'=84 D HLP^LRBLJB G ASK
 S LRW=$C(X) D B^LRU G:Y<0 END S ZTRTN="QUE^LRBLJC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S:LRW="A" LRS=$P(^DD(65,4.1,0),U,3) S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99 D L^LRU,S^LRU,H
 F LRA=LRSDT:0 S LRA=$O(^LRD(65,"A",LRA)) Q:'LRA!(LRA>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"A",LRA,LRI)) Q:'LRI  D B
 G:LRW="A" D
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=^LR(A,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)") S ^TMP($J,"B",$P(X,"^"),A)=$P(X,"^",9)
 S LRP=0 F LRA=0:0 S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""  F LRDFN=0:0 S LRDFN=$O(^TMP($J,"B",LRP,LRDFN)) Q:'LRDFN  S SSN=^(LRDFN),LRDPF=$P(^LR(LRDFN,0),U,2) D SSN^LRU,W
OUT D END^LRUTL,END Q
D S LRE=0 F LRF=0:0 S LRE=$O(^TMP($J,LRE)) Q:LRE=""  S X=LRE_":",LRD=$P($P(LRS,X,2),";") D:$Y>(IOSL-6) H W !?11,LRD D F
 G OUT
F S LRC=0 F LRA=0:0 S LRC=$O(^TMP($J,LRE,LRC)) Q:LRC=""  F LRI=0:0 S LRI=$O(^TMP($J,LRE,LRC,LRI)) Q:'LRI  D:$Y>(IOSL-6) H2 W !?45,LRC S X1=$P(^LRD(65,LRI,4),"^",2),X2=$P(^(0),"^",5) D ^%DTC S:X=0 X="<1" W ?65,$J(X,5)
 Q
W D:$Y>(IOSL-6) H W !!,LRP," ",SSN
 S LRE=0 F LRF=0:0 S LRE=$O(^TMP($J,LRDFN,LRE)) Q:LRE=""  S LRI=$O(^TMP($J,LRDFN,LRE,0)) D Y
 Q
Y D:$Y>(IOSL-6) H1 S X1=$P(^LRD(65,LRI,4),"^",2),X2=$P(^(0),"^",5) D ^%DTC S:X=0 X="<1" I LRW="A" S LRX=$P(^LRD(65,LRI,4),"^")_":",LRX=$P($P(LRS,LRX,2),";")
 W !?11,$S(LRW="T":$P(^LRD(65,LRI,6),"^",3),1:LRX),?45,LRE,?65,$J(X,5) Q
 ;
B I '$D(^LRD(65,LRI,0)) K ^LRD(65,"A",LRA,LRI) Q
 S X=^LRD(65,LRI,0) I $D(^(4)),$P(X,"^",4)=LRM,$P(X,"^",7)=LRABO S LRY=$P(^(4),"^") D @(LRW)
 Q
T Q:'$D(^LRD(65,LRI,6))  S X=+^(6) Q:'X
S S Z=^LRD(65,LRI,0),^TMP($J,X,$P(Z,"^"),LRI)="" Q
A Q:LRY="T"!(LRY="")  S X=LRY G S
 Q
 ;
H S LRQ=LRQ+1,X="N",%DT="T" D ^%DT,D^LRU W @IOF,Y," ",LRQ(1),?(IOM-10),"Pg: ",LRQ,!,LRM(1),?45,"ABO Group: ",LRABO
 W !,$S(LRW="T":"Transfusions",1:"")," (Units received from ",LRSTR," to ",LRLST,")",!?11,$S(LRW="T":"Treating Specialty",1:"Disposition"),?45,"Unit ID",?60,"Days in inventory",!,LR("%") Q
H1 D H W !,LRP," ",SSN Q
H2 D H W !,LRE Q
 ;
END D V^LRU Q
