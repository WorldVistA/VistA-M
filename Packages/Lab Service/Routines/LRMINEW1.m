LRMINEW1 ;SLC/CJS/BA - NEW DATA TO BE REVIEWED/VERIFIED ;5/6/04  12:04
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
VER W !!,"Indicate those you wish to exclude from verification."
 D CHECK
 I $O(LRAN(0))>0 W !,"Verifying all but the following:" F LRAN=0:0 S LRAN=$O(LRAN(LRAN)) Q:LRAN=""  W !,LRAN
 F I=0:0 W !,"Want the approved reports to be printed at the requesting locations" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 Q:%=-1  S LRMIQUE=$S(%=1:1,1:0)
 F I=0:0 W !!,"Are you ready to verify" S %=2 D YN^DICN Q:%  W !,"If you're not sure, it's not too late to quit."
 Q:%'=1
 S LRAN=0 F I=0:0 S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  K ^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)
 S LRAN=0 F I=0:0 S LRAN=+$O(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) Q:LRAN<1  I +^(LRAN)=LRDXZ!(LRDXZ=0) D STUFF
 W !,"ALL DONE"
 Q
STUFF Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  Q:'$D(^(3))  S Y=^(0),LRDFN=+Y,LRLLOC=$P(Y,U,7),LRODT=$S($P(Y,U,4):$P(Y,U,4),1:$P(Y,U,3)),LRSN=$P(Y,U,5),LRIDT=9999999-^(3),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX
 S $P(^LR(LRDFN,"MI",LRIDT,LRSB),U)=DT,$P(^(LRSB),U,$S(LRSB=11:5,1:3))=DUZ
 D UPDATE^LRPXRM(LRDFN,"MI",LRIDT)
 S LRCDT=9999999-LRIDT,Y=DT D VT^LRMIUT1
 K ^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)
 D:LRMIQUE TSKM^LRMIUT
 Q
CHECK ;from LRMINEW
 D LRAN^LRMIUT S LRAN=0 F I=0:0 S LRAN=+$O(LRAN(LRAN)) Q:LRAN<1  S LROK=1 D CHECK1 I 'LROK K LRAN(LRAN)
 Q
CHECK1 I '$D(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) W !,LRAN," is not defined." S LROK=0 Q
 I LRDXZ'=0,+^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)'=LRDXZ W !,LRAN," is not your accession." S LROK=0
 Q
