PRCPPOLM ;WISC/RFJ-receive purchase order (list manager)            ; 6/13/01 5:52pm
 ;;5.1;IFCAP;**34,87**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "PW"'[PRCP("DPTYPE") W !,"YOU MUST BE A WAREHOUSE OR PRIMARY INVENTORY POINT TO USE THIS OPTION." Q
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 N %,PRCPFCOS,PRCPFLAG,PRCPINPT,PRCPORDN,PRCPORDR,PRCPPARD,PRCPPART,PRCPTYPE,PRCPVEND,PRCPVENN,PRCPM,X,Y
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
AUTH S PRCPINPT=PRCP("I"),PRCPTYPE=PRCP("DPTYPE")
 S:$G(PRCHAUTH) PRCPORDR=PRCHPO
 D:$G(PRCHAUTH)  I '$G(PRCHAUTH) F  S PRCPORDR=$$SELECTPO^PRCPPOU1(PRCPINPT) Q:PRCPORDR<1  D
 .   S PRCPORDN=$P($G(^PRC(442,PRCPORDR,0)),"^") I PRCPORDN="" W !,"ERROR - INVALID OR MISSING PURCHASE ORDER NUMBER !" Q
 .   S PRCPVEND=+$G(^PRC(442,PRCPORDR,1)),PRCPVENN=$P($G(^PRC(440,PRCPVEND,0)),"^")
 .   I PRCPVEND="" W !,"ERROR - INVALID OR MISSING VENDOR ON THIS PURCHASE ORDER !" Q
 .   L +^PRC(442,PRCPORDR):5 I '$T D SHOWWHO^PRCPULOC(442,PRCPORDR,0) Q
 .   I $G(PRCHAUTH) S PRCPPART=PRCHRPT G JMP
 .   ;I '$D(^PRC(442,PRCPORDR,11,0)) G JMP ; functionality modified 9/15/05 T.Holloway.
 .   ; if level 11 does not exist the old code would jump over the part that creates PRCPPART.
 .   ; PRCPPART is a required variable later in the application and items without it should not continue.
 .   ; 7 lines of code are added to detect and handle the situation.  T.Holloway
 .   I '$D(^PRC(442,PRCPORDR,11,0)) D  D UNLOCK Q
 . .   S PRCPM=$P($G(^PRC(442,PRCPORDR,0)),U,2),PRCPM=$P(^PRCD(442.5,PRCPM,0),U,2)
 . .   I (PRCPM="PC")&($P($G(^PRC(442,PRCPORDR,23)),U,15)="N") D
 . . .   W !!,"Sorry, this Purchase Card order has been marked 'No Receiving Required'"
 . . .   W !,"and has been Reconciled as COMPLETE ORDER RECEIVED: YES."
 . . .   W !,"It may not be received into inventory in this status."
 . .   E  W !!,"No Partial on file, further processing not allowed."
 .   S FINALREC=""
 .   S FINALREC=$P($G(^PRC(442,PRCPORDR,11,0)),"^",4)
 .   I FINALREC'=""  D
 .   . I $P($G(^PRC(442,PRCPORDR,11,FINALREC,0)),"^",16)=""  D
 .   . .;;  show partials not received yet
 .   . . W !!,"PARTIALS NOT YET RECEIVED:"
 .   K FINALREC
 .   S %=0 F  S %=$O(^PRC(442,PRCPORDR,11,%)) Q:'%  I $P($G(^(%,0)),"^",16)="" S Y=$P(^(0),"^") D DD^%DT W !?5,"PARTIAL #: ",%,?28,"DATE: ",Y I $P($G(^PRC(442,PRCPORDR,11,%,0)),"^",9)="F" W ?55,"FINAL RECEIPT"
 .   S PRCPPART=$$PARTIAL^PRCPPOU1(PRCPORDR) I PRCPPART<0 D UNLOCK Q
 .   S PRCPPARD=$P($G(^PRC(442,PRCPORDR,11,PRCPPART,0)),"^") I 'PRCPPARD W !,"ERROR - CANNOT FIND PARTIAL DATE FOR THIS PARTIAL !" D UNLOCK Q
JMP .   D EN^VALM("PRCP PURCHASE ORDER RECEIPT")
 .   D UNLOCK
 Q
 ;
 ;
UNLOCK ;  unlock po
 D CLEAR^PRCPULOC(442,PRCPORDR,0)
 L -^PRC(442,PRCPORDR)
 Q
 ;
 ;
HDR ;  build header
 N DATA,FLAG,SPACE,Y
 S DATA=$G(^PRC(442,PRCPORDR,11,PRCPPART,0)),FLAG=$S($P(DATA,"^",9)="F":"FINAL  ",1:""),FLAG=FLAG_$S($P(DATA,"^",10)="Y":"OVERAGE",1:"")
 S Y=$P(DATA,"^") D DD^%DT
 S SPACE="                                                             "
 S VALMHDR(1)=$E("INVENTORY: "_$$INVNAME^PRCPUX1(PRCPINPT)_SPACE,1,30)_$E("  PO: "_PRCPORDN_SPACE,1,20)_$E("VENDOR: "_PRCPVENN_SPACE,1,22)_"#"_PRCPVEND
 S VALMHDR(2)=$E("PARTIAL: "_PRCPPART_SPACE,1,14)_$E("DATE: "_Y_SPACE,1,19)_$E("LINECNT: "_$P(DATA,"^",14)_SPACE,1,14)_$E("TOTAL AMT: "_$P(DATA,"^",12)_SPACE,1,25)_FLAG
 S VALMHDR(3)="LINE DESCRIPTION          IM#   POQTY CONV  RECQTY   AVGCOST  UNITCOST   TOTCOST"
 Q
 ;
 ;
INIT ;  build array
 ;  clean up before entry
 K ^TMP($J,"PRCPPOLMCOS")
 D REBUILD^PRCPPOLB
 Q
 ;
 ;
EXIT ;  exit
 K ^TMP($J,"PRCPPOLM"),^TMP($J,"PRCPPOLMCOS"),^TMP($J,"PRCPPOLMREC")
 Q
