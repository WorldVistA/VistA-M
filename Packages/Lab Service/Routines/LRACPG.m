LRACPG ;SLC/RWF - REMOVE LR(LRDFN,"PG") TO INITIALIZE PAT CUM ;19 JUN 84 12:38PM ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
ANS ;
 W !,"Are you certain you wish to re-initial",!?10," every patient's cumulative pages  "
 S %=2 D YN^DICN G:%=1 GO
 W !!,"Process Aborted ",!!,$C(7)
 Q
GO W !?20,"This may take a while.  PG XREF INITIALIZATION",! S LRDFN=0
DFN W "." S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  I $D(^LR(LRDFN,"PG")) W LRDFN," " K ^LR(LRDFN,"PG")
 G DFN
