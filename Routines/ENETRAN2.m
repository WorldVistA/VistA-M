ENETRAN2 ;(WIRMFO)/DH-Transfer Electronic Work Orders ;5/8/1998
 ;;7.0;ENGINEERING;**35,53**;Aug 17, 1993
 ;Expects DA
EN S ENXP=1 D D^ENWOD K ENXP W !!,"Ready to transfer ",$P(^ENG(6920,DA,0),U,1) I $D(^(1)) W ?35,$P(^(1),U,2)
LOCK L +^ENG(6920,DA):5 I '$T W !,*7,"Sorry, this Work Order is being edited by another user. Try later." G ABORT
 S DIC="^DIC(6922,",DIC(0)="AEMQ"
 S DIC("A")="Transfer to shop ('^'to EXIT, '^D' to DISAPPROVE): "
 S DIC("W")="W ?60,Y"
 S:$D(ENEWKEY) DIC("B")=ENEWKEY
 ; set screen to prevent selection of current shop
 I $P($G(^ENG(6920,DA,2)),U)]"" S DIC("S")="I Y'="_$P(^ENG(6920,DA,2),U)
 D ^DIC K DIC("A"),DIC("B"),DIC("S")
 G:X="^D" DISAP G:+Y'>0 ABORT S ENEWKEY=+Y
GETNO I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
 N CODE,NUMBER
 S CODE=$P(^DIC(6922,ENEWKEY,0),U,2)_$E(DT,2,7)_"-"
 L +^ENG(6920,"B"):20 I '$T W !!,*7,"Can't get a new number." G ABORT
 F I=1:1 S X=CODE_$S(I<10:"00"_I,I<100:"0"_I,1:I) I '$D(^ENG(6920,"B",X)),'$D(^ENG(6920,"H",X)) S NUMBER=X Q
 S DIE="^ENG(6920,",DR="9///"_ENEWKEY_";.01///"_NUMBER_";10///TODAY"
 D ^DIE
 L -^ENG(6920,"B")
 I ENERN'="ALL" K ^TMP($J,"ENEWO",ENERN),^TMP($J,DA) S ENCNT=ENCNT-1
 S DR=$S($D(^DIE("B","ENZWOWARDXFER")):"[ENZ",1:"[EN")_"WOWARDXFER]"
EDIT W !!,"Edit this work order" S %=1 D YN^DICN G:%<1 EDIT
 I %=1 D ^DIE
 I "^^2^"[(U_$P($G(^ENG(6920,DA,4)),U,3)_U) S DR="32///IN PROGRESS" D ^DIE ; set status to 'in progress' when blank or 'pending' (may result in bulletin)
PRINT N WARD,SHOPKEY S WARD=0,SHOPKEY=ENEWKEY
 D WOPRNT^ENWONEW
 G EXIT
 ;
DISAP S DIE="^ENG(6920," D EN1^ENWO2 K ^TMP($J,"ENEWO",ENERN),^TMP($J,DA) S ENCNT=ENCNT-1
 G EXIT
 ;
ABORT W !,*7,"Transfer aborted."
 W !!,"Press <RETURN> to continue, '^' to escape... " R X:DTIME
 S:$E(X)="^" ENEX4=1
EXIT ;Return to ENETRAN1
 L -^ENG(6920,DA)
 Q
 ;ENETRAN2
