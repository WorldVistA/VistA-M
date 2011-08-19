ENFABAL2 ;WIRMFO/SAB-MAINTAIN FILE 6915.9 FAP BALANCES (cont) ;7/19/96
 ;;7.0;ENGINEERING;**29,33**;AUG 17, 1883
 ;This routine should not be modified.
EN ; called from RECALC^ENFABAL
 W !,"Report of FAP Recalculation for "_$$FMTE^XLFDT(ENDTR)
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFABAL2"
 . S ZTDESC="Report of FAP Recalc for "_$$FMTE^XLFDT(ENDTR)
 . F X="ENDTR","^TMP($J,""P""," S ZTSAVE(X)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 N END,ENDT,ENFUND,ENL,ENPG,ENSGL,ENSN
 U IO
 ; generate output
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 D HD
 S ENSN="" F  S ENSN=$O(^TMP($J,"P",ENSN)) Q:ENSN=""  D
 . S ENFUND="" F  S ENFUND=$O(^TMP($J,"P",ENSN,ENFUND)) Q:ENFUND=""  D
 . . S ENSGL=""
 . . F  S ENSGL=$O(^TMP($J,"P",ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D
 . . . S Y=$G(^TMP($J,"P",ENSN,ENFUND,ENSGL))
 . . . I $Y+5>IOSL D HD
 . . . W !,?2,ENSN,?11,ENFUND,?19,ENSGL,?23,$J($P(Y,U),13,2)
 . . . W ?42,$J($P(Y,U,2),13,2)
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@" K ^TMP($J)
EXIT K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 Q
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"FAP Net Activity Comparison",?48,ENDT,?72,"page ",ENPG
 W !!,"FAP Balance File vs. Recalculation for ",$$FMTE^XLFDT(ENDTR)
 W !!,?2,"STATION",?11,"FUND",?19,"SGL",?25,"NET FROM FILE"
 W ?42,"NET FROM RECALCULATION"
 Q
 ;
TVSF ; compare transactions vs. file
 ; called from RECALC^ENFABAL
 ; input
 ;   ENDTR - month to recalculate (FileMan date)
 ;   ^TMP($J,"R",station,fund,sgl)=net $ activity from recalc
 ; output -
 ;   problems where net activity is not equal in
 ;     ^TMP($J,"P",station,fund,sgl)=net from file^net from recalc
 N ENI,ENFUND,ENFUNDI,ENPM,ENPMI,ENSGL,ENSGLI,ENSMI,ENSN,PAMT,RAMT,SAMT
 ; loop thru station
 S ENSN="" F  S ENSN=$O(^TMP($J,"R",ENSN)) Q:ENSN=""  D
 . S ENI(1)=$O(^ENG(6915.9,"B",ENSN,0))
 . ; loop thru fund
 . S ENFUND="" F  S ENFUND=$O(^TMP($J,"R",ENSN,ENFUND)) Q:ENFUND=""  D
 . . S ENFUNDI=$O(^ENG(6914.6,"B",ENFUND,0))
 . . S ENI(2)=$S(ENI(1):$O(^ENG(6915.9,ENI(1),1,"B",ENFUNDI,0)),1:"")
 . . ; loop thru sgl
 . . S ENSGL=""
 . . F  S ENSGL=$O(^TMP($J,"R",ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D
 . . . S ENSGLI=$O(^ENG(6914.3,"B",ENSGL,0))
 . . . S ENI(3)=$S(ENI(2):$O(^ENG(6915.9,ENI(1),1,ENI(2),1,"B",ENSGLI,0)),1:"")
 . . . I ENI(1),ENI(2),ENI(3) Q  ; already checked in FVST module
 . . . S ENSMI=$S(ENI(3):$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",ENDTR,0)),1:"")
 . . . S ENPM=$S(ENI(3):$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",ENDTR),-1),1:"")
 . . . S ENPMI=$S(ENPM:$O(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,"B",ENPM,0)),1:"")
 . . . S SAMT=$S(ENSMI:$P($G(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENSMI,0)),U,2),1:"")
 . . . S PAMT=$S(ENPMI:$P($G(^ENG(6915.9,ENI(1),1,ENI(2),1,ENI(3),1,ENPMI,0)),U,2),1:"")
 . . . I SAMT="" S SAMT=PAMT ; balance inherited from prior month
 . . . S RAMT=$P($G(^TMP($J,"R",ENSN,ENFUND,ENSGL)),U)
 . . . I +(SAMT-PAMT)'=+RAMT S ^TMP($J,"P",ENSN,ENFUND,ENSGL)=(+(SAMT-PAMT))_U_(+RAMT)
 Q
 ;ENFABAL2
