LRUWL ;AVAMC/REG - DISPLAY WORKLOAD FOR ACCESSION ;3/9/94  13:40
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END
A W ! S DIC="^LRO(68,",DIC(0)="AEQM" D ^DIC K DIC G:Y<1 END S LRAA=+Y,LRAA(1)=$P(Y,U,2),LRY=$S($D(^LRO(68,LRAA,1,0)):$P(^(0),U,3),1:"")
D W ! S DIC="^LRO(68,LRAA,1,",DIC("B")=LRY,DIC(0)="AEQM",DIC("A")="Select "_LRAA(1)_" Date: " D ^DIC K DIC G:Y<1 A S LRAD=+Y,Y=$P(Y,U,2) D D^LRU S LRD=Y
B S LRY="" W !!,"Select ",LRAA(1)," Accession Number for ",LRD,": " R X:DTIME G:'X D I '$D(^LRO(68,LRAA,1,LRAD,1,X,0)) W !,"Accession Number doesn't exist for date selected." G B
 W ! S DA=X,DR=4,DIC="^LRO(68,LRAA,1,LRAD,1," I '$O(^LRO(68,LRAA,1,LRAD,1,DA,4,0)) W $C(7),!,"No tests entered for this accession." G B
 D EN^DIQ G B
END D V^LRU Q
