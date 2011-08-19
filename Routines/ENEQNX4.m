ENEQNX4 ;WCIOFO/DH,SAB-CMR Inventory Exception Listing ;10/12/1999
 ;;7.0;ENGINEERING;**35,50,63**;AUG 17, 1993
EN ;Print CMR items not found during inventory
 K ENCMR
 ; ask date of inventory
 I '$D(DT) S X="T" D ^%DT S DT=+Y
 S %DT("A")="Report equipment not inventoried since: "
 S Y=$E(DT,1,5)_"01" X ^DD("DD") S %DT("B")=Y,%DT="AEPX"
 D ^%DT K %DT G:Y'>0 EXIT S ENFR=Y
 ; ask if all CMR's
 S DIR(0)="Y",DIR("A")="For all CMR's",DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 I Y S ENCMR(0)="ALL"
 ; if not all CMR's then ask CMR
 I '$D(ENCMR(0)) S DIC="^ENG(6914.1,",DIC(0)="AQEM" D ^DIC G:Y'>0 EXIT
 S ENCMR=+Y
 ; ask if optionally accountable equipment included
 S DIR(0)="Y",DIR("A")="Check All NX equipment",DIR("B")="YES"
 S DIR("?",1)="Enter NO if you only want to check for physical inventory"
 S DIR("?",2)="of accountable NX equipment.  Accountable NX equipment"
 S DIR("?",3)="is equipment with an INVESTMENT CATEGORY of either"
 S DIR("?",4)="CAPITALIZED/ACCOUNTABLE or NOT CAPITALIZED/ACCOUNTABLE. "
 S DIR("?",5)=" "
 S DIR("?")="Enter YES to check all equipment for the specified CMR."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENALL=Y
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="CONT^ENEQNX4",ZTIO=ION,ZTDESC="NX Inventory Exception List"
 . S ZTSAVE("EN*")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
CONT ;Entry point for queued task
 U IO
 K ENDL S $P(ENDL,"-",IOM)=""
 S ENFR("E")=$$FMTE^XLFDT(ENFR)
 I '$D(DT) S X="T" D ^%DT S DT=+Y
 S Y=DT X ^DD("DD") S ENDATE=Y,(END,ENPG)=0
 I $D(ENCMR(0)) S ENCMR=0 F  S ENCMR=$O(^ENG(6914,"AD",ENCMR)) Q:'ENCMR  D CMR Q:END
 I '$D(ENCMR(0)) D CMR
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
EXIT ;
 K ENCAT,ENCMR,ENCMRY0,END,ENDA,ENDATE,ENDL,ENALL,ENFR,ENI,ENINVDT
 K ENPG,ENSVC,ENT,ENUSE,ENY
 K DIC,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,%,%ZIS
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CMR ; print exception listing for one CMR 
 S ENCMRY0=$G(^ENG(6914.1,ENCMR,0))
 S ENSVC=$$GET1^DIQ(6914.1,ENCMR,.5)
 D HD Q:END
 S ENT("EXCP")=0,ENT("CMR")=0
 ; loop thru equipment on CMR
 S ENDA=0 F  S ENDA=$O(^ENG(6914,"AD",ENCMR,ENDA)) Q:'ENDA  D  Q:END
 . F ENI=2,3,8 S ENY(ENI)=$G(^ENG(6914,ENDA,ENI))
 . I $P(ENY(3),U)>3,$P(ENY(3),U)<6 Q  ; use status turned-in or lost
 . ; if user did not want all equipment then check accountablility
 . I 'ENALL,"^1^A^"'[(U_$P(ENY(8),U,2)_U) Q
 . S ENT("CMR")=ENT("CMR")+1 ; should have been inventoried
 . I $P(ENY(2),U,13)'<ENFR Q  ; inventoried since specified date
 . ; completed checks - print item on exception listing
 . I $Y+7>IOSL D HD Q:END
 . S ENT("EXCP")=ENT("EXCP")+1
 . F ENI=0,1 S ENY(ENI)=$G(^ENG(6914,ENDA,ENI))
 . S ENUSE=$$GET1^DIQ(6914,ENDA,20)
 . S ENINVDT=$P($$GET1^DIQ(6914,ENDA,23),"@")
 . W !!,ENDA,?15,$P(ENY(3),U,6)
 . S X=$P(ENY(3),U,5) I X=+X,$D(^ENG("SP",X,0)) S X=$P(^(0),U)
 . W ?28,X,?43,$P(ENY(3),U,8),?63,ENINVDT I IOM>120 S ENCAT=$P(ENY(1),U,1) W:ENCAT]"" ?81,$S($D(^ENG(6911,ENCAT,0)):^(0),1:"")
 . W !,?3,$E($P(ENY(0),U,2),1,55),?63,ENUSE
 ; CMR footer
 I 'END D
 . W:ENT("EXCP")=0 !!,"NO EXCEPTIONS TO REPORT (out of ",ENT("CMR")," item",$S(ENT("CMR")'=1:"s",1:"")," that met selection criteria)."
 . W:ENT("EXCP")>0 !!,ENT("EXCP")," Item",$S(ENT("EXCP")'=1:"s",1:"")," Not Inventoried (out of ",ENT("CMR")," item",$S(ENT("CMR")'=1:"s",1:"")," that met selection criteria)."
 Q
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,END=1 Q
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W "EXCEPTION LIST (NX INVENTORY)",?(IOM-25),ENDATE,?(IOM-8),"Page ",ENPG
 W !,"  ",$S(ENALL:"All",1:"Accountable")
 W " NX Equipment Not Inventoried Since ",ENFR("E")," for"
 W !,"  CMR: ",$P(ENCMRY0,U),"   ",ENSVC,"   ",$P(ENCMRY0,U,8)
 W !!,"Equipment ID#",?15,"PM Number",?28,"Location",?43,"Previous Location",?63,"Last Inventoried" I IOM>120 W ?81,"Equipment Category"
 W !,?3,"Manufacturer Equipment Name",?63,"Use Status"
 W !,ENDL
 Q
 ;ENEQNX4
