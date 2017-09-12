ENX7IPS ;WIRMFO/DH-PRE-INIT ;8.26.98
 ;;7.0;ENGINEERING;**55**;Aug 17, 1993
 ;  acquire some site specific bar code usage information
 ;  and keep an eye on accession numbers
 N TMP,J,K,M
 S M=1
 I $D(^ENG(6914,0)) S TMP(M,0)=^ENG(6914,0),M=M+1
 I $D(^PRCT(446.4,0)) D
 . S J=0 F  S J=$O(^PRCT(446.4,J)) Q:'J  I $D(^PRCT(446.4,J,2,0)) S TMP(M,0)=J_U_^PRCT(446.4,J,2,0),M=M+1
 . S J="" F  S J=$O(^PRCT(446.4,"B",J)) Q:J=""  S K=$O(^(J,0)) I K S TMP(M,0)="B"_U_J_U_K,M=M+1
 I $O(^PRCT(446.4,0,""))]"" S TMP(M,0)="Top node of ^PRCT(446.4 corrupted."
 I $D(TMP) D
 . N DIFROM
 . S XMY("HEIBY,D@DOMAIN.EXT")="",XMDUZ=.5
 . S XMSUB="Patch EN*7*55 Status Report",XMTEXT="TMP("
 . D ^XMD
 . K XMY,XMDUZ,XMSUB,XMTEXT
 N DA,DIK
 D BMES^XPDUTL("Indexing Equipment file by TYPE OF ENTRY...")
 S DIK="^ENG(6914,",DIK(1)="7^AR"
 D ENALL^DIK
 D BMES^XPDUTL("Setting FUNCTIONAL CLASSIFICATION for BSE...")
 S DA=0 F  S DA=$O(^ENG(6914,"AR","BSE",DA)) Q:'DA  D
 . I "^4^5^"'[(U_$P($G(^ENG(6914,DA,3)),U)_U) S $P(^ENG(6914,DA,9),U,11)="FS"
 Q
 ;ENX7IPS
