PRCAEA ;SF-ISC/LJP-LOCK FOR IN/REACTIVATE VENDOR ;6/30/92  12:49 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
LCK L @("+"_DIC_DA_"):15") I '$T W !,*7,"ANOTHER USER IS EDITING THIS ENTRY!" K DA
 Q
