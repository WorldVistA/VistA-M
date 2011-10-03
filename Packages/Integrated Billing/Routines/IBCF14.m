IBCF14 ;ALB/AAS - PRINT BILL CONT. (PRINT STATEMENTS) ; 5-FEB-92
 ;;Version 2.0 ; INTEGRATED BILLING ;**4**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRP4
 ;
% ;Add statements to bottom of first page of UB-82.
 Q:'DGSM
 S DGNUMLIN=$S(DGSM=1:5,DGSM=2:2,DGSM=3:8)
 I DGSM=1!(DGSM=3) D
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="For your information, even though the patient may be otherwise eligible",DGNUMLIN=DGNUMLIN-1
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="for Medicare, no payment may be made under Medicare to any Federal provider",DGNUMLIN=DGNUMLIN-1
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="of medical care or services and may not be used as a reason for non-payment.",DGNUMLIN=DGNUMLIN-1
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="Please make your check payable to the Department of Veterans Affairs and",DGNUMLIN=DGNUMLIN-1
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="send to the address listed above.",DGNUMLIN=DGNUMLIN-1
 .I DGSM=3 S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="",DGNUMLIN=DGNUMLIN-1
 .Q
 I DGSM>1 D
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="The undersigned certifies that treatment rendered is not for a",DGNUMLIN=DGNUMLIN-1
 .S ^UTILITY($J,"IB-RC",24-DGNUMLIN)="service connected disability.",DGNUMLIN=DGNUMLIN-1
 .Q
 Q
