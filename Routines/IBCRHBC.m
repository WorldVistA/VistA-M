IBCRHBC ;ALB/ARH - RATES: UPLOAD HOST FILES (CMAC DRIVER) ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,124,307**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; USER SELECT FILE, DETERMINE FILE TYPE/FORMAT, CALL LOAD ROUTINE
 ;
CMAC ; OPTION: upload a CMAC file from a VMS file into ^XTMP
 N IBPATH,IBFILE,IBNAME,IBMODP,IBMODT,IBFLINE,IBFORM,IBDONE,IBGLBEFF S IBDONE=""
 ;
 S IBNAME="IBCR UPLOAD " I '$$CONT(IBNAME) Q
 ;
 W !!,"Upload CMAC Host File:  'CMACxxx.TXT' or 'yyyyCMACxxx.TXT'  w/xxx = locality",!
 ;
 S IBPATH=$$PATH I IBPATH<0 Q
 I '$$FNDHOST(IBPATH) Q
 ;
 S IBFILE=$$FILE Q:IBFILE=""
 ;
 S IBMODP=$$MOD("","Professional") I IBMODP<0 Q
 S IBMODT=$$MOD("","Technical") I IBMODT<0 Q
 ;
 D OPEN^%ZISH("CMAC UPLOAD",IBPATH,IBFILE,"R") I POP W !!,"**** Unable to open ",IBPATH,IBFILE,! Q
 ;
 U IO R IBFLINE:5
 ;
 D CLOSE^%ZISH("CMAC UPLOAD")
 ;
 S IBFORM=$$CHKF(IBFLINE,IBFILE) Q:'IBFORM
 ;
 W !!,?14,"File: ",IBFILE,?40,"Effective: ",$$DATE(IBFORM,IBFLINE)
 I '$$CONT1 Q
 ;
 I IBFORM=1 S IBDONE=$$CMAC^IBCRHBC1(IBPATH,IBFILE,IBNAME,IBMODP,IBMODT)
 I IBFORM=2 S IBDONE=$$CMAC^IBCRHBC2(IBPATH,IBFILE,IBNAME,IBMODP,IBMODT)
 I IBFORM=3 S IBDONE=$$CMAC^IBCRHBC3(IBPATH,IBFILE,IBNAME,IBMODP,IBMODT)
 ;
 W !!,"Done. ",$P(IBDONE,U,1)," lines processed."
 W !,"The following files were created, they will be purged in 2 days:" D DISP1^IBCRHU1($P(IBDONE,U,2))
 Q
 ;
CHKF(LINE,FILE) ; check that first line of file fits one of the three formats, if it does return the format type, otherwise 0
 N IBX,IBY S LINE=$G(LINE),FILE=$G(FILE),IBX=0
 S IBY="**** Error reading file: not expected format (85, 91 or 98 numeric characters):"
 ;
 I (FILE'?1"CMAC"3N1".TXT"),(FILE'?4N1"CMAC"3N1".TXT") W !!,IBY,!!,"Bad file name, can not continue!" G CHKFQ
 I LINE="" W !!,IBY,!!,"First line of file is null, can not continue!" G CHKFQ
 ; 
 I $$LNFORM^IBCRHBC1(LINE) S IBX=1 G CHKFQ
 I $$LNFORM^IBCRHBC2(LINE) S IBX=2 G CHKFQ
 I $$LNFORM^IBCRHBC3(LINE) S IBX=3 G CHKFQ
 ;
 W !!,IBY,!,"Line Length=",$L(LINE)," characters",!!,"LINE='",LINE,"'",!!,"Can not Continue!"
 ;
CHKFQ Q IBX
 ;
CONT(XREF) ; check for existing files stored in XREF with same host file name
 ; returns true if user wants to continue and these files are deleted
 ;
 N ARR,IBX,IBY,IBZ,DIR,DIRUT,DUOUT,X,Y S XREF=$G(XREF),ARR=0,IBZ=1 W !
 ;
 D DISP1^IBCRHU1(XREF,.ARR)
 ;
 I +ARR S IBZ=0 D  W !
 . W !!,"The above files already exist in XTMP." S DIR("?")="Enter either 'Y' or 'N'.  These files use the same names as the new upload would use, and therefore must be deleted before the upload can proceed."
 . S DIR("A")="Delete the above files and continue with upload",DIR(0)="Y" D ^DIR K DIR
 . ;
 . I Y=1 S IBZ=1,IBX="" F  S IBX=$O(ARR(IBX)) Q:IBX=""  K ^XTMP(IBX) W "."
 ;
 Q IBZ
 ;
MOD(DEFAULT,NAME) ; get the modifiers to use with the professional and technical component charges
 ;
 N IBX,DIR,DIRUT,DUOUT,DTOUT,X,Y S IBX=""
 S DIR("?",1)="Some procedures have charges broken into professional and technical components."
 S DIR("?",2)="To bill these components a CPT Modifier must be added with the CPT."
 S DIR("?",3)="If no modifier is entered the "_NAME_" Component charges will not be uploaded."
 S DIR("?")="Enter the CPT Modifier that should be used for every "_NAME_" component charge.",DIR("?",4)=""
 ;
 S DIR("A")=NAME_" Component Modifier",DIR("B")=$G(DEFAULT)
 S DIR(0)="PO^DIC(81.3," D ^DIR K DIR I Y>0 S IBX=+Y
 I $D(DUOUT)!$D(DTOUT) S IBX=-1
 I 'IBX W !!,?7,NAME," Component charges will not be uploaded.",!
 ;
 Q IBX
 ;
CONT1() ; get final OK to start upload
 N IBZ,DIR,DIRUT,DUOUT,X,Y S IBZ=0 W !
 S DIR("A")="Proceed with upload now",DIR(0)="Y" D ^DIR K DIR I Y=1 S IBZ=1
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
FNDHOST(IBPATH) ; find and display any host files available for upload: 1 if some, 0 none found
 N IBX,IBY,IBZ,IBI,IBCYR,X,Y S IBPATH=$G(IBPATH),IBZ=0
 ;
 S IBX("CMAC*")="",IBCYR=$S($E(DT)=2:19,1:20)_$E(DT,2,3) F IBI=IBCYR:-1:(IBCYR-10) S IBX(IBI_"CMAC*")=""
 ;
 W !,"CMAC Host files available for upload in: ",IBPATH,!!
 S IBZ=$$LIST^%ZISH(IBPATH,"IBX","IBY")
 I 'IBZ W "**** No CMAC files found ",IBPATH,"CMACxxx.TXT or yyyyCMACxxx.TXT, can not continue.",!
 I +IBZ S IBX="" F  S IBX=$O(IBY(IBX)) Q:IBX=""  W ?30,$P(IBX,";",1),!
 Q IBZ
 ;
FILE() ; get name of file to be loaded, returns null or file name in 'CMACxxx.TXT' or 'yyyyCMACxxx.TXT' format
 N DIR,DIRUT,DUOUT,DTOUT,X,Y,IBX,IBY S (IBY,IBX)=""
 S DIR("?")="Enter a CMAC Host File Name of format: 'CMACxxx.TXT' or 'yyyyCMACxxx.TXT'  w/xxx = locality and w/yyyy = year charges effective"
 S DIR(0)="FO^3:60",DIR("A")="Enter a Host File Name" D ^DIR K DIR I '$D(DIRUT) S IBY=Y
 ;
 I IBY'="",($E(IBY,1,4)="CMAC"),($E(IBY,5,7)?3N),($E(IBY,8,999)=".TXT") S IBX=IBY
 I IBY'="",($E(IBY,1,4)?4N),($E(IBY,5,8)="CMAC"),($E(IBY,9,11)?3N),($E(IBY,12,999)=".TXT") S IBX=IBY
 ;
 I IBY'="",IBX="" W !!,"**** File not a CMAC file: must be 'CMACxxx.TXT' or 'yyyyCMACxxx.TXT'.",!
 ;
 Q IBX
 ;
DATE(FORM,LINE) ; return file formated date in FM format, returns null or file date in FM format
 N IBX S LINE=$G(LINE),FORM=$G(FORM),(IBGLBEFF,IBX)=""
 I FORM=1 S IBX=$$LNDT^IBCRHBC1(LINE)
 I FORM=2 S IBX=$$LNDT^IBCRHBC2(LINE)
 I FORM=3 S IBX=$$LNDT^IBCRHBC3(LINE)
 I IBX'="" S IBGLBEFF=IBX,IBX=$$FMTE^XLFDT(IBX)
 Q IBX
