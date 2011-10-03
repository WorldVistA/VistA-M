IVMUPAR1 ;ALB/CJM - IVM PARAMETER ENTER/EDIT (continued); 4-SEP-97
 ;;2.0;INCOME VERIFICATION MATCH;**9,17**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ON() ;
 ;Description:  Returns 1 if enrollment events should be transmitted, 0 otherwise.
 ;Input:
 ;  None
 ;Output:
 ;  Function Value: 1 if enrollment events should be transmitted, 0 otherwise
 ;
 Q $S(($P($G(^IVM(301.9,1,0)),"^",8)=1):1,1:0)
 ;
SETON ;
 ;Description:  Sets the field TRANSMIT ENROLLMENT EVENTS? to 1 so that
 ;patient enrollment events will be transmitted in the nightly
 ;transmission. It is assumed that a record, ien=1, exists in the 
 ;IVM SITE PARAMETER file.
 ;
 ;Input: None
 ;Output: None
 ;
 S $P(^IVM(301.9,1,0),"^",8)=1
 Q
 ;
 ;
DCDON() ;
 ; Description: Returns 1 if DCD messaging is enabled, 0 otherwise.
 ;
 ;  Input: None
 ;
 ; Output:
 ;   Function Value: 1 if DCD messaging is enabled, 0 otherwise
 ;
 Q $S(($P($G(^IVM(301.9,1,20)),"^")=1):1,1:0)
