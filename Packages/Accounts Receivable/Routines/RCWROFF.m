RCWROFF ;WISC/RFJ - write off, terminated ;1 Feb 2000
 ;;4.5;Accounts Receivable;**168,204,309,301,307,315,377,381,391,378,418**;Mar 20, 1995;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
8 ;  terminated by fiscal officer (trantype=8) (menu option)
 N RCDRSTRG
 S RCDRSTRG="11TERMINATION DATE;"
 S RCDRSTRG=RCDRSTRG_"17;"  ;termination reason
 D MAIN("8^Fiscal Officer Termination",RCDRSTRG)
 Q
 ;
 ;
9 ;  terminated by compromise (trantype=9) (menu option)
 N RCDRSTRG
 S RCDRSTRG="11TERMINATION DATE;"
 S RCDRSTRG=RCDRSTRG_"17;"  ;termination reason
 D MAIN("9^Compromise Termination",RCDRSTRG)
 Q
 ;
 ;
A9 ;  compromised by rc/doj (use trantype=9) (menu option)
 N RCDRSTRG
 S RCDRSTRG="11TERMINATION DATE;"
 S RCDRSTRG=RCDRSTRG_"17;"  ;termination reason
 D MAIN("9^Compromise Termination by RC/DOJ",RCDRSTRG)
 Q
 ;
 ;
10 ;  waived in full transaction (trantype=10) (menu option)
 D MAIN("10^Waiver","11WAIVED DATE;")
 Q
 ;
 ;
A10 ;  waived by rc/doj (use trantype=10) (menu option)
 D MAIN("10^RC/DOJ Waiver","11WAIVED DATE;")
 Q
 ;
 ;
29 ;  terminated by rc/doj (trantype=29) (menu option)
 N RCDRSTRG
 S RCDRSTRG="11TERMINATION DATE;"
 S RCDRSTRG=RCDRSTRG_"17;"  ;termination reason
 D MAIN("29^RC/DOJ Termination",RCDRSTRG)
 Q
 ;
 ;
47 ;  suspended (trantype=47) (menu option)
 N RCDRSTRG
 S RCDRSTRG="11SUSPENDED DATE;"
 S RCDRSTRG=RCDRSTRG_"90.1R;"  ;suspension type  PRCA*4.5*391
 S RCDRSTRG=RCDRSTRG_"S RCX=$$SUSTP^RCWROFF(X);"
 S RCDRSTRG=RCDRSTRG_"5.02////^S X=RCX;"  ;brief comment
 S RCDRSTRG=RCDRSTRG_"K RCX;"
 D MAIN("47^Suspension",RCDRSTRG)
 Q
 ;
SUSTP(X) ; suspension types for brief comment in *309
 ; input-code between 0 to 14
 ; output-text
 N IBX
 S IBX=$P($T(SUSTX+X),";;",2)
 Q IBX
 ;
 ; PRCA*4.5*391 - moved everything in tag SUSTX 1 line down to accomodate for switch of suspension type to a dictionary file 433.001
SUSTX ;
 ;;NOT CO-PAY SUSPENSION
 ;;INITIAL CO-PAY WAIVER
 ;;APPEAL CO-PAY WAIVER
 ;;ADMINISTRATIVE SUSPENSION
 ;;COMPROMISE
 ;;TERMINATION
 ;;BANKRUPTCY CHAP 7
 ;;BANKRUPTCY CHAP 13
 ;;BANKRUPTCY OTHER
 ;;PROBATE
 ;;CHOICE
 ;;DISPUTE
 ;;INDIAN ATTESTATION
 ;;COMPACT
 ;;CLELAND-DOLE
 ;
 ;
MAIN(RCTRTYPE,RCDRSTRG) ;  main subroutine to process a waiver, termination, suspended transaction
 ;  rctrtype = transaction type^description, example 10^waiver
 ;  rcdrstrg = dr string used when calling die
 I '$G(GOTBILL) N RCBILLDA  ;PRCA*4.5*315 Pass in RCBILLDA
 N BALANCE,DR,RCTRANDA,Y,RCSPFLG
 F  D  Q:RCBILLDA<1!($G(GOTBILL))
 .   K RCTRANDA  ;do not leave around in for loop
 .   ;  select a bill
 .   I '$G(GOTBILL) S RCBILLDA=$$GETABILL^RCBEUBIL I RCBILLDA<1 Q  ;PRCA*4.5*315
 .   I $D(^PRCA(430,"TCSP",RCBILLDA)) W !,"BILL HAS BEEN REFERRED TO CROSS-SERVICING.",!,"NO TRANSACTIONS ARE ALLOWED." D  Q  ;prca*4.5*301
 . .  I +RCTRTYPE=10!(+RCTRTYPE=47)!(+RCTRTYPE=9)!(+RCTRTYPE=8) W !,"** THE RECALL PROCESS MUST BE UTILIZED PRIOR TO PERFORMING THIS FUNCTION **"   ;prca*4.5*301  
 .   ;  check to see if bill has been referred to rc/doj (6;4 = referral date)
 .   I $P(RCTRTYPE,"^",2)["RC/DOJ",$P($G(^PRCA(430,RCBILLDA,6)),"^",4)="" W !,"THIS ACCOUNT IS NOT REFERRED TO RC/DOJ." Q
 .   ;  lock the bill
 .   L +^PRCA(430,RCBILLDA):5 I '$T W !,"ANOTHER USER IS CURRENTLY WORKING WITH THIS BILL." Q
 .   D SHOWBILL^RCWROFF1(RCBILLDA)
 .   I '$G(^PRCA(430,RCBILLDA,7)) W !,"THIS BILL HAS NO PRINCIPAL BALANCE." D UNLOCK Q
 .   ;  ask to enter transaction
 .   S Y=$$ASKOK($P(RCTRTYPE,"^",2))          ; prca*4.5*315 changes
 .   I Y'=1 D  Q                              ; user said No, or no response, or ^/timeout
 . .   D UNLOCK                               ; unlock bill and transaction
 . .   I Y<0,'$G(GOTBILL) S RCBILLDA=0        ; ^ or timeout, get out of this loop
 . .   I Y<0,$G(GOTBILL) S RCDPGQ=1           ; ^ or timeout, set special variable - see RCDPAPL1
 . .   Q
 .   ;
 .   ;  add a new transaction to file 433
 .   S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,$P(RCTRTYPE,"^")) I 'RCTRANDA W !,$P(RCTRANDA,"^",2) D UNLOCK Q
 .   W !,"  Transaction number ",RCTRANDA," added ..."
 .   ;
 .   ;  set up dr string for die call  PRCA*4.5*307 - Move comment below balance sets
 .   S DR=RCDRSTRG   ;_"41;"  ;comment
 .   ;  bill amount moved to transaction amount
 .   S BALANCE=$P($G(^PRCA(430,RCBILLDA,7)),"^",1,5)
 .   S DR=DR_"15////"_($P(BALANCE,"^")+$P(BALANCE,"^",2)+$P(BALANCE,"^",3)+$P(BALANCE,"^",4)+$P(BALANCE,"^",5))_";"
 .   I $P(BALANCE,"^",1) S DR=DR_"81////"_+$P(BALANCE,"^",1)_";"   ;principal
 .   I $P(BALANCE,"^",2) S DR=DR_"82////"_+$P(BALANCE,"^",2)_";"   ;interest
 .   I $P(BALANCE,"^",3) S DR=DR_"83////"_+$P(BALANCE,"^",3)_";"   ;admin
 .   I $P(BALANCE,"^",4) S DR=DR_"84////"_+$P(BALANCE,"^",4)_";"   ;marshal fee
 .   I $P(BALANCE,"^",5) S DR=DR_"85////"_+$P(BALANCE,"^",5)_";"   ;court cost
 .   ;
 .   ; PRCA*4.5*307 - Comment save is moved below balance sets
 .   S DR=DR_"41;"
 .   ;  edit the fields
 .   S Y=$$EDIT433^RCBEUTRA(RCTRANDA,DR)
 .   I 'Y W !,$P(Y,"^",2) D DEL433^RCBEUTRA(RCTRANDA,"",0),UNLOCK Q
 .   ;  set the bill and transaction as RC/DOJ
 .   I $P(RCTRTYPE,"^",2)["RC/DOJ" D SETRCDOJ^RCBEUBIL(RCBILLDA,RCTRANDA,"RC")
 .   ;  change the status of the bill
 .   I $P(RCTRTYPE,"^")'=47 D CHGSTAT^RCBEUBIL(RCBILLDA,23)  ;write off
 .   I $P(RCTRTYPE,"^")=47 D CHGSTAT^RCBEUBIL(RCBILLDA,40)   ;suspended
 .   ;  mark transaction as processed
 .   D PROCESS^RCBEUTRA(RCTRANDA)
 .   ;
 .   ;PRCA*4.5*377
 .   S RCSPFLG=2
 .   S:+RCTRTYPE=47 RCSPFLG=1
 .   ;  Update any active repayment plan the bill may be attached to
 .   D UPDBAL^RCRPU1(RCBILLDA,RCTRANDA,RCSPFLG)   ;PRCA*4.5*381 - Add suspend flag.
 .   ;
 .   ;  create fms write off document, if not accrued and not suspended (47) transaction
 .   I '$$ACCK^PRCAACC(RCBILLDA),$P($G(^PRCA(433,RCTRANDA,1)),"^",2)'=47 D FMSDOC(RCTRANDA)
 .   ;
 .   W !,"  * * * * * ",$P(RCTRTYPE,"^",2)," has been PROCESSED! * * * * *"
 .   I '$G(REFMS)&(DT>$$LDATE^RCRJR(DT)) S Y=$E($$FPS^RCAMFN01(DT,1),1,5)_"01" D DD^%DT W !!,"   * * * * Transmission will be held until "_Y_" * * * *"
 .   D UNLOCK
 Q
 ;
 ;
FMSDOC(RCTRANDA) ;  create fms write off document
 N Y
 W !!,"Creating FMS Write-off document ... "
 S Y=$$BUILDWR^RCXFMSW1(RCTRANDA)
 I Y W $P(Y,"^",2)," created."
 E  W "ERROR: ",$P(Y,"^",2)
 Q
 ;
 ;
UNLOCK ;  unlock bill and transaction
 L -^PRCA(430,RCBILLDA)
 I $G(RCTRANDA) L -^PRCA(433,RCTRANDA)
 Q
 ;
 ;
ASKOK(TRANTYPE) ;  ask record transaction
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you sure you want to record this bill as a "
 I $L(TRANTYPE)<20 S DIR("A")=DIR("A")_TRANTYPE
 E  S DIR("A",1)=DIR("A"),DIR("A")="  "_TRANTYPE
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
