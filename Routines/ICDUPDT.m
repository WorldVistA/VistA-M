ICDUPDT ; DLS/DEK/KER - ICD Update Protocol for ICD Codes ; 02/22/2007
 ;;18.0;DRG Grouper;**6,11,28**;Oct 20, 2000;Build 3
 ;
 ; Quit Update if NOT ICD Diagnosis/Procedure Related 
 ;
 ;   XQORQUIT  Signals the Unwinder to not process 
 ;             any protocols that are subordinate to 
 ;             the current protocol.  Control is passed
 ;             to the next sibling protocol.
 ;
 S:'$D(LEXSCHG("B",80))&('$D(LEXSCHG("B",80.1))) XQORQUIT=1
 Q
