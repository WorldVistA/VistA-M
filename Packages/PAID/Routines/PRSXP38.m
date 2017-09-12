PRSXP38 ;WCIOFO/SAB-INIT ROUTINE FOR PATCH PRS*4*38 ;3/4/98
 ;;4.0;PAID;**38**;Sep 21, 1995
 ; This routine can be deleted after patch PRS*4*38 is installed.
 Q
PST ; Post-Init
 N DA,DIK
 D MES^XPDUTL("   Rebuilding the T&L UNIT (#455.5) file 'ASX' x-ref.")
 K ^PRST(455.5,"ASX")
 ; loop thru t&l units
 S DA(1)=0 F  S DA(1)=$O(^PRST(455.5,DA(1))) Q:'DA(1)  D
 . S DIK="^PRST(455.5,"_DA(1)_",""S"","
 . S DIK(1)="1^ASX"
 . D ENALL^DIK ; rebuild xref for all entries in subfile
 D MES^XPDUTL("   Post-Init completed.")
 Q
