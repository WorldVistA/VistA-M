VADPT61 ;ALB/MJK - Patient ID Utilities (cont.); 12 AUG 89 @1200
 ;;5.3;Registration,;**749**;Aug 13, 1993;Build 10
 ;
1 ;;ID Format Enter/Edit
 W ! S DIC="^DIC(8.2,",DIC(0)="AELMQ" D ^DIC K DIC G Q1:+Y<1
 S DA=+Y,DIE="^DIC(8.2,",DR="[DG ID FORMAT ENTER/EDIT]" D ^DIE G 1
Q1 K DIE,DR,DA,Y Q
 ;
2 ;;Eligibility Code Enter/Edit
 W ! S DIC="^DIC(8,",DIC(0)="AELMQ",DIC("DR")=8 D ^DIC K DIC G Q2:+Y<1
 S DA=+Y,DIE="^DIC(8,",DR="[DG ELIG ENTER/EDIT]" D ^DIE G 2
Q2 K DIE,DR,DA,Y
 Q
 ;
ASK ;
 Q:$S('$D(^DIC(8.2,+$P(^DIC(8,VAELG,0),U,10),0)):1,1:'$P(^(0),U,2))
 W !!,*7,"User Input Needed for '",$P(^DIC(8,VAELG,0),U),"' id:"
 S DIE="^DPT("_DFN_",""E"",",DR=.03,DA(1)=DFN,DA=VAELG D ^DIE
 W !!?5,"...",$P(^DIC(8,VAELG,0),U)
 K DIE,DR,DA,Y
 Q
 ;
WARN ; -- interaction warning
 I $P(X,U,2) W !!?5,*7,"WARNING: User interaction usually is required for this format."
 Q
 ;
BEG ;
 S VASTART=$$NOW^XLFDT
 Q
 ;
END ;
 S VAEND=$$NOW^XLFDT,L=0
 K XMY
 S XMSUB=$P($T(OPTS+VAOPT),";",4),XMDUZ=.5,XMTEXT="VATEXT(",XMY(DUZ)=""
 I VAOPT=3 S XMSUB=XMSUB_" (Format: "_$S($D(^DIC(8.2,VAFMT,0)):$P(^(0),U),1:"UNKNOWN")_")"
 I VAOPT=5 S XMSUB=XMSUB_" (Eligibility: "_$S($D(^DIC(8,VAELG,0)):$P(^(0),U),1:"UNKNOWN")_")"
 S L=L+1 S VATEXT(L,0)=" "
 S Y=VASTART,L=L+1 X ^DD("DD") S VATEXT(L,0)="  Job started   at "_Y
 S Y=VAEND,L=L+1 X ^DD("DD") S VATEXT(L,0)="  Job completed at "_Y
 D ^XMD
 K VAOPT,VASTART,VAEND,L,VATEXT,XMY,XMSUB,XMDUZ,XMTEXT,Y,% Q
 ;
TASK ;
 W !!?5,"The resetting of ID formats can take many hours."
 W !?5,"It is suggested that it be run at off-peak hours,"
 W !?5,"perferably over a weekend.",!
 K ZTSK S X=$T(OPTS+VAOPT),VARS=$P(X,";",5)
 F I=1:1 S Y=$P(VARS,"^",I) Q:Y=""  S ZTSAVE(Y)=""
 S ZTSAVE("VAOPT")="",ZTRTN="QUE"_VAOPT_"^VADPT60",ZTDESC=$P(X,";",4),ZTIO="" D ^%ZTLOAD
 I $D(ZTSK) W !!,"Job has been queued. (Task #",ZTSK,")",!,"A MailMan message will be sent to you when the job has completed."
TASKQ K ZTIO,ZTRTN,ZTDESC,ZTSAVE,VARS,Y,X,ZTSK Q
 ;
OPTS ; -- queue task list ;;opt#;description;vars to save
 ;;1;none
 ;;2;none
 ;;3;Reset ID Format;VAFMT
 ;;4;Reset Primary Eligibilty ID Format
 ;;5;Reset Specific Eligibilty ID Format;VAELG
 ;;6;none
 ;;7;Reset All ID Formats for all Patients
