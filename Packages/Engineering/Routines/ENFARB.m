ENFARB ;WIRMFO/SAB-FIXED ASSET RPT, SUMMARY OF SGL $ BALANCES; 12/16/96
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
 ; Summary of $ Balances by Station, [Fund,] and SGL
EN ;
 ; ask for period (month/year)
 S DIR(0)="D^::E^K:($E(Y,4,5)=""00"")!($E(Y,1,5)>$E(DT,1,5)) X"
 S DIR("A")="Enter month of desired closing balances"
 S X("Y")=$E(DT,1,3),X("M")=$E(DT,4,5)
 S X=$S(X("M")="01":(X("Y")-1)_"12",1:X("Y")_$E("00",1,2-$L(X("M")-1))_(X("M")-1))_"00"
 S DIR("B")=$$FMTE^XLFDT(X)
 K X
 S DIR("?",1)="Month and year are required and future dates are invalid."
 S DIR("?",2)="This date will be used to select the closing balances"
 S DIR("?",3)="that will be shown on the output."
 S DIR("?",4)=" "
 S DIR("?")="Enter the month and year."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENDTR=$E(Y,1,5)_"00" ; month to report
 ; ask type of breakdown
 S DIR(0)="Y",DIR("A")="Report SGL totals by Fund"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENBYFUND=Y
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFARB"
 . S ZTSAVE("ENDTR")="",ZTSAVE("ENBYFUND")=""
 . S ZTDESC="FAP $ Balances"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
COLLECT ; collect data
 S END=0 K ENT
 I 'ENBYFUND S ENFUND="all"
 ; loop thru stations
 S ENI(1)=0 F  S ENI(1)=$O(^ENG(6915.9,ENI(1))) Q:'ENI(1)  D
 . S ENSN=$$GET1^DIQ(6915.9,ENI(1)_",",.01)
 . ; loop thru funds
 . S ENI(2)=0 F  S ENI(2)=$O(^ENG(6915.9,ENI(1),1,ENI(2))) Q:'ENI(2)  D
 . . S:ENBYFUND ENFUND=$$GET1^DIQ(6915.91,ENI(2)_","_ENI(1)_",",.01)
 . . ; loop thru standard general ledgers
 . . S ENI(3)=0
 . . F  S ENI(3)=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3))) Q:'ENI(3)  D
 . . . S ENSGL=$$GET1^DIQ(6915.911,ENI(3)_","_ENI(2)_","_ENI(1)_",",.01)
 . . . S ENBAL=$$GETBAL^ENFABAL(ENI(1),ENI(2),ENI(3),ENDTR)
 . . . S:ENBAL>0 ENT(ENSN,ENFUND,ENSGL)=$G(ENT(ENSN,ENFUND,ENSGL))+ENBAL
PRINT ; print results
 S ENPG=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENDTR("E")=$$FMTE^XLFDT(ENDTR)
 S ENL="",$P(ENL,"-",IOM)=""
 S ENSN="" F  S ENSN=$O(ENT(ENSN)) Q:ENSN=""  D  Q:END
 . D HD Q:END
 . S ENTS="0^0" ; initialize station totals
 . S ENFUND="" F  S ENFUND=$O(ENT(ENSN,ENFUND)) Q:ENFUND=""  D  Q:END
 . . S ENTF="0^0" ; initialize fund totals
 . . S ENSGL=""
 . . F  S ENSGL=$O(ENT(ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D  Q:END
 . . . I $Y+4>IOSL D HD Q:END
 . . . W !,?12,ENFUND,?22,ENSGL
 . . . W ?30,"$",$J($FN($P(ENT(ENSN,ENFUND,ENSGL),U),",",2),16)
 . . . S $P(ENTF,U)=$P(ENTF,U)+$P(ENT(ENSN,ENFUND,ENSGL),U)
 . . Q:END
 . . S $P(ENTS,U)=$P(ENTS,U)+$P(ENTF,U)
 . . Q:'ENBYFUND
 . . I $Y+5>IOSL D HD Q:END
 . . W !,?30,"-----------------"
 . . W !,?30,"$",$J($FN($P(ENTF,U),",",2),16),!
 . Q:END
 . I $Y+5>IOSL D HD Q:END
 . W !,?30,"-----------------"
 . W !,?16,"STATION TOTAL"
 . W ?30,"$",$J($FN($P(ENTS,U),",",2),16)
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K ENBAL,ENBYFUND,ENDA,ENDTR,ENFUND,ENI,ENSGL,ENSN,ENT,ENTF,ENTS
 K END,ENDT,ENL,ENPG
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,ENDTR("E")," ",$S($E(ENDTR,1,5)=$E(DT,1,5):"CURRENT",1:"CLOSING")
 W " BALANCES FOR STATION: ",ENSN
 W ?49,ENDT,?72,"page ",ENPG
 W !,ENL
 W !!,?20,"STANDARD",?30,"TOTAL"
 W !,?20,"GENERAL",?30,"ASSET"
 W !,?12,"FUND",?20,"LEDGER",?30,"VALUE"
 W !,?12,"------",?20,"--------",?30,"-----------------"
 Q
 ;ENFARB
