IBY577PR ;AITC/VD - Pre-Installation for IB patch 577 ;06-APR-2017
 ;;2.0;INTEGRATED BILLING;**577**;21-MAR-94;Build 38
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF
 Q
 ;
INC3508(Y) ; function to determine if entry in IB ERROR file (350.8) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(350.8,Y,0)),U,3)_U
 F LN=2:1 S TAG="ENT3508+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
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
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ;
ENT5 ; OF entries in file 364.5 to be included
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;
 ;   170 - SUB-2
 ;   171 - SUB-3
 ;   956 - OI1A-9
 ;   957 - CI3A-4
 ;   970 - SUB2-13 (was SUB-8)
 ;  1930 - PRV1-7
 ;  1931 - PRV1-8
 ;  1940 - AMB-3
 ;  1941 - AMB-4
 ;  1968 - CI3A-9
 ;  1975 - PT2-6
 ;  2025 - OI4-12
 ;  2371 - SUB-8
 ;
ENT6 ; O.F. entries in file 364.6 to be included
 ;
 ;;^170^171^956^957^970^1930^1931^1940^1941^1968^1975^2025^2371^
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;
 ;  804 - COB1-2
 ;  939 - PRF-23
 ;  941 - PRF-25
 ; 1015 - GEN-7
 ; 1406 - INS-15
 ; 1537 - OI6-7
 ; 1538 - OI6-8
 ; 1551 - OI6-10.1
 ; 1927 - COB1-7
 ; 1949 - INS-16
 ; 1950 - INS-17
 ; 1955 - OI1A-2
 ; 1956 - SUB-8
 ; 
ENT7 ; O.F. entries in file 364.7 to be included
 ;
 ;;^804^939^941^1015^1406^1537^1538^1551^1927^1949^1950^1955^1956^
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
 ; 1850 - OI6-6.9
 ;
DEL6    ; remove O.F. entries in file 364.6 (not re-added)
 ;
 ;;^1850^
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries deleted:
 ;
 ; 1550 - OI6-6.9
 ;
DEL7    ; remove O.F. entries in file 364.7 (not re-added)
 ;
 ;;^1550^
 ;
 ;-----------------------------------------------------------------------
ENT3508 ; Add New IB Error Codes to File 350.8
 ;
 ;;^IB365^
 ;
 Q
 ;
