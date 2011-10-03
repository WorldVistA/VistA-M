PRCOPHA ;WISC/DJM-IFCAP PHA RETRANSMIT ROUTINE ;1/14/98  17:47
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;SELECT PO FROM FILE 442 TO RETRANSMIT
 N AA,XX,YY,DIE,DR,DA,%,VAR2,PRCHPO
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  S PRCHP("S")="$P(^(0),U,2)<10!($P(^(0),U,2)=25&("";P;S;""'[("";""_$P($G(^(23)),U,11)_"";"")))" D EN3^PRCHPAT I '$D(PRCHPO) W !!,"No P.O. selected...quitting" Q
 S AA=$G(^PRC(442,PRCHPO,12)) I $P(AA,U,10)="" W !!,"This P.O. has never been sent to Austin in a PHA transaction.  It can't be",!,"sent using this option." Q
 I $P(AA,U,16)="n" W !!,"The Purchasing Agent has specified that this order not go out EDI.",!,"This P.O. can't be sent using this option." Q
 S XX=$G(^PRC(442,PRCHPO,1))  I +XX'>0 W !!,"For some reason there is no vendor listed in this P.O.  This P.O. can't be",!,"processed in this option." Q
 S YY=$G(^PRC(440,+XX,3)) I $P(YY,U,2)'="Y" W !!,"This P.O. is not going to a vendor that can accept a P.O. electronically.",!,"This P.O. can't be sent in this option." Q
QUERY W !!,"Do you want to re-transmit PO " S AA=$G(^PRC(442,PRCHPO,0)) W $P(AA,U) S %=2 D YN^DICN Q:%<0  Q:%=2  I %=1 S DIE="^PRC(442,",DA=PRCHPO,DR="18.5///@" D ^DIE S VAR2="" D NEW^PRCOPHA1(PRCHPO,.VAR2) W !!,VAR2,! G START
 I %=0 W !!,"If you have an EDI TRANSACTION REPORT for a rejected PHA transaction",!,"and have corrected the P.O. answer YES to send a new PHA transaction." G QUERY
