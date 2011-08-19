ENFAR5B ;WIRMFO/SAB-FIXED ASSET RPT, VOUCHER SUMMARY (CONT); 5/22/97
 ;;7.0;ENGINEERING;**29,39**;Aug 17, 1993
GETBAL ; get balances from file #6915.9
 ; find station
 S ENI(1)=$$FIND1^DIC(6915.9,"","X",ENSNR,"B") Q:'ENI(1)
 ; loop thru fund
 S ENI(2)=0 F  S ENI(2)=$O(^ENG(6915.9,ENI(1),1,ENI(2))) Q:'ENI(2)  D
 . S ENFUND=$$GET1^DIQ(6915.91,ENI(2)_","_ENI(1)_",",.01)
 . ; loop thru sgl
 . S ENI(3)=0
 . F  S ENI(3)=$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3))) Q:'ENI(3)  D
 . . S ENSGL=$$GET1^DIQ(6915.911,ENI(3)_","_ENI(2)_","_ENI(1)_",",.01)
 . . ; get two balances
 . . S ENBAL1=$$GETBAL^ENFABAL(ENI(1),ENI(2),ENI(3),ENDTM1)
 . . S ENBAL2=$$GETBAL^ENFABAL(ENI(1),ENI(2),ENI(3),ENDTM2)
 . . ; save balances in ^tmp
 . . S:ENBAL1>0!(ENBAL2>0) ^TMP($J,ENFUND,ENSGL)=ENBAL1_U_ENBAL2
 Q
PRINT ; print results
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDTR=Y
 S ENL="",$P(ENL,"-",IOM)=""
 I '$D(^TMP($J)) S ENFUND="" D HD W !!,"No activity in selected period",!
 S ENDTMO=$$FMTE^XLFDT($E(ENDTS,1,5)_"00"),ENDTMC=$$FMTE^XLFDT(ENDTM2)
 S ENFUND="" F  S ENFUND=$O(^TMP($J,ENFUND)) Q:ENFUND=""  D  Q:END
 . S ENFUND("I")=$O(^ENG(6914.6,"B",ENFUND,0))
 . S ENFUND("A")=$S(ENFUND("I"):$P($G(^ENG(6914.6,ENFUND("I"),0)),U,4),1:"")
 . D HD Q:END
 . S ENSGL="" F  S ENSGL=$O(^TMP($J,ENFUND,ENSGL)) Q:ENSGL=""  D  Q:END
 . . S ENBAL=$G(^TMP($J,ENFUND,ENSGL))
 . . S ENSGL("I")=$O(^ENG(6914.3,"B",ENSGL,0))
 . . S ENSGL("A")=$S(ENSGL("I"):$P($G(^ENG(6914.3,ENSGL("I"),0)),U,4),1:"")
 . . W !!,?2,"SGL: ",ENSGL W:ENSGL("A")]"" " ",ENSGL("A")
 . . S ENT("SGL")=0 ; initialize SGL net activity
 . . W !,?12,"Opening Balance for ",ENDTMO,":"
 . . W ?43,$J("$"_$FN(+$P(ENBAL,U,1),",",2),16)
 . . S ENDT=""
 . . F  S ENDT=$O(^TMP($J,ENFUND,ENSGL,ENDT)) Q:ENDT=""  D  Q:END
 . . . S ENY=""
 . . . F  S ENY=$O(^TMP($J,ENFUND,ENSGL,ENDT,ENY)) Q:ENY=""  D  Q:END
 . . . . I $Y+4>IOSL D HD Q:END  D HDSGL
 . . . . S ENFILE=$P(ENY,";"),ENDA("F?")=$P(ENY,";",2)
 . . . . S ENAMT=$P(^TMP($J,ENFUND,ENSGL,ENDT,ENY),U)
 . . . . S ENY1=$G(^ENG(ENFILE,ENDA("F?"),1))
 . . . . S ENDA=$P($G(^ENG(ENFILE,ENDA("F?"),0)),U)
 . . . . W !,?4,$P(ENY1,U,6),?9,$P(ENY1,U,9),?21,$$FMTE^XLFDT(ENDT,"2D")
 . . . . W ?31,ENDA,?43,$J($FN(ENAMT,",",2),16)
 . . . . W ?61,$P($G(^ENG(6914,ENDA,2)),U,2) ; p.o.
 . . . . I ENFILE=6915.3 D
 . . . . . S ENNOTE=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,8)
 . . . . . I ENNOTE]"" W !,?9,"Desc: ",ENNOTE
 . . . . I ENFILE=6915.5 D
 . . . . . S ENNOTE=$P($G(^ENG(ENFILE,ENDA("F?"),5)),U,8)
 . . . . . I ENNOTE>0 W !,?9,"Sold: $",$FN(ENNOTE,",",2)
 . . . . S ENT("SGL")=ENT("SGL")+ENAMT
 . . Q:END
 . . W !,?12,"G/L Acct "_ENSGL_" Net Activity: "
 . . W ?43,$J($FN(ENT("SGL"),",",2),16)
 . . W !,?12,"Closing Balance for ",ENDTMC,":"
 . . W ?43,$J("$"_$FN(+$P(ENBAL,U,2),",",2),16)
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 K ENDTMC,ENDTMO
 Q
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"VOUCHER SUMMARY FOR STATION: ",ENSNR,?49,ENDTR,?72,"page ",ENPG
 W !,"  FUND: ",ENFUND W:$G(ENFUND("A"))]"" " ",ENFUND("A")
 W ?32,"   ACCOUNTING PERIOD FROM ",$$FMTE^XLFDT(ENDTS,"2D")
 W " TO ",$$FMTE^XLFDT(ENDTE,"2D")
 W !!,?4,"TRANSACTION",?31,"EQUIP ID#",?43,"NET AMOUNT",?61,"EQUIP P.O.#"
 W !,?4,"CODE NUMBER      DATE"
 W !,?4,"---- ----------- --------",?31,"----------"
 W ?43,"----------------",?61,"------------"
 Q
HDSGL ; header for continued SGL
 W !,?2,"SGL: ",ENSGL W:ENSGL("A")]"" " ",ENSGL("A") W " (continued)"
 Q
 ;ENFAR5B
