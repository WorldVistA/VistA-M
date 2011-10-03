LRULA ;AVAMC/REG - EDIT LOCATION ;3/9/94  13:28 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
A W ! S DIC=68,DIC(0)="AEQMZ" D ^DIC K DIC G:Y=-1 END S LRAA=+Y,LRAA(1)=$P(Y,U,2),T=$P(Y(0),U,3)
D S %DT="AEQ",%DT("A")="Select Date: " D ^%DT G:Y=-1 A S LRAD=$S(T="D":Y,T="Y":$E(Y,1,3)_"0000",1:$E(Y,1,5)_"00") D D^LRU S LRD=Y I '$D(^LRO(68,LRAA,1,LRAD)) W $C(7),!,"No date for ",LRAA(1) G D
L R !!,"Select Accession Number: ",LRAN:DTIME Q:LRAN=""!(LRAN[U)  I LRAN'?1N.N W $C(7),"  Enter numbers only." G L
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!,"Accession ",LRAN," for ",LRD," doesn't exist for ",LRAA(1) G L
 S LRX=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7) W !,"LOCATION: ",LRX," // " R X:DTIME G:'X!(X[U) A
 I '$O(^SC("C",X,0)) W $C(7),!,"LOCATION ABBREVIATION DOES NOT EXIST" G L
 I X'=LRX S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7)=X
 G L
 ;
END D V^LRU Q
