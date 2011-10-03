DGBTCR2 ;ALB/SCK - BENEFICIARY TRAVEL FORM 70-3542d CONTINUE; 2/7/88@08:00  6/11/93@09:30
 ;;1.0;Beneficiary Travel;;September 25, 2001
 ;This routine is a modification of AIVBTPRT / pmg / GRAND ISLAND ;07 Jul 88  12:02 PM
 Q
PRINT ;Continuation of DGBTCR1, called by DGBTCR
MILEAGE W !,"| 6.  Miles Traveled",?30,"| 7.  Authorized Mileage Rate:",?66,"| 8.  Mileage Allowance (Item 6 X Item 7)",?131,"|"
RMV ;W !,"|",?30,"|",?66,"|",?131,"|"
 W !,"|",?10,DGBTM6," miles",?30,"|",?40,DGBTM7," per mile",?66,"|",?80,DGBTM8,?131,"|" D LINE
COST1 W !,"| 9.  Meals & Lodging Costs   |",?32,"10.  Ferry, Bridges, Etc.",?66,"| 11.  Total (Sum of 8, 9, and 10)",?131,"|"
RMV1 ;W !,"|",?30,"|",?66,"|",?131,"|"
 W !,"|",?7,DGBTM9,?30,"|",?40,DGBTM10,?66,"|",?80,DGBTM11,?131,"|" D LINE
COST2 W !,"| 12.  Most Economical",?30,"| 13.  Total (Sum of 9 and 12)",?66,"| 14.  AMOUNT CLAIMED AND PAYABLE *",?131,"|"
 W !,"|      Public Trans. Costs",?30,"|",?66,"|","      MINUS",?80,$P(DGBTM14,"^",2)," APPLIED DEDUCTIBLE",?131,"|"
RMV2 ;W !,"|",?30,"|",?66,"|",?131,"|"
 W !,"|",?7,DGBTM12,?30,"|",?40,DGBTM13,?66,"|",?80,$P(DGBTM14,"^"),?131,"|" D LINE
 W !,"| * The amount payable will be the amount entered in Item 11 or Item 13, whichever is less.  Exception:  If public transportation",?131,"|"
 W !,"|   is not reasonably accessible or would be medically inadvisable, the amount payable will be the amount entered in item 11.",?131,"|" D LINE
CERTIFY W !,"|  I CERTIFY THAT THE CLAIMANT REPORTED FOR AN AUTHORIZED SERVICE ON THE DATE SHOWN.  (Authority VA Regulation 6100 & PL 100-322)",?131,"|" D LINE
 W !,"| 15.  Date/Time of Claim",?30,"| 16.  Signature of Certifying Official",?131,"|",!,"|",?30,"|",?131,"|"
 W !,"|",?8,DGBTM15,?30,"|",?37,DGBTM16,?131,"|" D LINE
PAYEE W !,"|  I have neither obtained transportation at Government expense nor through the use of Government request, tickets, or tokens;",?131,"|"
 W !,"|  and have not used any Government-owned conveyance or incurred any expenses which may be presented as charges against the",?131,"|"
 W !,"|  Dept. of Veterans Affairs for transportation, meals, or lodging in connection with my authorized travel that is not herein",?131,"|"
 W !,"|  claimed.  I hereby claim the amount entered in Item 14 above.  I certify that the claim is correct and just and that payment",?131,"|",!,"|  has not been received.",?131,"|",!,"|",?131,"|"
 W !,"|  I hereby acknowledge receipt, in  cash  or  check to be mailed, of the amount in Item 14 above, in full payment of this claim.",?131,"|" D LINE
 W !,"| 17.  Signature of Payee",?100,"| 18.  Date",?131,"|",!,"|",?100,"|",?131,"|"
 W !,"|",?7,DGBTM17,?100,"|",?131,"|" D LINE
REMKS W !,"|",?7,"REMARKS:  ",DGBTVAR("R"),?102,"ACCOUNT: ",$P(^DGBT(392.3,$P(DGBTVAR(0),"^",6),0),"^",2) W:$P(DGBTVAR("A"),"^",3)=1 "  REVIEW VISIT" W ?131,"|" D LINE
AUDIT W !,"|",?60,"AUDIT BLOCK",?131,"|",!,"|" K I S $P(I,"-",131)="" W I,"|"
 W !,"|",?7,"AMOUNT PAID FOUND CORRECT",?66,"|  Remarks",?131,"|",!,"|" K I S $P(I,"-",65)="" W I
 W ?66,"|",?131,"|",!,"|",?7,"Auditor's Initials",?45,"Date",?66,"|",?131,"|" D LINE W !,"VA Form 70-3542d",!
 Q
LINE K I S $P(I,"=",131)="" W !,"|",I,"|"
 Q
