DGBTE ;ALB/SCK/BLD - BENEFICIARY TRAVEL SETUP/MAIN ENTRY CALL UP; 11/20/92@1000; 11/25/92
 ;;1.0;Beneficiary Travel;**2,19,20,22,25,28**;September 25, 2001;Build 12
START ;
 N TRNSMDE,REMARKS,CLMTYPE,INSTIT,SPMODE,DGBTCMTY,DGBTDIVI,DGBTDIV,DGBTDIVN,DGANS,DGBTINCA,DGBTDTY,DGBTAPPTYP,DGBTDCLM,IOM,PATCHDT,DGBTPDIV
 ;DGBTINCA = Alternate Income
 K DGBTFDA,ERRMSG,DGBTX1,SGCOMPLETE
 ;
 D QUIT^DGBTEND  ; kill all variables
 D PATCH
 S PRCABN=1,IOP="HOME" D ^%ZIS K IOP
 S DGBTIME=300 S:'$D(DTIME) DTIME=DGBTIME S:'$D(U) U="^"
 ;   if date/time is undefined, set DT value
 I '$D(DT)#2 S %DT="",S="T" D ^%DT S DT=Y
DIVISN ; if MED CTR DIV file set up (first record) and record does not exist, write warning, kill variables, and exit
 S X=$G(^DG(40.8,0)) I X="" W !,"WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP",!,"USE THE ADT PARAMETER OPTION FILE TO SET UP DIVISION" G EXIT
 ;  check if multi-divisional center (GL node exists and 2nd piece=1). Do lookup, if it exists-set local variables
 I $D(^DG(43,1,"GL")),$P(^("GL"),U,2) D  G:Y'>0 EXIT F  D PATIENT Q:$G(DGANS)="Q"  ;dbe patch DGBT*1*22 - return to select patient prompt
 . S DIC="^DG(40.8,",DIC(0)="AEQMNZ",DIC("A")="Select DIVISION: " W !!
 . D ^DIC K DIC Q:Y'>0
 . S (DGBTPDIV,DGBTDIVI)=+Y,DGBTDIV=$P(Y,U,2) ;dbe patch DGBT*1*22 - Added DGBTPDIV to save selected division if previous claim is edited
 . D INSTIT S DGBTMD=1
 Q:$G(DGANS)="Q"  ;dbe patch DGBT*1*22
 ;  if not a multi-divisional center, default to institution name
 S (DGBTPDIV,DGBTDIVI)=$O(^DG(40.8,0)),DGBTDIV=$P(^DG(40.8,DGBTDIVI,0),U) D INSTIT ;DGBT*1.0*28 - added variable DGBTPDIV
 ;
PATIENT ; patient lookup, quit if patient doesn't exist
 N VAEL
 D QUIT^DGBTEND
 S DGBTOLD=0   ;PAVEL DGBT*1*20
 D QUIT1^DGBTEND ; kill local variables except med division vars
 S DGBTTOUT="",DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")="Select PATIENT: "
 W !! D ^DIC K DIC I +Y'>0 D EXIT S DGANS="Q" Q
 ; get patient information#, call return patient return variables routine and set whether new claim or not
 S:DGBTDIVI'=DGBTPDIV DGBTDIVI=DGBTPDIV ;dbe patch DGBT*1*22 - restore selected division from previous claim editing
 S DFN=+Y D 6^VADPT,KVAR^DGBTEND,PID^VADPT
 S DGBTNEW=$S($D(^DGBT(392,"C",DFN)):0,1:1)
 S SPCOMPLETE=0,DGBTAPPTYP=0
 S DGBTNSC=$$NSC^DGBTUTL
 ;
 ;next 2 lines were added by the BT Dashboard project(DGBT*1.0*19) and Integrated into DGBTE by BLD for DGBT*1.0*20
 S ^XTMP("DGBT BTD",0)=$$DT^XLFDT_"^"_$$DT^XLFDT
 S ^XTMP("DGBT BTD","CLAIMERS",$G(DUZ,-1))=$G(DFN,-1)
 ;
OLDCLAIM ;  find any past claims through DGBTE1 call
 D ^DGBTE1 I '$D(DGBTA) D PATIENT Q  ; set to call test routine, call old claims
 I '$D(^DG(43,1,"BT"))!('$D(^DG(43.1,$O(^DG(43.1,(9999999.9999999-DGBTDT))),"BT"))) D  D EXIT2 Q
 . ;  check for certifying official and that current (or past) FY deductible is set up 
 . W !!,"***WARNING...BENE TRAVEL PARAMETERS HAVE NOT BEEN SET UP",!,"USE THE BENEFICIARY TRAVEL PARAMETER RATES ENTER/EDIT OPTION TO PROPERLY INITIALIZE"
 ;
COREFLS ;  coreFLS vendor interface active/inactive
 S DGBTCORE=$P($G(^DG(43,1,"BT")),U,4)
 ;
SCREEN ;  display B/T claim information through screen1
 N DGBTQUIT
 D SCREEN^DGBT1 I $G(DGBTQUIT) D:'$G(CHZFLG) EXIT2,PATIENT D:$G(CHZFLG) EXIT,PATIENT Q
 Q:$G(ENDMENU)
 S:$D(^DGBT(392,DGBTDT,"SP")) SPCOMPLETE=1
 I '+VAEL(1) W !!,"Eligibility is missing from registration and is required to continue.",*7 D EXIT2 Q
 I $G(DGANS)="I" Q     ;BLD DG*1*20
 S DIR("A")="Continue processing claim",DIR("?")="Sorry, enter 'Y'es or RETURN to continue processing claim, 'N'o to exit",DIR(0)="Y",DIR("B")="YES"
 D ^DIR S ANS=Y K DIR
 I 'ANS S SPCOMPLETE=0 D EXIT2,CLEANUP^DGBTSP,PATIENT Q  ;S DGANS="Q" Q    ;BLD DG*1*20
 N DGBTELL S DGBTELL=$$ELIG^DGBTUTL1(DFN) ;PAVEL DGBT*1.0*20
 I +$G(DGBTELL)'=14,(+$G(DGBTELL)'=15) W !!," Eligible: ",$P(DGBTELL,U,2),!!
 I +$G(DGBTELL)=15 W !!,"Not Eligible: ",$P(DGBTELL,U,2),!!
 I +DGBTELL=14 S:'$G(CHZFLG) DGBTTOUT=-1,DGBTOLD=0 G DELETE1^DGBTEND ;User exit with ^  so delete the claim   !!??
 D  ;Store Result of E7 in fields 43.1  43.2
 .K FDA,ERRMSG
 .S FDA(392,DGBTDTI_",",43)=$G(DGBTCPAP)
 .S FDA(392,DGBTDTI_",",43.1)=+$G(DGBTELL)
 .S FDA(392,DGBTDTI_",",43.4)=$G(DGBTSCAP)
 .S FDA(392,DGBTDTI_",",43.5)=$G(DGBTQAP)
 .S:$L($P(DGBTELL,": ",2)) FDA(392,DGBTDTI_",",43.2)=$P($G(DGBTELL),": ",2,99)
 .D FILE^DIE("EKTS","FDA","ERRMSG") ;
 .I $D(ERRMSG),ERRMSG("DIERR",1,"TEXT",1)["The record is currently locked" W !!,"The patients record is currently locked..."
 I $D(ERRMSG) D EXIT Q
 ;
 ;the following question is for E1 in patch DGBT*1.0*20
 ;
SPMODE ;BLD DGBT*1*20 - SPMODE line tag will display question whether or special mode claim or mileage claim
 ; CLMTYP = type of BT claim, Mileage or Special Mode
 ;
 S (SPCOMPLETE,DGBTSP)=0
 D EN^DGBTSP(.DGBTSP) I $D(DTOUT)!($D(DUOUT)) K:$G(DGBTTOUT)=-1&($G(CHZFLG)=0) ^DGBT(392,DGBTDTI,"A") D:'$G(SPCOMPLETE) EXIT2 D:$G(SPCOMPLETE)&('$G(CHZFLG)) CLEANUP^DGBTSP D PATIENT,EXIT Q  ;DGBT*1.0*28 - added check for 'chzflg
 I +DGBTELL=15 D  I $G(DGBTTOUT)=-1  D:$G(DGBTTOUT)=-1&($G(CHZFLG)=0) EXIT2 D:$G(DGBTTOUT)=-1&($G(CHZFLG)) EXIT D PATIENT,EXIT Q
 .W !!,"CLAIM HAS BEEN DENIED AND DENIAL OF BENEFITS LETTER WILL BE ISSUED"
 .D DGBTDR^DGBTDLT Q:$G(DGBTTOUT)=-1
 .W !!,"PLEASE COMPLETE THE INVOICE INFORMATION." H 2
 S DA=DGBTDT,DIE="^DGBT(392,",DR="11///"_DGBTDIVI S:'$G(CHZFLG)!($P(^DGBT(392,DGBTDT,0),U,12)="") DR=DR_";12////"_DUZ S:'$G(CHZFLG)!($P(^DGBT(392,DGBTDT,0),U,13)="") DR=DR_";13///"_DT D ^DIE ;dbe patch DGBT*1*25
 I DGBTCMTY="S" D RESTART^DGBTSP(DGBTCMTY) I $D(DTOUT)!($D(DUOUT))!('$G(SPCOMPLETE)) S:'$G(SPCOMPLTE) DGBTTOUT=-1 D:'$G(SPCOMPLETE) EXIT2 D:$G(SPCOMPLETE) CLEANUP^DGBTSP D PATIENT,EXIT Q 
 ;
SCREEN2 ;
 I $G(DGBTSP)=0&('$D(^DGBT(392,"C",DFN,DGBTDTI))) D CLEANUP^DGBTSP,EXIT2 Q
 I $G(DFN)=""&($G(DGBTSP)=0) D PATIENT Q
 D SCREEN^DGBT2
COMPLT ;  complete claims processing
 ;
 I DGBTCMTY="M" S SPCOMPLETE=0
 I $G(SPCOMPLETE)=1 W !!,"Complete claim for ",DGBTDTE_" " S %=1 D YN^DICN S:%=2 SPCOMPLETE=0 K:%=2&(CHZFLG=0) ^DGBT(392,DGBTDTI,"A") I %'=1 D:%<1 HELP1 G:%<1 COMPLT D:(%=2)&($G(SPCOMPLETE)=0) EXIT2,PATIENT Q  ;dbe patch DGBT*1*22
 ;
 I $G(DGBTCMTY)="M" D  G:(%=2)&($G(DGBTSP)=0) EXIT G:%=2 EXIT3 G:%=-1 EXIT2 D:%<1 HELP1 G:%<1 COMPLT
 .S DA=DGBTDT,DIE="^DGBT(392,",DR="11///"_DGBTDIVI S:'$G(CHZFLG)!($P(^DGBT(392,DGBTDT,0),U,12)="") DR=DR_";12////"_DUZ S:'$G(CHZFLG)!($P(^DGBT(392,DGBTDT,0),U,13)="") DR=DR_";13///"_DT D ^DIE S %=1 ;dbe patch DGBT*1*25
 .W !!,"Complete claim for ",DGBTDTE D YN^DICN S:%=2 %=-1 S:%=-1&($G(CHZFLG)=0) DGBTTOUT=-1
 I $D(DGBTSP)>1 D FILE^DGBTSP1(.SPCOMPLETE) S NOLINE=1 D:$G(DGBTSP)=0 PATIENT D:$G(DGBTSP)=1 SCREEN^DGBTCDSP D EXIT D:$G(DGANS) PATIENT Q
 I $G(DGBTCMTY)="M" F I="SP","SPAD" K ^DGBT(392,DGBTDT,I)  ;clean up special mode if during an edit user switches from special mode to mileage
 I $G(SPCOMPLETE)=1&(DGBTCMTY'="M") D EXIT Q
 D SCREEN^DGBTEE
 I $G(DGBTTOUT)=-1,$G(DGBTCMTY)="M" G DELETE1^DGBTEND ;PAVEL DGBT*1*20
 G:$G(DGBTTOUT)=-1 EXIT3
 D ^DGBTEND
 Q
HELP1 ; 
 W !!?10,$S(%=-1:"SORRY, '^' NOT ALLOWED",1:"ENTER 'Y'ES OR 'N'O")
 Q
INSTIT ;  check for pointer to institution file and for address information on institution
 S DGBTDIVN=$P(^DG(40.8,DGBTDIVI,0),"^",7)
 I 'DGBTDIVN W !!,"INSTITUTION HAS NOT BEEN DEFINED FOR ",$P(^(0),"^"),!,"USE THE ADT PARAMETER OPTION TO UPDATE",! Q
 I $D(^DIC(4,DGBTDIVN,0)),$S($D(^(1))#10=0:1,$P(^(1),"^",3)']"":1,1:0) W !!,"INSTITUTION ADDRESS NOT ENTERED.  PLEASE UPDATE USING THE INSTITUTION FILE ENTER/EDIT",! Q
 Q
EXIT ; kills off all variables before quitting
 I $D(DGANS) D QUIT^DGBTEND Q
 I $G(DGBTCMTY)="S" D END^DGBTCDSP Q
 D QUIT^DGBTEND Q
 Q
EXIT2 ; delete claim through DIK call, return to patient label
 D DELETE1^DGBTEND
 Q
EXIT3 ;
 I $G(DGBTCMTY)="S" S:$D(^DGBT(392,DGBTDT,"SP")) DGBTTOUT="" D DELETE1^DGBTEND Q
 I $D(^DGBT(392,DGBTDT,"A")) S DGBTTOUT=""
 D DELETE^DGBTEND
 Q
 ;
PATCH ;this return the date DGBT*1.0*20 was first loaded
 ;
 N PATCHNBR
 S PATCHNBR=$O(^XPD(9.7,"B","DGBT*1.0*20",""))
 S PATCHDT=$P(^XPD(9.7,PATCHNBR,0),"^",3)
 Q
