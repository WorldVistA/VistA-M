PRCNTICN ;SSI/SEB-Cancel equipment turn-in request ;[ 02/25/97  5:10 PM ]
 ;;1.0;PRCN;**2,3**;Sep 13, 1996
 W @IOF S DIC("A")="Enter TRANSACTION #: ",DIC="^PRCN(413.1,",DIC(0)="AEQ"
 S PRCNPPM=0 I $D(^XUSEC("PRCNPPM",DUZ)) S PRCNPPM=1
 I 'PRCNPPM S DIC("S")="I $P(^(0),U,2)=DUZ&($P(^(0),U,7)=4)!($P(^(0),U,7)=1)"
 I PRCNPPM S DIC("S")="I $P(^(0),U,7)'=20&($P(^(0),U,7)'=24)"
 D ^DIC
 K DIC("S") G EXIT:+Y<0 S D0=+Y,PRCNDATA=^PRCN(413.1,D0,0),NUM=$P(Y,U,2)
PR ; Prints the data for this transaction
 S PCMR=$P(PRCNDATA,U,6),PREQ=$P(PRCNDATA,U,2),PSER=$P(PRCNDATA,U,3)
 W !!,"Service: " W:PSER'="" $P($G(^DIC(49,PSER,0)),U),?41,"CMR Official: "
 I PCMR'="" W $P(^VA(200,PCMR,0),U)
 W !,"Requestor: " S Y=$P(PRCNDATA,U,4)\1
 D DD^%DT W:PREQ $P(^VA(200,PREQ,0),U) W ?41,"Date entered: ",Y
 W !,"Line Items:" S D1=0
 F  S D1=$O(^PRCN(413.1,D0,1,D1)) Q:'D1  D
 . S PD1=$P(^PRCN(413.1,D0,1,D1,0),U)
 . W !,?5,"Number: ",D1,?41,"Description: ",$P(^ENG(6914,PD1,0),U,2)
 W !,"CMR Explanation:" S D1=0
 F  S D1=$O(^PRCN(413.1,D0,2,D1)) Q:D1'?1N.N  W !,?4,^PRCN(413.1,D0,2,D1,0)
ASK ; Ask if user is certain he/she wants to cancel request
 W !!,"Are you sure you want to cancel this turn-in" S %=2 D YN^DICN
 I %=2 W !!,"OK, the turn-in was not cancelled." G EQUIP
 I %=0 W !,"Please enter 'Y' to cancel the Turn-in request" G ASK
 S DIE=413.1,DA=D0,DR="6////^S X=20;7////^S X=DT" D ^DIE
 W !!,"Transaction #",DA," has been cancelled."
 S D1=0 F  S D1=$O(^PRCN(413.1,DA,1,D1)) Q:'D1  D
 . S PTR=$P(^PRCN(413.1,DA,1,D1,0),U) K ^PRCN(413.1,"AB",PTR,DA,D1)
EQUIP ; If there is an equip. request associated with this, prompt to cancel
 G EXIT:"^"[$P(^PRCN(413.1,D0,0),U,9)
 S DA=$P(^PRCN(413.1,D0,0),U,9),%=2
QS W !!,"Do you want to cancel the corresponding equipment request"
 D YN^DICN I %=2 W !!,"OK, the equipment request was not cancelled." G EXIT
 I %=0 W !,"Please enter 'Y' to cancel the equipment request." G QS
 S DIE=413,DR="6////^S X=20;7////^S X=DT" D ^DIE
 W !!,"Equipment request #",$P(^PRCN(413,DA,0),U)," cancelled."
EXIT ; Kill variables and quit
 K DIC,DIE,D0,D1,DA,DR,X,Y,ST,TRN,NUM,C,PRCNDATA,%,PRCNPPM
 Q
