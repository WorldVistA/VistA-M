LAMIAUT1 ;SLC/FHS -  CONTINUE MICRO AUTO INSTRUMENT PROGRAN VITEK  ;7/23/90  11:06 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
EN ; From LAMIAUT0
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  W @IOF S Y(0)=^(0),LRDFN=+Y(0),LRDPF=$P(Y(0),U,2),LRLLOC=$P(Y(0),U,7),LRPHY=$P(Y(0),U,8),LRACCN=^(.2)
 S LRODT=$P(Y(0),U,4),LRSN=$P(Y(0),U,5),(LRSPEC,LRSAMP)=0
 S Y(3)=^(3),LRCDT=$P(Y(3),U),LRDTR=$P(Y(3),U,3),LRIDT=$P(Y(3),U,5),LREAL=$P(Y(3),U,2),LRI=$O(^(5,0)) I $D(^(LRI,0)) S LRSPEC=+^(0),LRSAMP=+$P(^(0),U,2)
 S DFN=$P(^LR(LRDFN,0),U,3),LRPHYN=$S($D(^VA(200,+LRPHY,0)):$P(^(0),U),1:"Unknown")
PAT ;
 D PT^LRX W !,"ACC # (",LRAN,")    " W $$DTF^LRAFUNC1(LRCDT),!!?10,PNM,"   SSN: ",SSN,"   LOC: ",LRLLOC
 W !?5,"Specimen: ",$S($D(^LAB(61,+LRSPEC,0)):$P(^(0),U),1:"Unknown"),"    Sample: ",$S($D(^LAB(62,+LRSAMP,0)):$P(^(0),U),1:"Unknown"),!
 I $D(^LRO(69,LRODT,1,LRSN,6,+$O(^LRO(69,LRODT,1,LRSN,6,0)),0)) W !," Comment on Specimem    " S I=0 F A=0:0 S I=$O(^LRO(69,LRODT,1,LRSN,6,I)) Q:I=""  W ?30,^(I,0),!
 I $D(^LR(LRDFN,"MI",LRIDT,2,+$O(^LR(LRDFN,"MI",LRIDT,2,0)),0)) W !,"GRAM STAIN " S I=0 F A=0:0 S I=$O(^LR(LRDFN,"MI",LRIDT,2,I)) Q:I=""  W ?15,^(I,0),!
 I $D(^LR(LRDFN,"MI",LRIDT,99)) W !,"Comment on Specimen : ",^(99)
RD S %=1,LREND=0 W !!?10,"Is this the correct patient/specimen " D YN^DICN I %'=1 Q
 D EXP^LAMIAUT4 Q:LREND  S LRCAPOK=1 G:'$D(^LR(LRDFN,"MI",0))!('$D(^LR(LRDFN,"MI",LRIDT,0))) BB
RD1 ;
 G:'$P(^LR(LRDFN,"MI",LRIDT,0),U,3) RD2 W !,"Final report has been verified by microbiology supervisor.",$C(7),!,"If you proceed in editing, this report will need to be reverified."
 F I=0:0 W !,?20,"OK" S %=1 D YN^DICN Q:%  W !,"Enter 'Y' or 'N':"
 I %=2!(%<0) S LRCAPOK=0 Q
RD2 I $P(^LR(LRDFN,"MI",LRIDT,0),U,3)!$P(^LR(LRDFN,"MI",LRIDT,0),U,9) S LRUNDO=1
BB I '$D(^LR(LRDFN,"MI",0)) S ^LR(LRDFN,"MI",0)="^63.05DA^"_LRIDT_U_0
 S ^LR(LRDFN,"MI",0)=$P(^LR(LRDFN,"MI",0),U,1,2)_U_LRIDT_U_(1+$P(^(0),U,4))
 S:'$D(^LR(LRDFN,"MI",LRIDT,3,0)) ^(0)="^63.3PA^^"
 I '$D(^LR(LRDFN,"MI",LRIDT,0)) S ^(0)=LRCDT_U_LREAL_"^^^"_LRSPEC_U_LRACCN_U_LRPHY_U_LRLLOC_"^^"_LRDTR_U_LRSAMP
 L +(^LR(LRDFN,"MI",LRIDT),^LRO(68,LRAA,1,LRAD,1,LRAN)):0 I '$T W !!?7,$C(7),"Another User is Editing this Patient",!! Q
 K LRBDUP F I=0:0 S I=$O(^LR(LRDFN,"MI",LRIDT,3,I)) Q:I<1  I $D(^(I,0)) S BB=+^(0) I BB S:'$D(LRBDUP(BB))#2 LRBDUP(BB)=0 S LRBDUP(BB)=LRBDUP(BB)+1,LRBDUP(BB,I)="" K BB
 S LRIFN=+$O(^LAH(LRLL,1,"C",LRAN,0)) G:'LRIFN CLEAR I '$D(^LAH(LRLL,1,LRIFN,3)) W !,$C(7),?10,"No Organism for this Accession" G CLEAR
 F II=0:0 S II=+$O(^LAH(LRLL,1,LRIFN,3,II)) Q:II<1  D ORG^LAMIAUT2 Q:LREND
DR ;
 D ^LAMIAUT2 Q:LREND  I '+$O(^LR(LRDFN,"MI",LRIDT,3,0)) W !?10,"NO ORGANISM TO DISPLAY " Q
 K DR,DIC,DIE,DA S DA(1)=LRDFN,DA=LRIDT,Y(0)=^LR(LRDFN,"MI",LRIDT,0),DIE="^LR("_LRDFN_",""MI"","
 S DR="11.55////^S X=DUZ;.99;11.5;11.6;13" D ^DIE
 S LREND=0 D ^LAMIAUT3 Q:LREND  D ^LAMIAUT4
 L -(^LR(LRDFN,"MI",LRIDT),^LRO(68,LRAA,1,LRAD,1,LRAN))
 Q
CLEAR ;
 S (LRUNDO,LACAPOK)=0 LOCK  Q
