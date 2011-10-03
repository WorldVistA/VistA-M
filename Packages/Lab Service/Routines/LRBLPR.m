LRBLPR ;AVAMC/REG - BLOOD BANK PT RECORD ;2/18/93  09:46 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?20,"PRINT CURRENT PATIENT BLOOD BANK RECORDS",!!,"The dates asked will be from the BLOOD BANK ACCESSION LIST:"
 D B^LRU G:Y<0 END
 W !!,"Print only patients with antibodies/special instructions " S %=1,LR(7)=0 D YN^LRU G:%<1 END I %=1 S LR(7)=1
ASK W !!,"Enter the maximum number of specimens to display",!,"in reverse chronological order for each patient: " R LR(8):DTIME Q:LR(8)[U
 I LR(8)'?1N.N W $C(7),!,"ENTER A WHOLE NUMBER FROM 0-99" G ASK
 I $S(+LR(8)<0:1,+LR(8)>99:1,1:0) W $C(7),!,"ENTER A WHOLE NUMBER FROM 0-99" G ASK
 S LR(8)=+LR(8),ZTRTN="QUE^LRBLPR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO W @IOF K ^TMP("LRBL",$J) D L^LRU,S^LRU S S=LRSDT-1
 F A=S:0 S A=$O(^LRO(68,LRAA,1,A)) Q:'A!(A>LRLDT)  F B=0:0 S B=$O(^LRO(68,LRAA,1,A,1,B)) Q:'B  I $D(^(B,0)) S ^TMP("LRBL",$J,+^(0))=""
 F A=0:0 S A=$O(^TMP("LRBL",$J,A)) Q:'A  D S
 D H S LR("F")=1
 F LR=0:0 S LR=$O(^TMP("LRBL",$J,"B",LR)) Q:'LR!(LR("Q"))  S LRP=0 F LR(1)=0:0 S LRP=$O(^TMP("LRBL",$J,"B",LR,LRP)) Q:LRP=""!(LR("Q"))  D B
OUT K ^TMP("LRBL",$J),^TMP($J) W:IOST'?1"C".E @IOF D END^LRUTL,END Q
S Q:'$D(^LR(A,0))  S W=^(0),Y=$P(W,"^",3),(LRDPF,P)=$P(W,"^",2),X=^DIC(P,0,"GL"),X=@(X_Y_",0)"),SSN=$P(X,"^",9) D SSN^LRU S ^TMP("LRBL",$J,"B",P,$P(X,"^"),A)=$P(X,"^",3)_"^"_SSN_"^"_$P(W,"^",5)_"^"_$P(W,"^",6) Q
 ;
B F LRDFN=0:0 S LRDFN=$O(^TMP("LRBL",$J,"B",LR,LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S LR(4)=^(LRDFN) D W
 Q
W I LR(7),'$O(^LR(LRDFN,1.7,0)),'$O(^LR(LRDFN,3,0)) Q
 D:$Y>(IOSL-6) H Q:LR("Q")  S Y=+LR(4) D DT^LRU W !,LRP,?31,$P(LR(4),"^",2),?46,Y,?56,$J($P(LR(4),"^",3),2),?59,$P(LR(4),"^",4) D ^LRBLPR1 Q
 ;
H ;from LRBLPR1, LRBLPRA
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK PATIENTS" I $D(LRSTR),$D(LRLST) W " from ",LRSTR," to ",LRLST
 W !?10,"Patient",?34,"SSN",?49,"DOB",?55,"ABO",?59,"Rh",!,LR("%") Q
 ;
END D V^LRU Q
