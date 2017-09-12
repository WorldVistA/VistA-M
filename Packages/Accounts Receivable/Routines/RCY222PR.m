RCY222PR ;ALB/TMK - PRCA*4.5*222 PRE-INSTALL ;04-AUG-2004
 ;;4.5;Accounts Receivable;**222**;Mar 20, 1995
 ;
 D BMES^XPDUTL("Closing all 'in-use' ERA worklist batches")
 N Z,Z0,DA,DIE,DR
 S Z=0 F  S Z=$O(^RCY(344.49,Z)) Q:'Z  I $O(^RCY(344.49,Z,3,0)) S Z0=0 F  S Z0=$O(^RCY(344.49,Z,3,Z0)) Q:'Z0  I $P($G(^(Z0,0)),U,5) S DA(1)=Z,DA=Z0,DR=".05///0",DIE="^RCY("_DA(1)_",3," D ^DIE
 ;
 D COMPLETE
 D END
 Q
 ;
COMPLETE ;
 D BMES^XPDUTL("Step complete.")
 Q
 ;
END ;
 D BMES^XPDUTL("Pre-install complete.")
 Q
 ;
