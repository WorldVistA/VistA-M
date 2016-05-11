PSSMRRI ;ALB/DRP PRINT MRR ITEMS ;06/18/15
 ;;1.0;PHARMACY DATA MANAGEMENT;**191**;9/30/97;Build 40
 ;
 Q
INIT ;
 N PSSOIEN,PSSDRG,PSSDSG,PSSSPCE,PSSLN,PSSDDRG,PSSINACT,PSSDDIEN,PSSDSGF,PAGNO,PSSMRR,PSSDRGS,PSSINACTS,PSSDSGI
 N PSSQ,PSSVAL,TERM
 S PAGNO=0,$P(PSSSPCE," ",30)="",PSSQ=0
 D MAIN
 K POP,DTOUT,DUOUT,Y
 Q
 ;
MAIN ;
 D ASKUSR Q:PSSQ
 ;open print device
 D OPEN^%ZISUTL("PSSMRRI",,) I $G(POP) W !!,"Nothing queued to print.",! Q
 S TERM=$S($E($G(IOST),1,2)="C-":1,1:0)
 U IO
 D PRNHDR,GET50P7
 ;close print device
 D CLOSE^%ZISUTL("PSSMRRI")
 Q
 ;
ASKUSR ; Prompt user for inout values
 K DIR
 S DIR(0)="SB^A:ALL;1:1;2:2;3:3",DIR("B")="A",DIR("A")="Enter 'A' to run report for all Orderable Items. Enter '1, 2 or 3' to show only the selected values."
 S (DIR("?"),DIR("??"))="^D HELP^PSSMRRI"
 D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! S PSSQ=1 Q
 S PSSVAL=X
 W:PSSVAL="1" !!,"This report will be for items requiring removal at the next administration ",!
 W:PSSVAL="2" !!,"This report will be for items with optional removal prior to next administration. ",!
 W:PSSVAL="3" !!,"This report will be for items that require removal prior to the next administration. ",!
 W:PSSVAL="A" !!,"This report will be for all items that require removal.",!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 G ASKUSR
 S:PSSVAL="A" PSSVAL="123"
 W $C(7),!!?3,"This report is designed for 132 column output!",!
 Q
HELP ;
  Q:$L(X)<2
  D Q23
  S X="",DIR("L")="" ;Setting DIR("L") suppresses extra help display.
  Q
Q23 ;
 W !,"Enter 'A' to run report for all Orderable Items. Enter '1, 2 or 3'"
 W !,"to show only the selected values."
 W !,"                  Select one of the following:"
 W !,"     A        ALL"
 W !,"     1        Removal at Next Administration"
 W !,"     2        Removal Period Optional Prior to Next Administration"
 W !,"     3        Removal Period Required Prior to Next Administration",!
 Q
 ;
GET50P7 ;
 S (PSSDRG,PSSDRGS)=""
 F  S PSSDRG=$O(^PS(50.7,"ADF",PSSDRG)) Q:(PSSDRG="")!PSSQ  D
 .S PSSDSG=""
 . F  S PSSDSG=$O(^PS(50.7,"ADF",PSSDRG,PSSDSG)) Q:(PSSDSG="")!PSSQ  D
 .. S PSSOIEN=""
 .. F  S PSSOIEN=$O(^PS(50.7,"ADF",PSSDRG,PSSDSG,PSSOIEN)) Q:(PSSOIEN="")!PSSQ  D
 ... S PSSMRR=$G(^PS(50.7,PSSOIEN,4))
 ... I PSSVAL[+PSSMRR S PSSINACT=$P(^PS(50.7,PSSOIEN,0),U,4) D
 .... S PSSDSGF=$P(^PS(50.606,PSSDSG,0),U),PSSDDIEN="",PSSDRG=PSSDRG_" - "_PSSDSGF
 .... F  S PSSDDIEN=$O(^PS(50.7,"A50",PSSOIEN,PSSDDIEN)) Q:(PSSDDIEN="")!PSSQ  D
 ..... S:$G(PSSDDIEN)]"" PSSDDRG=$P(^PSDRUG(PSSDDIEN,0),"^"),PSSDSGI=$G(^PSDRUG(PSSDDIEN,"I")),PSSDSGI=$S(PSSDSGI="":" ",1:PSSDSGI)
 ..... D PRNLN
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 Q
 ;
PRNHDR ; Heading
 Q:PSSQ
 S PAGNO=PAGNO+1
 W @IOF
 W !,?57,$E($$FMTE^XLFDT($$NOW^XLFDT),1,18)
 W !,?19,"Orderable Items Report on Medications Requiring Removal (MRR) Prompt for Removal in BCMA Value",?125,"Page ",PAGNO
 W !,?5,"ORDERABLE ITEM                  OI INACTIVE   MRR  DISPENSE DRUG (DD)              DD INACTIVE"
 W !,?5,"NAME - DOSAGE FORM              DATE          VAL  NAME                            DATE "
 W !,?5,"------------------------------  ------------  ---  ------------------------------  -----------"
 Q
 ;
PRNLN ;Write line on report
 N PSSDRGP,PSSINACTP,PSSMRRP
 S:PSSDRGS=PSSDRG (PSSDRGP,PSSINACTP,PSSMRRP)=" "
 S:PSSDRGS'=PSSDRG (PSSDRGS,PSSDRGP)=PSSDRG,PSSINACTP=PSSINACT,PSSMRRP=" "_PSSMRR_" "
 W !,?5,$E(PSSDRGP_PSSSPCE,1,30)_"  "_$E($$FMTE^XLFDT(PSSINACTP,5)_PSSSPCE,1,12)_"  "_$E(PSSMRRP_PSSSPCE,1,3)_"  "_$E(PSSDDRG_PSSSPCE,1,30)_"  "_$E($$FMTE^XLFDT(PSSDSGI,5)_PSSSPCE,1,12)
 I $Y>(IOSL-1) D:$G(TERM) PAUSE D PRNHDR
 Q
 ;
PAUSE Q:'$G(TERM)
 N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit"
 R X:$G(DTIME) I (X="^")!('$T) S PSSQ=1 Q
 U IO
 Q
 ;
