ONCOFUP ;Hines OIFO/GWB - Print Follow-up Letter [ONCO FOLL-PRINT LETTER]
 ;;2.11;ONCOLOGY;**2,22,25,47**;Mar 07, 1995;Build 19
 ;
SCL W @IOF,!?2,"************ Print Follow-Up Letter ************",!
 K DIC
 S DIC="^ONCO(160,"
 S DIC(0)="AEMQZ"
 S DIC("A")="  Select patient: "
 D ^DIC G:(Y=-1)!($D(DTOUT))!($D(DUOUT)) EXIT
 S (DA,ONCOD0)=+Y
 ;
LFC ;LAST FOLLOW-UP CONTACT (160,15.1)
 K ONCOC0
 W !
 W !?2,"The follow-up letter is sent to the LAST FOLLOW-UP CONTACT."
 W !?2,"You may enter a new contact."
LC W !
 S DIE="^ONCO(160,",DR="15.1"
 L +^ONCO(160,DA):$G(DILOCKTM,5)
 I '$T R !?2,"Another user is editing this entry.",X:5 G SCL
 D ^DIE L -^ONCO(160,DA)
 G EXIT:$D(Y)
 S FC=$P($G(^ONCO(160,D0,1)),U,6)
 I FC="" W !!?2,"You need to designate a follow-up contact before printing a follow-up letter." G LC
 D LET G SCL
 ;
LET ;Print follow-up letter (Also called from FA^ONCOFUL)
 I $D(ONCOC0) D
 .S DIE="^ONCO(160,",DR="15.1////^S X=ONCOC0" D ^DIE
 S ONCOC0=$P(^ONCO(160,ONCOD0,1),U,6)
 ;
TP S ONCTP=$P($G(^ONCO(165,ONCOC0,0)),U,2)
 K DIC
 S DIC="^ONCO(165.1,"
 S DIC(0)="AEMQZ"
 S DIC("A")="Select FOLLOW-UP FORM LETTER: "
 I (ONCTP=1)!(ONCTP=2)!(ONCTP=6) S DIC("S")="I $P(^(0),U,2)=ONCTP"
 I (ONCTP=3)!(ONCTP=5) S DIC("S")="I $P(^(0),U,2)=3"
 I ONCTP=4 S DIC("S")="I $P(^(0),U,2)>3"
 D ^DIC
 G:(Y=-1)!($D(DTOUT))!($D(DUOUT)) EXIT
 S ZZL=+Y
 S DIWF="^ONCO(165.1,"_ZZL_",1,"
 S DIWF(1)="160"
 S BY="NUMBER",(FR,TO)=ONCOD0
 W !
 K DIC D EN2^DIWF D ^%ZISC D HOME^%ZIS
 Q
 ;
EXIT ;Exit
 K DIC,DA,ONCOD0,ONCOC0,DIE,DR,FC,ONCTP,ZZL,DIWF,BY,FR,TO
 Q
