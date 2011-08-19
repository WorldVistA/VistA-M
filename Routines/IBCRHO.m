IBCRHO ;ALB/ARH - RATES: UPLOAD CHECK & ADD TO CM REPORT ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,138,148,307**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTRY(ADD) ; OPTION:  check validity of data in uploaded files and add to Charge Master
 ;
 W !!,"Check files waiting to be loaded into the Charge Master for data validity."
 D DISP1^IBCRHU1("",.IBA1,"",1) I 'IBA1 W !,"No files in XTMP." G EXIT
 ;
 I +$G(ADD),'$$CONT G EXIT
 ;
 ;get the device
 W !!,"Report requires 120 columns"
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="RPT^IBCRHO",ZTDESC="IBCR UPLOAD REPORT",ZTSAVE("ADD")=+$G(ADD) D ^%ZTLOAD K IO("Q") G EXIT
 ;
 ;
RPT N IBX,IBQUIT S IBQUIT=0 K ^TMP($J)
 D GETXTMP^IBCRHU1("",.IBA1,"",1)
 S IBX="" F  S IBX=$O(IBA1(IBX)) Q:IBX=""  D SRCH^IBCRHL(IBX,+$G(ADD))  S IBQUIT=$$STOP Q:IBQUIT
 ;
 I 'IBQUIT,+$G(ADD) S IBX=$O(IBA1("")) I IBX'="" S IBX=$G(IBA1(IBX)) I IBX["RC v1 " D CPT2000^IBCRHBRA
 I 'IBQUIT,+$G(ADD) S IBX=$O(IBA1("")) I IBX'="" S IBX=$G(IBA1(IBX)) I IBX["RC " S IBX=$$CSEMPTY^IBCRED("RC")
 I 'IBQUIT,+$G(ADD) S IBX=$O(IBA1("")) I IBX'="" S IBX=$G(IBA1(IBX)) I IBX["CMAC" S IBX=$$CSEMPTY^IBCRED("CM")
 ;
 I 'IBQUIT D PRNT
 ;
EXIT ;clean up and quit
 K ^TMP($J),IBA1 Q:$D(ZTQUEUED)  D ^%ZISC
 Q
 ;
PRNT ; print report
 N IBFILE,IBSUB,IBX,IBY,IBLN,IBCNT,IBPG,IBTIME,IBQUIT,DIR,DIRUT,X,Y S IBTIME=$H
 U IO
 Q:$$HDR
 S IBFILE="" F  S IBFILE=$O(^TMP($J,IBFILE)) Q:IBFILE=""  D  Q:IBQUIT
 . W !!,?15,IBFILE S IBCNT=IBCNT+2
 . S IBSUB="" F  S IBSUB=$O(^TMP($J,IBFILE,IBSUB)) Q:IBSUB=""  D  S:IBCNT>(IOSL-5) IBQUIT=$$HDR Q:IBQUIT
 .. S IBLN=$G(^TMP($J,IBFILE,IBSUB))
 .. W !!,IBSUB,?20,$P(IBLN,U,2),! S IBCNT=IBCNT+4
 .. I $P(IBLN,U,3)'="" W ?20,$P(IBLN,U,3),! S IBCNT=IBCNT+1
 .. I $P(IBLN,U,4)'="" W ?20,$P(IBLN,U,4),! S IBCNT=IBCNT+1
 .. ;
 .. S IBX=0 F  S IBX=$O(^TMP($J,IBFILE,IBSUB,IBX)) Q:'IBX  D  S:IBCNT>(IOSL-5) IBQUIT=$$HDR Q:IBQUIT
 ... S IBY=$P(^TMP($J,IBFILE,IBSUB,IBX),U,2)
 ... W !,?5,IBX,?10," = ",$G(^XTMP(IBFILE,IBSUB,IBX)),?50,$E(IBY,1,69) S IBCNT=IBCNT+1
 ... S IBY=$E(IBY,70,999) I IBY'="" W !,?70,IBY S IBCNT=IBCNT+1
 ;
 I 'IBQUIT,IBCNT>(IOSL-12) S IBQUIT=$$HDR
 I 'IBQUIT D
 . W !!,"SUBFILE/SET ERROR:",?20,"This error results when a problem is found in the definition of the subfile that has been uploaded",!,"or the Charge Set that has been assigned to it.  All processing of the subfile"
 . W " is stopped, no part of the subfile will",!,"be loaded into the Charge Master."
 . W !!,"LINE/DATA ERROR:",?20,"A data error in a required field has been found in a line read from the file.  The chargeable item",!,"defined by that line will be ignored, it will NOT be added to the Charge Master."
 . W !!,"LINE/DATA WARNING:",?20,"A data error in a non-required field has been found in a line read from the file.  The chargeable",!,"item defined by that line will be ignored, it will NOT be added to the Charge Master."
 . W !!,"Records found that are duplicates of existing charge entries or have a 0 charge are NOT added nor reported individually."
 Q
 ;
PAUSE ;pause at end of screen if being displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
CONT() ; returns true if user wants to add the files to the Charge Master
 N IBZ,DIR,DIRUT,DUOUT,X,Y S IBZ=0
 S DIR("A")="Load the above files into the Charge Master",DIR(0)="Y" D ^DIR K DIR I Y=1 S IBZ=1
 I +IBZ W !,"A summary report of the results will be printed.",!
 Q IBZ
 ;
HDR() ;print the report header
 S IBQUIT=0,IBPG=$G(IBPG)+1,IBCNT=3
 S IBQUIT=$$STOP G:IBQUIT HDRQ I IBPG>1 D PAUSE G:IBQUIT HDRQ
 W @IOF
 I +$G(ADD) W !,"IB Upload Summary Report of Charge Items Loaded into the Charge Master"
 I '$G(ADD) W !,"IB Upload Data Validity Check on Temporary files"
 W ?75,$$HTE^XLFDT(IBTIME,2)_"  Page ",IBPG
 W !,"---------------------------------------------------------------------------------------------------"
HDRQ Q IBQUIT
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPG) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
