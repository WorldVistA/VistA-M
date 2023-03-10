IBY718PR ;EDE/JRA - Pre-Installation for IB patch 718 ; 10/12/17 2:12 pm
 ;;2.0;INTEGRATED BILLING;**718**;21-MAR-94;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x or FILE=8 indicating file 350.8 (IB ERROR)
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
 F FILE=5:1:8 S DIK=$S(FILE=8:"^IBE(350.",1:"^IBA(364.")_FILE_"," D
 . F TAG="ENT"_FILE,"DEL"_FILE D
 .. F LN=2:1 S TAGLN=TAG_"+"_LN,DATA=$P($T(@TAGLN),";;",2) Q:DATA=""  D
 ... F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  D
 .... I FILE=8,$D(^IBE(350.8,DA,0)) D ^DIK
 .... Q:FILE=8
 .... I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 Q
 ;
 ; Example for ENT5, ENT6, ENT7, ENT8, DEL5, DEL6, and DEL7:
 ;;^195^254^259^269^324^325^
 ; Note:  Must have beginning and ending up-carat
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 O.F. entries added:
 ;
 ;  225  N-COB CLAIM LEVEL AMOUNTS 'COB1-1.9' (US2486)
 ;  226  N-MEDICARE INPT CLAIM COB AMTS 'MIA1-1.9' (US2486)
 ;  227  N-MEDICARE OUTPT CLAIM COB AMT 'MOA1-1.9' (US2486)
 ;  228  N-COB CLAIM LEVEL ADJUSTMENTS 'CCAS-1.9' (US2486)
 ;  396  N-CMN RECORD ID 'LQ  '
 ;  438  N-CMN RECORD ID 'FRM '
 ;  440  N-CMN RECORD ID 'CMN '
 ;  442  N-CMN RECORD ID 'MEA '
 ;  
ENT5 ;O.F. entries in file 364.5 to be added
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 O.F. entries added:
 ;
 ;
ENT6 ;O.F. entries in file 364.6 to be added
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 O.F. entries added:
 ;
 ;
ENT7 ; O.F. entries in file 364.7 to be added
 ;
 ;;^107^1015^
 ;
 ;107   N-GET FROM PREVIOUS EXTRACT (IB 837 TRANSMISSION)
 ;1015  GEN-7
 ;-----------------------------------------------------------------------
 ; 350.8 O.F. entries added:
 ;
 ;
ENT8 ;O.F. entries in file 350.8 to be added
 ;
 ;;^436^
 ;
 ;436 IB916 VC AMT CANNOT EQUAL ZERO
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
DEL6    ; remove O.F. entries in file 364.6 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries deleted:
 ;
 ;
DEL7    ; remove O.F. entries in file 364.7 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 350.8 Entries deleted:
 ;
 ;
DEL8    ; remove entries from 350.8 (IB ERROR)
 ;
 ;;
 ;
