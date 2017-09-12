DENTPS29 ;HIRMFO/NCA - Post Init Routine For Patch 29
 ;;1.2;DENTAL;**29**;JAN 26, 1989
 Q:+$$VERSION^XPDUTL("DENT")'=1.2
 ; Remove Obsolete fields for Dental Patient file #220
 D MES^XPDUTL("Removing Obsolete fields in the Dental Patient file #220...")
 K DA,DIK S DIK="^DD(220,",DA(1)=220 F DA=15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46 D ^DIK
 K DA,DIK
 Q
