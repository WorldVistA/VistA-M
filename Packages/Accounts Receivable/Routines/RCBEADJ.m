RCBEADJ ;WISC/RFJ-adjustment ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**169,172,204,173,208,233,298,301,315,326,338,371**;Mar 20, 1995;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
DECREASE ;  menu option: create a decrease adjustment
 D ADJUST("DECREASE")
 Q
 ;
 ;
INCREASE ;  menu option: create an increase adjustment
 D ADJUST("INCREASE")
 Q
 ;
ADJUST(RCBETYPE,RCEDI) ;  create an adjustment
 ;  rcbetype = INCREASE for increase or DECREASE for decrease
 ;  rcedi = the ien of the bill selected via the EDI Worklist;ien of 
 ;    XX      the ERA entry or null/undefined if bill should be selected
 I '$G(GOTBILL) N RCBILLDA  ;PRCA*4.5*315 If entering from worklist
 F  D  Q:RCBILLDA<0!$G(RCEDI)!$G(GOTBILL)
 .   K RCTRANDA,RCLIST,RCTRREV
 .   ;
 .   ;  select a bill
 .   I '$G(GOTBILL) S RCBILLDA=$S('$G(RCEDI):$$GETABILL^RCBEUBIL,1:+RCEDI)  ;PRCA*4.5*315
 .   I RCBILLDA<1 Q
 .   I $D(^PRCA(430,"TCSP",RCBILLDA)),(RCBETYPE="INCREASE") D  ;PRCA*4.5*315/DRF
 ..    S RCTRREV=$$ASKREV()
 ..    W !
 .   I $D(^PRCA(430,"TCSP",RCBILLDA)),(RCBETYPE="DECREASE") S %=$$ASKCM Q:(%'=1)     ; prca*4.5*301 & *315
 .   ;
 .   ;  adjust the bill
 .   D ADJBILL(RCBETYPE,RCBILLDA,$P($G(RCEDI),";",2))
 Q
 ;
ADJBILL(RCBETYPE,RCBILLDA,RCEDIWL) ;  adjust a bill
 ; RCEDIWL = ien of ERA entry if called from worklist
 N RCAMOUNT,RCBALANC,RCDATA7,RCLIST,RCONTADJ,RCTRANDA,TOTALCAL,TOTALSTO,I,X,Y,RCFDA
 ;  lock the bill
 L +^PRCA(430,RCBILLDA):5 E  W !,"ANOTHER USER IS CURRENTLY WORKING WITH THIS BILL." Q
 ;
 ;  show data for the bill
 D SHOWBILL^RCWROFF1(RCBILLDA)
 ;
 ;  check the balance of the bill
 W !!,"Checking the bill's balance ..."
 S RCBALANC=$$OUTOFBAL^RCBDBBAL(RCBILLDA)
 I RCBALANC="" W " IN Balance!"
 ;
 ;  out of balance, ask to fix it
 I RCBALANC'="" D  I RCBILLDA<1 D UNLOCK Q
 .   S TOTALCAL=$P(RCBALANC,"^")+$P(RCBALANC,"^",2)+$P(RCBALANC,"^",3)+$P(RCBALANC,"^",4)+$P(RCBALANC,"^",5)
 .   S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 .   S TOTALSTO=$P(RCDATA7,"^")+$P(RCDATA7,"^",2)+$P(RCDATA7,"^",3)+$P(RCDATA7,"^",4)+$P(RCDATA7,"^",5)
 .   W " OUT of Balance!"
 .   W !!,"                  BALANCE:",$J("Calculated",12),$J("Stored",12)
 .   W !,"                  ------- ",$J("------------",12),$J("------------",12)
 .   W !,"        Principal Balance:",$J($P(RCBALANC,"^",1),12,2),$J($P(RCDATA7,"^",1),12,2)
 .   I +$P(RCBALANC,"^",1)'=+$P(RCDATA7,"^",1) W "  <<-- OUT OF BALANCE"
 .   W !,"         Interest Balance:",$J($P(RCBALANC,"^",2),12,2),$J($P(RCDATA7,"^",2),12,2)
 .   I +$P(RCBALANC,"^",2)'=+$P(RCDATA7,"^",2) W "  <<-- OUT OF BALANCE"
 .   W !,"            Admin Balance:",$J($P(RCBALANC,"^",3),12,2),$J($P(RCDATA7,"^",3),12,2)
 .   I +$P(RCBALANC,"^",3)'=+$P(RCDATA7,"^",3) W "  <<-- OUT OF BALANCE"
 .   W !,"               MF Balance:",$J($P(RCBALANC,"^",4),12,2),$J($P(RCDATA7,"^",4),12,2)
 .   I +$P(RCBALANC,"^",4)'=+$P(RCDATA7,"^",4) W "  <<-- OUT OF BALANCE"
 .   W !,"               CC Balance:",$J($P(RCBALANC,"^",5),12,2),$J($P(RCDATA7,"^",5),12,2)
 .   I +$P(RCBALANC,"^",5)'=+$P(RCDATA7,"^",5) W "  <<-- OUT OF BALANCE"
 .   W !,"                  ------- ",$J("-------------",12),$J("-------------",12)
 .   W !,"                    TOTAL:",$J(TOTALCAL,12,2),$J(TOTALSTO,12,2)
 .   I +TOTALCAL'=+TOTALSTO W "  <<-- OUT OF BALANCE"
 .   ;
 .   ;  ask to fix the balances
 .   S Y=$$ASKFIX I Y'=1 W !,"  NOTE: You must fix the Balance Discrepancy before processing an adjustment!" S RCBILLDA=0 Q
 .   ;
 .   ;  fix it
 .   ; PRCA*4.5*371 - Replace direct global sets in 7 node with FileMan calls so indexes get updated
 .   S RCFDA(430,RCBILLDA_",",71)=+$P(RCBALANC,"^",1) ; principal
 .   S RCFDA(430,RCBILLDA_",",72)=+$P(RCBALANC,"^",2) ; interest
 .   S RCFDA(430,RCBILLDA_",",73)=+$P(RCBALANC,"^",3) ; admin
 .   S RCFDA(430,RCBILLDA_",",74)=+$P(RCBALANC,"^",4) ; marshal fee
 .   S RCFDA(430,RCBILLDA_",",75)=+$P(RCBALANC,"^",5) ; court cost
 .   D FILE^DIE(,"RCFDA")
 .   ;
 .   W !,"  Balance Discrepancy FIXED!"
 ;
 ;  if the principal balance is zero, do not allow it to be adjusted
 ;  ask to close/cancel it
 I RCBETYPE="DECREASE",'$G(^PRCA(430,RCBILLDA,7)) W !!,"Note: This bill has NO PRINCIPAL BALANCE to decrease !" D INTADMIN(RCBILLDA),UNLOCK Q
 ;
 ; If entry is from EDI Lockbox worklist, display total adjustments in ERA
 N AP D
 .N BILL,EOB,ERA,SEQ S ERA="",AP=0
 .F  S ERA=$O(^RCY(344.4,"AP",1,ERA)) Q:'ERA  D  Q:AP
 ..S SEQ=0
 ..F  S SEQ=$O(^RCY(344.4,"AP",1,ERA,SEQ)) Q:'SEQ  D  Q:AP
 ...S EOB=$P($G(^RCY(344.4,ERA,1,SEQ,0)),U,2) Q:'EOB
 ...S:$P($G(^IBM(361.1,EOB,0)),U)=RCBILLDA AP=1 ;IA #4051
 ;
 ;  Ask to enter transaction even though it is marked for autopost PRCA*4.5*298
 I RCBETYPE="DECREASE",AP S Y=$$ASKAUPO() I Y'=1 W !,"Exiting bill adjustment." D UNLOCK Q
 ;
 ; Display warning for decrease adjustment if pending payments exist
 I RCBETYPE="DECREASE" D WARN^RCBEADJ1(RCBILLDA) ; PRCA*4.5*326
 ;
 ;  ask to enter adjustment amount
 S RCAMOUNT=$$AMOUNT(RCBILLDA,RCBETYPE)
 I RCAMOUNT<0 D UNLOCK Q
 ;
 ;  if decrease, make negative
 I RCBETYPE="DECREASE" S RCAMOUNT=-RCAMOUNT
 ;
 ;  ask if it is a contract adjustment (Community Care added check for all 3rd party categories PRCA*4.5*338)
 I RCBETYPE="DECREASE",$$THRDPRTY(RCBILLDA) S RCONTADJ=$$ASKCONT I RCONTADJ<0 D UNLOCK Q
 ;
 ;  show what the new transaction will look like
 S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 W !!,"If you process the transaction, the bill will look like:"
 W !,"Current Principal Balance: ",$J($P(RCDATA7,"^"),11,2)
 W !,"  NEW ",RCBETYPE," Adjustment: ",$J(RCAMOUNT,11,2)
 W !,"                           -----------"
 W !,"    NEW Principal Balance: ",$J($P(RCDATA7,"^")+RCAMOUNT,11,2)
 ;
 ;  ask to enter transaction
 S Y=$$ASKOK(RCBETYPE) I Y'=1 D UNLOCK Q
 ;
ADDADJ ;  add adjustment
 S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILLDA,RCAMOUNT,"","","",$G(RCONTADJ))
 I 'RCTRANDA W !,"  *** W A R N I N G: Adjustment NOT Processed! ***" D UNLOCK Q
 I RCTRANDA W !,"  Adjustment Transaction: ",RCTRANDA," has been added."
 I RCTRANDA,'$G(RCEDIWL),(RCBETYPE="DECREASE"),$D(^PRCA(430,"TCSP",RCBILLDA)) D DECADJ^RCTCSPU(RCBILLDA,RCTRANDA) ;prca*4.5*301 add cs decrease adjustment
 I RCTRANDA,$G(RCTRREV)=0 S PRCABN=RCBILLDA D CSITRN^RCTCSPD5
 I RCTRANDA,$G(RCTRREV)=0,'$G(RCEDIWL),(RCBETYPE="INCREASE"),$D(^PRCA(430,"TCSP",RCBILLDA)) S PRCABN=RCBILLDA D INCADJ^RCTCSPU(RCBILLDA,RCTRANDA) ;PRCA*4.5*315/DRF add cs increase adjustment
 I $G(RCTRREV)=1 S PRCABN=RCBILLDA D CSITRY^RCTCSPD5
 I '$G(REFMS)&(DT>$$LDATE^RCRJR(DT)) S Y=$E($$FPS^RCAMFN01(DT,1),1,5)_"01" D DD^%DT W !!,"   * * * * Transmission will be held until "_Y_" * * * *"
 ;
 ;  ask to enter a comment
 W !!,"Enter a comment for the ",RCBETYPE," Adjustment:"
 S Y=$$EDIT433^RCBEUTRA(RCTRANDA,"41;")
 ;
 ;  ask to exempt interest and admin charges
 I RCBETYPE="DECREASE" D INTADMIN(RCBILLDA)
 ;
 ;  notification of subsequent payer bulletin
 S RCDATA7=$G(^PRCA(430,RCBILLDA,7)),X=0
 F I=1:1:5 S X=X+$P(RCDATA7,"^",I)
 I RCDATA7'="",'X D
 .   N PRCABN,PRCAEN,PRCAMT
 .   S PRCABN=RCBILLDA,PRCAEN=RCTRANDA,PRCAMT=+$P($G(^PRCA(433,RCTRANDA,1)),"^",5)
 .   D EOB^PRCADJ
 ;
 ;  unlock and ask the next bill to adjust
 D UNLOCK
 Q
 ;
 ;
UNLOCK ;  unlock bill and transaction
 L -^PRCA(430,RCBILLDA)
 I $G(RCTRANDA) L -^PRCA(433,RCTRANDA)
 Q
 ;
 ;
INTADMIN(RCBILLDA) ;  ask and adjust the interest and admin
 N RCAMOUNT,RCTRANDA,Y
 ;
 ;  check to see if there is interest and admin charges
 S RCAMOUNT=$G(^PRCA(430,RCBILLDA,7))
 I '$P(RCAMOUNT,"^",2),'$P(RCAMOUNT,"^",3),'$P(RCAMOUNT,"^",4),'$P(RCAMOUNT,"^",5) Q
 ;
 ;  only ask if there is no principal
 I RCAMOUNT Q
 ;
 W !!,"You have the option to automatically EXEMPT the interest"
 W !,"and administrative charges.  This will close the bill."
 S Y=$$ASKEXEMP I Y'=1 Q
 ;
 W !!,"Creating an EXEMPT transaction ..."
 S RCTRANDA=$$EXEMPT^RCBEUTR2(RCBILLDA,$P(RCAMOUNT,"^",2)_"^"_$P(RCAMOUNT,"^",3)_"^^"_$P(RCAMOUNT,"^",4)_"^"_$P(RCAMOUNT,"^",5))
 I 'RCTRANDA W !,"  *** W A R N I N G: EXEMPTION NOT Processed! ***" Q
 I RCTRANDA W !,"   Exempt Transaction: ",RCTRANDA," has been added."
INTC35B ;Check if CS5B entry needed for exempt transaction
 I RCTRANDA,'$G(RCEDIWL),(RCBETYPE="DECREASE"),$D(^PRCA(430,"TCSP",RCBILLDA)) D DECADJ^RCTCSPU(RCBILLDA,RCTRANDA) ;prca*4.5*301 add cs exempt
 I '$G(REFMS)&(DT>$$LDATE^RCRJR(DT)) S Y=$E($$FPS^RCAMFN01(DT,1),1,5)_"01" D DD^%DT W !!,"   * * * * Transmission will be held until "_Y_" * * * *"
 ;
 W !,"  Current Bill Status: ",$P($G(^PRCA(430.3,+$P($G(^PRCA(430,RCBILLDA,0)),"^",8),0)),"^")
 Q
 ;
ASKOK(RCBETYPE) ;  ask record decrease or increase transaction
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("A")="Are you sure you want to enter this "_RCBETYPE_" adjustment "
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
ASKAUPO() ;  ask record even though marked for auto post PRCA*4.5*298
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YOA",DIR("B")="NO"
 S DIR("A")="Marked for Auto-Post. Are you sure? (Y/N) "
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
 ;PATCH 313
ASKFIX() ;  ask to fix bill's balance
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="YES"
 ;S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to FIX the balance discrepancy "
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
 ;
ASKEXEMP() ;  ask to record an exempt transaction
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Would you like to EXEMPT the interest and admin charges "
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
 ;
ASKCONT() ;  ask if contract adjustment
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("A")="  Is this a CONTRACT adjustment "
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
 ;
ASKREV() ; Ask if Treasury reversal *315/DRF
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Is this a TREASURY reversal "
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
 ;
ADJNUM(RCBILLDA) ;  get next adjustment number for a bill
 N %,ADJUST,DATA1,RCTRANDA
 S RCTRANDA=0
 F  S RCTRANDA=$O(^PRCA(433,"C",RCBILLDA,RCTRANDA)) Q:'RCTRANDA  S DATA1=$G(^PRCA(433,RCTRANDA,1)) I $P(DATA1,"^",4),$P(DATA1,"^",2)=1!($P(DATA1,"^",2)=35) S ADJUST=$P(DATA1,"^",4)+1
 Q ADJUST
 ;
 ;
AMOUNT(RCBILLDA,RCBETYPE) ;  enter the adjustment amount for a bill
 N DIR,DIRUT,DTOUT,DUOUT,PRINBAL,X,Y
 S PRINBAL=+$P($G(^PRCA(430,RCBILLDA,7)),"^")
 I RCBETYPE="INCREASE" S PRINBAL=9999999.99
 W !!,"Enter the ",RCBETYPE," Adjustment AMOUNT, from .01 to ",$J(PRINBAL,0,2),"."
 S DIR(0)="NAO^.01:"_PRINBAL_":2"
 S DIR("A")="  "_RCBETYPE_" PRINCIPAL BALANCE BY: "
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q $S(Y'="":Y,1:-1)
 ;
ASKCM() ;  ask if the action is being performed due to the claims matching process  *315
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Is this action being performed due to the CLAIMS MATCHING process "
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1 I $G(GOTBILL) S RCDPGQ=1    ; account profile listman quit flag  *315
 Q Y
 ;
 ;
THRDPRTY(RCBILLDA) ; check whether or not bill is THIRD PARTY
 N CAT
 S CAT=$$GET1^DIQ(430,RCBILLDA,2,"I")   ; get account receivable category  
 I $$GET1^DIQ(430.2,CAT,5,"I")="T" Q 1  ; return true if AR Category is THIRD PARTY
 Q 0
