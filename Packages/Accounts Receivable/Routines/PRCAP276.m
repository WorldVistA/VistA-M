PRCAP276 ;OIFO-BAYPINES/RBN - PRE-INSTALL ROUTINE ;6/6/11 12:29pm
 ;;4.5;Accounts Receivable;**276**;Mar 20, 1995;Build 87
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  icr #1157 Authorizes use of $$DELETE^XPDMENU()
 Q
PR ; Pre-install entry point
 ; Creates KIDS checkpoint with call back
 N OPT,Y
 F OPT="OPT" D
 . S Y=$$NEWCP^XPDUTL(OPT,OPT_"^PRCAP276")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_OPT_" Checkpoint.")
 Q
OPT ; pre-install to remove report from reports menu
 N MENU,OPT
 D BMES^XPDUTL("  Updating Menu...")
 S MENU="RCDPE EDI LOCKBOX REPORTS MENU"
 S OPT=$$DELETE^XPDMENU(MENU,"RCDPE DEPOSIT RECON REPORT")
 ; clear x-refs 'E' and 'G' if they are present
 I $P($G(^RCY(344.4,0)),"^",4)=0 Q
 E  D
 . I $D(^RCY(344.4,"G")) S DIK="^RCY(344.4,",DIK(1)=".04^G" D ENALL2^DIK K DIK ; clear index
 . I $D(^RCY(344.4,"E")) S DIK="^RCY(344.4,",DIK(1)=".17^E" D ENALL2^DIK K DIK
 Q
 ;
POST ; post-install to re-index fields #.04 and #.17 in file #344.4. The
 ; cross-ref 'AC' and 'AD' will be populated only if we find data.
 I $P($G(^RCY(344.4,0)),"^",4)>0 D
 . D BMES^XPDUTL("Indexing fields #.04 and #.17 in ELECTRONIC REMITTANCE ADVICE File #344.4")
 . D WAIT^DICD
 . S DIK="^RCY(344.4,",DIK(1)=".04^AC" D ENALL^DIK K DIK ; new index
 . S DIK="^RCY(344.4,",DIK(1)=".17^AD" D ENALL^DIK K DIK
 . D BMES^XPDUTL("<<< Indexing complete!")
 Q
