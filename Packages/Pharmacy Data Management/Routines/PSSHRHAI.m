PSSHRHAI ;BIRMINGHAM/GN-Orderable Items High Risk/High Alert Report ;9/25/15 10:03am
 ;;1.0;PHARMACY DATA MANAGEMENT;**191**;9/30/97;Build 40
 ;
 Q
INIT ; Initialize Variables
 N PSSOIEN,PSSDRG,PSSDSG,PSSSPCE,PSSLN,PSSDDRG,PSSINACT,PSSDDIEN,PSSDSGF,PAGNO,PSSMRR,TERM
 N PSSQ,PSSVAL,PSSDRGS,PSSDSGI,PSSHRA,PSSINACTS
 S PAGNO=0,$P(PSSSPCE," ",30)="",PSSQ=0
 D MAIN
 K POP,DTOUT,DUOUT,Y
 Q
 ;
MAIN ;
 D ASKUSR Q:PSSQ
 ;open print device
 D OPEN^%ZISUTL("PSSMRRI") Q:POP
 S TERM=$S($E($G(IOST),1,2)="C-":1,1:0)
 U IO
 D PRNHDR,GET50P7
 ;close print device
 D CLOSE^%ZISUTL("PSSMRRI")
 Q
 ;
GET50P7 ;
 S (PSSDRG,PSSDRGS)=""
 F  S PSSDRG=$O(^PS(50.7,"ADF",PSSDRG)) Q:(PSSDRG="")!PSSQ  D
 .S PSSDSG="",PSSDRGP=PSSDRG
 . F  S PSSDSG=$O(^PS(50.7,"ADF",PSSDRG,PSSDSG)) Q:(PSSDSG="")!PSSQ  D
 .. S PSSOIEN=""
 .. F  S PSSOIEN=$O(^PS(50.7,"ADF",PSSDRG,PSSDSG,PSSOIEN)) Q:(PSSOIEN="")!PSSQ  D
 ... S PSSHRA=$P($G(^PS(50.7,PSSOIEN,0)),U,14)
 ... I PSSVAL[+PSSHRA S PSSINACT=$P(^PS(50.7,PSSOIEN,0),U,4) D
 .... S PSSDSGF=$P(^PS(50.606,PSSDSG,0),U),PSSDSGI=$P(^PS(50.606,PSSDSG,0),U,2),PSSDDIEN="",PSSDRG=PSSDRG_" - "_PSSDSGF
 .... F  S PSSDDIEN=$O(^PS(50.7,"A50",PSSOIEN,PSSDDIEN)) Q:(PSSDDIEN="")!PSSQ  D
 ..... S:$G(PSSDDIEN)]"" PSSDDRG=$P(^PSDRUG(PSSDDIEN,0),"^"),PSSDSGI=$S(PSSDSGI="":" ",1:PSSDSGI)
 ..... D PRNLN
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 Q
 ;
ASKUSR ; Prompt user for input values
 K DIR
 S DIR(0)="SB^A:ALL;1:1;2:2;3:3",DIR("B")="A",DIR("A")="Print Report for (A)ll or Specific HR/HA Flag values(1,2,3)"
 S (DIR("?"),DIR("??"))="^D HELP^PSSHRHAI"
 D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! S PSSQ=1 Q
 S PSSVAL=X
 W:PSSVAL="1" !!,"This report will be for items that do not require a witness in BCMA",!
 W:PSSVAL="2" !!,"This report will be for items that recommend a witness in BCMA",!
 W:PSSVAL="3" !!,"This report will be for items that require a witness in BCMA",!
 W:PSSVAL="A" !!,"This report will be for all High Risk/High Alert witness related items ",!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 G ASKUSR
 S:PSSVAL="A" PSSVAL="123"
 W $C(7),!!?3,"This report is designed for 132 column output!",!
 Q
 ;
HELP ;
 Q:$L(X)<2
 D Q23
 S X="",DIR("L")="" ;Setting DIR("L") suppresses extra help display.
 Q
Q23 ;
 W !,"Enter 'A' to run report for All Orderable Items. Enter '1, 2 or 3'"
 W !,"to show only the selected values."
 W !,"                  Select one of the following:"
 W !,"     A        ALL"
 W !,"     1        HIGH RISK/ALERT-NO WITNESS REQUIRED IN BCMA"
 W !,"     2        RECOMMEND WITNESS IN BCMA-HIGH RISK/ALERT"
 W !,"     3        WITNESS REQUIRED IN BCMA-HIGH RISK/ALERT",!
 Q
 ;
PRNHDR ; Heading
 Q:PSSQ
 S PAGNO=PAGNO+1
 W @IOF
 W !,?57,$E($$FMTE^XLFDT($$NOW^XLFDT),1,18)
 W !,?42,"High Risk/High Alert for Orderable Items Report",?125,"Page ",PAGNO
 W !,?5,"ORDERABLE ITEM                  OI INACTIVE   HRHA  DISPENSE DRUG (DD)              DD INACTIVE"
 W !,?5,"NAME - DOSAGE FORM              DATE          VAL   NAME                            DATE "
 W !,?5,"------------------------------  ------------  ----  ------------------------------  -----------"
 Q
 ;
PRNLN ;Write line on report
 N PSSDRGP,PSSINACTP,PSSHRAP
 S:PSSDRGS=PSSDRG (PSSDRGP,PSSINACTP,PSSHRAP)=" "
 S:PSSDRGS'=PSSDRG (PSSDRGS,PSSDRGP)=PSSDRG,(PSSINACTS,PSSINACTP)=PSSINACT,PSSHRAP="  "_PSSHRA_" "
 W !,?5,$E(PSSDRGP_PSSSPCE,1,30)_"  "_$E($$FMTE^XLFDT(PSSINACTP,5)_PSSSPCE,1,12)_"  "_$E(PSSHRAP_PSSSPCE,1,4)_"  "_$E(PSSDDRG_PSSSPCE,1,30)_"  "_$E(PSSDSGI_PSSSPCE,1,12)
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
