QAPEDIT1 ;557/THM-CREATE/EDIT/MAINTAIN SURVEY INFORMATION, PART 2 [ 05/18/95  7:28 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
INDIV I $O(^QA(748.3,"B",SURVEY,0))]"" W *7,!!,"This survey has data associated with it and the question content",!,"may not be changed.",!!,"Press RETURN  " R ANS:DTIME S:'$T STOP=1 G:$D(STOP) EXIT G EN^QAPEDIT
 I ACTION="I" K STOP,OUT S DA(1)=SURVEY DO  G:$D(STOP) EXIT
 .;
DIS .K DA S DA(1)=SURVEY
 .K DANS S LSTNUM="" F I=0:0 S I=$O(^QA(748.25,"E",SURVEY,I)) Q:I=""  F J=0:0 S J=$O(^QA(748.25,"E",SURVEY,I,J)) Q:J=""  S DANS(I,J)=I,DANS(I)=I,LSTNUM=I
 .W @IOF,! S QAPHDR="Survey Name: "_SUBJ X QAPBAR S QAPHDR="Editing Individual Questions" X QAPBAR W !,BLDON,"Type ^ to exit, ? or ?? for HELP",BLDOFF
 .W:$D(LSTNUM) ?51,"Last question number: ",LSTNUM W !!,">> Question number: " R QAPQN:DTIME S:+QAPQN>0 LSTNUM=QAPQN I '$T S STOP=1 Q
 .I QAPQN="?" D HELPLKE^QAPUTIL1 I QAPQN="" G DIS
 .I QAPQN=""!(QAPQN[U) S OUT=1 Q
 .S QAPQN=$TR(QAPQN,"cr","CR")
 .I QAPQN?1"R" W "    Resequence question numbers   " H 1 D R1^QAPRSEQ G DIS
 .I QAPQN?1"C" D EN^QAPQCOPY,RSQ G DIS
 .I QAPQN'?1.3N,QAPQN'?1.3N1"."1.2N,QAPQN'?1"R",+QAPQN'=QAPQN W !!,"Question number entry must be numeric,'R' to resequence",!,"the question numbers, or 'C' to copy a question.",*7 H 2 G DIS
 .I +QAPQN<1!(+QAPQN>999) W !!,*7,"This number must be between 1 and 999.",! H 2 G DIS
 .S (DIC,DIE)="^QA(748.25,"_DA(1)_",1," X CLEOP
 .S DA=$O(^QA(748.25,"E",DA(1),QAPQN,0)) I DA]"" F I=0:0 S I=$O(^QA(748.25,SURVEY,1,DA,2,I)) D:I=""!(+I=0)  Q:I=""!(+I=0)  S X=$P(^QA(748.25,SURVEY,1,DA,2,I,0),U,1) W X,!
 .K DIR S DIR("A")="Change or Delete"
 .I DA]"" S DIR(0)="SB^C:Change;D:Delete",DIR("B")="Change" D ^DIR S:$D(DTOUT) EXIT=1 S:$D(DUOUT) OUT=1 Q:$D(DTOUT)  G:$D(DUOUT) DIS  S CHOICE=Y I CHOICE=""!(CHOICE[U) S OUT=1 Q
 .I DA="" K DIR,STOP,OUT S DIR("A")="Are you adding question "_QAPQN_" ",DIR(0)="Y",DIR("B")="No" W *7 D ^DIR S:$D(DTOUT) EXIT=1 S:$D(DUOUT) OUT=1 Q:$D(DTOUT)!($D(DUOUT))  S:Y=1 CHOICE="A" I Y'=1 G DIS
 .I CHOICE="A" S:'$D(^QA(748.25,DA(1),1,0)) ^QA(748.25,DA(1),1,0)="^748.26I^0^0"
 .I CHOICE="A" S X=+$P(^QA(748.25,DA(1),1,0),U,3)+1,DLAYGO=748.25,DIC(0)="AEQLM",DIC("DR")=".015////"_QAPQN_";.055;.05;.02" K DO,DD D FILE^DICN
 .I CHOICE="A" Q:+Y<0  S DA=+Y I $P(^QA(748.25,DA(1),1,DA,1),U)="m" S DR=".025;I X'=""l"" S Y=""@1"";.027;3;1;2;S Y=""@99"";@1;.03;@99" D ^DIE,RSQ
 .I CHOICE="C" S DR=".015;.055;.05;.02" X CLEOP D ^DIE,RSQ S:$D(DTOUT) STOP=1 G:$D(Y) DIS
 .I CHOICE="C",$P(^QA(748.25,DA(1),1,DA,1),U)'="m" D KANS^QAPUTIL2 S DR=".025///@;.027///@;3///@;1///@;2///@" D ^DIE,RSQ
 .I CHOICE="C",$P(^QA(748.25,DA(1),1,DA,1),U)="m" S DR=".025;I X'=""l"" S Y=""@1"";D KANS^QAPUTIL2;.027;3;1;2;S Y=""@99"";@1;.027///@;3///@;1///@;2///@;.03;@99" D ^DIE,RSQ
 .I CHOICE="D" DO  G DIS
 ..W !,*7,"Are you sure you want to remove this question" S %=2 D YN^DICN I $D(DTOUT) S EXIT=1 Q
 ..I %'=1 W !,">> Nothing deleted <<" H 1 Q
 ..I %=1 S DIK="^QA(748.25,"_DA(1)_",1," D ^DIK W !!,">> Question removed <<  " H 2 Q
 .G DIS
 ;
EDITALL I $O(^QA(748.3,"B",SURVEY,0))]"" W *7,!!,"This survey has data associated with it and the question content",!,"may not be changed.",! H 2 G EN^QAPEDIT
 S DA(1)=SURVEY
 I ACTION="E" K OUT  S QAPHDR="Survey Name: "_SUBJ W @IOF,! X QAPBAR S QAPHDR="Edit All Questions Sequentially" X QAPBAR K ^TMP($J)
 I ACTION="E",$O(^QA(748.25,"E",SURVEY,0))="" W !!?10,"This survey has no questions.",! H 2 G EN^QAPEDIT
 I ACTION="E" F QAPQN=0:0 S QAPQN=$O(^QA(748.25,"E",DA(1),QAPQN)) Q:QAPQN=""  F DA=0:0 S DA=$O(^QA(748.25,"E",DA(1),QAPQN,DA)) Q:DA=""  DO  I $D(OUT)!($D(EXIT)) S (QAPQN,DA,DA(1))=999999
 .S QAPHDR="Survey Name: "_SUBJ W @IOF,! X QAPBAR S QAPHDR="Edit All Questions Sequentially" X QAPBAR
 .W !,">> Question number: ",QAPQN,! S (DIC,DIE)="^QA(748.25,"_DA(1)_",1,",DR=".055;.05;.015;.02" D ^DIE,RSQ I $D(DTOUT) S EXIT=1 Q
 .I $D(Y) S OUT=1 Q
 .I $P(^QA(748.25,DA(1),1,DA,1),U)'="m" D KANS^QAPUTIL2 S DR=".025///@;.027///@;3///@;1///@;2///@" D ^DIE,RSQ
 .I $P(^QA(748.25,DA(1),1,DA,1),U)="m" S DR=".025;I X'=""l"" S Y=""@1"";D KANS^QAPUTIL2;.027;3;1;2;S Y=""@99"";@1;.027///@;3///@;1///@;2///@;.03;@99" D ^DIE,RSQ I $D(DTOUT) S EXIT=1 Q
 .I $D(Y) S OUT=1 Q
 I $D(EXIT) G EXIT
 G EN^QAPEDIT
 ;
EXIT G EXIT^QAPUTIL
 ;
RSQ K DANS F I=0:0 S I=$O(^QA(748.25,"E",SURVEY,I)) Q:I=""  F J=0:0 S J=$O(^QA(748.25,"E",SURVEY,I,J)) Q:J=""  S DANS(I,J)=I,DANS(I)=I
 Q
