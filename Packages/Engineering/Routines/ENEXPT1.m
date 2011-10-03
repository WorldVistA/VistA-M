ENEXPT1 ;WIRMFO/SAB-EQUIPMENT FILE EXPORT SUMMARY RPT ;1/18/96
 ;;7.0;ENGINEERING;**27**;Aug 17, 1993
EN ;
 W !,"This report searches the entire equipment file and may take some"
 W !,"time to complete. Consider queuing this report to run after-hours."
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENEXPT1",ZTDESC="Equipment File Export Summary Rpt"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 N ENC,END,ENDA,ENDL,ENDT,ENPG,ENSN,ENSND,ENTA,ENTL,ENY0,ENY2,ENY3
 U IO
 S ENSND=$$GET1^DIQ(6910,"1,",1) ; default station #
 W:$E(IOST,1,2)="C-" !,"Searching Equipment File"
 S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D
 . I $E(IOST,1,2)="C-" W:'(ENDA#100) "."
 . S ENY0=$G(^ENG(6914,ENDA,0))
 . Q:$P(ENY0,U,4)'="NX"  ; type of entry screen
 . S ENY3=$G(^ENG(6914,ENDA,3))
 . Q:"^4^5^"[(U_$P(ENY3,U,1)_U)  ; use status screen
 . S ENSN=$P($G(^ENG(6914,ENDA,9)),U,5) S:ENSN="" ENSN=ENSND ; station
 . S ENY2=$G(^ENG(6914,ENDA,2))
 . S ENC(ENSN)=$G(ENC(ENSN))+1
 . S ENTA(ENSN)=$G(ENTA(ENSN))+$P(ENY2,U,3)
 . S ENTL(ENSN)=$G(ENTL(ENSN))+$P(ENY2,U,12)
 ; print summary
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENDL="",$P(ENDL,"-",IOM)=""
 D HD
 S (ENC,ENTA,ENTL)=0
 S ENSN="" F  S ENSN=$O(ENC(ENSN)) Q:ENSN=""  D  Q:END
 . I $Y+4>IOSL D HD Q:END
 . W !,?5,ENSN,?15,$J(ENC(ENSN),6),?28,$J($FN($G(ENTA(ENSN)),",",2),16),?48,$J($FN($G(ENTL(ENSN)),",",2),16)
 . S ENC=ENC+ENC(ENSN)
 . S ENTA=ENTA+$G(ENTA(ENSN))
 . S ENTL=ENTL+$G(ENTL(ENSN))
 I 'END D
 . W !,?5,"-------",?15,"----------",?28,"-----------------",?48,"----------------"
 . W !,?5,"TOTAL:",?15,$J(ENC,6),?28,$J($FN(ENTA,",",2),16),?48,$J($FN(ENTL,",",2),16)
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"EQUIPMENT FILE EXPORT SUMMARY RPT",?48,ENDT,?72,"page ",ENPG
 W !!,?5,"STATION",?15,"ITEM COUNT",?28,"TOTAL ASSET VALUE"
 W ?48,"TOTAL LEASE COST"
 W !,ENDL
 Q
ASK ; description of selection criteria and set up of summary report prompt
 ; called by ENEXPT
 W !!,"The Equipment File Export transmits equipment data to the National"
 W !,"Engineering Service Center (NESC) in St. Louis."
 W !,"Equipment which meets the following criteria will be selected:"
 W !,"    TYPE OF ENTRY equals ""NX"""
 W !,"    USE STATUS not equal ""TURNED IN"" or ""LOST OR STOLEN""",!
 S DIR(0)="Y",DIR("A")="Would you like a summary report",DIR("B")="YES"
 S DIR("?",1)="Enter YES to generate a summary report of equipment that"
 S DIR("?")="will be included in the transmission."
 Q
 ;ENEXPT1
