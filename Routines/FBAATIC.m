FBAATIC ;AISC/CMR-TERMINATE ID CARD ;15 APR 1993
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D SITEP^FBAAUTL G Q:FBPOP S FBPROG="I $P(^(0),U,3)=2"
RD W ! S DIC="^DPT(",DIC(0)="QEAZM" D ^DIC K DIC G Q:Y<0 S DFN=+Y
 I $P($G(^FBAAA(DFN,4)),"^")']"" W !!,"There is no FEE ID Card information on file for this patient!" G Q
 D ^FBAADEM
 S HID=$P(^FBAAA(DFN,4),"^"),NIDR=$P(^(4),"^",3) W !!,"Fee ID Card #: ",HID,!
 S DIR(0)="Y",DIR("A")="Are you sure you want to terminate this ID Card",DIR("B")="No" D ^DIR K DIR G Q:$D(DIRUT),RD:'Y
 S DA=DFN,DIE="^FBAAA(",DR=".5////^S X=""@"";.65///^S X=""T"";.7TERMINATION REASON~;S NIDR=X",DIE("NO^")="" D ^DIE K DIE
 D TRIG^FBAAAUT
 G RD
Q K Y,DFN,FBPOP,HID,NIDR,DA,FBSITE,X,FBAAOUT,DR,FBAUT,FBPROG,TIME,NID
 Q
