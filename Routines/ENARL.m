ENARL ;(WIRMFO)/JED/SAB-ARCHIVE ACTIVITY LOG ;2.19.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 ;CALLED BY ENAR
 Q
L ; entry point
 ; ask log entry
 S DIC="^ENG(6919,",DIC(0)="AEQM"
 D ^DIC G:Y<0 EXIT S ENDA=+Y
L1 ; entry point with ENDA already defined
 ; if equipment archive then ask if equipment should also be listed 
 S ENEQL=0 I $P($G(^ENG(6919,ENDA,1)),U)=3 D  G:$D(DIRUT) EXIT
 . S DIR(0)="Y",DIR("A")="Should archived equipment Entry #s be listed"
 . S DIR("B")="NO"
 . D ^DIR K DIR S ENEQL=Y
 ; ask device
 D DEV^ENLIB G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="PRNT^ENARL",ZTDESC="Engineering Archive Activity Log"
 . S ZTSAVE("ENDA")="",ZTSAVE("ENEQL")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
PRNT ; queued entry point
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDTR=Y
 K ENDL S $P(ENDL,"-",80)=""
 S ENDAN=$P($G(^ENG(6919,ENDA,0)),U)
 D HD
 ; print archive log
 S ENY=$G(^ENG(6919,ENDA,1))
 W !,"RECORDS TYPE: ",$$EXTERNAL^DILFD(6919,1,"",$P(ENY,U))
 W ?40,"FILE VERSION: ",$P(ENY,U,8)
 W !,"START DATE: ",$$FMTE^XLFDT($P(ENY,U,2))
 W ?40,"STOP DATE: ",$$FMTE^XLFDT($P(ENY,U,3))
 W !,"OPT PARAMETERS: ",$P(ENY,U,4)
 W !,"RECORDS SAVED: ",$P(ENY,U,5)
 W ?25,"PHYSICAL LOCATION: ",$P(ENY,U,6)
 W !,"TAPE DESCRIPTION: ",$P(ENY,U,7)
 ; print activity list
 D HDA
 I '$O(^ENG(6919,ENDA,2,0)) W !!,"There is no activity recorded"
 E  S ENI=0 F  S ENI=$O(^ENG(6919,ENDA,2,ENI)) Q:'ENI  D  Q:END
 . I $Y+4>IOSL D HD Q:END  D HDA
 . S ENX=$G(^ENG(6919,ENDA,2,ENI,0))
 . S ENX(1)=$$FMTE^XLFDT($P(ENX,U))
 . S ENX(2)=$$EXTERNAL^DILFD(6919.01,1,"",$P(ENX,U,2))
 . W !,?5,$P(ENX(1),"@"),"  ",$P(ENX(1),"@",2),?28,ENX(2),?50,$P(ENX,U,3)
 ; print equipment list
 I 'END,ENEQL D
 . I $Y+8>IOSL D HD Q:END
 . D HDE S ENX=""
 . I '$O(^ENG(6919,ENDA,3,0)) W !!,"There is no archived equipment"
 . E  S ENI=0 F  S ENI=$O(^ENG(6919,ENDA,3,ENI)) Q:'ENI  D  Q:END
 . . I $Y+4>IOSL D HD Q:END  D HDE
 . . S ENEQ=$P($G(^ENG(6919,ENDA,3,ENI,0)),U)
 . . I $L(ENX)+$L(ENEQ)+11>IOM W !,?5,ENX_"," S ENX=ENEQ
 . . E  S ENX=ENX_$S(ENX]"":", ",1:"")_ENEQ
 . I 'END,ENX]"" W !,?5,ENX
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
EXIT ;
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K END,ENDA,ENDAN,ENDL,ENDTR,ENEQ,ENEQL,ENI,ENPG,ENX,ENY
 Q
 ;
HD ; page header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"Archive Log Report ",?49,ENDTR,?72,"page ",ENPG
 W !,"ARCHIVE ID: ",ENDAN
 Q
HDA ; activity list header
 W !!,ENDL
 W !?5,"ACTIVITY DATE",?28,"ACTIVITY TYPE",?50,"REQUESTOR"
 W !,ENDL
 Q
HDE ; equipment list header
 W !!,ENDL
 W !,?5,"ARCHIVED EQUIPMENT LIST"
 W !,ENDL
 Q
 ;ENARL
