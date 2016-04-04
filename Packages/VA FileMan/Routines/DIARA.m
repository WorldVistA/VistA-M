DIARA ;SFISC/TKW,WISC/CAP-ARCHIVING FUNCTIONS (CONT) ;22SEP2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1006**
 ;
ENTD ; PURGE
 W:'$D(DIAX) !!,$C(7),$C(7),"BEFORE YOU PURGE, MAKE SURE THAT YOUR ARCHIVE MEDIUM IS READABLE!",!,"YOU MAY USE THE FIND ARCHIVED ENTRIES OPTION TO FIND THE LAST",!,"ARCHIVED RECORD APPEARING ON THE INDEX.",!
 K DIR S DIR(0)="Y",DIR("A")="Do you want to proceed",DIR("B")="NO" D ^DIR Q:$D(DUOUT)!$D(DTOUT)!($G(Y)'=1)
 D FILE^DIARU G Q:'$D(DIARC)
 I $D(^DD(DIARF,0,"PT")) W !!,$C(7),"The records about to be purged should not be 'pointed to' by other records to",!,"maintain database integrity."
 W ! K DIR S DIR(0)="Y",DIR("A",1)="This option will DELETE DATA from both "_$P(^DIC(DIARF,0),U),DIR("A",2)="and from the ARCHIVAL ACTIVITY file.",DIR("A")="Are you sure you want to continue",DIR("B")="NO"
 D ^DIR G UNLK:$D(DUOUT)!$D(DTOUT)!($G(Y)'=1)
 S DIFILE=DIARF,DIAC="DEL" D ^DIAC I '% W !,$C(7),"Sorry, you cannot purge this archival activity!",!,"You do not have DELETE access to ",$P(^DIC(DIARF,0),U),"." G UNLK
 W !!,"The entries will be deleted in INTERNAL NUMBER order."
 S DIARS="" F K="ID","SP" F I=0:0 S I=$O(^DD(DIARF,0,K,I)) Q:+I'=I  I $D(^DD(DIARF,I,0))#2 S X=$P(^(0),U,4) I $P(X,";")=0 S DIARS=DIARS_$P(X,";",2)_U
D0 S DA=$O(^DIBT(DIARU,1,0))
 I DA="" W !!,"<< ",$P(^DIAR(1.11,DIARC,0),U,7)," ENTRIES PURGED >>" K ^("D"),^("EX") D UPDATE^DIARU G Q
 S DIK=DIC,DIARS(0)=$S($D(@(DIC_"DA,0)")):^(0),1:"") K ^DIBT(DIARU,1,DA)
 I DIARS(0)="" S Y=$P(^DIAR(1.11,DIARC,0),U,7),$P(^(0),U,7)=Y-1 G D0
 D ^DIK G D0:DIARF'=DIARF2 S Y=DIARS(0),X=$P(Y,U)
D F I=1:1 Q:$P($G(DIARS),U,I)=""  S %=$P(DIARS,U,I),$P(X,U,%)=$P(Y,U,%)
E G D0
 ;
ENTC ;CANCEL
 S DIC("A")="CANCEL WHICH "_$S($D(DIAX):"EXTRACT",1:"ARCHIVING")_" SELECTION: " D FILE^DIARU G Q:'$D(DIARC)
 S DIR("A")="Are you sure you want to CANCEL this "_$S($D(DIAX):"EXTRACT",1:"ARCHIVING")_" ACTIVITY",DIR("B")="NO",DIR(0)="Y"
 S DIR("??")="^W !!?5,""Enter YES to stop this activity and start again from the beginning."""
 D ^DIR G UNLK:$D(DUOUT)!$D(DTOUT),UNLK:'Y
 F I=0:0 S I=$O(^DIBT(+DIARU,1,I)) Q:'I  K @(DIC_I_",-9)")
 I $D(DIAX) S DIAXNRB=0 I DIARST=6,$D(^DIAR(1.11,DIARC,"EX")) D ASK^DIARB G UNLK:$D(DUOUT)!$D(DTOUT) I 'DIAXNRB,$D(^DIAR(1.11,DIARC,"EX")) S DIK=^DIC(DIAXFNO,0,"GL"),DA=0,DIOVRD=1 F  S DA=$O(^DIAR(1.11,DIARC,"EX","B",DA)) Q:DA'>0  D ^DIK
 S DIK="^DIAR(1.11,",DA=DIARC D ^DIK W !!,">>> DONE <<<"
 G Q
 ;
OUT ;USED TO PRINT LISTING OR TO WRITE TO TEMP.STORAGE
 K DIARC,FLDS D FILE^DIARU G Q:'$D(DIARC)
 S DIARD=0 W !!
 D @DIAR
 I DIAR'=3 K DIARP S DIE="^DIAR(1.11,",DA=DIARC,DR="3;S DIARP=X" D ^DIE G UNLK:$D(DTOUT)!'$D(DIARP) S FLDS="[`"_DIARP_"]"
 S FR="",TO="",L=0 K DIOEND S:(DIAR'=3) DIOEND="W !,$P(^DIAR(1.11,DIARC,0),U,7)"_","""_" ITEMS HAVE BEEN "_$S($D(DIAX):"EXTRACTED",1:"ARCHIVED")_"""",DISTOP=0
 K DIE,DR,DA S BY="[`"_DIARU_"]",DIARI=DIARU S:DIAR=3 BY=BY_",.01"
 S DHD=$P(^DIC(DIARF,0),U)_$S($D(DIAX):" EXTRACT",1:" ARCHIVING")_" ACTIVITY",DIC=^(0,"GL")
 F %=0:0 S %=$O(^DIAR(1.11,DIARC,"S",%)) Q:%'>0  S DIFG(+DIARF2,^(%,0))=^(1)
 S %=$O(DIFG(+DIARF2,"")) K:%="" DIFG
 I $D(DIFG) S DIFG(+DIARF2,"S")="X DIFG("_+DIARF2_","_%_")"
 D EN1^DIP
 I DIAR'=3,$G(POP) G UNLK
 G Q
UNLK S DIAR="" D UPDATE^DIARU
Q K POP G Q^DIARB
 ;
3 W "Enter regular Print Template name or fields you wish to see printed on this",!,"report of entries to be "_$S($D(DIAX):"extracted.",1:"archived.") Q
4 W "You MUST enter a FILEGRAM template name.  This FILEGRAM template will be used",!,"to actually build the archive message." Q
