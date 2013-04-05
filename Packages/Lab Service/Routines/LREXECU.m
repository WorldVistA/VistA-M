LREXECU ;SLC/RWF - EXECUTE CODE UTILITY ;8/11/97
 ;;5.2;LAB SERVICE;**121,200,362**;Sep 27, 1994;Build 11
TDM ;DRUG MONITORING
 N DIR,DTOUT,DUOUT,DIRUT
 ;Set the DIR array for sample to be drawn question
 S DIR(0)="SO^P:Peak;T:Trough;M:Mid;U:Unknown"
 S DIR("A")="Please select"
 S DIR("L",1)="Will (is) the sample to be drawn at"
 S DIR("L")=" Peak, Trough, Mid, or Unknown"
 S DIR("T")=60
 S DIR("?",1)="Enter a 'P', 'T', 'M', 'U', or hit the Enter Key."
 S DIR("?",2)="Hitting the Enter key will default to Unknown "
 S DIR("?")="Entering ""^"" or a timeout will cancel the order."
 D ^DIR K DIR  ;Prompt for user selection
 ;Process user selection
 I $D(DUOUT)!($D(DTOUT)) W !!!,$C(7),"ORDER CANCELED" S LRKIL=1 Q
 I Y="" S Y(0)="Unknown" W !!!,$C(7),"Defaulted to Unknown"
 E  W !!!,$C(7),Y(0)_" has been selected."
 S LRCCOM="~Dose is expected to be at "_Y(0)_" level."
 I $$VER^LR7OU1>2.5 D TCOM^LRORD2(+LRTEST(LRTSTN),LRCCOM)
 I $$VER^LR7OU1<3 D RCS^LRXO9 I '$D(ORACTION) D TCOM^LRORD2(+LRTEST(LRTSTN),LRCCOM) ;OE/RR 2.5
 ;Set DIR array for additional comment question
 S DIR(0)="FO^1:250"
 S DIR("A")="ADDITIONAL COMMENT"
 S DIR("T")=60
 S DIR("?")="This is a free text field, up to 250 characters in length."
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) S Y=""
 S LRCCOM=Y
 Q
DOSE ;DOSE/DRAW TIMES
EN ;
 S %DT("A")="Enter the last dose time: ",%DT="AT" D ^%DT S LRDOSE=Y
 I Y<1 W !,"Time unknown" S %=2 D YN^DICN S:%=1 LRDOSE="UNKNOWN" G:%'=1 EN
 I Y>1,Y'["." W !,"You must enter a time, e.g.  T@6AM" G EN
 I LRDOSE["." S Y=LRDOSE D DD^LRX S LRDOSE=Y
DRAW W ! S %DT("A")="Enter draw time: ",%DT="AT" D ^%DT S LRDRAW=Y
 I Y<1 W !,"Time unknown" S %=2 D YN^DICN S:%=1 LRDRAW="UNKNOWN" G:%'=1 DRAW
 I Y>1,Y'["." W !,"You must enter a time, e.g.  T@6AM" G DRAW
 I LRDRAW["." S Y=LRDRAW D DD^LRX S LRDRAW=Y
 S LRCCOM="~Last dose: "_LRDOSE_"   draw time: "_LRDRAW W !,LRCCOM
 W !,"OK" S %=1 D YN^DICN G EN:%'=1
 K LRDOSE,LRDRAW,%DT Q
