PXRMTAXD ; SLC/PKR - Routines used by taxonomy data dictionary. ;08/18/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;================================================
TAXCOUNT(TAXIEN) ;Count the expanded taxonomy entries and set the 0 node.
 N IEN,NUM
 S (IEN,NUM)=0
 F  S IEN=+$O(^PXD(811.3,IEN)) Q:IEN=0  S NUM=NUM+1
 S $P(^PXD(811.3,0),U,3,4)=TAXIEN_U_NUM
 Q
 ;
 ;================================================
TAXEDIT(TAXIEN,KI) ;Whenever a taxonony item is edited rebuild the expanded
 ;taxonomy. Called from new-style cross-reference on 811.2.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 D DELEXTL^PXRMBXTL(TAXIEN)
 D EXPAND^PXRMBXTL(TAXIEN,KI)
 D TAXCOUNT(TAXIEN)
 Q
 ;
 ;================================================
TAXKILL(TAXIEN) ;Called whenever a taxonony item is killed. Called from new-
 ;style cross-reference on 811.2.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 D DELEXTL^PXRMBXTL(TAXIEN)
 D TAXCOUNT(TAXIEN)
 Q
 ;
