IBCRHBA ;ALB/ARH - RATES: UPLOAD HOST FILES (AWP) ; 11-FEB-1997
 ;;2.0;INTEGRATED BILLING;**52,106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
AWP ; OPTION: upload an AVERAGE WHOLESALE PRICE file from a VMS file into ^XTMP
 ;
 N DIR,DIRUT,DUOUT,X,Y,IBI,IBFILE,IBPATH,IBXRF,IBXRF1,IBXRF2,IBFLINE,IBX,IBY
 N IBEFDT,IBNDC,IBNDCO,IBNDCN,IBCHGD,IBCHGC,IBCHG
 W !!,"Upload Average Wholesale Price list from a host file:   'AWP_mmddyy.TXT'"
 ;
 S IBPATH=$$PATH I IBPATH<0 Q
 I '$$FNDHOST(IBPATH) Q
 ;
 S DIR("?")="Enter a AWP Host File Name of format:  'AWP_mmddyy.TXT'"
 S DIR(0)="FO^3:60",DIR("A")="Enter a Host File Name" D ^DIR K DIR Q:$D(DIRUT)  S IBFILE=Y
 ;
 I ($E(IBFILE,1,4)'="AWP_")!($E(IBFILE,5,10)'?6N)!($E(IBFILE,11,14)'=".TXT") W !!,"**** File not an AWP file: must be 'AWP_mmddyy.TXT'.",! Q
 ;
 S IBEFDT=$$GETDT^IBCRU1(2961101) I IBEFDT'?7N Q
 W !!,"All NDC numbers will be added to the Charge Master with the form of: 5n-4n-2n.",!!
 ;
 S IBXRF="IBCR UPLOAD "_IBFILE I '$$CONT(IBXRF) Q
 I '$$CONT1 Q
 ;
 ;
 D OPEN^%ZISH("AWP UPLOAD",IBPATH,IBFILE,"R") I POP W !!,"**** Unable to open ",IBPATH,IBFILE,! Q
 ;
 U IO(0) W !!,"Loading ",IBFILE," into ^XTMP "
 ;
 S IBI=0 F  S IBI=IBI+1 U IO R IBFLINE:5 Q:$$ENDF  D PARSE,STORE I '(IBI#100) U IO(0) W "."
 ;
 D CLOSE^%ZISH("AWP UPLOAD")
 ;
 ;
 W !!,"Done. ",(IBI-1)," lines processed."
 W !,"The following files were created, they will be purged in 2 days:" D DISP1^IBCRHU1(IBXRF)
 Q
 ;
ENDF() N IBX S IBX=1 I $T,IBFLINE'="" S IBX=0
 I $$STATUS^%ZISH S IBX=1
 I IBFLINE?36"9" S IBX=1
 I 'IBX,IBFLINE'?36N D
 . U IO(0)
 . W !!,"**** Error while reading file: line not expected format (36 numeric characters):"
 . W !!,"Line Length=",$L(IBFLINE)," characters" W:IBFLINE="" ?40,"Line read is null"
 . W !,"LINE='",IBFLINE,"'",!!,"Upload Aborted!"
 . S IBX=1 H 7 U IO
 I IBI=1,IBFLINE="" U IO(0) W !!,"First line of file has no data, can not continue!" S IBX=1 H 7 U IO
 Q IBX
 ;
PARSE ; process a single line from a AWP file: parse out into individual fields and store the line in XTMP
 ;
 S IBNDCO=$E(IBFLINE,1,11) ; old NDC #
 S IBNDCN=$E(IBFLINE,12,22) ; new NDC #
 S IBCHGD=$E(IBFLINE,23,25) ; charge, dollars
 S IBCHGC=$E(IBFLINE,26,29) ; charge, cents
 Q
 ;
STORE ;
 S IBXRF1=IBXRF
 S IBXRF2="AWP"
 S IBNDC=IBNDCO I +IBNDCN S IBNDC=IBNDCN
 S IBNDC=$$NDCSET(IBNDC)
 S IBCHG=IBCHGD_"."_IBCHGC
 S IBCHG=+$FN(+IBCHG,"",2)
 ;
 D SET
 ;
 Q
 ;
SET ;
 N IBX S IBX=$G(^XTMP(IBXRF1,0)) I IBX="" D SETHDR
 S $P(^XTMP(IBXRF1,0),U,4)=+$P(IBX,U,4)+1
 S ^XTMP(IBXRF1,IBXRF2)=(+$G(^XTMP(IBXRF1,IBXRF2))+1)_U_3
 S ^XTMP(IBXRF1,IBXRF2,IBI)=IBNDC_U_IBEFDT_U_U_IBCHG
 Q
 ;
SETHDR ;
 N IBX S IBX="IB upload of Host file "_IBFILE_", on "_$$HTE^XLFDT($H,2)_" by "_$P($G(^VA(200,+$G(DUZ),0)),U,1)
 S ^XTMP(IBXRF1,0)=$$FMADD^XLFDT(DT,2)_U_DT_U_IBX
 Q
 ;
CONT(XREF) ; check for existing files stored in XREF with same host file name
 ; returns true if user wants to continue and these files are deleted
 ;
 N ARR,IBX,IBY,IBZ,DIR,DIRUT,DUOUT,X,Y S ARR=0,IBZ=1 W !
 ;
 D DISP1^IBCRHU1(XREF,.ARR)
 ;
 I +ARR S IBZ=0 D  W !
 . W !!,"The above files already exist in XTMP." S DIR("?")="Enter either 'Y' or 'N'.  This files use the same name as the new upload would use and therefore must be deleted before the upload can proceed."
 . S DIR("A")="Delete the above files and continue with upload",DIR(0)="Y" D ^DIR K DIR
 . ;
 . I Y=1 S IBZ=1,IBX="" F  S IBX=$O(ARR(IBX)) Q:IBX=""  K ^XTMP(IBX) W "."
 ;
 Q IBZ
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
 N IBX,IBY,IBZ S IBZ=0
 ;
 W !,"AWP Host files available for upload in ",IBPATH,":",!!
 S IBX("AWP*")="",IBZ=$$LIST^%ZISH(IBPATH,"IBX","IBY")
 I 'IBZ W "**** No AWP files found ",IBPATH,"AWP_mmddyy.TXT, can not continue.",!
 I +IBZ S IBX="" F  S IBX=$O(IBY(IBX)) Q:IBX=""  W ?30,$P(IBX,";",1),!
 Q IBZ
 ;
NDCSET(X) ; parse NDC number:  raw form from VMS file is 11 numbers, parsed to 5n-4n-2n
 N Y S Y="" S Y=$E(X,1,5)_"-"_$E(X,6,9)_"-"_$E(X,10,11)
 Q Y
