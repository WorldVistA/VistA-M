PRCPCED0 ;WISC/RFJ-enter edit case cart or instrument kit           ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
INSTRKIT ;  enter edit instrument kit
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,D0,D1,DA,DDC,DG,DI,DIC,DIE,DQ,DR,PRCPPRIV,PRCPSET,PRCPFLAG,X,Y
 K X S X(1)="Before you can create an instrument kit, an item must be defined in the Item Master File as non-purchasable." D DISPLAY^PRCPUX2(2,40,.X)
 F  S DA=$$SELECT("K",1,PRCP("I")) Q:DA<1  D
 .   D LOCATE(PRCP("I"),DA) I $G(PRCPFLAG) K PRCPFLAG W !! Q
 .   S (DIC,DIE)="^PRCP(445.8,",DR=".01;5////"_DUZ_";6///NOW;1;7;11;12;10",PRCPSET="I 1",PRCPPRIV=1 D ^DIE
 .   W !!
 Q
 ;
 ;
CASECART ;  enter edit case cart
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,D0,D1,DA,DI,DIC,DIE,DQ,DR,PRCPPRIV,PRCPSET,X,Y
 K X S X(1)="Before you can create a case cart, an item must be defined in the Item Master File as non-purchasable." D DISPLAY^PRCPUX2(2,40,.X)
 F  S DA=$$SELECT("C",1,PRCP("I")) Q:DA<1  D
 .   S (DIC,DIE)="^PRCP(445.7,",DR=".01;5////"_DUZ_";6///NOW;1;7;10",PRCPSET="I 1",PRCPPRIV=1 D ^DIE
 .   W !!
 Q
 ;
 ;
OPCODES ;  enter opcodes tied to a case cart
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,D0,D1,DA,DI,DIC,DIE,DIZ,DLAYGO,DQ,DR,X,Y
 K X S X(1)="This option allows operation codes to be linked to case carts.  When a patient is scheduled for an operation code, the system will recommend ordering the case carts tied to the operation code."
 D DISPLAY^PRCPUX2(2,40,.X)
 F  S DA=$$SELECT("C",0,$S(PRCP("DPTYPE")="P":PRCP("I"),1:0)) Q:DA<1  D
 .   S (DIC,DIE)="^PRCP(445.7,",DR=81 W ! D ^DIE
 .   W !!
 Q
 ;
 ;
SELECT(TYPE,ADDNEW,INVPT) ;  select a case cart or instrument kit
 ;  type='C'ase cart or instrument 'K'it
 ;  addnew=1 for adding new entries
 ;  invpt to screen cc or ik owned by inventory point
 N %,DIC,DLAYGO,I,PRCPINPT,PRCPFILE,PRCPNAME,PRCPSET,PRCPPRIV,X,Y
 S PRCPFILE=445.7,PRCPNAME="CASE CART",PRCPPRIV=1
 I TYPE="K" S PRCPFILE=445.8,PRCPNAME="INSTRUMENT KIT"
 S DIC="^PRCP("_PRCPFILE_",",DIC(0)="QEAM",DIC("A")="Select "_PRCPNAME_" Item Number: ",PRCPSET="I 1"
 I INVPT S DIC("S")="I $P(^PRCP("_PRCPFILE_",+Y,0),U,2)="_INVPT,PRCPINPT=INVPT
 S DIC("W")="W ?20,$E($$DESCR^PRCPUX1(+$G(PRCPINPT),+Y),1,20) I $G(PRCPINPT) S %=$G(^PRCP(445,PRCPINPT,1,+Y,0)) W ?45,""  "",$S(%="""":""Not Stored In InvPt"",1:""Qty On-Hand: ""_+$P(%,U,7))"
 I ADDNEW S DIC(0)="QEALM",DLAYGO=PRCPFILE,DIC("DR")="2////"_PRCP("I")_";3////"_DUZ_";4///NOW"
 D ^DIC
 Q $S(Y<1:0,1:+Y)
 ;
 ;
LOCATE(INVPT,IKITEM) ;  locate any case carts containing instrument kits ikitem
 S IOP="HOME" D ^%ZIS K IOP
 K ^TMP($J,"PRCPCED0")
 N CCITEM,SCREEN,QTY,X
 S CCITEM=0 F  S CCITEM=$O(^PRCP(445.7,"AI",IKITEM,CCITEM)) Q:'CCITEM  S QTY=+$P($G(^PRCP(445,INVPT,1,CCITEM,0)),"^",7) I QTY S ^TMP($J,"PRCPCED0",CCITEM)=QTY
 I '$O(^TMP($J,"PRCPCED0",0)) Q
 ;  show where iks are
 W ! D H
 S SCREEN=1,(CCITEM,PRCPFLAG)=0 F  S CCITEM=$O(^TMP($J,"PRCPCED0",CCITEM)) Q:'CCITEM!($G(PRCPFLAG))  S QTY=^(CCITEM) D
 .   W !,CCITEM,?7,$E($$DESCR^PRCPUX1(INVPT,CCITEM),1,22),?44,$J(QTY,13)
 .   S SCREEN=SCREEN+1
 .   I SCREEN'<IOSL D P^PRCPUREP Q:$D(PRCPFLAG)  D H S SCREEN=1
 I SCREEN>(IOSL-16) D R^PRCPUREP
 K X S X(1)="WARNING -- This Instrument Kit has been assembled and is contained in the above case cart(s)."
 S X(2)="If you continue editing the definition of this instrument kit, disassembling of the above case cart(s) and instrument kit may cause incorrect quantities for items contained within this instrument kit."
 S X(3)="To prevent incorrect quantities, please disassemble the above case cart(s) and the instrument kit before editing the definition."
 D DISPLAY^PRCPUX2(20,60,.X)
 K ^TMP($J,"PRCPCED0")
 S PRCPFLAG=1
 Q
 ;
 ;
H ;  display header on display
 S %="",$P(%,"-",81)=""
 W !,"IM#",?7,"DESCRIPTION",?44,$J("QTY ON-HAND",13),!,%
 Q
