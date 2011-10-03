LRBLDCU ;AVAMC/REG/CYM - CUMULATIVE DONATION CALCULATIONS ;6/28/96  08:47 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  S IOP="HOME" D ^%ZIS,END W @IOF,?15,"Cumulative donations and new awards"
 D S^LRU S LRC=0 D FIELD^DID(65.54,1,"","POINTER","X") S X=X("POINTER") F A=1:1 S B=$P(X,";",A),C=$P(B,":") Q:B=""  S LRB(C)=$P(B,":",2)
 S X=0 F A=0:0 S X=$O(LRB(X)) Q:X=""  D Z G:E["^"!(E="") END
 S I="" W !!,"Print all donors to receive new awards " S %=2 D YN^LRU G:%<1 END I %=1 G DEV
ASK W ! S LRG(1)=0,DIC="^LRE(",DIC(0)="AEQM" D ^DIC K DIC G:Y<1 END
 S I=+Y,N=$P(Y,U,2),K=0 D C S:$D(^LRE(I,3)) K=$P(^(3),"^") W:LRG(1)'>LRG!(LRG<1) !,N,!,$S(K:"New award; Not given",1:"No new award"),?33,"Total donations: ",$J(T,3),"  Total awards: ",LRG G ASK
DEV S ZTRTN="QUE^LRBLDCU" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU S X="T",%DT="" D ^%DT S LRF=10009999-Y
 D:IOST?1"C".E WAIT^LRU D H S LR("F")=1,N=0 F A=0:0 S N=$O(^LRE("B",N)) Q:N=""!(LR("Q"))  F I=0:0 S I=$O(^LRE("B",N,I)) Q:'I!(LR("Q"))  D E
 W:'LRC !,"No donors found to receive new awards." W:IOST'?1"C".E @IOF D END,END^LRUTL Q
E Q:$O(^LRE(I,5,0))>LRF
C S T=0,X=^LRE(I,0),LRG=$P(X,"^",8),Y=$P(X,"^",3) D DT^LRU S N(1)=Y D D
 Q
D F V=0:0 S V=$O(^LRE(I,5,V)) Q:'V!(LR("Q"))  S C=$P(^(V,0),"^",2) I C]"" S T=T+E(C)
 Q:LR("Q")  I T S LRG(1)=T\8 I LRG(1)>LRG S ^LRE(I,3)=1 D:$Y>(IOSL-6) H Q:LR("Q")  W !,N,?31,N(1),?45,$J(LRG,2),?60,$J(T,3) S LRC=LRC+1
 S $P(^LRE(I,0),"^",7)=T Q
Z W !,"Enter donation value for ",LRB(X),": " R E:60 Q:E=""!(E[U)  I E'?1N.N!(E<0)!(E>99) W !,$C(7),"Enter a whole number from 0 to 99" G Z
 S E(X)=E Q
H I $D(^LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !?20,"BLOOD DONORS TO RECEIVE NEW AWARDS"
 W !,"Donor",?33,"DOB",?41,"Total Awards",?55,"Cumulative donations",!,LR("%") Q
END D V^LRU Q
 ; Line E stops processing any donor not donating in past year
