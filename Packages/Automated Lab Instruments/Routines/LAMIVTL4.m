LAMIVTL4 ;DAL/HOAK 4th Vitek literal verify rtn
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,31,40**;Sep 27,1994
INIT ;
 I '$G(LRTS) S LRTS=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,1,4,0))
 I 'OK D GLEEP^LAMIVTL3 QUIT
 S OK=1
DR ; FROM LAMIAUT1 BY FHS
 ;-----------------------------------------------------------------------
 ; This block runs edit template for comment, final report, bact etc.
 K DR,DIC,DIE,DA
 S DA(1)=LRDFN
 S DA=LRIDT
 S Y(0)=^LR(LRDFN,"MI",LRIDT,0),DIE="^LR("_LRDFN_",""MI"","
 S DR="11.55////^S X=DUZ;11.5;11.6;13"
 D ^DIE
 ;-----------------------------------------------------------------------
 S LREND=0
 D ^LAMIAUT3 Q:LREND
 D VERIFY
 L -(^LR(LRDFN,"MI",LRIDT),^LRO(68,LRAA,1,LRAD,1,LRAN))
 Q
VERIFY ;
 R !!," ('E'dit data, 'C'omments, 'O'rganism 'W'orklist) // ",LREDIT:DTIME
 I '$T D GLEEP^LAMIVTL3 S OK=0 QUIT
 I $E(LREDIT)="?" D HLP^LAMIAUT4,^LAMIAUT3 G VERIFY
 I $E(LREDIT)="^"!($E(LREDIT="@")) D GLEEP^LAMIVTL3 S OK=0 K LRBDUP,LRMOVE Q
 K DIC,DR,DIE,DA
 S DA=LRIDT,DA(1)=LRDFN
 S LRY(0)=^LR(LRDFN,"MI",LRIDT,0)
 S DIE="^LR("_DA(1)_",""MI"",",DIC=DIE
 I $E(LREDIT)="E" S ZX9=X9 D EDIT^LAMIAUT4,^LAMIAUT3 S X9=ZX9 K ZX9 G VERIFY
 I $E(LREDIT)="O" S ZX9=X9 D ^LRMIBUG,^LAMIAUT3 S X9=ZX9 K ZX9 G VERIFY
 I $E(LREDIT)="C" K DR S DR=".99;1;13" D ^DIE D ^LAMIAUT3 G VERIFY
 I $E(LREDIT)="W" D EN^LRCAPV D ^LAMIAUT3 G VERIFY
 R !,"Approve for release by entering your initials: ",X:DTIME
 I '$T!($E(X)="^") D GLEEP^LAMIVTL3 Q
 I X'=LRINI W !!,$C(7)," NOT APPROVED " Q
 I X=LRINI W !!,"Approved for Release" D VER D  QUIT
 .  ;time stamp
 .  D NOW^%DTC
 .  S $P(^LR(LRDFN,LRSUB,LRIDT,0),U,3)=%,$P(^(0),U,4)=$G(DUZ)
 .  S $P(^LR(LRDFN,LRSUB,LRIDT,1),U)=DT
 .  S LRODT=$P(^LR(LRDFN,LRSUB,LRIDT,0),U),LRODT=$P(LRODT,".")
 .  I $G(LRORGCNT) D
 ..  I $D(^LR(LRDFN,LRSUB,LRIDT,3,0)) S LRN12=$G(^(0)) D
 ...  S LRORGCNT=$P($G(LRN12),U,4)+LRORGCNT
 ..  S ^LR(LRDFN,LRSUB,LRIDT,3,0)=U_"63.3PA"_U_LRORGCNT_U_LRORGCNT
 .  S ^LRO(69,LRODT,1,"AL",LRLLOC,PNM,LRDFN)=""
 .  S ^LRO(69,LRODT,1,"AN",LRLLOC,LRDFN,LRIDT)=""
 .  S ^LRO(69,LRODT,1,"AP",LRPHYN,PNM,LRDFN)=""
 .  S ^LRO(69,LRODT,1,"AR",LRLLOC,PNM,LRDFN)=""
 .  S $P(^LRO(69,LRODT,1,LRSN,3),U,2)=%
 ;-----------------------------------------------------------------
VER ;Final report after initials
 S LRSS=LRSUB
 S LRUNDO=1
 ;
 S LRDPF=2,LRSSD=LRAA,LRACC="",LRADDF=LRSUB,LRORCOM=""
 Q:'$G(LRBUX)
 S LRORG(+LRBUX)=LRORGCNT
 S LRORGN=+LRBUX
 S LAMIAUTO=1
 S LAMIAUT0=1
 ;
 S LRFIFO=0
 S T1=1
 D VER1 Q
TIC ;
 ;
 ;I '$D(X9) S X9="F T1=1 "
 N LRBG0
 Q:X9=""  S (LRBG0,Y(0))=^LR(LRDFN,"MI",LRIDT,0),LRCAPOK=1,LRUNDO=0 I '$P(Y(0),U,3) S:$P(Y(0),U,9) LRUNDO=1 G VER1
 I $P(^LR(LRDFN,"MI",LRIDT,0),U,3) W !,"Final report has been verified by micro  supervisor,",$C(7),!,"If you proceed in editing, the report will be reprinted"
 F I=0:0 W !?10,"OK" S %=1 D YN^DICN Q:%  W !," Enter  'Y' or 'N' : "
 I %=2!(%<0) Q
VER1 ;
 S LRCAPOK=1
 S LRT=LRTS
 S LRCB7=LRIFN
 D:'$P(^LAB(69.9,1,"NITE"),U) ANN^LRCAPV
 ;N LRADD,GLB,LRBUG,LRBUGY
 S LRSB=1
 W !
 X (X9_"S LRPTP=$O(LRNAME(T1,0))")
 S LRCAPOK=1,Y(0)=^LR(LRDFN,"MI",LRIDT,0) D
 .  K DR
 .  S DR=11,LRSAME=0
 .  D:LRUNDO UNDO^LRMIEDZ
 .  I $G(^LAB(61.38,1,4))'>0 D
 ..  S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTS,0),U,5)=""
 .  D ^DIE,TIME^LRMIEDZ3
 .  S LRTS=LRPTP I $G(LRTS) I LRCAPOK&($P(LRPARAM,U,14)) D
 ..  S LRIFN=0
 ..  S LRIFN=$O(LRIFN(LRIFN)) Q:LRIFN=""  D WKLD
 ;
 ;
 ;
 N LRWRDVEW
 S LRWRDVEW=1
 D VT^LRMIUT1 I $L($G(LRVT)) D STF^LRMIUT
 S ^LRO(68,"AVS",LRAA,LRAD,LRAN)=LRDFN_U_LRIDT
 K ^LAH(LRLL,1,"C",LRAN)
 S LRPLA=0
 ;-->make certain we get'em all
 F  S LRPLA=$O(^LAH(LRLL,1,"C",LRAN,LRPLA)) Q:+LRPLA'>0  K ^(LRAN,LRPLA)
 D END^LAMIVTL0
 W @IOF D S1^LAMIVTL0 W !!
 Q
 ;             VITEK WORKLOAD----ETIOLOGY
WKLD ;
 D LOOK^LRCAPV1
 Q
 S LRT=LRTS
 S LRPLUK=0
 F  S LRPLUK=$O(^LAH(LRLL,1,LRPLUK)) Q:+LRPLUK'>0  D
 .  Q:$P(^LAH(LRLL,1,LRPLUK,0),U,5)'=LRAN
 .  S LRORG=0
 .  S LRIFN=LRPLUK
 .  F  S LRORG=$O(^LAH(LRLL,1,LRIFN,3,LRORG)) K LRADD Q:LRORG<1  D
 ..  I $D(^LAH(LRLL,1,LRIFN,3,LRORG,0))#2 S LRGB1=+^(0) D
 ...  S GLB="^LAB(61.2,LRGB1,9,A)",LRADD=""
 ...  D DISP1 Q:'$G(LRIFN)  D ETIOL^LRCAPV1
 K GLB
 F  W !!?10,"(D)isplay (A)dd Work Load " R X:DTIME S X=$E(X) S:'$T!(X=U)!(X="") LREND=1 Q:X="A"!(LREND)  D:X="D" DIS^LRCAPU
 Q
DISP1 ;
 W !,"PROCESSING: ",^LAB(61.2,LRGB1,0),?60,$G(LRCODE)
 Q
