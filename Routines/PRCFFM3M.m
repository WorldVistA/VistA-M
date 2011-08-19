PRCFFM3M ;WISC/SJG-ROUTINE TO PROCESS AMENDMENT OBLIGATIONS ;5/9/94  3:07 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; Message processing for amendment obligation
NOA ;
 W ! S MSG(1)="NO AMENDMENT EXISTS FOR THIS ORDER - PLEASE CHECK WITH SUPPLY."
 S MSG(2)="OPTION IS BEING ABORTED."
 D EN^DDIOL(.MSG) K MSG W !
 Q
MSG ;
 W ! D EN^DDIOL("No further processing is being taken on this amendment obligation.")
 Q
MSG1 ;
 W ! K MSG
 S MSG(1)="     This Purchase Order has been tampered with."
 S MSG(2)="     Please notify IFCAP APPLICATION COORDINATOR."
 D EN^DDIOL(.MSG) K MSG W !
 Q
