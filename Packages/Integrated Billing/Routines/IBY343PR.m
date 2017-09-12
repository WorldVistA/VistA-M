IBY343PR ;PRXM/KJH - Pre-Install for IB patch 343 ;29-JUN-2006
 ;;2.0;INTEGRATED BILLING;**343**;21-MAR-94;Build 16
 ;
 ; Sections of this code were copied from IBY320PR - which was created by ESG for IB patch 320.
 ;
EN ; Standard Entry Point
 D CHECK
 D SAVE
 D DELOF
 D DELPIT
 Q
 ;
CHECK ; Check for bad provider ID type entries related to NPI
 N ERROR,IEN,DA,DIK,Y
 S IEN=$$FIND1^DIC(355.97,,,"NATIONAL PROVIDER ID",,,"ERROR") ; Get IEN for NPI
 I IEN=35 Q  ; NPI found in the correct IEN - OK to continue
 I IEN="",'$D(ERROR) Q  ; Entry does not exist - OK to continue
 I $D(ERROR)!(IEN>29) W !,"Suspected problem with NPI entry found in file 355.97. Contact programmer for assistance." S XPDQUIT=2 Q  ; May have caused other entries to be numbered improperly.
 S DIK="^IBE(355.97,",DA=IEN D ^DIK ; Remove bad entry. Should be IEN=35.
 Q
 ;
SAVE ; Save off data elements for a global node change that occurred between test versions 14 and 15.
 ; These will be restored to their new location during the post-install (after the DD is updated).
 N IBPAR,IBIEN,DA,DIK,DIC,X,Y
 D FIELD^DID(355.93,40,"","GLOBAL SUBSCRIPT LOCATION","IBPAR")
 I '$D(IBPAR) Q  ; First time this patch has been loaded.
 I $P($G(IBPAR("GLOBAL SUBSCRIPT LOCATION")),";")="NPISTATUS" Q  ; Update has already occurred.
 ; Save off the "NPI" nodes for each entry in file 355.93 and kill them.
 K ^TMP("IBY343",$J)
 S IBIEN=0
 F  S IBIEN=$O(^IBA(355.93,IBIEN)) Q:'IBIEN  D
 . M ^TMP("IBY343",$J,IBIEN,"NPI")=^IBA(355.93,IBIEN,"NPI")
 . K ^IBA(355.93,IBIEN,"NPI")
 . Q
 ; Remove the multiple from the DD
 K DA,DIK,DIC
 S DIK="^DD(355.93,",DA=40,DA(1)=355.93 D ^DIK
 ; Remove the DD entries in the multiple
 K DA,DIK,DIC
 S DIK="^DD(355.9301,",DA=.04,DA(1)=355.9301 D ^DIK
 S DIK="^DD(355.9301,",DA=.03,DA(1)=355.9301 D ^DIK
 S DIK="^DD(355.9301,",DA=.02,DA(1)=355.9301 D ^DIK
 S DIK="^DD(355.9301,",DA=.01,DA(1)=355.9301 D ^DIK
 ; Remove the remainder of DD entries in the multiple
 K ^DD(355.9301,0)
 Q
 ;
DELPIT ; Delete included provider ID type entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 S DIK="^IBE(355.97," F LN=2:1 S TAG="PIT+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBE(355.97,DA,0)) D ^DIK
 . Q
DELPITX ;
 Q
 ;
INCPIT(Y) ; Function to determine if provider ID type entry should be included in the build
 ; Y=ien to check in file 355.97
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="PIT+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
INCPITX ;
 Q OK
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
DELOFX ;
 Q
 ;
INCLUDE(FILE,Y) ; Function to determine if output formatter entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to check
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
INCLUDEX ;
 Q OK
 ;
PIT ; provider ID type entries in file 355.97 to be included
 ;
 ;;^35^
 ;;
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^320^321^322^323^
 ;;
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^1323^1324^1325^1326^1327^1328^1329^1330^1331^1332^1333^1334^1335^1336^1337^1338^1339^
 ;;
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^1015^1041^1042^1043^1044^1045^1046^1047^1048^1049^1050^1051^1052^1053^1054^1055^1056^1057^
 ;;
 ;
