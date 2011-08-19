LRUTELL ;AVAMC/REG - FIND EXISTING ACCESSION NUMBER ; 6/2/86  9:13 AM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S Y=+^LRO(68,LRAA,1,LRAD,1,X,0),LRSPEC=$S($D(^(5,1,0)):+^(0),1:LRU) I 'Y K ^LRO(68,LRAA,LRAD,1,X),Y Q
 S Y(1)=^DIC($P(^LR(Y,0),"^",2),0,"GL"),Y=$P(^LR(Y,0),"^",3)
 W $C(7),!!,"Sorry, Accession # ",X," assigned to ",$P(@(Y(1)_Y_",0)"),"^") I "CYEMSPAU"'[LRSS W " Specimen type: ",$S(LRSPEC'=0:$P(^LAB(61,LRSPEC,0),"^"),1:"NOT ENTERED")
 W !,"Specimen(s) Taken " S Y=$P(^LRO(68,LRAA,1,LRAD,1,X,0),U,3) D D^LRU W:Y'[1700 Y,!! Q
