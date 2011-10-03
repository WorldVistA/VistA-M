ENFAR8 ;WIRMFO/SAB-FIXED ASSET RPT, EQUIP LOCATOR LIST FOR STATION ;1/18/2001
 ;;7.0;ENGINEERING;**29,33,50,63,69**;Aug 17, 1993
 ; Equipment Locator List for STATION
 ;
EN ;
 ; ask STATION
 S DIR(0)="F^3:5",DIR("A")="STATION NUMBER"
 S DIR("B")=$$GET1^DIQ(6910,"1,",1)
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENSNR=Y
 ; ask about including not capitalized/accountable equipment
 S DIR(0)="Y"
 S DIR("A")="Include Not Capitalized/Accountable Equipment"
 S DIR("B")="YES"
 S DIR("?",1)="This report lists capitalized equipment on a CMR."
 S DIR("?",2)=" "
 S DIR("?",3)="Equipment with an Investment Category of NOT CAPITALIZED/ACCOUNTABLE"
 S DIR("?",4)="can also be included in the output."
 S DIR("?",6)=" "
 S DIR("?")="Enter YES to list all accountable equipment."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENEXP=Y
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFAR8",ZTDESC="Equipment List for Station"
 . S ZTSAVE("ENSNR")="",ZTSAVE("ENEXP")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 ; collect and sort equipment
 K ^TMP($J)
 S ENSND=$$GET1^DIQ(6910,"1,",1) ; default station number
 S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D
 . S ENSN=$P($G(^ENG(6914,ENDA,9)),U,5) S:ENSN="" ENSN=ENSND
 . Q:ENSN'=ENSNR  ; not station
 . S ENY2=$G(^ENG(6914,ENDA,2))
 . S X=$P(ENY2,U,9),ENCMR=$S(X:$E($P($G(^ENG(6914.1,X,0)),U),1,5),1:"")
 . Q:ENCMR=""  ; not on a CMR
 . S ENCSNI=$P(ENY2,U,8)
 . S ENCSN=$S(ENCSNI:$P($G(^ENCSN(6917,ENCSNI,0)),U),1:"")
 . I ENCSN="" S (ENCSN,ENCSNI)="<null value>"
 . S ENY8=$G(^ENG(6914,ENDA,8))
 . ; quit when not capitalized (or not accountable if user specified)
 . Q:$S(ENEXP:"^1^A^",1:"^1^")'[(U_$P(ENY8,U,2)_U)
 . ;Q:'($P(ENY8,U,2))  ;*63
 . ;Q:'($P(ENY8,U,2))&'(ENEXP&("^10^23^70^"[(U_$E(ENCSN,1,2)_U)))  ;*50
 . S ^TMP($J,ENCSN,ENCMR,ENDA)=""
 . I $D(^TMP($J,ENCSN))#10=0 S ^TMP($J,ENCSN)=ENCSNI
 ; generate output
 K ENT
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 S ENCSN="" D HD
 I 'END F  S ENCSN=$O(^TMP($J,ENCSN)) Q:ENCSN=""  D  Q:END
 . ; category stock number
 . S ENC="0^0" ; initialize CSN count and value
 . S ENCSNI=$P($G(^TMP($J,ENCSN)),U)
 . I $Y+4>IOSL D HD Q:END
 . W !! W:ENCSNI $P($G(^ENCSN(6917,ENCSNI,0)),U,3) W " (CSN: ",ENCSN,")"
 . S ENCMR="" F  S ENCMR=$O(^TMP($J,ENCSN,ENCMR)) Q:ENCMR=""  D  Q:END
 . . ; cmr
 . . S ENDA=0 F  S ENDA=$O(^TMP($J,ENCSN,ENCMR,ENDA)) Q:'ENDA  D  Q:END
 . . . ; equipment item
 . . . S ENY2=$G(^ENG(6914,ENDA,2))
 . . . S X=$P($G(^ENG(6914,ENDA,8)),U,6)
 . . . S ENSGL=$S(X:$P($G(^ENG(6914.3,X,0)),U),1:"")
 . . . S ENFUND=$$GET1^DIQ(6914,ENDA,62)
 . . . S ENI=5 ; number of lines needed to print item
 . . . S ENPM=$P($G(^ENG(6914,ENDA,3)),U,6) S:ENPM]"" ENI=ENI+1
 . . . S ENMAN=$E($$GET1^DIQ(6914,ENDA_",",1),1,30) S:ENMAN]"" ENI=ENI+1
 . . . S ENMOD=$P($G(^ENG(6914,ENDA,1)),U,2) S:ENMOD]"" ENI=ENI+1
 . . . S ENSERIAL=$P($G(^ENG(6914,ENDA,1)),U,3) S:ENSERIAL]"" ENI=ENI+1
 . . . I IOM'>89,$P(ENY2,U,13)]"" S ENI=ENI+1
 . . . I $Y+ENI>IOSL D HD Q:END  D HDCSN
 . . . W !!,?1,ENDA ; equipment id
 . . . W ?12,$E($P(ENY2,U,4),4,5),?14,"/",$E($P(ENY2,U,4),2,3) ; acq date
 . . . W ?18,ENFUND ; fund
 . . . W ?25,ENSGL ; sgl
 . . . W ?30,$J("$"_$FN($P(ENY2,U,3),",",2),14) ; asset value
 . . . W ?45,$P(ENY2,U,6) ; le
 . . . W ?48,$E($P(ENY2,U,10),4,5),?50,"/",$E($P(ENY2,U,10),2,3) ; repl
 . . . W ?54,$$GET1^DIQ(6914,ENDA,24) ; location
 . . . W ?74,ENCMR ; cmr
 . . . I IOM>89,$P(ENY2,U,13)]"" W ?80,$$FMTE^XLFDT($P(ENY2,U,13),2)
 . . . W:ENPM]"" !,?4,"PM: ",ENPM
 . . . W:ENMAN]"" !,?4,"Manf: ",ENMAN
 . . . W:ENMOD]"" !,?4,"Model: ",ENMOD
 . . . W:ENSERIAL]"" !,?4,"S/N: ",ENSERIAL
 . . . I IOM'>89,$P(ENY2,U,13)]"" W !,?4,"Last Inv. Date: ",$$FMTE^XLFDT($P(ENY2,U,13),2)
 . . . S:ENSGL="" ENSGL="<null>"
 . . . S $P(ENT(ENSGL),U)=$P($G(ENT(ENSGL)),U)+1
 . . . S $P(ENT(ENSGL),U,2)=$P($G(ENT(ENSGL)),U,2)+$P(ENY2,U,3)
 . . . S $P(ENC,U)=$P($G(ENC),U)+1
 . . . S $P(ENC,U,2)=$P($G(ENC),U,2)+$P(ENY2,U,3)
 . Q:END
 . W !,?13,"(CSN TOTAL",?24,$J("#"_$P(ENC,U),3)
 . W ?30,$J("$"_$FN($P(ENC,U,2),",",2),14),")"
 I END W !!,"REPORT STOPPED BY USER REQUEST"
 E  D
 . ; report footer
 . S ENSGL="",ENC=0 F  S ENSGL=$O(ENT(ENSGL)) Q:ENSGL=""  S ENC=ENC+1
 . I $Y+ENC+6>IOSL D HD Q:END
 . W !,ENL,!,"TOTALS",?20,"COUNT",?30,"ASSET VALUE"
 . S ENT="0^0"
 . S ENSGL="" F  S ENSGL=$O(ENT(ENSGL)) Q:ENSGL=""  D
 . . W !,?9,"SGL ",ENSGL
 . . W ?20,$J($P(ENT(ENSGL),U),5)
 . . W ?30,"$",$J($FN($P(ENT(ENSGL),U,2),",",2),15)
 . . S $P(ENT,U)=$P(ENT,U)+$P(ENT(ENSGL),U)
 . . S $P(ENT,U,2)=$P(ENT,U,2)+$P(ENT(ENSGL),U,2)
 . W !,?20,"-----",?30,"----------------"
 . W !,?6,"REPORT TOTAL"
 . W ?20,$J($P(ENT,U),5)
 . W ?30,"$",$J($FN($P(ENT,U,2),",",2),15)
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K DIR,DIROUT,DIRUT,DIWF,DIWL,DTOUT,DUOUT,X,Y
 K ENC,ENCMR,ENCMRI,ENCSN,ENCSNI,ENDA,ENFUND,ENI,ENMAN,ENMOD,ENPM
 K ENSERIAL,ENSGL,ENSN,ENSND,ENSNR,ENT,ENY2
 K END,ENDT,ENL,ENPG
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,$S(ENEXP:"ACCOUNTABLE",1:"CAPITALIZED")," NX EQUIP. FOR STATION: "
 W ENSNR,?48,ENDT,?72,"page ",ENPG
 W !!,?1,"EQUIPMENT",?12,"ACQ",?18,"FUND",?25,"SGL",?30,"ASSET VALUE"
 W ?45,"LE",?48,"REPL",?54,"LOCATION",?74,"CMR"
 W:IOM>89 ?80,"INVENTORY"
 W !,?1,"ENTRY #",?12,"DATE",?48,"DATE",?54,"ROOM-BLDG-DIV"
 W:IOM>89 ?80,"DATE"
 W !,?1,$E(ENL,1,10),?12,$E(ENL,1,5),?18,$E(ENL,1,6),?25,$E(ENL,1,4)
 W ?30,$E(ENL,1,14),?45,$E(ENL,1,2),?48,$E(ENL,1,5),?54,$E(ENL,1,19)
 W ?74,$E(ENL,1,5)
 W:IOM>89 ?80,$E(ENL,1,9)
 Q
HDCSN ; header for continued CSN
 I $G(ENCSN)]"" D
 . W ! W:$G(ENCSNI) $P($G(^ENCSN(6917,ENCSNI,0)),U,3)
 . W " (CSN: ",ENCSN," continued)"
 Q
 ;ENFAR8
