ENFAR2 ;WIRMFO/SAB-FIXED ASSET RPT, CAPITALIZED EQUIPMENT SUMMARY; 7/19/96
 ;;7.0;ENGINEERING;**25,33**;Aug 17, 1993
 ; Summary of Capitalized NX Equipment Assets by Station, Fund, SGL
EN ;
 ; ask type of breakdown
 S DIR(0)="Y",DIR("A")="Report SGL totals by Fund"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENBYFUND=Y
 ; ask device
 W !!,"This report searches the entire equipment file and may take some"
 W !,"time to complete. Consider queuing this report to run after-hours."
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFAR2",ZTSAVE("ENBYFUND")=""
 . S ZTDESC="Capitalized NX Equip. Summary for Station"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 ; collect data
 S (ENC,END)=0 K ENT
 S ENSND=$$GET1^DIQ(6910,"1,",1) S:ENSND="" ENSND="Unk" ; default station
 I 'ENBYFUND S ENFUND="all"
 S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D  Q:END
 . S ENC=ENC+1
 . I '(ENC#500),$D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 . S ENY8=$G(^ENG(6914,ENDA,8))
 . Q:$P(ENY8,U,2)'=1  ; not capitalized
 . Q:$P($G(^ENG(6914,ENDA,3)),U,11)]""  ; disposition date exists
 . Q:$P($G(^ENG(6914,ENDA,0)),U,4)'="NX"  ; not NX
 . S ENY9=$G(^ENG(6914,ENDA,9))
 . S ENSN=$P(ENY9,U,5) S:ENSN="" ENSN=ENSND
 . I ENBYFUND S X=$P(ENY9,U,7),ENFUND=$S(X:$P($G(^ENG(6914.6,X,0)),U),1:"<null>")
 . S ENSGL=$$GET1^DIQ(6914,ENDA_",",38) I ENSGL="" S ENSGL="<null>"
 . S:ENSGL="" ENSGL="<null>" ; for dangling pointers
 . S $P(ENT(ENSN,ENFUND,ENSGL),U)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U)+1 ; count
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,2)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U,2)+$P($G(^ENG(6914,ENDA,2)),U,3) ; asset value
 K ENY8,ENY9
 ; print results
 S ENPG=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 I 'END S ENSN="" F  S ENSN=$O(ENT(ENSN)) Q:ENSN=""  D  Q:END
 . D HD Q:END
 . S ENTS="0^0" ; initialize station totals
 . S ENFUND="" F  S ENFUND=$O(ENT(ENSN,ENFUND)) Q:ENFUND=""  D  Q:END
 . . S ENTF="0^0" ; initialize fund totals
 . . S ENSGL=""
 . . F  S ENSGL=$O(ENT(ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D  Q:END
 . . . I $Y+4>IOSL D HD Q:END
 . . . W !,?12,ENFUND,?22,ENSGL
 . . . W ?30,$J($P(ENT(ENSN,ENFUND,ENSGL),U),5)
 . . . W ?38,"$",$J($FN($P(ENT(ENSN,ENFUND,ENSGL),U,2),",",2),16)
 . . . S $P(ENTF,U)=$P(ENTF,U)+$P(ENT(ENSN,ENFUND,ENSGL),U)
 . . . S $P(ENTF,U,2)=$P(ENTF,U,2)+$P(ENT(ENSN,ENFUND,ENSGL),U,2)
 . . S $P(ENTS,U)=$P(ENTS,U)+$P(ENTF,U)
 . . S $P(ENTS,U,2)=$P(ENTS,U,2)+$P(ENTF,U,2)
 . . Q:'ENBYFUND
 . . I $Y+5>IOSL D HD  Q:END
 . . W !,?30,"-----",?38,"-----------------"
 . . W !,?30,$J($P(ENTF,U),5),?38,"$",$J($FN($P(ENTF,U,2),",",2),16),!
 . I $Y+5>IOSL D HD  Q:END
 . W !,?30,"-----",?38,"-----------------"
 . W !,?16,"STATION TOTAL"
 . W ?30,$J($P(ENTS,U),5),?38,"$",$J($FN($P(ENTS,U,2),",",2),16)
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 K ENBYFUND,ENC,ENDA,ENFUND,ENSGL,ENSN,ENSND,ENT,ENTF,ENTS
 K END,ENDT,ENL,ENPG
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"CAPITALIZED NX EQUIP. SUMMARY FOR STATION: ",ENSN
 W ?49,ENDT,?72,"page ",ENPG
 W !,ENL
 W !!,?20,"STANDARD",?38,"TOTAL"
 W !,?20,"GENERAL",?30,"ITEM",?38,"ASSET"
 W !,?12,"FUND",?20,"LEDGER",?30,"COUNT",?38,"VALUE"
 W !,?12,"------",?20,"--------",?30,"-----",?38,"-----------------"
 Q
 ;ENFAR2
