ENFARA1 ;WIRMFO/SAB-FIXED ASSET RPT, ADJUSTMENT VOUCHER (CONT) ;5.16.97
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
QEN ; queued entry
 ; in
 ;   ENDTS - start date
 ;   ENDTE - end date
 ;   ENSRT("U") - true if sort by user
 ;   if ENSRT("U") true
 ;     ENSRT("U",0) - DUZ of selected user or * for all
 ;     ENSRT("U",0,"E") - external value for ENSRT("U",0)
 U IO
GETDATA ; collect/sort data
 S ENUSR="*"
 ; loop thru FAP document file transactions within selected date range
 K ^TMP($J) F ENFILE="6915.2","6915.3","6915.4","6915.5","6915.6" D
 . S ENDT=ENDTS
 . ;***F  S ENDT=$O(^ENG(ENFILE,"AV",ENDT)) Q:ENDT=""!(ENDT>ENDTE)  D
 . F  S ENDT=$O(^ENG(ENFILE,"AV",ENDT)) Q:ENDT=""!($P(ENDT,".")>ENDTE)  D
 . . S ENDA("F?")=0
 . . F  S ENDA("F?")=$O(^ENG(ENFILE,"AV",ENDT,ENDA("F?"))) Q:'ENDA("F?")  D
 . . . I ENSRT("U") S ENUSR=$$GET1^DIQ(ENFILE,ENDA("F?"),302,"I")
 . . . I ENSRT("U"),ENSRT("U",0)'="*",ENUSR'=ENSRT("U",0) Q
 . . . S ^TMP($J,ENUSR,ENDT,ENFILE_";"_ENDA("F?"))=""
PRINT ; print
 ; load table for converting FA Type to SGL
 K ENFAPTY S ENDA=0 F   S ENDA=$O(^ENG(6914.3,ENDA)) Q:'ENDA  D
 . S ENY0=$G(^ENG(6914.3,ENDA,0))
 . I $P(ENY0,U,3)]"" S ENFAPTY($P(ENY0,U,3))=$P(ENY0,U)
 ;
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDTR=Y
 S ENL="",$P(ENL,"-",IOM)=""
 I '$D(^TMP($J)) D HD W !!,"No activity in selected period",!
 S ENUSR="" F  S ENUSR=$O(^TMP($J,ENUSR)) Q:ENUSR=""  D  Q:END
 . S ENUSR("E")=$S('ENSRT("U"):"",1:$$GET1^DIQ(200,ENUSR,.01))
 . K ENT
 . D HD Q:END
 . S ENDT="" F  S ENDT=$O(^TMP($J,ENUSR,ENDT)) Q:ENDT=""  D  Q:END
 . . S ENY="" F  S ENY=$O(^TMP($J,ENUSR,ENDT,ENY)) Q:ENY=""  D  Q:END
 . . . S ENFILE=$P(ENY,";"),ENDA("F?")=$P(ENY,";",2)
 . . . S ENY0=$G(^ENG(ENFILE,ENDA("F?"),0))
 . . . S ENY1=$G(^ENG(ENFILE,ENDA("F?"),1))
 . . . S ENDA=$P($G(^ENG(ENFILE,ENDA("F?"),0)),U)
 . . . S ENDA("FA")=$$AFA^ENFAR5A(ENFILE,ENDA("F?")) ; associated FA
 . . . S ENFAY3=$G(^ENG(6915.2,ENDA("FA"),3))
 . . . S ENSN=$TR($E($P(ENFAY3,U,5),1,5)," ","")
 . . . S:ENFILE=6915.2 ENFUND=$P(ENFAY3,U,10)
 . . . S:ENFILE'=6915.2 ENFUND=$$FUND^ENFAR5A(ENFILE,ENDA("F?"),ENDA("FA"))
 . . . S ENSGL=$S($P(ENFAY3,U,6)]"":$G(ENFAPTY($P(ENFAY3,U,6))),1:"")
 . . . S ENAMT=0
 . . . I ENFILE=6915.2 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,27)
 . . . I ENFILE=6915.3 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,4)
 . . . I ENFILE=6915.4 S ENX=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,6),ENAMT=$S(ENX="":0,1:ENX-$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,4))
 . . . I ENFILE=6915.5 S ENAMT="-"_$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,2)
 . . . I ENFILE=6915.6 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,8)
 . . . I $Y+8>IOSL D HD Q:END
 . . . W !,$E($TR($$FMTE^XLFDT(ENDT,"2F")," ",0),1,14)
 . . . W ?16,$P(ENY1,U,6),?22,$P(ENY1,U,9)
 . . . W ?34,$TR($$FMTE^XLFDT($P(ENY0,U,2),"2DF")," ",0)
 . . . W ?44,ENSN,?51,ENFUND,?58,ENSGL
 . . . I ENFILE=6915.6 D  ; check FR doc for FUND change
 . . . . S ENFUNDNW=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,9)
 . . . . I ENFUND=ENFUNDNW S ENAMT=0 Q  ; fund didn't change
 . . . . S ENAMT=-ENAMT ; subtract from old fund
 . . . W ?63,$J($FN(ENAMT,",",2),16)
 . . . S ENT(ENSN,ENFUND,ENSGL)=$G(ENT(ENSN,ENFUND,ENSGL))+ENAMT
 . . . I ENFILE=6915.6,ENFUND'=ENFUNDNW D
 . . . . ; show addition to new fund
 . . . . W !,?44,ENSN,?51,ENFUNDNW,?58,ENSGL
 . . . . W ?63,$J($FN(-ENAMT,",",2),16)
 . . . . S ENT(ENSN,ENFUNDNW,ENSGL)=$G(ENT(ENSN,ENFUNDNW,ENSGL))-ENAMT
 . . . ;
 . . . W !,?4,"EQUIP #: ",ENDA,?26,$$GET1^DIQ(6914,ENDA,3)
 . . . W !,?4,"P.O. #: ",$P($G(^ENG(6914,ENDA,2)),U,2)
 . . . W ?26,"A.V. REASON: ",$$GET1^DIQ(ENFILE,ENDA("F?"),303)
 . . . K ^UTILITY($J,"W") S DIWL=5,DIWR=(IOM-5),DIWF="W|"
 . . . S X="COMMENTS: ",ENI=0
 . . . F  S ENI=$O(^ENG(ENFILE,ENDA("F?"),301,ENI)) Q:'ENI  S X=X_^(ENI,0) D ^DIWP S X="" I $Y+6>IOSL D HD Q:END  D HDAV
 . . . Q:END
 . . . D ^DIWW
 . Q:END
 . I $Y+10>IOSL D HD Q:END
 . W !,?30,"TOTALS:"
 . S ENTU=0 ; initialize user/grand total
 . S ENSN="" F  S ENSN=$O(ENT(ENSN)) Q:ENSN=""  D  Q:END
 . . S ENTS="0" ; initialize station totals
 . . S ENFUND="" F  S ENFUND=$O(ENT(ENSN,ENFUND)) Q:ENFUND=""  D  Q:END
 . . . S ENTF="0" ; initialize fund totals
 . . . S ENSGL=""
 . . . F  S ENSGL=$O(ENT(ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D  Q:END
 . . . . I $Y+6>IOSL D HD Q:END  W !,?30,"TOTALS: (continued)"
 . . . . W !,?44,ENSN,?51,ENFUND,?58,ENSGL
 . . . . W ?63,$J($FN($P(ENT(ENSN,ENFUND,ENSGL),U),",",2),16)
 . . . . S $P(ENTF,U)=$P(ENTF,U)+$P(ENT(ENSN,ENFUND,ENSGL),U)
 . . . Q:END
 . . . S $P(ENTS,U)=$P(ENTS,U)+$P(ENTF,U)
 . . . I $Y+6>IOSL D HD Q:END  W !,?30,"TOTALS: (continued)"
 . . . W !,?63,"----------------"
 . . . W !,?44,ENSN,?51,ENFUND,?58,"TOTAL",?63,$J($FN($P(ENTF,U),",",2),16),!
 . . Q:END
 . . S $P(ENTU,U)=$P(ENTU,U)+$P(ENTS,U)
 . . I $Y+6>IOSL D HD Q:END  W !,?30,"TOTALS: (continued)"
 . . W !,?63,"----------------"
 . . W !,?44,ENSN,?50,"TOTAL",?63,$J($FN($P(ENTS,U),",",2),16),!
 . Q:END
 . I $Y+6>IOSL D HD Q:END  W !,?30,"TOTALS: (continued)"
 . W !,?63,"================"
 . W !,?44,$S(ENSRT("U"):"USER",1:"GRAND")," TOTAL"
 . W ?63,$J($FN($P(ENTU,U),",",2),16),!
 . D FT
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
WRAPUP ; wrap up
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K DIWF,DIWL,DIWR,X,Y
 K ^TMP($J),ENAMT,END,ENDA,ENDT,ENDTE,ENDTR,ENDTS,ENFAPTY,ENFAY3
 K ENFILE,ENFUND,ENFUNDNW,ENI,ENIEN,ENL,ENPG,ENSGL,ENSN,ENSRT,ENUSR
 K ENT,ENTS,ENTF,ENTU,ENX,ENY,ENY0,ENY1
 Q
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 S $X=0
 W "ADJUSTMENT VOUCHERS",?49,ENDTR,?72,"page ",ENPG
 W !,?2,"FROM ",$$FMTE^XLFDT(ENDTS,"2")," TO ",$$FMTE^XLFDT(ENDTE,"2")
 I ENSRT("U") D
 . W "  (SORT BY USER FOR ",ENSRT("U",0,"E"),")"
 . I ENSRT("U",0)="*",$G(ENUSR("E"))]"" W !,"A.V.s By: ",ENUSR("E")
 W !!,"ADJ. VOUCHER",?16,"...... TRANSACTION .......",?44,"STN"
 W ?51,"FUND",?58,"SGL",?63,"NET AMOUNT"
 W !,"DATE/TIME",?16,"CODE  NUMBER      DATE"
 W !,"--------------",?16,"----- ----------- --------",?44,"-----"
 W ?51,"------",?58,"----",?63,"----------------"
 Q
HDAV ; header for continued adjustment voucher
 W !,?4,"Transaction: ",$P(ENY1,U,6),"-",$P(ENY1,U,9),"(continued)"
 Q
FT ; report footer when hardcopy
 Q:$E(IOST,1,2)="C-"!'ENPG
 W !!!,?4,"--------------------  --------"
 W ?44,"--------------------  --------"
 W !,?4,"ACCOUNTABLE OFFICER   DATE"
 W ?44,"APPROVING OFFICIAL    DATE"
 Q
 ;ENFARA1
