IBCRHBT ;LL/ELZ - RATES: UPLOAD HOST FILES (TP) ; 19-MAR-1999
 ;;2.0;INTEGRATED BILLING;**115,140**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TP ; OPTION: upload an IBAT file from a VMS file into ^XTMP
 ;
 N DIR,DIRUT,DUOUT,X,Y,IBI,IBFILE,IBPATH,IBXRF,IBLOC,IBXRF1,IBXRF2,IBFLINE,IBX,IBY,IBTYPE,POP,IBCHRG,IBCODE
 N IBCPT,IBEFDT,IBTRDT,IBINACT,IBMOD,IBCHG,IBPATH
 W !!,"Upload the IBAT from a host file:   'IBATaxxxx.TXT'   w/a = C for CPT or D for DRG",!,?49," & xxxx = year effective",!
 ;
 S IBPATH=$$PATH I IBPATH<0 Q
 I '$$FNDHOST(IBPATH) Q
 ;I '$$FNDHOST Q
 ;
 S DIR("?")="Enter an IBAT Host File Name of format:  'IBATaxxxx.TXT'   w/xxxx = year effective"
 S DIR(0)="FO^3:60",DIR("A")="Enter a Host File Name" D ^DIR K DIR Q:$D(DIRUT)  S IBFILE=Y
 ;
 I $$CHECK(IBFILE) Q
 ;
 ;
 S IBXRF="IBCR UPLOAD "_IBFILE,IBLOC="" I '$$CONT(IBXRF) Q
 I '$$CONT1 Q
 ;
 ;
 D OPEN^%ZISH("IBAT UPLOAD",IBPATH,IBFILE,"R") I POP W !!,"**** Unable to open ",IBPATH,IBFILE,! Q
 ;
 U IO(0) W !!,"Loading ",IBFILE," into ^XTMP "
 ;
 S IBI=0 F  S IBI=IBI+1 U IO R IBFLINE:5 Q:$$ENDF  D PARSE,STORE I '(IBI#100) U IO(0) W "."
 ;
 D CLOSE^%ZISH("IBAT UPLOAD")
 ;
 ;
 W !!,"Done. ",(IBI-1)," lines processed."
 W !,"The following files were created, they will be purged in 2 days:" D DISP1^IBCRHU1(IBXRF)
 Q
 ;
ENDF() N IBX S IBX=1 I $T,IBFLINE'="" S IBX=0
 I $$STATUS^%ZISH S IBX=1
 I 'IBX,IBFLINE'?3U29N D
 . U IO(0)
 . W !!,"**** Error while reading file: line not expected format"
 . W !,"(3 upper case letters & 29 numeric characters):"
 . W !!,"Line Length=",$L(IBFLINE)," characters" W:IBFLINE="" ?40,"Line read is null"
 . W !,"LINE='",IBFLINE,"'",!!,"Upload Aborted!"
 . S IBX=1 H 7 U IO
 I IBI=1,IBFLINE="" U IO(0) W !!,"First line of file has no data, can not continue!" S IBX=1 H 7 U IO
 Q IBX
 ;
PARSE ; process a single line from an IBAT file: parse out into individual fields and store the line in XTMP
 ;
 ; format: 3 alpha letters and 29 numbers
 ;
 S IBTYPE=$E(IBFLINE,1,3) ; type, either CPT or DRG
 S IBCODE=$E(IBFLINE,4,8) ; CPT procedure or DRG code
 I IBTYPE="DRG" S IBCODE=IBTYPE_+IBCODE
 S IBCHRG=$E(IBFLINE,9,16) ; charge
 S IBEFDT=$E(IBFLINE,17,24) ; effective date
 S IBTRDT=$E(IBFLINE,25,32) ; termination date
 S IBCS=$$CS(IBTYPE)
 Q
 ;
STORE ;
 S IBXRF1=IBXRF_"  "_IBLOC
 ;
 S IBMOD="",IBEFDT=$$DATE(IBEFDT),IBINACT="" I IBTRDT'=999999,+IBTRDT S IBINACT=$$DATE(IBTRDT)
 ;
 I +IBCHRG S IBXRF2=IBTYPE,IBCHG=$E(IBCHRG,1,6)_"."_$E(IBCHRG,7,8) D SET ; charge
 ;
 Q
 ;
DATE(X) ; reformats dates
 N Y,DTOUT,%DT
 I X S %DT="X" D ^%DT
 Q $G(Y,X)
SET ;
 N IBX S IBX=$G(^XTMP(IBXRF1,0)) I IBX="" D SETHDR
 S $P(^XTMP(IBXRF1,0),U,4)=+$P(IBX,U,4)+1
 S ^XTMP(IBXRF1,IBXRF2)=(+$G(^XTMP(IBXRF1,IBXRF2))+1)_U_$S(IBTYPE="CPT":2,1:4)_U_IBCS
 S ^XTMP(IBXRF1,IBXRF2,IBI)=IBCODE_U_IBEFDT_U_IBINACT_U_+IBCHG
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
 N IBX,IBY,IBZ,IBQ S (IBZ,IBQ)=0
 ;
 W !,"IBAT Host files available for upload in: ",IBPATH,!!
 S IBX("IBAT*.TXT")="",IBZ=$$LIST^%ZISH(IBPATH,"IBX","IBY")
 I +IBZ S IBQ=IBZ,IBX="" F  S IBX=$O(IBY(IBX)) Q:IBX=""  W ?30,$P(IBX,";",1),!
 K IBX,IBY S IBX("TP*.TXT")="",IBZ=$$LIST^%ZISH(IBPATH,"IBX","IBY")
 I 'IBZ,'IBQ W "**** No IBAT files found ",IBPATH,"IBATaxxxx.TXT, can not continue.",!
 I +IBZ S IBX="" F  S IBX=$O(IBY(IBX)) Q:IBX=""  W ?30,$P(IBX,";",1),!
 Q $S(IBQ:IBQ,1:IBZ)
 ;
CS(X) ; find charge set ien from X (name)
 N IBX S X=$S(X="CPT":"TP-OPT",X="DRG":"TP-INPT",1:""),IBX=0
 I X'="" S IBX=$O(^IBE(363.1,"B",X,IBX))
 Q IBX
 ;
CHECK(IBFILE) ; returns if file name is not in correct format
 N IBZ S IBZ=1
 I ($E(IBFILE,1,4)="IBAT"),(($E(IBFILE,5)="C")!($E(IBFILE,5)="D")),($E(IBFILE,6,9)?4N),($E(IBFILE,10,13)=".TXT") S IBZ=0
 I IBZ,($E(IBFILE,1,2)="TP"),(($E(IBFILE,3)="C")!($E(IBFILE,3)="D")),($E(IBFILE,4,7)?4N),($E(IBFILE,8,11)=".TXT") S IBZ=0
 I IBZ W !!,"****  File not an IBAT file: must be 'IBATaxxxx.TXT'.",!
 Q IBZ
