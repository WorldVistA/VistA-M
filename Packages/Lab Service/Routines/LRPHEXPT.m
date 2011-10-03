LRPHEXPT ;SLC/CJS/RWF-EXCEPTION LOGIN OF ACCESSIONS ;8/11/97
 ;;5.2;LAB SERVICE;**43,121,221**;Sep 27, 1994
 S X="N",%DT="T" D ^%DT S LRODT=DT,LRNT=Y
LR1 ;
 D ^LRPARAM QUIT:$G(LREND)  ;-> 4/25/95 LJA
 ;
 D FNDLOC^LRDRAW G END:LRLLOC["^" I LRLLOC=""&'$D(^XUSEC("LRPHSUPER",DUZ)) W !,"You don't have the LRPHSUPER key to enter 'ALL'." G LRPHEXPT
 I LRLLOC="" W !,"You're doing the entire collection" S %=2 D YN^DICN W:%=0 !,"Maybe you'd better think about it some more." G END:%'=1
 K LRSN,LROR,LRCOM,LRTCOM,LRNOCOM W !,"Enter Order Numbers not collected: "
LOOP S LRFIRST=1,LROR=0 D
 . D LP1^LRPHITEM
 I $O(LROR(0))>0 W !,"Let's handle the exceptions first.",! D
 . N LRLLOC,LRODT
 . S LROR=0 F  S LROR=$O(LROR(LROR)) Q:LROR<1  D EXCEPT^LRPHITE3 W ! D EQUALS^LRX W !
 W !!,"Now enter any orders that are not canceled but you don't want ""collected"", yet.",!,"If all remaining orders are collected, skip this entry."
 W !,"Any order #'s entered here will remain on collection list until 12 midnight.",!,"The orders will not 'rollover' to the next days collection list."
 K LROR S LROR=0,LRNOCOM=1 D
 . D LP1^LRPHITEM
 S %=2 W !!,"Ready to accept the rest of the orders" D YN^DICN G END:%'=1
 D INV G:LRLLOC'="" E1 S LRLLOC="" F  S LRLLOC=$O(^LRO(69,LRODT,1,"AC",LRLLOC)) Q:LRLLOC=""  D E2
 G LR1
 Q
E1 D E2 G LR1
E2 S LRSN=0 F  S LRSN=$O(^LRO(69,LRODT,1,"AC",LRLLOC,LRSN)) Q:LRSN=""  D
 . I ^LRO(69,LRODT,1,"AC",LRLLOC,LRSN)=1 I $S($D(^LRO(69,LRODT,1,LRSN,.1)):'$D(LROR(^(.1))),1:1) D P15^LRPHITEM W:$P(^LRO(69,LRODT,1,LRSN,1),U,4)="C" !,LRLLOC,"  ",$S($D(^(.1)):^(.1),1:".")
 Q
INV K ^TMP($J) S %X="LROR(",%Y="^TMP($J," D %XY^%RCR K LROR F I=1:1 Q:'$D(^TMP($J,I))  S LROR(^(I))=""
 Q
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
END K %,A,J1,K,LRFIRST,LRFORD,LRLLOC,LRNOCOM,LRNT,LRODT,LROR,LRSN,X,Y,Z,DIC,LRLLOC,LRAA,LRAD,LRAN,LRDFN,LRSS,LRIDT,LROID,T,LRSN,I,%H,%X,%Y,DIWL,DIWR,DO,DPF,LRBED,LRCS,LRCSN,LRCSS,LRDC,LRDTO,LRFLOG,LRIOZERO,LRIX,LRLWC,LRM,LRORDR,LRORDTIM
 K LRGCOM,LROUTINE,LRPR,LRRND,LRSSX,LRSTIK,LRTSN,LRUNQ,LRUR,LRWD,LRWPC,POP Q
