IBCRHBS1 ;ALB/ARH - RATES: UPLOAD HOST FILES (RC 2+) SETUP ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
HOSTLOAD(VERS) ; upload national REASONABLE CHARGES files from Host files into ^XTMP
 ;
 N X,Y,IBFILES,IBPATH,IBFILE,IBNODE,IBOK S IBOK=0,VERS=+$G(VERS)
 W @IOF,!,"Upload National Reasonable Charges v"_VERS_" Host Files to Temporary Vista files"
 W !,"--------------------------------------------------------------------------------",!
 ;
 S IBPATH=$$PATH I IBPATH<0 G HLEND
 ;
 D FILES^IBCRHBRV(.IBFILES,VERS) ;          list of files to be loaded
 ;
 I '$$FNDHOST(.IBFILES,IBPATH) G HLEND ;    all host files found
 ;
 I '$$CONT(.IBFILES) G HLEND
 I '$$CONT1 G HLEND
 ;
 W @IOF,!,"Loading National Reasonable Charges v"_VERS_" Host Files into temporary local file"
 W !,"--------------------------------------------------------------------------------"
 ;
 S IBOK=1,IBFILE="" F  S IBFILE=$O(IBFILES(IBFILE)) Q:IBFILE=""  D  I 'IBOK Q
 . S IBNODE=IBFILES(IBFILE)
 . I $$LOAD^IBCRHBS2(IBPATH,IBFILE,$P(IBNODE,U,1),$P(IBNODE,U,2),VERS,$P(IBNODE,U,3)) Q
 . W !!,"   Error while processing host file, can not continue!",!! S IBOK=0
 ;
 I +IBOK W !!,"Upload of Reasonable Charges v"_VERS_" Host Files Complete.",!
 I +$$FNDXTMP(.IBFILES) D
 . W !!,"The following files were created in XTMP, they will be purged in 2 days:"
 . W !,"------------------------------------------------------------------------" D DSPXTMP(.IBFILES)
HLEND Q IBOK
 ;
CONT(FILES) ; check for existing files stored in XTMP with same subscript
 ; returns true if user wants to continue, any existing files are deleted
 ;
 N ARR,IBX,IBZ,DIR,DIRUT,DUOUT,X,Y S IBZ=1
 ;
 I +$$FNDXTMP(.FILES) D
 . S IBZ=0 W !!,"These files already exist in XTMP:",!,"----------------------------------"
 . ;
 . D DSPXTMP(.FILES,.ARR) Q:$D(ARR)<10  W !
 . S DIR("?")="Enter either 'Y' or 'N'.  These files use the same name as the new upload would use and therefore must be deleted before the upload can proceed."
 . S DIR("A")="Delete the above files and continue with the upload",DIR(0)="Y" D ^DIR K DIR
 . ;
 . I Y=1 S IBZ=1,IBX="IBCR RC" F  S IBX=$O(^XTMP(IBX)) Q:IBX'["IBCR RC"  K ^XTMP(IBX) W "."
 ;
 Q IBZ
 ;
CONT1() ; get final OK to start upload, return true if want to continue with upload
 N IBZ,DIR,DIRUT,DUOUT,X,Y S IBZ=0 W !!
 S DIR("?")="Enter either 'Y' or 'N'.  Enter 'Y' if you want to load the Reasonable Charges Host files into XTMP."
 S DIR("A")="Proceed with upload of National Reasonable Charges Host Files now",DIR(0)="Y" D ^DIR K DIR I Y=1 S IBZ=1
 Q IBZ
 ;
PATH() ; return directory or -1
 N IBPATH,DIR,DIRUT,DUOUT,X,Y S IBPATH=""
 S DIR("?",1)="Enter the full path specification where the host files may be found"
 S DIR("?")="or press return for the default directory "_$$PWD^%ZISH
 S DIR(0)="FO^3:60",DIR("A")="Enter the file path",DIR("B")=$$PWD^%ZISH D ^DIR K DIR
 S IBPATH=$S($D(DUOUT)!$D(DTOUT):-1,1:Y)
 Q IBPATH
 ;
FNDXTMP(FILES) ; find if any existing files in XTMP, return true if any found
 N IBFILE,IBXRF,IBNODE,IBZ S IBZ=0
 ;
 S IBFILE="" F  S IBFILE=$O(FILES(IBFILE)) Q:IBFILE=""  D  Q:+IBZ
 . S IBXRF="IBCR RC "_$P(FILES(IBFILE),U,2) Q:$D(^XTMP(IBXRF))=0  S IBZ=1
 Q IBZ
 ;
DSPXTMP(FILES,ARR) ; display any existing files in XTMP, ARR passed by ref can be used to get list of existing file subscripts
 N IBFILE,IBXRF,IBNODE,IBY K ARR
 ;
 S IBFILE="" F  S IBFILE=$O(FILES(IBFILE)) Q:IBFILE=""  D
 . S IBXRF="IBCR RC "_$P(FILES(IBFILE),U,2) I $D(^XTMP(IBXRF))=0 Q
 . S ARR(IBXRF)="",IBNODE=$G(^XTMP(IBXRF,0)),IBY=$S($P(IBNODE,U,3)="":IBXRF,1:$P(IBNODE,U,3))
 . W !,?4,$E(IBY,1,67),?74,$P(IBNODE,U,5)
 Q
 ;
FNDHOST(FILES,IBPATH) ; find and display any Host files available for upload, return true if all required files found
 N IBX,IBY,IBZ,IBF,IBFILE,X,Y S IBF=1
 W !!,"Reasonable Charges Host Files found: ",?44,IBPATH,!,"------------------------------------"
 ;
 I $O(FILES(""))="" S IBF=0
 ;
 S IBFILE="" F  S IBFILE=$O(FILES(IBFILE)) Q:IBFILE=""  D
 . S IBX(IBFILE)="",IBZ=$$LIST^%ZISH(IBPATH,"IBX","IBY") K IBX,IBY
 . W !,$P(FILES(IBFILE),U,1),":",?45,IBFILE I 'IBZ W ?57,"*** not found ***" S IBF=0
 ;
 I 'IBF W !!,"Can not find all required host files, can not continue!",!!
 I +IBF W !!,"All required host files found.",!
 Q IBF
