IBEPTC1 ;ALB/CPM/ARH - TP FLAG STOP CODES AND CLINICS (CON'T.) ; 23-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**55**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
REV ; Review selected entries and de-select if necessary.
 W !!,"You have selected ",IBNUM," ",$P(IBINFO,";",3),"."
 S DIR(0)="Y",DIR("A")="Would you like to review these selections",DIR("?")="^D HREV^IBEPTC1"
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G REVQ
 ;
 ; - list selections and ask if user would like to de-select.
 W ! D LIST W !
 S DIR(0)="Y",DIR("A")="Would you like to de-select any entries"
 S DIR("?")="Enter 'Y' to de-select entries, 'N' to continue, or '^' to quit."
 D ^DIR K DIR I 'Y!($D(DIRUT))!($D(DUOUT)) G REVQ
 ;
 ; - allow de-selection and pull entries from the list.
 S IBHIT=0 F  D  Q:Y<0
 .S DIC=$P(IBINFO,";",5),DIC(0)="QEAMZ"
 .S DIC("A")="De-select "_$S(IBHIT:"Next ",1:"")_$P(IBINFO,";",4)_": "
 .S:$P(IBINFO,";",6)]"" DIC("S")=$P(IBINFO,";",6)
 .D ^DIC K DIC Q:Y<0  S IBHIT=1
 .I '$D(^TMP("IBEPTC",$J,+Y)) W !,"Please note that ",Y(0,0)," is not currently selected."
 .E  K ^TMP("IBEPTC",$J,+Y) S IBNUM=IBNUM-1
 W !!,"You have selected a total of ",IBNUM," ",$P(IBINFO,";",$S(IBNUM=1:7,1:3)),"."
REVQ S:$D(DIRUT)!($D(DUOUT)) IBQ=1
 Q
 ;
FILE ; File all selected entries.
 N IBI,IBIN,IBALR
 S IBI=0 F  S IBI=$O(^TMP("IBEPTC",$J,IBI)) Q:'IBI  S IBIN=^(IBI) D
 .K DD,DO,DIC,DR
 .S DIC=$P(IBINFO,";",8),DIC(0)="",X=IBI,DLAYGO=$P(IBINFO,";",9)
 .;
 .; - has this entry already been filed for this date?
 .S IBALR=$O(@(DIC_"""AIVDTT2"","_IBI_","_-IBDAT_",0)"))
 .;
 .; - add new entry if not yet on file for the specified date
 .I 'IBALR D FILE^DICN I Y<0 W !,"Unable to file ",IBIN,"..",! Q
 .S DIE=$P(IBINFO,";",8),DA=$S(IBALR:IBALR,1:+Y),DR=".02////"_IBDAT_";.04////2;.05////"_IBFILE_";.06////"_IBTPAB
 .D ^DIE K DA,DR,DIE W "."
 W " done!"
 Q
 ;
LIST ; List all selected entries.
 W ! S I=0 F  S I=$O(^TMP("IBEPTC",$J,I)) Q:'I  W:$X>40 ! W:$X>2 ?40 W ^(I)
 Q
 ;
HACT ; Help for the Billing action prompt.
 W !!,"For Third Party Billing, please enter:"
 W !,"   'Y' to flag ",$S(IBNUM=1:"this",1:"these")," ",$P(IBINFO,";",$S(IBNUM=1:7,1:3))," as non-billable."
 W !,"   'N' to flag ",$S(IBNUM=1:"this",1:"these")," ",$P(IBINFO,";",$S(IBNUM=1:7,1:3))," as billable."
 W !,"   '^' to quit this option."
 Q
 ;
HAUTO ; Help for the Auto Biller action prompt.
 W !!,"For the Third Party Auto Biller, please enter:"
 W !,"   'Y' if bills should be created for ",$S(IBNUM=1:"this",1:"these")," billable ",$P(IBINFO,";",$S(IBNUM=1:7,1:3))
 W !,"   'N' if bills should NOT be created for ",$S(IBNUM=1:"this",1:"these")," billable ",$P(IBINFO,";",$S(IBNUM=1:7,1:3))
 W !,"   '^' to quit this option."
 Q
 ;
HSEL ; Help for the Billing characteristic prompt.
 W !!,"For Third Party Billing, please enter:"
 W !,"   'S' to flag some Stop Codes as (non) billable or (not) auto billed"
 W !,"   'C' to flag some Clinics as (non) billable or (not) auto billed"
 W !,"   'A' to flag ALL Clinics for the auto biller"
 W !,"   '^' to quit this option."
 Q
 ;
HREV ; Help for the Request to Review prompt.
 W !!,"Enter 'Y' to review the selections, 'N' to continue, or '^' to quit."
 W !,"Please note that, if you choose to review the selections, you will have"
 W !,"the opportunity to de-select incorrect entries from the list."
 Q
