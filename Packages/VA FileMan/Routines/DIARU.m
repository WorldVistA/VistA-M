DIARU ;SFISC/TKW-ARCHIVING FUNCTIONS (CONT) ;2/18/93  5:21 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
UPDATE ;UPDATE ARCHIVING FILE (DJ=#ITEMS SELECTED) called w/in DIO4
 N DIE D:DIAR=3 NOW^%DTC S DA=DIARC,DIE="^DIAR(1.11,",X=""
 S:DIAR&(DIAR'=3) X="7////"_DIAR_";"
 S X=X_"13////@;14////@;15////@"
 I DIAR=1 S X=X_";4////"_DT_$S($D(^VA(200)):";8////"_DUZ,1:"")_";6////"_DJ
 I DIAR=3 S X=X_";12////"_%
 I DIAR=4!(DIAR=5)!(DIAR=6) S X=X_$S($D(^VA(200)):";5////"_DUZ,1:"")_";10////"_DT
 ;I DIAR=3!(DIAR=4),U'[DIARP S %=$P(DIARP,U,2),X=X_";3////"_$S(%:%,1:+DIARP)
 I DIAR=90 S X=X_$S($D(^VA(200)):";9////"_DUZ,1:"")_";11////"_DT
 S DR=X,DA=DIARC D ^DIE S DV=""
 Q
 ;
FILE ;LOOKUP ARCHIVING ACTIVITY
 K DIC S DIC(0)="AEQIMZ",DIC="^DIAR(1.11,",DIC("S")="I $P(^(0),U,8)<90"_$S($D(DIAX):",$P(^(0),U,17)",1:",'+$P(^(0),U,17)"),DIC("A")="Select "_$S($D(DIAX):"EXTRACT",1:"ARCHIVAL")_" ACTIVITY: "
 D ^DIC Q:Y<0!$D(DUOUT)!$D(DTOUT)
 I $P(Y(0),U,14) D ER1 Q
 S DIARC=+Y,DIARF=$P(Y(0),U,2),DIARU=$P(Y(0),U,3),DIARP=$P(Y(0),U,4),DIARST=$P(Y(0),U,8) S:$D(DIAX) DIAXFNO=+$P(Y(0),U,18)
 I DIAR'=99,'DIARU W !!,$C(7),"No selection template used for this ARCHIVING ACTIVITY--CANCEL it!" K DIARC Q
 I (DIAR=2!(DIAR=4)),DIARST>2 D ER2 K DIARC Q
 I DIAR=5 W:DIARST=5 $C(7),!!,"This data has already been moved to permanent storage once !!",! I DIARST<4 D ER3 K DIARC Q
 I DIAR=6,DIARST=6 W !!,$C(7),"This data has already been moved to the destination file!",!,"PURGE data or CANCEL this extract activity." K DIARC Q
 I DIAR=90,$S($D(DIAX):DIARST'=6,1:DIARST'=5) D ER4 K DIARC Q
 I DIAR=99 D:DIARST=5 MSG I DIARST>6 D ER5 K DIARC Q
 S DIARF2=$S($D(^DIAR(1.11,+Y,1)):^(1),1:DIARF)
 S DIARX=Y(0) D:DIAR'=3 MRK S Y(0)=DIARX,DIC=$G(^DIC(+DIARF,0,"GL")) I DIC="" D ER6 S DIK="^DIAR(1.11,",DA=DIARC D ^DIK K DIK,DIARC Q
 Q
 ;
MRK ;SET FIELDS TO LOCK OUT OTHER USERS DURING ARCHIVING ACTIVITY
 D NOW^%DTC S DIE="^DIAR(1.11,",DA=DIARC,DR="13////"_DIAR_";14////"_%_";15////"_DUZ D ^DIE
 Q
 ;
ER1 W $C(7),!!!,"The following Archival Activity is in progress--no access allowed!",!
 S DIARX=Y(0),Y=$P(Y(0),U,14),C=$P(^DD(1.11,13,0),U,2) D Y^DIQ W Y_"     STARTED: " S Y=$P(DIARX,U,15) X:Y ^DD("DD") W Y_"    BY: " W:$S($D(^VA(200,+$P(DIARX,U,16),0)):1,1:$D(^DIC(3,+$P(DIARX,U,16),0))) $P(^(0),U,1) W ! Q
ER2 I $D(DIAX) W !!,$C(7),"Data has already been moved to the destination file.",!,"List cannot be edited." Q
 W !!,$C(7),"This data has already been archived to "_$S(DIARST=4:"temporary",1:"permanent")_" storage" W:DIARST>5 " and purged" W ".",! W:DIAR=2 "List cannot be edited after data has been archived!" Q
ER3 W !!,$C(7),"Cannot write to permanent storage until data has been written",!,"to temporary storage!!" Q
ER4 W !!,$C(7),$S(DIARST>6:"Data ALREADY purged",$D(DIAX):"Data has NOT YET been moved to the destination file",1:"Data has NOT YET been archived to PERMANENT storage"),"!",! Q
ER5 W !!,$C(7),"Cannot cancel archiving record after archiving has been complete--this now",!,"acts as your history!!" Q
ER6 W !!,$C(7),"Source File is missing!",!,"I AM DELETING THIS ",$S($D(DIAX):"EXTRACT",1:"ARCHIVING")," ACTIVITY!" Q
MSG W !!,$C(7),"Just a reminder--you have already archived these records to permanent storage.",!,"You probably won't want to save the sequential storage media since you",!,"are cancelling this archiving activity!!",! Q
