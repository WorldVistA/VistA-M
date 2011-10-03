XU8P554 ;O-OIFO/GMB-Check field .07 in file 8989.3 ;3/9/2011
 ;;8.0;KERNEL;**554**;Jul 10, 1995;Build 4
 Q
 ;
POST ; Post-Init
 D BMES^XPDUTL("Beginning Post-Installation...")
 I "^^0^1^"'[(U_$P(^XTV(8989.3,1,0),U,7)_U) S $P(^(0),U,7)=""
 D BMES^XPDUTL("Finished Post-Installation.")
 Q
