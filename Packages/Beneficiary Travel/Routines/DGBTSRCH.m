DGBTSRCH ;ALB/SCK - SEARCH ROUTINE FOR INCOMPLETE DATA IN bt DISTANCE FILE;2/4/93  4/22/93
 ;;1.0;Beneficiary Travel;;September 25, 2001
 Q
START ;
 K DIR D HOME^%ZIS W @IOF
START2 ;
 W !!!?5,"List the Incomplete data found in the Beneficiary Distance File",!?5,"Any incomplete data should be corrected as soon as possible"
 S OPT=$$OPTION G:$D(DIRUT) EXIT
 S OPT=$S(Y=1:"REMARKS",Y=2:"ZIP",Y=3:"MILES",1:"") G:OPT']"" EXIT
 L +^DGBT(392.1):3 I '$T W !!?5,*7,"File not available, Please try later..." G EXIT
 D @OPT L -^DGBT(392.1) G START2
EXIT ;
 L -^DGBT(392.1)
 K II,DIR,TO,FLDS,DHD,L,FR,OPT,X,Y,DR,DIRUT,DIS,DIC,BY,DA,DIS,DIOEND
 Q
REMARKS ;  list cities and divisions with the additional information field set true
 I $$REPORT=1 D
 . K DIC S DIC="^DGBT(392.1,",DIC(0)="EMZ",L=0,BY="[DGBT REMARKS]",FLDS="[DGBT REMARKS]",DHD="Incomplete Additional Information Remarks in the Beneficiary Travel Distance FIle",DIOEND="D FTR^DGBTSRCH"
 . D EN1^DIP K DIC
 W !!,"Do you wish to update any Remark fields" Q:$$YESNO'=1
REMARK1 ;  loop to complete remarks field
 D SETUP S DIR(0)="FO^1:30" D ^DIR Q:$D(DIRUT)  S X=Y K DIR D ^DIC Q:+Y'>0  S DA=+Y,DIE="^DGBT(392.1,",DR="100",DR(2,392.1001)="5" D ^DIE K DIE
 G REMARK1
 Q
ZIP ; list cities with missing zip codes, screen on fields that don't match 5N
 I $$REPORT=1 D
 . K DIC S DIC="^DGBT(392.1,",DIC(0)="EMZ",L=0,DIS(0)="I +$P($G(^DGBT(392.1,D0,0)),U,4)'>0",BY=".01",FLDS="[DGBT ZIP]",(FR,TO)=""
 .S DHD="Incomplete zip code information in the Beneficiary Travel Distance File",DIOEND="D FTR^DGBTSRCH"
 . D EN1^DIP K DIC
 W !!,"Do you wish to update Zip Codes" Q:$$YESNO'=1
ZIP1 ; loop to add zip codes
 D SETUP D ^DIR Q:$D(DIRUT)  S X=Y K DIR D ^DIC Q:+Y'>0  S DA=+Y,DIE="^DGBT(392.1,",DR="[DGBT ZIP]" D ^DIE K DIE
 G ZIP1
 Q
MILES ;  list those cities that have a null default mileage
 I $$REPORT=1 D
 . K DIC S DIC="^DGBT(392.1,",DIC(0)="EMZ",L=0,DIS(1)="I +$P($G(^DGBT(392.1,D0,0)),U,3)'>0",BY=".01",FLDS="[DGBT MILES]",(FR,TO)=""
 . S DHD="Incomplete mileage information",DIOEND="D FTR^DGBTSRCH"
 . D EN1^DIP K DIC
 W !!,"Do you wish to update Mileage data" Q:$$YESNO'=1
MILES1 ; add/edit default mileage and division mileage
 D SETUP D ^DIR Q:$D(DIRUT)  S X=Y K DIR D ^DIC Q:+Y'>0  S DA=+Y,DIE="^DGBT(392.1,",DR="[DGBT MILES]" D ^DIE K DIE
 G MILES1
 Q
STCHK ;
 S STREC="",DIE="^DGBT(392.1,",DR="2",STERR=0
 F STREC=0:0 S STREC=$O(^DGBT(392.1,STREC)) Q:+STREC'>0  I $P($G(^DGBT(392.1,STREC,0)),U,2)']"" S STATE(STERR)=STREC,STERR=STERR+1
 I STERR>0 W !!?5,*7,">> YOU HAVE ",STERR," ERROR(S) IN YOUR STATE IDENTIFIERS,",!?5,"THESE MUST BE CORRECTED BEFORE CONTINUING",! D
 . F XX=0:1:STREC S DA=STATE(XX) W !,"City Name: ",$P($G(^DGBT(392.1,DA,0)),U,1)
 . D ^DIE
 K DIE,STATE,STREC,STERR,XX
 Q
YESNO() ;
YN1 S %=2 D YN^DICN I %=0 W !,"Enter either YES or NO, '^' to Exit." G YN1
 Q (+%)
SETUP ;  setup common variables for lookup and edit
 S DIC="^DGBT(392.1,",(FR,TO)="",L=0,DIC(0)="EMZ",DIR(0)="FO^1:30",DIR("A")="ENTER NAME OF CITY TO CORRECT"
 S DIR("?")="Enter the name of the city you wish to lookup, 1 to 30 characters in length"
 Q
OPTION() ;   menu options in text form.
 S X="SO^"
 S X=X_"1:Additional Information Fields Marked;"
 S X=X_"2:Missing Zip Codes;"
 S X=X_"3:No Default or Division Mileages"
 S DIR(0)=X,DIR("A")="Enter Option or [RETURN] to continue",DIR("?")="Enter the desired menu option mumber or either '^' or [RETURN] to add departure city"
 D ^DIR K DIR
 Q (+Y)
REPORT() ;  ask yes no to do report
 W !!?5,"Print Report"
RP1 S %=1 D YN^DICN I %=0 W !?5,"Enter 'Y'es or 'N'o" G RP1
 Q (+%)
 ;
FTR ;
 W !!?5,"NOTE:",!?5,"If no data prints, then no problems were found"
 W !?5,"in the Distance file.",!
 Q
