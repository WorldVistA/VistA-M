LRBLPA ;AVAMC/REG/CYM - GET PATIENT INSTR./TESTS ; 7/22/97  19:58 ;
 ;;5.2;LAB SERVICE;**90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S:'$D(LRLLOC) LRLLOC="?" Q:LRLLOC["DIED"  S:'$D(LRAA)#2 LRAA=$O(^LRO(68,"B","BLOOD BANK",0))
 S (S,E,LRBBSPEC)=$O(^LAB(61,"B","BLOOD",0))
 I 'E S (S,E,LRBBSPEC)=$O(^LAB(61,"B","PERIPHERAL BLOOD",0)) I 'E W $C(7),!,"BLOOD or PERIPHERAL BLOOD must be an entry in TOPOGRAPHY file (#61)",! Q
 D:'$D(LRBLT) T
 S X=$S('$D(LRPABO):1,LRPABO="":0,1:1)
 S:X X=$S('$D(LRPRH):1,LRPRH="":0,1:1)
 I 'X W $C(7),!!,"No Patient ABO &/or Rh !",! I $D(LRU(2)) S LRDFN=-1 Q
 K V F A=0:0 S A=$O(LRBLT(A)) Q:'A  S V(A)=LRBLT(A)
 K Q W ! D D I '$D(LRQ) W !!,"OK TO CONTINUE " S %=1 D YN^LRU G:%'=1 END
 W !! Q
T S:LRAA="" LRAA=$O(^LRO(68,"B","BLOOD BANK",0))
 F A=0:0 S A=$O(^LRO(69.2,LRAA,61,S,1,A)) Q:'A  S Y=^(A,0),W=$P(Y,"^",2),Y=+Y D S
 Q
 ;
X S W=$$FMTE^XLFDT(+W,"5F"),W=$TR(W," ","0")
 S W=$TR(W,"@"," ")
 Q
 ;
S S X=^LAB(60,Y,0),Z=$S($D(^(1,W,0)):$P(^(0),"^",7),1:""),LRBLT(A)=W_"^"_$P($P(X,"^",5),";",2,3)_"^"_$P(X,"^")_"^"_Z_"^"_$P(^LAB(61,W,0),"^")_"^"_Y
 Q
D F A=0:0 S A=$O(^LR(LRDFN,"CH",A)) Q:'A!('$D(V))  D
 . S W=^LR(LRDFN,"CH",A,0),S=$P(W,"^",5)
 . D X
 . F B=0:0 S B=$O(V(B)) Q:'B  D
 .. I +V(B)=S,$D(^(+$P(V(B),"^",2))) S X=^(+$P(V(B),"^",2)) D W
 Q
W S Y=$P($P(V(B),"^",2),";",2),X=$P(X,"^",Y)
 S S($P(V(B),"^",6),S)=X_"^"_$P(V(B),"^",3)_"^"_W_"^"_$P(V(B),"^",4)_"^"_$P(V(B),"^",5) W !,W,?18,"Last ",$P(V(B),"^",3),": ",X," ",$P(V(B),"^",4)," ",$P(V(B),"^",5) K V(B)
 Q
 ;
END S Q("Q")=1 Q
