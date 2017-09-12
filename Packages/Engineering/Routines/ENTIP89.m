ENTIP89 ;ALB/CXW - EN*7*89 POST INIT
 ;;7.0;ENGINEERING;**89**;Aug 17, 1993;Build 20
 ;;
 ;This post-init routine is to index field #1 of file #6916.3.
START ;
 D BMES^XPDUTL("Indexing ""AOA2"" x-ref in Owner field #1 of file 6916.3")
 N U,DIK S U="^"
 S DIK="^ENG(6916.3,"
 S DIK(1)="1^AOA2"
 D ENALL^DIK
 ;
 D BMES^XPDUTL("Post-init process is complete.")
 Q
