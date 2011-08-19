LRAPS ;AVAMC/REG/CYM - AP PATIENT SCREEN DISPLAY ;8/6/97  14:06 ;
 ;;5.2;LAB SERVICE;**173**;Sep 27, 1994
 Q:'$D(DUZ)
 S LR("Q")=0,LRS(5)=1,IOP="HOME" D L^LRU,EN^LRUA,^%ZIS S LRDPAF=1
 W @IOF,!?15,"DISPLAY cum path data summary for a patient"
GETP W ! S LRA("A")="" K DIC D ^LRDPA I LRDFN=-1 D V^LRU Q
 W !!,"Is this the patient " S %=1 D YN^LRU Q:%<1  G:%=2 GETP
 I '$D(^LR(LRDFN,"CY")),'$D(^("SP")),'$D(^("EM")),'$D(^("AU")) W $C(7),!!,"No tissue pathology results for this patient.",!! G GETP
 I DOB[1700 S DOB=""
 G:'$D(^LR(LRDFN,"SP"))&('$D(^("CY")))&('$D(^("EM"))) AU
 D HDR,S^LRAPS1 G:LRA("A")]"" GETP
AU I $D(^LR(LRDFN,"AU")),+^("AU") D ^LRAPS2 K LRAU
 G GETP
M F X=0:0 Q:$Y>(IOSL-4)  W !
 Q:LRA("A")]""  R !!,"'^' TO STOP: ",LRA("A"):DTIME S:'$T LRA("A")="^" Q:LRA("A")="^"  I LRA("A")]"" S LRA("A")="" W $C(7) G M
 Q
HDR W @IOF,$E(LRP,1,30),?31,SSN,?50,"DOB: ",DOB,?68,"LOC: ",$E(LRLLOC,1,5) Q
