IBY547PR ;ALB/WCJ - Pre-Installation for IB patch 547 ; 1/7/16 4:33pm
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF,RATETYPE,RFIINTAD
 Q
 ;
RATETYPE ;Update all active rate types to be transmittable electronically
 ;FILE 399.3 field .1
 ;
 N IBIEN,DA,DR,DIE
 S IBIEN=0
 F  S IBIEN=$O(^DGCR(399.3,IBIEN)) Q:'IBIEN  D
 . I '$$GET1^DIQ(399.3,IBIEN_",",.03) D
 .. S DIE=399.3,DR=".1///1",DA=IBIEN
 .. D ^DIE
 K DIE,DR,DA
 Q
 ;
RFIINTAD ;Add necessary entries for the IB RFI HL7 interface.
 I '$O(^HL(771.5,"B",2.6,0)) D
 .N DIC,X,DIK,DA,DIE,DR,Y,DTOUT,DUOUT
 .D MES^XPDUTL("Adding entrie(s) to the HL7 VERSION file (#771.5)")
 .K DO
 .S DIC="^HL(771.5,",DIC(0)="",X=2.6
 .S DIC("DR")="2////"_$$FIND1^DIC(771.8,,,"HEALTH LEVEL SEVEN")
 .D FILE^DICN
 .K DIC,DIE,DR,DTOUT,DUOUT,X,DIK
 .D MES^XPDUTL("........'Version 2.6' added.")
 ;
 I '$O(^HL(771.2,"B","EHC",0)) D
 .N DIC,X,DIK,DA,DIE,DR,Y,DTOUT,DUOUT
 .D MES^XPDUTL("Adding entrie(s) to the HL7 Message Type file (#771.2)")
 .K DO
 .S DIC="^HL(771.2,",DIC(0)="",X="EHC"
 .S DIC("DR")="2////Health Care Invoice"
 .D FILE^DICN                                ;Supported by DBIA 2162
 .S DIK="^HL(771.2,",DA=+Y D IX1^DIK         ;Supported by DBIA 2162
 .K DIE,DR,DTOUT,DUOUT,X,DIK
 .;
 .K DO
 .S DA(1)=+Y,DIC=DIC_DA(1)_","_"""V"""_",",DIC(0)="L"
 .S X=$$FIND1^DIC(771.5,,,2.6)               ;Lookup IEN for 2.6
 .D FILE^DICN                                ;Supported by DBIA 2162
 .K DIC,DA,DIE,DR,Y,DTOUT,DUOUT,DIC,X
 .D MES^XPDUTL("........'EHC-Health Care Invoice' added.")
 ;
 I '$O(^HL(779.001,"B","E12",0)) D
 .N D0,DIC,X,DIK,DA,DIE,DR,DTOUT,DUOUT,Y
 .D MES^XPDUTL("Adding entrie(s) to the HL7 Event Type Code file (#779.001)")
 .K D0
 .S DIC="^HL(779.001,",DIC(0)="",X="E12"
 .S DIC("DR")="2////Request Additional Information"
 .D FILE^DICN
 .S DIK="^HL(779.001,",DA=+Y D IX1^DIK
 .K DA,DIE,DR,DTOUT,DUOUT,X,DIK
 .;
 .K D0
 .S DA(1)=+Y,DIC=DIC_DA(1)_",1,",DIC(0)="L"
 .S X=$$FIND1^DIC(771.5,,,2.6)               ;Lookup IEN for 2.6
 .D FILE^DICN
 .S DIK="^HL(779.001,",DA=+Y D IX1^DIK
 .K DIC,DA,DIE,DR,DTOUT,DUOUT,DIC,X,DIK,Y
 .D MES^XPDUTL("........'E12-Request Additional Information' added.")
 ;
 I '$O(^HL(779.005,"B","EHC_E12",0)) D
 .N D0,DIC,X,DIK,DA,DIE,DR,DTOUT,DUOUT,Y
 .D MES^XPDUTL("Adding entrie(s) to the HL7 MESSAGE STRUCTURE CODE file (#779.005)")
 .K D0
 .S DIC="^HL(779.005,",DIC(0)="",X="EHC_E12"
 .S DIC("DR")="2////E12"
 .D FILE^DICN
 .K DIE,DR,DTOUT,DUOUT,X,DIK
 .;
 .K D0
 .S DA(1)=+Y,DIC=DIC_DA(1)_",1,",DIC(0)="L"
 .S X=$$FIND1^DIC(771.5,,,2.6)               ;Lookup IEN for 2.6
 .D FILE^DICN
 .K DIC,DA,DIE,DR,DTOUT,DUOUT,X,DIK
 .D MES^XPDUTL("........'EHC_E12' added.")
 ;
 ;Add interface user to file 200.  Supported by IA#4677.
 N IEN200
 D MES^XPDUTL("Adding entrie(s) to the New Person file (#200)")
 S IEN200=$$CREATE^XUSAP("INTERFACE,IB RFI","")
 I +IEN200=0 D MES^XPDUTL("........'Interface,IB RFI' already exists.")
 I +IEN200>0 D MES^XPDUTL("........'Interface,IB RFI' added.")
 I IEN200<0 D MES^XPDUTL("........'ERROR: Interface,IB RFI' NOT added.")
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
 Q OK
 ;
 ;Delete edited entries to insure clean install of new entries
 ;Delete obsolete entries.
DELOF   ; Delete included OF entries
 NEW FILE,DIK,LN,TAG,TAGLN,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," D
 . F TAG="ENT"_FILE,"DEL"_FILE D
 .. F LN=2:1 S TAGLN=TAG_"+"_LN,DATA=$P($T(@TAGLN),";;",2) Q:DATA=""  D
 ... F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 Q
 ;
 ; Example for ENT5, ENT6, ENT7, DEL5, DEL6, and DEL7:
 ;;^195^254^259^269^324^325^
 ; Note:  Must have beginning and ending up-carat
 ;
 ; 364.5 entries modified:
 ;
ENT5 ; OF entries in file 364.5 to be included
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;    1 - CI2.2
 ;    3 - PRV.11
 ;    6 - CI2A.2.9
 ;    7 - CI2A.5
 ;    9 - CI2A.7
 ;   10 - CI2.6.9
 ;   11 - CI2.8
 ;   12 - CI2A.8
 ;   13 - CI3A.1.9
 ;   16 - CI2.7
 ;   17 - CI2A.3
 ;   18 - CI3A.2
 ;   22 - CI2.4
 ;   26 - CI2.3
 ;   29 - PT1.3
 ;   37 - PT1.11
 ;   41 - PT1.15
 ;   43 - PT2.2
 ;   59 - CL1.19
 ;   65 - CI2.4
 ;   66 - CL1.26
 ;   67 - CL1.27
 ;   96 - OI1.6
 ;   98 - OI1.4
 ;   99 - OI2.3
 ;  100 - OI1.5
 ;  101 - OI2.4
 ;  102 - OI2.5
 ;  106 - OI1A.3
 ;  109 - OI2.8
 ;  110 - OI2.9
 ;  117 - PRF.8
 ;  127 - INS.6
 ;  132 - INS.11
 ;  136 - RX1.5
 ;  146 - CI3A.99.9
 ;  155 - OI1A.99.9
 ;  174 - SUB.6
 ;  177 - PRV.3
 ;  189 - CI3.2
 ;  190 - CI3.3
 ;  195 - OI1A.4
 ;  196 - CI1.8
 ;  581 - RX1.9
 ;  784 - CL1.34
 ;  785 - CL1.35
 ;  789 - CI2A.6
 ;  794 - CI3A.3
 ;  804 - OI1A.5
 ;  805 - OI1.7
 ;  806 - OI1A.8
 ;  809 - COB1.3
 ;  810 - COB1.4
 ;  811 - COB1.5
 ;  812 - COB1.6
 ;  939 - OPR.12
 ;  944 - OPR.5
 ;  952 - CL1.36
 ;  956 - OI1A.9
 ;  957 - CI3A.4
 ;  968 - PRV.10
 ;  971 - SUB.9
 ;  980 - PRF.27
 ;  981 - PRF.28
 ;  988 - OI2.10
 ;  999 - CI3A.6
 ; 1000 - CI3A.5
 ; 1004 - CI1.11
 ; 1005 - OI1.8
 ; 1010 - PRF.26
 ; 1016 - CI2.6
 ; 1029 - PT1.17
 ; 1030 - PT1.18
 ; 1034 - CL1A.4
 ; 1043 - SUB2.4
 ; 1065 - OI1.9
 ; 1194 - SUB.11
 ; 1289 - OI5.4
 ; 1290 - OI5.5
 ; 1315 - CI1.9
 ; 1316 - CI1.7
 ; 1317 - CI1.13
 ; 1802 - CI6.3
 ; 1804 - CI6.5
 ; 1861 - PRV-2
 ; 1862 - UB1.5
 ; 1863 - UB1.6
 ; 1864 - UB1.7
 ; 1865 - UB1.8
 ; 1866 - UB1.9
 ; 1867 - UB1.10
 ; 1868 - UB1.11
 ; 1869 - UB1.12
 ; 1870 - UB1.13
 ; 1871 - UB1.14
 ; 1872 - UB1.15
 ; 1873 - UB1.16
 ; 1874 - UB1.17
 ; 1875 - UB1.18
 ; 1876 - OPR1.13
 ; 1913 - CL1A.14
 ; 1927 - PRV1.4
 ; 1928 - PRV1.5
 ; 1929 - PRV1.6
 ; 1930 - PRV1.7
 ; 1931 - PRV1.8
 ; 1966 - CI3A.7
 ; 1967 - CI3A.8
 ; 1968 - CI3A.9
 ; 2059 - LDAT.9
 ; 2060 - LDAT.10
 ; 2204 - OI1A.6
 ; 2205 - OI1A.7
 ; 2253 - CI2A.1
 ; 2254 - CI2A.2
 ; 2255 - CI3A.1
 ; 2256 - OI1A.1
 ; 2257 - OI1A.2
 ;
ENT6 ; O.F. entries in file 364.6 to be included
 ;
 ;;^1^3^6^7^9^10^11^12^13^16^17^18^22^26^29^37^41^43^59^65^66^67^
 ;;^96^98^99^100^101^102^106^109^110^117^127^132^136^146^155^174^177^
 ;;^189^190^195^196^581^784^785^789^794^804^805^806^809^810^
 ;;^811^812^939^944^952^956^957^968^971^980^981^988^999^1000^
 ;;^1004^1005^1010^1016^1029^1030^1034^1043^1065^1194^1289^
 ;;^1290^1315^1316^1317^1802^1804^1861^1862^1863^1864^1865^
 ;;^1866^1867^1868^1869^1870^1871^1872^1873^1874^1875^1876^
 ;;^1927^1928^1929^1930^1931^1966^1967^1968^2059^2060^2204^2205^2253^
 ;;^2254^2255^2256^2257^
 ;
 ;-----------------------------------------------------------------------
 ;
 ;   27 - DC1.2
 ;   28 - CL1-16
 ;   37 - PC1.1.9
 ;   77 - CL1.14
 ;   98 - CL1.13.9
 ;  100 - CL1.15.9
 ;  809 - COB1.3
 ; 1015 - GEN.7
 ; 1579 - DC1.4
 ; 1627 - PRV1.4
 ; 1951 - CI2A.1
 ; 1952 - CI2A.2
 ; 1953 - CI3A.1
 ; 1954 - OI1A.1
 ; 1955 - OI1A.2
 ;
ENT7 ; O.F. entries in file 364.7 to be included
 ;
 ;;^27^28^37^77^98^100^809^1015^1198^1305^1579^1627^1951^1952^1953^1954^1955^
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries deleted:
 ;
DEL5    ; remove O.F. entries in file 364.5 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries deleted:
 ;
 ;    5 - CI2.6
 ;   14 - CI3.7
 ;   15 - CI3.6
 ;  104 - OI1.6
 ;  105 - OI1.7
 ;  107 - OI1.9
 ;  111 - OI1.10
 ;  191 - CI3.4
 ;  814 - COB1.8
 ;  815 - COB1.9
 ;  891 - COB1.10
 ;  961 - COB1.11
 ;  962 - COB1.12
 ;  964 - COB1.13
 ;  987 - CI3.12
 ; 1097 - CI1A.10
 ; 1098 - CI1A.11
 ; 1099 - CI1A.12
 ; 1100 - CI1A.13
 ; 1101 - CI1A.14
 ; 1102 - CI1A.15
 ; 1103 - CI1A.16
 ; 1104 - CI1A.17
 ; 1195 - SUB.13
 ; 1196 - SUB.14
 ; 1214 - SUB2.13
 ; 1215 - SUB2.14
 ; 1216 - SUB2.15
 ; 1217 - SUB2.16
 ; 1232 - OPR2.10
 ; 1233 - OPR2.11
 ; 1242 - OPR3.10
 ; 1243 - OPR3.11
 ; 1252 - OPR4.10
 ; 1253 - OPR4.11
 ; 1260 - OPR5.8
 ; 1261 - OPR5.9
 ; 1262 - OPR5.10
 ; 1263 - OPR5.11
 ; 1285 - OPR8.10
 ; 1286 - OPR8.11
 ; 1296 - OI5.11
 ; 1297 - OI5.12
 ; 1298 - OI5.13
 ; 1299 - OI5.14
 ; 1805 - CI6.6
 ; 1806 - CI6.7
 ; 1807 - CI6.8
 ; 1808 - CI6.9
 ; 2029 - SUB2.17
 ; 2030 - SUB2.18
 ; 2031 - SUB2.18
 ; 2032 - SUB2.20
 ; 2033 - SUB2.21
 ; 2034 - SUB2.22
 ; 2208 - PRV1.12
 ;
DEL6    ; remove O.F. entries in file 364.6 (not re-added)
 ;
 ;;^5^14^15^104^105^107^111^191^814^815^891^961^962^964^987^
 ;;^1097^1098^1099^1100^1101^1102^1103^1104^1195^1196^
 ;;^1214^1215^1216^1217^1232^1233^1242^1243^1252^1253^
 ;;^1260^1261^1262^1263^1285^1286^1296^1297^1298^1299^
 ;;^1805^1806^1807^1808^2029^2030^2031^2032^2033^2034^2208^
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries deleted:
 ;
 ;    3 - CI2.6
 ;   22 - CI3.6
 ;   23 - CI3.7
 ;  122 - OI1.6
 ;  124 - OI1.7
 ;  125 - OI1.9
 ;  130 - 0I1.10
 ;  133 - CI3.4
 ;  378 - CI1A.10
 ;  379 - CI1A.11
 ;  380 - CI1A.12
 ;  381 - CI1A.13
 ;  382 - CI1A.14
 ;  383 - CI1A.15
 ;  384 - CI1A.16
 ;  385 - CI1A.17
 ;  392 - SUB.13
 ;  393 - SUB.14
 ;  410 - SUB2.13
 ;  411 - SUB2.14
 ;  412 - SUB2.15
 ;  413 - SUB2.16
 ;  428 - OPR2.10
 ;  429 - OPR2.11
 ;  438 - OPR3.10
 ;  439 - OPR3.11
 ;  451 - OPR8.10
 ;  452 - OPR8.11
 ;  462 - OI5.11
 ;  463 - OI5.12
 ;  464 - OI5.13
 ;  465 - OI5.14
 ;  650 - OPR5.8
 ;  651 - OPR5.9
 ;  652 - OPR5.10
 ;  653 - OPR5.11
 ;  657 - OPR4.11
 ;  662 - OPR4.10
 ;  844 - COB1.8
 ;  845 - COB1.9
 ;  951 - COB1.10
 ;  955 - COB1.11
 ;  956 - COB1.13
 ;  983 - COB1.12
 ;  990 - CI3.12
 ; 1505 - CI6.6
 ; 1506 - CI6.7
 ; 1507 - CI6.8
 ; 1508 - CI6.9
 ; 1728 - SUB2.17
 ; 1729 - SUB2.18
 ; 1730 - SUB2.19
 ; 1731 - SUB2.20
 ; 1732 - SUB2.21
 ; 1733 - SUB2.22
 ; 1908 - PRV1.12
 ;
DEL7    ; remove O.F. entries in file 364.7 (not re-added)
 ;
 ;;^3^22^23^122^124^125^130^133^378^379^380^381^382^383^
 ;;^384^385^392^393^410^411^412^413^428^429^438^439^451^
 ;;^452^462^463^464^465^650^651^652^653^657^662^844^845^
 ;;^951^955^956^983^990^1505^1506^1507^1508^1728^1729^
 ;;^1730^1731^1732^1733^1908^
 ;
 ;-----------------------------------------------------------------------
 ;
