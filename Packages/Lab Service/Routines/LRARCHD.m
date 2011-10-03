LRARCHD ;SLC/MRH/DALISC/FHS - DEARCHIVE FROM ^LAR TO ^LR ;2/5/91  12:31 ;
 ;;5.2;LAB SERVICE;**59,125**;Sep 27, 1994
 ;ONCE THE GLOBAL ^LAR HAS BEEN PLACED ON THE SYSTEM
START ;
 W !,"This option will restore Laboratory data that has been archived ",!,"This data will again be removed from the ^LR global the next time the",!,"ARCHIVE program runs.",!!
ASK W !,"Do you wish to continue " S U="^",%=2 D YN^DICN G TEXT:%=0,STOP:%'=1
 I '$D(^LAR("Z")) W !,$C(7),"The LAR global is not on the system.  Load it",!,"from where you have it stored and start again." G STOP
NPC ;Check to ensure the routine ^LRARNPXA has been ran - 'it sets the 'NPC' node
 W !!?5,"Checking ^LAR( for New Person Conversion ",!
  S LRDFN=0 F CNT=1:1:80 S LRDFN=$O(^LAR("Z",LRDFN)) Q:LRDFN<1!($G(LRNOP))  W "." D
 . S LRIDT=$O(^LAR("Z",LRDFN,"CH",0)) Q:'LRIDT  I '$G(^(LRIDT,"NPC")) S LRNOP=1
 K LRDFN,LRIDT,CNT I $G(LRNOP) W !!,"You must FIRST run the option",!," 'Convert archived data to use New Person file",!,$C(7) G CONV
 W !!?5,"File appears to have been Converted to New Person.",!!
 S %=2 W !,"Do you wish to restore data for ALL patients " D YN^DICN G ALL:%=1,TEXT:%=0,STOP:%<0
PT K LRCHND,LRMIND S DIC=0 D ^LRDPA G:Y'>0 STOP
 I '$L(SSN) W !,$C(7),"No identifier defined for this patient" G STOP
 I '$D(^LAR("SSN",SSN(2)))&('$D(^(SSN))) W !,$C(7),"NO ARCHIVED DATA EXISTS FOR THIS PATIENT! " G PT
 S LRDFN=$S($D(^LAR("SSN",SSN(2))):$O(^(SSN(2),0)),$D(^LAR("SSN",SSN)):$O(^(SSN,0))),LRCHKSUM=$P(^LAR("Z",LRDFN,0),U,1,3)
 I LRCHKSUM'=$P(^LR(LRDFN,0),"^",1,3) W !,$C(7),"The file entries do not match, I can go no further!" G PT
 I $D(^LAR("Z",LRDFN,"CH",0)) S LRCHND=^(0) S $P(^(0),U,2)="63.04D"
 I $D(^LR(LRDFN,"CH",0)) K ^LAR("Z",LRDFN,"CH",0)
 I $D(^LAR("Z",LRDFN,"MI",0)) S LRMIND=^(0) S $P(^(0),U,2)="63.05DA"
 I $D(^LR(LRDFN,"MI",0)) K ^LAR("Z",LRDFN,"MI",0)
 S Z=^LR(LRDFN,0),%X="^LAR(""Z"",LRDFN,",%Y="^LR(LRDFN," D %XY^%RCR S ^LR(LRDFN,0)=Z S:$D(LRCHND) ^LAR("Z",LRDFN,"CH",0)=LRCHND S:$D(LRMIND) ^LAR("Z",LRDFN,"MI",0)=LRMIND W !,$C(7),"DONE FOR THIS PATIENT",! G PT
EXIT ;
 W !,$C(7),"ALL DONE !",$C(7)
STOP K %X,%Y,%,SSN,LRCHND,LRMIND,LRDFN,LRIDT,LRNOP,CNT,LRCHKSUM,DIC Q
TEXT W !!,"Just answer ""YES"" or ""NO""." G ASK
ALL W !,"This may take some time!",! F LRDFN=0:0 S LRDFN=$O(^LAR("Z",LRDFN)) Q:LRDFN<1  D
 .I $D(^LAR("Z",LRDFN,"CH",0)) S LRCHND=^(0) S $P(^(0),U,2)="63.04D"
 .I $D(^LR(LRDFN,"CH",0)) K ^LAR("Z",LRDFN,"CH",0)
 .I $D(^LAR("Z",LRDFN,"MI",0)) S LRMIND=^(0) S $P(^(0),U,2)="63.05DA"
 .I $D(^LR(LRDFN,"MI",0)) K ^LAR("Z",LRDFN,"MI",0)
 .S Z=^LR(LRDFN,0),%X="^LAR(""Z"",LRDFN,",%Y="^LR(LRDFN," D %XY^%RCR S ^LR(LRDFN,0)=Z
 G EXIT
CONV ;
 W !,"Would you like to run the conversion option now " S %=1 D YN^DICN
 I %'=1 G STOP
 D ^LRARNPX G STOP
 Q
EN ;
FIND K DIC S DIC=0 D ^LRDPA Q:LRDFN<1  S DA=$O(^LR(LRDFN,"T",0)) I DA="" W !,"No data archived." G FIND
 S DIC="^LAB(69.9,1,6,",DR=0 D EN^DIQ F DA=DA:0 S DA=$O(^LR(LRDFN,"T",DA)) Q:DA<1  S K=0 D EN^DIQ
 G FIND
