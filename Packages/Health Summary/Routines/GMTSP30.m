GMTSP30 ;SLC/RMP - GMTS*2.7*30 Post Install                ; 04/19/1999
 ;;2.7;Health Summary;**30**;Apr 19, 1999
 Q
PST ; Post Install Health Summary v 2.7, Pathc 30
EN N DA,X,Y S X=" Reindexing Health Summary Type file, #142"
 W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 N DA,DIC,DIK S DA=$O(^GMT(142,"!"),-1),(DIC,DIK)="^GMT(142,"
 F  S DA=$O(^GMT(142,DA)) Q:DA=""  K:$L(DA)&(+DA=0) ^GMT(142,DA)
 S DA=0 F  S DA=$O(^GMT(142,DA)) Q:+DA=0  D IX1^DIK W "."
 S X=" " W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 Q
