DGMTP2 ;ALB/RMO - Print Means Test 10-10F Cont. ;7 APR 1992 11:00 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ;Entry point to print income and net worth
 ;Also calls DGMTP3 to print deductible expenses and
 ;DGMTP4 to print the signature block and special notes
 D INC,EXP^DGMTP3,NET,EN^DGMTP4
Q Q
 ;
INC ;Print income
 N Y
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!!?5,"C. Previous Calendar Year Gross Income for " S Y=$$LYR^DGMTSCU1(DGMTDT) X ^DD("DD") W Y,"  (including amounts deducted for taxes, insurance, Medicare, etc.)"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?10,"Type of Income",?50,"|      Veteran",?72,"|      Spouse",?93,"|   Children",?109,"|      Total"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"1. Social Security (Not SSI)" D INCFLD(.DGIN0,8)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"2. U.S. Civil Service" D INCFLD(.DGIN0,9)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"3. U.S. Railroad Retirement" D INCFLD(.DGIN0,10)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"4. Military Retirement" D INCFLD(.DGIN0,11)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"5. Unemployment Compensation" D INCFLD(.DGIN0,12)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"6. Other Retirement (Company, state, local, etc.)" D INCFLD(.DGIN0,13)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"7. Total Income from Employment",?50,"|",?72,"|",?93,"|",?109,"|",!?4,"(Wages, salary, earnings, tips)" D INCFLD(.DGIN0,14)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"8. Interest, Dividend, or Annuity Income" D INCFLD(.DGIN0,15)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"9. Workers Compensation or Black Lung Benefits" D INCFLD(.DGIN0,16)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"10. All Other Income" D INCFLD(.DGIN0,17)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"11. Total Income",?50,"|",?109,"|",$J($$AMT^DGMTSCU1(DGINT),18)
 Q
INCFLD(DGIN,DGPCE) ;Print income fields
 N DGTOT,I
 W ?50,"|",$J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),19)
 W ?72,"|" W:$D(DGIN("S")) $J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),18)
 W ?93,"|" W:$D(DGIN("C")) $J($$AMT^DGMTSCU1($P(DGIN("C"),"^",DGPCE)),13)
 S DGTOT=0,I="" F  S I=$O(DGIN(I)) Q:I=""  S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 W ?109,"|",$J($$AMT^DGMTSCU1(DGTOT),18)
 Q
 ;
NET ;Print net worth
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!!?37,"E. Previous Calendar Year Net Worth"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?10,"Type of Asset",?63,"|      Veteran",?88,"|      Spouse",?109,"|      Total"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"1. Cash, Amounts in Bank Accounts (Include IRA's)" D NETFLD(.DGIN2,1)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"2. Stocks and Bonds" D NETFLD(.DGIN2,2)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"3. Real Property (Not including your primary residence)",?63,"|",?88,"|",?109,"|",!?4,"(market value of property minus incumbrances)" D NETFLD(.DGIN2,3)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"4. Other Property or Assets not Shown Elsewhere" D NETFLD(.DGIN2,4)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"5. Debts (Include any debts that will reduce the value",?63,"|",?88,"|",?109,"|",!?4,"of property listed in E4)(Cannot exceed E4)" D NETFLD(.DGIN2,5)
 I DGMTYPT=1 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"6. Net Worth (Line E1 + E2 + E3 + E4 minus line E5)",?63,"|",?109,"|",$J($$AMT^DGMTSCU1(DGNWT),18)
 I DGMTYPT=2 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"6. Net Worth (Line E1 + E2 + E3 + E4 minus line E5)",?63,"|",?109,"|",$S('$$ASKNW^DGMTCOU:$J("NOT APPLICABLE",18),1:$J($$AMT^DGMTSCU1(DGNWT),18))
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!!?1,"7. TOTAL (Add items D(11) and E(6))",?63,"|",?109,"|",$J($$AMT^DGMTSCU1(DGINT-DGDET+DGNWT),18)
 Q
 ;
NETFLD(DGIN,DGPCE) ;Print net worth fields
 N DGTOT,I
 W ?63,"|",$J($$AMT^DGMTSCU1($P(DGIN("V"),"^",DGPCE)),22)
 W ?88,"|" W:$D(DGIN("S")) $J($$AMT^DGMTSCU1($P(DGIN("S"),"^",DGPCE)),19)
 S DGTOT=0,I="" F  S I=$O(DGIN(I)) Q:I=""  S DGTOT=DGTOT+$P(DGIN(I),"^",DGPCE)
 I DGMTYPT=1 W ?109,"|",$J($$AMT^DGMTSCU1(DGTOT),18)
 I DGMTYPT=2 W ?109,"|",$S('$$ASKNW^DGMTCOU:$J("NOT APPLICABLE",18),1:$J($$AMT^DGMTSCU1(DGTOT),18))
 Q
