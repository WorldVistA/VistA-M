PRCAMARK ;WASH-ISC@ALTOONA,PA/TJK,LDB-MARK/UNMARK INVALID TRANSACTION ;10/15/93  11:53 AM
V ;;4.5;Accounts Receivable;**169,193**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SE ;  search for balance discrepancies
 NEW DIC,FR,TO,L,FLDS,BY,DIOEND,DIS
 W !!,"Since this may take awhile, queue this report to a printer!",!
 S DIC="^RCD(340,",(FR,TO)="",BY="@.01",FLDS="[PRCA DISCREPANCY]"
 S DIS(0)="I '$D(^RCD(340,D0,-9)),$P($G(^RCD(340,D0,0)),""^"")[""DPT("",$$EN^PRCAMRKC(D0)"
 S DIOEND="W !,""*   indicates account has bills in refund review."""
 D EN1^DIP
 Q
