DGBTEF1 ;ALB/SCK - BENEFICIARY TRAVEL UPDATE PARAMETERS INTO FILES ;12/14/92 3/12/93
 ;;1.0;Beneficiary Travel;**2,14**;September 25, 2001;Build 7
RATES ;enter/edit bene travel parameters;option DGBT BENE TRAVEL RATES
 S DA=1,DR="720;723;721",DIE="^DG(43," D ^DIE G QUIT:X="^"!($D(DTOUT))!($D(Y)) K DA,DE,DQ,DR,DIE
 Q  ;This Q was added under direction of CBO to remove site's ability to edit rates
 W !!,"New travel rates are determined each fiscal year.  The rates should be",!,"entered each year with the effective date of Oct 1.",!
 W !,"Changing values for the current or past fiscal years could result in changes",!,"to the claims already entered.",!
DATE ;  change deductible rates for FY
 Q  ;This Q was added under direction of CBO to remove site's ability to edit rates
 S DIR("A")="Select EFFECTIVE DATE",DIR(0)="DO^^E",DIR("?")="^D HELP1^DGBTEF1"
 D ^DIR K DIR G QUIT:$D(DIRUT) G HELP:$E(Y,4,7)'="1001" S X=+Y
 S DIC="^DG(43.1,",DIC(0)="ELQMZ"
 D ^DIC G QUIT:Y'>0 S DA=+Y
 S DGBTN=$S('$D(^DG(43.1,DA,"BT")):"",1:^DG(43.1,DA,"BT"))
 S:$D(DGBTN)&($P(DGBTN,"^")]"") DIR("B")=$P(DGBTN,"^")
 S DGBTDEDV=$$DEDUCT(6,"VISIT") G:DGBTDEDV<0 QUIT1
 S DIE="^DG(43.1,",DR="30.01///^S X=DGBTDEDV"
 D ^DIE
 S:$D(DGBTN)&($P(DGBTN,"^",2)]"") DIR("B")=$P(DGBTN,"^",2)
 S DGBTDEDM=$$DEDUCT(18,"MONTH") G:DGBTDEDM<0 QUIT1
 S DIE="^DG(43.1,",DR="30.02///^S X=DGBTDEDM"
 D ^DIE
 S DR="30.03;30.05;30.04",DIE="^DG(43.1,"
 D ^DIE G QUIT1
ACCT ;  change activation/inactivation dates for accounts
 W !!,"ACCOUNT TYPES are determined by Fiscal Service and have a direct impact",!,"on the type of questions asked in the Beneficiary Travel CLAIM ENTER/EDIT",!,"option."
 W !,"DO NOT add to this file unless so instructed by Fiscal Service.",!
TYPE ;  select account to edit
 S DIR("A")="Select ACCOUNT",DIR("?")="^D HELP2^DGBTEF1",DIR(0)="FO"
 D ^DIR K DIR G QUIT:$D(DIRUT) S X=Y
 S DIC="^DGBT(392.3,",DIC(0)="ELQMZ"
 D ^DIC G TYPE:Y'>0
 S DA=+Y,DR="2:4",DIE="^DGBT(392.3," D ^DIE G TYPE
NWACT ;enter/edit account file (392.3);option DGBT BENE TRAVEL ACCOUNT
 W !!?3,"You are about to enter/edit Bene Travel account types.  Although",!?3,"this process is now decentralized, changes and additions should be",!?3,"made with extreme care.",!
 S DIR(0)="Y",DIR("A")="Are you sure you wish to continue",DIR("B")="No" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!('Y) G QUIT1
ED ;  edit data for new account
 W ! K X,DA
 S (DIE,DIC)="^DGBT(392.3,",DIC(0)="AEQLMZ",DLAYGO=392.3,DIC("DR")=""
 D ^DIC K DIC G:$D(DTOUT)!$D(DUOUT)!(X="") QUIT1 G:Y'>0 ED
 S DR="2///"_$P(Y(0)," ",1)_";3;4;5" ; account number now stuffed, not asked
 S DA=+Y L ^DGBT(392.3,DA):2 E  W !?5,"Another user is editing this entry.",*7 G ED
 S DIE("NO^")=1
 D ^DIE L  K DR,DIE,DIE("NO^")
 W ! S DIR(0)="Y",DIR("A")="Would you like to Enter/Edit another ACCOUNT",DIR("B")="Yes"
 D ^DIR K DIR G:$D(DTOUT)!($D(DUOUT))!(Y=0) QUIT1 G ED
QUIT1 ;
 K DIR,DTOUT,DI,D0,DUOUT,DIRUT,DGBTN,DGBTDEDV,DGBTDEDM
QUIT ;
 K %DT,DA,DIC,DIE,DIE("NO^"),DR,X,Y Q
DEDUCT(LIMIT,TYPE) ;  enter new deductble value
DEDCT1 S DIR(0)="FAO",DIR("A")="ENTER DEDUCTIBLE AMOUNT/"_TYPE_": "
 S DIR("?")="Type a dollar amount between 0 and "_LIMIT_" with up to 2 decimal places."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT))!(Y']"") S Y=-1 G DEDUCTQ
 S:Y["$" Y=$P(Y,"$",2)
 I Y'?.N,Y'?.N1".".N K X,Y,DIR G DEDCT1
 I Y>(LIMIT+.001) W "  -- Deductible exceeds limit." K X,Y,DIR G DEDCT1
DEDUCTQ Q (+Y)
 ;
HELP W !!,"The effective date must start on the fiscal year, Oct 1.",! G DATE
HELP1 S DIC="^DG(43.1,",DIC(0)="QMZ",X="?" D ^DIC K DIC Q
HELP2 S DIC="^DGBT(392.3,",DIC(0)="QMZ",X="?" D ^DIC K DIC Q
