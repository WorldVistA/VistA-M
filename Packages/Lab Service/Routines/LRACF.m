LRACF ;SLC/RWA - FORCE PAGES TO FULL ;2/19/91  10:10
 ;;5.2;LAB SERVICE;;Sep 27, 1994
QUEUE S U="^"
WARN W !,"This option will identify patients who have been inactive for the specified",!,"period of time defined in the GRACE PERIOD FOR INACTIVITY field of the"
 W !,"Laboratory Site file and force their lab data onto a permanent cumulative page,",!,"making the data eligible for archiving.",!
 W !,"The parameter is set for ( ",+$P(^LAB(69.9,1,0),U,13)," ) days ",!
WARN1 W !,"Are you sure you want to continue" S %=2 D YN^DICN Q:%=2!(%=-1)  I %=0 G HELP
 S ZTRTN="ENT^LRACF",ZTDESC="Force Cumulative data to Archive",LRFG=0 D IO^LRWU Q
ENT S U="^",LRFG=0
 S:$D(ZTQUEUED) ZTREQ="@" U IO S X="N",%DT="T" D ^%DT
 Q:'$L($P(^LAB(69.9,1,0),U,13))  S X1=DT,X2=-$P(^(0),U,13) D C^%DTC S LRDAYS=9999999-X_.5 D HDR S LRDFN=0 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D IDT
END K LRDAYS,LRDFN,LRDPF,LRFG,LRIDT,LRINO,LRNM,LRTXT,LRSPCM,LRSUB,LROPG,LRPG,LRPGE,LRPL
 Q
IDT Q:'$D(^LR(LRDFN,0))  S LRDPF=$P(^(0),U,2),DFN=$P(^(0),U,3) Q:LRDPF'=2  S LRNM=$S($D(^DPT(DFN,0)):$P(^(0),U,1),1:"UNKNOWN") Q:$O(^LR(LRDFN,"CH",0))<LRDAYS
MORE S LRIDT=0 F  S LRIDT=$O(^LRO(68,"AC",LRDFN,LRIDT)) Q:LRIDT<1  S LRSUB=0 F  S LRSUB=$O(^LRO(68,"AC",LRDFN,LRIDT,LRSUB)) Q:LRSUB<1  D:LRSUB'=1 CHECK K ^LRO(68,"AC",LRDFN,LRIDT,LRSUB),LRPG,LROPG,LRPGE
KILL Q:LRFG=0  K ^LAC("LRAC",LRDFN),^LAC("LRKILL",LRDFN),^LAC("LGOT",LRDFN)
 I $Y>(IOSL-7) D HDR
 W !!,LRDFN,?10,LRNM S LRTXT="" F I=0:0 S LRTXT=$O(^TMP($J,LRTXT)) Q:LRTXT=""  S ^LR(LRDFN,"PG",$P(LRTXT,"^",1))=LRTXT D TEXT
 S LRFG=0 K ^TMP($J) Q
CHECK I '$D(^LR(LRDFN,"CH",LRIDT,LRSUB)) Q
 S LRFG=1 D PAGE S:LROPG="" $P(^LR(LRDFN,"CH",LRIDT,0),U,9)=LRPGE,LROPG=$P(^(0),U,9) S:LROPG'[LRPGE $P(^LR(LRDFN,"CH",LRIDT,0),U,9)=LROPG_";"_LRPGE S ^TMP($J,LRPG)=""
 Q
PAGE S LRPG="" D FIND S LRPL=$F(LRPG,"^"),LRPGE=$E(LRPG,1,LRPL-2)_":"_$E(LRPG,LRPL,$L(LRPG)),LROPG=$P(^LR(LRDFN,"CH",LRIDT,0),U,9) Q
FIND ;Since Major Header and Page number is unknown this subroutine
 ;determines the major header and page number to be assigned.
 S LRSPCM=$P(^LR(LRDFN,"CH",LRIDT,0),"^",5)
 S LRMH=0 F  S LRMH=$O(^LAB(64.5,"AC",LRSUB,1,LRMH)) Q:'LRMH  S LRSH=0 F  S LRSH=$O(^LAB(64.5,"AC",LRSUB,1,LRMH,LRSH)) Q:'LRSH  S LRTSTS=0 F  S LRTSTS=$O(^LAB(64.5,"AC",LRSUB,1,LRMH,LRSH,LRTSTS)) Q:'LRTSTS  D SPCM
 I LRPG="" S LRPG=$S('$D(^LR(LRDFN,"PG","MISC")):"MISC^1",1:"MISC^"_($P(^LR(LRDFN,"PG","MISC"),"^",2)+1))
 Q
SPCM S LRSPM1=$P(^LAB(64.5,"AC",LRSUB,1,LRMH,LRSH,LRTSTS),"^",1) Q:LRSPCM'=LRSPM1  I $D(^LR(LRDFN,"PG",LRMH)) S LRPG=LRMH_"^"_($P(^LR(LRDFN,"PG",LRMH),"^",2)+1) Q
 S LRPG=LRMH_"^"_1
 Q
HDR W @IOF,!,?20,"***** INACTIVE PATIENTS FOR ARCHIVE*****",!!
 W "LRDFN"_"     "_"PATIENT NAME"_"                       "_"PAGE FORCED TO PERMANENT"
 Q
TEXT W ?57,LRTXT,! Q
HELP W !!,"Enter 'Yes' to continue, 'No' or '^' to exit" W ! G WARN1
