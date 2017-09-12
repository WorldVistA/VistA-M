NUR20PST ; HCIOFO/MD-Post-Init for Patch 20
 ;;4.0;NURSING SERVICE;**20**;Apr 25, 1997
 D BMES^XPDUTL("Removing old 'SERVICE COMPUTATION DATE' data from the NURS Staff (#210) file....")
 S DA=0 F  S DA=$O(^NURSF(210,DA)) Q:DA'>0  I $D(^NURSF(210,DA,0)) S $P(^(0),U,7)=""
QUIT K DA
 D BMES^XPDUTL("Done")
 Q
 ;
