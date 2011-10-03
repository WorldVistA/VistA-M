PRCPCSOR ;WISC/RFJ-surgery order supplies ; 06/23/2009  2:23 PM
 ;;5.1;IFCAP;**136**;Oct 20, 2000;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 N X
 S X="SROPS" X:$D(^%ZOSF("TEST")) ^("TEST") I '$T D NO Q
 I '$$VERSION^XPDUTL("SURGERY") D NO Q
 ;
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "S"'=PRCP("DPTYPE") W !,"THIS OPTION SHOULD ONLY BE USED BY A SECONDARY INVENTORY POINT." Q
 N DIPGM,DFN,OPCODE,OPDATEI,ORDERDA,PRCPDEV,PRCPFAUT,PRCPFLAG,PRCPFNEW,PRCPFONE,PRCPINNM,PRCPORD,PRCPPAT,PRCPPRIM,PRCPSDAT,PRCPSECO,PRCPSURG,SRTN,Y
 S PRCPPRIM=+$$SPD^PRCPUDPT(PRCP("I"),1) I 'PRCPPRIM Q
 S PRCPINNM=$$INVNAME^PRCPUX1(PRCPPRIM)
 S PRCPSECO=PRCP("I")
 ;
 S IOP="HOME" D ^%ZIS K IOP
 ;
 ;  srops returns ^dpt(dfn,0) and ^srf(srtn,0)
 F  W ! K SRTN D ^SROPS Q:'$G(DFN)!('$G(SRTN))  D
 .   S PRCPPAT=DFN,PRCPSURG=SRTN
 .   D SURGDATA^PRCPCRPL(PRCPSURG,".09;27")
 .   S OPCODE=+$G(PRCPSDAT(130,PRCPSURG,27,"I")),OPDATEI=$G(PRCPSDAT(130,PRCPSURG,.09,"I"))
 .   W !?2,"Operation: ",$S('OPCODE:"<< NONE SPECIFIED >>",1:$TR($$ICPT^PRCPCUT1(OPCODE,OPDATEI),"^"," "))
 .   W !!?2,"** Distribution from inventory point: ",PRCPINNM
 .   ;
 .   ;  if no orders placed, cc's linked to operation, ask for automatic
 .   S (PRCPFAUT,PRCPFLAG,PRCPFNEW,ORDERDA)=0
 .   I '$D(^PRCP(445.3,"ASR",PRCPPAT,PRCPSURG)),$D(^PRCP(445.7,"AOP",+OPCODE)) S PRCPFAUT=1 D AUTOORD^PRCPCSO1 Q:PRCPFLAG  I 'ORDERDA S PRCPFAUT=0
 .   I PRCPFAUT S PRCPFNEW=1
 .   ;
 .   ;  if not automatic ordering, ask to select order
 .   I 'PRCPFAUT D ASKORDER Q:'ORDERDA  L +^PRCP(445.3,ORDERDA):5 I '$T D SHOWWHO^PRCPULOC(445.3,ORDERDA,0) Q
 .   I 'PRCPFAUT D ADD^PRCPULOC(445.3,ORDERDA,0,"Ordering Surgical Supplies")
 .   ;
 .   ;  ask to delete order if order is not new (prcpfnew=1)
 .   I '$G(PRCPFNEW) K PRCPFLAG D  I $G(PRCPFLAG) D UNLOCK Q
 .   .   S XP="  Do you want to DELETE the order",XH="  Enter 'YES' to delete the order, 'NO' to continue, '^' to exit."
 .   .   W !! S %=$$YN^PRCPUYN(2)
 .   .   I %=1 D DELORDER^PRCPOPD(ORDERDA) S PRCPFLAG=1 Q
 .   .   I %'=2 S PRCPFLAG=1 Q
 .   ;
 .   I 'PRCPFAUT W !! S PRCPFLAG=$$TYPE^PRCPOPUS(ORDERDA) I PRCPFLAG D UNLOCK Q
 .   ;
 .   ;  if automatic ordering, add items to order
 .   I PRCPFAUT D AUTOITEM I PRCPFLAG S PRCPFAUT=0
 .   ;
 .   I 'PRCPFAUT D
 .   .   ;  show items which should be ordered for opcode
 .   .   D SHOWCC^PRCPCSOU(OPCODE,ORDERDA,OPDATEI)
 .   .   D ITEMS^PRCPOPEE(ORDERDA)
 .   I '$O(^PRCP(445.3,ORDERDA,1,0)) D DELORDER^PRCPOPD(ORDERDA) D UNLOCK Q
 .   ;
 .   ;  ask remarks
 .   W !! I $$REMARKS^PRCPOPUS(ORDERDA) Q
 .   ;  ask to release order
 .   I $$ASKREL^PRCPOPR(ORDERDA,1)=1 D RELEASE^PRCPOPR(ORDERDA)
 .   I $P($G(^PRCP(445.3,ORDERDA,0)),"^",6)'="R" D UNLOCK Q
 .   W !,"* * * ORDER HAS BEEN RELEASED * * *"
 .   ;
 .   ;  order is released, print picking ticket automatically
 .   S (PRCPDEV,ZTIO)=$P($G(^PRCP(445,PRCPPRIM,"DEV")),"^") I ZTIO="" W !,"NO DEVICE SPECIFIED FOR PRINTING THE PICKING TICKET IN ",$E(PRCPINNM,1,15) D UNLOCK Q
 .   D BUILD^PRCPOPT(ORDERDA)
 .   D VARIABLE^PRCPOPU
 .   S ZTDESC="Print Picking Ticket Automatically",ZTRTN="DQ^PRCPOPT"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ORDERDA")="",ZTSAVE("^TMP($J,""PRCPOPT PICK LIST"",")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD,Q^PRCPOPT K IO("Q"),ZTSK
 .   W !!,"Picking Ticket Queued on printer ",PRCPDEV," in ",$E(PRCPINNM,1,15)," !"
 .   D UNLOCK
 Q
 ;
 ;
UNLOCK ;  unlock distribution order
 D CLEAR^PRCPULOC(445.3,ORDERDA,0)
 L -^PRCP(445.3,ORDERDA,0)
 Q
 ;
 ;
NO ;  not available
 W !,"NOT AVAILABLE, SURGERY PACKAGE NOT LOADED."
 Q
 ;
 ;
PATLINK(ORDERDA,PATIENT,SURGERY)  ;  link patient da and surgery da to order da
 N %,D0,DA,DI,DIC,DIE,DIPGM,DQ,DR,X,Y
 I '$D(^PRCP(445.3,ORDERDA,0)) Q
 S DA=ORDERDA,(DIC,DIE)="^PRCP(445.3,",DR="129///"_$C(96)_PATIENT_";130///"_$C(96)_SURGERY D ^DIE
 Q
 ;
 ;
AUTOITEM ;  automatically put items in order
 N CCITEM,ITEMDA
 W !!,"ADDING ITEMS TO THE ORDER:"
 S (CCITEM,PRCPFLAG)=0 F  S CCITEM=$O(^PRCP(445.7,"AOP",OPCODE,CCITEM)) Q:'CCITEM  D
 .   W !,$E($$DESCR^PRCPUX1(PRCPPRIM,CCITEM),1,30),?32,"MI#",CCITEM,?45
 .   S ITEMDA=$$ITEMADD^PRCPOPUS(ORDERDA,CCITEM,1)
 .   I 'ITEMDA W "*** ITEM NOT ORDERED ***" S PRCPFLAG=1 Q
 .   W "Item Ordered"
 Q
 ;
 ;
ASKORDER ;  ask for order selection
 ;  show orders already placed for patient and operation
 D SHOWORD^PRCPCSOU(PRCPPAT,PRCPSURG)
 W !
 S ORDERDA=+$$ORDERSEL^PRCPOPUS(PRCPPRIM,PRCPSECO,"",1) I 'ORDERDA Q
 ;  tie patient and operation to the order
 I $G(PRCPFNEW) D PATLINK(ORDERDA,PRCPPAT,PRCPSURG)
 I $P($G(^PRCP(445.3,ORDERDA,2)),"^",1,2)'=(PRCPPAT_"^"_PRCPSURG) W !,"YOU CAN ONLY SELECT ORDERS WHICH HAVE BEEN PLACED FOR THIS PATIENT AND OPERATION" G ASKORDER
 Q
