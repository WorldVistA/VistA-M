ONCPST56 ;Hines OIFO/RVD,RTK - POST-INSTALL ROUTINE FOR PATCH ONC*2.11*56 ;06/04/12
 ;;2.11;ONCOLOGY;**56**;Mar 07, 1995;Build 10
 ;
 ;Set url to DC server.
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1757/cgi_bin/oncsrv.exe")
 D ZIP,SD160,SD695,TCODES
 Q
ZIP ;Add 85083 zip code.  [PATCH DESCRIPTION ITEM #13]
 K DD,DO,DIC
 I $D(^VIC(5.11,"B","85083 ")) D BMES^XPDUTL("Zip code 85083 is already in file #5.11...") Q
 D BMES^XPDUTL("Adding zip code 85083 ...")
 S DIC="^VIC(5.11,"
 S DIC(0)="L"
 S DIC("DR")="1///PHOENIX;2///285;3///4",X="85083" D FILE^DICN
 D BMES^XPDUTL("Done adding zip code 85083!!!")
 K DD,D0,DIC
 Q
 ;
SD160 ;Add Schema Discriminator for STOMACH (67160) in file #164
 ; [PATCH DESCRIPTION ITEM #16]
 I $D(^ONCO(164,67160,14,"B",982)) Q
 K DIC,DO S DA(1)=67160,DIC="^ONCO(164,"_DA(1)_",14,"
 S DIC(0)="L",X=982
 D FILE^DICN
 K DIC,DO S DA(1)=67160,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="982  Primary site coded to C16.0"
 D FILE^DICN
 K DIC,DO S DA(1)=67160,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="     May include cases which were converted to this code from a blank"
 D FILE^DICN K DIC,DO
 D BMES^XPDUTL("Schema Discriminator added for STOMACH, CARDIA (C16.0) Topography...")
 Q
SD695 ;Update Schema Discriminator for LACRIMAL (67695) in file #164
 ; [PATCH DESCRIPTION ITEM #17]
 I $D(^ONCO(164,67695,14,"B","015")) Q
 ; first add the 2 new codes
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",14,"
 S DIC(0)="L",X="015"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",14,"
 S DIC(0)="L",X="025"
 D FILE^DICN
 ; next update the help - delete old help and add new help
 K ^ONCO(164,67695,15)
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="Schema Discriminator: Lacrimal Gland/Lacrimal Sac"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X=" "
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="OBSOLETE DATA REVIEWED AND CHANGED V0203"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="See codes 015,025"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="010  Lacrimal gland"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="     Lacrimal duct, NOS"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="       Nasal lacrimal duct"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="       Nasolacrimal duct"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="     Lacrimal, NOS"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X=" "
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="015  Lacrimal gland"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="     Lacrimal, NOS"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X=" "
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="OBSOLETE DATA CONVERTED V0203"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="See code 025"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="020  Lacrimal sac "
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X=" "
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="025  Lacrimal sac"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="     Lacrimal duct, NOS"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="       Nasal lacrimal duct"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="       Nasolacrimal duct"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X=" "
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="100  OBSOLETE DATA RETAINED V0200"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="     C69.5- originally coded in CSv1 and"
 D FILE^DICN
 K DIC,DO S DA(1)=67695,DIC="^ONCO(164,"_DA(1)_",15,"
 S DIC(0)="L"
 S X="       case diagnosed before 1/1/2010"
 D FILE^DICN K DIC,DO
 D BMES^XPDUTL("Schema Discriminator updated for LACRIMAL GLAND (C69.5) Topography...")
 Q
TCODES ;Update the 7th Edition T Codes (Clin & Path) for Mycosis Fungoides
 ; in entry #55 of file #164.33 [fields 16 & 17]
 ; [PATCH DESCRIPTION ITEM #20]
 ; First delete codes T1A, T1B, T2A, T2B and TX if they exist
T1A I '$D(^ONCO(164.33,55,"T7","B","1A")) G T1B
 S DA(1)=55,DIK="^ONCO(164.33,"_DA(1)_",""T7"","
 S DA=$O(^ONCO(164.33,55,"T7","B","1A","")) D ^DIK
T1B I '$D(^ONCO(164.33,55,"T7","B","1B")) G T2A
 S DA(1)=55,DIK="^ONCO(164.33,"_DA(1)_",""T7"","
 S DA=$O(^ONCO(164.33,55,"T7","B","1B","")) D ^DIK
T2A I '$D(^ONCO(164.33,55,"T7","B","2A")) G T2B
 S DA(1)=55,DIK="^ONCO(164.33,"_DA(1)_",""T7"","
 S DA=$O(^ONCO(164.33,55,"T7","B","2A","")) D ^DIK
T2B I '$D(^ONCO(164.33,55,"T7","B","2B")) G TX
 S DA(1)=55,DIK="^ONCO(164.33,"_DA(1)_",""T7"","
 S DA=$O(^ONCO(164.33,55,"T7","B","2B","")) D ^DIK
TX I '$D(^ONCO(164.33,55,"T7","B","X")) G X7
 S DA(1)=55,DIK="^ONCO(164.33,"_DA(1)_",""T7"","
 S DA=$O(^ONCO(164.33,55,"T7","B","X","")) D ^DIK
 ;
 ; next update the help - delete old help and add new help
X7 K ^ONCO(164.33,55,7)
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="Primary Tumor (T) Skin"
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X=" "
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="T1  Limited patches, papules, and/or plaques covering <10% of the skin surface"
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="    **per ISCL/EORTC: 'May further stratify into T1a (patch only) vs T1b"
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="    (plaque ± patch)'. The T1a & T1b values are not part of the AJCC algorithm."
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="T2  Patches, papules or plaques covering 10% of the skin surface."
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="    **per ISCL/EORTC: 'May further stratify into T1a (patch only) vs T1b"
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="    (plaque ± patch)'. The T2a & T2b values are not part of the AJCC algorithm."
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="T3  One or more tumors (1-cm diameter)"
 D FILE^DICN
 K DIC,DO S DA(1)=55,DIC="^ONCO(164.33,"_DA(1)_",7,"
 S DIC(0)="L"
 S X="T4  Confluence of erythema covering 80% body surface area"
 D FILE^DICN
 ;
 D BMES^XPDUTL("Updated the 7th Edition T-Codes for Mycosis Fungoides...")
 Q
