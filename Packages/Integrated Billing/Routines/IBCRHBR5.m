IBCRHBR5 ;ALB/ARH - RATES: UPLOAD (RC) CALCULATIONS SETUP ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,138,148,169**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CALCRC(SITE) ; calculate a sites RC charges, create XTMP file that can be loaded into CM
 ; input:  IFN of site in IBCR RC SITE ^ site number ^ site name
 ;
 N IBX,IBXSITE,IBSITE Q:'$G(SITE)  S IBXSITE=+SITE,IBSITE=$P(SITE,U,2)_" "_$P(SITE,U,3)
 I '$D(^XTMP("IBCR RC SITE",IBXSITE))!(IBSITE="") W !!,"Site incompletely defined in upload, can not continue!" Q
 W @IOF,!,"Calculating Reasonable Charges v"_$$VERSION^IBCRHBRV_" for "_IBSITE_":"
 W !,"-------------------------------------------------------------------------------"
 ;
 I '$$CONT("RC "_IBSITE) Q
 ;I '$$CONT1(IBSITE) Q
 ;
 D CGROUP^IBCRHBR
 S IBX=$$RG^IBCRHU2("RC "_$P(SITE,U,2)_" - "_$P(SITE,U,3),$P(SITE,U,2),$P(SITE,U,4)) W !
 ;
 D INPT^IBCRHBR6(+IBXSITE)
 D SNF^IBCRHBR6(+IBXSITE)
 D OPT^IBCRHBR6(+IBXSITE)
 D PCE^IBCRHBR6(+IBXSITE)
 D PCF^IBCRHBR6(+IBXSITE)
 D PCG^IBCRHBR6(+IBXSITE)
 ;
 K ^TMP($J,"IBCR RC CGROUP")
 D LAB^IBCRHBRB ; move selected Lab charges from Physician to Faclity Charge Sets, v1.4 only
 ;
 W !!,"Done.",!!,"The following files were created, they will be purged in 2 days:" D DISP1^IBCRHU1("IBCR UPLOAD RC "_IBSITE)
 ;
 S IBX=$P(IBSITE," ",1) I (IBX?3N1"X"1.3N)!(IBX>899.9)&(IBX'=999) D RESETDV^IBCREE2("RC "_IBX)
 Q
 ;
CONT(SITE) ; check for existing files stored in XTMP with same subscript
 ; returns true if user wants to continue, any existing files are deleted, 0 otherwise
 N ARR,IBX,IBY,IBZ,DIR,DIRUT,DUOUT,X,Y S ARR=0,IBZ=1
 ;
 D DISP1^IBCRHU1("IBCR UPLOAD "_$G(SITE),.ARR)
 ;
 I +ARR S IBZ=0 D
 . W !!,"The above files already exist in XTMP." S DIR("?")="Enter either 'Y' or 'N'.  This files use the same name as the new upload would use and therefore must be deleted before the upload can proceed."
 . S DIR("A")="Delete the above files and continue with upload",DIR(0)="Y" D ^DIR K DIR
 . ;
 . I Y=1 S IBZ=1,IBX="" F  S IBX=$O(ARR(IBX)) Q:IBX=""  K ^XTMP(IBX) W "."
 ;
 Q IBZ
 ;
CONT1(SITE) ; get final OK to start charge calculations, return true if want to continue, 0 if not
 N IBZ,DIR,DIRUT,DUOUT,X,Y S IBZ=0 W !!
 S DIR("?")="Enter either 'Y' or 'N'.  Enter 'Y' if you want to calculate charges for "_$G(SITE)_" into XTMP."
 S DIR("A")="Proceed with calculations now",DIR(0)="Y" D ^DIR K DIR I Y=1 S IBZ=1 W !
 Q IBZ
