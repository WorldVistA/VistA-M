ANRVLET ;MUSK/MFW - EDIT,PRINT VIST LETTERS ; 22 Jun 93 / 9:20 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
 ;These letters are stored in file 2043 and is called by menu
 ;'Letter Menu'.
EDIT ;------ Edit Form Letter ------
 N DIC,DLAYGO,DIE,DA,DR
 S DIC="^ANRV(2043,",DIC(0)="AEQML",DLAYGO=2043
 D ^DIC Q:Y<0  S DA=+Y
 S DIE=DIC,DR="[ANRV EDIT LETTER]" D ^DIE G EDIT
 ;-----------------------------------------------------------------------
PRINT ;------ Entry Point to Print Form Letter ------
 N ANRVLT,ANRVPT,BY,DFN,DIRUT,DIS,DTOUT,DUOUT,FR,TO
 D GETLET G:$D(DIRUT) EXIT
 D GETDFN G:$D(DIRUT) EXIT
 S DIWF="^ANRV(2043,"_ANRVLT_",1,"
 S DIWF(1)=2040
 I ANRVRQP S DIS(0)="I $P($G(^(13)),U,2)'=""I"""
 S BY=".01" S:ANRVPT BY="NUMBER",(FR,TO)=ANRVPT
 D EN2^DIWF
EXIT ;
 Q
GETLET ;------ Select Letter to Print ------
 N DIR,X,Y
 S DIR(0)="P^2043:AEMQ",DIR("A")="Select Form Letter to Print"
 D ^DIR Q:$D(DIRUT)  S ANRVLT=+Y,ANRVRQP=$P(^ANRV(2043,+Y,0),U,2) S:ANRVRQP="" ANRVRQP=1
 Q
GETDFN ;------ Select VIST Patient ------
 N DIR,X,Y
 I 'ANRVRQP S ANRVPT=$O(^ANRV(2040,0)) Q
 S DIR(0)="PO^2040:AEQM",DIR("A")="Select Patient"
 S DIR("A",1)="If you wish to print a letter for a single patient"
 D ^DIR I $D(DUOUT)!($D(DTOUT)) S DIRUT=1 Q
 S (ANRVPT,DFN)="" I $D(DIRUT) K DIRUT Q
 S ANRVPT=+Y,DFN=+^ANRV(2040,ANRVPT,0)
 Q
