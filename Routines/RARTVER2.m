RARTVER2 ;HISC/FPT-On-line Verify Radiology Reports (cont.) ;11/19/97  13:47
 ;;5.0;Radiology/Nuclear Medicine;**23,26,31**;Mar 16, 1998
ADDLRPT ; add'l reports to be verified
 S (RARPT,RATOT)=0
 Q:RACHOICE=6
 F  S RARPT=$O(^RARPT(RAD,RARADHLD,RARPT)) Q:'RARPT  I $D(^RARPT(RARPT,0)) S RARTDT=$S($P(^(0),"^",6)="":9999999.9999,1:$P(^(0),"^",6)) D
 .I $D(^TMP($J,"RA","DT",RARTDT,RARPT)) Q
 .S X=$G(^RARPT(RARPT,0))
 .Q:$$STUB^RAEDCN1(RARPT)  ;skip stub report
 .Q:$P(X,"^",5)="V"  ; skip if already verified
 .I RACHOICE=1,$P(X,U,12)]"","DR"[$E($P(X,U,5)) D SETTMP Q
 .I RACHOICE=2,$P(X,U,5)="R" D SETTMP Q
 .I RACHOICE=3,$P(X,U,5)="D" D SETTMP Q
 .I RACHOICE=4,$P(X,U,5)="PD" D SETTMP Q
 .I RACHOICE=5 D SETTMP
 I RATOT>0 W $C(7),!!?5,RATOT_" additional exam"_$S(RATOT>1:"s are",1:" is")_" now ready for verification.",!! K DIR S DIR(0)="E",DIR("A")="Press RETURN to Continue" D ^DIR S:$D(DIRUT) RATOT=0 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S:RATOT>0 RARLTVFL=""
 Q
SETTMP ;
 S Y=RARPT D RASET^RAUTL2 Q:'Y  ; corrupt record - so ignore!!
 S ^TMP($J,"RA","DT",RARTDT,RARPT)="",RATOT=RATOT+1
 Q
CU ; clean-up variables
 K %,%DT,%W,%Y1,DA,DGO,DI,DIC,DIWF,DIWR,I,OREND,POP,RA,RACHOICE,RACN,RACNI,RACS,RACT,RAD,RADATE,RADFN,RADIV,RADTE,RADTI,RADUP,RADUZ,RAERR,RAFLG,RAIMGTYI,RAIMGTYJ,RAJ1
 K RANM,RANME,RANUM,RAONLINE,RAOR,RAOUT,RAPGM,RAPRC,RAPRIT,RARAD,RARADHLD,RARDX,RARESFLG,RARPDT,RARLTV,RARLTVFL,RARPT,RARPTX,RARTDT,RARTVER,RARTVERF,RASET,RASIG,RASN,RASTAFF,RASTI,RATOT,RAVER,RAVNB,RAXX,RPTX,X,Y,^TMP($J,"RA")
 K D,D0,D1,DDER,DLAYGO,RACI,X1,ZTSK,DISYS
 Q
SAVE ; Save key variables. User can first print a report to a slave printer
 ; in which case the key variables are killed by the printing program.
 ; These variables are needed if the  user then decides to CONTINUE
 ; editing the STATUS.
 N RAI
 F RAI="RACN","RACNI","RADFN","RADTI","RARPT","RAVER" S RASAVE(RAI)=$G(@RAI)
 Q
RESTORE ; Restore the variables that were saved above.
 N RAI
 S RAI=""
 F  S RAI=$O(RASAVE(RAI)) Q:RAI=""  S @RAI=RASAVE(RAI)
 K RASAVE
 Q
RETURN ; On-line verifier deletes resident pre-verification values. Report
 ; will reappear in the resident's list of choices for the resident
 ; pre-verification option
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT W !
 S DIR("A")="Return to Resident (delete pre-verification)"
 S DIR("?")="If you answer NO, this report will remain pre-verified."
 S DIR("?",1)="If you answer YES, this report will no longer be marked as pre-verifed."
 S DIR("?",2)="It will reappear as a selection in the Resident On-Line Pre-Verification"
 S DIR("?",3)="option for the Resident associated with this report."
 S DIR("?",4)=" "
 S DIR(0)="Y"
 D ^DIR
 Q:Y=0!($D(DIRUT))
 N DA,DIE,DR
 S DIE="^RARPT(",DA=RARPT,DR="14///@;15///@;16///@"
 D ^DIE
 Q
DISRPT ; Display the report
 S RARTVER="" D RASET Q:'Y  D DISP^RART1 K RARTVER
 Q
PRTRPT  ; Print the report
 D SAVE^RARTVER2
 S ION=$P(RAMLC,"^",10),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S RAMES="W !!,""Report has been queued for printing on device "",ION,"".""" D Q^RARTR
 D RESTORE^RARTVER2
 Q
RASET ; raset^rautl2  returns  radfn,radti,racni's "P"-node
 S Y=RARPT D RASET^RAUTL2 Q:'Y  S Y(0)=Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"UNKNOWN"),RAPRC=$S($D(^RAMIS(71,+$P(Y(0),"^",2),0)):$P(^(0),"^"),1:"UNKNOWN")
        Q
LOCK ; Display the warning message when a user is trying to edit a
 ; locked report
 S RACN=+$P(^RARPT(RARPT,0),"^",4)
 W !!,$C(7),"Another user is editing this report",$S($G(RACN)]"":" (Case # "_RACN_")",1:""),".  Please try again later." K DIR S DIR(0)="E" D ^DIR K DIR,DIROUT,DIRUT,DTOUT,DUOUT,RACN G GETRPT^RARTVER
 Q
EDTCHK ; is user permitted to edit?
 S RASTATUS=+$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",3)
 I $P($G(^RA(72,RASTATUS,0)),"^",3)>0 K RASTATUS Q
 K RASTATUS
 I $D(^XUSEC("RA MGR",DUZ)) Q
 I $P(RAMDV,"^",22)=1 Q
 W $C(7),!!,"The STATUS for this case is CANCELLED. You may not enter a report.",!!
 S RARDX="C" ;user can verify only
 Q
ERR(RA) ; Display inactive physician message.
 W !!?3,"'"_$P($G(^VA(200,RA,0)),"^")_"' has an inactive provider "
 W "date of "_$$FMTE^XLFDT($P($G(^VA(200,RA,"PS")),"^",4))_".",$C(7)
 Q
