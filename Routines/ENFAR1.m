ENFAR1 ;WIRMFO/SAB-FIXED ASSET RPT, CAPITALIZED EQUIPMENT ON CMR; 3/11/96
 ;;7.0;ENGINEERING;**25**;Aug 17, 1993
 ; Capitalized Equipment List for CMR by CSN
 ;
CMR ; ask CMR
 S DIC=6914.1,DIC(0)="AQEM" D ^DIC K DIC G:Y'>0 EXIT
 S ENCMRI=+Y,ENCMR=$P(Y,U,2)
 I $$LOC^ENFAVAL(ENCMR)="" D  G CMR
 . W $C(7),!,"CMR ",ENCMR," is inappropriate for capitalized NX equip."
 . W !,"Please choose a different CMR.",!
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFAR1",ZTDESC="Capitalized Equipment on CMR"
 . S ZTSAVE("ENCMR")="",ZTSAVE("ENCMRI")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 ; collect and sort equipment
 K ^TMP($J)
 S ENDA="" F  S ENDA=$O(^ENG(6914,"AD",ENCMRI,ENDA)) Q:ENDA=""  D
 . Q:$P($G(^ENG(6914,ENDA,8)),U,2)'=1  ; not capitalized
 . S ENCSNI=$P($G(^ENG(6914,ENDA,2)),U,8)
 . S ENCSN=$S(ENCSNI:$P($G(^ENCSN(6917,ENCSNI,0)),U),1:"")
 . I ENCSN="" S (ENCSN,ENCSNI)="<null value>"
 . S ^TMP($J,ENCSN,ENDA)=""
 . I $D(^TMP($J,ENCSN))#10=0 S ^TMP($J,ENCSN)=ENCSNI
 ; generate output
 K ENT
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 S ENCSN="" D HD
 F  S ENCSN=$O(^TMP($J,ENCSN)) Q:ENCSN=""  D  Q:END
 . ; category stock number
 . S ENCSNI=$P($G(^TMP($J,ENCSN)),U)
 . I $Y+4>IOSL D HD Q:END
 . W !! W:ENCSNI $P($G(^ENCSN(6917,ENCSNI,0)),U,3) W " (CSN: ",ENCSN,")"
 . S ENDA=0 F  S ENDA=$O(^TMP($J,ENCSN,ENDA)) Q:'ENDA  D  Q:END
 . . ; equipment item
 . . I $Y+6>IOSL D HD Q:END  D HDCSN
 . . S ENY2=$G(^ENG(6914,ENDA,2))
 . . S X=$P($G(^ENG(6914,ENDA,8)),U,6)
 . . S ENSGL=$S(X:$P($G(^ENG(6914.3,X,0)),U),1:"")
 . . W !!,?2,ENDA ; equip id
 . . W ?13,$E($P($G(^ENG(6914,ENDA,1)),U,3),1,19) ; serial #
 . . W ?33,$J("$"_$FN($P(ENY2,U,3),",",2),14) ; asset value
 . . W ?48,ENSGL ; sgl
 . . W ?53,$E($P(ENY2,U,4),4,5),?55,"/",$E($P(ENY2,U,4),2,3) ; acq date
 . . W ?60,$P(ENY2,U,6) ; le
 . . W ?64,$E($P(ENY2,U,10),4,5),?66,"/",$E($P(ENY2,U,10),2,3) ; repl
 . . W ?71,$P(ENY2,U,7) ; nxrn
 . . S ENPM=$P($G(^ENG(6914,ENDA,3)),U,6)
 . . W:ENPM]"" !,?4,"PM: ",ENPM
 . . S ENMAN=$E($$GET1^DIQ(6914,ENDA_",",1),1,30)
 . . W:ENMAN]"" !,?4,"Manf: ",ENMAN
 . . S ENMOD=$P($G(^ENG(6914,ENDA,1)),U,2)
 . . W:ENMOD]"" !,?4,"Model: ",ENMOD
 . . S:ENSGL="" ENSGL="<null>"
 . . S $P(ENT(ENSGL),U)=$P($G(ENT(ENSGL)),U)+1
 . . S $P(ENT(ENSGL),U,2)=$P($G(ENT(ENSGL)),U,2)+$P(ENY2,U,3)
 I 'END D
 . ; report footer
 . S ENSGL="",ENC=0 F  S ENSGL=$O(ENT(ENSGL)) Q:ENSGL=""  S ENC=ENC+1
 . I $Y+ENC+6>IOSL D HD Q:END
 . W !,ENL,!,"TOTALS",?19,"COUNT",?27,"ASSET VALUE"
 . S ENT="0^0"
 . S ENSGL="" F  S ENSGL=$O(ENT(ENSGL)) Q:ENSGL=""  D
 . . W !,?8,"SGL ",ENSGL
 . . W ?19,$J($P(ENT(ENSGL),U),5)
 . . W ?27,"$",$J($FN($P(ENT(ENSGL),U,2),",",2),15)
 . . S $P(ENT,U)=$P(ENT,U)+$P(ENT(ENSGL),U)
 . . S $P(ENT,U,2)=$P(ENT,U,2)+$P(ENT(ENSGL),U,2)
 . W !,?19,"-----",?27,"----------------"
 . W !,?5,"REPORT TOTAL"
 . W ?19,$J($P(ENT,U),5),?27,"$",$J($FN($P(ENT,U,2),",",2),15)
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 K ENC,ENCMR,ENCMRI,ENCSN,ENCSNI,ENDA,ENMAN,ENMOD,ENPM,ENSGL,ENT,ENY2
 K END,ENDT,ENL,ENPG
 Q
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"CAPITALIZED EQUIPMENT BY CSN FOR CMR: ",$E(ENCMR,1,5)
 W ?48,ENDT,?72,"page ",ENPG
 W !!,?2,"EQUIP ID #",?13,"SERIAL NUMBER",?33,"ASSET VALUE",?48,"SGL"
 W ?53,"ACQ",?60,"LE",?64,"REPL",?71,"NXRN"
 W !,?2,$E(ENL,1,10),?13,$E(ENL,1,19),?33,$E(ENL,1,14),?48,$E(ENL,1,4)
 W ?53,$E(ENL,1,5),?60,$E(ENL,1,2),?64,$E(ENL,1,5),?71,$E(ENL,1,8)
 Q
HDCSN ; header for continued CSN
 I $G(ENCSN)]"" D
 . W ! W:$G(ENCSNI) $P($G(^ENCSN(6917,ENCSNI,0)),U,3)
 . W " (CSN: ",ENCSN," continued)"
 Q
 ;ENFAR1
