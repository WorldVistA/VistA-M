IBEMTF ;ALB/CPM - FLAG STOP CODES, DISPOSITIONS, AND CLINICS ; 22-JUL-93
 ;;2.0;INTEGRATED BILLING;**167**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Option entry point - main processing loop.
 ;
 ; per patch ib*2*167, this option no longer valid
 ;
 W !!,"Due to the new Means Test Copayment Tier, this option, is no longer used!",!!
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT S DIR(0)="E" D ^DIR
 Q
 ;
 ;
 ;
 S IBQ=0 F  D UPD Q:IBQ
 K IBQ
 Q
 ;
UPD ; Update the billable status for stop codes, dispositions, or clinics.
 W @IOF,*13,?6,"Flag Stop Codes, Dispositions, and Clinics for Means Test Billing"
 W !,$$DASH(),!,"This option is used to set up Clinic Stop Codes, Dispositions, and Clinics"
 W !,"as either non-billable or billable for the Means Test Outpatient Copayment."
 W !!,"Use of this option will have an immediate effect on your billing operations,"
 W !,"so you should have your work pre-planned before using this option.",!,$$DASH()
 ;
 ; - select stop codes, dispositions, or clinics.
 S DIR(0)="SO^S:STOP CODES;D:DISPOSITIONS;C:CLINICS",DIR("?")="^D HSEL^IBEMTF1"
 S DIR("A")="Enter your choice" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) G UPDQ
 S IBINFO=$T(@Y+1)
 ;
 ; - some help
 W !!,$$DASH(),!,"You may now enter the ",$P(IBINFO,";",3)," that you wish to flag.  Please note"
 W !,"all ",$P(IBINFO,";",3)," that you select will be assigned the same effective"
 W !,"date and billable status.",!,$$DASH(),!
 ;
 ; - select all entries to be updated
 S (IBNUM,IBHIT)=0 D UPDQ1 F  D  Q:Y<0
 .S DIC=$P(IBINFO,";",5),DIC(0)="QEAMZ"
 .S DIC("A")=$S(IBHIT:"Next",1:"Select")_" "_$P(IBINFO,";",4)_": "
 .S:$P(IBINFO,";",6)]"" DIC("S")=$P(IBINFO,";",6)
 .D ^DIC K DIC Q:Y<0  S IBHIT=1
 .I $D(^TMP("IBEMTF",$J,+Y)) W !,"Please note that you've already selected ",Y(0,0),"."
 .E  S ^TMP("IBEMTF",$J,+Y)=Y(0,0),IBNUM=IBNUM+1
 ;
 ; - quit if no selections were made.
 I '$D(^TMP("IBEMTF",$J)) W !!,"No ",$P(IBINFO,";",3)," selected!" S IBQ=1 G UPDQ
 ;
 ; - allow review of the selections.
 I IBNUM>1 D REV^IBEMTF1 I IBQ G UPDQ
 ;
 ; - quit if all entries were de-selected (but allow re-start).
 I '$D(^TMP("IBEMTF",$J)) W !!,"All ",$P(IBINFO,";",3)," were de-selected!" G UPDQ
 ;
 ; - should Means Test billing be ignored or activated?
 S DIR(0)="Y",DIR("A")="Ignore Means Test billing for "_$S(IBNUM=1:"this",1:"these")_" "_$P(IBINFO,";",$S(IBNUM=1:7,1:3))
 S DIR("?")="^D HACT^IBEMTF1"
 W ! D ^DIR K DIR G:($D(DIRUT))!($D(DUOUT)) UPDQ
 S IBFILE=+Y,IBACT=$S(IBFILE:"ignore",1:"activate")
 ;
 ; - what is the effective date for this action?
 S %DT="AEX",%DT("A")="Please enter the effective date to "_IBACT_" billing: "
 D ^%DT K %DT G:Y<0 UPDQ S IBDAT=Y
 I Y>DT W !!,"Please note that you've selected a future date!"
 ;
 ; - re-display the list of selected entries.
 W !!,"Action to take => ",IBACT," billing for the following ",$P(IBINFO,";",3),":" D LIST^IBEMTF1 W !
 ;
 ; - okay to proceed and file entries?
 S DIR(0)="Y",DIR("A")="Is it okay to proceed and file these entries"
 S DIR("?")="Enter 'Y' to file these entries, 'N' to try again, or '^' to quit."
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G UPDQ
 ;
 ; - file selected entries.
 W !!,"Filing these ",$P(IBINFO,";",4)," entries...  " D FILE^IBEMTF1
 W ! S DIR(0)="E" D ^DIR K DIR,DIRUT,DUOUT
 ;
UPDQ S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 K DIRUT,DUOUT,DTOUT,DIROUT,IBINFO,IBNUM,IBFILE,IBACT,IBDAT,IBHIT
UPDQ1 K ^TMP("IBEMTF",$J)
 Q
 ;
DASH() ; Write a dashed line.
 Q $TR($J("",79)," ","=")
 ;
INFO ; Description of stop/disposition/clinic information listed below.
 ;;desc (plural);desc (selection);source file root;source screen;desc (sing);dest file root;dest file #
 ;
S ; Stop Code Information
 ;;clinic stop codes;CLINIC STOP CODE;^DIC(40.7,;I '$P(^(0),U,3);clinic stop code;^IBE(352.3,;352.3
 ;
D ; Disposition Information
 ;;dispositions;DISPOSITION;^DIC(37,;I '$P(^(0),U,10);disposition;^IBE(352.2,;352.2
 ;
C ; Clinic Information
 ;;clinics;CLINIC;^SC(;I $P(^(0),U,3)="C";clinic;^IBE(352.4,;352.4
 ;
