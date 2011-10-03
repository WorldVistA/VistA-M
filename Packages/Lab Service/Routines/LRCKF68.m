LRCKF68 ;SLC/RWF - CHECK FILE 68 ; 8/27/87  10:32 ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 S ZTRTN="ENT^LRCKF68" D LOG^LRCKF Q:LREND  W !,"QUICK REVIEW" S %=1 D YN^DICN Q:%<1  S:%=1 LRQUICK=1 D ENT W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
ENT ;from LRCKF
 U IO W !,"   CHECKING FILE 68" S LRPACC=0,LRPWL=0,LRPWDT=0,U="^" F I=1:1:10 S E(8,I)=0
 F LRAA=0:0 S LRAA=$O(^LRO(68,LRAA)) Q:LRAA'>0  D LRAD
 K LRPACC,LRPWL,LRPWDT,LRQUICK W !! W:$E(IOST,1,2)="P-" @IOF Q
LRAD I '$D(^LRO(68,LRAA,0))#2 W:$Y'<IOSL @IOF W !,"****  ACCESSION AREA # "_LRAA_" IS CORRUPTED ****",! Q
 S LR0=^LRO(68,LRAA,0) W:$Y'<IOSL @IOF W !,"ACCESSION AREA: ",$P(LR0,U) I '$L($P(LR0,U,2)) W !?5,"F- Missing the LR SUBSCRIPT entry."
 I '$P(LR0,U,8) W !?5,"W- Missing print order."
 I '$L($P(LR0,U,11)) W !?5,"F- Has no ABBREVIATION."
 I LRCKW,'$L($P(LR0,U,3)) W !?5,"W- missing the Clean up field."
 I $P(LR0,U,4),$D(^LRO(68,+$P(LR0,U,4),0))[0 W !?5,"F- BAD common accession # pointer to the accession file."
 I $P(LR0,U,5),$D(^LAB(62.07,+$P(LR0,U,5),0))[0 W !?5,"F- BAD accession transform pointer to the execute code file."
 I $S($D(^LAB(62.07,+$P(LR0,U,5),.1)):^(.1),1:"")'=$S($D(^LRO(68,LRAA,.1)):^(.1),1:1) W !?5,"F- Accession transform field and execute code file don't match."
 I $P(LR0,U,6),$D(^LAB(62.07,+$P(LR0,U,6),0))[0 W !?5,"F- BAD verification code pointer to the execute code file."
 I $P(LR0,U,6),$S($D(^LAB(62.07,+$P(LR0,U,6),.1)):^(.1),1:"")'=$S($D(^LRO(68,LRAA,.2)):^(.2),1:1) W !?5,"F- Verification code and execute code file don't match."
 F LRIN=0:0 S LRIN=$O(^LRO(68,LRAA,.5,LRIN)) Q:LRIN<1  I $D(^(LRIN,0))#2 S X=^(0) D INST
 I '$D(LRQUICK) F LRAD=0:0 S LRAD=$O(^LRO(68,LRAA,1,LRAD)) Q:LRAD<1  D LRAN
 Q
LRAN F LRAN=0:0 S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:LRAN'>0  D CHK68
 Q
NAME S E(8,E)=1+E(8,E) I E(8,E)>20 S E=0 Q
 I LRPWDT'=LRAD!(LRAA'=LRPWL) S Y=LRAD D DD^LRX W:$Y'<IOSL @IOF W !!,"ACCESSION AREA: ",$P(^LRO(68,LRAA,0),U)," for date: ",Y S LRPWL=LRAA,LRPWDT=LRAD
 I LRPACC'=LRACC W !,"ACCESSION: ",LRACC S LRPACC=LRACC
 Q
CHK68 I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))[0 Q  ;MUST BE A PLACE HOLDER
 S LA=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRDFN=+LA,LRORDER=$S($D(^(.1)):^(.1),1:""),LRACC=$S($D(^(.2)):^(.2),1:""),LRCTRL=$S($D(^LR(LRDFN,0))#2:$P(^(0),U,2),1:0),LRCTRL=(LRCTRL>60&(LRCTRL<70))
 I $D(^LR(LRDFN,0))[0 S E=1 D NAME I E W !?5,"F- Entry ",LRDFN," in ^LR( is missing."
 I LRACC="" S E=2,LRACC="ENTRY: "_LRAN D NAME I E W !?5,"F- Does not have an ACCESSION."
 Q:LRCTRL
 I LRCKW,LRORDER="" S E=3 D NAME I E W !?5,"W- Does not have an LRORDER number."
 I LRCKW,$D(^LRO(69,+$P(LA,U,4),1,+$P(LA,U,5),0))[0 S E=4 D NAME I E W !?5,"W- Does not have an Order on file."
 F T=0:0 S T=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,T)) Q:T'>0  I $D(^(T,0))#2 S X=^(0) D TEST
 F T=0:0 S T=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,T)) Q:T'>0  I $D(^(T,0))#2 S X=^(0) D SPEC
 Q
TEST I $D(^LAB(60,+X,0))[0 S E=5 D NAME I E W !?5,"F- BAD pointer to test file (60)."
 I $D(^LAB(62.05,+$P(X,U,2),0))[0 S E=6 D NAME I E W !?5,"F- BAD pointer to urgency file (62.05)."
 S Y=$P(X,U,3) Q:'+Y  S LRLL=+Y,LRTRAY=$P(Y,";",2),LRCUP=$P(Y,";",3),L=$S($D(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,0)):^(0),1:"")
 I L="" S E=9 D NAME I E W !?5,"W- Accession points to a load/work list entry that is missing" Q
 I $P(L,U,1,3)'=(LRAA_U_LRAD_U_LRAN) S E=10 D NAME I E W !?5,"W- Load/work list (",LRLL,";",LRTRAY,";",LRCUP,") doesn't point back to here. (",$P(L,U,1,3),")" Q
 Q
SPEC I $D(^LAB(61,+X,0))[0 S E=7 D NAME I E W !?5,"F- BAD pointer to the specimen file (61)."
 I $D(^LAB(62,+$P(X,U,2),0))[0 S E=8 D NAME I E W !?5,"F- BAD pointer to collection file (62)."
 Q
INST I $D(^LAB(62.4,+X,0))[0 W !?5,"F- BAD instrument pointer to the auto instrument file."
 F LRCT=0:0 S LRCT=$O(^LRO(68,LRAA,.5,LRIN,1,LRCT)) Q:LRCT<1  I $D(^(LRCT,0))#2 S X=^(0) I $D(^LAB(62.3,+X,0))[0 W !?5,"F- BAD control name pointer to the control name file."
 Q
