PSOSITED ;BHAM ISC/SAB - ENTER/EDIT OUTPATIENT SITE PARAMETERS ; 09/18/92 9:11
 ;;7.0;OUTPATIENT PHARMACY;**24,65,268**;DEC 1997;Build 9
 ;External reference to ^PS(59.7 supported by DBIA 694
 I $G(PSOPAR)']"" D ^PSOLSET
1 W ! K DIC S DIC("A")="Select SITE NAME: ",(DIC,DIE)="^PS(59,",DIC(0)="QEALM",DLAYGO=59
 K PSOSITEX D ^DIC G:"^"[X EX K DIC("A") G:Y<0 1 S DA=+Y D FLDQ G:$D(PSOSITEX) EX S DR="[PSO SITE]" W ! D ^DIE
 W !!,"Outpatient System Parameters",! S DA=1,DIE=59.7,DR="40;40.1;40.19;40.14;40.15" L +^PS(59.7,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !,"Another person is editing this entry.  Try Later!",! K DA,DIE,DR G 1
 D ^DIE L -^PS(59.7,DA)
 N CNT,TOT S (TOT,CNT)=0 F  S CNT=$O(^PS(59,CNT)) Q:'CNT  S TOT=TOT+1
 D:TOT>1 ^PSODIV K CNT,TOT
 S:$G(PSOSITE)=DA PSOPAR=$G(^PS(59,DA,1)),PSOPAR7=$G(^PS(59,DA,"IB")),PSOSYS=$G(^PS(59.7,1,40.1)) D EX G 1
EX K DIC,DA,DIE,DIR,DIV,DR,I,PS1,PS11,PSIX,PSOCNT,PSOSITEX,X,Y,%,%X,%Y,D0,DI,DQ,DX,S Q
 Q
FLDQ S DIR("?",1)="Press <RETURN> if you want to see a list of all outpatient",DIR("?")="pharmacy answered site fields.  Enter 'N' if you don't want to see the list."
 S DIR(0)="Y",DIR("A")="Would you like to see all site parameters for this division",DIR("B")="Y" D ^DIR K DIR S:$D(DTOUT) PSOSITEX="" I Y,'$D(PSOSITEX) W @IOF D EN^DIQ
 K DIR Q
