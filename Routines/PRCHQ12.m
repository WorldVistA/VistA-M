PRCHQ12 ;(WASH IRMFO)/LKG-RFQ QUOTE VIEW ;8/6/96  20:44
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
QUOTEVU ;View an individual quote
 S DIC=444,DIC(0)="AEMQ",DIC("A")="Select RFQ: ",DIC("S")="I $P($G(^(8,0)),U,4)>0"
 D ^DIC K DIC
 G:+Y<1 EX S PRCDA=+Y
QLKUP ;Loop for selecting quote
 K DA S DA(1)=PRCDA,DIR(0)="PAO^PRC(444,DA(1),8,:AEMQ"
 S DIR("A")="Select Quote Vendor: ",DIR("?",1)="Enter the Name of the Vendor or"
 S DIR("?")="  enter 'DUN' plus the vendor's Dun & Bradstreet Number."
 D ^DIR K DIR I +Y<1 G EX:$D(DIROUT)!$D(DTOUT)!$D(DUOUT),QUOTEVU
 S PRCVEN=$P(Y,U,2),PRCDA2=+Y
 L +^PRC(444,PRCDA,8,PRCDA2):5 E  W !,"This RFQ is in use, please try later!" G QLKUP
 S PRCMODE="P"
 I $$TEST^DDBRT D  G EX:$D(DIRUT)!$D(DUOUT)
 . K DIR S DIR(0)="SAM^B:BROWSE;P:PRINT",DIR("B")="BROWSE"
 . S DIR("A")="Do you wish to Browse or Print this quote? "
 . S DIR("?",1)="Enter 'B' to use the FileMan Browser or 'P' to display on Terminal in"
 . S DIR("?")="Scroll Mode or send to Printer" D ^DIR K DIR
 . S PRCMODE=Y
 I PRCMODE="B"!(PRCMODE="b") D  G QLKUP
 . D BUILD^PRCHQ12A(PRCVEN,PRCDA,PRCDA2,.PRCTITLE) L -^PRC(444,PRCDA,8,PRCDA2)
 . D BROWSE^DDBR("^TMP($J,""RPT"")","NR",PRCTITLE)
 . K ^TMP($J,"RPT"),PRCDA2,PRCVEN
 I PRCMODE="P"!(PRCMODE="p") D  G QLKUP
 . S %ZIS="QP" D ^%ZIS I POP L -^PRC(444,PRCDA,8,PRCDA2) Q
 . I $D(IO("Q")) D  Q
 . . S ZTRTN="PRINT^PRCHQ12",ZTDESC="Single Vendor Quote Print"
 . . S ZTSAVE("PRCVEN")="",ZTSAVE("PRCDA")="",ZTSAVE("PRCDA2")=""
 . . D ^%ZTLOAD,HOME^%ZIS K ZTSK L -^PRC(444,PRCDA,8,PRCDA2)
 . D PRINT
 G QLKUP
EX K DIROUT,DIRUT,DTOUT,DUOUT,PRCDA,PRCDA2,PRCMODE,PRCVEN,X,Y,DIC,DA
 Q
PRINT ;Printing text of quote
 I $D(ZTQUEUED) L +^PRC(444,PRCDA,8,PRCDA2):1200
 D:'$D(U)!'$D(DT) DT^DICRW U IO
 D BUILD^PRCHQ12A(PRCVEN,PRCDA,PRCDA2,.PRCTITLE)
 L -^PRC(444,PRCDA,8,PRCDA2) D NOW^%DTC S Y=% D DD^%DT S PRCDATE=Y
 S PRCP=0,X="" D HDR G:X["^" EX2 S PRCJ=0
 F  S PRCJ=$O(^TMP($J,"RPT",PRCJ)) Q:PRCJ=""  D  Q:X["^"
 . I PRCL+4>IOSL D HDR Q:X["^"
 . W !,^TMP($J,"RPT",PRCJ) S PRCL=PRCL+1
 I X'["^",$E(IOST,1,2)="C-",'$D(ZTQUEUED) R !!,"Enter RETURN to continue ",X:DTIME
 D ^%ZISC S:$D(ZTQUEUED) ZTREC="@"
EX2 K ^TMP($J,"RPT"),PRCDA2,PRCVEN,PRCTITLE,PRCP,PRCJ,PRCL,X,Y,%,PRCDATE
 Q
HDR ;Print header at top of each page
 I PRCP>0,$E(IOST,1,2)="C-",'$D(ZTQUEUED) R !!,"Enter RETURN to continue or '^' to exit: ",X:DTIME Q:X["^"
 S PRCP=PRCP+1
 W:$E(IOST,1,2)="C-"!(PRCP>1) @IOF W !,PRCTITLE,!,?26,"Date: ",PRCDATE W:PRCP>1 ?65,"Page: ",PRCP
 W !! S PRCL=5
 Q
