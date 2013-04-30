LA7SRPT ;DALOI/JDB - SHIPPING MGR REPORTS ;03/07/12  08:52
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Top Level routine for option calls
 Q
 ;
SHPCFG ;
 ; Display a Shipping Configuration (or MSG CFG)
 D EN^LA7SRPT1
 Q
 ;
CU ;
 ; Display Code Usage
 D ASK^LA7SRPT2
 Q
 ;
SCTOVER ;
 ; Display #62.48 SCT Override info
 D EN^LA7SRPT4
 Q
