LRULB ;AVAMC/REG - LAB LOG-BOOK ;2/18/93  12:48 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!?20,LRAA(1)," Log-Book" S Y=DT D LRAD
 W !!,"Accession list date:  ",LRH(0),"  OK " S %=1 D YN^LRU G:%<1 END
ASK I %'=1 W ! S %DT("A")="Select DATE: ",%DT="AQE" D ^%DT K %DT G:Y<1 END D LRAD
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"No accession numbers for ",LRH(0) S %=2 G ASK
N I LRAD'["00" R !,"Start with Acc #: FIRST // ",N(1):DTIME G:'$T!(N(1)["^") END S:N(1)="" N(1)=1 I N(1)'?1N.N W $C(7),!!,"Enter NUMBERS only" G N
 I LRAD["00" R !,"Start with Acc #: ",N(1):DTIME G:N(1)=""!(N(1)["^") END I N(1)'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N
M R !,"Go    to   Acc #: LAST // ",N(2):DTIME G:N(2)='$T!(N(2)["^") END S:N(2)="" N(2)=999999 I N(2)'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G M
 I N(2)<N(1) S X=N(1),N(1)=N(2),N(2)=X
 S ZTRTN="QUE^LRULB" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU G ^LRULB1
 ;
LRAD S X=$P(^LRO(68,LRAA,0),"^",3),(Y,LRAD)=$S(X="Y":$E(Y,1,3)_"0000","M"[X:$E(Y,1,5)_"00","Q"[X:$E(Y,1,3)_"0000"+(($E(Y,4,5)-1)\3*300+100),1:Y) D D^LRU S LRH(0)=Y Q
 ;
END D V^LRU Q
