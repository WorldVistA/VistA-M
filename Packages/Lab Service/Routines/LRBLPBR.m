LRBLPBR ;AVAMC/REG - BB TESTS REPORT ;3/28/94  11:59 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
GETP D:'$D(LRAA) A
 G:'$D(LRAA) END
 W ! K DIC D ^LRDPA G:LRDFN<1 END
 I '$D(^LR(LRDFN,"BB")) W $C(7),!?3,"No blood bank data for ",LRP G GETP
 I '$D(^LRO(69.2,LRAA,3,LRDFN,0)) D
 . S ^LRO(69.2,LRAA,3,LRDFN,0)=LRDFN_"^"_LRLLOC,^LRO(69.2,LRAA,3,"C",LRLLOC,LRDFN)=""
 . L +^LRO(69.2,LRAA,3):5 I '$T G GETP
 . S X=^LRO(69.2,LRAA,3,0),^(0)=$P(X,"^",1,2)_"^"_LRDFN_"^"_($P(X,"^",4)+1)
 . L -^LRO(69.2,LRAA,3)
 G GETP
 ;
CH D A G:'$D(LRAA) END
 D L G:'G END
 S LRAPX=1 D C
 W !!,"Save reports for reprinting " S %=2 D YN^LRU G:%<1 END S:%=1 LRSAV=1
DEV W !!,"Print  component  requests  " S %=2 D YN^LRU Q:%<1  S:%=1 LRN(2)=1
 W ! S ZTRTN="QUE^LRBLPBR" D BEG^LRUTL G:POP!($D(ZTSK)) END
 ;
QUE U IO K ^TMP("LRBL",$J)
 D L^LRU,S^LRU
 F X=2.91,8,10.3,11.3 D FIELD^DID(63.01,X,"","LABEL","LRN") S LRN(X)=LRN("LABEL") K LRN("LABEL")
 I $D(LR("S")) D SET G LST
 S LRLLOC=0 F A=0:0 S LRLLOC=$O(^LRO(69.2,LRAA,3,"C",LRLLOC)) Q:LRLLOC=""  F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,3,"C",LRLLOC,LRDFN)) Q:'LRDFN  D SET
LST S G=0
 F  S G=$O(^TMP("LRBL",$J,G)) Q:G=""!(LR("Q"))  S N=0 F  S N=$O(^TMP("LRBL",$J,G,N)) Q:N=""!(LR("Q"))  S LRDFN=0 F  S LRDFN=$O(^TMP("LRBL",$J,G,N,LRDFN)) Q:'LRDFN!(LR("Q"))  S LR=^(LRDFN) D ^LRBLPBR1
 I '$D(LRSAV) K ^LRO(69.2,LRAA,3) S ^LRO(69.2,LRAA,3,0)="^69.29A^^"
 W:IOST'?1"C".E @IOF K ^TMP("LRBL",$J) D END^LRUTL,END Q
 ;
SET S W=^LR(LRDFN,0),Y=$P(W,"^",3),(LRDPF,P)=$P(W,"^",2),X=^DIC(P,0,"GL"),X=@(X_Y_",0)"),Z=+$G(^(.104)),Z(1)="^"_$P($G(^DD(P,.104,0)),"^",3),SSN=$P(X,"^",9)
 D SSN^LRU
 I Z,$D(@(Z(1)_Z_",0)")) S LRMD=$P(^(0),"^")
 I 'Z S Z=$S($D(^LR(LRDFN,.2)):+^(.2),1:"") I Z,$D(^VA(200,Z,0)) S LRMD=$P(^(0),"^")
 I 'Z S LRMD="UNKNOWN"
 S ^TMP("LRBL",$J,LRLLOC,$P(X,"^"),LRDFN)=$P(X,"^",3)_"^"_SSN_"^"_$P(W,"^",5)_"^"_$P(W,"^",6)_"^"_LRMD Q
 ;
SGL D:'$D(LRAA) A
 G:'$D(LRAA) END
 K DIC S LRDPAF=1 W ! D ^LRDPA G:LRDFN<1 END
 I '$D(^LR(LRDFN,"BB")) W $C(7),!?3,"No blood bank data for ",LRP G SGL
 S:LRLLOC="" LRLLOC="???"
 S (LRSAV,LR("S"))=1 G DEV
 ;
DEL D A G:Y=-1 END
 D L G:'G END
 D C W $C(7),!!,"OK TO DELETE THE ",LRAA(1)," TEST REPORT QUEUE LIST"
 S %=2 D YN^LRU I %=1 K ^LRO(69.2,LRAA,3) S ^LRO(69.2,LRAA,3,0)="^69.29A^0^0" W $C(7),!,"LIST DELETED !" D END Q
 W !!,"FINE, LET'S FORGET IT",! Q
C S X=$P(^LRO(69.2,LRAA,3,0),U,4)
 W !?30,"(",X," patient",$S(X>1:"s",1:""),")" Q
 ;
L S G=$O(^LRO(69.2,LRAA,3,0)) I 'G W $C(7),!!,"NO BLOOD BANK PATIENTS ON THE TEST REPORT QUEUE",!! Q
 Q
 ;
A D END S X="BLOOD BANK" D ^LRUTL Q
 ;
END D V^LRU Q
