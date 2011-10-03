ENWOME ;(WASH ISC)/SAB-WORK ORDER MULTIPLE ENTRY ;1-27-97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
 N NUMBER,SHOPKEY,WARD
 K ^TMP($J)
 S DIR("A")="Enter a new equipment work order and copy it (Y/N)"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR G:'Y!$D(DIRUT) EXIT
 ; get first w.o.
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT
 S SHOPKEY=ENSHKEY
 S NUMBER="" D WONUM^ENWONEW I NUMBER="" D  G EXIT
 . W !!,*7,"Can't seem to add to Work Order File."
 . W !,"Please try again later or contact IRM Service."
 S ENWODA=DA L +^ENG(6920,ENWODA)
 W !,"WORK ORDER #: ",NUMBER
 S WARD=0 D WOFILL^ENWONEW
EDITWO ; edit work order
 S DR=$S($D(^DIE("B","ENZWONEW")):"[ENZWONEW]",1:"[ENWONEW]")
 D ^DIE I $D(DTOUT) D DELWO G EXIT
 S ENEQDA=$P($G(^ENG(6920,ENWODA,3)),U,8)
 I ENEQDA']"" D  G:Y EDITWO D DELWO G EXIT
 . W !,"An Equipment ID # is required by this option."
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to edit the work order (Y/N)",DIR("B")="YES"
 . D ^DIR K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you want to CLOSE this work order now (Y/N)"
 D ^DIR K DIR D:Y  I $D(DIRUT) D DELWO G EXIT
 . S DR=$S($D(^DIE("B","ENZWONEWCLOSE")):"[ENZWONEWCLOSE]",1:"[ENWONEWCLOSE]")
 . D ^DIE
 S DIR(0)="Y"
 S DIR("A")="Do you want to print this work order (Y/N)",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) D DELWO G EXIT
 I Y S DA=ENWODA D P^ENWOD
SEL ; select equipment
 K ^TMP($J)
 S DIR(0)="S^1:SEARCH EQUIPMENT FILE BY CATEGORY, MANUFACTURER, OR MODEL;2:INDIVIDUALLY SELECT EQUIPMENT"
 S DIR("A")="USE METHOD: ",DIR("B")="1"
 S DIR("A",1)="Choose desired method to select additional equipment."
 S DIR("?")="Enter 1 or 2 (enter '^' to abort and W.O. will be deleted)"
 S DIR("?",1)="Additional equipment can be selected by one of the following methods."
 S DIR("?",2)=" "
 S DIR("?",3)="1 SEARCH EQUIPMENT FILE BY CATEGORY, MANUFACTURER, OR MODEL -"
 S DIR("?",4)="  Enter desired value(s) in one or more of the three available search"
 S DIR("?",5)="  criteria. Equipment Category, Manufacturer, and/or Model can be specified."
 S DIR("?",6)="  Equipment which exactly matches all specified criteria will be selected."
 S DIR("?",7)="  If a value is not entered then the corresponding search criteria will not"
 S DIR("?",8)="  be used. Equipment with a disposition date will not be included."
 S DIR("?",9)=" "
 S DIR("?",10)="2 INDIVIDUALLY SELECT EQUIPMENT - Individually choose each equipment item."
 S DIR("?",11)=" "
 D ^DIR K DIR S ENMETH=Y I $D(DIRUT) D DELWO G EXIT
 S ENC("EQ")=0
 I ENMETH=1 D  I $D(DTOUT)!$D(DUOUT) D DELWO G EXIT
 . S (ENEQCAT,ENMANF,ENMODEL)="" K DA
 . S DIR(0)="6914,6",DIR("A")="Select items with EQUIPMENT CATEGORY"
 . D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S:Y>0 ENEQCAT=+Y
 . S DIR(0)="6914,1",DIR("A")="Select items with MANUFACTURER"
 . D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S:Y>0 ENMANF=+Y
 . S DIR(0)="6914,4",DIR("A")="Select items with MODEL"
 . D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S ENMODEL=Y
 . I ENEQCAT']"",ENMANF']"",ENMODEL']"" W !,"No criteria entered" Q
 . S ENXREF=$S(ENMODEL]"":"E",ENMANF]"":"K",1:"G")
 . S ENXREFV=$S(ENXREF="E":ENMODEL,ENXREF="K":ENMANF,1:ENEQCAT)
 . S ENI=0 F  S ENI=$O(^ENG(6914,ENXREF,ENXREFV,ENI)) Q:'ENI  D
 . . S ENY1=$G(^ENG(6914,ENI,1))
 . . I ENEQCAT]"",$P(ENY1,U,1)'=ENEQCAT Q
 . . I ENMANF]"",$P(ENY1,U,4)'=ENMANF Q
 . . I ENMODEL]"",$P(ENY1,U,2)'=ENMODEL Q
 . . I $P($G(^ENG(6914,ENI,3)),U,11)]"" Q  ; disposition date exists
 . . I ENI'=ENEQDA S ^TMP($J,ENI)="",ENC("EQ")=ENC("EQ")+1
 I ENMETH=2 D  K DIC
 . S DIC="^ENG(6914,",DIC(0)="AQEM"
 . F  D ^DIC Q:Y'>0  I Y'=ENEQDA,'$D(^TMP($J,+Y)) S ^(+Y)="",ENC("EQ")=ENC("EQ")+1
 I 'ENC("EQ") W !,"No equipment items were selected" G SEL
CONF ; confirm
 W !!,"Work Orders will be copied for ",ENC("EQ")," items of equipment"
 S DIR("A")="OK to Proceed"
 S DIR("?")="Enter Y, N, or L (enter '^' to exit and delete work order)"
 S DIR("?",1)="Select appropriate action"
 S DIR("?",2)="YES  to create work orders for selected equipment"
 S DIR("?",3)="NO   to select different equipment"
 S DIR("?",4)="LIST to list currently selected equipment"
 S DIR("?",5)="^    to exit and delete original work order"
 S DIR(0)="SMB^Y:YES;N:NO;L:LIST" D ^DIR K DIR I $D(DIRUT) D DELWO G EXIT
 I Y="N" G SEL
 I Y="L" D LST^ENWOME1 G CONF
ASKPRT ; print new work orders?
 S DIR(0)="Y"
 S DIR("?")="Enter Yes or No"
 S DIR("?",1)="Enter Yes to print all new work orders to a selected"
 S DIR("?",2)="device. The appropriate format (LONG or SHORT) will be"
 S DIR("?",3)="obtained from the AUTO PRINT NEW W.O. software option."
 S DIR("?",4)=" "
 S DIR("A")="Should all new work orders be printed? (Y/N)",DIR("B")="NO"
 D ^DIR K DIR S ENPRT=Y I $D(DIRUT) D DELWO G EXIT
 D:ENPRT  I $D(DTOUT)!$D(DUOUT) D DELWO G EXIT
 . ; get output device (with default for shop)
 . S DIC=6922,DR="2",DA=ENSHKEY,DIQ="ENDIQ",DIQ(0)="E"
 . D EN^DIQ1 K DIQ
 . S DIC=3.5,DIC(0)="AQEMZ",DIC("B")=ENDIQ(6922,ENSHKEY,2,"E")
 . K ENDIQ
 . D ^DIC K DIC S:Y>0 ENPRT("DEV")=$P(Y(0),U)
COPYWO ;
 W !,"Copying work order for selected equipment"
 S ENFATAL=0
 S ENI=0 F  S ENI=$O(^TMP($J,ENI)) Q:'ENI  D  Q:ENFATAL
 . ; get new w.o. number
 . S NUMBER="" D WONUM^ENWONEW
 . I NUMBER="" D  I NUMBER="" S ENFATAL=1 Q
 . . W !,"Couldn't obtain a new Work Order #. Retrying..."
 . . D WONUM^ENWONEW
 . . I NUMBER="" W !,"Still couldn't get a new Work Order #"
 . S ENWODAY=DA
 . ; copy data
 . L +^ENG(6920,ENWODAY)
 . S %X="^ENG(6920,ENWODA,",%Y="^ENG(6920,ENWODAY," D %XY^%RCR
 . ; set specific data for .01, .05, LOCATION, EQUIPMENT ID #
 . S ENY0=$G(^ENG(6920,ENWODAY,0))
 . S $P(ENY0,U,1)=NUMBER
 . S $P(ENY0,U,6)=NUMBER
 . S $P(ENY0,U,4)=$P($G(^ENG(6914,ENI,3)),U,5) ; location from equip
 . S ^ENG(6920,ENWODAY,0)=ENY0
 . S $P(^ENG(6920,ENWODAY,3),U,8)=ENI ; will trigger remaining fields
 . ; index new entry
 . S DA=ENWODAY,DIK="^ENG(6920," D IX^DIK K DIK
 . ; save w.o. number in ^tmp
 . S ^TMP($J,ENI)=ENWODAY_U_NUMBER
 . L -^ENG(6920,ENWODAY)
 . W "."
 I ENFATAL D DELWO G EXIT
 I ENPRT D QUETSK^ENWOME2
 W !,"All work orders created"
 W !,"Select output device for list or enter '^' to suppress report"
 S ENCOPY=1 D LST^ENWOME1
EXIT ;
 I $D(ENWODA) L -^ENG(6920,ENWODA)
 K ^TMP($J)
 K %X,%Y,DA,DIK,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 K ENBARCD,ENC,ENCOPY,ENDA,ENEQCAT,ENEQDA,ENFATAL,ENI
 K ENMANF,ENMODEL,ENMETH,ENPRT,ENSHKEY,ENWOCLOD
 K ENWODA,ENWODAY,ENXREF,ENXREFV,ENY0,ENY1
 Q
DELWO ; delete work orders (master and any copied)
 W !,"Process Terminated - Deleting any created work orders"
 K DA S DA=ENWODA
 S ENWOCLOD=$P($G(^ENG(6920,ENWODA,5)),U,2)
 I ENWOCLOD]"" D KILLHS^ENEQHS
 S DA=ENWODA,DIK="^ENG(6920," D ^DIK K DIK W "."
 S ENI=0 F  S ENI=$O(^TMP($J,ENI)) Q:'ENI  S ENDA=$P($G(^(ENI)),U) D:ENDA
 . I ENWOCLOD]"" S DA=ENDA D KILLHS^ENEQHS
 . S DA=ENDA,DIK="^ENG(6920," D ^DIK K DIK
 . W "."
 Q
 ;ENWOME
