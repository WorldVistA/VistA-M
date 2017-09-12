IBY371PR ;ALB/ESG - Pre-Installation for IB patch 371 ;3-May-2006
 ;;2.0;INTEGRATED BILLING;**371**;21-MAR-94;Build 57
 ;
 D DELOF       ; delete all data elements included in build
 D DELXREFS    ; delete a trigger that was added on a previous version of the build
 ;
 Q
 ;
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
INC3508(Y) ; function to determine if entry in IB ERROR file (350.8) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(350.8,Y,0)),U,3)_U
 F LN=2:1 S TAG="ENT3508+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
 ;-----------------------------------------------------------------------
 ; 350.8 entries modified:
 ;    IB137: new error for missing Initial Treatment date
 ;    IB138: new error for missing Patient Condition code
 ;    IB139: new error for missing Acute Manifestation Date
 ;    IB146: 3 payers - MRA secondary claim
 ;    IB147: 3 payers - payer sequence >1
 ;    IB150: Occurrence Code End Date can not be before the start date.
 ;    IB151: Referring provider must have SSN or EIN defined.
 ;    IB152: Operating provider must have SSN or EIN defined.
 ;    IB153: Supervising provider must have SSN or EIN defined.
 ;    IB154: Other provider must have SSN or EIN defined.
 ;    IB155: End dates are required for occurrence spans.
 ;    IB157: One or more Value Codes has no associated Value.
 ;    IB158: One or more of the value codes has an improper format.
 ;    IB205: ICN/DCN required - MRA replacement claim.
 ;    IB206: FL-80 remarks required - MRA replacement claim.
 ;    IB269: Patient address is incomplete. Address Line 1 is required.
 ;    IB270: Patient address is incomplete. City is required.
 ;    IB271: Patient address is incomplete. State is required.
 ;    IB272: Patient address is incomplete. ZIP is required.
 ;    IB273: Primary insurance subscriber's name is missing or invalid
 ;    IB274: Secondary insurance subscriber's name is missing or invalid
 ;    IB275: Tertiary insurance subscriber's name is missing or invalid
 ;    IB276: Primary insurance subscriber's ID number is missing
 ;    IB277: Secondary insurance subscriber's ID number is missing
 ;    IB278: Tertiary insurance subscriber's ID number is missing
 ;    IB279: Primary insurance missing PT. RELATIONSHIP TO INSURED
 ;    IB280: Secondary insurance missing PT. RELATIONSHIP TO INSURED
 ;    IB281: Tertiary insurance missing PT. RELATIONSHIP TO INSURED
 ;    IB282: Primary insurance subscriber's address line 1 is missing
 ;    IB283: Secondary insurance subscriber's address line 1 is missing
 ;    IB284: Tertiary insurance subscriber's address line 1 is missing
 ;    IB285: Primary insurance subscriber's CITY is missing
 ;    IB286: Secondary insurance subscriber's CITY is missing
 ;    IB287: Tertiary insurance subscriber's CITY is missing
 ;    IB288: Primary insurance subscriber's STATE is missing
 ;    IB289: Secondary insurance subscriber's STATE is missing
 ;    IB290: Tertiary insurance subscriber's STATE is missing
 ;    IB291: Primary insurance subscriber's ZIPCODE is missing
 ;    IB292: Secondary insurance subscriber's ZIPCODE is missing
 ;    IB293: Tertiary insurance subscriber's ZIPCODE is missing
 ;
ENT3508 ; entries in file 350.8 to be included
 ;
 ;;^IB137^IB138^IB139^IB146^IB147^IB150^IB151^IB152^IB153^IB154^IB155^IB157^IB158^IB269^
 ;;^IB205^IB206^IB270^IB271^IB272^IB273^IB274^IB275^IB276^IB277^IB278^IB279^IB280^IB281^
 ;;^IB282^IB283^IB284^IB285^IB286^IB287^IB288^IB289^IB290^IB291^IB292^IB293^
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ;     12:  N-VALUE CODES (added internal number as 4th piece of return array)
 ;     20:  N-CMS-1500 PURCH SVC TOTAL - new one for Box 20 and SUB-7
 ;     21:  N-INITIAL TREATMENT - new one for CL1A-2
 ;     22:  N-ACUTE MANIFESTATION - new one for CL1A-8
 ;     29:  N-LAST XRAY - new one for CL1A-3
 ;     34:  N-OTH INSURED ID - updated description
 ;     36:  N-PATIENT CONDITION CODE - new one for CL1A-7
 ;     55:  N-CURR INS FORM LOC 64 - removed blank out for Medicare
 ;    198:  N-ALL INSURANCE NUMBER - removed default of patient SSN
 ;    282:  N-PURCHASED SERVICE TOTAL - bug fix
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^12^20^21^22^29^34^36^55^198^282^
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;      5:  CI2-6
 ;     41:  PT1-15
 ;    107:  OI1-9
 ;    191:  CI3-4
 ;    195:  OI1-12
 ;    196:  CI1-8
 ;    783:  SUB-7
 ;    804:  OI1-13
 ;    806:  OI1-15
 ;    935:  OPR-16
 ;    951:  OPR-17
 ;    958:  INS-14
 ;    977:  PRF-23
 ;    979:  PRF-25
 ;    980:  PRF-27
 ;    981:  PRF-28
 ;   1000:  CI3-10
 ;   1002:  UB1-19
 ;   1004:  CI1-11
 ;   1010:  PRF-26
 ;   1194:  SUB-11
 ;   1315:  CI1-9
 ;   1316:  CI1-7
 ;   1471:  CMS-1500, Box 20 charges
 ;   1472:  CMS-1500, Box 20 blank part
 ;   1800 thru 1899 are allocated for new entries for this patch
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^5^41^107^191^195^196^783^804^806^935^951^958^977^979^980^981^1000^1002^1004^1010^1194^1315^1316^1471^1472^
 ;;^1800^1801^1802^1803^1804^1805^1806^1807^1808^1809^1810^1811^1812^1813^1814^1815^1816^1817^1818^1819^1820^1821^
 ;;^1822^1823^1824^1825^1826^1827^1828^1829^1830^1831^1832^1833^1834^1835^1836^1837^1838^1839^1840^1841^1842^1843^
 ;;^1844^1845^1846^1847^1848^1849^1850^1851^1852^
 ;;
 ;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;      3:  CI2-6
 ;      4:  CI2-6.9
 ;      5:  CI2-8
 ;      7:  CI2-10
 ;     14:  CI2-7
 ;     62:  PT1-15
 ;     88:  PT1-17
 ;    107:  VC1-3
 ;    117:  OI2-3
 ;    125:  OI1-9
 ;    130:  OI1-10 (desc only)
 ;    133:  CI3-4
 ;    135:  CI2-14
 ;    144:  CL1A-2
 ;    186:  CL1A-3
 ;    188:  OI1-12
 ;    195:  CI1-8
 ;    197:  CL1A-7
 ;    198:  CL1A-8
 ;    205:  SUB2-2 
 ;    366:  OI3-6
 ;    368:  OI3-7
 ;    369:  OI3-8
 ;    370:  OI3-9
 ;    371:  OI3-10
 ;    372:  OI3-11
 ;    373:  OI3-12
 ;    391:  SUB-11
 ;    460:  OI5-9
 ;    461:  OI5-10
 ;    462:  OI5-11
 ;    463:  OI5-12
 ;    464:  OI5-13
 ;    465:  OI5-14
 ;    800:  CI2-9
 ;    892:  SUB-7
 ;    900:  OI1-13
 ;    902:  OI1-15
 ;    933:  INS-14
 ;    939:  PRF-23
 ;    941:  PRF-25
 ;    942:  PRF-27
 ;    943:  PRF-28
 ;   1001:  CI3-10
 ;   1003:  UB1-19
 ;   1005:  CI1-11
 ;   1011:  PRF-26
 ;   1015:  GEN-7 - added patch 371
 ;   1026:  OI3-5
 ;   1031:  CI1-9
 ;   1032:  CI1-7
 ;   1038:  OI5-99.9
 ;   1054:  NPI-14
 ;   1055:  NPI-15
 ;   1056:  NPI-16
 ;   1057:  NPI-17
 ;   1170:  CMS-1500, Box 20, Yes
 ;   1171:  CMS-1500, Box 20, Charges
 ;   1172:  CMS-1500, Box 20, Blank part
 ;   1220:  CMS-1500, Box 20, No
 ;   1276:  UB04/FL-8a
 ;   1307:  UB04/FL-14
 ;   1362:  UB04/FL-59A:C
 ;   1457:  UB04/Creation Date
 ;   1500 thru 1599 are allocated for new entries for this patch
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^3^4^5^7^14^62^88^107^117^125^130^133^135^144^186^188^195^197^198^205^366^368^369^370^371^372^373^391^
 ;;^460^461^462^463^464^465^800^892^900^902^933^939^941^942^943^1001^1003^1005^1011^1015^1026^1031^1032^1038^
 ;;^1054^1055^1056^1057^1170^1171^1172^1220^1276^1307^1362^1457^
 ;;^1500^1501^1502^1503^1504^1505^1506^1507^1508^1509^1510^1511^1512^1513^1514^1515^1516^1517^1518^1519^1520^1521^
 ;;^1522^1523^1524^1525^1526^1527^1528^1529^1530^1531^1532^1533^1534^1535^1536^1537^1538^1539^1540^1541^1542^1543^
 ;;^1544^1545^1546^1547^1548^1549^1550^1551^1552^
 ;;
 ;
 ;
 ;-----------------------------------------------------------------------
DEL6 ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;^90^208^969^984^1021^1022^1023^1024^1025^1026^1027^1028^1078^1080^1092^
 ;;
 ;
 ;-----------------------------------------------------------------------
DEL7 ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;^108^361^362^374^
 ;;
 ;
 Q
 ;
DELXREFS ;
 D BMES^XPDUTL("Removing triggers")
 D DELIX^DDMOD(399.047,.01,2)
 D MES^XPDUTL("Done")
 ;
