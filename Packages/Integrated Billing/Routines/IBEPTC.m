IBEPTC ;ALB/CPM/ARH - TP FLAG STOP CODES AND CLINICS ; 22-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**55**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Option entry point - main processing loop.
 S IBQ=0 F  D UPD Q:IBQ
 K IBQ
 Q
 ;
UPD ; Update the billable status for stop codes or clinics.
 W @IOF,*13,?10,"Flag Stop Codes and Clinics for Third Party Billing"
 W !,$$DASH(),!,"FOR THIRD PARTY BILLING, THIS OPTION IS USED TO SET UP:"
 W !,"1. INDIVIDUAL OR A GROUP OF STOP CODES OR CLINICS AS:"
 W !,"   a. NON-BILLABLE OR BILLABLE."
 W !,"      A Stop/Clinic is assumed billable until it is flagged as non-billable."
 W !,"   b. IGNORED BY THE AUTO BILLER.  Stops the auto biller from creating"
 W !,"      bills for specified billable Stops/Clinics."
 W !,"2. ALL CLINICS TO BE:"
 W !,"   a. IGNORED BY THE AUTO BILLER.  Stops the auto biller from creating bills"
 W !,"      for ALL clinics.  Should only be used if the outpatient auto biller"
 W !,"      is on but only a small number of Clinics should be auto billed."
 W !,"   b. BILLED BY THE AUTO BILLER.  Resets all Clinics to be auto billed."
 W !,"Use of this option will have an immediate effect on your billing operations"
 W !,"so you should have your work pre-planned before using this option.",!,$$DASH()
 ;
 ; - select stop codes or clinics.
 S DIR(0)="SO^S:STOP CODES;C:CLINICS;A:ALL CLINICS",DIR("?")="^D HSEL^IBEPTC1"
 S DIR("A")="Enter your choice" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) G UPDQ
 I Y="A" G ^IBEPTC3
 S IBINFO=$T(@Y+1)
 ;
 ; - some help
 W !!,$$DASH(),!,"You may now enter the ",$P(IBINFO,";",3)," that you wish to flag.  Please note"
 W !,"all ",$P(IBINFO,";",3)," that you select will be assigned the same effective"
 W !,"date and billable status and auto bill status.",!,$$DASH(),!
 ;
 ; - select all entries to be updated
 S (IBNUM,IBHIT)=0 D UPDQ1 F  D  Q:Y<0
 .S DIC=$P(IBINFO,";",5),DIC(0)="QEAMZ"
 .S DIC("A")=$S(IBHIT:"Next",1:"Select")_" "_$P(IBINFO,";",4)_": "
 .S:$P(IBINFO,";",6)]"" DIC("S")=$P(IBINFO,";",6)
 .D ^DIC K DIC Q:Y<0  S IBHIT=1
 .I $D(^TMP("IBEPTC",$J,+Y)) W !,"Please note that you've already selected ",Y(0,0),"."
 .E  S ^TMP("IBEPTC",$J,+Y)=Y(0,0),IBNUM=IBNUM+1
 ;
 ; - quit if no selections were made.
 I '$D(^TMP("IBEPTC",$J)) W !!,"No ",$P(IBINFO,";",3)," selected!" S IBQ=1 G UPDQ
 ;
 ; - allow review of the selections.
 I IBNUM>1 D REV^IBEPTC1 I IBQ G UPDQ
 ;
 ; - quit if all entries were de-selected (but allow re-start).
 I '$D(^TMP("IBEPTC",$J)) W !!,"All ",$P(IBINFO,";",3)," were de-selected!" G UPDQ
 ;
 ; - should be Third Party Billable or Non-billable?
 S DIR(0)="Y",DIR("A")=$S(IBNUM=1:"Is this",1:"Are these")_" "_$P(IBINFO,";",$S(IBNUM=1:7,1:3))_" Non-Billable for Third Party Billing"
 S DIR("?")="^D HACT^IBEPTC1"
 W ! D ^DIR K DIR G:($D(DIRUT))!($D(DUOUT)) UPDQ
 S IBFILE=+Y,IBACT=$S(IBFILE:"Non-",1:"")
 ;
 I +IBFILE S IBTPAB="",IBACT1="NOT "
 I 'IBFILE D  I IBTPAB<0 G UPDQ
 . S DIR(0)="Y",DIR("A")="Should the Third Party Auto Biller create bills for "_$S(IBNUM=1:"this",1:"these")_" "_$P(IBINFO,";",$S(IBNUM=1:7,1:3))
 . S DIR("?")="^D HAUTO^IBEPTC1"
 . W ! D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBTPAB=-1 Q
 . S IBTPAB=$S(+Y:0,1:1),IBACT1=$S(IBTPAB:"NOT ",1:"")
 ;
 ; - what is the effective date for this action?
 S %DT="AEX",%DT("A")="Please enter the date this should become effective: "
 D ^%DT K %DT G:Y<0 UPDQ S IBDAT=Y
 I Y>DT W !!,"Please note that you've selected a future date!"
 ;
 ; - re-display the list of selected entries.
 W !!,$$DASH() D LIST^IBEPTC1
 W !!,"Effective ",$$FMTE^XLFDT(IBDAT)," the above ",$P(IBINFO,";",3)," will be ",IBACT,"billable"
 W !,"and will ",IBACT1,"have bills created by the Third Party auto biller.",!
 ;
 ; - okay to proceed and file entries?
 S DIR(0)="Y",DIR("A")="Is this correct, is it okay to proceed and file these entries"
 S DIR("?")="Enter 'Y' to file these entries, 'N' to try again, or '^' to quit."
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G UPDQ
 ;
 ; - file selected entries.
 W !!,"Filing these ",$P(IBINFO,";",4)," entries...  " D FILE^IBEPTC1
 W ! S DIR(0)="E" D ^DIR K DIR,DIRUT,DUOUT
 ;
UPDQ S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 K DIRUT,DUOUT,DTOUT,DIROUT,IBINFO,IBNUM,IBFILE,IBACT,IBDAT,IBHIT,IBACT1,IBTPAB
UPDQ1 K ^TMP("IBEPTC",$J)
 Q
 ;
DASH() ; Write a dashed line.
 Q $TR($J("",79)," ","=")
 ;
INFO ; Description of stop/clinic information listed below.
 ;;desc (plural);desc (selection);source file root;source screen;desc (sing);dest file root;dest file #
 ;
S ; Stop Code Information
 ;;clinic stop codes;CLINIC STOP CODE;^DIC(40.7,;I '$P(^(0),U,3);clinic stop code;^IBE(352.3,;352.3
 ;
C ; Clinic Information
 ;;clinics;CLINIC;^SC(;I $P(^(0),U,3)="C";clinic;^IBE(352.4,;352.4
 ;
 Q
