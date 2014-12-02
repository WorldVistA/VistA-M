IBCRHRS ;ALB/ARH - RATES: UPLOAD (RC) CHANGE SITE TYPE OPTION ; 25-JAN-13
 ;;2.0;INTEGRATED BILLING;**458**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Option that allows the user to change a divisions Facility Charge Type
 ; only allows the currently released version to be changed
 ;
OPTION ; Option entry Change Reasonable Charge Facility Type
 N IBVERS,IBVERSDT,IBCMRG,IBHFRG,IBNWFT,IBNWDT,IBXRF1,IBDS,IBDONE S IBDONE=0 S IBDS="",$P(IBDS,"=",IOM+1)=""
 ;
 W !!,"Change Reasonable Charges Facility Type:",!
 W !,"This option allows the Facility Type of currently loaded Reasonable Charges"
 W !,"to be changed on a specified date.  A Non-Provider Based Freestanding site"
 W !,"with only Professional charges may be changed to a Provider Based site with"
 W !,"both Institutional and Professional charges.",!
 W !,"This option will complete the following steps:"
 W !,"1.  Uploads the current version of Reasonable Charges."
 W !,"2.  Request the Region/Division to change, the new type and effective date."
 W !,"3.  Calculate the charges for the Region with the new type and effective date."
 W !,"4.  Request confirmation then update the permanent files in the Charge Master:"
 W !,"    inactivate the currently loaded charges for the region, update the "
 W !,"    Region's Type, and load the new charges into the Charge Master.",!
 W !,"Only CBO can approve a Facility Type change for a division.  "
 W !,"Approval from CBO must be received before using this option to change charges.",!
 S DIR(0)="Y",DIR("A")="Approval Received to Change a Divisions Facility Type, Continue" D ^DIR K DIR,X I Y'=1 Q
 ;
 ;
 S IBVERS=+$$VERSTR^IBCRHBRV(1) I 'IBVERS G OPTIONQ ; get the current version
 S IBVERSDT=+$$VERSDT^IBCRHBRV(IBVERS) I 'IBVERSDT G OPTIONQ ; get effective date of current version
 ;
 W !,IBDS,!,"*** Set-Up process:",!
 ;
 D XTMPKL ; delete any existing upload files in XTMP
 I '$$XTMPHL(IBVERS) G OPTIONQ ; load current version load files into XTMP
 ;
 W !,IBDS,!,"*** Get specifications from user and check the change is valid",!
 ;
 S IBCMRG=$$ASKCMRG I 'IBCMRG G OPTIONQ ; get CM Billing Region from user (#363.31)
 S IBHFRG=$$GETHFRG(IBCMRG) I 'IBHFRG G OPTIONQ ; get HF Billing Region from Host Site File
 S IBNWFT=$$ASKNWFT(IBHFRG) I 'IBNWFT G OPTIONQ ; get the new Charge Type for the Billing Region
 S IBNWDT=$$ASKNWDT I 'IBNWDT G OPTIONQ ; get the effective date of the change from the user
 I '$$CHECK(IBVERS,IBVERSDT,IBNWDT,IBCMRG,IBHFRG,IBNWFT) G OPTIONQ
 ;
 W !,IBDS,!,"*** Calculate charges and update effective date based on user entry",!
 ;
 S $P(IBHFRG,U,5)=IBNWFT
 D CALCRC^IBCRHBS5(IBHFRG) ; calculate site charges with new type, create XTMP files
 I '$$XTMPDT(IBVERSDT,IBNWDT) G OPTIONQ ; update calculated charges dates in XTMP
 ;
 W !,IBDS,!,"*** Confirm Request to Update Charge Master",!
 ;
 I '$$ASKFNL(IBCMRG,IBNWDT,IBNWFT) G OPTIONQ ; get final confirmation for change from user
 ;
 W !,IBDS,!,"*** Complete Request - Update Charge Master",!
 ;
 I '$$CMINDT(IBCMRG,IBVERSDT,IBNWDT) G OPTIONQ ; inactivate existing charges in Charge Master
 S IBDONE=1
 D CMRGFT(IBCMRG,IBNWFT) ; update Facility Type in Charge Master
 D CMLOAD ; load the modifified charges into Charge Master
 ;
OPTIONQ ;
 D XTMPKL ; delete any existing upload files in XTMP
 ;
 I +IBDONE W !,IBDS,!,"*** Process Complete, Charge Master Charges Updated.",!
 I 'IBDONE W !,IBDS,!,"*** Process Ended, No Permanent Changes.",!
 Q
 ;
 ;
XTMPKL ; delete any existing RC Upload Files in XTMP
 N IBX
 W !,"Removing any existing temporary Upload files: ",!
 S IBX="IBCR RC" F  S IBX=$O(^XTMP(IBX)) Q:IBX'["IBCR RC"  K ^XTMP(IBX) W "."
 S IBX="IBCR UPLOAD RC" F  S IBX=$O(^XTMP(IBX)) Q:IBX'["IBCR UPLOAD RC"  K ^XTMP(IBX) W "."
 Q
 ;
XTMPHL(VERS) ; load version of RC Host Files IBCR RC into XTMP (IBCRHBS1)
 N IBPATH,IBFILES,IBFILE,IBNODE,IBOK S IBOK=0 I '$G(VERS) G XTMPHLQ
 ;
 W !!,"Upload National Reasonable Charges v"_VERS_" Host Files to temporary local files:",!
 S IBPATH=$$PATH^IBCRHBS1 I IBPATH<0 G XTMPHLQ ; get path/directory
 D FILES^IBCRHBRV(.IBFILES,VERS) ; get list of files to be loaded
 I '$$FNDHOST^IBCRHBS1(.IBFILES,IBPATH) G XTMPHLQ ; check host files are available/found
 ;
 W !,"Loading National Reasonable Charges v"_VERS_" Host Files into temporary local file:"
 S IBOK=1,IBFILE="" F  S IBFILE=$O(IBFILES(IBFILE)) Q:IBFILE=""  D  I 'IBOK Q
 . S IBNODE=IBFILES(IBFILE)
 . I $$LOAD^IBCRHBS2(IBPATH,IBFILE,$P(IBNODE,U,1),$P(IBNODE,U,2),VERS,$P(IBNODE,U,3)) Q
 . W !!,"   Error while processing host file, can not continue!",!! S IBOK=0
 I +IBOK W !!,"Upload of Reasonable Charges v"_VERS_" Host Files Complete.",!
 ;
XTMPHLQ Q IBOK
 ;
XTMPDT(VSDT,NWDT) ; update calculated charges IBCR UPLOAD effective date in XTMP, returns count changed
 N IBXRF1,IBSUB,IBX,IBLN,IBCNT S IBXRF1=0,IBCNT=0
 I ($G(VSDT)'?7N)!($G(NWDT)'?7N) G XTMPDTQ
 ;
 S IBSUB="IBCR UPLOAD RC" S IBXRF1=$O(^XTMP(IBSUB)) I IBXRF1'[IBSUB G XTMPDTQ
 ;
 W !!,"Changing Effective Date from ",$$FMTE^XLFDT(VSDT,2)," to ",$$FMTE^XLFDT(NWDT,2)," in Host Files."
 W !!,"Host Files ",IBXRF1,?55,"Count = ",$P($G(^XTMP(IBXRF1,0)),U,4),!
 ;
 ; loop through XTMP calculated charges and update the effective date
 S IBSUB="" F  S IBSUB=$O(^XTMP(IBXRF1,IBSUB)) Q:IBSUB=""  D
 . S IBX=0 F  S IBX=$O(^XTMP(IBXRF1,IBSUB,IBX)) Q:'IBX  D
 .. S IBLN=$G(^XTMP(IBXRF1,IBSUB,IBX))
 .. I +$P(IBLN,U,3),+$P(IBLN,U,3)<NWDT Q
 .. ;
 .. I $P(IBLN,U,2)=VSDT S $P(IBLN,U,2)=NWDT,^XTMP(IBXRF1,IBSUB,IBX)=IBLN S IBCNT=IBCNT+1
 . I +IBCNT W !,IBSUB,?25,IBCNT
 ;
XTMPDTQ I IBCNT'=$P($G(^XTMP(IBXRF1,0)),U,4) S IBCNT=0 W !!,"Error: All dates not changed, can not continue!",!
 Q IBCNT
 ;
 ;
CMINDT(CMRG,VSDT,NWDT) ; inactivate existing charges for selected Billing Region in Charge Master (#363.2)
 N IBCNT,IBINACT,IBCS,IBCS0,IBBR0,IBXRF,IBITM,IBCI,IBCI0,IBCHG,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 I ($G(VSDT)'?7N)!($G(NWDT)'?7N) G CMINDTQ
 I $G(^IBE(363.31,+$G(CMRG),0))'["RC " G CMINDTQ
 ;
 S IBINACT=$$FMADD^XLFDT(NWDT,-1)
 ;
 W !!,"Inactivating ",$P(CMRG,U,2)," existing charges on ",$$FMTE^XLFDT(IBINACT,2),":",!,"Please wait...",!
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)) I $P(IBCS0,U,7)'=+CMRG Q
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)) I $E(IBBR0,1,3)'="RC " Q
 . ;
 . S IBXRF="AIVDTS"_IBCS,IBCHG=0
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,-VSDT,IBCI)) Q:'IBCI  D
 ... S IBCI0=$G(^IBA(363.2,IBCI,0))
 ... I +$P(IBCI0,U,4),IBINACT>+$P(IBCI0,U,4) Q
 ... ;
 ... S DR=".04///"_+IBINACT,DIE="^IBA(363.2,",DA=+IBCI D ^DIE K DIC,X,Y S IBCNT=IBCNT+1,IBCHG=1
 . I +IBCHG W !,$P(IBCS0,U,1),?35,IBCNT
 ;
CMINDTQ I 'IBCNT W !!,"Unable to Inactivate current charges, can not continue!",!
 Q IBCNT
 ;
CMRGFT(CMRG,NWFT) ; change the Billing Regions Facility Type in the Charge Master (#363.31,.03)
 N IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S NWFT=+$G(NWFT)
 S IBX=+$P($G(^IBE(363.31,+$G(CMRG),0)),U,3)
 W !!,"Changing Billing Regions Facility Type: "
 ;
 I +IBX,+NWFT,IBX'=NWFT S DR=".03///"_NWFT,DIE="^IBE(363.31,",DA=+CMRG D ^DIE
 ;
 W !,"Billing Region ",$P($G(CMRG),U,2)," changed from ",IBX," to ",NWFT
 Q
 ;
CMLOAD ; load charges into Charge Master
 ; queuing is not allowed to ensure the modified files are used and 
 ; process completes fully.
 ;
 N ADD W !!,"Load modified charges into Charge Master:",!
 ;
 ; get the device
 W !,"Report requires 120 columns.  Queuing not allowed to ensure process completes."
 S %ZIS="M",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS I POP QUIT
 ;
 S ADD=1 D RPT^IBCRHO
 Q
 ;
 ;
ASKCMRG() ; ask user for Billing Region (#363.31), return Billing Region ifn ^ name ^ div/site ^ id/zip ^ chg type
 N IBRG,IBDV,IBX,IBY,DIC,X,Y
 W !,"Enter the Division to change the Reasonable Charges Facility Type:",!
 S DIC("S")="I $E(^(0),1,3)=""RC """
 S DIC="^IBE(363.31,",DIC(0)="AEMNQZ",DIC("A")="Select DIVISION/REGION: " D ^DIC I Y<1 S Y=0
 I +Y S Y=Y_U_$P(Y(0)," ",2)_U_$P(Y(0),U,2,3)
 ;
 I +Y D
 . W !!,"Billing Region: ",$P(Y,U,2),?50,"3-Zip: ",$P(Y,U,4),?65,"Type: ",$P(Y,U,5)
 . W !,"Division: " S IBRG=+Y,IBY=0 F  S IBY=$O(^IBE(363.31,IBRG,11,IBY)) Q:'IBY  D
 .. S IBDV=$G(^IBE(363.31,IBRG,11,IBY,0)) Q:'IBDV  S IBX=$G(^DG(40.8,+IBDV,0)) W ?16,$P(IBX,U,2),?24,$P(IBX,U,1),!
 Q Y
 ;
GETHFRG(CMRG) ; get the Host File Site of Region selection, return IBCR RC SITE ifn ^ div/site ^ site name ^ id/zip ^ chg type
 N IBX,IBS,IBY S IBX=0
 S IBS=$P($G(CMRG)," ",2)_" "
 S IBY=$O(^XTMP("IBCR RC SITE","B",IBS,0)),IBS=$G(^XTMP("IBCR RC SITE",+IBY))
 I +IBY,IBS'="" S IBX=IBY_U_IBS
 ;
 I 'IBX W !!,"Error:  Site ",$P($G(CMRG)," ",2)," not found in Host Files, can not continue!",!!
 Q IBX
 ;
ASKNWFT(HFRG) ; determine/confirm from user the Facility Type Change based on the current Host File setting
 N IBT,IBN,IBX,DIR,X,Y S IBX=0 S HFRG=$G(HFRG)
 S IBT=+$P(HFRG,U,5),IBN=$P(HFRG,U,2)_" - "_$P(HFRG,U,3)
 ;
 ; if currently Provider Based (1 or 2) then ask to confirm the change to Freestanding (3)
 I (IBT=1)!(IBT=2) D
 . W !!,IBN," is currently Provider Based ",$S(IBT=1:"INPT/SFN/OPT (1)",1:"Outpatient Only (2)"),!
 . S DIR("?")="Must change the Provider Type otherwise do not use this option."
 . S DIR("A")="Do you want to change this site to Freestanding (3)"
 . S DIR(0)="YO" D ^DIR I Y=1 S IBX=3
 ;
 ; if currently Freestanding (3) then ask if change to Provider Based Inpatient (1) or Outpatient (2)
 I IBT=3 D
 . W !!,IBN," is currently Non-Provider Based Freestanding (3)",!
 . S DIR("?")="Must change the Provider Type otherwise do not use this option."
 . S DIR("?",1)="Enter 'I' if Inpatient, SNF and Outpatient charges are required for the site."
 . S DIR("?",2)="Enter 'O' if Outpatient Only charges are required for the site."
 . S DIR("A")="Site will be changed to Provider Based, select Type"
 . S DIR(0)="SO^1:Inpatient/SNF/Outpatient;2:Outpatient" D ^DIR I Y>0 S IBX=+Y
 ;
 Q IBX
 ;
ASKNWDT() ; ask the user for the effective date of the change, return date or 0
 N DIR,X,Y W !
 S DIR("?")="The date the new charges will become effective."
 S DIR("?",1)="Enter the Effective Date of the Facility Type change."
 S DIR("?",2)="This is the date the new charges become available."
 S DIR("?",3)="The old charges (existing) will be inactivated one day before this date."
 S DIR("A")="Effective Date of Facility Type Change"
 S DIR(0)="DO^::AEX" D ^DIR I Y'?7N S Y=0
 Q Y
 ;
 ;
ASKFNL(CMRG,NWDT,NWFT) ; ask user if they really want to make the change, return true if yes
 N DIR,IBRG,IBDV,IBX,IBY,IBOK,X,Y S IBOK=0
 W !,"You have requested current charges for the following Region and Division "
 W !,"be changed from ",$S(NWFT'=3:"Freestanding",1:"Provider Based")," to ",$S(NWFT=3:"Freestanding",1:"Provider Based"),":",!
 ;
 W !,"Billing Region: ",$P(CMRG,U,2),?50,"3-Zip: ",$P(CMRG,U,4),?65,"Type: ",$P(CMRG,U,5)
 W !,"Division: " S IBRG=+CMRG,IBY=0 F  S IBY=$O(^IBE(363.31,IBRG,11,IBY)) Q:'IBY  D
 . S IBDV=$G(^IBE(363.31,IBRG,11,IBY,0)) Q:'IBDV  S IBX=$G(^DG(40.8,+IBDV,0)) W ?16,$P(IBX,U,2),?24,$P(IBX,U,1),!
 ;
 W !!,"Currently loaded ",$S(NWFT'=3:"Freestanding",1:"Provider Based")," charges will be inactivated as of ",$$FMTE^XLFDT($$FMADD^XLFDT(NWDT,-1),2)
 W !,"New ",$S(NWFT=3:"Freestanding",1:"Provider Based")," charges will be loaded with an effective date of ",$$FMTE^XLFDT(NWDT,2),!
 ;
 S DIR("?")="No permanent changes have been made, enter Yes to complete the changes."
 S DIR("A")="Do you want to complete these changes and update your stored charges"
 S DIR(0)="YO" D ^DIR I Y=1 S IBOK=1
 ;
 Q IBOK
 ;
 ;
CHECK(VERS,VSDT,NWDT,CMRG,HFRG,NWFT) ; check the inputs to determine if change is ok
 N IBX,IBC,IBRG,IBDS,IBOK S IBOK=1 S IBDS="",$P(IBDS,"=",IOM+1)="" W !,IBDS,!
 ;
 I VERS'=$$VERSION^IBCRHBRV D  S IBOK=0 G CHECKQ
 . W !,"Error: Version of Host Files loaded is not the current RC version "_VERS_".",!
 ;
 I $P(CMRG,U,3)'=$P(HFRG,U,2) D  S IBOK=0 G CHECKQ
 . W !,"Error: Site Number does not match in Host File and Charge Master"
 . W !,"       for selected Region.  Data inconsistency unresolved.",!
 ;
 I $P(CMRG,U,4)'=$P(HFRG,U,4) D  S IBOK=0 G CHECKQ
 . W !,"Error: Identifier 3-digit zip does not match in Host File and Charge Master"
 . W !,"       for selected Region.  Data inconsistency unresolved.",!
 ;
 I $P(CMRG,U,5)'=$P(HFRG,U,5) D  S IBOK=0 G CHECKQ
 . W !,"Error: Facility Type does not match in Host File and Charge Master"
 . W !,"       for selected Region.  Data inconsistency unresolved.",!
 ;
 I NWFT=$P(HFRG,U,5) D  S IBOK=0 G CHECKQ
 . W !,"Error: Host File Facility Type is the same as the selected Facility Type."
 . W !,"       This would result in no change to the charges.",!
 ;
 I NWFT<3,$P(HFRG,U,5)<3 D  S IBOK=0 G CHECKQ
 . W !,"Error: Host File Facility Type and Selected Facility Type are both"
 . W !,"       Provider Based.  This would result in no change to the charges.",!
 ;
 I NWDT'>VSDT D  S IBOK=0 G CHECKQ
 . W !,"Error: Date entered ",$$FMTE^XLFDT(NWDT,2)," is before v",VERS," effective date ",$$FMTE^XLFDT(VSDT,2),"."
 . W !,"       This option may only be used to change the Facility Type of the"
 . W !,"       current version charges after they are effective.  Use the regular"
 . W !,"       Upload to change charges on ",$$FMTE^XLFDT(VSDT,2),".",!
 ;
 S IBC=","_$$VERSITE^IBCRHBRV($P(HFRG,U,2))_",",IBX=","_VERS_","
 I IBC'[IBX D  S IBOK=0 G CHECKQ
 . W !,"Error: Selected Billing Region ",$P(CMRG,U,2)
 . W !,"       does not have the current version ",VERS," of Reasonable Charges installed."
 . W !,"       This option may only be used to change the current version charges."
 . W !,"       Use the regular Upload option to change charges from previous versions.",!
 ;
 S IBRG=+CMRG,IBC=0,IBX=0 F  S IBX=$O(^IBE(363.31,IBRG,11,IBX)) Q:'IBX  S IBC=IBC+1
 I IBC>1 D  S IBOK=0 G CHECKQ
 . W !,"Error: Selected Billing Region ",$P(CMRG,U,2)
 . W !,"       has more than one Division assigned.  Changing the Facility Type"
 . W !,"       may only be applied to one Division.  The extra Divisions need"
 . W !,"       to be removed from the Billing Region and charges loaded specifically"
 . W !,"       for those sites, usually at least two past versions.",!
 ;
CHECKQ Q IBOK
