NURIPST ; HIRMFO/REL-Post-Init for Patch 9 ;3/25/98  09:32
 ;;4.0;NURSING SERVICE;**9**;Apr 25, 1997
 D BMES^XPDUTL("Remove File 213.1")
 S U="^" S DIU="^NURSA(213.1,",DIU(0)="DST" D EN^DIU2
 D BMES^XPDUTL("Recompile NURS-P-STF Template")
 S Y=$O(^DIPT("B","NURS-P-STF",0)) I Y S X="NURSPA",DMAX=5000 D EN2^DIPZ(Y,"",X,DMAX)
 D BMES^XPDUTL("Remove AMON, AQUA, AYR cross-refs from File 213.4")
 F X="AMON","AQUA","AYR" D
 .F K=0:0 S K=$O(^DD(213.4,.01,1,K)) Q:K<1  I $P($G(^(K,0)),"^",2)=X K ^DD(213.4,.01,1,K) Q
 .K ^DD(213.4,0,"IX",X,213.4,.01) K ^NURSA(213.4,X) Q
 D BMES^XPDUTL("Re-index AB cross-ref")
 S DIK="^NURSA(213.4,",DIK(1)=".01^AB" D ENALL^DIK
 D BMES^XPDUTL("Done")
 Q
 ;
