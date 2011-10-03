IBCF34 ;ALB/BGA -UB92 HCFA-1450 (set text print) ;13-SEPT-93
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN ;This routine sets the array which will store the message that will
 ;be displayed on the front page of the bill.
 ;
 ; Free text no longer prints in these blocks as of MRA/EDI
 Q:$G(IBNOCOM)  ;No comments on post-EDI bills
 ; ******** Only used for pre-EDI bills *********
 N IBSM,IBE,IBX,IBI,IBCNT S (IBCNT,IBSM)=0,IBE=24,IBLINES=23
 S IBX=$G(^DGCR(399.3,+$P(IBCBILL,U,7),0))
 I $P(IBCBILL,U,11)="i",$P(IBX,U,8) S IBSM=1,IBCNT=5
 I $P(IBX,U,9) S IBSM=IBSM+2,IBCNT=IBCNT+2
 Q:'IBSM  S:IBSM=3 IBCNT=IBCNT+1,IBLINES=23-IBCNT
% ;Add statements to bottom of first page of UB-92.
 I IBSM=1!(IBSM=3) D
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^For your information, even though the patient may be otherwise eligible",IBCNT=IBCNT-1
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^for Medicare, no payment may be made under Medicare to any Federal provider",IBCNT=IBCNT-1
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^of medical care or services and may not be used as a reason for non-payment.",IBCNT=IBCNT-1
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^Please make your check payable to the Department of Veterans Affairs and",IBCNT=IBCNT-1
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^send to the address listed above.",IBCNT=IBCNT-1
 I IBSM=3 S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^",IBCNT=IBCNT-1
 I IBSM>1 D
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^The undersigned certifies that treatment rendered is not for a",IBCNT=IBCNT-1
 . S ^TMP($J,"IBC-RC",(IBE-IBCNT))="2^service connected disability.",IBCNT=IBCNT-1
 Q
