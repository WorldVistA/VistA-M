PRCAI78 ;WISC/RFJ-patch 78 post init ;1 Sep 99
 ;;4.5;Accounts Receivable;**78**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
POST ;  start post init
 ;
 ;  approval in DBIA 2903
 ;  set write identifiers for file 433 (removes old id that references calm)
 S ^DD(433,0,"ID","WR1")="I +$P(^(0),U,4)<2 D EN^DDIOL(""  TRANSACTION STATUS: INCOMPLETE"","""",""?0"")"
 K ^DD(433,0,"ID","WR2")
 ;
 Q
