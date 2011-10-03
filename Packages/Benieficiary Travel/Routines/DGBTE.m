DGBTE ;ALB/SCK-BENEFICIARY TRAVEL SETUP/MAIN ENTRY CALL UP; 11/20/92@1000; 11/25/92
 ;;1.0;Beneficiary Travel;**2**;September 25, 2001
START ;
 D QUIT^DGBTEND ; kill all variables
 S PRCABN=1,IOP="HOME" D ^%ZIS K IOP
 S DGBTIME=300 S:'$D(DTIME) DTIME=DGBTIME S:'$D(U) U="^"
 ;   if date/time is undefined, set DT value
 I '$D(DT)#2 S %DT="",S="T" D ^%DT S DT=Y
DIVISN ; if MED CTR DIV file set up (first record) and record does not exist, write warning, kill variables, and exit
 S X=$G(^DG(40.8,0)) I X="" W !,"WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP",!,"USE THE ADT PARAMETER OPTION FILE TO SET UP DIVISION" G EXIT
 ;  check if multi-divisional center (GL node exists and 2nd piece=1). Do lookup, if it exists-set local variables
 I $D(^DG(43,1,"GL")),$P(^("GL"),U,2) D  G:Y'>0 EXIT G PATIENT
 . S DIC="^DG(40.8,",DIC(0)="AEQMNZ",DIC("A")="Select DIVISION: " W !!
 . D ^DIC K DIC Q:Y'>0
 . S DGBTDIVI=+Y,DGBTDIV=$P(Y,U,2)
 . D INSTIT S DGBTMD=1
 ;  if not a multi-divisional center, default to institution name
 S DGBTDIVI=$O(^DG(40.8,0)),DGBTDIV=$P(^DG(40.8,DGBTDIVI,0),U) D INSTIT
 ;
PATIENT ; patient lookup, quit if patient doesn't exist
 D QUIT1^DGBTEND ; kill local variables except med division vars
 S DGBTTOUT="",DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: "
 W !! D ^DIC K DIC G:Y'>0 EXIT
 ; get patient information#, call return patient return variables routine and set wether new claim or not
 S DFN=+Y D 6^VADPT,KVAR^DGBTEND,PID^VADPT
 S DGBTNEW=$S($D(^DGBT(392,"C",DFN)):0,1:1)
 ;
OLDCLAIM ;  find any past claims through DGBTE1 call
 D ^DGBTE1 Q:'$D(DGBTA)  ; set to call test routine, call old claims
 I '$D(^DG(43,1,"BT"))!('$D(^DG(43.1,$O(^DG(43.1,(9999999.9999999-DGBTDT))),"BT"))) D  G EXIT2
 . ;  check for certifying official and that current (or past) FY deductable is set up 
 . W !!,"***WARNING...BENE TRAVEL PARAMETERS HAVE NOT BEEN SET UP",!,"USE THE BENEFICIARY TRAVEL PARAMETER RATES ENTER/EDIT OPTION TO PROPERLY INITIALIZE"
 ;
COREFLS ;  coreFLS vendor interface active/inactive
 S DGBTCORE=$P($G(^DG(43,1,"BT")),U,4)
 ;
SCREEN ;  display B/T claim information through screen1
 D SCREEN^DGBT1
 I '+VAEL(1) W !!,"Eligibility is missing from registration and is required to continue." G EXIT2
 S DIR("A")="Continue processing claim",DIR("?")="Sorry, enter 'Y'es or RETURN to continue procesing claim, 'N'o to exit",DIR(0)="Y",DIR("B")="YES"
 D ^DIR S ANS=Y K DIR G:'ANS!($D(DTOUT))!($D(DUOUT)) EXIT3
SCREEN2 ;
 D SCREEN^DGBT2
COMPLT ;  complete claims processing
 ;  
 I '$D(^DGBT(392,DGBTDT,"A")) S DA=DGBTDT,DIE="^DGBT(392,",DR="11///"_DGBTDIVI_";12////"_DUZ_";13///"_DT D ^DIE S %=1 W !!,"Complete claim for ",DGBTDTE D YN^DICN G:%=2 EXIT3 G:%=-1 EXIT2 D:%<1 HELP1 G:%<1 COMPLT D SCREEN^DGBTEE
 G:DGBTTOUT=-1 EXIT2
 G ^DGBTEND
HELP1 ;
 W !!?10,$S(%=-1:"SORRY, '^' NOT ALLOWED",1:"ENTER 'Y'ES OR 'N'O")
 Q
INSTIT ;  check for pointer to institution file and for address information on institution
 S DGBTDIVN=$P(^DG(40.8,DGBTDIVI,0),"^",7)
 I 'DGBTDIVN W !!,"INSTITUTION HAS NOT BEEN DEFINED FOR ",$P(^(0),"^"),!,"USE THE ADT PARAMETER OPTION TO UPDATE",! Q
 I $D(^DIC(4,DGBTDIVN,0)),$S($D(^(1))#10=0:1,$P(^(1),"^",3)']"":1,1:0) W !!,"INSTITUTION ADDRESS NOT ENTERED.  PLEASE UPDATE USING THE INSTITUTION FILE ENTER/EDIT",! Q
 Q
EXIT ; kills off all variables before quitting
 G QUIT^DGBTEND
 Q
EXIT2 ; delete claim through DIK call, return to patient label
 G DELETE1^DGBTEND
 Q
EXIT3 ;
 G DELETE^DGBTEND
 Q
