PRCUA ;WISC/PLT-One time use utility ; 01/03/94  8:37 AM
V ;;5.0;IFCAP;;4/21/95
 QUIT  ;invalid entry
EN1 ;Set 'p.o. date' in file 442 equal to 1358 request 'date obligated' in file 410
 N PRC410,PRC442,PRCA,PRCB,ZTSTOP,X,Y
Q1 W !! D YN^PRC0A(.X,.Y,$P($T(EN1),";",2,999),"","YES") G EXIT:Y'=1
Q2 W ! D YN^PRC0A(.X,.Y,"Queue This Task","","") G Q1:Y?1"^".E
 W ! I Y=1 D  G EXIT
 . S ZTSAVE("PRC*")="",ZTDESC=$P($T(EN1),";",2,999),ZTIO=""
 . S ZTRTN="ETM^PRCUA" D ^%ZTLOAD
 . W !,"TASK NUMBER ",$S($D(ZTSK):ZTSK_" assigned",1:"not assigned and try again")
 . QUIT
ETM S PRCA="",ZTSTOP=""
 F  S PRCA=$O(^PRCS(410,"D",PRCA)) QUIT:PRCA=""  D  Q:ZTSTOP
 . S PRC410=0 F  S PRC410=$O(^PRCS(410,"D",PRCA,PRC410)) QUIT:PRC410'?1.N  D  Q:ZTSTOP=1
 .. W:'$D(ZTQUEUED)&(PRC410#200=0) "."
 .. I $D(ZTQUEUED),PRC410#30=0 S ZTSTOP=$$S^%ZTLOAD Q:ZTSTOP=1
 .. S PRCB=$G(^PRCS(410,PRC410,0)) Q:$P(PRCB,"^",4)'=1
 .. S PRCB=$G(^PRCS(410,PRC410,10)),PRC442=$P(PRCB,"^",3) Q:PRC442=""
 .. S PRCB=$G(^PRCS(410,PRC410,4)) Q:$P(PRCB,"^",5)=""!($P(PRCB,"^",4)="")
 .. Q:$P($G(^PRC(442,PRC442,1)),"^",15)'=""
 .. S DA=PRC442,DIE="^PRC(442,",DR=".1////"_$P(PRCB,"^",4) D ^DIE
 .. QUIT
 . QUIT
 W:'$D(ZTQUEUED) !!,"Set p.o. date in file 442 is done.",!!
 K:ZTSTOP'=1 ZTSTOP
EXIT QUIT
 ;
