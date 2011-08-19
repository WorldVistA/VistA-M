ENWOME1 ;(WASH ISC)/SAB-WORK ORDER MULTIPLE ENTRY, EQUIPMENT LIST; 2-6-95
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
LST ;
 ; Input Variables
 ;   ENWODA = ien of master work order
 ;   ENEQDA = ien of equipment on master work order
 ;   ^TMP($J,equip ien) selected equipment array
 ;       = "" when wo not yet created by copying master
 ;       = work order ien^work order number
 ;   ENCOPY optional flag
 ;       = 1 to indicate work order copy has been completed
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="QEN^ENWOME1",ZTDESC="Multiple Work Order Equipment List"
 . S ZTSAVE("ENCOPY")="",ZTSAVE("ENEQDA")="",ZTSAVE("ENWODA")=""
 . S ZTSAVE("^TMP($J,")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
QEN ; queued entry
 U IO
 S (END,ENPG)=0 S Y=$P(DT,".") D DD^%DT S ENDT=Y
 S DIC="^ENG(6920,",DA=ENWODA,DR=".01;32",DIQ="ENDIQ",DIQ(0)="E"
 D EN^DIQ1
 S ENDASH="",$P(ENDASH,"-",IOM+1)="" D HD
 S ENI=0 F  S ENI=$O(^TMP($J,ENI)) Q:'ENI  D  D:$Y+4>IOSL HD Q:END
 . W:$D(ENCOPY) !,$P($G(^TMP($J,ENI)),U,2),?24,ENDIQ(6920,ENWODA,32,"E")
 . S DIC="^ENG(6914,",DA=ENI,DR=".01;6;1;4",DIQ="ENDIQ",DIQ(0)="E"
 . D EN^DIQ1
 . W !,?2,ENDIQ(6914,ENI,.01,"E")
 . W ?14,$E(ENDIQ(6914,ENI,6,"E"),1,25)
 . W ?41,$E(ENDIQ(6914,ENI,1,"E"),1,20)
 . W ?63,$E(ENDIQ(6914,ENI,4,"E"),1,16)
 . K ENDIQ(6914)
 I $D(ZTQUEUED) S ZTREQ="Q" K ^TMP($J)
 K DA,DIC,DIQ,DR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K END,ENDASH,ENDIQ,ENDT,ENI,ENPG
 D ^%ZISC
 Q
HD ; header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "Multiple Work Order Equipment List",?50,ENDT,?70,"page ",ENPG,!
 W:$G(ENCOPY) !,"Work Order #",?24,"Status"
 W !,?2,"Control #",?14,"Equipment Category",?41,"Manufacturer"
 W ?63,"Model"
 W !,?2,$E(ENDASH,1,10),?14,$E(ENDASH,1,25),?41,$E(ENDASH,1,20)
 W ?63,$E(ENDASH,1,16)
 W !,"(Master Equipment Work Order)"
 W !,ENDIQ(6920,ENWODA,.01,"E"),?24,ENDIQ(6920,ENWODA,32,"E")
 S DIC="^ENG(6914,",DA=ENEQDA,DR=".01;6;1;4",DIQ="ENDIQ",DIQ(0)="E"
 D EN^DIQ1
 W !,?2,ENDIQ(6914,ENEQDA,.01,"E")
 W ?14,$E(ENDIQ(6914,ENEQDA,6,"E"),1,25)
 W ?41,$E(ENDIQ(6914,ENEQDA,1,"E"),1,20)
 W ?63,$E(ENDIQ(6914,ENEQDA,4,"E"),1,16)
 K ENDIQ(6914)
 ;W !,$E(ENDASH,1,10),?12,$E(ENDASH,1,25),?39,$E(ENDASH,1,20)
 ;W ?61,$E(ENDASH,1,18)
 W !!,"(Equipment "
 W $S($G(ENCOPY):"Work Orders Copied from Master",1:"Selected"),")"
 Q
 ;ENWOME1
