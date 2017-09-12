IBY349PR ;ALB/ESG - Pre-Installation for IB patch 349 ;3-Nov-2006
 ;;2.0;INTEGRATED BILLING;**349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 D FILE353     ; changes to file 353 for the UB-04
 D MOVE        ; archive existing UB-92 data elements
 D DELTRIG     ; delete some DD triggers (will be re-added)
 D DELOF       ; delete all data elements included in build
 ;
 Q
 ;
FILE353 ; Make the needed changes to the BILL FORM TYPE file (#353)
 ;  -Create an entry for #13 to archive the old UB-92 and edit
 ;  -Repoint any local forms that used to point to #3 to #13 instead
 ;  -Edit some data in the new #3 for UB-04
 ;
 NEW DIK,DA,DIE,DR,FORM,FORMCNT
 ;
 D BMES^XPDUTL("Updating information in the BILL FORM TYPE file (#353)")
 ;
 ; If #13 is already there, then just quit
 I $D(^IBE(353,13)),$P($G(^IBE(353,13,0)),U,1)="LEGACY UB-92" D BMES^XPDUTL("   Entry# 13 is already defined") G F353X
 ;
 K ^IBE(353,13)
 M ^IBE(353,13)=^IBE(353,3)             ; create entry# 13
 S DIK="^IBE(353,",DA=13 D IX1^DIK      ; reindex #13
 S DIE=353,DA=13                        ; edit #13
 S DR=".01///LEGACY UB-92;2.04///@;2.06///*LEGACY NATIONAL UB-92;2.05///@;2.08///@;2.09///@;.02///@;.03///@;1.01///@"
 D ^DIE
 D BMES^XPDUTL("   Entry# 13 has been created and edited")
 ;
 ; repoint any local forms to the new 13 instead of the old 3
 ; count total number of forms too
 S FORM=0,FORMCNT=0
 F  S FORM=$O(^IBE(353,FORM)) Q:'FORM  D
 . N B S B=$G(^IBE(353,FORM,2))
 . S FORMCNT=FORMCNT+1
 . I $P(B,U,4) Q    ; quit if national form type
 . I $P(B,U,5)=3 S DIE=353,DA=FORM,DR="2.05////13" D ^DIE   ; parent form
 . I $P(B,U,8)=3 S DIE=353,DA=FORM,DR="2.08////13" D ^DIE   ; print form name
 . Q
 D BMES^XPDUTL("   Local forms/overrides for the old UB-92 have been removed and repointed")
 ;
 S $P(^IBE(353,0),U,4)=FORMCNT     ; re-set 0 node
 ;
 ; edit the data for entry# 3 so it becomes the new UB-04
 S DIE=353,DA=3
 S DR=".01///UB-04;2.04////1;2.06///NATIONAL UB-04;2.05///@;2.08////3;2.09///@"   ; note screen 9 is being deleted also
 D ^DIE
 D BMES^XPDUTL("   Entry# 3 has become the new UB-04")
 ;
F353X ;
 Q
 ;
MOVE ; move existing output formatter entries for form type 3 to form type 13
 NEW IEN,DIE,DA,DR
 D BMES^XPDUTL("Archiving output formatter entries for the old UB-92 form")
 I $O(^IBA(364.6,"B",3,0))=1550 D BMES^XPDUTL("   Already archived") G MOVEX
 ;
 I '$D(^IBE(353,13)) D BMES^XPDUTL("   Error - entry# 13 not defined...call EVS") G MOVEX
 ;
 S IEN=0
 F  S IEN=$O(^IBA(364.6,"B",3,IEN)) Q:'IEN  D
 . I IEN'<1550 Q    ; do not move the new data elements
 . S DIE=364.6,DA=IEN,DR=".01////13"
 . D ^DIE
 . Q
 D BMES^XPDUTL("   Completed")
MOVEX ;
 Q
  ;
DELTRIG ; remove some triggers from ^DD(FILE,FIELD,1)
 ; these will be re-added when the build is installed
 D BMES^XPDUTL("Removing DD triggers....")
 D DELIX^DDMOD(399,.04,1)
 D DELIX^DDMOD(399,.05,2)
 D DELIX^DDMOD(399,.06,1)
 D DELIX^DDMOD(399,.26,1)
 D DELIX^DDMOD(399,.02,2)
 D BMES^XPDUTL("   Completed")
DELTRIGX ;
 Q
 ;
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning entries in file 364.6.
 S DIK="^IBA(364.6,",TAG="DEL6+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.6,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning entries in file 364.7.
 S DIK="^IBA(364.7,",TAG="DEL7+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.7,DA,0)) D ^DIK
 . Q
 ;
DELOFX ;
 Q
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
 ;         8 - N-UB-04 SERVICE LINE (EDI)
 ;        14 - N-UB92 FORM LOCATOR 57
 ;        15 - N-UB92 FORM LOCATOR 31
 ;        16 - N-UB-04 PROCEDURES
 ;        53 - N-UB92 FORM LOCATOR 78
 ;        55 - N-CURR INS FORM LOC 64
 ;        56 - N-OTH INS FORM LOC 64
 ;        85 - N-ADMITTING DIAGNOSIS
 ;       142 - N-PRINT BILL SUBMIT STATUS - description edit
 ;       186 - N-UB92 FORM LOCATOR 11
 ;       187 - N-PATIENT SHORT ADDRESS
 ;       191 - N-UB-04 FORM LOCATOR 64
 ;       193 - N-UB-04 SERVICE LINE (PRINT)
 ;       221 - N-UB-04 TIMEFRAME OF BILL
 ;       222 - N-UB-04 LOCATION OF CARE
 ;       223 - N-UB-04 BILL CLASSIFICATION
 ;       246 - N-UB-04 FORM LOCATOR 64B
 ;       247 - N-UB-04 FORM LOCATOR 64C
 ;       253 - N-DIAGNOSIS E-CODE
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^8^14^15^16^53^55^56^85^142^186^187^191^193^221^222^223^246^247^253^
 ;;
 ;
 ; 364.6 entries modified:
 ;     111  OI1-10
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^111^
 ;;^1550^1551^1552^1553^1554^1555^1556^1557^1558^1559^1560^1561^1562^1563^1564^1565^1566^1567^1568^1569^1570^1571^
 ;;^1572^1573^1574^1575^1576^1577^1578^1579^1580^1581^1582^1583^1584^1585^1586^1587^1588^1589^1590^1591^1592^1593^
 ;;^1594^1595^1596^1597^1598^1599^1600^1601^1602^1603^1604^1605^1606^1607^1608^1609^1610^1611^1612^1613^1614^1615^
 ;;^1616^1617^1618^1619^1620^1621^1622^1623^1624^1625^1626^1627^1628^1629^1630^1631^1632^1633^1634^1635^1636^1637^
 ;;^1638^1639^1640^1641^1642^1643^1644^1645^1646^1647^1648^1649^1650^1651^1652^1653^1654^1655^1656^1657^1658^1659^
 ;;^1660^1661^1662^1663^1664^1665^1666^1667^1668^1669^1670^1671^1672^1673^1674^1675^1676^1677^1678^1679^1680^1681^
 ;;^1682^1683^1684^1685^1686^1687^1688^1689^1690^1691^1692^1693^1694^1695^1696^1697^1698^1699^1700^1701^1702^1703^
 ;;^1704^1705^1706^1707^1708^1709^1710^1711^1712^1713^1714^1715^1716^1717^1718^1719^1720^1721^1722^1723^
 ;;^1727^1728^1729^1730^1731^1732^1733^1734^1735^1736^1737^1738^1739^1740^1741^1742^1743^1744^1745^1746^1747^
 ;;^1748^1749^1750^1751^1752^1753^1754^1755^1756^1757^1758^1759^
 ;;
 ;
 ;
 ; 364.7 entries modified:
 ;     130  OI1-10
 ;     787  (old UB-92)  - multiple page check (just in case)
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^130^787^
 ;;^1250^1251^1252^1253^1254^1255^1256^1257^1258^1259^1260^1261^1262^1263^1264^1265^1266^1267^1268^1269^1270^1271^
 ;;^1272^1273^1274^1275^1276^1277^1278^1279^1280^1281^1282^1283^1284^1285^1286^1287^1288^1289^1290^1291^1292^1293^
 ;;^1294^1295^1296^1297^1298^1299^1300^1301^1302^1303^1304^1305^1306^1307^1308^1309^1310^1311^1312^1313^1314^1315^
 ;;^1316^1317^1318^1319^1320^1321^1322^1323^1324^1325^1326^1327^1328^1329^1330^1331^1332^1333^1334^1335^1336^1337^
 ;;^1338^1339^1340^1341^1342^1343^1344^1345^1346^1347^1348^1349^1350^1351^1352^1353^1354^1355^1356^1357^1358^1359^
 ;;^1360^1361^1362^1363^1364^1365^1366^1367^1368^1369^1370^1371^1372^1373^1374^1375^1376^1377^1378^1379^1380^1381^
 ;;^1382^1383^1384^1385^1386^1387^1388^1389^1390^1391^1392^1393^1394^1395^1396^1397^1398^1399^1400^1401^1402^1403^
 ;;^1404^1405^1406^1407^1408^1409^1410^1411^1412^1413^1414^1415^1416^1417^1418^1419^1420^1421^1422^1423^
 ;;^1427^1428^1429^1430^1431^1432^1433^1434^1435^1436^1437^1438^1439^1440^1441^1442^1443^1444^1445^1446^1447^
 ;;^1448^1449^1450^1451^1452^1453^1454^1455^1456^1457^1458^1459^
 ;;
 ;
 ;
DEL6 ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;^77^78^79^80^925^926^927^928^929^930^931^932^933^934^
 ;;
 ;
DEL7 ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;^32^33^34^35^904^905^906^907^908^909^910^911^912^913^
 ;;
 ;
 Q
 ;
