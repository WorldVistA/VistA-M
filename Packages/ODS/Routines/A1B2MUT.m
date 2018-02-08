A1B2MUT ;ALB/AAS - BILLING UTILITY ROUTINE ;16-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 ;written as war breaks out
 ;
 ;
ADM ;  -- find local patient dfn and ods admission entry number from ptf entry
 ;  -- input       DFN := entry in dpt
 ;             a1b2ptf := entry in ^dgpt
 ;  -- output  a1b2adm := entry in 11500.2
 S DFN=+^DGPT(A1B2PTF,0),A1B2ADM=""
 S A1B2ADM1=$O(^DGPM("APTF",A1B2PTF,0)) G:'A1B2ADM1 ADMQ
 S A1B2ADM=$S($D(^DGPM(A1B2ADM1,"ODS")):$P(^("ODS"),"^",4),1:"")
ADMQ K A1B2ADM1 Q
 ;
PTF ;  -- find ptf entry number from ods admission entry
 ;  -- input a1b2adm := entry in 11500.2
 ;  -- output a1b2ptf :=entry in ^dgpt
 S A1B2ADM2=$O(^DGPM("AODSA",A1B2ADM,0)),A1B2ADM="" G:'A1B2ADM2 PTFQ
 S A1B2PTF=$S($D(^DGPM(A1B2ADM2,0)):$P(^(0),"^",16),1:"")
PTFQ K A1B2ADM2 Q
 Q
 ;
ASKAD ;  -- ask ods admission
 ;I '$D(A1B2NTY) D FAC^A1B2UTL
 S A1B2ADM=""
 S DIC("S")="I $P(^(0),U,15),$P(^(0),U,7)=A1B2FN"
 S DIC("A")="Select ODS ADMISSION DATE/TIME: ",DIC="^A1B2(11500.2,",DIC(0)="AEQMN" D ^DIC K DIC S A1B2Y=Y G:+Y<1 ASKADQ
 S A1B2ADM=+A1B2Y,DFN=$P(^A1B2(11500.2,A1B2ADM,0),"^",12)
ASKADQ Q
 ;
EN1 ;  -- local site enter/edit of cost data
 D FAC^A1B2UTL
 D ASKAD G:'A1B2ADM EN1Q W !
 S A1B2NK="" D DISP1
 D EDIT
 W ! G EN1
EN1Q K A1B2MAIN,DIC,DIE,X,Y,A1B2Y,A1B2ADM,A1B2NOD,A1B2YY,DA,DR,DFN,A1B2NK
 I '$D(A1B2NTY) K A1B2FN,A1B2FNME
 Q
 ;
EDIT ;  -- input cost data,local input
 S DLAYGO=11500.64,DIC("A")="Select COST DATE: ",DIC="^A1B2(11500.64,",DIC(0)="AEQLMZ" D DICDR1
 D ^DIC Q:Y<1  K DIC S DA=+Y,A1B2NOD=Y(0)
 S DIE="^A1B2(11500.64,",DR="[A1B2 ENTRY]"
 D ^DIE
 S A1B2YY=^A1B2(11500.64,DA,0) I A1B2YY'=A1B2NOD,$D(^(1)),+^(1)'=2 S DR="1.01////3" D ^DIE
 K DIE,DR,DA,DLAYGO
 W ! G EDIT
 Q
 ;
DICDR1 ;  --set dic(dr) and dic(s) for files 11500.61 => 11500.64
 S DIC("DR")=".02////"_A1B2ADM_";.07////"_A1B2FN_";.08////"_A1B2FNME_";.15////1;1.05////"_DUZ_";1.01////2"_$S($D(A1B2PTF):";.13////"_A1B2PTF,1:"")_";.12////"_DFN_";.03;.04;.05"
 S DIC("S")="I $P(^(0),U,15),$P(^(0),U,7)=A1B2FN,$P(^(0),U,2)=A1B2ADM"
 Q
 ;
EN2 ;  -- Print billing data
 I '$D(A1B2NTY) D FAC^A1B2UTL
 S L=0,DIC="^A1B2(11500.2,",FLDS="[A1B2 BILLING DATA]",BY="[A1B2 BILLING DATA]"
 S A1B2FL=11500.2 D DIS^A1B2UTL
 D EN1^DIP
EN2Q K DIC,FLDS,BY,X,X1,D,A1B2FL
 Q
 ;
DISP ;  -- display billing data header, and data
 I '$D(A1B2NTY) D FAC^A1B2UTL
 W ! D ASKAD G:'A1B2ADM DISPQ
DISP1 D HOME^%ZIS K DXS S D0=+A1B2ADM,DN=1
 D HEAD
 S ^UTILITY($J,1)="S A1B2X=X D PAUSE^A1B2MUT Q:'DN  D HEAD^A1B2MUT S X=A1B2X W !"
 D ^A1B2CO,PAUSE:DN
 I '$D(A1B2NK) G DISP
DISPQ I $D(A1B2NK) K A1B2X,A1B2ANS,A1B2I,A1B2Y,DXS,DN,D0,X,X1,C,D,DIXX Q
 K A1B2ADM,A1B2X,A1B2ANS,A1B2BR,A1B2I,A1B2VR,A1B2Y,DFN,DXS,DN,D0,X,X1,C,D,DIXX
 I '$D(A1B2NTY) K A1B2FN,A1B2FNME
 K A1B2X,A1B2ANS,A1B2I,A1B2Y,DXS,DN,D0,X,X1,C,D,DIXX
 Q
 ;
HEAD ;
 W @IOF
 D ^A1B2COH
 Q
PAUSE ;
 F A1B2I=0:0 Q:$Y>(IOSL-2)  W !
 R "Press RETURN to continue:",A1B2ANS:DTIME I A1B2ANS["^" S DN=0
 Q
