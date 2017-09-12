IBY345PR ;;PROXICOM/RTO - Pre Installation Program ;5-March-2007
 ;;2.0;INTEGRATED BILLING;**345**;21-MAR-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;Program Description: This is the pre install routine for IB*2.0*345
 ;
 ;  Program to remove all prior entires of file "SOURCE OF INFORMATION" ^IBE(355.12)
 ;  
REM ;  Remove old entries
 N DA,DIK
 S DIK="^IBE(355.12,",DA(1)=1,DA=0
 F  S DA=$O(^IBE(355.12,DA)) Q:DA="B"!'DA  D ^DIK
 Q
