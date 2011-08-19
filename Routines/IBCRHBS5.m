IBCRHBS5 ;ALB/ARH - RATES: UPLOAD (RC 2+) CALCULATIONS DRIVER ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CALCRC(SITE) ; calculate a sites RC charges, create XTMP file that can be loaded into CM
 ; input:  IFN of site in IBCR RC SITE ^ site number ^ site name ^ 3-digit zip ^ type
 ;
 N IBX,IBSITE,IBRG Q:'$G(SITE)  S IBSITE=$P(SITE,U,2)_" "_$P(SITE,U,3) K ^TMP($J,"IBCR UPLOAD FS PROF")
 I '$D(^XTMP("IBCR RC SITE",+SITE))!(IBSITE="")!($P(SITE,U,4)'?3N)!('$P(SITE,U,5)) W !!,"Site incompletely defined in upload, can not continue!" Q
 W @IOF,!,"Calculating Reasonable Charges v"_$$VERSION^IBCRHBRV_" for "_IBSITE_":"
 W !,"-------------------------------------------------------------------------------"
 ;
 I '$$CONT("RC "_IBSITE) Q
 ;
 S IBXRF1="IBCR UPLOAD RC "_$P(SITE,U,2)_" "_$P(SITE,U,3) K ^XTMP(IBXRF1)
 ;
 ;
 S TYPE=$P(SITE,U,5) Q:'TYPE
 ;
 I TYPE=1 D
 . D INPT^IBCRHBS6(SITE,IBXRF1)
 . D OPT^IBCRHBS6(SITE,IBXRF1)
 . D A^IBCRHBS7(SITE,IBXRF1)
 . D B^IBCRHBS7(SITE,IBXRF1)
 . D C^IBCRHBS7(SITE,IBXRF1)
 ;
 I TYPE=2 D
 . D OPT^IBCRHBS6(SITE,IBXRF1)
 . D B^IBCRHBS7(SITE,IBXRF1)
 . D C^IBCRHBS7(SITE,IBXRF1)
 ;
 I TYPE=3 D
 . D FREE^IBCRHBS6(SITE,IBXRF1)
 . D B^IBCRHBS7(SITE,IBXRF1)
 . D C^IBCRHBS7(SITE,IBXRF1)
 . D FA^IBCRHBS7(SITE,IBXRF1)
 ;
 ;
 W !!,"Done.",!!,"The following files were created, they will be purged in 2 days:" D DISP1^IBCRHU1("IBCR UPLOAD RC "_IBSITE)
 ;
 K ^TMP($J,"IBCR UPLOAD FS PROF")
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
