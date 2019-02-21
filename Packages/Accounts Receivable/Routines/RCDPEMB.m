RCDPEMB ;AITC/CJE - CONTINUE MANUAL ERA AND EFT MATCHING ;Jun 11, 2014@13:24:36
 ;;4.5;Accounts Receivable;**326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*326 - Move subroutine here to resolve routine size issue in RCDPEM2
NOCHNG ; EP
 ; Input: None
 ; Output: None
 N DIR,X,Y,DTOUT,DUOUT
 D EN^DDIOL("NO CHANGES HAVE BEEN MADE.","","!")
 S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 W !! D ^DIR
 Q
