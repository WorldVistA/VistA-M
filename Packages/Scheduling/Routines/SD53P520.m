SD53P520 ;ALB/MJB - SD*5.3*520 POST INIT; Oct 04, 2006 ; 10/23/06 5:40pm  ; 12/28/07 9:29am
         ;;5.3;SCHEDULING;**520**;AUG 13, 1993;Build 26
 Q
POST ;delete inactivated "D" cross reference
 N SDA
 S SDA(1)="",SDA(2)="    SD*5.3*520 Post-Install starting.....",SDA(3)="" D ATADDQ
 N SDA
 S SDA(1)="",SDA(2)=" Deleting cross-reference definition of the Associated Clinic field(.09)"
 S SDA(3)=" in the TEAM POSITION file (# 404.57)"
 D DELIX^DDMOD(404.57,.09,1,"K") D ATADDQ
EN ;Entry point for indexing cross-reference definition for Associated Clinics multiple
 N SDA
 S SDA(1)="",SDA(2)=" indexing cross-reference E - of the Associated Clinics Multiple field(#5)"
 S SDA(3)=" in the TEAM POSITION file (# 404.57)"
 K DA,DIK
 S DA(1)=0
 F  S DA(1)=$O(^SCTM(404.57,DA(1))) Q:'DA(1)  D
 .Q:'$D(^SCTM(404.57,DA(1),5))
 .S DA="",DIK="^SCTM(404.57,"_DA(1)_",5,",DIK(1)=".01^E" D ENALL^DIK D ATADDQ
 N SDA
 S SDA(1)="",SDA(2)="    SD*5.3*520 Post-Install completed.....",SDA(3)="" D ATADDQ
 Q
ATADDQ ;
 D MES^XPDUTL(.SDA) K SDA
 Q
 ;
