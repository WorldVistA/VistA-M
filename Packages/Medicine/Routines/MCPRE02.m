MCPRE02 ;HISC/DAD-FIX DATA IN PROCEDURE/SUBSPECIALTY FILE ;7/25/96  12:34
 ;;2.3;Medicine;;09/13/1996
 ;
 ; Procedure/Subspecialty file (#697.2) Print Name field (#7)
 ; Change 'GI ENDSCOPIC' to 'GI ENDOSCOPIC'
 N DA,DIE,DR,MCD0,TEMP
 S TEMP(1)=""
 S TEMP(2)="Cleaning up data in the Procedure/Subspecialty file (#697.2)."
 D MES^XPDUTL(.TEMP)
 ;
 I $$VFILE^DILFD(697.2) D
 . S MCD0=0
 . F  S MCD0=$O(^MCAR(697.2,MCD0)) Q:MCD0'>0  D
 .. S DR="2///@;2.1///@;9///@;10///@"
 .. I $P($G(^MCAR(697.2,MCD0,0)),U,8)="GI ENDSCOPIC" S DR=DR_";7///GI ENDOSCOPIC"
 .. S DIE="^MCAR(697.2,",DA=MCD0
 .. D ^DIE
 .. Q
 . Q
 Q
