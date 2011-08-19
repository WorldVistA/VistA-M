ENFAR7 ;WIRMFO/SAB-FIXED ASSET RPT, FA DOCUMENTS FOR EXCESS EQUIP; 1.12.98
 ;;7.0;ENGINEERING;**29,33,46,48**;Aug 17, 1993
 ; FA Documents for Excess Equipment (SGL 1524) during Accounting Period
EN ;
 ; compute default start date (day of previous month)
 S ENDT("Y")=$E(DT,1,3),ENDT("M")=$E(DT,4,5),ENDT("D")=$E(DT,6,7)
 S ENDTS=$S(ENDT("M")="01":(ENDT("Y")-1)_"12",1:ENDT("Y")_$E("00",1,2-$L(ENDT("M")-1))_(ENDT("M")-1))_ENDT("D")
 I ENDTS>$$EOM^ENUTL(ENDTS) S ENDTS=$$EOM^ENUTL(ENDTS)
 ; ask start date when interactive
 I '$D(ZTQUEUED) D  G:$D(DIRUT) EXIT
 . S DIR(0)="D^::EX",DIR("A")="Start Date"
 . S DIR("B")=$$FMTE^XLFDT(ENDTS,"2D")
 . D ^DIR K DIR S ENDTS=Y
ASKDTE ; compute default end date (Today)
 S ENDTE=$P(DT,".")
 ; ask end date when interactive
 I '$D(ZTQUEUED) D  G:$D(DIRUT) EXIT
 . S DIR(0)="D^::EX",DIR("A")="End Date"
 . S DIR("B")=$$FMTE^XLFDT(ENDTE,"2D")
 . D ^DIR K DIR S ENDTE=Y
 I ENDTE<ENDTS W $C(7),!,"End date must be after start date!",! G ASKDTE
 ; ask device when interactive
 I '$D(ZTQUEUED) S %ZIS="QM" D ^%ZIS G:POP EXIT I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFAR7",ZTDESC="FA Documents for Excess Equipment"
 . F X="ENDTS","ENDTE" S ZTSAVE(X)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 K ^TMP($J)
 ; get/sort FA Documents for excess within date range
 ; loop thru FA DOCUMENT LOG by created date/time
 S ENDT=ENDTS
 F  S ENDT=$O(^ENG(6915.2,"D",ENDT)) Q:ENDT=""!($P(ENDT,".")>ENDTE)  D
 . S ENDA=0 F  S ENDA=$O(^ENG(6915.2,"D",ENDT,ENDA)) Q:'ENDA  D
 . . S ENY3=$G(^ENG(6915.2,ENDA,3))
 . . Q:$P(ENY3,U,6)'="X"  ; FA TYPE not X (SGL 1524 excess)
 . . S ENSN=$TR($E($P(ENY3,U,5),1,5)," ","") ; station
 . . S ENFUND=$P(ENY3,U,10) ; fund
 . . S ^TMP($J,ENSN,ENFUND,ENDA)=""
 ; print output
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDTR=Y
 S ENL="",$P(ENL,"-",IOM)=""
 D HD
 I '$D(^TMP($J)) W !!,"No FA Documents for SGL 1524 in selected period",!
 S ENSN="" F  S ENSN=$O(^TMP($J,ENSN)) Q:ENSN=""  D  Q:END
 . W !
 . S ENFUND="" F  S ENFUND=$O(^TMP($J,ENSN,ENFUND)) Q:ENFUND=""  D  Q:END
 . . S ENDA=0 F  S ENDA=$O(^TMP($J,ENSN,ENFUND,ENDA)) Q:'ENDA  D  Q:END
 . . . S ENY0=$G(^ENG(6915.2,ENDA,0))
 . . . S ENY1=$G(^ENG(6915.2,ENDA,1))
 . . . S ENY3=$G(^ENG(6915.2,ENDA,3))
 . . . I $Y+4>IOSL D HD Q:END
 . . . W !,?3,ENSN,?11,ENFUND,?18,$P(ENY1,U,6)
 . . . W ?23,$P(ENY1,U,9),?35,$$FMTE^XLFDT($P(ENY0,U,2),"2D")
 . . . W ?45,$P(ENY0,U),?57,$J($FN($P(ENY3,U,27),",",2),14)
 I END W !!,"REPORT STOPPED AT USER REQUEST"
 E  I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 K END,ENDA,ENDT,ENDTE,ENDTR,ENDTS,ENFUND,ENL,ENPG,ENSN,ENY0,ENY1,ENY3
 Q
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"FA DOCUMENTS FOR EXCESS EQUIP. (SGL 1524)"
 W ?49,ENDTR,?72,"page ",ENPG
 W !,"  ACCOUNTING PERIOD FROM ",$$FMTE^XLFDT(ENDTS,"2D")
 W " TO ",$$FMTE^XLFDT(ENDTE,"2D")
 W !!,?3,"STATION",?11,"FUND",?18,"TRANSACTION"
 W ?45,"EQUIPMENT",?57,"ASSET VALUE"
 W !,?18,"CODE NUMBER      DATE",?45,"ENTRY #"
 W !,?3,"-------",?11,"------",?18,"---- ----------- --------"
 W ?45,"----------",?57,"--------------"
 Q
