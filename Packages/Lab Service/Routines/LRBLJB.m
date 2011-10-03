LRBLJB ;AVAMC/REG - AUTOLOGOUS UNIT DISPOSITION LIST ;2/18/93  09:08
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?10,"LIST OF AUTOLOGOUS UNIT DISPOSITIONS BY DATE UNIT RECEIVED"
ASK W !!,"Select (T)ransfusions or (A)ll other dispositions: " R X:DTIME G:X=""!(X[U) END S X=$A(X) S:X>97 X=X-32 I X'=65,X'=84 D HLP G ASK
 S LRW=$C(X) D B^LRU G:Y<0 END S ZTRTN="QUE^LRBLJB" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S:LRW="A" LRS=$P(^DD(65,4.1,0),U,3) S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99 D L^LRU,S^LRU,H
 F LRA=LRSDT:0 S LRA=$O(^LRD(65,"A",LRA)) Q:'LRA!(LRA>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"A",LRA,LRI)) Q:'LRI  I $D(^LRD(65,LRI,8)),$P(^(8),"^",3)="A" D @(LRW)
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=^LR(A,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)") S ^TMP($J,"B",$P(X,"^"),A)=$P(X,"^",9)
 S LRP=0 F LRA=0:0 S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""  F LRDFN=0:0 S LRDFN=$O(^TMP($J,"B",LRP,LRDFN)) Q:'LRDFN  S SSN=^(LRDFN),LRDPF=$P(^LR(LRDFN,0),U,2) D SSN^LRU,W
 W !! S LRA=0 F LRB=0:0 S LRA=$O(LRD(LRA)) Q:LRA=""  D:$Y>(IOSL-6) H W !?3,LRA,?7," = ",LRD(LRA),?50,"(",$J(LRD(LRA,1),3)," units)"
 D END^LRUTL,END Q
W D:$Y>(IOSL-6) H W !!,LRP," ",SSN
 F LRC=0:0 S LRC=$O(^TMP($J,LRDFN,LRC)) Q:LRC=""  S LRD=LRC D X
 Q
X I LRC,$D(^LAB(66,LRC,0)) S X=^(0),LRD=$P(X,"^",2) S:LRD="" LRD="?" S LRD(LRD)=$P(X,"^") S:'$D(LRD(LRD,1)) LRD(LRD,1)=0
 S LRE=0 F LRF=0:0 S LRE=$O(^TMP($J,LRDFN,LRC,LRE)) Q:LRE=""  S LRI=$O(^TMP($J,LRDFN,LRC,LRE,0)) D Y
 Q
Y D:$Y>(IOSL-6) H1 S LRD(LRD,1)=LRD(LRD,1)+1,X1=$P(^LRD(65,LRI,4),"^",2),X2=$P(^(0),"^",5) D ^%DTC S:X=0 X="<1" I LRW="A" S LRX=$P(^LRD(65,LRI,4),"^")_":",LRX=$P($P(LRS,LRX,2),";")
 W !?3,LRD,?11,$S(LRW="T":$P(^LRD(65,LRI,6),"^",3),1:LRX),?45,LRE,?65,$J(X,5) Q
 ;
T Q:'$D(^LRD(65,LRI,6))  S X=^(6) Q:'+X
S S Z=^LRD(65,LRI,0),Y=$P(Z,"^",4) S:Y="" Y="?" S ^TMP($J,+X,Y,$P(Z,"^"),LRI)="" Q
A Q:'$D(^LRD(65,LRI,4))  S X=$P(^(4),"^") Q:X=""!(X="T")  S X=+$P(^(8),"^") Q:'+X  G S
 Q
 ;
H S LRQ=LRQ+1,X="N",%DT="T" D ^%DT,D^LRU W @IOF,Y," ",LRQ(1),?(IOM-10),"Pg: ",LRQ
 W !,"Autologous ",$S(LRW="T":"Transfusions",1:"")," (Units received from ",LRSTR," to ",LRLST,")",!,"Component",?11,$S(LRW="T":"Treating Specialty",1:"Disposition"),?45,"Unit ID",?60,"Days in inventory",!,LR("%") Q
H1 D H W !,LRP," ",SSN Q
 ;
HLP W !!,"Enter 'T' for a list of autologous transfusions or",!,"enter 'A' for a list of all dispositions except transfusions",!,"for autologous units." Q
 ;
END D V^LRU Q
