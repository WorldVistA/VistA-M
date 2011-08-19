LRUE ;AVAMC/REG - RESULTS FOR SELECTED LAB TESTS ;3/3/94  12:11 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!?10,"Find results for one or more tests (maximum of 13)",!?23,"from one date to another",! D END
 F A=1:1:13 S DIC=60,DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,5)[""CH""" D ^DIC K DIC Q:X=""!(X[U)  S LRC(A)=0,N(A)=$P(^LAB(60,+Y,.1),"^"),L(A)=$P($P(Y(0),U,5),";",2)
 G:A=1 END D B^LRU G:Y<0 END S LRLDT=9999998-LRLDT,LRSDT=9999999-LRSDT
 S ZTRTN="QUE^LRUE" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S LRA=0,Z(2)=$O(^LAB(61,"B","SERUM",0)),Z(3)=$O(^LAB(61,"B","BLOOD",0)),Z(5)=$O(^LAB(61,"B","PLASMA",0)) D L^LRU,S^LRU,H
 F LRDFN=0:0 S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  I $D(^LR(LRDFN,0)),$P(^(0),"^",2)'=62.3 S LRI=LRLDT,W=0 D D
 D:$Y>50 H W !!?30,"Summary Report",!,"Patient count: ",LRA
 F A=0:0 S A=$O(LRT(A)) Q:'A  W !,N(A),?8,"Repeat tests in one day:",$J(LRT(A),6) W:LRT(A) ?40,"(",$J(LRT(A)*100\LRC(A),2),"%)" W ?46,"Total tests:",$J(LRC(A),5)
 D END^LRUTL,END Q
D F A=0:0 S LRI=$O(^LR(LRDFN,"CH",LRI)) Q:'LRI!(LRI>LRSDT)  F B=0:0 S B=$O(L(B)) Q:'B  I $D(^LR(LRDFN,"CH",LRI,L(B))) D W Q
 D S Q
W S W=W+1,X=^LR(LRDFN,"CH",LRI,0),Y=+X_"000",T=$P(X,"^",5),T(1)=$E(Y,4,5)_"/"_$E(Y,6,7)_" "_$S(Y[".":$E(Y,9,10)_":"_$E(Y,11,12),1:""),LRD=$P(Y,".")
 I W=1 S LRD(1)=LRD,LRA=LRA+1,X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),LRP=$P(V,"^"),SSN=$P(V,"^",9),LRL=$S($D(@(X_Y_".1)")):^(.1),$D(^LR(LRDFN,.1)):^(.1),1:"") D SSN^LRU
 D:$Y>60 H1 W:W=1 !!,SSN,?19,$E(LRL,1,5),?44,LRP W !,T(1) W:T'=Z(2)&(T'=Z(3))&(T'=Z(5)) ?13,$E($P(^LAB(61,T,0),"^"),1,10)
 F X=0:0 S X=$O(L(X)) Q:'X  I $D(^LR(LRDFN,"CH",LRI,L(X))) S Y=$P(^(L(X)),"^") W ?(16+(X*8)),$J(Y,7) I Y'["canc" S:'$D(LRB(X)) LRB(X)=-1 S LRB(X)=LRB(X)+1,LRC(X)=LRC(X)+1
 I LRD'=LRD(1) S LRD(1)=LRD D S
 Q
S F Y=0:0 S Y=$O(LRB(Y)) Q:'Y  S:'$D(LRT(Y)) LRT(Y)=0 S LRT(Y)=LRT(Y)+LRB(Y)
 K LRB Q
H S LRQ=LRQ+1,%DT="T",X="N" D ^%DT,D^LRU W @IOF,!,Y,?23,"LABORATORY SERVICE ",LRQ(1),?IOM-10,"Pg:",LRQ,!,"From: ",LRSTR," To: ",LRLST,!?3,"SSN",?19,"Loc",?44,"Patient",!?3,"DATE" F X=0:0 S X=$O(N(X)) Q:'X  W ?(16+(X*8)),$J(N(X),7)
 W !,LR("%") Q
H1 D H I W>1 W !,SSN,?19,$E(LRL,1,5),?44,LRP
 Q
END D V^LRU Q
