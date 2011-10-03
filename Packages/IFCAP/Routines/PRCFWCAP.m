PRCFWCAP ;WISC/RFJ-enter supply fund cap into file 420 ;3/18/93  1:52 PM 
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
ENTERCAP(DATA) ;enter supply fund cap into file 420
 ;%=inventoryvalue^dueinvalue  ;if piece="" do nothing to value in piece
 ;if $d(error), unable to enter cap
 K ERROR N DIC,DIE,DR,D0,DA,OLDATA,X,Y
 I '$D(^PRC(420,+$G(PRC("SITE")),0)) S ERROR=1 Q
 S OLDATA=$P(^PRC(420,+$G(PRC("SITE")),0),"^",4,6),(DIC,DIE)="^PRC(420,",DA=PRC("SITE"),DR=$S($P(DATA,"^")'="":"5///"_$J($P(DATA,"^"),0,2)_";",1:"")_$S($P(DATA,"^",2)'="":"6///"_$J($P(DATA,"^",2),0,2)_";",1:"") D ^DIE
 I '$D(Y) S %=$G(^PRC(420,+DA,0)),%=$P(%,"^",3)-$P(%,"^",4)-$P(%,"^",5),DR="7///"_%_";" D ^DIE
 I $D(Y) S DR="5////"_$P(OLDATA,"^")_";6////"_$P(OLDATA,"^",2)_";7////"_$P(OLDATA,"^",3)_";" D ^DIE S ERROR=1
 Q
 ;
ADDCAP(DATA) ;add cap to current values
 ;%=inventoryvalue^dueinvalue  ;if piece="" do nothing to value in piece
 ;add inv value or due-in and update cap available  ;$d(error) if unable to add/enter cap
 K ERROR N %,X,Y I '$D(^PRC(420,+$G(PRC("SITE")),0)) Q
 L +^PRC(420,+$G(PRC("SITE")),0):10 I '$T S ERROR="UNABLE TO UPDATE SUPPLY FUND CAP" Q
 S %=$P(^PRC(420,+$G(PRC("SITE")),0),"^",4,5),X=$P(%,"^")+$P(DATA,"^"),Y=$P(%,"^",2)+$P(DATA,"^",2) S:X<0 X=0 S:Y<0 Y=0 D ENTERCAP(X_"^"_Y) L -^PRC(420,+$G(PRC("SITE")),0)
 Q
