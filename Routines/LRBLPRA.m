LRBLPRA ;AVAMC/REG - BB PT RECORD ;2/18/93  09:46 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 I LR(7),'$O(^LR(A,1.7,0)),'$O(^LR(A,3,0)) Q
 S W=^LR(A,0),Y=$P(W,"^",3),P=$P(W,"^",2),X=^DIC(P,0,"GL") Q:'$D(@(X_Y_",0)"))  S X=^(0),^TMP("LRBL",$J,P,$P(X,"^"),A)=$P(X,"^",3)_"^"_$P(X,"^",9)_"^"_$P(W,"^",5)_"^"_$P(W,"^",6) Q
 ;
EN D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?20,"PRINT PATIENT BLOOD BANK RECORDS",!!
 W "Print only patients with antibodies/special instructions " S %=1,LR(7)=0 D YN^LRU G:%<1 END I %=1 S LR(7)=1
ASK W !!,"Enter the maximum number of specimens to display",!,"in reverse chronological order for each patient: " R LR(8):DTIME Q:LR(8)=""!(LR(8)[U)
 I LR(8)'?1N.N!(LR(8)<0)!(LR(8)>99) W $C(7),!,"ENTER A WHOLE NUMBER FROM 0-99" G ASK
S R !!,"START WITH PATIENT NAME: FIRST// ",X:DTIME G:X[U!'$T END I X="" S P(1)=0,P(2)="z" G T
 I X["?"!(X'?1U.E)!($L(X)>30) D H^LRU G S
 S P(1)=X I $L(X)>1 S X(1)=$A(X,$L(X))-1,X(1)=$C(X(1)),P(1)=$E(X,1,$L(X)-1)_X(1)
F R !,"GO TO PATIENT NAME: LAST// ",X:DTIME G:X[U!'$T END I X="" S P(2)="z" G T
 I X["?"!(X'?1U.E)!($L(X)>30) D H1^LRU G F
 S P(2)=X
T S ZTRTN="QUE^LRBLPRA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP("LRBL",$J) D L^LRU,S^LRU
 F A=0:0 S A=$O(^LR(A)) Q:'A  I $D(^(A,1.7))!($D(^(3)))!($D(^("BB"))) D LRBLPRA
 D H^LRBLPR S LR("F")=1
 F LR=0:0 S LR=$O(^TMP("LRBL",$J,LR)) Q:'LR!(LR("Q"))  S LRP=P(1) F LR(1)=0:0 S LRP=$O(^TMP("LRBL",$J,LR,LRP)) Q:LRP=""!(LRP]P(2))!(LR("Q"))  D B
 K ^TMP("LRBL",$J),^TMP($J) D END^LRUTL,END Q
 ;
B F LRDFN=0:0 S LRDFN=$O(^TMP("LRBL",$J,LR,LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S LR(4)=^(LRDFN) D W
 Q
W D:$Y>(IOSL-6) H^LRBLPR Q:LR("Q")  S LRDPF=$P(^LR(LRDFN,0),U,2),Y=+LR(4),SSN=$P(LR(4),"^",2) D SSN^LRU,D^LRU W !,LRP,?31,SSN,?43,Y,?56,$J($P(LR(4),"^",3),2),?59,$P(LR(4),"^",4) D ^LRBLPR1 Q
 ;
END D V^LRU Q
