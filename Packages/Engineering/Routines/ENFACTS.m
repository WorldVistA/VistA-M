ENFACTS ;(WCIOFO)/SAB-FAP CAPITALIZATION THRESHOLD SKIP LIST ;10/23/2000
 ;;7.0;ENGINEERING;**63**;Aug 17, 1993
EN ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFACTS"
 . S ZTDESC="ENG List Equip to Remain Capitalized"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
COLLECT ; collect data
 S END=0 ; init flag, =true if user stopped job
 K ENT ; totals ENT(station,fund,sgl)
 ;       =capitalized count^$^to remain capitalized count^$
 K ^TMP($J)
 ;
 ; loop thru equipment in FA DOCUMENT LOG file
 S ENDA=0 F  S ENDA=$O(^ENG(6915.2,"B",ENDA)) Q:'ENDA  D
 . Q:+$$CHKFA^ENFAUTL(ENDA)'>0  ; not currently reported to FAP
 . ; get equipment data
 . S ENSN=$$GET1^DIQ(6914,ENDA_",",60)_" " S:ENSN=" " ENSN="UNK"
 . S ENFUND=$$GET1^DIQ(6914,ENDA_",",62)_" " S:ENFUND=" " ENFUND="UNK"
 . S ENSGL=$$GET1^DIQ(6914,ENDA_",",38) S:ENSGL="" ENSGL="UNK"
 . S ENVAL=$$GET1^DIQ(6914,ENDA_",",12)
 . ; update capitalized count and amount
 . S $P(ENT(ENSN,ENFUND,ENSGL),U)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U)+1
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,2)=$P(ENT(ENSN,ENFUND,ENSGL),U,2)+ENVAL
 . ; quit if item should be expensed
 . S ENX=$$CHKEXP^ENFACTU(ENDA)
 . Q:$P(ENX,U)=1
 . ; put on sorted list of items that will remain cap. and update counts
 . S ENSYS=+$$TOPSYS^ENFACTU(ENDA) ; plus value to treat ? as standalone
 . S ENSYSV=+$S(ENSYS>0:$$SYSVAL^ENFACTU(ENSYS,"C"),1:ENVAL)
 . S ^TMP($J,ENSN,ENSYSV,ENSYS,ENDA)=ENX
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,3)=$P(ENT(ENSN,ENFUND,ENSGL),U,3)+1
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,4)=$P(ENT(ENSN,ENFUND,ENSGL),U,4)+ENVAL
 ;
PRINT ; print results
 S ENPG=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 I '$D(ENT) S ENSN="" D HD  W !!,"Nothing to report."
 ; loop thru ENT( by station
 S ENSN="" F  S ENSN=$O(ENT(ENSN)) Q:ENSN=""  D  Q:END
 . D HD Q:END
 . I '$D(^TMP($J,ENSN)) W !!,"NO EQUIPMENT WILL REMAIN CAPITALIED WHEN TASK RUNS FOR THIS STATION."
 . ; loop thru system values in ^TMP(
 . S ENSYSV="" F  S ENSYSV=$O(^TMP($J,ENSN,ENSYSV)) Q:ENSYSV=""  D  Q:END
 . . ; loop thru system # (will be 0 for standalone items)
 . . S ENSYS=""
 . . F  S ENSYS=$O(^TMP($J,ENSN,ENSYSV,ENSYS)) Q:ENSYS=""  D  Q:END
 . . . ; if system then print parent data and system info
 . . . I ENSYS>0 D
 . . . . W !!,?2,"TOP PARENT SYSTEM ENTRY #: ",ENSYS
 . . . . W ?40,"CMR: ",$E($$GET1^DIQ(6914,ENSYS,19),1,5)
 . . . . W ?51,"Parent Value: "
 . . . . I +$$CHKFA^ENFAUTL(ENSYS) W $FN($$GET1^DIQ(6914,ENSYS,12),",",2)
 . . . . E  W "not in FAP"
 . . . . S ENCSN=$$GET1^DIQ(6914,ENSYS,18)
 . . . . W !,?2,"CATEGORY STOCK NUMBER: ",ENCSN
 . . . . I ENCSN]"" W " (",$$GET1^DIQ(6914,ENSYS,"18:2"),")"
 . . . . I +$$CHKFA^ENFAUTL(ENSYS) D
 . . . . . S ENTSK=$G(^TMP($J,ENSN,ENSYSV,ENSYS,ENSYS))
 . . . . . I $P(ENTSK,U)=0 W !,"  Reason: ",$P(ENTSK,U,2)
 . . . . . I $P(ENTSK,U)="U" W !,"  Reason: ",$P(ENTSK,U,2)," indicated it should remain capitalized."
 . . . . W !,?2,"Sum of Capitalized Values in System: "
 . . . . W $FN(ENSYSV,",",2)
 . . . ; loop thru equipment
 . . . S ENDA=0
 . . . F  S ENDA=$O(^TMP($J,ENSN,ENSYSV,ENSYS,ENDA)) Q:'ENDA  D  Q:END
 . . . . Q:ENDA=ENSYS  ; already displayed as parent of system
 . . . . I $Y+6>IOSL D HD Q:END  W " (continued)"
 . . . . S ENCSN=$$GET1^DIQ(6914,ENDA,18)
 . . . . ; print format for component of system
 . . . . I ENSYS>0 D
 . . . . . W !!,?6,"COMPONENT ENTRY #: ",ENDA
 . . . . . W ?36,"CMR: ",$E($$GET1^DIQ(6914,ENDA,19),1,5)
 . . . . . W ?47,"Component Value: ",$FN($$GET1^DIQ(6914,ENDA,12),",",2)
 . . . . . W !,?6,"CATEGORY STOCK NUMBER: ",ENCSN
 . . . . . I ENCSN]"" W " (",$$GET1^DIQ(6914,ENDA,"18:2"),")"
 . . . . ; print format for standalone equipment
 . . . . I ENSYS=0 D
 . . . . . W !!,?2,"ENTRY #: ",ENDA
 . . . . . W ?22,"CMR: ",$E($$GET1^DIQ(6914,ENDA,19),1,5)
 . . . . . W ?33,"Value: ",$FN($$GET1^DIQ(6914,ENDA,12),",",2)
 . . . . . W !,?2,"CATEGORY STOCK NUMBER: ",ENCSN
 . . . . . I ENCSN]"" W " (",$$GET1^DIQ(6914,ENDA,"18:2"),")"
 . . . . S ENTSK=$G(^TMP($J,ENSN,ENSYSV,ENSYS,ENDA))
 . . . . I $P(ENTSK,U)=0 D
 . . . . . W !,"  ",$S(ENSYS>0:"    ",1:""),"Reason: ",$P(ENTSK,U,2)
 . . . . I $P(ENTSK,U)="U" D
 . . . . . W !,"  ",$S(ENSYS>0:"    ",1:""),"Reason: ",$P(ENTSK,U,2)," indicated it should remain capitalized."
 . Q:END
 . ; print station totals
 . I $Y+14>IOSL D HD Q:END  W " (continued)"
 . D HDST
 . S ENFUND="" F  S ENFUND=$O(ENT(ENSN,ENFUND)) Q:ENFUND=""  D  Q:END
 . . S ENSGL=""
 . . F  S ENSGL=$O(ENT(ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D  Q:END
 . . . I $Y+6>IOSL D HD Q:END  W " (continued)" D HDST
 . . . W !,ENFUND,?7,ENSGL
 . . . S ENX=$G(ENT(ENSN,ENFUND,ENSGL))
 . . . W ?12,$J($FN($P(ENX,U,1),","),5)
 . . . W ?18,$J($FN($P(ENX,U,2),",",2),14)
 . . . W ?35,$J($FN($P(ENX,U,3),","),5)
 . . . W ?41,$J($FN($P(ENX,U,4),",",2),14)
 . . . W ?58,$J($FN($P(ENX,U,1)-$P(ENX,U,3),","),5)
 . . . W ?64,$J($FN($P(ENX,U,2)-$P(ENX,U,4),",",2),14)
 . . . ; add sgl to subtotals for station
 . . . S $P(ENT(ENSN),U,1)=$P($G(ENT(ENSN)),U,1)+$P(ENX,U,1)
 . . . S $P(ENT(ENSN),U,2)=$P(ENT(ENSN),U,2)+$P(ENX,U,2)
 . . . S $P(ENT(ENSN),U,3)=$P(ENT(ENSN),U,3)+$P(ENX,U,3)
 . . . S $P(ENT(ENSN),U,4)=$P(ENT(ENSN),U,4)+$P(ENX,U,4)
 . W !,"            ----- --------------   ----- --------------   ----- --------------"
 . W !,"Station Tot"
 . W ?12,$J($FN($P(ENT(ENSN),U,1),","),5)
 . W ?18,$J($FN($P(ENT(ENSN),U,2),",",2),14)
 . W ?35,$J($FN($P(ENT(ENSN),U,3),","),5)
 . W ?41,$J($FN($P(ENT(ENSN),U,4),",",2),14)
 . W ?58,$J($FN($P(ENT(ENSN),U,1)-$P(ENT(ENSN),U,3),","),5)
 . W ?64,$J($FN($P(ENT(ENSN),U,2)-$P(ENT(ENSN),U,4),",",2),14)
 I END W !!,"REPORT STOPPED BY USER REQUEST"
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,END,ENDT,ENL,ENPG
 K ENCSN,ENDA,ENFUND,ENSGL,ENSN,ENSYS,ENSYSV,ENT,ENTSK,ENVAL,ENX
 Q
 ;
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"EQUIPMENT TO REMAIN CAPITALIZED sorted by value"
 W ?49,ENDT,?72,"page ",ENPG
 W !,ENL
 I ENSN]"" W !,"STATION ",ENSN
 Q
 ;
HDST ; header for station totals
 W !!,"            Current Capitalized    Remain Capitalized     CT Task Will Expense"
 W !,"Fund   SGL  Count   $ Amount       Count   $ Amount       Count   $ Amount"
 W !,"------ ---- ----- --------------   ----- --------------   ----- --------------"
 Q
 ;ENFACTS
