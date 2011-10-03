PRCAGST2 ;WASH-ISC@ALTOONA,PA/CMS-Print Patient Statement Summary ;4/19/95  11:07 AM
V ;;4.5;Accounts Receivable;**2,176**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
SUM ;statement summary called from PRCAGST1
 NEW I,Y
 W !,"|",?12,"|",?58,"|",?67,"|",?79,"|"
 W !,"|",?12,"|",?58,"|",?67,"|",?79,"|"
 W !,"|",?12,"|",?14,"Previous Balance",?32,$J(PBAL,15,2),?58,"|",?67,"|",?79,"|"
 W !,"|",?12,"|",?14,"Charges",?32,$J(TBAL("CH"),15,2),?58,"|",?67,"|",?79,"|"
 W !,"|",?12,"|",?14,"Payments/Credits",?32,$J(TBAL("PC"),15,2),?58,"|",?67,"|",?79,"|"
 I TBAL("RF")'=0 W !,"|",?12,"|",?14,"Refunds",?32,$J(TBAL("RF"),15,2),?58,"|",?67,"|",?79,"|"
 W !,"|",?12,"|",?32,"_______________",?58,"|",?67,"|",?79,"|"
 W !,"|",?12,"|",?14,"New Balance",?32,$J((PBAL+TBAL("CH")+TBAL("PC")+TBAL("RF")),15,2),?58,"|",?67,"|",?79,"|"
 F  Q:$Y>(IOSL-4)  W !,"|",?12,"|",?58,"|",?67,"|",?79,"|"
 I $D(THNK) W !,"|",?12,"|","THANK YOU FOR YOUR PAYMENT!",?58,"|",?67,"|",?79,"|"
 W !,"|" F I=12,46,9,12 S Y="",$P(Y,"_",I)="" W Y,"|"
 Q
