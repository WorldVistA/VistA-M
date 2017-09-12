IBY447PR ;ALB/WCJ - Pre-Installation for IB patch 447 ;19-APR-2011
 ;;2.0;INTEGRATED BILLING;**447**;19-APR-11;Build 80
 ;
 D DELOF       ; delete all output formatter data elements included in build
 D NMCHG
 Q
 ;
NMCHG   ; change name and abbreviation of some 355.1 entries prior to install
 N DATA,IEN,FLAGS,FDA,ERR,LN
 F LN=3:1:5 D
 .S DATA=$P($T(NMC3551+LN),";;",2) Q:DATA=""
 .S IEN=$O(^IBE(355.1,"B",$P(DATA,U,2),"")) Q:IEN=""
 .S FDA(355.1,IEN_",",.01)=$P(DATA,U,3),FDA(355.1,IEN_",",.02)=$P(DATA,U,4)
 .D FILE^DIE(,"FDA")
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
DELOF   ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning entries in file 364.6.
 S DIK="^IBA(364.6,"
 F LN=2:1 S TAG="DEL6"_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364.6",DA,0)) D ^DIK
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are non-functioning entries in file 364.7.
 S DIK="^IBA(364.7,"
 F LN=2:1 S TAG="DEL7"_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364.7",DA,0)) D ^DIK
 ;
DELOFX  ;
 Q
 ;
INC3551(Y) ; function to determine if entry in TYPE OF PLAN file (355.1) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(355.1,Y,0)),U)_U
 F LN=2:1 S TAG="ENT3551+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
INC3508(Y) ; function to determine if entry in IB ERROR file (350.8) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(350.8,Y,0)),U,3)_U
 F LN=2:1 S TAG="ENT3508+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ; 79 Modified, SDD Section 3.2.3.1, BEN
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^79^
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;  107 - OI1-9
 ;  111 - OI1-10
 ;  891 - COB1-10
 ;  962 - COB1-12
 ; 1045 - SUB2-1.5
 ; 1487 - CMS-1500 BX-24F CHARGES
 ; 1938 - AMB-2
 ; 1939 - AMB1-1
 ; 1940 - AMB-3
 ; 1941 - AMB-4
 ; 1942 - AMB-5
 ; 1943 - AMB-6
 ; 1944 - AMB-7
 ; 1945 - AMB1-2
 ; 1946 - AMB1-3
 ; 1947 - AMB1-4
 ; 1948 - AMB1-5
 ; 1949 - AMB1-6
 ; 1950 - AMB1-7
 ; 1951 - AMB-8
 ; 2209 - AMB-1.9
 ; 2210 - AMB-99.9
 ; 2211 - AMB1-1.9
 ; 2212 - AMB1-8
 ; 2213 - AMB1-99.9
 ; 2214 - AMB2-1
 ; 2215 - AMB2-1.9
 ; 2216 - AMB2-2
 ; 2217 - AMB2-3
 ; 2218 - AMB2-4
 ; 2219 - AMB2-5
 ; 2220 - AMB2-6
 ; 2221 - AMB2-7
 ; 2222 - AMB2-8
 ; 2223 - AMB2-99.9
 ; 2224 - COB1-7
 ; 2225 - OI1A-1
 ; 2226 - OI1A-2
 ; 2227 - OI1A-3
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^107^111^891^962^1045^1487^
 ;;^1938^1939^1940^1941^1942^1943^1944^1945^1946^1947^1948^1949^1950^1951^
 ;;^2209^2210^2211^2212^2213^2214^2215^2216^2217^2218^2219^2220^2221^2222^
 ;;^2223^2224^2225^2226^2227^
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;   37 Modified, SDD Sections 3.2.1.5 & 3.2.1.6, BEN
 ;  103 - CL1-23
 ;  130 - OI1-10
 ;  205 - SUB2-2
 ;  206 - SUB2-3
 ;  209 - SUB2-1.5
 ; 1015 - GEN-7
 ; 1403 Modified, SDD Sections 3.2.1.5 & 3.2.1.6, BEN
 ; 1638 - AMB-2
 ; 1639 - AMB1-1
 ; 1640 - AMB-3
 ; 1641 - AMB-4
 ; 1642 - AMB-5
 ; 1643 - AMB-6
 ; 1644 - AMB-7
 ; 1645 - AMB1-2
 ; 1646 - AMB1-3
 ; 1647 - AMB1-4
 ; 1648 - AMB1-5
 ; 1649 - AMB1-6
 ; 1650 - AMB1-7
 ; 1651 - AMB-8
 ; 1909 - AMB-1.9
 ; 1910 - AMB-99.9
 ; 1911 - AMB1-1.9
 ; 1912 - AMB1-8
 ; 1913 - AMB1-99.9
 ; 1914 - AMB2-1
 ; 1915 - AMB2-1.9
 ; 1916 - AMB2-2
 ; 1917 - AMB2-3
 ; 1918 - AMB2-4
 ; 1919 - AMB2-5
 ; 1920 - AMB2-6
 ; 1921 - AMB2-7
 ; 1922 - AMB2-8
 ; 1923 - AMB2-99.9
 ; 1924 - COB1-7
 ; 1925 - OI1A-1
 ; 1926 - OI1A-2
 ; 1927 - OIAA-3
 ; 
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^37^103^130^205^206^209^1015^1403^
 ;;^1638^1639^1640^1641^1642^1643^1644^1645^1646^1647^1648^1649^1650^1651^
 ;;^1909^1910^1911^1912^1913^1914^1915^1916^1917^1918^1919^1920^1921^1922^
 ;;^1923^1924^1925^1926^1927^
 ;;
 ;
 ;-----------------------------------------------------------------------
DEL6    ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;^813^
 ;;
 ;
 ;-----------------------------------------------------------------------
DEL7    ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;^843^
 ;;
 ;
 Q
 ;
ENT3508 ; entries in file 350.8 to be included
 ;
 ;;^IB344^IB345^IB346^IB347^IB348^IB349^
 ;;
 ;
 Q
 ;
NMC3551 ; entries in file 355.1 to change name prior to install
 ; ^OLD NAME^NEW NAME^NEW ABBREVIATION
 ; 
 ;;^MEDIGAP (SUPPLEMENTAL)^MEDIGAP PLAN C^MGC
 ;;^MEDIGAP (SUPPL - COINS, DED, PART B EXC)^MEDIGAP PLAN F^MGF
 ;;^MEDICARE SECONDARY^MEDICARE SECONDARY (NO B EXC)^MS
 ;;
 ;
 Q
 ;
ENT3551 ; entries in file 355.1 to be included
 ;
 ;;^MEDIGAP PLAN F^MEDIGAP PLAN A^MEDIGAP PLAN B^MEDIGAP PLAN D^MEDIGAP PLAN G^MEDIGAP PLAN K^
 ;;^MEDIGAP PLAN L^MEDIGAP PLAN M^MEDIGAP PLAN N^MEDICARE SECONDARY (B EXC)^MEDIGAP PLAN C^
 ;;^MEDICARE SUPPLEMENTAL^CARVE-OUT^MEDICARE SECONDARY (NO B EXC)^COMPREHENSIVE MAJOR MEDICAL^
 ;;^PREFERRED PROVIDER ORGANIZATION (PPO)^RETIREE^MENTAL HEALTH^MEDICAL EXPENSE (OPT/PROF)^
 ;;^POINT OF SERVICE^SURGICAL EXPENSE INSURANCE^
 ;
 Q
