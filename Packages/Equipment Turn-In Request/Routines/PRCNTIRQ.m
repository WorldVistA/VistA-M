PRCNTIRQ ;SSI/ALA-Enter a Turn-In Request ;[ 02/06/97  11:57 AM ]
 ;;1.0;Equipment/Turn-In Request;**2**;Sep 13, 1996
EN D NOW^%DTC S PRCNDTM=% K %I,%H
 D FYQ^PRCNUTL S PRCF("X")="S" D ^PRCFSITE G EXIT:'$D(PRC("SITE"))
 S DIC(0)="AEQZ",DIC="^ENG(6914.1," D ^DIC G EXIT:Y<1
 S PRCN("CMR")=$P(Y(0),U),PRCNCMR=+Y,PRCNSRV=$P(Y(0),U,5)
 I PRCNSRV="" D  G EXIT:Y<1
 . S DIC="^DIC(49," D ^DIC S PRCNSRV=+Y
 K DIC,Y
ENR ;  Get the next sequential number
 I $G(PRC("SITE"))="" S PRC("SITE")=$P($P(^PRCN(413,DA,0),U),"-")
 I $G(PRCN("CMR"))="" S PRCN("CMR")=$P($P(^PRCN(413,DA,0),U),"-",2)
 I $G(PRC("FY"))="" S PRC("FY")=$P($P(^PRCN(413,DA,0),U),"-",3)
 S TST=PRC("SITE")_"-"_PRCN("CMR")_"-"_PRC("FY") D SEQ^PRCNUTL
 S PRCNRTN=TST_"-"_$E("00000",$L(PRCNDA)+1,5)_PRCNDA
 ;  File into temporary transaction file
 N DA,DIC,DIE,Y
 S DIC="^PRCN(413.1,",DIC(0)="L",DLAYGO=413.1,X=PRCNRTN D FILE^DICN
 S PRCNTDA=DA I $G(PRCNTY)'="" D
 . S ^PRCN(413.1,PRCNTDA,0)=PRCNRTN_U_$P(^PRCN(413,PRCNRDA,0),U,2,8)
 . S $P(^PRCN(413.1,PRCNTDA,0),U,9)=PRCNRDA,$P(^PRCN(413,PRCNRDA,0),U,11)=PRCNTDA
 . S $P(^PRCN(413.1,PRCNTDA,0),U,16)=$P(^PRCN(413,PRCNRDA,0),U,16)
 G EXIT:$D(PRCNTY)
TIN ; Select a Turn-In request, display info & get justification
 W !!,"This request has been assigned transaction #: ",PRCNRTN,!
 S PRCNFA=0,DIE=413.1,DA=PRCNTDA,DR="[PRCNTIRQ]"
 S EDIT=$S($P(^PRCN(413.1,PRCNTDA,0),U,7)="":0,1:1) D ^DIE
EXIT K PRC,PRCF,PRCN,PRCNDA,DIC,DIE
 K %DT,EDIT,TST,X,RI,%,DA,DLAYGO,PRCNFA,PRCNFAP
 I $G(PRCNTY)="" K PRCNRTN
 Q
DISP ; Display line item info
 NEW DIC,DA,DR,DI
 S DA=RI,DIC=6914,DR=".01;3;2;4;5;12;18;19;24",DIQ(0)="E",DIQ="PRCNDAT"
 D EN^DIQ1
 W !,"CSN: ",$G(PRCNDAT(6914,RI,18,"E"))
 W !,"Description: ",$G(PRCNDAT(6914,RI,3,"E"))
 W !,"Model #: ",$G(PRCNDAT(6914,RI,4,"E"))
 W ?40,"Serial #: ",$G(PRCNDAT(6914,RI,5,"E"))
 W !,"Manufacturer: ",$G(PRCNDAT(6914,RI,1,"E"))
 W ?40,"Last Location: ",$G(PRCNDAT(6914,RI,24,"E"))
 W !,"Aquisition Value: ","$ "_$G(PRCNDAT(6914,RI,12,"E"))
 W ?40,"CMR: ",$G(PRCNDAT(6914,RI,19,"E"))
 K PRCNDAT
 Q
INP ;  Input transform check for validity of selection
 I DR["PRCNTIPPM",'$D(^PRCN(413.1,D0,1,"B",X)) W !,$C(7),"  Cannot add item to turn in at this point" K X Q
 I $G(PRCNFA)="" S PRCNFA=0
 I $G(PRCNCMR)="" S PRCNCMR=$P(^PRCN(413.1,DA,0),U,16)
 I $D(^PRCN(413.1,"AB",X)) W !,$C(7)," Request already on file for this item" K X Q
 ;S ACQ=$P($G(^ENG(6914,X,3)),U,4) I ACQ'="P"&(ACQ'="M")&(ACQ'="O")&(ACQ'="") K X W !,$C(7),"Item not owned by facility" Q
 I $P($G(^ENG(6914,X,2)),U,9)'=PRCNCMR W !,$C(7)," Item not in this CMR" K X Q
 S PRCNFAP=$$CHKFA^ENFAUTL(X)
 I 'PRCNFA,PRCNFAP S PRCNFA=1 Q
 I PRCNFA,'PRCNFAP W !,$C(7),"Previous item capitalized, this item isn't" K X Q
 Q
