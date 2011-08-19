PRCHDSP ;TKW/BOISE,ID/RSD,WISC/AKS-DISPLAY AMENDMENT ;2/12/98  2:45 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N %X,%Y,DIWF,DIWL,DIWR,I,J,P,PRCH0,PRCH1,PRCHAV,PRCHP0,PRCHP1,PRCHPG,PRCHPGT,PRCHUL,X,Y,PRCHREPR,PRCHTPG,PRCHTYP,PRCHX,Z,PRCHDY
 S D0=$S($D(PRCHPO):PRCHPO,1:D0),D1=$S($D(PRCHAM):PRCHAM,1:D1)
 S U="^" Q:'$D(^PRC(442,D0,6,D1))  S PRCH0=^(D1,0),PRCH1=^(1),PRCHAV=$S($P(PRCH0,U,8)="Y":1,1:0),PRCHP0=^PRC(442,D0,0),PRCHP1=^(1),PRC("SITE")=$P(+PRCHP0,"-",1),PRCHUL="",$P(PRCHUL,"_",80)=""
 S PRCHPG=1,PRCHPGT=2
 K ^UTILITY($J,"W"),^TMP($J,"AMD") S DIWL=1,DIWR=91,DIWF="",P=0 I PRCHAV'>0,$P($G(PRC(442,D0,6,D1,2,0)),U,4)'>0 D START^PRCHDSP4(D0,D1) G CONT
 F PRCHJJ=0:0 S P=$O(^PRC(442,D0,6,D1,2,P)) Q:'P!(P'>0)  S X=^(P,0) D DIWP^PRCUTL($G(DA))
 K PRCHJJ S %X="^UTILITY($J,""W"",DIWL,",%Y="^TMP($J,""AMD"",DIWL," D %XY^%RCR
 S X=+^UTILITY($J,"W",DIWL) I X>37 S X=X-52 F I=0:0 Q:X'>41  S X=X-56,PRCHPGT=PRCHPGT+1
 S:+^UTILITY($J,"W",DIWL)>37 PRCHPGT=PRCHPGT+1
CONT G:PRCHAV EN2^PRCHDSP1
 D HDR^PRCHDSP1 W "2.AMENDMENT/MODIFICATION NO. ",?29,"|3.EFFECTIVE DATE",?46,"|4.REQUISITION/PURCHASE REQ.NO."
 W !?7,$P(PRCH0,U,1),?29,"|    " S Y=$P(PRCH0,U,2) D DT S Y=0 I $P(PRCHP0,U,12),$D(^PRCS(410,+$P(PRCHP0,U,12),0)) S Y=$P(^(0),U,1)
 W ?46,"|  ",$S(Y:Y_"/",1:"        "),$P($P(PRCHP0,U,1),"-",2) ;,!,?29,"|",?46,"|"
 W !,$E(PRCHUL,1,29),"|",$E(PRCHUL,1,16),"|",$E(PRCHUL,1,30)
 S SITE=$P($G(^PRC(442,D0,23)),U,7) S SITE=$S($G(SITE)]"":SITE,1:+$P(^PRC(442,D0,0),U))
 W !,"6.ISSUED BY ",?31,"| 7.ADMINISTERED BY (If other than item 6)" S Y=$G(^PRC(411,SITE,3))
 W !?3,"A&MM SERVICE",?31,"|",!?3,"VA MEDICAL CENTER",?31,"|",! F I=1:1:2 W:$P(Y,U,I)]"" ?3,$P(Y,U,I),?31,"|",!?3
 ;W $P(Y,U,3),", ",$S($D(^DIC(5,+$P(Y,U,4),0)):$P(^(0),U,2),1:""),"  ",$P(Y,U,5),?31,"|" F I=1:1:2-I W !?31,"|"
 W $P(Y,U,3),", ",$P($G(^DIC(5,+$P(Y,U,4),0)),U,2),"  ",$P(Y,U,5),?31,"|" F I=1:1:2-I W !?31,"|"
 S X=$G(^PRC(440,+PRCHP1,0)) W !,$E(PRCHUL,1,31),"|",$E(PRCHUL,1,47),!,"8.NAME & ADDRESS OF CONTRACTOR ",?34,"|   | 9A.AMENDMENT OF SOLICITATION NO.",!
 W ?2,"(No.,street,county,St. and ZIP)",?34,"|   |",!,?2,$P(X,U),?34,"|   |",$E(PRCHUL,1,40),! S J=1 D AL
 W ?34,"|   | 9B.DATED (See Item 11)",! D:J'>5 AL W ?34,"|   |",! D:J'>5 AL W ?34,"|___|",$E(PRCHUL,1,40),!
 D:J'>5 AL W ?34,"|   | 10A.MODIF. OF CONT./ORD. NO.",! D:J'>5 AL W ?34,"| X |",?43,$P(PRCHP0,U),!
 W ?34,"|   |",$E(PRCHUL,1,40),!,$E(PRCHUL,1,34),?34,"|   | 10B.DATED (See Item 13)",!,"CODE",?20,"|FACILITY CODE",?34,"|   |",?45 S Y=$P(PRCHP1,U,15) D DT
 W !,$E(PRCHUL,1,20),"|",$E(PRCHUL,1,13),"|___|",$E(PRCHUL,1,40),! ;,?16,"11.THIS ITEM ONLY APPLIES TO AMENDMENTS OF SOLICITATIONS",!,PRCHUL,!
 ;W PRCHUL,!
 ;W !,"____ The above numbered solicitation is amended as set forth in Item 14. The hour",!,"and date specified for receipt of Offers  ____is extended  ____is not extended.",!
 ;W "Offers must acknowledge receipt of this amendment prior to the hour and date",!,"specified in the solicitation or as amended by one of the following methods:",!!
 ;W "(a) By completing Items 8 and 15 and returning ______ copies of the amendment:",!,"(b) By acknowledging receipt of this amendment on each copy of the offer",!,"submitted: or"
 ;W "(c) By separate letter or telegram which includes a reference to the solicitation",!,"and amendment numbers.  FAILURE OF YOUR ACKNOWLEDGEMENT TO BE RECEIVED AT THE PLACE DESIGNATED",!,"FOR THE RECEIPT"
 ;W "OF OFFERS PRIOR TO THE HOUR AND DATE SPECIFIED MAY RESULT IN REJECTION",!,"OF YOUR OFFER. If by virtue of this amendment you desire to change an",!,"offer already submitted, such change may be made"
 ;W "by telegram or letter,",!,"provided each telegram or letter makes reference to the solicitation and",!,"this amendment, and is received prior to the opening hour and date specified.",!
 G ^PRCHDSP1
DT Q:'Y  W Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
AL F I=J:1 S J=J+1 Q:J>6  I $P(X,U,J)]"" G:J=6 AL1 W ?2,$P(X,U,J) Q
 Q
AL1 ;W ?8,$P(X,U,6),", ",$S($D(^DIC(5,+$P(X,U,7),0)):$P(^(0),U,2),1:""),"  ",$P(X,U,8) Q
 W ?2,$P(X,U,6),", ",$P($G(^DIC(5,+$P(X,U,7),0)),U,2),"  ",$P(X,U,8)
 Q
