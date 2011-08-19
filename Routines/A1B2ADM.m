A1B2ADM ;ALB/MIR - Create ODS ADMISSION record from past admission record ;23 JAN 91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 D ON^A1B2UTL I 'A1B2ODS W !,"ODS software is not on...you can not use this option" G Q
PAT ;ask patient, check if ODS
 W !! K DIC S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DFN=+Y
 I $S('$D(^DPT(DFN,.32)):1,'$D(^DIC(21,+$P(^(.32),"^",3),0)):1,$P(^(0),"^",3)'=6:1,1:0) W !!?5,"Patient does not have a period of service of ODS" G PAT
 S DIC("S")="I $P(^(0),""^"",2)=1,(^(0)>2910115),$S('$D(^(""ODS"")):1,'$P(^(""ODS""),""^"",4):1,1:0)" D EN^DGPMUTL S A1B2MVT=Y
 I Y'>0 G PAT
 ;
ASK W !!,"Do you want to create an ODS ADMISSION entry for " S Y=$P(Y,"^",2) X ^DD("DD") W Y S %=2 D YN^DICN I $D(DTOUT) G Q
 I %<0!(%=2) G PAT
 I '% W !?2,"Enter 'Y'es if this admission was for care related to Operation",!?2,"Desert Shield.  Otherwise, respond 'N'o." G ASK
ADD ;
 S DGPMDA=+A1B2MVT,DGPMA=$P(A1B2MVT,"^",2) D ADM^DGPMVODS
 S DIE="^DGPM(",DA=+A1B2MVT,DR="11500.01////1;11500.04////^S X=DGODSE" D ^DIE
 S A1B2Y=11500.2,X=+DGODSE D UPD^A1B2XFR
 W !,"Record Created"
Q K %,%Y,A1B2MVT,A1B2ODS,A1B2Y,DA,DFN,DGODSE,DGPMDA,DGPMA,DIC,DIE,DR,DTOUT,I,J,X,Y
 Q
