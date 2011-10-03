ENFAR3 ;WIRMFO/SAB-FIXED ASSET RPT, CHECK OF EQUIP CAPITALIZATION ;5/29/2002
 ;;7.0;ENGINEERING;**25,63,71**;Aug 17, 1993
 ;-----------------------------------------------------------------
 ;Patch 71 Increases Threshold from $25,000.00 to $100,000.00
 ;
 ;ENCAP = Investment Category
 ;ENSGL = Standard General Ledger
 ; ENCT = Capitalization Threshold
 ;ENTYI = Type of Entry
 ;
 ;-----------------------------------------------------------------
EN W !,"This report searches the entire equipment file and may take some"
 W !,"time to complete. Consider queuing this report to run after-hours."
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFAR3",ZTDESC="Check of Equipment Capitalization"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 D HD
 ;
 ;The new capitalization threshold of 100K will take effect for
 ;this report after the 1-time job runs on July 24, 2002 (3020724).
 S ENCT=$S(DT>3020724:100000,1:25000)
 ;
 ; loop thru equipment file
 S ENT=0
 S ENDA=0 F  S ENDA=$O(^ENG(6914,ENDA)) Q:'ENDA  D  Q:END
 . Q:$P($G(^ENG(6914,ENDA,3)),U,11)]""  ; ignore dispositioned items
 . S ENY2=$G(^ENG(6914,ENDA,2)),ENY8=$G(^ENG(6914,ENDA,8))
 . S ENTYI=$P($G(^ENG(6914,ENDA,0)),U,4) ;TYPE OF ENTRY (#7)
 . S ENVAL=$P(ENY2,U,3) ;TOTAL ASSET VALUE (#12)
 . S X=$P(ENY2,U,9),ENCMR=$S(X:$P($G(^ENG(6914.1,X,0)),U),1:X)
 . ;;S X=$P(ENY8,U,2),ENCAP=$S(X=1:"YES",X=0:"NO",1:X)
 . S ENCAP=$P(ENY8,U,2) ;INVESTMENT CATEGORY (#34)
 . ;
 . ;ENSGL = Standard General Ledger (#38)
 . S X=$P(ENY8,U,6),ENSGL=$S(X:$P($G(^ENG(6914.3,X,0)),U),1:X)
 . K ENY2,ENY8
 . ; perform checks
 . K EN S ENC=0
 . I ENCAP'=1,ENVAL'<ENCT,ENTYI="NX"!(ENTYI="") D
 . . S ENC=ENC+1,EN(ENC)="Check capitalization"
 . ;
 . ;Investment Category (1) is Capitalized/Accountable
 . I ENCAP=1 D
 . . I ENTYI="" S ENC=ENC+1,EN(ENC)="Type Entry is blank"
 . . I ENTYI="NX" D
 . . . I ENVAL<ENCT S ENC=ENC+1,EN(ENC)="Check capitalization"
 . . . I $$LOC^ENFAVAL(ENCMR)="" S ENC=ENC+1,EN(ENC)="Check CMR"
 . . . I ENSGL="" S ENC=ENC+1,EN(ENC)="SGL is blank"
 . . . I ENSGL=6100 S ENC=ENC+1,EN(ENC)="SGL is 6100 (Expensed)"
 . I ENC D
 . . ; print questionable equipment item
 . . S ENT=ENT+1
 . . S ENCAP=$S(ENCAP=1:"YES",1:"NO")
 . . I $Y+3+ENC>IOSL D HD Q:END
 . . W !!,ENDA,?12,ENTYI,?19,ENCMR,?26
 . . W $J("$"_$FN(ENVAL,",",2),14),?47,ENCAP,?55,EN(1)
 . . F ENI=2:1:ENC W !,?55,EN(ENI)
 I 'END D
 . W !!,ENT," questionable equipment items found"
 . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT I $D(ZTQUEUED) S ZTREQ="@"
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K END,ENDT,ENL,ENPG
 K EN,ENC,ENCAP,ENCT,ENCMR,ENDA,ENI,ENSGL,ENT,ENTYI,ENVAL
 Q
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"CHECK OF EQUIPMENT CAPITALIZATION",?48,ENDT,?72,"page ",ENPG
 W !!,?12,"TYPE"
 W !,"EQUIP ID#",?12,"ENTRY",?19,"CMR",?26,"  ASSET VALUE"
 W ?42,"CAPITALIZED"
 W !,$E(ENL,1,10),?12,$E(ENL,1,5),?19,$E(ENL,1,5),?26,$E(ENL,1,14)
 W ?42,$E(ENL,1,11),?55,$E(ENL,1,23)
 Q
 ;ENFAR3
