LRBLQPR ;AVAMC/REG - PRINT UNITS/COMPONENTS ;2/18/93  09:48 ;
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
P W ! K DIC D ^LRDPA K DIC,DIE,DR W ! G:LRDFN=-1 END
 W !,"Is this the patient " S %=1 D YN^LRU G:%'=1 P
 S ZTRTN="QUE^LRBLQPR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D S^LRU I $A(IOST)=80 S A(1)=0 D L^LRU,H
 I $A(IOST)'=80 W @IOF,LRP," ",SSN(1),?37,$J(LRPABO,2),?40,LRPRH
 D S S A(1)=(IOSL-3) F B=1:1 S A=$O(^LRD(65,"AP",LRDFN,A)) Q:'A  D N
 I B=1 W !,"No UNITS assigned/xmatched",!
 G:A(2)?1P END W ! D S F B=0:1 S A=$O(^LR(LRDFN,1.8,A)) Q:'A  S X=^(A,0) W:'B !,"Component Requests",?27,"Units",?33,"Request date",?47,"Date wanted",?59,"Requestor",?77,"By" D L
 I 'B W "No component requests",!
 D END^LRUTL,END Q
 ;
N W:B=1 !?6,"Unit assigned/xmatched:",?50,"Exp date",?69,"Loc"
 I '$D(^LRD(65,A,0)) K ^LRD(65,"AP",LRDFN,A) Q
 D:$Y>A(1) R Q:A(2)?1P  S X=^LRD(65,A,0),L=$O(^(3,0)) S:'L L="Blood Bank" I L S L=$P(^(L,0),"^",4)
 S M=^LAB(66,$P(X,"^",4),0) W !,$J(B,2),")",?6,$P(X,"^"),?21,$E($P(M,"^"),1,19),?42,$P(X,"^",7)_" "_$P(X,"^",8),?49 S Y=$P(X,"^",6) D D^LRU S:L<0 L="Blood bank" W Y,?69,$E(L,1,11)
 S C=$O(^LRD(65,A,2,LRDFN,1,0)) I C F E=0:0 S E=$O(^LRD(65,A,2,LRDFN,1,C,3,E)) Q:'E  D:$Y>A(1) R Q:A(2)?1P  W !?2,^(E,0)
 Q
 ;
L D:$Y>A(1) R Q:A(2)?1P
 W !,$E($P(^LAB(66,+X,0),"^"),1,27),?27,$J($P(X,"^",4),3),?33 S Y=$P(X,"^",3) D M W Y,?47 S Y=$P(X,"^",5) D M W Y,?59,$P(X,"^",9),?77,$S($P(X,"^",8)="":"",$D(^VA(200,$P(X,"^",8),0)):$P(^(0),"^",2),1:$P(X,"^",8)) Q
M S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_$S(Y'[".":"",1:" "_$E(Y,9,12)) Q
 D END^LRUTL,END Q
 ;
R G:$A(IOST)=80 H S A(1)=A(1)+21 R !,"^ TO STOP: ",A(2):DTIME I A(2)?1P S A=0 Q
 S A(1)=A(1)+21 W $C(13),$J("",15),$C(13) Q
S S (A,A(2))=0 Q
 ;
H D F^LRU W !,"LABORATORY SERVICE",!,LR("%")
 W !,LRP," ",SSN(1),?37,$J(LRPABO,2),?40,LRPRH S A(1)=A(1)+(IOSL-4) Q
 ;
END D V^LRU Q
