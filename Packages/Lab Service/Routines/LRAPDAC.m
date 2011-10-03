LRAPDAC ;AVAMC/REG - DELETE AP YEARLY ACCESSIONS  ;5/9/91  18:12 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!,?20,"Delete anatomic pathology accession lists"
 S %DT="",X="T" D ^%DT S LRA=$E(Y,1,3)-1_"0000"
AREA W ! S DIC=68,DIC(0)="AEQMZ",DIC("A")="Select ANATOMIC PATHOLOGY SECTION: ",DIC("S")="I ""AUCYEMSP""[$P(^(0),U,2)&($P(^(0),U,2)]"""")" D ^DIC K DIC G:Y<1 END S LRAA=+Y D ASK G AREA
 ;
ASK W ! S %DT="AEQ",%DT("A")="Enter year to delete: " D ^%DT Q:Y<1  S LR=$E(Y,1,3)_"0000" I LR'<LRA W $C(7),"  Cannot be current or last year." G ASK
 W !!,"Ok to delete " S %=2 D YN^LRU G:%'=1 ASK
 L +^LRO(68,LRAA,1) K ^LRO(68,LRAA,1,LR),^LRO(68,LRAA,1,"B",LR,LR) S X=^LRO(68,LRAA,1,0),X(1)=$O(^LRO(68,LRAA,1,0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:($P(X,"^",4)-1)) L -^LRO(68,LRAA,1)
 W !,"Done." G ASK
 ;
END D V^LRU Q
