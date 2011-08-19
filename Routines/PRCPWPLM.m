PRCPWPLM ;WISC/RFJ-whse post issue book (list manager)              ;13 Jan 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN POST ISSUE BOOKS!" Q
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 I '$D(^PRC(442.6,"B",PRC("SITE")_"-I"_$E(PRC("FY"),2))) D  Q
 .   K X S X(1)="Before you can post issue books you need to set up a common numbering series for issue books.  The common numbering series should be in the form '460-I4' where 460 is the station number and 4 is the fiscal year."
 .   S X(2)="For this station and fiscal year, set up the common numbering series: "_PRC("SITE")_"-I"_$E(PRC("FY"),2)
 .   D DISPLAY^PRCPUX2(5,75,.X)
 N PRCPDA,PRCPFERR,PRCPFINL,PRCPFNSN,PRCPFPRI,PRCPIBNM,PRCPINPT,PRCPORD,PRCPPRIM,PRCPPVNO,X,Y
 S PRCPINPT=PRCP("I")
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
 S PRCPPVNO=+$O(^PRC(440,"AC","S",0))_";PRC(440," I '$D(^PRC(440,+PRCPPVNO,0)) W !!,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE." Q
 F  S PRCPDA=$$SELECTIB(1) Q:PRCPDA<1  D
 .   L +^PRCS(410,PRCPDA):5 I '$T D SHOWWHO^PRCPULOC(410,PRCPDA,0) Q
 .   D ADD^PRCPULOC(410,PRCPDA,0,"Post Issue Book")
 .   I $P($G(^PRCS(410,PRCPDA,9)),"^",3)'="" W !,"*** THIS TRANSACTION NUMBER WAS JUST MADE A 'FINAL' ***" D UNLOCK Q
 .   S PRCPIBNM=$P(^PRCS(410,PRCPDA,0),"^")
 .   S PRCPPRIM=$P($G(^PRCS(410,PRCPDA,0)),"^",6)
 .   ;  primary inventory point not attached to issue book
 .   I '$D(^PRCP(445,+PRCPPRIM,0)) D  I 'PRCPPRIM D UNLOCK Q
 .   .   W !,"NOT A VALID PRIMARY INVENTORY POINT ('",$S(PRCPPRIM="":"<<NO ENTRY>>",1:PRCPPRIM),"')."
 .   .   F  S PRCPPRIM=+$$TO^PRCPUDPT(PRCP("I")) Q:'PRCPPRIM  D  Q:PRCPPRIM
 .   .   .   S XP="  ARE YOU SURE YOU WANT TO USE THIS INVENTORY POINT FOR DISTRIBUTION",XH="ENTER 'YES' TO USE THIS INVENTORY POINT, 'NO' TO SELECT ANOTHER INVENTORY POINT."
 .   .   .   I $$YN^PRCPUYN(1)'=1 S PRCPPRIM=0 Q
 .   .   .   S $P(^PRCS(410,PRCPDA,0),"^",6)=PRCPPRIM
 .   ;
 .   S PRCPFPRI=$S($P($G(^PRCP(445,PRCPPRIM,0)),"^",16)="N":0,1:1)
 .   K X S X(1)="Distribution to Primary Inventory Point: "_$P($$INVNAME^PRCPUX1(PRCPPRIM),"-",2,99)_"  "_$S('PRCPFPRI:"***NOT UPDATED DURING POSTING***",1:"") D DISPLAY^PRCPUX2(5,75,.X)
 .   ;
 .   ;  get voucher number
 .   S PRCPORD=$P($G(^PRCS(410,PRCPDA,445)),"^")
 .   K X S X(1)="Reference Voucher Number: "_PRCPORD
 .   I PRCPORD="" K X S X(1)="This is the FIRST time this issue book has been POSTED.  The reference voucher number will automatically be generated from the common numbering series when the issue book is posted."
 .   D DISPLAY^PRCPUX2(5,75,.X)
 .   D R^PRCPUREP
 .   S PRCPFNSN=+$G(^DISV(DUZ,"PRCPWPLM","SHOWNSN"))
 .   K PRCPFINL
 .   D EN^VALM("PRCP ISSUE BOOK POSTING")
 .   D UNLOCK
 Q
 ;
 ;
UNLOCK ;  unlock issue book
 D CLEAR^PRCPULOC(410,PRCPDA,0)
 L -^PRCS(410,PRCPDA)
 Q
 ;
 ;
INIT ;  build array
 K ^TMP($J,"PRCPWPLMPOST")
 D REBUILD^PRCPWPLB
 Q
 ;
 ;
HDR ;  header
 N SPACE
 S SPACE="                                                                                "
 S VALMHDR(1)=$E("ISSUE BOOK: "_PRCPIBNM_"   POST TO: "_$E($$INVNAME^PRCPUX1(PRCPPRIM),1,15)_" "_$S('$G(PRCPFPRI):"**NOT UPDATED DURING POSTING**",1:"")_SPACE,1,69)_$S($G(PRCPFINL):"** FINAL **",1:"")
 S VALMHDR(2)=$E("  REF#: "_$S($G(PRCPORD)="":"to be generated",1:PRCPORD)_SPACE,1,32)_"UNIT       QTY  ESTIMATE * * Q U A N T I T Y * *"
 S VALMHDR(3)="LINE DESCRIPTION          IM#    /IS    ONHAND  UNITCOST ORDERED  REMAIN TO POST"
 Q
 ;
 ;
EXIT ;  exit
 K ^TMP($J,"PRCPWPLM"),^TMP($J,"PRCPWPLMPOST"),^TMP($J,"PRCPWPLMLIST")
 Q
 ;
 ;
SELECTIB(FINAL) ;  select issue book
 ;  final=1 for screening out ib which are final
 N %,DIC,I,X,Y,Z
 S DIC="^PRCS(410,",DIC(0)="QEAMZ",DIC("A")="Select TRANSACTION NUMBER: "
 S DIC("S")="I $P(^(0),U,2)=""O"",$P(^(0),U,4)=5,$P($G(^(3)),U,4)=+PRCPPVNO,$P($G(^(7)),U,6)]"""","_$S($G(FINAL):"'$P($G(^(9)),U,3),",1:"")_"$S('$D(^PRC(443,+Y,0)):1,$P(^(0),U,3)]"""":1,1:0)"
 W ! D ^PRCSDIC
 Q +Y
