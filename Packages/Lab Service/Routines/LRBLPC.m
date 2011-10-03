LRBLPC ;AVAMC/REG - TRANSFUSIONS/HEM RESULTS ;2/18/93  09:42 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !!?14,"Print transfusions & hematology data for a patient" D V^LRU
 S LRS=$O(^LAB(61,"B","BLOOD",0)) I 'LRS S LRS=$O(^LAB(61,"B","PERIPHERAL BLOOD",0)) I 'LRS W $C(7),!,"BLOOD or PERIPHERAL BLOOD must be an entry in TOPOGRAPHY file (#61)",! G END
 S X="BLOOD BANK" D ^LRUTL G:Y=-1 END K LRDPAF S A=0 F B=0:1 S A=$O(^LRO(69.2,LRAA,61,LRS,2,A)) Q:'A  S Y=^(A,0),W=$P(Y,"^",2),Y=+Y D S
 S LRT(0)=B I 'B W $C(7),!!,"Must have tests to print entered in the",!,"'Tests for inclusion in transfusion report option' in",!,"Blood bank supervisor menu",! G END
 S:'$D(^LRO(69.2,LRAA,7,0)) ^(0)="^69.28PA^^" I '$D(^(DUZ,0)) S ^(0)=DUZ,X=^LRO(69.2,LRAA,7,0),^(0)="^69.28PA^"_DUZ_"^"_($P(X,"^",4)+1)
 G:$O(^LRO(69.2,LRAA,7,DUZ,1,0)) OUT
 K ^LRO(69.2,LRAA,7,DUZ) S ^LRO(69.2,LRAA,7,DUZ,0)=DUZ_"^"_DT,^LRO(69.2,LRAA,7,DUZ,1,0)="^69.3PA^^"
 K DIC F LRA=1:1 W !,"Choice: ",LRA D ^LRDPA Q:LRDFN<1  D G S X=^LRO(69.2,LRAA,7,DUZ,1,0),^(0)="^69.3PA^"_LRDFN_"^"_($P(X,"^",4)+1),^(LRDFN,0)=LRDFN_"^"_Y(0),^LRO(69.2,LRAA,7,DUZ,1,"C",$P(Y(0),"^"),LRDFN)=""
 G:LRA=1 END D B^LRU I Y<0 D SET^LRBLPC1 G END
 S LRLDT=9999998-LRLDT,LRSDT=9999999-LRSDT,ZTRTN="QUE^LRBLPC" D BEG^LRUTL Q:$D(ZTSK)  I POP D SET^LRBLPC1 G END
QUE U IO D L^LRU,S^LRU D:IOST?1"C".E WAIT^LRU K ^TMP($J)
 F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,LRDFN)) Q:'LRDFN  D A
 D WRT W:IOST'?1"C".E @IOF K ^LRO(69.2,LRAA,7,DUZ) D END,END^LRUTL Q
A S ^TMP($J,LRDFN)="" F A=LRLDT:0 S A=$O(^LR(LRDFN,1.6,A)) Q:'A!(A>LRSDT)  S X=^(A,0),^TMP($J,LRDFN,A,0)=+X,^(.1)=$P(X,"^",2,99)
 F A=LRLDT:0 S A=$O(^LR(LRDFN,"CH",A)) Q:'A!(A>LRSDT)  S X=^(A,0) F B=0:0 S B=$O(LRT(B)) Q:B=""  S Z=$S($D(^LR(LRDFN,"CH",A,LRV(B))):$P(^(LRV(B)),"^"),1:"") I Z]"",$P(X,"^",5)=LRS(B) S ^TMP($J,LRDFN,A,0)=+X,^(B)=Z
 Q
WRT S N=0 F A=0:0 S N=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",N)) Q:N=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",N,LRDFN)) Q:'LRDFN!(LR("Q"))  S W=^LRO(69.2,LRAA,7,DUZ,1,LRDFN,0) D W
 Q
W S W(2)=$P(W,"^",2),W(5)=$P(W,"^",5),DFN=$P(W,"^",6),W(10)=$P(W,"^",10),Y=$P(W,"^",4) D D^LRU S W(4)=Y D H Q:LR("Q")  S LR("F")=1
 F A=0:0 S A=$O(^TMP($J,LRDFN,A)) Q:'A!(LR("Q"))  S T=+^(A,0) D T,P
 D:DFN ^LRBLPC1 Q
P D:$Y>(IOSL-6) H Q:LR("Q")
 W !,T S Q=$S($D(^TMP($J,LRDFN,A,.1)):^(.1),1:"") W:Q ?15,$E($P(^LAB(66,+Q,0),"^"),1,25),$S($P(Q,"^",6):"("_$P(Q,"^",6)_")",1:"")
 Q:'$O(^TMP($J,LRDFN,A,.1))
 S X(1)=0 F B=0:0 S B=$O(LRT(B)) Q:B=""  S X(1)=X(1)+1 S:$X>(IOM-9) X(1)=1 W:$X>(IOM-9) !?32 W ?32+(8*X(1)) I $D(^TMP($J,LRDFN,A,B)) W $J(^(B),5)
 Q
S S X=^LAB(60,Y,0),X(1)=$S($D(^(.1)):$P(^(.1),"^"),1:"??"),Z=$S($D(^(1,W,0)):$P(^(0),"^",7),1:"")
 S LRT(A)=$P($P(X,"^",5),";",2,3)_"^"_W_"^"_$P(X,"^")_"^"_Z_"^"_$P(^LAB(61,W,0),"^")_"^"_Y_"^"_X(1),LRV(A)=+LRT(A),LRS(A)=W Q
T S T=T_"000",T=$E(T,4,5)_"/"_$E(T,6,7)_"/"_$E(T,2,3)_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"") Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"TRANSFUSION/HEMATOLOGY RESULTS",!,W(2),?31,W(10),?45,"DOB: ",W(4),!,"Location:",?12,W(5),!,"Mo/Da/Yr TIME",?15,"Blood component"
 S X(1)=0 F X=0:0 S X=$O(LRT(X)) Q:X=""  S X(1)=X(1)+1 S:$X>(IOM-8) X(1)=1 W:$X>(IOM-8) !?32 W ?32+(8*X(1)),$P(LRT(X),"^",7)
 W !,LR("%") Q
G S:$D(DPF) LRDPF=DPF S LRPF="^"_$P(LRDPF,"^",2)
 S Y=@(LRPF_DFN_",0)"),Y(0)=$P(Y,"^")_U_$P(Y,"^",2)_U_$P(Y,"^",3)_U_$S($D(^(.1)):^(.1),1:"")_"^"_$S(LRPF="^DPT(":DFN,1:"")_"^^^^"_$P(Y,"^",9) Q
 ;
END D V^LRU Q
OUT W $C(7),!!?10,"Cannot use this option until your last report is completed.",!,"If the report was queued and never printed it must be removed from the"
 W !,"list of queued reports (see your LIM).  Also have your blood bank supervisor",!,"delete your patient list for transfusion & hematology data." G END
