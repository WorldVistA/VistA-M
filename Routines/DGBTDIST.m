DGBTDIST ;ALB/SCK-BENEFICIARY TRAVEL DEPARTURE CITY DISTANCE ENTER/EDIT;1/21/93  2/1/93 4/26/93
 ;;1.0;Beneficiary Travel;;September 25, 2001
 Q
START ;
 N DGBTMDIV,DGBTDIV,XX,DA,DO,X,NEWDIV,CITY
 D HOME^%ZIS W @IOF
 D WAIT^DICD,STCHK^DGBTSRCH
 I '$$CHECKS^DGBTDST1 W !,"No Problems were found in the Distance Data."
 E  G:'$$FIX CLEAR
CLEAR ; set division and whether multi or single instit.
 S DGBTMDIV=+$P($G(^DG(43,1,"GL")),U,2),NEWDIV=0,DGBTDIV=+$P($G(^DG(43,1,"GL")),U,3),ERR=0
LKUP ; lookup departure city using DIR reader for input and DIC call for lookup
 D HEADER
 K DIR S DIR(0)="FO^1:30",DIR("A",1)="",DIR("A")="Enter Departure City",DIR("?",1)="Enter the name for the departure city",DIR("?")="Name must be free text, 1-30 characters in length"
 D ^DIR K DIR G:$D(DIRUT) EXIT S (CITY,X)=Y
 L +^DGBT(392.1):3 I '$T W !?5,*7,"FILE IN USE, PLEASE TRY AGAIN LATER" G EXIT
 S DIC="^DGBT(392.1,",DIC(0)="ELQMZ",DLAYGO="392",DIC("DR")="" D ^DIC K DIC,DLAYGO L -^DGBT(392.1) S (REC,DA)=+Y G:$D(DTOUT)!($D(DUOUT)) EXIT
 S:$P(Y,U,3)=1 NEWDIV=1 G:X["?"!(+Y'>0) LKUP
 G:$$ADDIT CLEAR
DIS ; check to add additional divisions
 I DGBTMDIV F XX=2:1 Q:'$$NEXTDV  D DIV
 G CLEAR
EXIT ;
 K REC,Y,DTOUT,DUOUT,DIRUT,DR,NEWDIV,DGBTMDIV,CITY,DGBTDIV,ERR,%,DIC,DIR
 Q
 ;
NEXTDV() ;
 N Y
 S DIR("A")="Enter another division for this departure city",DIR("B")="YES"
 S DIR(0)="YO",DIR("?")="Enter a 'Y'es to add or enter another division, or 'N'o to exit to the Departure City prompt"
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) S Y=0
NEXTDIQ Q (+Y)
 ;
ADDIT() ; enter data for new city and create 1st division
 N ERR
 S DIE="^DGBT(392.1,",DA=REC,DR=".01"_"CITY OR TOWN"_";2;4" D ^DIE I '$D(DA) S ERR=1 G ADDQ
 I X="",$P($G(^DGBT(392.1,DA,0)),U,2)']""&($P($G(^DGBT(392.1,DA,0)),U,4)']"") D DELETE S ERR=1 G ADDQ
 I $D(DTOUT)!($D(Y))!('$D(DA)) S ERR=1 G ADDQ
 D MILES ; print default mileage message
 S DR=$S(NEWDIV:"100///"_DGBTDIV,1:"100")
 S DR(2,392.1001)="I 'DGBTMDIV S Y=""@2"";.01;@2;2;3;4//"_"NO"_";I X=""""!(X=0) S Y=""@1"";5;@1" D ^DIE K DIE
 D DEFMILE L -^DGBT(392.1) ; check 1st div mile vs default miles
ADDQ Q ($D(ERR))
 ;
MILES ; print default mileage message
 W:DGBTMDIV&(NEWDIV) !!?10,*7,"THE MILEAGE FOR THE SELECTED DIVISION WILL BE USED AS THE",!?10,"DEFAULT MILEAGE FOR THIS DEPARTURE CITY.",!!
 Q
DEFMILE ; compare city's default mileage vs. 1st divisions mileage, update if necessary
 I $P($G(^DGBT(392.1,REC,0)),U,3)'=$P($G(^DGBT(392.1,REC,1,1,0)),U,2) D
 . S DIE="^DGBT(392.1,",DA=REC,DR="3///^S X=+$P($G(^DGBT(392.1,DA,1,1,0)),U,2)" D ^DIE K DIE
 Q
DIV ; add additional divisions to existing city
 L +^DGBT(392.1):3 I '$T W !?5,*7,"FILE IN USE, PLEASE TRY AGAIN LATER" G EXIT
 S DIE="^DGBT(392.1,",DA=REC,DO=XX,DR="100",DR(2,392.1001)=".01;2;3;4//"_"NO"_";I X=""""!(X=0) S Y=""@1"";5;@1" D ^DIE K DIE
 L -^DGBT(392.1)
 Q
HEADER ;
 W !!,"Enter the CITY as the point of origin.  The MILEAGE/ONE-WAY",!,"is the distance from the CITY to the Medical Center Division.",!
 Q
 ;
DELETE ;
 W !!?5,*7,"INCOMPLETE INFORMATION WAS ENTERED, BOTH THE STATE AND ZIP CODE",!?5,"ARE REQUIRED, RECORD DELETED",!
 K DIE S DIK="^DGBT(392.1,",DA=REC D ^DIK K DIK S ERR=1
 Q
FIX() ;
 W !,"You can either correct these problems, or add a new departure city."
 W !,"CORRECT PROBLEMS"
 D:$$YESNO^DGBTSRCH=1 START^DGBTSRCH
 Q (+%)
