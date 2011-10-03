ENFACTR ;(WCIOFO)/SAB-FAP CAPITALIZATION THRESHOLD REMOVED LIST ;10/14/1999
 ;;7.0;ENGINEERING;**63**;Aug 17, 1993
EN ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFACTR"
 . S ZTDESC="ENG List Equip Removed from Expensed List"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
COLLECT ; collect data
 S END=0 ; init flag, =true if user stopped job
 K ^TMP($J)
 ;
 ; loop thru equipment in FA DOCUMENT LOG file
 S ENDA=0 F  S ENDA=$O(^ENG(6915.2,"B",ENDA)) Q:'ENDA  D
 . Q:+$$CHKFA^ENFAUTL(ENDA)'>0  ; not currently reported to FAP
 . S ENX=$$CHKEXP^ENFACTU(ENDA)
 . Q:$P(ENX,U)'="U"  ; not exempted by user
 . ; put on sorted list to report
 . S ENSN=$$GET1^DIQ(6914,ENDA_",",60)_" " S:ENSN=" " ENSN="UNK"
 . S ^TMP($J,ENSN,ENDA)=$P(ENX,U,2)
 ;
PRINT ; print results
 S ENPG=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 I '$D(^TMP($J)) S ENSN="" D HD  W !!,"Nothing to report."
 ; loop thru station
 S ENSN="" F  S ENSN=$O(^TMP($J,ENSN)) Q:ENSN=""  D  Q:END
 . D HD Q:END
 . ; loop thru equipment
 . S ENDA=0 F  S ENDA=$O(^TMP($J,ENSN,ENDA)) Q:'ENDA  D  Q:END
 . . I $Y+4>IOSL D HD Q:END  W " (continued)"
 . . S ENCSN=$$GET1^DIQ(6914,ENDA,18)
 . . W !!,?2,"ENTRY #: ",ENDA
 . . W ?22,"CMR: ",$E($$GET1^DIQ(6914,ENDA,19),1,5)
 . . W ?33,"Value: ",$FN($$GET1^DIQ(6914,ENDA,12),",",2)
 . . W !,?2,"CATEGORY STOCK NUMBER: ",ENCSN
 . . I ENCSN]"" W " (",$$GET1^DIQ(6914,ENDA,"18:2"),")"
 . . W !,?2,"Remain Capitalized set by: ",$G(^TMP($J,ENSN,ENDA))
 . Q:END
 I END W !!,"REPORT STOPPED BY USER REQUEST"
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,END,ENDT,ENL,ENPG
 K ENCSN,ENDA,ENSN,ENX
 Q
 ;
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"EQUIPMENT THAT USER REMOVED FROM CT TASK"
 W ?49,ENDT,?72,"page ",ENPG
 W !,ENL
 I ENPG=1 D
 . W !,"The following equipment meets the system criteria to expense, but no action"
 . W !,"will be taken because a user indicated that it should remain capitalized.",!
 I ENSN]"" W !,"STATION ",ENSN
 Q
 ;
 ;ENFACTR
