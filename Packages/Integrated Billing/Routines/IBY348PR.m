IBY348PR ;ALB/ESG - Pre-Installation for IB patch 348 ;16-Aug-2006
 ;;2.0;INTEGRATED BILLING;**348**;21-MAR-94;Build 5
 ;
 D FILE353     ; changes to file 353
 D MOVE        ; archive existing 1500 data elements
 D DELTRIG     ; delete some DD triggers (will be re-added)
 D DELOF       ; delete all data elements included in build
 ;
 Q
 ;
FILE353 ; Make the needed changes to the BILL FORM TYPE file (#353)
 ;  -Create an entry for #12 to archive the old hcfa-1500 and edit
 ;  -Repoint any local forms that used to point to #2 to #12 instead
 ;  -Edit some data in the new #2 for cms-1500
 ;
 NEW DIK,DA,DIE,DR,FORM,FORMCNT
 ;
 D BMES^XPDUTL("Updating information in the BILL FORM TYPE file (#353)")
 ;
 ; If #12 is already there, then just quit
 I $D(^IBE(353,12)),$P($G(^IBE(353,12,0)),U,1)="LEGACY HCFA-1500" D BMES^XPDUTL("   Entry# 12 is already defined") G F353X
 ;
 K ^IBE(353,12)
 M ^IBE(353,12)=^IBE(353,2)             ; create entry# 12
 S DIK="^IBE(353,",DA=12 D IX1^DIK      ; reindex #12
 S DIE=353,DA=12                        ; edit #12
 S DR=".01///LEGACY HCFA-1500;2.04///@;2.06///*LEGACY NATIONAL HCFA-1500;2.05///@;2.08///@;2.09///@;.02///@;.03///@;1.01///@"
 D ^DIE
 D BMES^XPDUTL("   Entry# 12 has been created and edited")
 ;
 ; repoint any local forms to the new 12 instead of the old 2
 ; count total number of forms too
 S FORM=0,FORMCNT=0
 F  S FORM=$O(^IBE(353,FORM)) Q:'FORM  D
 . N B S B=$G(^IBE(353,FORM,2))
 . S FORMCNT=FORMCNT+1
 . I $P(B,U,4) Q    ; quit if national form type
 . I $P(B,U,5)=2 S DIE=353,DA=FORM,DR="2.05////12" D ^DIE   ; parent form
 . I $P(B,U,8)=2 S DIE=353,DA=FORM,DR="2.08////12" D ^DIE   ; print form name
 . Q
 D BMES^XPDUTL("   Local forms/overrides for the old 1500 have been removed and repointed")
 ;
 S $P(^IBE(353,0),U,4)=FORMCNT     ; re-set 0 node
 ;
 ; edit the data for entry# 2 so it becomes the new cms-1500
 S DIE=353,DA=2
 S DR=".01///CMS-1500;2.04////1;2.06///NATIONAL CMS-1500;2.05///@;2.08////2;2.09///@"   ; note screen 9 is being deleted also
 D ^DIE
 D BMES^XPDUTL("   Entry# 2 has become the new 1500")
 ;
F353X ;
 Q
 ;
MOVE ; move existing output formatter entries for form type 2 to form type 12
 NEW IEN,DIE,DA,DR
 D BMES^XPDUTL("Archiving output formatter entries for the old 1500 form")
 I $O(^IBA(364.6,"B",2,0))=1400 D BMES^XPDUTL("   Already archived") G MOVEX
 ;
 I '$D(^IBE(353,12)) D BMES^XPDUTL("   Error - entry# 12 not defined...call EVS") G MOVEX
 ;
 S IEN=0
 F  S IEN=$O(^IBA(364.6,"B",2,IEN)) Q:'IEN  D
 . I IEN'<1400 Q    ; do not move the new data elements
 . S DIE=364.6,DA=IEN,DR=".01////12"
 . D ^DIE
 . Q
 D BMES^XPDUTL("   Completed")
MOVEX ;
 Q
 ;
DELTRIG ; remove some triggers from ^DD(FILE,FIELD,1)
 ; these will be re-added when the build is installed
 D BMES^XPDUTL("Removing DD triggers....")
 D DELIX^DDMOD(36,.01,2)
 D DELIX^DDMOD(399,.01,7)
 D DELIX^DDMOD(399,.19,1)
 D BMES^XPDUTL("   Completed")
DELTRIGX ;
 Q
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;
 ;
INCLUDE(FILE,Y) ; function to determine if output formatter entry should be
 ; included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
INCLUDEX ;
 Q OK
 ;
 ;
 ; 364.5 entries modified:  
 ;     159 Fix to N-AUTO ACCIDENT STATE
 ;     188 New data element for box 24I - rend prov ID qual
 ;     189 New data element for box 24J - rend prov ID and NPI
 ;     229 n-hcfa emergency ind column 24C (Moved from 24I to 24C)
 ;     302 (SUB-7) New data element to re-enable SUB-7
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^159^188^189^229^302^
 ;;
 ;
 ; 364.6 IENS:  783 (SUB-7) turn field on
 ;              975 (PRF-22) Box 24K data - no longer being used
 ;              1002 (UB1-19) field name
 ;              1006 (PRF-30) Svc line comment - length and qualifier
 ;              1400-1520 (range for new form)
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^783^975^1002^1006^
 ;;^1400^1401^1402^1403^1404^1405^1406^1407^1408^1409^1410^1411^1412^1413^1414^1415^1416^1417^1418^1419^1420^
 ;;^1421^1422^1423^1424^1425^1426^1427^1428^1429^1430^1431^1432^1433^1434^1435^1436^1437^1438^1439^1440^1441^1442^1443^
 ;;^1444^1445^1446^1447^1448^1449^1450^1451^1452^1453^1454^1455^1456^1457^1458^1459^1460^1461^1462^1463^1464^1465^1466^
 ;;^1467^1468^1469^1470^1471^1472^1473^1474^1475^1476^1477^1478^1479^1480^1481^1482^1483^1484^1485^1486^1487^1488^1489^
 ;;^1490^1491^1492^1493^1494^1495^1496^1497^1498^1499^1500^1501^1502^1503^1506^1507^1508^1509^1510^1511^1512^1513^1514^
 ;;^1515^1516^1517^1518^1519^1520^
 ;;
 ;
 ;
 ; 364.7 IENS:   53 (OPR-6)  remove reference to field 214
 ;               95 (CL1-31) Accident State (fix bug)
 ;              889 (PRF-19) removed data element pointing to #229
 ;              892 (SUB-7)  turn field on
 ;              916 (OPR-7)  remove reference to field 214
 ;              919 (OPR-8)  remove reference to field 214
 ;              949 (SUB-10) help text
 ;              953 (PRF-22) Box 24K data - no longer being used
 ;             1007 (PRF-30) Svc line comment - length and qualifier
 ;             1023 (OP7-2)  help text
 ;        1100-1220 (range for new form)
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^53^95^889^892^916^919^949^953^1007^1023^
 ;;^1100^1101^1102^1103^1104^1105^1106^1107^1108^1109^1110^1111^1112^1113^1114^1115^1116^1117^1118^1119^
 ;;^1120^1121^1122^1123^1124^1125^1126^1127^1128^1129^1130^1131^1132^1133^1134^1135^1136^1137^1138^1139^1140^1141^1142^
 ;;^1143^1144^1145^1146^1147^1148^1149^1150^1151^1152^1153^1154^1155^1156^1157^1158^1159^1160^1161^1162^1163^1164^1165^
 ;;^1166^1167^1168^1169^1170^1171^1172^1173^1174^1175^1176^1177^1178^1179^1180^1181^1182^1183^1184^1185^1186^1187^1188^
 ;;^1189^1190^1191^1192^1193^1194^1195^1196^1197^1198^1199^1200^1201^1202^1203^1206^1207^1208^1209^1210^1211^1212^1213^
 ;;^1214^1215^1216^1217^1218^1219^1220^
 ;;
 ;
 ;
