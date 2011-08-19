ICPTAU ; DLS/DEK/KER - CPT Annual Update Protocol for CPT Codes ; 02/22/2007
 ;;6.0;CPT/HCPCS;**14,16,34**;May 19, 1997;Build 3
 ;
 ; Quit Update if NOT CPT Procedure Related 
 ;
 ;   XQORQUIT  Signals the Unwinder to not process 
 ;             any protocols that are subordinate to 
 ;             the current protocol.  Control is passed
 ;             to the next sibling protocol.
 ;
 S:'$D(LEXSCHG("B",81))&('$D(LEXSCHG("B",81.3))) XQORQUIT=1
 Q
