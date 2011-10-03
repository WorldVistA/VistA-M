GMRAPEM1 ;HIRMFO/YMP,RM,WAA-CHANGE OF OBSERVED DATA TO HISTORICAL STORAGE ;12/1/95  13:45
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
ENDING ;Display and edit the word processing field for a patient reaction.
 W @IOF,! D DISP,EDIT G EXIT
 Q
OUTPUT ;Display the word processing field for a patient.
 D DISP G EXIT
 Q
DISP S GMRAOUT=0
 F GMRAYY="O","V","E" D DISP1(GMRAPA,GMRAYY,.GMRAOUT) Q:GMRAOUT
 Q
DISP1(GMRAPA,GMRAKIND,GMRAOUT) ;Display comments and reaction for a reaction
 ; Input variables:
 ;     GMRAPA = Reaction IEN in 120.8
 ;   GMRAKIND = Kind of comment to display
 ;              O is Originator
 ;              V is Verifier
 ;              E is Entered in Error
 ;    GMRAOUT = Escape variable
 I '$D(^GMR(120.8,GMRAPA,26,"AVER",GMRAKIND)) Q
 W !!,?5,$S(GMRAKIND="O":"ORIGINATOR",GMRAKIND="V":"VERIFIER",GMRAKIND="E":"ENTERED IN ERROR",1:"")
 W !,?6,"COMMENTS:"
 S GMRAX=0 F  S GMRAX=$O(^GMR(120.8,GMRAPA,26,"AVER",GMRAKIND,GMRAX)) Q:GMRAX<1  D  Q:GMRAOUT
 .S GMRAY=$P(^GMR(120.8,GMRAPA,26,GMRAX,0),U),GMRAZ=$P(^(0),U,2)
 .D PRINT
 .Q
 Q
PRINT ;PRINT OUT THE DATA
 N GMRAT,GMRAZN S (GMRAZN,GMRAT)=""
 S:GMRAZ'="" GMRAZN=$P($G(^VA(200,GMRAZ,0)),U)
 S:GMRAZ'="" GMRAT=$P($G(^VA(200,GMRAZ,0)),U,9)
 S:GMRAT'="" GMRAT=$P($G(^DIC(3.1,GMRAT,0)),U)
 W !,?10,"Date: ",$$FMTE^XLFDT(GMRAY,1),?52,"User: ",GMRAZN
 W !,?51,"Title: ",GMRAT
 I '$D(^GMR(120.8,GMRAPA,26,GMRAX,2,0)) Q
 S DIWL=16,DIWR=75,DIWF=""
 K ^UTILITY($J,"W",DIWL)
 S GMRAXX=0 F  S GMRAXX=$O(^GMR(120.8,GMRAPA,26,GMRAX,2,GMRAXX)) Q:GMRAXX<1  S X=^(GMRAXX,0) D ^DIWP
 S GMRAXX=0 F  S GMRAXX=$O(^UTILITY($J,"W",DIWL,GMRAXX)) Q:GMRAXX<1  D:($Y+3)>IOSL HEAD Q:GMRAOUT  W !,?16,^UTILITY($J,"W",DIWL,GMRAXX,0)
 W !
 Q
HEAD ;print a header
 D EOP^GMRADSP3
 Q
EDIT ;Edit the word processing field.
 Q:GMRAOUT=2  S:'$D(GMRAVCM) GMRAVCM="O"
 S GMRAOUT=0 N GMRA
 I '$D(^GMR(120.8,GMRAPA,26,0)) S ^(0)="^120.826D^^"
 D NOW^%DTC S DIC="^GMR(120.8,"_GMRAPA_",26,",DA(1)=GMRAPA,DLAYGO=120.8,DIC(0)="L",X=% K DD,DO,DINUM D FILE^DICN K DLAYGO G EXIT:+Y'>0
 K DR S DA=+Y,DIE=DIC,DR="1////"_DUZ_";1.5////"_GMRAVCM_";2" K DIC D ^DIE
 I '$O(^GMR(120.8,DA(1),26,DA,2,0)) S DIK=DIE D ^DIK
EXIT ;Exit point.
 K GMRAVCM
 Q
