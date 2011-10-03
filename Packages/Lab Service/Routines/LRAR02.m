LRAR02 ;DAL/HOAK COMPARE MAJOR HEADERS 062096 ; 12/12/96  10:16 ;
 ;;5.2;LAB SERVICE;**111**;Sep 27, 1994
INIT ;
 ;
 ;
 ;----------------------------------------------------------------------
 ;------Here is where we check the major header  and force to perm.
 ;
CHECKX S LRMH=$P($P(LRDAT,U,9),":")  ;Major Header
 S LRFG=$P($P(LRDAT,U,9),":",2)  ;PAGE
 ;
 ;     Checking all the test for different major header
 ;
 ;
 S TEST=.5
 F  S TEST=$O(^LR(LRDFN,"CH",LRIDT,TEST)) Q:+TEST'>0  D
 .  Q:$D(^TMP("LRT2",TEST))#2
 .  D SET
 ;--------------------------------------------------------------------
 ;
 ;
 Q
 ;
 ;
SET ;
 ;
 ;W !!,"I'VE CROSSED OVER......."
 S LRT1="^LAB(64.5,1,1)"
 F  S LRT1=$Q(@LRT1) Q:+$P(LRT1,",",2)'>0  D
 .  I $P(@LRT1,";",2)=TEST S LRMHX=$P(LRT1,",",4) Q:'LRMHX  D
 ..  ;W !,"TEST=",TEST," ",$P(LRT1,",",4),"<---64.5  ^LR--->",LRMH R VVVV
 ..  I LRMH'=LRMHX D MORE
 Q
 ;
MORE ;
 ;S LRIDT=0
 S:'$D(^TMP("LRT2",TEST))#2 ^(TEST)=""
 ;F  S LRIDT=$O(^LRO(68,"AC",LRDFN,LRIDT)) Q:LRIDT<1  D
 ;-----------------------------------------------------------------
 I $E(IOST,1,2)="C-" D
 .  ;W !!,"Found a diferent major header. I will increment page now."
 ;
 ;
 ;
 S ^LAR("DHZ",LRDFN,LRIDT,$P(^DD(63.04,TEST,0),U))=PNM_U_LRMH_U_LRMHX_U_(9999999-LRIDT)
 ;
 I '$D(^LR(LRDFN,"PG",LRMHX)) S ^LR(LRDFN,"PG",LRMHX)=LRMHX_U_1
 E  S $P(^LR(LRDFN,"PG",LRMHX),U,2)=$P(^(LRMHX),U,2)+1
 S LRPG5=$P(^LR(LRDFN,"CH",LRIDT,0),U,9) I '$D(LRPG5) D  QUIT
 .  S LRPG5=$P(^LR(LRDFN,"PG",LRMHX),U)
 .  S LRPG5=LRPG5_":"_$P(^LR(LRDFN,"PG",LRMHX),U,2) K LRPG5
 I $D(LRPG5) S $P(^LR(LRDFN,"CH",LRIDT,0),U,9)=$P($P(^(0),U,9),":",2)+1
 ;
 ;
 Q
