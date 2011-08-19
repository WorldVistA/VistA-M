PRCSES3 ;WASH-ISC/DJM-HEADER FOR PRCS CO ITEMHIST ; [12/11/98 2:23pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
HEADER ; THIS IS THE HEADER FOR [PRCS CO ITEMHIST] PRINT TEMPLATE.
 ; THIS HEADER IS CALLED FROM [PRCS CO ITEMHIST-HDR] PRINT TEMPLATE.
 ;
 W !,?34,"Item History"
 W !
 W !,PRCSDT
 S PRCSPGQ=PRCSPGQ+1
 W ?70,"Page ",PRCSPGQ
 W !,"Site: ",PRC("SITE")
 W ?25,"Control Point: ",PRC("CP")
 W !,"Item Number: " D WRITMN^PRCSP1A
 W ?25,"Description: " D WRITMD^PRCSP1A
 W !
 W !,?25,"Qty.",?34,"Unit"
 W !,?25,"Prev.",?34,"of",?71,"Quantity"
 W !,"Date Ordered",?14,"PO Number",?25,"Recd.",?34,"Purch."
 W ?42,"Unit Cost",?56,"Total Cost",?71,"Ordered"
 K PRCSUL
 S $P(PRCSUL,"_",80)="_"
 W !,PRCSUL,!
 Q
