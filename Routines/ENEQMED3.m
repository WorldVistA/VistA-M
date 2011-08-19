ENEQMED3 ;(WASH ISC)/SAB-EQUIPMENT MULTIPLE EDIT, REPORT; 9.24.97
 ;;7.0;ENGINEERING;**35,39,45**;Aug 17, 1993
EN ;
 ; Input Variables
 ;   ^TMP($J,"ENFLD",field number) modified fields array
 ;   ^TMP($J,"ENSEL",equip ien) selected equipment array
 ;   ^TMP($J,"ENCOM", word processing array for comments
 ;   ^TMP($J,"ENSPEX", word processing array for spex
 ;   ^TMP($J,"ENLCK",equip ien) equipment that couldn't be locked/updated
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="QEN^ENEQMED3",ZTDESC="Multiple Edit of Equipment Report"
 . S ZTSAVE("^TMP($J,""ENFLD"",")="",ZTSAVE("^TMP($J,""ENSEL"",")=""
 . S ZTSAVE("^TMP($J,""ENCOM"",")="",ZTSAVE("^TMP($J,""ENSPEX"",")=""
 . S ZTSAVE("^TMP($J,""ENLCK"",")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 S (END,ENPG)=0 S Y=$P(DT,".") D DD^%DT S ENDT=Y
 S ENHDR2="Edited Field(s)                    New Value"
 S ENDASH="",$P(ENDASH,"-",IOM+1)="" D HD
 S ENFLD=0
 F  S ENFLD=$O(^TMP($J,"ENFLD",ENFLD)) Q:'ENFLD  D:$Y+3>IOSL HD Q:END  D
 . I ENFLD=30 W !,"PM DATA" Q
 . I ENFLD=40 W !,"COMMENTS" D  Q
 . . S DIWL=36,DIWR=75,DIWF="W|"
 . . S ENI=0
 . . F  S ENI=$O(^TMP($J,"ENCOM",ENI)) Q:'ENI  S X=^(ENI,0) D ^DIWP
 . . D ^DIWW
 . . K DIWL,DIWR,DIWF,X
 . I ENFLD=70 W !,"SPEX" D  Q
 . . S DIWL=36,DIWR=75,DIWF="W|"
 . . S ENI=0
 . . F  S ENI=$O(^TMP($J,"ENSPEX",ENI)) Q:'ENI  S X=^(ENI,0) D ^DIWP
 . . D ^DIWW
 . . K DIWL,DIWR,DIWF,X
 . S ENVALE=$P($G(^TMP($J,"ENFLD",ENFLD)),U,2)
 . W !,$$GET1^DID(6914,ENFLD,"","LABEL"),?35
 . W $S(ENVALE]"":$E(ENVALE,1,40),1:"(individually specified for each item)")
 G:END EXIT
 I $D(^TMP($J,"ENLCK")) D
 . S ENHDR2="List of Selected Equipment that was NOT Modified."
 . I $Y+8>IOSL D HD
 . E  W !!,ENHDR2
 . W !,"  Some of the selected equipment could not be updated because it"
 . W !,"  was being edited by another process. This equipment will need"
 . W !,"  to be edited to make the desired changes."
 . S ENDA=0,ENI=0
 . F  S ENDA=$O(^TMP($J,"ENLCK",ENDA)) Q:'ENDA  D  Q:END
 . . I '(ENI#6) D:$Y+3>IOSL HD Q:END  W !
 . . W ?(ENI#6*12),ENDA
 . . S ENI=ENI+1
 S ENHDR2="List of Modified Equipment"
 I $Y+5>IOSL D HD
 E  W !!,ENHDR2
 S ENDA=0,ENI=0
 F  S ENDA=$O(^TMP($J,"ENSEL",ENDA)) Q:'ENDA  D  Q:END
 . Q:$D(^TMP($J,"ENLCK",ENDA))  ; could not be locked/updated
 . I '(ENI#6) D:$Y+3>IOSL HD Q:END  W !
 . W ?(ENI#6*12),ENDA
 . S ENI=ENI+1
EXIT I $D(ZTQUEUED) S ZTREQ="Q" K ^TMP($J)
 K DA,DIC,DIQ,DR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K END,ENDA,ENDASH,ENDIQ,ENDT,ENFLD,ENHDR2,ENI,ENPG,ENVALE
 D ^%ZISC
 Q
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 S $X=0
 W "Multiple Edit of Equipment Report",?50,ENDT,?70,"page ",ENPG
 W !,ENDASH,!
 W !,ENHDR2,!
 Q
 ;ENEQMED3
