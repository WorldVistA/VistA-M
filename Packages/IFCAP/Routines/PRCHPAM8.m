PRCHPAM8 ;ID/TKW,RSD/RHD-PRINT AMENDMENT ;6/9/99  10:48
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N SITE
 S D0=$S($D(PRCHPO):PRCHPO,1:D0),D1=$S($D(PRCHAM):PRCHAM,1:D1)
 S U="^" Q:'$D(^PRC(443.6,D0,6,D1))  S PRCH0=$G(^(D1,0)),PRCH1=$G(^(1)),PRCHAV=$S($P(PRCH0,U,8)="Y":1,1:0),PRCHP0=^PRC(443.6,D0,0),PRCHP1=$G(^(1)),PRC("SITE")=$P(+PRCHP0,"-",1),PRCHUL="",$P(PRCHUL,"_",98)=""
 S SITE=$P($G(^PRC(443.6,D0,23)),U,7),SITE=$S($G(SITE)]"":SITE,1:PRC("SITE"))
 S PRCHPG=1,PRCHPGT=2
 K ^UTILITY($J,"W"),^TMP($J,"AMD") S DIWL=1,DIWR=91,DIWF="",P=0 I PRCHAV'>0,$P($G(^PRC(443.6,D0,6,D1,2,0)),U,4)'>0 D START^PRCHPAM2(D0,D1) G CONT
 F PRCHJJ=0:0 S P=$O(^PRC(443.6,D0,6,D1,2,P)) Q:P=""!(P'>0)  S X=^(P,0) D DIWP^PRCUTL($G(DA))
 K PRCHJJ S %X="^UTILITY($J,""W"",DIWL,",%Y="^TMP($J,""AMD"",DIWL," D %XY^%RCR S PRCHPG=1,PRCHPGT=2
 S X=+^UTILITY($J,"W",DIWL) I X>37 S X=X-52 F I=0:0 Q:X'>41  S X=X-56,PRCHPGT=PRCHPGT+1
 S:+^UTILITY($J,"W",DIWL)>37 PRCHPGT=PRCHPGT+1
CONT G:PRCHAV EN2^PRCHPAM9
 D HDR^PRCHPAM9 W "2.AMENDMENT/MODIFICATION NO. ",?29,"|3.EFFECTIVE DATE",?46,"|4.REQUISITION/PURCHASE REQ.NO.",?77,"|5.PROJECT NO."
 W !?7,$P(PRCH0,U,1),?29,"|    " S Y=$P(PRCH0,U,2) D DT S Y=0 I $P(PRCHP0,U,12),$D(^PRCS(410,+$P(PRCHP0,U,12),0)) S Y=$P(^(0),U,1)
 W ?46,"|  ",$S(Y:Y_"/",1:"        "),$P($P(PRCHP0,U,1),"-",2),?77,"|  (If applicable)",!,?29,"|",?46,"|",?77,"|"
 W !,$E(PRCHUL,1,29),"|",$E(PRCHUL,1,16),"|",$E(PRCHUL,1,30),"|",$E(PRCHUL,1,19)
 W !,"6.ISSUED BY ",?26,"CODE|________| 7.ADMINISTERED BY (If other than item 6)   CODE|________" S Y=$G(^PRC(411,SITE,3))
 W !?3,"A&MM SERVICE",?39,"|",!?3,"VA MEDICAL CENTER",?39,"|",! F I=1:1:2 W:$P(Y,U,I)]"" ?3,$P(Y,U,I),?39,"|",!?3
 W $P(Y,U,3),", ",$P($G(^DIC(5,+$P(Y,U,4),0)),U,2),"  ",$P(Y,U,5),?39,"|" F I=1:1:2-I W !?39,"|"
 S X=$G(^PRC(440,+PRCHP1,0)) W !,$E(PRCHUL,1,39),"|",$E(PRCHUL,1,57),!,"8.NAME & ADDRESS OF CONTRACTOR (No.,street,county,",?52,"|   | 9A.AMENDMENT OF SOLICITATION NO.",!
 W ?31,"State and ZIP Code)",?52,"|   |",!,?13,$P(X,U,1),?52,"|   |",$E(PRCHUL,1,40),! S J=1 D AL
 W ?52,"|   | 9B.DATED (See Item 11)",! D:J'>5 AL W ?52,"|   |",! D:J'>5 AL W ?52,"|___|",$E(PRCHUL,1,40),!
 D:J'>5 AL W ?52,"|   | 10A.MODIFICATION OF CONTRACT/ORDER NO.",! D:J'>5 AL W ?52,"| X |",?61,$P(PRCHP0,U,1),!
 S PRCVFAX=$P($G(^PRC(440,+PRCHP1,10)),U,6) W:PRCVFAX'="" ?13,"FAX: ",PRCVFAX K PRCVFAX
 W ?52,"|   |",$E(PRCHUL,1,40),!,$E(PRCHUL,1,52),?52,"|   | 10B.DATED (See Item 13)",!,"CODE",?30,"|FACILITY CODE",?52,"|   |",?61 S Y=$P(PRCHP1,U,15) D DT
 W !,$E(PRCHUL,1,30),"|",$E(PRCHUL,1,21),"|___|",$E(PRCHUL,1,38),!,?16,"11.THIS ITEM ONLY APPLIES TO AMENDMENTS OF SOLICITATIONS",!,PRCHUL,!
 W !,"____ The above numbered solicitation is amended as set forth in Item 14. The hour and date speci-",!,"fied for receipt of Offers  ____is extended  ____is not extended.",!
 W "Offers must acknowledge receipt of this amendment prior to the hour and date specified in the",!,"solicitation or as amended by one of the following methods:",!!
 W "(a) By completing Items 8 and 15 and returning ______ copies of the amendment:",!,"(b) By acknowledging receipt of this amendment on each copy of the offer submitted: or",!
 W "(c) By separate letter or telegram which includes a reference to the solicitation and amendment",!,"numbers.  FAILURE OF YOUR ACKNOWLEDGEMENT TO BE RECEIVED AT THE PLACE DESIGNATED FOR THE RECEIPT",!
 W "OF OFFERS PRIOR TO THE HOUR AND DATE SPECIFIED MAY RESULT IN REJECTION OF YOUR OFFER. If by vir-",!,"tue of this amendment you desire to change an offer already submitted, such change may be made",!
 W "by telegram or letter, provided each telegram or letter makes reference to the solicitation and",!,"this amendment, and is received prior to the opening hour and date specified.",!
 G ^PRCHPAM9
 ;
DT Q:'Y  W Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
 ;
AL F I=J:1 S J=J+1 Q:J>6  I $P(X,U,J)]"" G:J=6 AL1 W ?13,$P(X,U,J) Q
 Q
 ;
AL1 W ?13,$P(X,U,6),", ",$P($G(^DIC(5,+$P(X,U,7),0)),U,2),"  ",$P(X,U,8)
 Q
