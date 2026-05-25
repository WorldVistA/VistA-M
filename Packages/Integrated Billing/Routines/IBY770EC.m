IBY770EC ;EDE/WCJ - ENV CHECK FOR IB*2.0*770 ;
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ; ICR#2120 ; $$KCHK^XUSRB(): Check If User Holds Security Key
EN ;Entry Point
 K XPDQUIT
 I $$KCHK^XUSRB("XUMGR",+DUZ) Q  ; installer has the key and everything is cool
 ;
 ; ABORT! ABORT! ABORT
 S XPDQUIT=2  ; Do not install this transport global but leave it in ^XTMP. >S XPDQUIT=2
 W !,"Don't be alarmed but something went awry...",!
 W !,"You need SECURITY KEY - XUMGR to successfully install this patch"
 W !,"which creates Proxy User AUTHORIZER, IB ACC"
 W !,"Please get the required key or find the closest person that has it"
 W !,"and ask for assistance.",!
 N DIR
 S DIR(0)="E"
 D ^DIR
 Q
