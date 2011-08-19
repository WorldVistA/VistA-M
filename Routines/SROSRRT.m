SROSRRT ;BIR/MAM-ADD TISSUE EXAM FOR NON OR; 26 AUGUST 1994 7:00am
 ;;3.0; Surgery ;**33**;24 Jun 93
ADD ; add option Tissue Examination Report (SROTRPT) to the
 ; Non-O.R. Procedures (Enter/Edit) Menu
 ;
 S SRSOUT=0
 W !,"This routine will add the Tissue Examination Report to the Non-O.R.",!,"Procedures (Enter/Edit) Menu.  It also provides the ability to add the"
 W !,"fields BRIEF CLIN HISTORY, OPERATIVE FINDINGS, and SPECIMENS to the",!,"SRNON-OR input template.",!!,"After updating the input template, the TISSUE EXAM/NON O.R. entry in the"
 W !,"PACKAGE file will be removed.  It was created to provide the template",!,"updates and is no longer needed.  The PACKAGE file entry SURGERY V3.0"
 W !,"PATCH, which was created by an earlier Surgery patch, will be removed",!,"also since it, too, is no longer needed."
 K DIC,X,Y S DIC=19,DIC(0)="QM",X="SRONOP-ENTER" D ^DIC K DIC S SRMENU=+Y
 I SRMENU<0 W !!,"You are missing the Non-O.R. Procedures (Enter/Edit) Menu.  Please contact",!,"your local ISC customer service representative for assistance." Q
 K DIC,X,Y S DIC=19,DIC(0)="QM",X="SROTRPT" D ^DIC K DIC S SRTISS=+Y
 I SRTISS<0 W !!,"You are missing the Tissue Examination Report option.  Please contact your",!,"local ISC customer service representative for assistance." Q
 I '$O(^DIC(19,SRMENU,10,"B",SRTISS,0)) W !!,"Adding the Tissue Examination Report to Non-O.R. Procedures (Enter/Edit)..." D
 .K X,Y,DR,DIC,DA,DD,DO,DINUM S X=SRTISS,DA(1)=SRMENU,DIC(0)="L",DIC="^DIC(19,"_SRMENU_",10,",DLAYGO=19.01 D FILE^DICN S SRSUB=+Y
 .K DIE,DR,DA,X,Y S DIE="^DIC(19,"_SRMENU_",10,",DA(1)=SRMENU,DA=SRSUB,DR="2///TR;3///6" D ^DIE K DR,DA,DIE
 ;
TEMP ; update input template SRONOP-ENTER
 ;
 G:SRSOUT END
 W !!,"This routine provides the ability to overlay the input template SRNON-OR.",!,"This template is used within the option ""Edit Non-O.R. Procedure"" to"
 W !,"update Non-O.R. Procedure information."
 W !!,"If you have already made local changes to this template, you may opt to",!,"bypass this portion of the process and update your input template manually."
 W !,"The fields to be added are SPECIMENS, BRIEF CLIN HISTORY, and OPERATIVE",!,"FINDINGS."
 W !!,"Do you want to overlay the input template SRNON-OR?  YES// " R SRYN:DTIME I '$T!(SRYN["^") G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I SRYN["?" D HELP G TEMP
 I "YyNn"'[SRYN W !!,"Enter ""YES"" or ""NO"".  If you need additional help, enter ""?""." G TEMP
 I "Nn"[SRYN W !!,"No updates have been made to the SRNON-OR template." G END
 W !!,"Updating the SRNON-OR template.",!
 D ^SRRTINIT
END ;
 K DIC S DIC=9.4,DIC(0)="M",X="TISSUE EXAM/NON O.R." D ^DIC I +Y>0 S SRPKG=+Y D
 .W !!,"The update to SRNON-OR is complete.",!!,"Removing TISSUE EXAM/NON O.R. from the PACKAGE file..." K DIC,DIK,DA S DA=SRPKG,DIK="^DIC(9.4," D ^DIK
 K DIC S DIC=9.4,DIC(0)="M",X="SURGERY V3.0 PATCH" D ^DIC I +Y>0 S SRPKG=+Y W !!,"Removing SURGERY V3.0 PATCH from PACKAGE file..." K DIC,DIK,DA,X,Y S DA=SRPKG,DIK="^DIC(9.4," D ^DIK
 W !!,"The process is complete.  The Tissue Examination Report can now be printed",!,"for Non-O.R. Procedures."
 K DA,DIC,DIE,DIK,DINUM,DLAYGO,DO,DR,SRMENU,SRPKG,SRSOUT,SRSUB,SRTISS,SRYN,X,Y
 Q
HELP ; help message for updating SRNON-OR input template
 W !!,"Enter ""YES"" if you want to overlay the input template SRNON-OR.  If you have",!,"made local changes to this template, answering ""YES"" will remove them."
 W !,"If you have made local changes and do not wish to have them removed, you should",!,"answer ""NO"" to this question.  Then, using VA FileMan, add the fields"
 W !,"SPECIMENS, OPERATIVE FINDINGS, and BRIEF CLIN HISTORY to the SRNON-OR",!,"template.",!!,"Press RETURN to continue: " R X:DTIME S:X["^" SRSOUT=1
 Q
