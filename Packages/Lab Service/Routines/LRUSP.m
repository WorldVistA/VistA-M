LRUSP ;AVAMC/REG - ADD/DELETE SPECIAL STAIN ; 10/9/87  16:26 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!?20,"Add or Delete " W LRAA(1)," SPECIAL STAIN"
 W !!,"For ",LRH(0)," OK " S %=1 D YN^LRU Q:%<1  I %=2 S %DT="AEX" D ^%DT Q:Y<1  S LRAD=Y D D^LRU S LRH(0)=Y
ASK R !,"Select Accession Number: ",LRAN:DTIME Q:LRAN=""!(LRAN[U)  I LRAN'?1N.N W $C(7),!!,"Enter whole numbers only",!! G ASK
 W "  for ",LRH(0),!
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in file",!! G ASK
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRI=$P(^(3),U,5) G:'$D(^LR(LRDFN,0)) BAD S Y=^(0),X=$P(Y,U,2),X=^DIC(X,0,"GL"),Y=$P(Y,U,3)
 S LRP=@(X_Y_",0)") W !,$P(LRP,U,1)," ID: ",$P(LRP,U,9) S Y=$P(LRP,U,3) D D^LRU W:Y'[1700 "  DOB: ",Y S:'$D(^LRO(68,LRAA,1,LRAD,LRAN,5,0)) ^(0)="^68.05PA^^"
 W !!,"ACC # ",LRAN S Y=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,3)):+^(3),1:"") D:Y D^LRU W "  DATE RECEIVED: ",Y," OK " S %=1 D YN^LRU G:%'=1 ASK
T W ! S DIC="^LRO(68,LRAA,1,LRAD,1,LRAN,5,",DIC(0)="AELMOQ",DLAYGO=68 D ^DIC K DIC,DLAYGO Q:X=""!(X[U)
 S DIE="^LRO(68,LRAA,1,LRAD,1,LRAN,5,",DA=+Y,DR=".01;2:99" D ^DIE K DIE G T
BAD W $C(7),!!,"Entry not in file",!! G ASK
