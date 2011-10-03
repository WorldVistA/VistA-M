LRBLDPL ;AVAMC/REG - BLOOD DONOR LIST BY DATE ;2/18/93  09:00 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S IOP="HOME" D ^%ZIS
 W @IOF,?20,"BLOOD DONOR LIST BY LAST ATTEMPT DATE",!!
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S ZTRTN="QUE^LRBLDPL" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU,S,W
 W ! W:IOST'?1"C".E @IOF D END,END^LRUTL Q
S F A=LRSDT:0 S A=$O(^LRE("AD",A)) Q:'A!(A>LRLDT)  F I=0:0 S I=$O(^LRE("AD",A,I)) Q:'I  D O
 Q
O Q:'$D(^LRE(I,0))  S V=$S($D(^(1)):^(1),1:""),W=^(0),W(1)=$P(W,"^"),V(8)=$S($L($P(V,"^",8)):$P(V,"^",8),1:"UNKNOWN"),Q=$O(^(5,0)) Q:'Q  S Q=^(Q,0) Q:Q>LRLDT
 S W(7)=$P(W,"^",7)
 I Q="" S (Q,Q(2))="NONE" Q
 S Y=+Q\1 D D^LRU S Y(1)=Y,Q(2)=$P(Q,"^",2),Q(6)=$P(Q,"^",6),Q(7)=$P(Q,"^",7) S:'Q(6) Q(6)="?" S:'Q(7) Q(7)="?"
 S ^TMP($J,Q(7),W(1))=V(8)_"^"_Y(1)_"^"_Q(2)_"^"_W(7)_"^"_Q(6) Q
W D H S LR("F")=1,G=0
 F A=1:1 S G=$O(^TMP($J,G)) Q:G=""!(LR("Q"))  S Q(7)=$S(G&($D(^LAB(65.4,G,0))):$P(^(0),"^"),1:G),W(1)=0 D:$Y>(IOSL-6) H Q:LR("Q")  D HL F B=1:1 S W(1)=$O(^TMP($J,G,W(1))) Q:W(1)=""!(LR("Q"))  S W=^(W(1)) D D
 Q
D D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,W(1),?31,$P(W,"^"),?46,$P(W,"^",2),?61,$P(W,"^",3),?64,$J($P(W,"^",4),7) Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD DONORS (from: ",LRSTR," to ",LRLST,")"
 W !,"DONOR NAME",?31,"WORK PHONE",?46,"LAST ATTEMPT",?59,"CODE",?64,"CUM DONATIONS"
 W !,LR("%") Q
H1 D H,HL Q
HL Q:LR("Q")  W !!,"Donation Group: ",Q(7),!,"------------------" Q
 ;
END D V^LRU Q
