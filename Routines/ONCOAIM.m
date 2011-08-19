ONCOAIM ;Hines OIFO/GWB - Create additional primaries for a patient ;06/23/10
 ;;2.11;ONCOLOGY;**1,5,6,25,27,36,37,44,45,46,51**;Mar 07, 1995;Build 65
 ;
EN ;Add additional primaries for patient
 D KILL
 W @IOF
 W !!?5,"******** ADD PRIMARY RECORD FOR THIS PATIENT********",!!
 W:$D(ONCONM) ?5,"PATIENT: ",ONCONM
 ;
 ;Get next ACESSION NUMBER (165.5,.05)/SEQUENCE NUMBER (165.5,.06)
 ;Loop thru 165.5 "D" cross-reference
 ;Set up 2 ^TMP arrays: 1 for malignants, 1 for benigns
 S (KKM,KKB)=0,AC=$P(ONCOP,U,5),ACN=$E(AC,1,4)_"-"_$E(AC,5,9),ACS=ACN
 F KK=1:1 S ACSL=ACS,ACS=$O(^ONCO(165.5,"D",ACS)) S SQN=$P(ACS,"/",2) D  Q:$P(ACS,"/")'=ACN
 .Q:$P(ACS,"/")'=ACN
 .S RECNUM=0
 .F LL=1:1 S RECNUM=$O(^ONCO(165.5,"D",ACS,RECNUM)) Q:RECNUM=""  D
 ..S PRIMIEN=$P(^ONCO(165.5,RECNUM,0),U)
 ..S PRIM=$P(^ONCO(164.2,PRIMIEN,0),U,1)
 ..S SEQDIV=$$GET1^DIQ(165.5,RECNUM,2000)
 ..I ((+SQN>0)&(+SQN<60))!(SQN="00")!(SQN=99) S KKM=KKM+1,^TMP($J,"MAL",KKM)=SQN_U_ACS_U_PRIM_U_RECNUM_U_SEQDIV
 ..E  S KKB=KKB+1,^TMP($J,"BEN",KKB)=SQN_U_ACS_U_PRIM_U_RECNUM_U_SEQDIV
 ;Find last malignant/benign (if any) and determine SEQUENCE NUMBER
 K LASTBEN,LASTMAL,NEXTBEN,NEXTMAL
 S ALPHA=0 F  S BEN=ALPHA,ALPHA=$O(^TMP($J,"BEN",ALPHA)) Q:ALPHA'>0
 S NUM=0 F  S MAL=NUM,NUM=$O(^TMP($J,"MAL",NUM)) Q:NUM'>0
 S LASTBEN=$P($G(^TMP($J,"BEN",BEN)),U,1)
 S LASTMAL=$P($G(^TMP($J,"MAL",MAL)),U,1)
 S NEXTBEN=$S(LASTBEN=60:62,LASTBEN'="":LASTBEN+1,1:60)
 S NEXTMAL=$S(LASTMAL'="":LASTMAL+1,1:"NULL")
 S NEXTMAL=$S(NEXTMAL=1!(NEXTMAL>99):2,NEXTMAL="NULL":"00^99",1:NEXTMAL)
 S NEXTMAL=$S($L(NEXTMAL)<2:"0"_NEXTMAL,1:NEXTMAL)
 ;
 W !!?5,"ACCESSION NUMBER: ",ACN
 ;
PROMPT ;SEQUENCE NUMBER (165.5,.06) prompt 
 N DEF,DIEN
 S DEF=$S(NEXTMAL["00":"00",1:NEXTMAL)
 K DIR S DIR(0)="F^2:2",DIR("A")="     SEQUENCE NUMBER.",DIR("B")=DEF
 S DIR("?")="Enter the next SEQUENCE NUMBER.  Enter ?? for additional HELP"
 S DIR("??")="^D HLP^ONCOAIM2" D ^DIR I "^^"[Y D KILL Q
 I (Y'?2N)!((Y>88)&(Y<99)) W "  Allowable Values: 00-88, 99" G PROMPT
 S DIEN=ACN_"/"_Y
 S SN=Y,SEQ=SN,AY=$E(DT,1)+17,AY=AY_$E(DT,2,3)
 I SN="02",$D(^TMP($J,"MAL",1)),$P(^TMP($J,"MAL",1),U,1)="00" D
 .S ACS=$P(^TMP($J,"MAL",1),U,2)
 .S REC00=$P(^TMP($J,"MAL",1),U,4)
 .W !!?5,"You are adding the second malignant or in-situ primary for this patient"
 .W !!?5,ACS," ","will be changed to ",ACN,"/01",!
 I SN="02",$D(^TMP($J,"MAL",2)),$P(^TMP($J,"MAL",2),U,1)'="01" D
 .S REC002=$P(^TMP($J,"MAL",2),U,4)
 I SN>59,SN<88,SN'=NEXTBEN W ?32,"Next Non-Malignant SEQUENCE NUMBER is",NEXTBEN G PROMPT
 I SN=62,$D(^TMP($J,"BEN",1)),$P(^TMP($J,"BEN",1),U)=60 D
 .S ACS=$P(^TMP($J,"BEN",1),U,2)
 .S REC00=$P(^TMP($J,"BEN",1),U,4)
 .W !!?5,"You are adding the second Non-Malignant primary for this patient"
 .W !!?5,ACS," ","will be changed to ",ACN,"/61",!
 ;
LOOK2 ;Select Primary Site
 K DIC
 S DIC="^ONCO(164.2,",DIC(0)="AEQM"
 S DIC("A")="     Select Primary 'SITE/GP': "
 S DIC("S")="I '$P(^(0),U,3)"
 D ^DIC K DIC G EX:Y<0
 S (XX,X,ONCOSIT)=+Y,ONCOPN=$P(Y,U,2),XD0=ONCOD0
 D SEX^ONCOCKI G LOOK2:'$D(X)
 K DIR
 S DIR("A")="     Ok to add:",DIR("B")="Y",DIR(0)="Y" D ^DIR
 G CR:Y,EN:Y=0 Q
 ;
CR ;Create Primary
 K DIC,DO,DTOUT
 W !,?5,"Creating another primary record for ",ONCONM_" "_ACN_"..."
 S DIC="^ONCO(165.5,",X=ONCOSIT,DIC(0)="Z"
 S DIC("DR")="2000////^S X=DUZ(2);236////^S X=DT"
 D FILE^DICN K DIC,X G EX:Y<0
 S ONCOD0P=+Y
 S $P(^ONCO(165.5,+Y,0),U,2)=ONCOD0,$P(^(7),U,2)=0
 S ^ONCO(165.5,"C",ONCOD0,ONCOD0P)=""
 S ACAY=$E(DT,1)+17_$E(DT,2,3)
 L +^ONCO(165.5,ONCOD0P,0):0
 S DIE="^ONCO(165.5,"
 S DR="W !;.05////^S X=AC;.06////^S X=SEQ;.07//^S X=ACAY"
 S ACN=AC_"/"_SEQ,DA=ONCOD0P
 D ^DIE
 L -^ONCO(165.5,ONCOD0P,0)
 G PID:$D(Y)=0 D KLN G EX
 ;
PID ;Continue defining Primary Record
 I SN="02",$D(^TMP($J,"MAL",1)),$P(^TMP($J,"MAL",1),U,1)="00" S UPDATE="01" D UPDT
 I SN=62,$D(^TMP($J,"BEN",1)),$P(^TMP($J,"BEN",1),U,1)=60 S UPDATE=61 D UPDT
 S ONCOACN=AC_"/"_SEQ,Y=1 D KILL Q
 ;
UPDT ;Update 00 to 01, update 60 to 61
 S SN=UPDATE,DIE="^ONCO(165.5,",DA=REC00,DR=".06///^S X=SN"
 D ^DIE S D0=ONCOD0P
 I $D(REC002) S SN=UPDATE,DIE="^ONCO(165.5,",DA=REC002,DR=".06///^S X=SN" D ^DIE S D0=ONCOD0P
 W !!?5,"The following up-dating has occurred:",!! D SDA^ONCOCOM H 2
 Q
 ;
KLN ;KILL entry
 S DA=ONCOD0P,DIK="^ONCO(165.5," D ^DIK,KILL
 R !?5,"<ENTRY DELETED> - press RETURN to continue->",DA:DTIME
 Q:'$T!(DA=U)
 W !
 Q
 ;
KILL ;KILL variables
 K AC,ACAY,ACN,ACS,ACSL,ALPHA,AY,BEN,DA,DIC,DIE,DIK,DIR,D0,DR,DTOUT
 K KK,KKM,KKB,LASTBEN,LASTMAL,LL,MAL,NEXTBEN,NEXTMAL,NUM,ONCOSIT
 K PRIM,PRIMIEN,REC00,REC002,RECNUM,SEQDIV,SN,SEQ,SQN,UPDATE,X,XD0,XX
 K ^TMP($J,"BEN"),^TMP($J,"MAL")
 Q
 ;
EX ;Exit
 D KILL S Y=0
 Q
 ;
CLEANUP ;Cleanup
 K ONCOACN,ONCOD0,ONCOD0P,ONCONM,ONCOP,ONCOPN,ONCOSIT,Y
