PRCAGF1 ;WASH-ISC@ALTOONA,PA/CMS- Print Form Letters Cont. ;7/12/93  8:08 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PAY ;print payment Remittance bottom of letter
 NEW X,Y
 W:($Y+22)>IOSL @IOF ;the remittance form is 20 lines long
 W !! S Y="",$P(Y,"=",80)="" W !,Y
 W !,"FOR PROPER CREDIT TO YOUR ACCOUNT, PLEASE DETACH AND RETURN WITH YOUR PAYMENT"
 S Y="",$P(Y,"_",80)="" W !,?1,$E(Y,1,78),!,"|",?31,"PAYMENT REMITTANCE",?79,"|",!,"|",$E(Y,1,78),"|"
 W !,"|","*File No./SSAN",?16,"| Name of Debtor",?40,"|Amount Enclosed| Your Telephone No.",?79,"|"
 W !,"|",?16,"|",?40,"|",?56,"| (include Area Code)",?79,"|"
 W !,"|",$S($D(RCIRSTOT):SSN,1:$P(^PRCA(430,PRCABN,0),U,1)),?16,"|",$E(NAM,1,23),?40,"| $",?56,"|",?79,"|"
 W !,"|" F X=15,23,15,22 W $E(Y,1,X),"|"
 W !,"|ENTER YOUR CURRENT ADDRESS BELOW ONLY IF THE ONE ABOVE IS INCORRECT.",?79,"|",!,"|","PLEASE INCLUDE YOUR ZIP CODE.",?79,"|"
 W !,"|",?79,"|",!,"|",?79,"|",!,"|",?79,"|",!,"|",?79,"|",!,"|",$E(Y,1,78),"|"
 W !,"| *Please include this number on your check or money order.",?79,"|",!,"|",$E(Y,1,78),?79,"|"
 Q
