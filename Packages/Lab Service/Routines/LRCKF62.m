LRCKF62 ;SLC/RWF - CHECK FILE'S ACC TEST FILE ; 2/22/87  1:46 PM ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 S ZTRTN="ENT^LRCKF62" D LOG^LRCKF Q:LREND  D ENT W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
ENT ;from LRCKF
 U IO W !,"  Checking the Accession test group file." S U="^",LRPA=0
 F LRA=0:0 S LRA=$O(^LAB(62.6,LRA)) Q:LRA'>0  S Z0=^LAB(62.6,LRA,0),LRB=0 D ATF
END K LRB,LRPA,LRPB W !! W:$E(IOST,1,2)="P-" @IOF Q
 Q
ATF S LRB=$O(^LAB(62.6,LRA,1,LRB)) Q:LRB'>0!('$D(^(+LRB,0))#2)  S Z1=^(0)
 S Z2=$S($D(^LAB(60,+Z1,0)):^(0),1:"") I Z2="" D NAME1 W !?5,"F- Pointer ",+Z1," doesn't point to a test in file 60."
 I '$P(Z2,U,9),$P(Z0,U,4) D NAME1 W !,?5,"F- Test doesn't have a LAB COLLECTION SAMPLE."
 G ATF
NAME1 I LRPA'=LRA W !!,$P(Z0,U) S LRPA=LRA,LRPB=0
 I LRPB'=LRB W !?2,$P(Z2,U) S LRPB=LRB
 Q
