DGMTP3 ;ALB/RMO - Print Means Test 10-10F Cont. ;7 APR 1992 11:00 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
EXP ;Entry point to print deductible expenses
 N DGCET,DGEMT
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!!?59,"D. Deductible Expenses"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"1. List medical expenses ACTUALLY paid by you during the previous calendar year",!?4,"(include Medicare and other health insurance expenses).    ",$$AMT^DGMTSCU1($P(DGIN1("V"),"^"))
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"2. List amounts paid by you during the previous calendar year for funeral and burial expenses",!?4,"of a deceased spouse or child.    "
 W $S('$P(DGVIR0,"^",5)&('$P(DGVIR0,"^",8)):"NOT APPLICABLE",1:$$AMT^DGMTSCU1($P(DGIN1("V"),"^",2)))
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"3. List amounts paid by you during the previous calendar year for YOUR educational expenses.",!?4,"(Do NOT show spouse's or children's payments)    ",$$AMT^DGMTSCU1($P(DGIN1("V"),"^",3))
 S DGPGE=1 D FT^DGMTP ;end of first page for form
 ;
 D HD^DGMTP W !?1,"4. Was employment income reported for a child in item C7",?63,"|     FOR VA USE ONLY",?88,"| 5. Enter child's income exclusion"
 W !?6,$S('$P(DGVIR0,"^",8):"NOT APPLICABLE",1:$$YN^DGMTSCU1($D(DGDCS))),?63,"|",?88,"|        ",$$AMT^DGMTSCU1($P(DGMTPAR,"^",17))
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?20,"6. List each child for whom employment income was reported in item C7."
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?6,"Child's Name",?30,"| Employment",?45,"| Exclusion from",?63,"| Subtract (C) from (B)",?88,"| Child's",?109,"| Child's countable"
 W !?30,"| income from",?45,"| item D(5)",?63,"| (if ""0"", skip (E)",?88,"| post-secondary",?109,"| employment income"
 W !?30,"| item C7",?45,"|",?63,"| and enter ""0"" in (F))",?88,"| education expenses",?109,"|"
 W !?6,"       (A)",?30,"|     (B)",?45,"|      (C)",?63,"|         (D)",?88,"|       (E)",?109,"|         (F)"
 I '$D(DGDCS) W $$UL^DGMTSCU1(DGUL,DGLNE1),!?6,"NOT APPLICABLE",?30,"|",?45,"|",?63,"|",?88,"|",?109,"|"
 I $D(DGDCS) S (DGLP,DGCET,DGEMT)=0 F  S DGLP=$O(DGDCS(DGLP)) Q:'DGLP  S DGCNT=DGDCS(DGLP) D CHILD
 ;
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!!?37,"TO BE COMPLETED BY VA (VETERANS AFFAIRS)"
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"7. Child's Reported Employment Income (Item D6(B) above)",?109,"|",$J($S($D(DGDCS):$$AMT^DGMTSCU1(DGEMT),1:"NOT APPLICABLE"),18)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"8. Child's Countable Employment Income (Item D6(F) above)",?109,"|",$J($S($D(DGDCS):$$AMT^DGMTSCU1(DGCET),1:"NOT APPLICABLE"),18)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"9. Child's Employment Income Exclusion (Subtract Item D8 from Item D7))",?109,"|",$J($S($D(DGDCS):$$AMT^DGMTSCU1(DGEMT-DGCET),1:"NOT APPLICABLE"),18)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"10. Total Deductible Expenses (Add Items D1, D2, D3 and D9)",?109,"|",$J($$AMT^DGMTSCU1(DGDET),18)
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,"11. Attributable Income (Subtract Item D10 from C11)",?109,"|",$J($$AMT^DGMTSCU1(DGINT-DGDET),18)
 Q
 ;
CHILD ;Print employment income and expenses for a dependent child
 N DGCE,DGEX,DGIN0,DGIN1
 S DGIN0=$G(^DGMT(408.21,+$G(DGINC("C",DGCNT)),0)),DGIN1=$G(^(1))
 S DGEX=$P(DGIN0,"^",14)-$P(DGMTPAR,"^",17) S:DGEX>0 DGCE=DGEX-$P(DGIN1,"^",3)
 S DGEMT=DGEMT+$P(DGIN0,"^",14) S:$G(DGCE)>0 DGCET=DGCET+DGCE
 W $$UL^DGMTSCU1(DGUL,DGLNE1),!?1,$$NAME^DGMTU1(+$G(DGREL("C",DGCNT)))
 W ?30,"|",$J($$AMT^DGMTSCU1($P(DGIN0,"^",14)),12)
 W ?45,"|",$J($$AMT^DGMTSCU1($P(DGMTPAR,"^",17)),15)
 W ?63,"|",$J($S(DGEX>0:$$AMT^DGMTSCU1(DGEX),1:0),22)
 W ?88,"|",$J($S(DGEX>0:$$AMT^DGMTSCU1($P(DGIN1,"^",3)),1:"NOT APPLICABLE"),19)
 W ?109,"|",$J($S($G(DGCE)>0:$$AMT^DGMTSCU1(DGCE),1:0),18)
CHILDQ Q
