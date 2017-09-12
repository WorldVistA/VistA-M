IBY343PO ;PRXM/KJH - Post-Install for IB patch 343 ;28-JUL-2006
 ;;2.0;INTEGRATED BILLING;**343**;21-MAR-94;Build 16
EN ; Standard Entry Point
 D RESTORE
 D INDEX
 D SETPARM
 Q
RESTORE ; Restore data elements for a global node change that occurred between test versions 14 and 15.
 ; These were saved during the pre-install.
 N IBPAR,IBIEN,DA,DIK
 D FIELD^DID(355.93,40,"","GLOBAL SUBSCRIPT LOCATION","IBPAR")
 I $P($G(IBPAR("GLOBAL SUBSCRIPT LOCATION")),";")="NPISTATUS",'$D(^TMP("IBY343",$J)) Q  ; Update has already occurred.
 ; Restore the "NPI" nodes for each entry in file 355.93.
 S IBIEN=0
 F  S IBIEN=$O(^TMP("IBY343",$J,IBIEN)) Q:'IBIEN  D
 . M ^IBA(355.93,IBIEN,"NPISTATUS")=^TMP("IBY343",$J,IBIEN,"NPI")
 . Q
 ; Remove the temporary global.
 K ^TMP("IBY343",$J)
RESTOREX ;
 Q
 ;
INDEX ; Re-index the new "NPISTATUS" x-refs in file 355.93
 N IBIEN,DA,DIK,DIC,X,Y
 I $D(^IBA(355.93,"NPI42")) Q  ; Update has already occurred.
 S IBIEN=0
 F  S IBIEN=$O(^IBA(355.93,IBIEN)) Q:'IBIEN  D
 . S DA(1)=IBIEN,DIK="^IBA(355.93,"_DA(1)_",""NPISTATUS"",",DIK(1)=".03^NPI42^C" D ENALL^DIK
 . Q
INDEXX ;
 Q
 ;
SETPARM ; Set an entry in file 8989.5 (PARAMETERS) for XUSNPI QUALIFIED IDENTIFIER.
 N XUSPCK,XUSPR
 S XUSPCK=$O(^DIC(9.4,"B","KERNEL",0))
 I 'XUSPCK Q
 S XUSPCK=XUSPCK_";DIC(9.4,"
 S XUSPR="Non_VA_Provider_ID;IBA(355.93,"
 D PUT^XPAR(XUSPCK,"XUSNPI QUALIFIED IDENTIFIER",$P(XUSPR,";"),$P(XUSPR,";",2))
SETPARMX ;
 Q
