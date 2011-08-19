LRSETUP ;SLC/CJS/DALISC/FHS - REINITIALIZE DATA FILES ;2/6/91  14:34 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!,">> I WILL DO SOME FILE CHECKING AND THIS MAY TAKE A LITTLE WHILE <<",!!
 I $D(^LAB(62.4,1,0))[0 D
 . F  L +^LAB(62.4):1 Q:$T  W !!?7,"Someone else is editing the Automated Instrument file ",!!,$C(7) H 30
 . S ^(0)="^LABDATA",DIE="^LAB(62.4,",DR=".01///LSI#1;2///LAB",DA=1 D ^DIE W !,"I have added a LSI controller #1 to the auto instrument file",!,"Please check this entry after the init is finished",!,$C(7)
 . L -^LAB(62.4)
 F I=0:0 S I=$O(^LRO(68.2,I)) Q:I'>0  F J=0:0 S J=$O(^LRO(68.2,I,10,J)) Q:J'>0  F K=0:0 S K=$O(^LRO(68.2,I,10,J,1,K)) Q:K'>0  I $S($D(^(K,0)):$E($P(^(0),"^",3),1),1:0)="Y" S $P(^(0),"^",3)=1
 S $P(^LAB(64.5,1,1,0),"^")="MAJOR HEADER"
 Q
FRESH I '$D(^XUSEC("LRLIASON",DUZ)) W !,"Not cleared for this option." Q
POST W !!,"This procedure will purge/kill all entries in the ^LR( global"
 W !,"and the ^LRO( global. This should not be ran by any site already"
 W !,"running the Laboratory Package. It should only be used by First"
 W !,"Time Installation Sites. If your are not a First Time installation"
 W !,"DO NOT RUN this routine. If you have questions, contact your "
 W !,"Information Systems Center (ISC) before continuing"
 W !!?10,"Do you Wish to continue "
 S %=2 D YN^DICN G:%=0 POST Q:%'=1
 W !!?10,"ARE YOU CERTAIN - LAST CHANCE " S %=2 D YN^DICN G:%=0 POST Q:%'=1
 W !!,"In order to continue, you must answer the next prompt by"
 W !,"entering 'YES' --  A simple 'Y' will not work",!
 W !!,"IF YOU ARE READY   ANSWER 'YES'  " R ANS:100 Q:'$T  Q:ANS'="YES"
 W !!?5,"This will take a while ",!
 K ^LR("AAU"),^("AAUA"),^("ACY"),^("ACYA"),^("AEM"),^("AEMA"),^("ASP"),^("ASPA"),^("B"),^("AD") S ^LR(0)=$P(^LR(0),"^",1,2) S I=0 F  S I=$O(^LR(I)) Q:I<1  K ^LR(I)
 I $D(^LRD(65,0)) S X=$P(^LRD(65,0),"^",1,2),^LRD(65,0)=X,I=0 F A=0:0 S I=$O(^LRD(65,I)) Q:I=""  K ^(I)
 I $D(^LRE(0)) K ^LRE("AD"),^LRE("AT"),^LRE("B"),^("C"),^("D"),^("G"),^("G4") S ^LRE(0)=$P(^LRE(0),"^",1,2) S I=0 F  S I=$O(^LRE(I)) Q:I<1  K ^LRE(I)
 S I=0 F  S I=$O(^DPT(I)) Q:I<1  I $D(^DPT(I,"LR")) K ^DPT(I,"LR")
 F I=0:0 S I=$O(^LAB(62.3,I)) Q:I<1  S X=$P(^(I,0),U) I '$D(^LAB(62.3,"B",X)) K ^LAB(62.3,I)
 S LRDPF="62.3^LAB(62.3," S I=0 F  S I=$O(^LAB(62.3,I)) Q:I<1  K ^LAB(62.3,I,"LR") S DFN=I D END^LRDPA
 F F=67,67.1,67.2,67.3 S I=0 F  S I=$O(^LRT(F,I)) Q:I<1  K ^LRT(F,I,"LR")
 S X=$P(^LRO(67.9,0),U,1,2) K ^LRO(67.9) S ^LRO(67.9,0)=X
 S I=0 F  S I=$O(^LRO(68,I)) Q:I<1  K ^LRO(68,I,1)
 S I=0 F  S I=$O(^LRO(69.2,I)) Q:I<1  S J=0 F  S J=$O(^LRO(69.2,I,J)) Q:J<1  K ^LRO(69.2,I,J)
 S ^LAC(0)="" F I=0:0 S I=$O(^LAC(I)) Q:I=""  K ^(I)
 K ^LRO(68,"AA"),^("AC"),^("MI"),^("AVS"),^LAC("LRAC"),^("LRPHSET"),^("LGOT"),^("DEV") S ^LAC("LRAC",0)="CUMULATIVE^64.7",X=$P(^LRO(69,0),"^",1,2) K ^LRO(69) S ^LRO(69,0)=X
 F I=0:0 S I=$O(^LRO(68.2,I)) Q:I<1  K ^(I,1)
 S X=$P(^LRO(69.1,0),U,1,2) K ^LRO(69.1) S ^LRO(69.1,0)=X
 S X=$P(^LRO(69.2,0),U,1,2) K ^LRO(69.2) S ^LRO(69.2,0)=X
 S X=$P(^LRO(64.1,0),U,1,2) K ^LRO(64.1) S ^LRO(64.1,0)=X
 W !!?10,"Your files have been purged to day 1 status",!!
 Q
