PRCNTIED ;SSI/SEB-Edit a turn-in request ;[ 05/31/96  10:42 AM ]
 ;;1.0;Equipment/Turn-In Request;**11**;Sep 13, 1996
EN S DIC="^PRCN(413.1,",DIC("S")="I $P(^(0),U,2)=DUZ&($P(^(0),U,7)=1)!($P(^(0),U,7)=4)"
 S DIC(0)="AEQZ" D ^DIC G EXIT:Y<0 S ST=$P(^PRCN(413.1,+Y,0),U,7)
 S (IN,PRCNTDA)=+Y,PRCNUSR=$S(ST=4:2,1:0) D SETUP^PRCNTIPR
EDIT ; Edit the transaction if desired
 W !!,"Do you want to edit this request" S %=2 D YN^DICN
 I %=0 G EDIT
 I %'=1 G EXIT
 S DIE=413.1,DR="[PRCNTIRQ]",(DA,IN)=PRCNTDA,EDIT=1 D ^DIE
 I $P($G(^PRCN(413.1,IN,0)),U,10)]"" S $P(^(0),U,10)="" K ^PRCN(413.1,IN,2)
EXIT K DIC,DIE,DA,DR,EDIT,IN,PRCNUSR,PRCNTDA,Y,%,ST
 Q
