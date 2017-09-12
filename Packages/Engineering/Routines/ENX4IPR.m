ENX4IPR ;WIRMFO/DH-PRE-INIT ;7.8.98
 ;;7.0;ENGINEERING;**51**;Aug 17, 1993
 ;  acquire some site specific bar code usage information
 ;  and keep an eye on accession numbers
 N J,K,M
 Q:$$PATCH^XPDUTL("EN*7.0*51")  ;No need to do this more than once
 K ^TMP($J) S M=1
 I $D(^ENG(6914,0)) S ^TMP($J,1,M)=^ENG(6914,0),M=M+1
 I $D(^PRCT(446.4,0)) D
 . S J=0 F  S J=$O(^PRCT(446.4,J)) Q:'J  I $D(^PRCT(446.4,J,2,0)) S ^TMP($J,1,M)=J_U_^PRCT(446.4,J,2,0),M=M+1
 . S J="" F  S J=$O(^PRCT(446.4,"B",J)) Q:J=""  S K=$O(^(J,0)) I K S ^TMP($J,1,M)="B"_U_J_U_K,M=M+1
 I $O(^PRCT(446.4,0,""))]"" S ^TMP($J,1,M)="Top node of ^PRCT(446.4 corrupted."
 I $D(^TMP($J)) D
 . S XMY("HEIBY,D@DOMAIN.EXT")="",XMDUZ=.5
 . S XMSUB="Patch EN*7*51 Status Report",XMTEXT="^TMP($J,1,"
 . D ^XMD
 . K XMY,XMDUZ,XMSUB,XMTEXT
 K ^TMP($J)
 Q
 ;ENX4IPR
