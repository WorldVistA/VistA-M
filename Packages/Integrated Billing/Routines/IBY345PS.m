IBY345PS ;;PROXICOM/RTO - Post Installation Program ;10-November-2006
 ;;2.0;INTEGRATED BILLING;**345**;21-MAR-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;Program Description: This is the post install routine for IB*2.0*345
 ;
 ;  Program to check and clean up "ghost buffer entries"
 ;  
REM ;  Remove old entries
 NEW IEN,STAT
 S IEN=0
 F  S IEN=$O(^IBA(355.33,IEN)) Q:'IEN  D
 . S STAT=$P($G(^IBA(355.33,IEN,0)),"^",4)
 . I STAT="E" Q
 . I $G(^IBA(355.33,IEN,40))="",$G(^IBA(355.33,IEN,60))="" Q
 . D DELDATA^IBCNBED(IEN)
 Q
