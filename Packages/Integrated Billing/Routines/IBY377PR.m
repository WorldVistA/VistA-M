IBY377PR ;ALB/ESG - Pre-Installation for IB patch 377 ;26-Nov-2007
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 D DELOF       ; delete all output formatter data elements included in build
 D DELINS      ; delete inactive patient insurance fields and data
 D DELIX^DDMOD(364.6,.1,1)   ; delete traditional x-ref
 ;
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
 ; re-added later.  These are non-functioning or obsolete entries
 ; in file 364.6.
 S DIK="^IBA(364.6,",TAG="DEL6+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.6,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning or obsolete entries
 ; in file 364.7.
 S DIK="^IBA(364.7,",TAG="DEL7+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.7,DA,0)) D ^DIK
 . Q
 ;
DELOFX ;
 Q
 ;
DELINS ; This procedure will delete 7 inactive fields from the patient insurance subfile (#2.312)
 ; The reason we are doing this is so we can increase the size of the subscriber name field from 30 to 50 chars
 ; and we need to make some room.
 ; Fields deleted:   7  *RENEWAL DATE
 ;                   9  *AGENT'S NAME
 ;                  10  *AGENT'S TELEPHONE NUMBER
 ;                  11  *AGENT'S STREET
 ;                  12  *AGENT'S CITY
 ;                  13  *AGENT'S STATE
 ;                  14  *AGENT'S ZIP CODE
 ; These fields have been inactivated since early 1993, being deleted in 2008.
 ;
 D BMES^XPDUTL("Removing inactive data from the patient insurance file ... ")
 ;
 NEW DFN,CNT,POL,PCE,DIK,DA
 ;
 ; If these fields are already gone, then this process has already been run so get out
 I '$$VFIELD^DILFD(2.312,7),'$$VFIELD^DILFD(2.312,9),'$$VFIELD^DILFD(2.312,11) D MES^XPDUTL("   ... Data and Fields already removed.  No further action.")  G DELINSX
 ;
 D MES^XPDUTL("Each ""."" represents 10,000 patients  ")
 S DFN=0,CNT=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . S CNT=CNT+1 I CNT#10000=0,'$D(ZTQUEUED) W "."
 . S POL=0 F  S POL=$O(^DPT(DFN,.312,POL)) Q:'POL  D
 .. Q:'$D(^DPT(DFN,.312,POL,0))
 .. F PCE=7,9:1:14 S $P(^DPT(DFN,.312,POL,0),U,PCE)=""    ; blank out these 7 pieces
 .. Q
 . Q
 D MES^XPDUTL("   ... Done.")
 ;
 ; now remove the fields from the DD
 D BMES^XPDUTL("Removing inactive fields from the Data Dictionary ... ")
 S DIK="^DD(2.312,"
 S DA(1)=2.312
 F DA=7,9:1:14 D ^DIK
 D MES^XPDUTL("   ... Done.")
 ;
DELINSX ;
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
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^1^3^7^9^11^12^14^15^16^17^18^22^26^27^28^29^30^31^32^33^34^35^36^37^38^39^40^42^43^44^45^46^47^48^49^50^51^
 ;;^52^53^54^55^56^57^58^59^60^61^62^63^64^65^66^67^70^71^72^73^74^75^76^81^82^83^84^85^86^87^88^89^91^92^93^95^
 ;;^96^97^98^99^100^101^102^103^104^105^106^108^109^110^111^112^113^114^115^116^117^118^119^120^121^122^123^124^
 ;;^125^126^127^128^129^130^131^132^133^134^135^136^137^138^165^166^167^168^169^170^171^172^173^174^175^177^178^
 ;;^179^180^181^182^183^185^186^187^188^189^190^192^194^226^227^230^242^479^481^483^488^579^580^581^582^583^610^
 ;;^775^783^784^785^789^790^793^794^795^796^805^808^809^810^811^812^813^814^815^817^818^819^820^821^822^823^825^
 ;;^826^828^829^830^831^832^833^834^835^836^837^838^840^841^842^843^844^845^846^847^848^849^850^851^852^854^855^
 ;;^856^857^858^859^860^861^862^863^864^866^867^868^869^870^871^872^873^874^875^876^877^879^880^881^882^883^891^
 ;;^892^893^894^895^896^897^898^899^900^901^902^903^904^905^906^907^908^909^910^911^912^913^914^915^916^917^918^
 ;;^919^920^921^923^924^936^937^938^939^941^942^943^944^945^946^947^948^949^950^952^956^957^960^961^962^964^965^
 ;;^968^971^972^973^974^975^976^978^982^985^986^987^988^990^991^992^993^994^999^1002^1005^1006^1007^1009^1011^
 ;;^1012^1015^1016^1018^1019^1020^1029^1030^1031^1032^1033^1034^1035^1036^1037^1038^1039^1040^1041^1042^1043^
 ;;^1044^1045^1046^1047^1048^1051^1058^1059^1060^1061^1062^1063^1065^1072^1073^1074^1075^1076^1077^1081^1083^1084^
 ;;^1085^1086^1087^1088^1089^1090^1091^1094^1095^1096^1097^1098^1099^1100^1101^1102^1103^1104^1107^1108^1110^
 ;;^1111^1112^1113^1114^1115^1117^1118^1119^1120^1121^1122^1123^1124^1127^1128^1129^1130^1131^1132^1133^1134^
 ;;^1136^1137^1138^1139^1140^1141^1142^1143^1154^1155^1156^1157^1158^1159^1160^1161^1163^1164^1165^1166^1167^
 ;;^1168^1169^1170^1172^1173^1174^1175^1176^1177^1178^1179^1181^1182^1183^1184^1185^1186^1187^1188^1191^1192^
 ;;^1194^1195^1196^1198^1199^1200^1201^1202^1203^1204^1205^1206^1209^1210^1211^1212^1213^1214^1215^1216^1217^
 ;;^1224^1225^1226^1227^1228^1229^1230^1231^1232^1233^1234^1235^1236^1237^1238^1239^1240^1241^1242^1243^1244^
 ;;^1245^1246^1247^1248^1249^1250^1251^1252^1253^1254^1255^1256^1257^1258^1259^1260^1261^1262^1263^1277^1278^
 ;;^1279^1280^1281^1282^1283^1284^1285^1286^1289^1290^1291^1292^1293^1294^1295^1296^1297^1298^1299^1301^1303^
 ;;^1304^1305^1306^1308^1309^1310^1311^1312^1313^1314^1316^1317^1318^1319^1321^1322^1324^1325^1326^1327^1328^1329^
 ;;^1330^1331^1332^1333^1334^1335^1336^1337^1338^1339^1801^1802^1803^1804^1805^1806^1807^1808^1810^1811^1812^
 ;;^1813^1814^1815^1816^1817^1819^1820^1821^1822^1823^1824^1825^1826^1827^1831^1832^1834^1835^1836^1837^1838^
 ;;^1839^1840^1842^1843^1844^1845^1846^1847^1853^1854^1855^1856^1857^1858^1859^1860^1861^1862^1863^1864^1865^
 ;;^1866^1867^1868^1869^1870^1871^1872^1873^1874^1875^1876^1877^1878^
 ;;
 ;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^1^2^24^114^144^154^186^197^198^326^333^334^358^359^360^481^482^843^1028^1362^1553^1554^1555^
 ;;^1556^1557^1558^1559^1560^1561^1562^1563^1564^
 ;;^1565^1566^1567^1568^1569^1570^1571^1572^1573^1574^1575^1576^1577^1578^
 ;;
 ;
 ;
 ;-----------------------------------------------------------------------
DEL6 ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;^94^154^247^577^578^
 ;;
 ;
 ;-----------------------------------------------------------------------
DEL7 ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;^83^109^238^476^477^
 ;;
 ;
