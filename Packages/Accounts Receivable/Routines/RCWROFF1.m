RCWROFF1 ;WISC/RFJ-partial waiver ;1 Feb 2000
 ;;4.5;Accounts Receivable;**168,204,233**;Mar 20, 1995;Build 4
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PARTIAL ;  enter a partial waived (menu option)
 N DR,RCBILLDA,RCCURPRI,RCFYCNT,RCTOTAL,RCTRANDA,RCWAIVED,Y
 F  D  Q:RCBILLDA<1
 .   K RCTRANDA  ;do not leave around in for loop
 .   ;  select a bill
 .   S RCBILLDA=$$GETABILL^RCBEUBIL I RCBILLDA<1 Q
 .   ;  lock the bill
 .   L +^PRCA(430,RCBILLDA):5 I '$T W !,"ANOTHER USER IS CURRENTLY WORKING WITH THIS BILL." Q
 .   D SHOWBILL(RCBILLDA)
 .   I '$G(^PRCA(430,RCBILLDA,7)) W !,"THIS BILL HAS NO PRINCIPAL BALANCE." D UNLOCK^RCWROFF Q
 .   W !
 .   ;  add a new partial waiver transaction to file 433
 .   S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,11) I 'RCTRANDA W !,$P(RCTRANDA,"^",2) D UNLOCK^RCWROFF Q
 .   W !,"  Transaction number ",RCTRANDA," added ..."
 .   ;  transfer fy multiple from bill
 .   D FY433^RCBEUTRA(RCTRANDA)
 .   ;
 .   ;  build dr string for call to die
 .   S DR="11WAIVED IN PART DATE;"
 .   ;  determine if there is more than one fiscal year for build DR string
 .   S RCFYCNT=$P($G(^PRCA(433,RCTRANDA,4,0)),"^",4)
 .   ;  single fiscal year in multiple
 .   I RCFYCNT'>1 D
 .   .   ;  get the current principal balance
 .   .   S RCCURPRI=+$P($G(^PRCA(433,RCTRANDA,4,+$O(^PRCA(433,RCTRANDA,4,0)),0)),"^",2)
 .   .   S DR=DR_"15WAIVED AMOUNT;"
 .   .   S DR=DR_"S RCWAIVED=+X;"
 .   .   S DR=DR_"I RCWAIVED'>0 W !,""Amount must be greater than ZERO.  Press ^ to exit."" S Y=15;"
 .   .   S DR=DR_"I RCWAIVED>RCCURPRI W !,""Waived amount CAN NOT EXCEED Principal amount ($ "",$J(RCCURPRI,0,2),"")."" S Y=15;"
 .   .   S DR=DR_"I RCWAIVED=RCCURPRI W !,""If you are creating a waiver for the FULL AMOUNT, use the option Full Waiver."" S Y=15;"
 .   .   S DR=DR_"81///^S X=RCWAIVED;"
 .   ;  multiple fiscal years in multiple
 .   I RCFYCNT>1 D
 .   .   S DR=DR_"S RCTOTAL=0;"
 .   .   S DR=DR_".02;"
 .   .   S DR(2,433.01)="4WAIVED AMOUNT;"
 .   .   S DR(2,433.01)=DR(2,433.01)_"S RCWAIVED=+X,RCCURPRI=+$P(^PRCA(433,DA(1),4,DA,0),U,2);"
 .   .   S DR(2,433.01)=DR(2,433.01)_"I RCWAIVED>RCCURPRI W !,""Waived amount CAN NOT EXCEED Principal Amount ($ "",$J(RCCURPRI,0,2),"") for this Fiscal Year."" S Y=4;"
 .   .   S DR(2,433.01,1)="I RCWAIVED=RCCURPRI W !,""If you are creating a waiver for the FULL AMOUNT, use the option Full Waiver."" S Y=4;"
 .   .   S DR(2,433.01,1)=DR(2,433.01,1)_"1///^S X=$P(^PRCA(433,DA(1),4,DA,0),U,2)-RCWAIVED;"
 .   .   S DR(2,433.01,1)=DR(2,433.01,1)_"S RCTOTAL=$G(RCTOTAL)+RCWAIVED;"
 .   .   S DR=DR_"I RCTOTAL'>0 W !,""Amount must be greater than ZERO.  Press ^ to exit."" S Y=.02;"
 .   .   S DR=DR_"15///^S X=RCTOTAL;"
 .   .   S DR=DR_"81///^S X=RCTOTAL;"
 .   ;
 .   ;  allow user to edit key fields
 .   S Y=$$EDIT433^RCBEUTRA(RCTRANDA,.DR)
 .   I 'Y W !,$P(Y,"^",2) D DEL433^RCBEUTRA(RCTRANDA,"",0),UNLOCK^RCWROFF Q
 .   ;
 .   ;  if only one fiscal year, update the multiple since it was not done
 .   ;  by the user in the die call
 .   I RCFYCNT=1 D
 .   .   N DA40,DATA40,RCTOTAL
 .   .   S RCTOTAL=$P($G(^PRCA(433,RCTRANDA,8)),"^")  ;amount waived
 .   .   S DA40=+$O(^PRCA(433,RCTRANDA,4,0)) I 'DA40 Q
 .   .   S DATA40=$G(^PRCA(433,RCTRANDA,4,DA40,0)) I DATA40="" Q
 .   .   S $P(DATA40,"^",2)=$P(DATA40,"^",2)-RCTOTAL  ;principal remaining
 .   .   S $P(DATA40,"^",5)=RCTOTAL                   ;amount waived
 .   .   S ^PRCA(433,RCTRANDA,4,DA40,0)=DATA40
 .   ;
 .   D SHOWTRAN(RCTRANDA)
 .   I $$ASKOK^RCWROFF("Partial Waiver")'=1 D DEL433^RCBEUTRA(RCTRANDA,"",0),UNLOCK^RCWROFF Q
 .   ;
 .   ;  move the fy multiple from 433 to 430
 .   D FYMULT^RCBEUBIL(RCTRANDA)
 .   ;  mark transaction as processed
 .   D PROCESS^RCBEUTRA(RCTRANDA)
 .   ;  update the principal balance on the bill (subtract the waived amount)
 .   D SETBAL^RCBEUBIL(RCTRANDA)
 .   ;  create fms write off document, if not accrued
 .   I '$$ACCK^PRCAACC(RCBILLDA) D FMSDOC^RCWROFF(RCTRANDA)
 .   ;
 .   W !,"  * * * * * Partial Waiver has been PROCESSED! * * * * *"
 .I '$G(REFMS)&(DT>$$LDATE^RCRJR(DT)) S Y=$E($$FPS^RCAMFN01(DT,1),1,5)_"01" D DD^%DT W !!,"   * * * * Transmission will be held until "_Y_" * * * *"
 .   D UNLOCK^RCWROFF
 Q
 ;
 ;
SHOWTRAN(RCTRANDA) ;  show data for transaction
 N %,DATA0,DATA1,DATA40,RCWRLINE,Y
 S DATA0=$G(^PRCA(433,RCTRANDA,0))
 S DATA1=$G(^PRCA(433,RCTRANDA,1))
 S RCWRLINE="",$P(RCWRLINE,"=",79)=""
 W !!,RCWRLINE
 W !,"BILL NUMBER: ",$P($G(^PRCA(430,+$P(DATA0,"^",2),0)),"^")
 W ?40,"WAIVED AMOUNT: ",$J($P(DATA1,"^",5),0,2)
 S Y=$P($P(DATA1,"^"),".") I Y D DD^%DT
 W !?42,"WAIVED DATE: ",Y
 W !!,"FISCAL YEAR",?30,"WAIVED AMOUNT",?50,"NEW PRINCIPAL BALANCE DUE"
 S %=0 F  S %=$O(^PRCA(433,RCTRANDA,4,%)) Q:'%  D
 .   S DATA40=$G(^PRCA(433,RCTRANDA,4,%,0))
 .   W !,$P(DATA40,"^"),?30,$J($P(DATA40,"^",5),13,2),?50,$J($P(DATA40,"^",2),25,2)
 W !!,RCWRLINE
 Q
 ;
 ;
SHOWBILL(RCBILLDA) ;  show data for bill
 N DATA7,DATA20,FYDA
 S DATA7=$G(^PRCA(430,RCBILLDA,7))
 W !?8,"Principal Balance: ",$J($P(DATA7,"^"),11,2)
 ;
 ;  show fy data
 S FYDA=$O(^PRCA(430,RCBILLDA,2,0)),DATA20=$G(^PRCA(430,RCBILLDA,2,FYDA,0))
 W ?40,"FY: ",$P(DATA20,"^"),?48,"Principal Balance: ",$J($P(DATA20,"^",2),0,2)
 ;  if multiple fiscal years, show them here
 F  S FYDA=$O(^PRCA(430,RCBILLDA,2,FYDA)) Q:'FYDA  D
 .   S DATA20=$G(^PRCA(430,RCBILLDA,2,FYDA,0))
 .   W !?40,"FY: ",$P(DATA20,"^"),?48,"Principal Balance: ",$J($P(DATA20,"^",2),0,2)
 ;
 W !?8," Interest Balance: ",$J($P(DATA7,"^",2),11,2)
 W !?8,"    Admin Balance: ",$J($P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5),11,2)
 W !?27,"-----------"
 W !?8,"    TOTAL Balance: ",$J($P(DATA7,"^")+$P(DATA7,"^",2)+$P(DATA7,"^",3)+$P(DATA7,"^",4)+$P(DATA7,"^",5),11,2)
 Q
