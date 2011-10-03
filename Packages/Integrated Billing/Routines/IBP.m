IBP ;ALB/CPM - ARCHIVE/PURGING OPERATIONS ; 17-APR-92
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FIND ; Entry point to Find Billing Data to Archive
 S IBOP=1 G START
 ;
ARCHIVE ; Entry point to Archive Billing Data
 S IBOP=2 G START
 ;
PURGE ; Entry point to Purge Billing Data
 S IBOP=3
 ;
 ;
START ; Begin search/archive/purge operations.
 I $$NODUZ^IBPU1 G END ; no DUZ code
 I IBOP>1,$$NOESIG^IBPU1(DUZ) G END ; no Electronic Signature Code
 S IBLINE="",$P(IBLINE,"-",80)=""
 ;
 ; - write header
 D HOME^%ZIS
 S IBHDR="***   "_$P("Find^Archive^Purge","^",IBOP)_" Billing Data"_$S(IBOP=1:" to Archive",1:"")_"   ***"
 W @IOF,!?80-$L(IBHDR)\2,IBHDR,!
 W !,"This option is used to ",$P("begin the archive process for^archive data from^purge data from","^",IBOP)," the following files:",!
 W !?8,"#350   INTEGRATED BILLING ACTION",!?8,"#351   MEANS TEST BILLING CLOCK",!?8,"#399   BILL/CLAIMS",!!
 I IBOP=1 W "Specify your search criteria for each file.  "
 W "The ",$P("search^archiving process^purge process","^",IBOP)," will be queued.",!
 ;
 ; - issue all operational prompts
 K IBD
 F I=350,351,399 W !,IBLINE S J=$$ASK^IBPU(I,IBOP) G:J<0 END I J S IBD(I)="" I IBOP=1 S K=$$DAT^IBPU G:K<0 END S IBD(I)=K_"^"_+$P(J,"^",2)
 I '$D(IBD) X "F I=$Y:1:(IOSL-3) W !" S DIR(0)="E" D ^DIR K DIR G END
 ;
 ; - select device if archiving
 I IBOP=2 S %ZIS="N",%ZIS("B")="",%ZIS("A")="Archive entries to what device: " D ^%ZIS G:POP END
 ;
 ; - must enter Electronic Signature to archive or purge
 I IBOP>1,'$$ESIG^IBPU1(DUZ) G END
 ;
 ; - if ok to continue, task off job
 I $$OKAY^IBPU1(IBOP) D TASK^IBPU1
 ;
END ; - clean up and quit
 D HOME^%ZIS
 K I,IBD,IBHDR,IBLINE,IBOP,J,K,Y
 Q
 ;
 ;
 ;
QUE ; Tasked Entry point to begin search/archive/purge operations.
 ;
 ;  Input:  IBD(file number) --  piece 1:  date through which to archive
 ;                               piece 2:  log entry if restarting
 ;                      IBOP --  1 (Search), 2 (Archive), 3 (Purge)
 ;                       DUZ --  user ID; retained by Taskman
 ;
 ; - perform operation on each requested file
 S IBF="" F  S IBF=$O(IBD(IBF)) Q:'IBF  D @("^IBP"_$P("F^A^P","^",IBOP))
 ;
 ; - send confirmation message to user
 D ^IBPUBUL
 ;
 ; - clean up and quit
 K DFN,DATE,IBBDT,IBCNT,IBD,IBDATA,IBEDT,IBF,IBFNAME,IBHDT,IBLINE,IBLOG,IBN,IBOFF,IBOP,IBPAGE,IBROOT,IBSTAT,IBTMDA,IBTMPL,IBRCNO
 Q
