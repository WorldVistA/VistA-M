PRCPUMAN ;WISC/RFJ/DGL-lookup for mand source field .4 file 445 ; 7/22/99 1:49pm
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
HELP(INVPT,ITEMDA,SCREEN) ;  called from help (node 4 for dd(445.01,.4, )
 ;  to display mandatory source.
 ;  screen=1 to lookup in screen for procurement source in 445.07
 ;  optional prc("cp"),prc("site")
 I 'INVPT!('ITEMDA) Q
 N %,CP,MANSRCE,SITE,TYPE
 S MANSRCE=$$MANDSRCE^PRCPU441(ITEMDA),TYPE=$P($G(^PRCP(445,INVPT,0)),"^",3)
 S SITE=+$G(PRC("SITE")) I 'SITE S SITE=+$G(^PRCP(445,INVPT,0))
 S CP=$G(PRC("CP")) I CP="" S CP=+$O(^PRC(420,"AE",SITE,INVPT,0)),CP=$P($G(^PRC(420,SITE,1,CP,0))," ") ; Multiple FCP not supported
 W ! I TYPE="W" D  W !! Q
 .   I MANSRCE'=$O(^PRC(440,"AC","S",0)) W !,"ITEM IS NOT SET UP AS POSTED STOCK.  THE MANDATORY SOURCE IN THE ITEM MASTER",!,"FILE DOES NOT EQUAL THE WAREHOUSE VENDOR." Q
 .   S %=$P($G(^PRC(440,+$P($G(^PRC(441,ITEMDA,0)),"^",4),0)),"^") I %'="" W !,"LAST VENDOR ORDERED: ",%
 .   S %=$P($G(^PRC(440,+$P($G(^PRC(441,ITEMDA,4,SITE_CP,0)),"^",3),0)),"^") I %'="" W !,"PREFERRED VENDOR (FOR CP: ",CP,"): ",%
 .   W !,"YOU MAY SELECT ANY VENDOR WHICH IS SET UP AS A VENDOR FOR THIS ITEM IN THE ITEM",!,"MASTER FILE"
 .   W $S(SCREEN:", AND IS A PROCUREMENT SOURCE FOR THIS ITEM IN THE INVENTORY POINT.",1:".  ") W:SCREEN ! W "THE VENDOR ALSO MUST NOT BE INACTIVATED."
 I TYPE="P" D  W !! Q
 .   I MANSRCE W !,"ITEM HAS A MANDATORY SOURCE: ",$P($G(^PRC(440,+MANSRCE,0)),"^"),".",!,"YOU CAN ONLY SELECT THIS VENDOR." Q
 .   S %=$P($G(^PRC(440,+$P($G(^PRC(441,ITEMDA,0)),"^",4),0)),"^") I %'="" W !,"LAST VENDOR ORDERED: ",%
 .   S %=$P($G(^PRC(440,+$P($G(^PRC(441,ITEMDA,4,SITE_CP,0)),"^",3),0)),"^") I %'="" W !,"PREFERRED VENDOR (FOR CP: ",CP,"): ",%
 .   W !,"YOU MAY SELECT ANY VENDOR WHICH IS SET UP AS A VENDOR FOR THIS ITEM IN THE ITEM",!,"MASTER FILE, AND IS A PROCUREMENT SOURCE FOR THIS ITEM IN THE INVENTORY POINT.",!,"THE VENDOR ALSO MUST NOT BE INACTIVATED."
 I TYPE="S" D  W !! Q
 .   W !,"YOU CAN ONLY SELECT A PRIMARY DISTRIBUTION POINT WHICH DISTRIBUTES THIS ITEM."
 Q
 ;
 ;
SCREEN(INVPT,ITEMDA,SCREEN1) ;  called from input transform for dd(445.01,.4,
 ;  x=vendor name, y=vendor number,
 ;  dic=file 440 or 445 it should lookup on
 ;  screen1=1 to lookup in screen for procurement source in 445.07
 ;  if vendor y fails -->> flag=0 and $t=0
 N %,FLAG,LOOKUP,MANSRCE,SCREEN,TYPE
 S FLAG=1
 I 'INVPT!('ITEMDA) S FLAG=0 G END
 S MANSRCE=$$MANDSRCE^PRCPU441(ITEMDA),TYPE=$P($G(^PRCP(445,INVPT,0)),"^",3),LOOKUP=$S($G(DIC)["^PRCP(445":";PRCP(445,",1:";PRC(440,")
 S SCREEN="I LOOKUP[440,$D(^PRC(441,ITEMDA,2,+Y)),'$P($G(^PRC(440,+Y,10)),""^"",5)"_$S(SCREEN1:",$O(^PRCP(445,INVPT,1,ITEMDA,5,""B"",(+Y)_"";PRC(440,"",0))",1:"")
 I TYPE="W" D  G END
 .   I MANSRCE'=$O(^PRC(440,"AC","S",0)) S FLAG=0 Q
 .   I MANSRCE=Y S FLAG=0 Q
 .   X SCREEN I '$T S FLAG=0
 I TYPE="P" D  G END
 .   I MANSRCE,Y=MANSRCE Q
 .   I MANSRCE S FLAG=0 Q
 .   X SCREEN I '$T S FLAG=0
 I TYPE="S" D
 .   I LOOKUP[445,$D(^PRCP(445,Y,1,ITEMDA,0)),$D(^PRCP(445,Y,2,INVPT,0)) Q
 .   S FLAG=0
END I FLAG Q
 I 0
 Q
