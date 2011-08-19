PRCHRPTX ;AAC/JDM-PRCH ITEM HISTORY BY DATE RANGE ; [1/13/99 11:13am]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; <<<<<<<<<<<< Expected Variables In >>>>>>>>>>>>>
 ; PRC("SITE")=Stn.# (Mandatory)
 ; ITMNO;ITMNO=Item Master #
 ; <<<<<<<<<<<< Other Variables Used >>>>>>>>>>>>>>
 ; FR1 & TO1=Starting and ending FCP for sort
 ; FR2 & TO2=Starting & ending Stn.# for sort (Set from PRC("SITE")
 ; FR3 & TO3=Starting & ending Itm.# for sort (Set from ITMNO)
 ; FR4 & TO4=Starting & ending PO Date for sort
 ; ITMDESC=Set from file entry
 ;
EN ;DISPLAY ITEM HISTORY
 ;
XXLST S STN=PRC("SITE")
 S ABORT=0
 W !,"STN: ",STN
 K DIR
 S DIR(0)="S^ALL:ALL FCPs;RANGE:RANGE of FCPs;SPECIFIC:SPECIFIC FCP"
 S DIR("A")="List Item Activity (by DATE RANGE) for"
 S DIR("B")="ALL"
 D ^DIR
 I X["^"!($D(DTOUT)) G EXIT
 S SCTL=X
 I $E(X,1)="A"!($E(X,1)="a") D  G XXITM
 .  S FR2=STN
 .  S TO2=STN
 .  S FR1=0
 .  S TO1="99999 ZZZ"
 .  Q
 W !!,"START WITH FCP"
 I $E(SCTL,1)="S"!($E(SCTL,1)="s") W " and END WITH FCP"
 S DIC="^PRC(420,STN,1,"
 S DIC(0)="QEAMNZ"
 D ^DIC
 I X="^" G EXIT
 I Y'>0 W !,"INVALID SELECTION.  TRY AGAIN ('^' TO ABORT)." G XXLST
 S X=$P(Y,U,2)
 S FR1=$P(X," ",1)
 S FR2=STN
 I $E(SCTL,1)="S"!($E(SCTL,1)="s") G XFCP
 ;
TOFCP W !!,"END WITH FCP"
 D ^DIC
 I Y'>0 W !,"INVALID SELECTION.  TRY AGAIN ('^' TO ABORT)." G TOFCP
 I X="^" G EXIT
 ;
XFCP S X=$P(Y,U,2)
 S TO1=$P(X," ",1)
 S TO2=STN
 ;
XXITM I $D(ITMNO) D  G XXDT
 .  S FR3=ITMNO
 .  S TO3=ITMNO
 .  Q
 S DIC="^PRC(441,"
 S DIC(0)="QEAMNZ"
 D ^DIC
 I X="^" G EXIT
 I Y'>0 W !,"INVALID SELECTION" G XXITM
 S ITMNO=$P(Y(0),U,1)
 S FR3=ITMNO
 S TO3=ITMNO
 ;
XXDT S ITMDESC=$P(^PRC(441,ITMNO,0),U,2)
 D NOW^%DTC
 D YX^%DTC
 S DTX=$P(Y,"@",1)
 S DTX="JAN 1,"_$P(DTX,",",2)
 K DIR
 S DIR(0)="D"
 S DIR("A")="DATE ORDERED (BEGIN RANGE)"
 S DIR("B")=DTX
 D ^DIR
 I $D(DTOUT)!(X["^") G EXIT
 D ^%DT
 S FR4=Y
 K DIR
 S DIR(0)="D"
 S DIR("A")="DATE ORDERED   (END RANGE)   "
 S DIR("B")="TODAY"
 D ^DIR
 I $D(DTOUT)!(X["^") G EXIT
 D ^%DT
 S TO4=Y
 ;
 S NX=0
 ;
 S ZTSAVE("FR1")=""
 S ZTSAVE("FR2")=""
 S ZTSAVE("FR3")=""
 S ZTSAVE("FR4")=""
 S ZTSAVE("TO1")=""
 S ZTSAVE("TO2")=""
 S ZTSAVE("TO3")=""
 S ZTSAVE("TO4")=""
 S ZTSAVE("ITMNO")=""
 S ZTSAVE("ITMDESC")=""
 D EN^XUTMDEVQ("LOOPPD^PRCHRPTX","ITEM HISTORY Report by Date Range",.ZTSAVE,.%ZIS)
 I '$D(ZTSK) W ! G EXIT
 K ZTSK
 Q
 ;
LOOPPD ; Set up to locate records to display.
 N FCPS,FCPE,STN,DATES,DATET,LNCT,ABORT,NX,SITFCPS,SITFCPE
 N FCP,COUNT,HDR,PG
 S PG=0
 S FCPS=FR1
 S FCPE=TO1
 S STN=FR2
 S ITMNO=FR3
 S DATES=FR4
 S DATET=TO4
 S ABORT=0
 S NX=0
 S SITFCPS=STN_FCPS
 S SITFCPE=STN_FCPE
 ;
LOOPPD1 ; Loop through file 441.
 ; 
 ; 1.  Loop through Fund Control Point for PRC("SITE")
 ;      within one Item Master File Number.
 ; 2.  Loop through P.O. DATE (in reverse order).
 ; 3.  Loop through a single P.O. DATE to get file 442 PO NUMBER.
 ;
 ; These three nested loops will locate Purchase Orders to display.
 ;
 S FCP=0
 S COUNT=0
 ;
 ; Get FCP.
 ;
 F  S FCP=$O(^PRC(441,ITMNO,4,"B",FCP)) Q:FCP'>0  D  Q:ABORT=1
 .  Q:STN'=$E(FCP,1,$L(STN))
 .  Q:FCPS>0&((FCP<SITFCPS)!(FCP>SITFCPE))
 .  ;
 .  ; Because DATE in "AC" x-reference is in reverse order(latest
 .  ; date first) the search must start after TO4, the ending PO date.
 .  ;
 .  S DATE=(9999999-DATET)-1
 .  S NODATE=0
 .  ;
 .  ; Starting a new FCP.  Force listing a header.
 .  ;
 .  K HDR
 .  ;
 .  ; Get DATE.
 .  ;
 .  F  D  Q:NODATE=1  Q:ABORT=1
 .  .  S DATE=$O(^PRC(441,ITMNO,4,FCP,1,"AC",DATE))
 .  .  I DATE'>0 S NODATE=1 Q
 .  .  S CKDATE=9999999-DATE
 .  .  ;
 .  .  ; See if date found is before FR4 (starting date).
 .  .  ; If true, there will be no more dates between FR4 and TO4.
 .  .  ; Set the flag to stop this loop through "AC".
 .  .  ;
 .  .  I CKDATE<DATES S NODATE=1 Q
 .  .  ;
 .  .  ; If the date found is after TO4 (ending date) there may be
 .  .  ; some dates between FR4 and TO4.
 .  .  ;
 .  .  Q:CKDATE>DATET
 .  .  S PO=0
 .  .  ;
 .  .  ; Get PO NUMBER (may be more than one per DATE).
 .  .  ;
 .  .  F  S PO=$O(^PRC(441,ITMNO,4,FCP,1,"AC",DATE,PO)) Q:PO'>0  D  Q:ABORT=1
 .  .  .  S POCK=$G(^PRC(442,PO,0))
 .  .  .  Q:POCK']""
 .  .  .  S COUNT=COUNT+1
 .  .  .  D DISP
 .  .  .  Q
 .  .  Q
 .  Q
 Q
 ;
DISP S LX=$O(^PRC(442,PO,2,"AE",ITMNO,0))
 Q:LX'>0
 S LXN0(LX)=$G(^PRC(442,PO,2,LX,0))
 S LXN2(LX)=$G(^PRC(442,PO,2,LX,2))
 S ND0=$G(^PRC(442,PO,0))
 S ND1=$G(^PRC(442,PO,1))
 S PONUM=$P(ND0,U,1)
 S PODTX=$P(ND1,U,15)
 S FCPX=$P(ND0,U,3)
 S VP=$P(ND1,U,1)
 S IMFX=$P(LXN0(LX),U,5)
 S QTY=$P(LXN0(LX),U,2)
 S UIP=$P(LXN0(LX),U,3)
 S ACST=$P(LXN0(LX),U,9)
 S QPR=+$P(LXN2(LX),U,8)
 S TCST=$P(LXN2(LX),U,1)
 S STNX=$P(PONUM,"-",1)
 S FCPX=$P(FCPX," ",1)
 S MAXL=IOSL-4
 I '$D(LNCT) D  Q:ABORT=1
 .  S LNCT=0
 .  D HDR
 .  S HDR=1
 .  Q
 I '$D(HDR)&(LNCT>9) D  Q:ABORT=1
 .  S HDR=1
 .  S LCNT=1
 .  D HDR
 .  Q
 S LNCT=LNCT+3
 D:LNCT>MAXL HDR
 S X=PODTX
 D H^%DTC
 D YX^%DTC
 S PODT=Y
 S UIPX=" "
 S VNDX=" "
 S:UIP'="" UIPX=$P(^PRCD(420.5,UIP,0),U,1)
 S:VP'=""&(VP'=0) VNDX=$P(^PRC(440,VP,0),U,1)
 S:ACST'["." ACST=ACST_".00"
 S:TCST'["." TCST=TCST_".00"
 S ACL=$L(ACST)
 S TCL=$L(TCST)
 S ACS2=$P(ACST,".",2)
 S TCS2=$P(TCST,".",2)
 F M=1:1:2 D
 .  S ACS2=ACS2_$E("00",1,2-$L(ACS2))
 .  S TCS2=TCS2_$E("00",1,2-$L(TCS2))
 .  Q
 S ACST=$P(ACST,".",1)_"."_ACS2
 S TCST=$P(TCST,".",1)_"."_TCS2
 S SP9="         "
 F M=1:1:9 D
 .  S ACST=$E(SP9,1,9-$L(ACST))_ACST
 .  S TCST=$E(SP9,1,9-$L(TCST))_TCST
 .  S QTY=$E(SP9,1,9-$L(QTY))_QTY
 .  S QPR=$E(SP9,1,9-$L(QPR))_QPR
 .  Q
 I ABORT=0 D
 .  W !!,PODT,?15,PONUM,?26,QPR,?38,UIPX,?48,ACST,?59,TCST,?70,QTY,!,VNDX
 .  S STATX=$P($G(^PRC(442,PO,7)),U,1)
 .  W:STATX=45 ?50,"Order Status=CANCELLED"
 .  Q
 Q
 ;
MOFCP K DIR
 S DIR(0)="Y"
 S DIR("A")="Would you like to do another FCP Date-Range Listing for this item"
 S DIR("B")="NO"
 D ^DIR
 I $D(DTOUT)!(X["^")!(X["N")!(X="n") G EXIT
 G XXLST
 ;
EXIT K CST,P2,ABORT
 D Q^PRCHRPT1
 G EN^PRCHRPT1
 ;
CALCCST ; EP -- CALCULATES ACTUAL UNIT COST TO 2 DECIMALS
 S CST=$P(X,U,9)
 I CST'["." S CST=CST_"."
 S P2=$P(CST,".",2)
 I $L(P2)=0 S P2="00"
 I $L(P2)=1 S P2=P2_"0"
 I $L(P2)>2&($E(P2,3)>4) S $E(P2,2)=$E(P2,2)+1
 I $L(P2)>2 S P2=$E(P2,1,2)
 S CST=$P(CST,".",1)_"."_P2
 F J=1:1:10 I $L(CST)<10 S CST=" "_CST
 W CST
 Q
 ;
HDR I $E(IOST)="C"&(LNCT'=0) W ! D PAUSE Q:ABORT=1
 S FCPD=FCPX
 S PG=PG+1
 S:FCPX>0 FCPD=$P(ND0,U,3)
 W @IOF,!!,"Item Number: ",ITMNO,?25,"Description: "
 W ITMDESC,?71,"Page ",PG
 W !?7,"SITE: ",STN,?25,"FCP: ",FCPD,!!,?26,"Quantity"
 W !,?26,"Previously",?38,"Unit of",?71,"Quantity"
 W !,"Date Ordered",?15,"PO Number",?26,"Received",?38,"Purchase"
 W ?48,"Unit Cost",?59,"Total Cost",?71,"Ordered",!
 F I=1:1:80 W "_"
 S LNCT=9
 Q
 ;
PAUSE ; Test for prompt to return or exit
 K DIR
 S ABORT=0
 S DIR(0)="E"
 D ^DIR
 I Y=""!(Y=0) S ABORT=1
 Q
 ;
ASK Q:$E(IOST)="P"
 W !!,"Press RETURN to continue"
 R X:DTIME
 S ASK=1
 Q
